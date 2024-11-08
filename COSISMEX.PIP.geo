# Original ACT space craft - modified for COSI

# Brett's version of the bus geometry. Stream lined as we put back componnets w/ gradually increasing complexity 


# Start modeling the Payload Interface Plate 

Volume PIPbody
PIPbody.Material vacuum
PIPbody.Visibility 0
#PIPbody.Shape PGON 0.0 360.0 6  2    -100 0.0 {SCRadius+5}   100.0 0.0 {SCRadius+5}  
PIPbody.Shape PGON 0.0 360.0 6  2  {-((PIP_depth/2)+PIP_aluminum_thickness+bipod_outer_height)} 0.0 {SCRadius+5}  {PIP_depth/2+PIP_aluminum_thickness} 0.0 {SCRadius+5}

#####################################
# Bottom Half: Modled as two nested trapezoids w/ varying thicknesses, densities 

#Try modeling exterior as thin aluminum sheet 
# Create outer aluminum layer 
Shape TRD1 PIP_bottom_outer_volume
PIP_bottom_outer_volume.Parameters {(PIP_TRD1_length_1/2)+PIP_aluminum_thickness} {(PIP_TRD1_length_2/2)+PIP_aluminum_thickness} {(PIP_depth/2)+PIP_aluminum_thickness} {(PIP_TRD1_height/2)+PIP_aluminum_thickness}

# Create inner aluminum layer
Shape TRD1 PIP_bottom_inner_volume
PIP_bottom_inner_volume.Parameters {(PIP_TRD1_length_1/2)} {(PIP_TRD1_length_2/2)} {(PIP_depth/2)} {(PIP_TRD1_height/2)}

# Take the difference to create volume w/ thickness of PIP aluminum sheet 
Shape Subtraction PIP_bottom_aluminum_shell 
PIP_bottom_aluminum_shell.Parameters PIP_bottom_outer_volume PIP_bottom_inner_volume

Volume PIP_bottom_shell
PIP_bottom_shell.Color 5
PIP_bottom_shell.Material al6061
PIP_bottom_shell.Shape PIP_bottom_aluminum_shell
PIP_bottom_shell.Mother PIPbody
PIP_bottom_shell.Position 0 {-1*(PIP_TRD1_height/2)-PIP_aluminum_thickness}  0
PIP_bottom_shell.Rotation 90 0 0

## Now, create the inner  "honeycomb" region 

# Note: "0.0001" bias here is just to prevent clipping in ROOT GL viewer 
Volume PIP_bottom_interior
PIP_bottom_interior.Color 1
PIP_bottom_interior.Material al6061_honeycomb
PIP_bottom_interior.Shape TRD1 {PIP_TRD1_length_1/2-0.001} {PIP_TRD1_length_2/2-0.001}  {PIP_depth/2-0.001} {PIP_TRD1_height/2-0.001}
PIP_bottom_interior.Mother PIPbody
PIP_bottom_interior.Position 0 {-1*(PIP_TRD1_height/2)-PIP_aluminum_thickness} 0 
PIP_bottom_interior.Rotation 90 0 0 



#####################################
# Top  Half: Modled as two nested trapezoids w/ varying thicknesses, densities. Carve out hole in middle of resulting shape 

#Try modeling exterior as thin aluminum sheet 
# Create outer aluminum layer 
Shape TRD1 PIP_top_outer_volume
PIP_top_outer_volume.Parameters {(PIP_TRD2_length_1/2)+PIP_aluminum_thickness} {(PIP_TRD2_length_2/2)+PIP_aluminum_thickness} {(PIP_depth/2)+PIP_aluminum_thickness} {(PIP_TRD2_height/2)+PIP_aluminum_thickness}

# Create inner aluminum layer
Shape TRD1 PIP_top_inner_volume
PIP_top_inner_volume.Parameters {(PIP_TRD2_length_1/2)} {(PIP_TRD2_length_2/2)} {(PIP_depth/2)} {(PIP_TRD2_height/2)}

