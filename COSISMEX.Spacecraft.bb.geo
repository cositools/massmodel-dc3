# Original ACT space craft - modified for COSI

# Brett's version of the bus geometry. Stream lined as we put back componnets w/ gradually increasing complexity 


Volume SCbody
SCbody.Material SC_Vacuum
SCbody.Visibility 0
#SCbody.Shape PGON 0.0 360.0 6  2    0.0 0.0 SCRadius   50.0 0.0 SCRadius  
SCbody.Shape PGON 0.0 360.0 6  2    {-SCHeight/2} 0.0 {SCRadius+SCSideEffectiveThickness}   {SCHeight} 0.0 {SCRadius+SCSideEffectiveThickness}

# Create outer spacecraft volume 
Shape PGON SC_walls_outer 
# Args for pgon: starting phi limit, ending phi limit, # sides of cross section, # sections (>=2), full-height, inner radius, outer radius 
SC_walls_outer.Parameters 0.0  360.0  6  2 0 0 {SCRadius+SCSideEffectiveThickness} SCHeight 0 {SCRadius+SCSideEffectiveThickness}

# Create inner spacecraft volume 
Shape PGON SC_walls_inner 
# Args for pgon: starting phi limit, ending phi limit, # sides of cross section, # sections (>=2), full-height, inner radius, outer radius 
SC_walls_inner.Parameters 0.0  360.0  6  2 0 0 {SCRadius} SCHeight 0 {SCRadius}

# Take the difference to get the solid shell 
Shape Subtraction SC_walls_shell 
SC_walls_shell.Parameters SC_walls_outer SC_walls_inner

Volume SCouter
SCouter.Material SC_Al80St10Cu10_Dens281
SCouter.Shape SC_walls_shell
SCouter.Visibility 1
SCouter.Color 2
SCouter.Mother SCbody
SCouter.Position 0.0 0.0 0.0


####################################
# Power  
###############################

Volume batt
batt.Visibility 1
batt.Color 3
batt.Material SC_Elect1
batt.Shape BRIK {batt_width/2} {batt_length/2} {batt_depth/2}
batt.Mother SCbody
batt.Position {(1*(SCRadius*3/4))} {(1*(SCRadius)*sqrt(3)/4)} {SCHeight-batt_width}
batt.Rotation 0 90 210



# Body Mounted Solar Panels # 
# Note 11/15: Might not actually be present on model 
# 7 panels panels mounted at 60 deg intervals; x = rcos(theta),y=rsin(theta) 
#Volume bdy_panel_1
#bdy_panel_1.Visibility 1
#bdy_panel_1.Color 3
#bdy_panel_1.Material SC_Elect1
#bdy_panel_1.Shape BRIK {PanelWidth/2} {PanelLength/2} {PanelDepth/2}
#bdy_panel_1.Mother SCbody
#bdy_panel_1.Position 0.0 { -1*SCRadius - SCSideEffectiveThickness } {SCHeight+(PanelLength/2)}
#bdy_panel_1.Rotation 90.0 0 0

#Volume bdy_panel_3
#bdy_panel_3.Visibility 2
#bdy_panel_3.Color 3
#bdy_panel_3.Material SC_Elect1
#bdy_panel_3.Shape BRIK PanelWidth PanelLength PanelDepth
#bdy_panel_3.Mother SCbody
#bdy_panel_3.Position {((SCRadius+PanelBias)*3/4)} {((SCRadius+PanelBias)*sqrt(3)/4)} {SCHeight+(PanelLength/2)}
#bdy_panel_3.Rotation 90 0 300
# 
#Volume bdy_panel_4
#bdy_panel_4.Visibility 2
#bdy_panel_4.Color 3
#bdy_panel_4.Material SC_Elect1
#bdy_panel_4.Shape BRIK PanelWidth PanelLength PanelDepth
#bdy_panel_4.Mother SCbody
#bdy_panel_4.Position {(-1*(SCRadius+PanelBias)*3/4)} {((SCRadius+PanelBias)*sqrt(3)/4)} {SCHeight+(PanelLength/2)}
#bdy_panel_4.Rotation 90 0 60#