# Take the difference to get thick shell 
Shape Subtraction PIP_top_shell_solid
PIP_top_shell_solid.Parameters PIP_top_outer_volume PIP_top_inner_volume



# Create the hole negative  
Shape BRIK PIP_top_central_gap 
PIP_top_central_gap.Parameters {PIP_TRD2_gap_length/2} {PIP_TRD2_gap_height/2+PIP_aluminum_thickness} {PIP_depth/2}
Orientation PIP_top_central_gap_ori
PIP_top_central_gap_ori.Position 0.0 0.0 {(PIP_TRD2_gap_height/2+PIP_aluminum_thickness)-(PIP_TRD2_height/2+PIP_aluminum_thickness)}


# Take difference of the solid shell volume and the hole negative 
Shape Subtraction PIP_top_shell_with_hole 
PIP_top_shell_with_hole.Parameters PIP_top_shell_solid PIP_top_central_gap PIP_top_central_gap_ori



Volume PIP_top_shell
PIP_top_shell.Color 1
PIP_top_shell.Material al6061
PIP_top_shell.Shape PIP_top_shell_with_hole
PIP_top_shell.Mother PIPbody
PIP_top_shell.Position 0 {1*(PIP_TRD2_height/2+PIP_aluminum_thickness)} 0
PIP_top_shell.Rotation 90 0 180 

## Now, create the inner  "honeycomb" region 
# Note: "0.0001" bias here is just to prevent clipping in ROOT GL viewer 
Shape TRD1 PIP_top_inner_volume_honeycomb
PIP_top_inner_volume_honeycomb.Parameters {PIP_TRD2_length_1/2-0.001} {PIP_TRD2_length_2/2-0.001}  {PIP_depth/2-0.001} {PIP_TRD2_height/2-0.001}

# Cut out the same gap in the inner layer 
Shape Subtraction PIP_top_interior_with_hole 
PIP_top_interior_with_hole.Parameters PIP_top_inner_volume_honeycomb PIP_top_central_gap PIP_top_central_gap_ori

Volume PIP_top_interior
PIP_top_interior.Color 1
PIP_top_interior.Material al6061_honeycomb
PIP_top_interior.Shape PIP_top_interior_with_hole
PIP_top_interior.Mother PIPbody
PIP_top_interior.Position 0 {1*(PIP_TRD2_height/2+PIP_aluminum_thickness)} 0
PIP_top_interior.Rotation 90 0 180 



# Mass check:
#   - From MEL: 9.69kg
#   - Mass of bottom half: 
       # M = M_shell + M_interior 

        # M =[ rho_solid_al * V_outer] + [rho_honeycomb_al * V_inner] 
            # Assume outer shell is 0.1 cm thick; 0.2 cm added to each dimmension in outer shell 
            # Mass of aluminum shell: 2.5 g/cm^3 * [(1/2)(105.7+0.2+58.3+0.2)(4.72+0.2)(41.656+0.2)] - [(1/2)(105.7+58.3)(4.72)(41.656)]
       #         = 2.5g/cm^3 * [16,927.57 cm^3 - 16,122.53824 cm^3] 
       #         = 2.5g/cm^3 * 805.03 g 
       #            = 2012.58 g = ~2kg

           # Mass of aluminum interior: 0.12 g/cm^3* [(1/2)(105.7+58.3)(4.72)(41.656)]
           #   = 0.12g/cm^3 * 16,122.583824
           #   = 1,934 g  = ~1.9kg 

       # So total mass of bottom half of PIP is ~ 4kg

# - Mass of top half:
        # M =[ rho_solid_al * V_outer] + [rho_honeycomb_al * V_inner] 
            # Assume outer shell is 0.1 cm thick; 0.2 cm added to each dimmension in outer shell 
            # Mass of aluminum shell: 2.5 g/cm^3 * [(1/2)(105.7+0.2+47.39+0.2)(4.72+0.2)(49.8856+0.2)] - [(1/2)(105.7+47.39)(4.72)(49.8856)]
       #         = 2.5g/cm^3 * [18,911.59 cm^3 - 18,023.288 cm^3] 
       #         = 2.5g/cm^3 * 888.03 g 
       #            = 2220.757 g = ~ 2.2kg 

           # Mass of aluminum interior: 0.12 g/cm^3* [(1/2)(105.7+47.39)(4.72)(49.8856)]
           #   = 0.12g/cm^3 * 18,023.288
           #   = 1,934 g  = 2.162kg  

        # So total mass of top half of Pip in this model is ~ 4.3kg 

# Total mass would htne be: 4.3+ 4 = 8.3 kg. Upping thickness from 0.1 to 0.225 brings us closer



## Start modeling the DPM 
#
#Shape BRIK DPM_outer 
#DPM_outer.Parameters {DPM_length/2} {DPM_width/2} {DPM_height/2}
#Orientation DPM_outer_ori 
#DPM_outer_ori.Position 0.0 0.0 0
#DPM_outer_ori.Rotation 0.0 0.0 0.0
#
#Shape BRIK DPM_inner
#DPM_inner.Parameters {(DPM_length/2)-(DPM_wall_thickness)} {(DPM_width/2)-DPM_wall_thickness} {(DPM_height/2)-(DPM_wall_thickness)}
#Orientation DPM_inner_ori 
#DPM_inner_ori.Position 0.0 0.0 0
#DPM_inner_ori.Rotation 0.0 0.0 0.0
#
#Shape BRIK DPM_bracket
#DPM_bracket.Parameters {(DPM_bracket_length/2)} {(DPM_bracket_width/2)} {(DPM_bracket_height/2)}
#Orientation DPM_bracket_ori
#DPM_bracket_ori.Position 0.0 0.0 {-1*(DPM_bracket_height/2)-(DPM_height/2)}
#DPM_bracket_ori.Rotation 0.0 0.0 0.0 
#
#
## Subtract the outer and inner DPM volumes to get organic shape "DPM_hollow" 
#Shape Subtraction DPM_hollow
#DPM_hollow.Parameters DPM_outer DPM_inner DPM_inner_ori
#
## Add the mounting plate 
#Shape Union DPM_hollow_bracket 
#DPM_hollow_bracket.Parameters DPM_hollow DPM_bracket DPM_bracket_ori
#
## Mass check of DPM:
## From MEL: Housing mass of 0.19kg = 190 g
##  Volume of aluminum housing in this model: 
##     V_outer= [11.86+(2*0.15875)]*[13.45+(2*0.15875)]*[13.625+(2*0.15875)]
##               = 2,337.57 cm^3
##     V_inner = [11.86]*[13.45]*[13.625]
##               =2,173.41
##     V_total = V_outer-V_inner 
##             = 164.16 cm^3
##   Resulting mass for an aluminum alloy housing (rho = 2.6989):
##     M = 2.6989 g/cm^3 * 161.16 cm^3 = 434.95 g  [TOO HIGH]
#
## Tweak aluminum shell thickness until desired mas is reached: 
##    Setting thickness to 0.05cm gives mass of 136.72 g.
#
## Add in the bracket. Set thickness so that total masses add to 190g (about 0.11cm)
## M_bracket = [14.69cm*11.946cm*0.11cm] * 2.6969 g/cm^3 = 52.1g
#
## Resulting DPM housing mass: 136.72g+52.1g = 188.82g
## Place the organic shape inside the mother volume 
# 
############## Bottom Pannel ####################
#Volume DPM_1
#DPM_1.Color 4
#DPM_1.Material al6061
#DPM_1.Shape DPM_hollow_bracket
#DPM_1.Mother PIPbody
#DPM_1.Position 25 -30 {((PIP_depth/2)+PIP_aluminum_thickness+(DPM_height/2)+(DPM_bracket_height/2))+0.056}
#DPM_1.Rotation 0 0 {45+90}
#
#Volume DPM_1_card
#DPM_1_card.Color 3
#DPM_1_card.Material Elect
#DPM_1_card.Shape BRIK {DPM_board_length/2-0.2} {DPM_board_width/2} {DPM_board_depth/2}
#DPM_1_card.Mother PIPbody
#DPM_1_card.Position 25 -30 {((PIP_depth/2)+PIP_aluminum_thickness+(DPM_height/2)+(DPM_bracket_height/2))} 
#DPM_1_card.Rotation 0 0 {135+90}
#
#
#Volume DPM_2
#DPM_2.Color 4
#DPM_2.Material al6061
#DPM_2.Shape DPM_hollow_bracket
#DPM_2.Mother PIPbody
#DPM_2.Position -25 -30 {((PIP_depth/2)+PIP_aluminum_thickness+(DPM_height/2)+(DPM_bracket_height/2))+0.056} 
#DPM_2.Rotation 0 0 {135+90}
#
#Volume DPM_2_card
#DPM_2_card.Color 3
#DPM_2_card.Material Elect
#DPM_2_card.Shape BRIK {DPM_board_length/2-0.2} {DPM_board_width/2} {DPM_board_depth/2}
#DPM_2_card.Mother PIPbody
#DPM_2_card.Position -25 -30 {((PIP_depth/2)+PIP_aluminum_thickness+(DPM_height/2)+(DPM_bracket_height/2))} 
#DPM_2_card.Rotation 0 0 {45+90}
#
#
### Readout Module 
## Creater outer boundary of aluminum housing  
#Shape BRIK readout_housing_outer
#readout_housing_outer.Parameters {(Readout_length/2)+Readout_thickness} {(Readout_width/2)+Readout_thickness} {(Readout_height/2)+Readout_thickness}
#
## Create inner boundary of aluminum housing
#Shape BRIK readout_housing_inner
#readout_housing_inner.Parameters {(Readout_length/2)} {(Readout_width/2)} {(Readout_height/2)}
#
## Take the difference to get shell 
#Shape Subtraction readout_housing_shell 
#readout_housing_shell.Parameters readout_housing_outer readout_housing_inner
#
## Place resulting shape in the volume 
#Volume Readout_module
#Readout_module.Color 2
#Readout_module.Material al6061
#Readout_module.Shape readout_housing_shell
#Readout_module.Mother PIPbody
#Readout_module.Position -40 0 {(PIP_depth/2)+PIP_aluminum_thickness+(Readout_height/2+0.09)}
#Readout_module.Rotation 0 0  90
#
#Volume Readout_module_electronics
#Readout_module_electronics.Color 3
#Readout_module_electronics.Material electr
#Readout_module_electronics.Shape BRIK {Readout_length/2} {Readout_electronics_depth/2} {Readout_width/2}
#Readout_module_electronics.Mother PIPbody
#Readout_module_electronics.Position 40 -0 {(PIP_depth/2)+PIP_aluminum_thickness+(Readout_height/2)}
#Readout_module_electronics.Rotation 90 0 90
#
#
## New: Replace star tracker with readout module clone 
## Place resulting shape in the volume 
#Volume Shield_module
#Shield_module.Color 6
#Shield_module.Material al6061
#Shield_module.Shape readout_housing_shell
#Shield_module.Mother PIPbody
#Shield_module.Position 40 0 {(PIP_depth/2)+PIP_aluminum_thickness+(Readout_height/2+0.09)}
#Shield_module.Rotation 0 0  90
#
#Volume Shield_module_electronics
#Shield_module_electronics.Color 3
#Shield_module_electronics.Material electr
#Shield_module_electronics.Shape BRIK {Readout_length/2} {Readout_electronics_depth/2} {Readout_width/2}
#Shield_module_electronics.Mother PIPbody
#Shield_module_electronics.Position -40 -0 {(PIP_depth/2)+PIP_aluminum_thickness+(Readout_height/2)}
#Shield_module_electronics.Rotation 90 0 90
#
#
############### Top Panel #####################
#
#Volume DPM_3
#DPM_3.Color 4
#DPM_3.Material al6061
#DPM_3.Shape DPM_hollow_bracket
#DPM_3.Mother PIPbody
#DPM_3.Position 25 30 {((PIP_depth/2)+PIP_aluminum_thickness+(DPM_height/2)+(DPM_bracket_height/2))+0.056}
#DPM_3.Rotation 0 0 {135+90}
#
#Volume DPM_3_card
#DPM_3_card.Color 3
#DPM_3_card.Material Elect
#DPM_3_card.Shape BRIK {DPM_board_length/2-0.2} {DPM_board_width/2} {DPM_board_depth/2}
#DPM_3_card.Mother PIPbody
#DPM_3_card.Position 25 30 {((PIP_depth/2)+PIP_aluminum_thickness+(DPM_height/2)+(DPM_bracket_height/2))} 
#DPM_3_card.Rotation 0 0 {45+90}
#
#
#
#Volume DPM_4
#DPM_4.Color 4
#DPM_4.Material al6061
#DPM_4.Shape DPM_hollow_bracket
#DPM_4.Mother PIPbody
#DPM_4.Position -25 25 {((PIP_depth/2)+PIP_aluminum_thickness+(DPM_height/2)+(DPM_bracket_height/2))+0.056}
#DPM_4.Rotation 0 0 {45+90}
#
#Volume DPM_4_card
#DPM_4_card.Color 3
#DPM_4_card.Material Elect
#DPM_4_card.Shape BRIK {DPM_board_length/2-0.2} {DPM_board_width/2} {DPM_board_depth/2}
#DPM_4_card.Mother PIPbody
#DPM_4_card.Position -25 25 {((PIP_depth/2)+PIP_aluminum_thickness+(DPM_height/2)+(DPM_bracket_height/2))} 
#DPM_4_card.Rotation 0 0 {135+90}
#
#