#Volume bdy_panel_5
#bdy_panel_5.Visibility 2
#bdy_panel_5.Color 3
#bdy_panel_5.Material SC_Elect1
#bdy_panel_5.Shape BRIK PanelWidth PanelLength PanelDepth
#bdy_panel_5.Mother SCbody
#bdy_panel_5.Position {(-1*(SCRadius+PanelBias)*3/4)} {(-1*(SCRadius+PanelBias)*sqrt(3)/4)} {SCHeight+(PanelLength/2)}
#bdy_panel_5.Rotation 90 180 120#

#Volume bdy_panel_6
#bdy_panel_6.Visibility 2
#bdy_panel_6.Color 3
#bdy_panel_6.Material SC_Elect1
#bdy_panel_6.Shape BRIK PanelWidth PanelLength PanelDepth
#bdy_panel_6.Mother SCbody
#bdy_panel_6.Position {((SCRadius+PanelBias)*3/4)} {(-1*(SCRadius+PanelBias)*sqrt(3)/4)} {SCHeight+(PanelLength/2)}
#bdy_panel_6.Rotation 90 0 240


# Deployed Solar array # 
# 5 panels at equidistant separation 
# Moved to seperate individual file titled COSISMEX.SolarPanels.geo
# Change this to set the angle of the solar array 
#Constant panel_angle 90

# Mounting point 
#Constant array_drive_y {(SCRadius+SCSideEffectiveThickness)+(DriveHeight/2)}
#Volume array_drive
#array_drive.Color 1
#array_drive.Material SC_Elect1
#array_drive.Shape TRD1 {DriveLength_1/2} {DriveLength_2/2}  {DriveDepth/2} {DriveHeight/2}
#array_drive.Mother SCbody
#array_drive.Position 0 array_drive_y {SCHeight} 
#array_drive.Rotation 90 {-1*panel_angle} 180

#Constant array_1_y {array_drive_y+40}
#Volume array_panel_1 
#array_panel_1.Color 3
#array_panel_1.Material SC_Elect1
#array_panel_1.Shape BRIK {PanelWidth/2} {PanelLength/2} {PanelDepth/2}
#array_panel_1.Mother SCbody
#array_panel_1.Position 0 array_1_y {SCHeight} 
#array_panel_1.Rotation panel_angle 0 90

#Constant array_2_y {array_1_y+PanelWidth+PanelSeparation}
#Volume array_panel_2 
#array_panel_2.Color 3
#array_panel_2.Material SC_Elect1
#array_panel_2.Shape BRIK {PanelWidth/2} {PanelLength/2} {PanelDepth/2}
#array_panel_2.Mother SCbody
#array_panel_2.Position 0 array_2_y {SCHeight} 
#array_panel_2.Rotation panel_angle 0 90

#Constant array_3_y {array_2_y+PanelWidth+PanelSeparation}
#Volume array_panel_3 
#array_panel_3.Color 3
#array_panel_3.Material SC_Elect1
#array_panel_3.Shape BRIK {PanelWidth/2} {PanelLength/2} {PanelDepth/2}
#array_panel_3.Mother SCbody
#array_panel_3.Position 0 array_3_y {SCHeight} 
#array_panel_3.Rotation panel_angle 0 90

#Constant array_4_y {array_3_y+PanelWidth+PanelSeparation}
#Volume array_panel_4 
#array_panel_4.Color 3
#array_panel_4.Material SC_Elect1
#array_panel_4.Shape BRIK {PanelWidth/2} {PanelLength/2} {PanelDepth/2}
#array_panel_4.Mother SCbody
#array_panel_4.Position 0 array_4_y {SCHeight} 
#array_panel_4.Rotation panel_angle 0 90

#Constant array_5_y {array_4_y+PanelWidth+PanelSeparation}
#Volume array_panel_5 
#array_panel_5.Color 3
#array_panel_5.Material SC_Elect1
#array_panel_5.Shape BRIK {PanelWidth/2} {PanelLength/2} {PanelDepth/2}
#array_panel_5.Mother SCbody
#array_panel_5.Position 0 array_5_y {SCHeight} 
#array_panel_5.Rotation panel_angle 0 90