# Try modeling the bipod 
Shape TRD1 bipod_outer 
bipod_outer.Parameters {bipod_outer_separation_bottom/2} {bipod_outer_separation_top/2} {bipod_depth/2} {bipod_outer_height/2}

Shape TRD1 bipod_inner 
bipod_inner.Parameters {bipod_inner_separation_bottom/2} {bipod_inner_separation_top/2} {bipod_depth/2+0.01} {bipod_inner_height/2}
Orientation bipod_inner_ori 
bipod_inner_ori.Position 0 0 -5
# Take the difference 
Shape Subtraction bipod_shell 
bipod_shell.Parameters bipod_outer bipod_inner bipod_inner_ori 

Volume bipod_1
bipod_1.Color 7
bipod_1.Material CarbonCyanateEster
bipod_1.Shape bipod_shell
bipod_1.Mother PIPbody
#bipod_1.Position 0 -40 {(-PIP_depth/2)-(bipod_outer_height/2)-(PIP_aluminum_thickness)}
bipod_1.Position 0 48 {(-PIP_depth/2)-(bipod_outer_height/2)-(PIP_aluminum_thickness)}
bipod_1.Rotation 0 0 0

Volume bipod_2
bipod_2.Color 7
bipod_2.Material CarbonCyanateEster
bipod_2.Shape bipod_shell
bipod_2.Mother PIPbody
#bipod_2.Position -38 24 {(-PIP_depth/2)-(bipod_outer_height/2)-(PIP_aluminum_thickness)}
bipod_2.Position 38 -21 {(-PIP_depth/2)-(bipod_outer_height/2)-(PIP_aluminum_thickness)}
bipod_2.Rotation 0 0 60