###################################################
# Command and data handling 
##################################################
# Master Avionics Units
# MASS: 9.28 kg 
#Volume MAU 



Volume MAU

MAU.Color 4
MAU.Material SC_Elect1
MAU.Shape TRD1 {MAU_Length_1/2} {MAU_Length_2/2}  {MAU_Depth/2} {MAU_Height/2}
MAU.Mother SCbody
MAU.Position {(-1*(SCRadius*3/4))} {(1*(SCRadius)*sqrt(3)/4)} {7.24+{MAU_Length_2/2}}
MAU.Rotation 0 90 330

##########################################################
# Attitude Cotrol Subsystem
##########################################################

## Attidue Determination ## 
# - Coarse sun sensors (x4 dual, x1 triad)
# - Three-axis magnetometer 
# - Star tracker (data processing unit, camera head unit, baffle)

# Coarse Sun Sensors (Dual) (x4)
# MASS: 0.06 kg (ea) 
#Volume CSS_1 
#Volume CSS_2 
#Volume CSS_3 
#Volume CSS_4 


# Coarse Sun Sensors (Triad) (x1)
# MASS: 0.11 kg (ea) 
#Volume CSS_5 



# Three-axis magenetometer
# MASS: 0.32 kg 
#Volume TAM


# Star Tracker Data Processing Unit (DPU)
# MASS: 0.34 kg 
#Volume ST_DPU

# Star Tracker Camera Head Unit (CHU)
# MASS: 0.48 kg 
#Volume ST_CHU


# Star Tracker Baffle 
# MASS: 0.24 kg 
# Volume ST_BAFFLE

## ACTUATORS ## 
# - Magnetic Torquer Bars (x3)
# - Reaction Wheels (x4) 

# Magnetic Torquer Bars (MTB)
# MASS: 1.75 kg ea 


Volume MTB_1
MTB_1.Color 1
MTB_1.Material SC_Elect1
MTB_1.Shape TUBE 0 MT_radius {MT_length/2} 0 360 
MTB_1.Mother SCbody
#MTB_1.Position -28 0 {MT_radius+SCBottomEffectiveThickness}
MTB_1.Position -28 0 {MT_radius+SCSideEffectiveThickness}
MTB_1.Rotation 90 0 0

Volume MTB_2
MTB_2.Color 1
MTB_2.Material SC_Elect1
MTB_2.Shape TUBE 0 MT_radius {MT_length/2} 0 360 
MTB_2.Mother SCbody
#MTB_2.Position 28 -42 {(MT_length/2)+SCBottomEffectiveThickness+5}
MTB_2.Position 28 -42 {(MT_length/2)+SCSideEffectiveThickness+5}
MTB_2.Rotation 180 0 0
#Volume MTB_3



# Reaction Wheels 
# From SolidWorks: Incline at 60 deg, each wheel separated by 40.46cm; raised by 2.54 cm
# MASS: 2.50 kg ea

# Position of RW center, as measured from Solidworks: 16.8cm. Adjusted to 18.5 cm here
Constant RW_CoM_dist 18.5
Volume RW_1
RW_1.Color 2
RW_1.Material SC_Elect1
RW_1.Shape BRIK {WheelLength/2} {WheelWidth/2} {WheelDepth/2}
RW_1.Mother SCbody
RW_1.Position RW_CoM_dist 0 {(2.54+WheelLength/2)}
RW_1.Rotation 60 0 90


# Add plate beneath wheel 


Volume RW_2
RW_2.Color 2
RW_2.Material SC_Elect1
RW_2.Shape BRIK {WheelLength/2} {WheelWidth/2} {WheelDepth/2}
RW_2.Mother SCbody
RW_2.Position {-1*(RW_CoM_dist)} 0 {(2.54+WheelLength/2)}
#RW_2.Position {-1*(RW_CoM_dist)+1} 0 {(2.54+WheelLength/2)}
RW_2.Rotation 60 0 270