Volume bipod_3
bipod_3.Color 7
bipod_3.Material CarbonCyanateEster
bipod_3.Shape bipod_shell
bipod_3.Mother PIPbody
bipod_3.Position -38 -21  {(-PIP_depth/2)-(bipod_outer_height/2)-(PIP_aluminum_thickness)}
#bipod_3.Position 38 24  {(-PIP_depth/2)-(bipod_outer_height/2)-(PIP_aluminum_thickness)}
bipod_3.Rotation 0 0 120

########### Radiators ########
Shape BRIK radiator_solid 
radiator_solid.Parameters {radiator_length/2} {radiator_width/2} {radiator_thickness/2}

Shape BRIK radiator_gap 
radiator_gap.Parameters {radiator_gap_length/2} {radiator_gap_width/2} {radiator_thickness/2+0.1}
Orientation radiator_gap_ori
radiator_gap_ori.Position 0 {-radiator_width/2+(radiator_gap_width/2)} 0
radiator_gap_ori.Rotation 0 0 90

# Take the difference 
Shape Subtraction radiator_with_gap 
radiator_with_gap.Parameters radiator_solid radiator_gap radiator_gap_ori 

Volume radiator_1 
radiator_1.Color 1
radiator_1.Material CarbonCyanateEster
radiator_1.Shape radiator_with_gap
radiator_1.Mother PIPbody
radiator_1.Position 38 22  {(-PIP_depth/2)-(bipod_outer_height/2)-(PIP_aluminum_thickness)}
radiator_1.Rotation 90 0 120