Volume RW_3
RW_3.Color 2
RW_3.Material SC_Elect1
RW_3.Shape BRIK {WheelLength/2} {WheelWidth/2} {WheelDepth/2}
RW_3.Mother SCbody
RW_3.Position 0 {1*(RW_CoM_dist)} {(2.54+WheelLength/2)}
RW_3.Rotation 60 0 180

Volume RW_4
RW_4.Color 2
RW_4.Material SC_Elect1
RW_4.Shape BRIK {WheelLength/2} {WheelWidth/2} {WheelDepth/2}
RW_4.Mother SCbody
RW_4.Position 0 {-1*(RW_CoM_dist)} {(2.54+WheelLength/2)}
RW_4.Rotation 60 0 0



# Model reaction wheel mounts as two orthogonal trapezoids 
Shape TRD1 RW_bracket_1 
RW_bracket_1.Parameters {RW_Separation_Bottom/2} {RW_Separation_Top/2} {RW_Separation_Top/2} {RW_Height/2}
Orientation RW_bracket_1_ori
RW_bracket_1_ori.Position 0.0 0.0 0.0
RW_bracket_1_ori.Rotation 0.0 0.0 0.0 


Shape TRD1 RW_bracket_2
RW_bracket_2.Parameters {RW_Separation_Bottom/2} {RW_Separation_Top/2} {RW_Separation_Top/2} {(RW_Height/2)+0.001}
Orientation RW_bracket_2_ori
RW_bracket_2_ori.Position 0.0 0.0 0.0
RW_bracket_2_ori.Rotation 0.0 0.0 90.0 

# Carve out first set of reaction wheel holders 
Shape Subtraction wheel_platform_subtracted_1
wheel_platform_subtracted_1.Parameters RW_bracket_1 RW_bracket_2 RW_bracket_2_ori

# Place the organic shape as volume inside mother volume 
Volume wheel_platform_1 
wheel_platform_1.Color 4
wheel_platform_1.Material SC_Al70St10Cu10Ti10
wheel_platform_1.Shape wheel_platform_subtracted_1
wheel_platform_1.Mother SCbody
wheel_platform_1.Position 0 0 {RW_Height/2+0.1}


#Place the organic shape as volume inside mother volume 
Volume wheel_platform_2 
wheel_platform_2.Color 4
wheel_platform_2.Material SC_Al70St10Cu10Ti10
wheel_platform_2.Shape wheel_platform_subtracted_1
wheel_platform_2.Mother SCbody
wheel_platform_2.Position 0 0 {RW_Height/2+0.1}
wheel_platform_2.Rotation 0 0 90



## Solar Array Drive Assembly (SADA): 
Volume SADA
SADA.Color 6
SADA.Material SC_Elect1
SADA.Shape TUBE 0 SADA_radius {SADA_length/2} 0 360 
SADA.Mother SCbody
SADA.Position 0 {(SCRadius-SCSideEffectiveThickness)-(SADA_length/2)} {SADA_CoM_height-1}
SADA.Rotation 90 0 0

## Solar Array Drive Electronics: 
Volume SADE
SADE.Color 7
SADE.Material SC_Elect1
SADE.Shape TUBE 0 SADE_radius {SADE_length/2} 0 360 
SADE.Mother SCbody
SADE.Position SADE_radius {(SCRadius)-(SADE_length/2)} {SADE_CoM_height}
SADE.Rotation 90 0 0

## S-band transciever
Volume MSTB 
MSTB.Visibility 1
MSTB.Color 7
MSTB.Material SC_Elect1
MSTB.Shape BRIK {MSTB_width/2} {MSTB_length/2} {MSTB_width/2}
MSTB.Mother SCbody
# Try using measured position instead of analytic 
MSTB.Position -38 -15.5 15.5
MSTB.Rotation 0 90 210


## Three-Axis magnetometer (TAM)
Volume TAM 
TAM.Visibility 1
TAM.Color 2
TAM.Material SC_Elect1
TAM.Shape BRIK {TAM_width/2} {TAM_length/2} {TAM_depth/2}
TAM.Mother SCbody
# Try using measured position instead of analytic 
#TAM.Position -32 -39 30
TAM.Position -31 -38 30
TAM.Rotation 0 90 210