Volume radiator_2 
radiator_2.Color 1
radiator_2.Material CarbonCyanateEster
radiator_2.Shape radiator_with_gap
radiator_2.Mother PIPbody
radiator_2.Position -38 22  {(-PIP_depth/2)-(bipod_outer_height/2)-(PIP_aluminum_thickness)}
radiator_2.Rotation 90 0 60


Volume radiator_3
radiator_3.Color 1
radiator_3.Material CarbonCyanateEster
radiator_3.Shape radiator_with_gap
radiator_3.Mother PIPbody
radiator_3.Position 0 {-PIP_TRD1_height+radiator_thickness/2+2}  {(-PIP_depth/2)-(bipod_outer_height/2)-(PIP_aluminum_thickness)}
radiator_3.Rotation 90 0 0




#Adding the HVPS and the CCE Raditor 
Shape Brik HvpsShell
HvpsShell.Parameters {23.17/2} {14.12/2} {7.53/2}
Shape Brik HvpsCavity
HvpsCavity.Parameters {21/2} {13/2} {7/2}
Orientation HvpsCavityOri
HvpsCavityOri.Position 0.0 0.0 0.0

Shape SUBTRACTION HvpsHousing
HvpsHousing.Parameters HvpsShell HvpsCavity HvpsCavityOri

Volume HVPS
HVPS.Color 8
HVPS.Material al6061
HVPS.Shape HvpsHousing
#HVPS.Mother PIPbody

HVPS.Copy HVPS1
HVPS1.Mother PIPbody
HVPS1.Position 22 19 {(-PIP_depth/2)-(7.53/2)-(PIP_aluminum_thickness)}

HVPS.Copy HVPS2
HVPS2.Mother PIPbody
HVPS2.Position -10 {-PIP_TRD1_height+radiator_thickness/2+14.12/2+6} {(-PIP_depth/2)-(7.53/2)-(PIP_aluminum_thickness)}

#Adding electronics to the HVPS
Volume HVPSElect
HVPSElect.Shape Brik {20/2} {12/2} {.425/2}
HVPSElect.Material electr
HVPSElect.Color 3

HVPSElect.Copy HVPSElect1
HVPSElect1.Mother PIPbody
HVPSElect1.Position 22 19 {(-PIP_depth/2)-(7.53/2)-(PIP_aluminum_thickness)}

HVPSElect.Copy HVPSElect2
HVPSElect2.Mother PIPbody
HVPSElect2.Position -10 {-PIP_TRD1_height+radiator_thickness/2+14.12/2+6} {(-PIP_depth/2)-(7.53/2)-(PIP_aluminum_thickness)}

#CCE
#Accordind to the CAD this should be 4.37 kg but there are no materials included
#I'm going to assume the radiator material is the same as above, that the housing is Al6061 and that there are 2.29 kg of electronics boards which is according to the MEL
#electronics boards: 2.29 kg
#housing: (housing + heaters) .55 kg al6061
# Radiator: 1 kg
# not accounting for harnessing which is apparently 1.25 kg according to the MEL

Volume IcpRadiator
IcpRadiator.Shape BRIK {31.71/2} {.8/2} {34.04/2}
IcpRadiator.Material CarbonCyanateEster
IcpRadiator.Color 9

IcpRadiator.Copy IcpRadiator1
IcpRadiator1.Mother PIPbody
IcpRadiator.Rotation 0.0 0.0 120.0
IcpRadiator1.Position -36.5 -18 {(-PIP_depth/2)-(34.04/2)-(PIP_aluminum_thickness)}

#ICP Housing
Shape Brik IcpShell
IcpShell.Parameters  {23.88/2} {7.42/2} {15.94/2}
Shape Brik IcpCavity
IcpCavity.Parameters {23.7/2} {7.42/2} {15.77/2}
Orientation IcpCavityOri
IcpCavityOri.Position 0.0 0.0 0.0

Shape SUBTRACTION IcpHousing
IcpHousing.Parameters IcpShell IcpCavity IcpCavityOri

Volume IcpBox
IcpBox.Color 2
IcpBox.Material al6061
IcpBox.Shape IcpHousing

IcpBox.Copy Icp1
Icp1.Mother PIPbody
Icp1.Rotation 0.0 0.0 120.0
Icp1.Position {-33+radiator_thickness/2} {-24+7.42/2+radiator_thickness/2+4.8} {(-PIP_depth/2)-(15.94/2)-(PIP_aluminum_thickness)}

#There is another box in the CAD that I'm not sure what it is, for now I'm going to duplicate the ICP and use it as a dummy mass
#Underneath the omni antenna
IcpBox.Copy Icp2
Icp2.Mother PIPbody
Icp2.Rotation 0.0 90.0 0.0
Icp2.Position 0 {PIP_TRD2_height-7.42/2-10} {(-PIP_depth/2)-(23.88/2)-(PIP_aluminum_thickness)}

#Add electronics to the ICP housing
Volume IcpElect
IcpElect.Shape Brik {23.5/2} {.645/2} {15.5/2}
IcpElect.Material electr
IcpElect.Color 3

IcpElect.Copy IcpElect1
IcpElect1.Mother PIPbody
IcpElect1.Position {-33+radiator_thickness/2} {-24+7.42/2+radiator_thickness/2+4.8} {(-PIP_depth/2)-(15.94/2)-(PIP_aluminum_thickness)}
IcpElect1.Rotation 0.0 0.0 120.0

IcpElect.Copy IcpElect2
IcpElect2.Mother PIPbody
IcpElect2.Position 0 {PIP_TRD2_height-7.42/2-10} {(-PIP_depth/2)-(23.88/2)-(PIP_aluminum_thickness)}
IcpElect2.Rotation 0.0 90.0 0.0


# COSI crycooler and dog house:

Include COSISMEX.Cryocooler.geo

#Cryocooler.Position 13.0 6.0 { SCHeight - SCTopEffectiveThickness - 4.55 }
Cryocooler.Position -13.0 {PIP_TRD2_height/2-23.7} {(-PIP_depth/2)-(PIP_aluminum_thickness)-5}
Cryocooler.Rotation 90 90 90
Cryocooler.Mother PIPbody

