# This is the cryostat model



# The main volume:

Volume Telescope
Telescope.Material vacuum
Telescope.Visibility 1
Telescope.Color 67
Telescope.Shape BRIK {CryostatOuterX} {CryostatOuterY} {CryostatOuterZ + CryoLidZ + CryoBaseStageZ}  
Telescope.Position 0.0 0.0 {-ShieldedHeight -.71 - BGOBotZ + 2*CryoBaseZ+ CryoBaseStageZ + CryostatOuterZ + CryoLidZ + 2*1.605}
#Telescope.Position 0.0 0.0 {-ShieldedHeight+ 2*CryoBaseZ+ CryoBaseStageZ + CryostatOuterZ + CryoLidZ + 2*1.605}
Telescope.Mother ShieldedTelescope


    

#################################################################################################################
# The cryostat hull

Shape BRIK CryostatBlock
CryostatBlock.Parameters CryostatOuterX CryostatOuterY CryostatOuterZ
Shape BRIK CryostatCavity
CryostatCavity.Parameters { CryostatOuterX -2*CryostatXYFullThickness } { CryostatOuterY - 2*CryostatXYFullThickness } {CryostatOuterZ+.1}
Orientation CryostatCavityOri
CryostatCavityOri.Position 0.0 0.0 0.0

Shape SUBTRACTION CryostatBodyMinusCavity
CryostatBodyMinusCavity.Parameters CryostatBlock CryostatCavity CryostatCavityOri

Volume Cryostat
Cryostat.Material al6061
Cryostat.Visibility 1 
Cryostat.Color 4
Cryostat.Shape CryostatBodyMinusCavity
Cryostat.Position 0.0 0.0 {-CryoLidZ+CryoBaseStageZ}
Cryostat.Mother Telescope

#Making the lid
Shape BRIK CryostatLidBlock
CryostatLidBlock.Parameters CryostatOuterX CryostatOuterY CryoLidZ
Shape BRIK CryostatLidCavity
CryostatLidCavity.Parameters { CryostatOuterX -2*CryostatXYFullThickness } { CryostatOuterY - 2*CryostatXYFullThickness } {CryoLidZ}
Orientation CryostatLidCavityOri
CryostatLidCavityOri.Position 0.0 0.0 {-CryostatXYFullThickness}

Shape SUBTRACTION CryostatLidMinusCavity
CryostatLidMinusCavity.Parameters CryostatLidBlock CryostatLidCavity CryostatLidCavityOri

# Next, make the 8 holes out the top lid, then add in the feedthroughs
Shape BRIK FeedThroughHole1
FeedThroughHole1.Parameters 4.267 .7745 {CryostatXYFullThickness}
Orientation FeedThroughHole1Ori
FeedThroughHole1Ori.Position {CryostatOuterX-4.267-6.372} {CryostatOuterY-0.7745-2.276} {CryoLidZ}

Shape SUBTRACTION CryoLidMinusFeedthrough1
CryoLidMinusFeedthrough1.Parameters CryostatLidMinusCavity FeedThroughHole1 FeedThroughHole1Ori

Orientation FeedThroughHole2Ori
FeedThroughHole2Ori.Position {-CryostatOuterX+4.267+6.372} {CryostatOuterY-0.7745-2.276} {CryoLidZ}

Shape SUBTRACTION CryoLidMinusFeedthrough2
CryoLidMinusFeedthrough2.Parameters CryoLidMinusFeedthrough1 FeedThroughHole1 FeedThroughHole2Ori

Orientation FeedThroughHole3Ori
FeedThroughHole3Ori.Position {-CryostatOuterX+4.267+6.372} {-CryostatOuterY+0.7745+2.276} {CryoLidZ}

Shape SUBTRACTION CryoLidMinusFeedthrough3
CryoLidMinusFeedthrough3.Parameters CryoLidMinusFeedthrough2 FeedThroughHole1 FeedThroughHole3Ori

Orientation FeedThroughHole4Ori
FeedThroughHole4Ori.Position {+CryostatOuterX-4.267-6.372} {-CryostatOuterY+0.7745+2.276} {CryoLidZ}

Shape SUBTRACTION CryoLidMinusFeedthrough4
CryoLidMinusFeedthrough4.Parameters CryoLidMinusFeedthrough3 FeedThroughHole1 FeedThroughHole4Ori

Shape BRIK FeedThroughHoleY
FeedThroughHoleY.Parameters 0.7745 4.267 {CryostatXYFullThickness}
Orientation FeedThroughHoleY1Ori
FeedThroughHoleY1Ori.Position {-CryostatOuterX+0.7745+2.276} {CryostatOuterY-4.267-4.588} {CryoLidZ}

Shape SUBTRACTION CryoLidMinusFeedthroughY1
CryoLidMinusFeedthroughY1.Parameters CryoLidMinusFeedthrough4 FeedThroughHoleY FeedThroughHoleY1Ori

Orientation FeedThroughHoleY2Ori
FeedThroughHoleY2Ori.Position {-CryostatOuterX+0.7745+2.276} {-CryostatOuterY+4.267+4.588} {CryoLidZ}

Shape SUBTRACTION CryoLidMinusFeedthroughY2
CryoLidMinusFeedthroughY2.Parameters CryoLidMinusFeedthroughY1 FeedThroughHoleY FeedThroughHoleY2Ori

Orientation FeedThroughHoleY3Ori
FeedThroughHoleY3Ori.Position {CryostatOuterX-0.7745-2.276} {-14.7255+4.267+4.588} {CryoLidZ}

Shape SUBTRACTION CryoLidMinusFeedthroughY3
CryoLidMinusFeedthroughY3.Parameters CryoLidMinusFeedthroughY2 FeedThroughHoleY FeedThroughHoleY3Ori

Orientation FeedThroughHoleY4Ori
FeedThroughHoleY4Ori.Position {CryostatOuterX-0.7745-2.276} {14.7255-4.267-4.588} {CryoLidZ}

Shape SUBTRACTION CryoLidMinusFeedthroughY4
CryoLidMinusFeedthroughY4.Parameters CryoLidMinusFeedthroughY3 FeedThroughHoleY FeedThroughHoleY4Ori

Volume CryostatLid
CryostatLid.Material al6061
CryostatLid.Visibility 1
CryostatLid.Color 4
CryostatLid.Shape CryoLidMinusFeedthroughY4
CryostatLid.Position 0.0 0.0 {CryostatOuterZ+CryoBaseStageZ}
CryostatLid.Mother Telescope

Volume Cryostat_Interior
Cryostat_Interior.Material vacuum
Cryostat_Interior.Visibility 1
Cryostat_Interior.Color 67
Cryostat_Interior.Shape BRIK { CryostatOuterX -2*CryostatXYFullThickness } { CryostatOuterY - 2*CryostatXYFullThickness } {CryostatOuterZ+CryoLidZ-0.5*CryostatXYFullThickness}
Cryostat_Interior.Position 0.0 0.0 {CryoBaseStageZ-0.5*CryostatXYFullThickness}
Cryostat_Interior.Mother Telescope

###################################################################################################
# Feedthrough assembly

Shape BRIK FeedthroughHolder
FeedthroughHolder.Parameters 5.156 1.702 0.635
Shape Brik FeedthroughSlot
FeedthroughSlot.Parameters 4.267 0.7745 0.735

Orientation FeedthroughSlotOri
FeedthroughSlotOri.Position 0.0 0.0 0.0

Shape SUBTRACTION FeedthroughHolderMinusSlot
FeedthroughHolderMinusSlot.Parameters FeedthroughHolder FeedthroughSlot FeedthroughSlotOri

Volume FeedthroughAssem
FeedthroughAssem.Material al6061
FeedthroughAssem.Visibility 1
FeedthroughAssem.Color 96
FeedthroughAssem.Shape FeedthroughHolderMinusSlot

FeedthroughAssem.Copy FeedthroughAssem1
FeedthroughAssem1.Rotation 0.0 0.0 90.0
#FeedthroughAssem.Position {CryostatOuterX-0.7745-2.276} {CryostatOuterY-4.267-4.588} {CryoLidZ-0.735-CryostatXYFullThickness}
FeedthroughAssem1.Position {CryostatOuterX-0.7745-2.276} {CryostatOuterY-5.156-3.699} {CryostatOuterZ+CryoLidZ-0.5*CryostatXYFullThickness-0.635}
FeedthroughAssem1.Mother Cryostat_Interior

FeedthroughAssem.Copy FeedthroughAssem2
FeedthroughAssem2.Rotation 0.0 0.0 90.0
FeedthroughAssem2.Position {CryostatOuterX-0.7745-2.276} {CryostatOuterY-3*5.156-3.699-1.429} {CryostatOuterZ+CryoLidZ-0.5*CryostatXYFullThickness-0.635}
FeedthroughAssem2.Mother Cryostat_Interior

FeedthroughAssem.Copy FeedthroughAssem3
FeedthroughAssem3.Rotation 0.0 0.0 90.0
FeedthroughAssem3.Position {-CryostatOuterX+0.7745+2.276} {CryostatOuterY-5.156-3.699} {CryostatOuterZ+CryoLidZ-0.5*CryostatXYFullThickness-0.635}
FeedthroughAssem3.Mother Cryostat_Interior

FeedthroughAssem.Copy FeedthroughAssem4
FeedthroughAssem4.Rotation 0.0 0.0 90.0
FeedthroughAssem4.Position {-CryostatOuterX+0.7745+2.276} {CryostatOuterY-3*5.156-3.699-1.429} {CryostatOuterZ+CryoLidZ-0.5*CryostatXYFullThickness-0.635}
FeedthroughAssem4.Mother Cryostat_Interior

FeedthroughAssem.Copy FeedthroughAssem5
FeedthroughAssem5.Position {CryostatOuterX-5.156-5.483} {CryostatOuterY-0.7745-2.276} {CryostatOuterZ+CryoLidZ-0.5*CryostatXYFullThickness-0.635}
FeedthroughAssem5.Mother Cryostat_Interior

FeedthroughAssem.Copy FeedthroughAssem6
FeedthroughAssem6.Position {-CryostatOuterX+5.156+5.483} {CryostatOuterY-0.7745-2.276} {CryostatOuterZ+CryoLidZ-0.5*CryostatXYFullThickness-0.635}
FeedthroughAssem6.Mother Cryostat_Interior

FeedthroughAssem.Copy FeedthroughAssem7
FeedthroughAssem7.Position {CryostatOuterX-5.156-5.483} {-CryostatOuterY+0.7745+2.276} {CryostatOuterZ+CryoLidZ-0.5*CryostatXYFullThickness-0.635}
FeedthroughAssem7.Mother Cryostat_Interior

FeedthroughAssem.Copy FeedthroughAssem8
#FeedthroughAssem8.Position {-CryostatOuterX+5.156+5.483} {-CryostatOuterY+0.7745+2.276} {CryostatOuterZ+CryoLidZ+(CryoLidZ-0.635)-CryostatXYFullThickness}
FeedthroughAssem8.Position {-CryostatOuterX+5.156+5.483} {-CryostatOuterY+0.7745+2.276} {CryostatOuterZ+CryoLidZ-0.5*CryostatXYFullThickness-0.635}
FeedthroughAssem8.Mother Cryostat_Interior


# now add in the epoxy 
Volume FeedthroughEpoxy
FeedthroughEpoxy.Material Epoxy
FeedthroughEpoxy.Visibility 1
FeedthroughEpoxy.Color 86
FeedthroughEpoxy.Shape BRIK 4.267 0.7745 0.3175

FeedthroughEpoxy.Copy FeedthroughEpoxy1
FeedthroughEpoxy1.Rotation 0.0 0.0 90.0
FeedthroughEpoxy1.Position {CryostatOuterX-0.7745-2.276} {CryostatOuterY-5.156-3.699} {CryostatOuterZ+CryoLidZ-0.5*CryostatXYFullThickness-0.635}
FeedthroughEpoxy1.Mother Cryostat_Interior

FeedthroughEpoxy.Copy FeedthroughEpoxy2
FeedthroughEpoxy2.Rotation 0.0 0.0 90.0
FeedthroughEpoxy2.Position {CryostatOuterX-0.7745-2.276} {CryostatOuterY-3*5.156-3.699-1.429} {CryostatOuterZ+CryoLidZ-0.5*CryostatXYFullThickness-0.635}
FeedthroughEpoxy2.Mother Cryostat_Interior

FeedthroughEpoxy.Copy FeedthroughEpoxy3
FeedthroughEpoxy3.Rotation 0.0 0.0 90.0
FeedthroughEpoxy3.Position {-CryostatOuterX+0.7745+2.276} {CryostatOuterY-5.156-3.699} {CryostatOuterZ+CryoLidZ-0.5*CryostatXYFullThickness-0.635}
FeedthroughEpoxy3.Mother Cryostat_Interior

FeedthroughEpoxy.Copy FeedthroughEpoxy4
FeedthroughEpoxy4.Rotation 0.0 0.0 90.0
FeedthroughEpoxy4.Position {-CryostatOuterX+0.7745+2.276} {CryostatOuterY-3*5.156-3.699-1.429} {CryostatOuterZ+CryoLidZ-0.5*CryostatXYFullThickness-0.635}
FeedthroughEpoxy4.Mother Cryostat_Interior

FeedthroughEpoxy.Copy FeedthroughEpoxy5
FeedthroughEpoxy5.Position {CryostatOuterX-5.156-5.483} {CryostatOuterY-0.7745-2.276} {CryostatOuterZ+CryoLidZ-0.5*CryostatXYFullThickness-0.635}
FeedthroughEpoxy5.Mother Cryostat_Interior

FeedthroughEpoxy.Copy FeedthroughEpoxy6
FeedthroughEpoxy6.Position {-CryostatOuterX+5.156+5.483} {CryostatOuterY-0.7745-2.276} {CryostatOuterZ+CryoLidZ-0.5*CryostatXYFullThickness-0.635}
FeedthroughEpoxy6.Mother Cryostat_Interior

FeedthroughEpoxy.Copy FeedthroughEpoxy7
FeedthroughEpoxy7.Position {CryostatOuterX-5.156-5.483} {-CryostatOuterY+0.7745+2.276} {CryostatOuterZ+CryoLidZ-0.5*CryostatXYFullThickness-0.635}
FeedthroughEpoxy7.Mother Cryostat_Interior

FeedthroughEpoxy.Copy FeedthroughEpoxy8
FeedthroughEpoxy8.Position {-CryostatOuterX+5.156+5.483} {-CryostatOuterY+0.7745+2.276} {CryostatOuterZ+CryoLidZ-0.5*CryostatXYFullThickness-0.635}
FeedthroughEpoxy8.Mother Cryostat_Interior


##################################################################################
# Cryostat bottom and base
# Moved to the ACS geometry

#Shape BRIK CryoBigBase
#CryoBigBase.Parameters CryoBaseX CryoBaseY CryoBaseZ
#Shape BRIK CryoBaseStage
#CryoBaseStage.Parameters CryoBaseStageX CryoBaseStageY CryoBaseStageZ
#Orientation CryoBaseStageOri
#CryoBaseStageOri.Position 0.0 0.0 {(CryoBaseZ-CryoBaseStageZ)+2*CryoBaseStageZ}

#Shape UNION CryoBigBasePlusStage
#CryoBigBasePlusStage.Parameters CryoBigBase CryoBaseStage CryoBaseStageOri

#Shape TUBE CryoBaseFrangHole
#CryoBaseFrangeHole.Parametes 0.0 0.363 {2*CryoBaseStageZ+2*CryoBaseZ+.1} 0.0 360.0
#CryoBaseFrangeHole.Parametes 0.0 0.363 {2.386} 0.0 360.0
#Orientation CryoBaseFrangHoleOri
#CryoBaseFrangHoleOri.Position 0.0 0.0 0.0

#Shape Subtraction CryoBaseMinusFrangHole
#CryoBaseMinusFrangHole.Parameters CryoBigBasePlusStage CryoBaseFrangHole CryoBaseFrangHoleOri

#material is Al6061
Volume Cryostat_Stage
Cryostat_Stage.Material al6061
Cryostat_Stage.Visibility 1
Cryostat_Stage.Color 3
Cryostat_Stage.Shape BRIK CryoBaseStageX CryoBaseStageY CryoBaseStageZ
Cryostat_Stage.Position 0.0 0.0 {-CryostatOuterZ - CryoLidZ}
#Cryostat_Stage.Position 0.0 0.0 {-CryostatOuterZ-CryoLidZ-0.5*CryostatXYFullThickness+CryoBaseStageZ}
Cryostat_Stage.Mother Telescope


#################################################################################################################
# The cold finger


#Constant ColdfingerMaterial   CarbonCyanateEster

#Volume ColdfingerBase
#ColdfingerBase.Material ColdfingerMaterial
#ColdfingerBase.Visibility 1 
#ColdfingerBase.Color 51
#ColdfingerBase.Shape BRIK  { 0.5*ColdfingerDepth } { 0.5*ColdfingerLength } { 0.5*ColdfingerBaseHeight }
#ColdfingerBase.Position 0 0 { ColdfingerBasePosZ + 0.5*ColdfingerBaseHeight }
#ColdfingerBase.Mother Cryostat

#Volume ColdfingerSpire
#ColdfingerSpire.Material ColdfingerMaterial
#ColdfingerSpire.Visibility 1
#ColdfingerSpire.Color 7
#ColdfingerSpire.Shape BRIK  { 0.5*ColdfingerDepth } { 0.5*ColdfingerSpireLength } { 0.5*ColdfingerSpireHeight }

#ColdfingerSpire.Copy ColdfingerSpireA
#ColdfingerSpireA.Position 0 { 0.5*ColdfingerLength - 0.5*ColdfingerSpireLength }  { ColdfingerBasePosZ + ColdfingerBaseHeight + 0.5 * ColdfingerSpireHeight }
#ColdfingerSpireA.Mother Cryostat

#ColdfingerSpire.Copy ColdfingerSpireB
#ColdfingerSpireB.Position 0 { -0.5*ColdfingerLength + 0.5*ColdfingerSpireLength }  { ColdfingerBasePosZ + ColdfingerBaseHeight + 0.5 * ColdfingerSpireHeight }
#ColdfingerSpireB.Mother Cryostat



####################################################################################################################################
#  Detector holder base

Constant DHB_HalfWidth   {0.5*1.27}
#The side along x has a larger bigger width than the other side so I added another constant
Constant DHB_HalfWidth_AlongY   {0.5*0.635}
Constant DHB_HalfWidth_AlongX   {0.5*0.752}
Constant DHB_HalfHeight  {0.5*ColdfingerBaseHeight}
Constant DHB_IRShield_Gap  0.05

Volume DHB_AlongY
DHB_AlongY.Material al6061
DHB_AlongY.Visibility 1 
DHB_AlongY.Color 1
DHB_AlongY.Shape BRIK DHB_HalfWidth_AlongY {0.5*IRShieldY} DHB_HalfHeight

DHB_AlongY.Copy DHB_AlongYPlus
#DHB_AlongYPlus.Position  { 0.5*IRShieldX - IRShieldThickness - DHB_HalfWidth} 0.0 { ColdfingerBasePosZ + DHB_HalfHeight }
DHB_AlongYPlus.Position  { (0.5*IRShieldX) - IRShieldSideX - DHB_IRShield_Gap - DHB_HalfWidth_AlongY } 0.0 {ColdfingerBasePosZ-CryoLidZ+0.5*CryostatXYFullThickness}
DHB_AlongYPlus.Mother Cryostat_Interior


DHB_AlongY.Copy DHB_AlongYMinus
DHB_AlongYMinus.Position  { - 0.5*IRShieldX + IRShieldSideX + DHB_IRShield_Gap + DHB_HalfWidth_AlongY} 0.0 {ColdfingerBasePosZ-CryoLidZ+0.5*CryostatXYFullThickness}
DHB_AlongYMinus.Mother Cryostat_Interior

Constant DHB_AlongX_HalfSizeX { 0.5*(IRShieldX - 2*IRShieldSideX - 4*DHB_HalfWidth_AlongY - 2*DHB_IRShield_Gap) }

Volume DHB_AlongX
DHB_AlongX.Material al6061
DHB_AlongX.Visibility 1
DHB_AlongX.Color 6
DHB_AlongX.Shape BRIK DHB_AlongX_HalfSizeX DHB_HalfWidth_AlongX  DHB_HalfHeight

DHB_AlongX.Copy DHB_AlongXOutDown
#DHB_AlongXOutDown.Position { 0.5*ColdfingerDepth + DHB_AlongX_HalfSizeX } { 0.5*IRShieldY - IRShieldThickness - DHB_HalfWidth} { ColdfingerBasePosZ + DHB_HalfHeight }
DHB_AlongXOutDown.Position { 0.0 } { 0.5*IRShieldY - DHB_HalfWidth_AlongX} {ColdfingerBasePosZ-CryoLidZ+0.5*CryostatXYFullThickness}
DHB_AlongXOutDown.Mother Cryostat_Interior

DHB_AlongX.Copy DHB_AlongXInDown
DHB_AlongXInDown.Position { 0.0 } { - 0.5*IRShieldY + DHB_HalfWidth_AlongX} {ColdfingerBasePosZ-CryoLidZ+0.5*CryostatXYFullThickness}
DHB_AlongXInDown.Mother Cryostat_Interior

#Middle Base is thicker than the other two
Volume DHB_AlongXMiddleDown
DHB_AlongXMiddleDown.Material al7075
DHB_AlongXMiddleDown.Visibility 1
DHB_AlongXMiddleDown.Color 6
DHB_AlongXMiddleDown.Shape BRIK DHB_AlongX_HalfSizeX DHB_HalfWidth  {DHB_HalfHeight-.4}
DHB_AlongXMiddleDown.Position { 0.0 } { 0.0 } {ColdfingerBasePosZ-CryoLidZ+0.5*CryostatXYFullThickness-.2}
DHB_AlongXMiddleDown.Mother Cryostat_Interior

#Center structure material is al7075
Volume DHB_CentStrucBase
DHB_CentStrucBase.Material al7075
DHB_CentStrucBase.Visibility 1
DHB_CentStrucBase.Color 3
DHB_CentStrucBase.Shape BRIK DHB_CentStrucBase_HalfWidth {0.5*(0.5*IRShieldY - 2*DHB_HalfWidth_AlongX-DHB_HalfWidth)} DHB_CentStrucBase_HalfHeight

DHB_CentStrucBase.Copy DHB_CentStrucBase_PosY
DHB_CentStrucBase_PosY.Position 0.0 {0.5*IRShieldY -0.5*(0.5*IRShieldY - 2*DHB_HalfWidth_AlongX-DHB_HalfWidth)-2*DHB_HalfWidth_AlongX } {ColdfingerBasePosZ+(DHB_CentStrucBase_HalfHeight-DHB_HalfHeight)-CryoLidZ+0.5*CryostatXYFullThickness}
DHB_CentStrucBase_PosY.Mother Cryostat_Interior

DHB_CentStrucBase.Copy DHB_CentStrucBase_NegY
DHB_CentStrucBase_NegY.Position 0.0 {- 0.5*IRShieldY +0.5*(0.5*IRShieldY - 2*DHB_HalfWidth_AlongX-DHB_HalfWidth)+2*DHB_HalfWidth_AlongX } {ColdfingerBasePosZ+(DHB_CentStrucBase_HalfHeight-DHB_HalfHeight)-CryoLidZ+0.5*CryostatXYFullThickness}
DHB_CentStrucBase_NegY.Mother Cryostat_Interior

#The Center Structure base that connects the two sides over the middle base rod
Volume DHB_CentStrucBase_Bridge
DHB_CentStrucBase_Bridge.Material al7075
DHB_CentStrucBase_Bridge.Visibility 1
DHB_CentStrucBase_Bridge.Color 3
DHB_CentStrucBase_Bridge.Shape BRIK DHB_CentStrucBase_HalfWidth DHB_HalfWidth {DHB_CentStrucBase_HalfHeight-DHB_HalfHeight}
DHB_CentStrucBase_Bridge.Position {0.0} {0.0} {ColdfingerBasePosZ+(DHB_CentStrucBase_HalfHeight-DHB_HalfHeight)+DHB_CentStrucBase_HalfHeight-(DHB_CentStrucBase_HalfHeight-DHB_HalfHeight)-CryoLidZ+0.5*CryostatXYFullThickness}
DHB_CentStrucBase_Bridge.Mother Cryostat_Interior

Volume DHB_CentStrucArms
DHB_CentStrucArms.Material al7075
DHB_CentStrucArms.Visibility 1
DHB_CentStrucArms.Color 3
DHB_CentStrucArms.Shape BRIK DHB_CentStrucBase_HalfWidth DHB_CentStrucArms_HalfLength DHB_CentStrucArms_HalfHeight

DHB_CentStrucArms.Copy DHB_CentStrucArms_PosY
DHB_CentStrucArms_PosY.Position 0.0 { 0.5*IRShieldY - DHB_HalfWidth_AlongX - DHB_HalfWidth_AlongX - DHB_CentStrucArms_HalfLength } {ColdfingerBasePosZ+(2.0*DHB_CentStrucBase_HalfHeight-DHB_HalfHeight)+DHB_CentStrucArms_HalfHeight-CryoLidZ+0.5*CryostatXYFullThickness}
DHB_CentStrucArms_PosY.Mother Cryostat_Interior

DHB_CentStrucArms.Copy DHB_CentStrucArms_NegY
DHB_CentStrucArms_NegY.Position 0.0 {- 0.5*IRShieldY + DHB_HalfWidth_AlongX + DHB_HalfWidth_AlongX + DHB_CentStrucArms_HalfLength } {ColdfingerBasePosZ+(2.0*DHB_CentStrucBase_HalfHeight-DHB_HalfHeight)+DHB_CentStrucArms_HalfHeight-CryoLidZ+0.5*CryostatXYFullThickness}
DHB_CentStrucArms_NegY.Mother Cryostat_Interior


#Now need to add the added mass that are at the top of the arms. 
#This should also be the material of aluminum 7075
Volume DHB_CentStrucArmsTabs
DHB_CentStrucArmsTabs.Material al7075
DHB_CentStrucArmsTabs.Visibility 1
DHB_CentStrucArmsTabs.Color 3
DHB_CentStrucArmsTabs.Shape BRIK DHB_CentStrucBase_HalfWidth DHB_CentStrucArmsTabs_HalfLength DHB_CentStrucArmsTabs_HalfHeight

DHB_CentStrucArmsTabs.Copy DHB_CentStrucArmsTabs_PosY
DHB_CentStrucArmsTabs_PosY.Position 0.0 {0.5*IRShieldY - DHB_HalfWidth_AlongX - DHB_HalfWidth_AlongX +DHB_CentStrucArmsTabs_HalfLength} {ColdfingerBasePosZ+(2.0*DHB_CentStrucBase_HalfHeight-DHB_HalfHeight)+2*DHB_CentStrucArms_HalfHeight-DHB_CentStrucArmsTabs_HalfHeight-CryoLidZ+0.5*CryostatXYFullThickness}
DHB_CentStrucArmsTabs_PosY.Mother Cryostat_Interior

DHB_CentStrucArmsTabs.Copy DHB_CentStrucArmsTabs_NegY
DHB_CentStrucArmsTabs_NegY.Position 0.0 {-0.5*IRShieldY + DHB_HalfWidth_AlongX + DHB_HalfWidth_AlongX - DHB_CentStrucArmsTabs_HalfLength} {ColdfingerBasePosZ+(2.0*DHB_CentStrucBase_HalfHeight-DHB_HalfHeight)+2*DHB_CentStrucArms_HalfHeight-DHB_CentStrucArmsTabs_HalfHeight-CryoLidZ+0.5*CryostatXYFullThickness}
DHB_CentStrucArmsTabs_NegY.Mother Cryostat_Interior

#Renaming DHB_Spire to DHB_DetSidePost since it is titled side post in the CAD
#The material here should be al7075
# The width of this part is smaller than it should be but may be okay when accounting for total mass
Volume DHB_DetSidePost
DHB_DetSidePost.Material al7075
DHB_DetSidePost.Visibility 1
DHB_DetSidePost.Color 67
DHB_DetSidePost.Shape BRIK DHB_DetSidePost_HalfWidth DHB_DetSidePost_HalfLength DHB_DetSidePost_HalfHeight

DHB_DetSidePost.Copy DHB_DetSidePost_PosX
DHB_DetSidePost_PosX.Position {DHB_AlongX_HalfSizeX-1.496} 0.0 {ColdfingerBasePosZ+DHB_HalfHeight+DHB_DetSidePost_HalfHeight-CryoLidZ+0.5*CryostatXYFullThickness}
DHB_DetSidePost_PosX.Mother Cryostat_Interior

DHB_DetSidePost.Copy DHB_DetSidePost_NegX
DHB_DetSidePost_NegX.Position {-DHB_AlongX_HalfSizeX+1.496} 0.0 {ColdfingerBasePosZ+DHB_HalfHeight+DHB_DetSidePost_HalfHeight-CryoLidZ+0.5*CryostatXYFullThickness}
DHB_DetSidePost_NegX.Mother Cryostat_Interior


#Detector spider and stack skewer in the center of the holder base
#The spider is Al7075 while the rods are 304 stainless steel
Volume DHB_SkewBaseBlock
DHB_SkewBaseBlock.Material al7075 
DHB_SkewBaseBlock.Visibility 1
DHB_SkewBaseBlock.Color 7
DHB_SkewBaseBlock.Shape BRIK 0.5715 0.3685 0.413

DHB_SkewBaseBlock.Copy DHB_SkewBaseBlock_PosX
DHB_SkewBaseBlock_PosX.Position {DHB_CentStrucBase_HalfWidth+0.5715} {0.0} {ColdfingerBasePosZ+DHB_HalfHeight+.413-CryoLidZ+0.5*CryostatXYFullThickness}
DHB_SkewBaseBlock_PosX.Mother Cryostat_Interior

DHB_SkewBaseBlock.Copy DHB_SkewBaseBlock_NegX
DHB_SkewBaseBlock_NegX.Position {-DHB_CentStrucBase_HalfWidth-0.5715} {0.0} {ColdfingerBasePosZ+DHB_HalfHeight+.413-CryoLidZ+0.5*CryostatXYFullThickness}
DHB_SkewBaseBlock_NegX.Mother Cryostat_Interior

#Revisit this, I think the CAD model is wrong
#Volume DHB_SkewBase
#DHB_SkewBase.Material al7075
#DHB_SkewBase.Visibility 1
#DHB_SkewBase.Color 7
#DHB_SkewBase.Shape BRIK 0.216 0.2285 0.4395

#DHB_SkewBase.Copy DHB_SkewBase1
#DHB_SkewBase1.Position {DHB_CentStrucBase_HalfWidth+0.5715+.5715-.216} {0.3685+0.2285} {ColdfingerBasePosZ+DHB_HalfHeight+0.4395-CryoLidZ+0.5*CryostatXYFullThickness}
#DHB_SkewBase1.Mother Cryostat_Interior

#DHB_SkewBase.Copy DHB_SkewBase2
#DHB_SkewBase2.Position {DHB_CentStrucBase_HalfWidth+0.5715+.5715-.216} {-0.3685-0.2285} {ColdfingerBasePosZ+DHB_HalfHeight+0.4395-CryoLidZ+0.5*CryostatXYFullThickness}
#DHB_SkewBase2.Mother Cryostat_Interior

#DHB_SkewBase.Copy DHB_SkewBase3
#DHB_SkewBase3.Position {-DHB_CentStrucBase_HalfWidth-0.5715-.5715+.216} {-0.3685-0.2285} {ColdfingerBasePosZ+DHB_HalfHeight+0.4395-CryoLidZ+0.5*CryostatXYFullThickness}
#DHB_SkewBase3.Mother Cryostat_Interior

#DHB_SkewBase.Copy DHB_SkewBase4
#DHB_SkewBase4.Position {-DHB_CentStrucBase_HalfWidth-0.5715-.5715+.216} {0.3685+0.2285} {ColdfingerBasePosZ+DHB_HalfHeight+0.4395-CryoLidZ+0.5*CryostatXYFullThickness}
#DHB_SkewBase4.Mother Cryostat_Interior

#Now add the rods
# Removing the rods for now, I think the model I have is incorrent and keep getting an overlap
Volume DHB_Skewer
DHB_Skewer.Material steel_304
DHB_Skewer.Visibility 1
DHB_Skewer.Color 7
DHB_Skewer.Shape TUBS 0.0 0.1 4.972 0.0 360.0

DHB_Skewer.Copy DHB_Skewer1
DHB_Skewer1.Position {DHB_CentStrucBase_HalfWidth+0.5715+.5715-.166} {0.3685+0.4085} {ColdfingerBasePosZ+DHB_HalfHeight+2*0.5395+4.972-CryoLidZ+0.5*CryostatXYFullThickness}
DHB_Skewer1.Mother Cryostat_Interior

DHB_Skewer.Copy DHB_Skewer2
DHB_Skewer2.Position {DHB_CentStrucBase_HalfWidth+0.5715+.5715-.166} {-0.3685-0.4085} {ColdfingerBasePosZ+DHB_HalfHeight+2*0.5395+4.972-CryoLidZ+0.5*CryostatXYFullThickness}
DHB_Skewer2.Mother Cryostat_Interior

DHB_Skewer.Copy DHB_Skewer3
DHB_Skewer3.Position {-DHB_CentStrucBase_HalfWidth-0.5715-.5715+.166} {-0.3685-0.4085} {ColdfingerBasePosZ+DHB_HalfHeight+2*0.5395+4.972-CryoLidZ+0.5*CryostatXYFullThickness}
DHB_Skewer3.Mother Cryostat_Interior

DHB_Skewer.Copy DHB_Skewer4
DHB_Skewer4.Position {-DHB_CentStrucBase_HalfWidth-0.5715-0.5715+0.166} {0.3685+0.4085} {ColdfingerBasePosZ+DHB_HalfHeight+2*0.5395+4.972-CryoLidZ+0.5*CryostatXYFullThickness}
DHB_Skewer4.Mother Cryostat_Interior

#Spider
#removing for now because its causing problems
Shape BRIK SpiderBlock 
SpiderBlock.Parameters 2.0385 0.9145 0.1015
Shape TUBS Rod_Hole1
Rod_Hole1.Parameters 0.0 0.3 0.11 0.0 360.0
Orientation Rod_Hole1_Ori
Rod_Hole1_Ori.Position 1.7215 0.5975 0.0

Shape Subtraction SpiderBlockMinusHole1
SpiderBlockMinusHole1.Parameters SpiderBlock Rod_Hole1 Rod_Hole1_Ori 

Shape TUBS Rod_Hole2 
Rod_Hole2.Parameters 0.0 0.3 0.11 0.0 360.0
Orientation Rod_Hole2_Ori
Rod_Hole2_Ori.Position -1.7215 0.5975 0.0

Shape Subtraction SpiderBlockMinusHole2
SpiderBlockMinusHole2.Parameters SpiderBlockMinusHole1 Rod_Hole2 Rod_Hole2_Ori

Shape TUBS Rod_Hole3
Rod_Hole3.Parameters 0.0 0.3 0.11 0.0 360.0
Orientation Rod_Hole3_Ori
Rod_Hole3_Ori.Position 1.7215 -0.5975 0.0

Shape Subtraction SpiderBlockMinusHole3
SpiderBlockMinusHole3.Parameters SpiderBlockMinusHole2 Rod_Hole3 Rod_Hole3_Ori

Shape TUBS Rod_Hole4
Rod_Hole4.Parameters 0.0 0.3 0.11 0.0 360.0
Orientation Rod_Hole4_Ori
Rod_Hole4_Ori.Position -1.7215 -0.5975 0.0

Shape Subtraction SpiderBlockMinusHole4
SpiderBlockMinusHole4.Parameters SpiderBlockMinusHole3 Rod_Hole4 Rod_Hole4_Ori

#Removing this for now because it is causing problems
Volume DHB_Spider
DHB_Spider.Material al7075
DHB_Spider.Visibility 1
DHB_Spider.Color 7
DHB_Spider.Shape SpiderBlockMinusHole4
DHB_Spider.Position 0.0 0.0 {ColdfingerBasePosZ+DHB_HalfHeight+2*0.5395+2*4.972+0.1015-0.521-CryoLidZ+0.5*CryostatXYFullThickness+.123}
DHB_Spider.Mother Cryostat_Interior


#Now adding the four blocks around the center where the two bases meet
#This should be al7075
Volume DHB_BaseBlock
DHB_BaseBlock.Material al7075
DHB_BaseBlock.Visibility 1
DHB_BaseBlock.Color 6
DHB_BaseBlock.Shape BRIK 0.5715 0.362 0.597

DHB_BaseBlock.Copy DHB_BaseBlock1
DHB_BaseBlock1.Position { DHB_CentStrucBase_HalfWidth+0.5715}  {DHB_HalfWidth+0.362 } { ColdfingerBasePosZ-(DHB_HalfHeight-0.597)-CryoLidZ+0.5*CryostatXYFullThickness}
DHB_BaseBlock1.Mother Cryostat_Interior

DHB_BaseBlock.Copy DHB_BaseBlock2
DHB_BaseBlock2.Position { DHB_CentStrucBase_HalfWidth+0.5715}  {-DHB_HalfWidth-0.362 } { ColdfingerBasePosZ -(DHB_HalfHeight-0.597)-CryoLidZ+0.5*CryostatXYFullThickness}
DHB_BaseBlock2.Mother Cryostat_Interior


DHB_BaseBlock.Copy DHB_BaseBlock3
DHB_BaseBlock3.Position {-DHB_CentStrucBase_HalfWidth-0.5715}  {-DHB_HalfWidth-0.362 } { ColdfingerBasePosZ -(DHB_HalfHeight-0.597)-CryoLidZ+0.5*CryostatXYFullThickness}
DHB_BaseBlock3.Mother Cryostat_Interior

DHB_BaseBlock.Copy DHB_BaseBlock4
DHB_BaseBlock4.Position {-DHB_CentStrucBase_HalfWidth-0.5715}  {DHB_HalfWidth+0.362 } { ColdfingerBasePosZ -(DHB_HalfHeight-0.597)-CryoLidZ+0.5*CryostatXYFullThickness}
DHB_BaseBlock4.Mother Cryostat_Interior

#This should be bronze
Volume CagingStud
CagingStud.Material bronze_544
CagingStud.Visibility 1
CagingStud.Color 14
CagingStud.Shape TUBS 0.357 0.635 0.47 0.0 360.0

CagingStud.Copy CagingStud1
CagingStud1.Mother Cryostat_Interior
CagingStud1.Position {0.5*IRShieldX-4.6235} 0.0 {ColdfingerBasePosZ-.47-DHB_HalfHeight-CryoLidZ+0.5*CryostatXYFullThickness}

CagingStud.Copy CagingStud2
CagingStud2.Mother Cryostat_Interior
CagingStud2.Position {-0.5*IRShieldX+4.6235} 0.0 {ColdfingerBasePosZ-.47-DHB_HalfHeight-CryoLidZ+0.5*CryostatXYFullThickness}

CagingStud.Copy CagingStud3
CagingStud3.Mother Cryostat_Interior
CagingStud3.Position 0.0 {-0.5*IRShieldY+2.841} {ColdfingerBasePosZ-.47-DHB_HalfHeight-CryoLidZ+0.5*CryostatXYFullThickness}

CagingStud.Copy CagingStud4
CagingStud4.Mother Cryostat_Interior
CagingStud4.Position 0.0 {0.5*IRShieldY-2.841} {ColdfingerBasePosZ-.47-DHB_HalfHeight-CryoLidZ+0.5*CryostatXYFullThickness}

#Bellville stake assembly cage
#This should be A286 stainless steel
Volume Bellville_Assem
Bellville_Assem.Material steel_a286
Bellville_Assem.Visibility 1
Bellville_Assem.Color 12
Bellville_Assem.Shape TUBS 0.0 1.2605 0.8635 0.0 360.0
Bellville_Assem.Position {0.0} {0.0} {ColdfingerBasePosZ-2*.8635-(DHB_HalfHeight-.8635)-CryoLidZ+0.5*CryostatXYFullThickness}
Bellville_Assem.Mother Cryostat_Interior

###################################################################################################################
# The detectors

Constant DetDepth {(-CryostatOuterZ - CryoLidZ - CryoBaseStageZ)-15}

For Z  NLayers  { DetZPos }  {2.5660}
   SingleDetector.Copy SingleDetector_Copy%Z_a
   SingleDetector_Copy%Z_a.Mother Cryostat_Interior
   SingleDetector_Copy%Z_a.Rotation 0.0 0.0 180.0
   SingleDetector_Copy%Z_a.Position {DetX + DetXHalfGap} {DetY+DetYHalfGap} {$Z}

   SingleDetector.Copy SingleDetector_Copy%Z_b
   SingleDetector_Copy%Z_b.Mother Cryostat_Interior
   SingleDetector_Copy%Z_b.Rotation 180.0 0.0 180.0
   SingleDetector_Copy%Z_b.Position {DetX + DetXHalfGap} {-(DetY+DetYHalfGap)} {$Z}

   SingleDetector.Copy SingleDetector_Copy%Z_c
   SingleDetector_Copy%Z_c.Mother Cryostat_Interior
   SingleDetector_Copy%Z_c.Rotation 180.0 0.0 0.0
   SingleDetector_Copy%Z_c.Position {-DetX - DetXHalfGap} {DetY+DetYHalfGap} {$Z}

   SingleDetector.Copy SingleDetector_Copy%Z_d
   SingleDetector_Copy%Z_d.Mother Cryostat_Interior
   SingleDetector_Copy%Z_d.Rotation 0.0 0.0 0.0
   SingleDetector_Copy%Z_d.Position {-DetX-DetXHalfGap} {-(DetY+DetYHalfGap)} {$Z}
Done




##########################################################
## IR shields
# Updated by Alyson Joens on 03/04/23
#It looks like the X and Y sides of the IR shield have gotten slightly biggger(~.5 cm) in this new step file.
# Going to leave it as it was before until I verify with Brad that the dimensions have in fact changed because
# this measurement is tied to others and would require adjustment. If it has indeed changed did the dimenstions of the DHB also change?
# Using the step file COSI-SMX-SPC-MEC-000 Spectrometer Assy_Rad.STEP for the measurements of everything except the holes which I will use
# COSI-SMX-DET-MEC-320 Thermal Shield Assy.STEP for.


# Starting with the IRShield on the Y side
# Holes on the left side that start closer to the top of the shields
Shape BRIK IRShieldY_Block
IRShieldY_Block.Parameters { 0.5*IRShieldX } { 0.5 * IRShieldThickness } { 0.5 * IRShieldZ }
Shape BRIK IRShield_Hole1
IRShield_Hole1.Parameters { 0.5*IRShieldHoleX} { 0.5*IRShieldThickness+.01} {0.5*IRShieldHoleZ} 
Orientation IRShield_Hole1Ori
IRShield_Hole1Ori.Position {(0.5*IRShieldX)- (0.5*IRShieldHoleX)-2.774 } {0.0} {( 0.5 * IRShieldZ)-(0.5*IRShieldHoleZ)-0.927 }

Shape Subtraction IRShieldBlockMinusHole1
IRShieldBlockMinusHole1.Parameters IRShieldY_Block IRShield_Hole1 IRShield_Hole1Ori

Orientation IRShield_Hole2Ori
IRShield_Hole2Ori.Position {(0.5*IRShieldX)- (0.5*IRShieldHoleX)-2.774 } {0.0} {( 0.5 * IRShieldZ)-(0.5*IRShieldHoleZ)-0.927-IRShieldHoleZ-IRShieldSideY_Zspace }

Shape Subtraction IRShieldBlockMinusHole2
IRShieldBlockMinusHole2.Parameters IRShieldBlockMinusHole1 IRShield_Hole1 IRShield_Hole2Ori

Orientation IRShield_Hole3Ori
IRShield_Hole3Ori.Position {(0.5*IRShieldX)- (0.5*IRShieldHoleX)-IRShieldSideY_Xpos } {0.0} {( 0.5 * IRShieldZ)-(0.5*IRShieldHoleZ)-IRShieldSideY_Hole1_Zpos-2*IRShieldHoleZ-2*IRShieldSideY_Zspace }

Shape Subtraction IRShieldBlockMinusHole3
IRShieldBlockMinusHole3.Parameters IRShieldBlockMinusHole2 IRShield_Hole1 IRShield_Hole3Ori

Orientation IRShield_Hole4Ori
IRShield_Hole4Ori.Position {(0.5*IRShieldX)- (0.5*IRShieldHoleX)-IRShieldSideY_Xpos } {0.0} {( 0.5 * IRShieldZ )-(0.5*IRShieldHoleZ)-IRShieldSideY_Hole1_Zpos-3*IRShieldHoleZ-3*IRShieldSideY_Zspace}

Shape Subtraction IRShieldBlockMinusHole4
IRShieldBlockMinusHole4.Parameters IRShieldBlockMinusHole3 IRShield_Hole1 IRShield_Hole4Ori


# Holes on the other side that are further from the top
Orientation IRShield_Hole5Ori
IRShield_Hole5Ori.Position {-(0.5*IRShieldX)+ (0.5*IRShieldHoleX)+IRShieldSideY_Xpos } {0.0} {( 0.5 * IRShieldZ)-(0.5*IRShieldHoleZ)-IRShieldSideY_Hole2_Zpos}

Shape Subtraction IRShieldBlockMinusHole5
IRShieldBlockMinusHole5.Parameters IRShieldBlockMinusHole4 IRShield_Hole1 IRShield_Hole5Ori

Orientation IRShield_Hole6Ori
IRShield_Hole6Ori.Position {-(0.5*IRShieldX)+ (0.5*IRShieldHoleX)+IRShieldSideY_Xpos } {0.0} {( 0.5 * IRShieldZ)-(0.5*IRShieldHoleZ)-IRShieldSideY_Hole2_Zpos-IRShieldHoleZ-IRShieldSideY_Zspace}

Shape Subtraction IRShieldBlockMinusHole6
IRShieldBlockMinusHole6.Parameters IRShieldBlockMinusHole5 IRShield_Hole1 IRShield_Hole6Ori

Orientation IRShield_Hole7Ori
IRShield_Hole7Ori.Position {-(0.5*IRShieldX)+ (0.5*IRShieldHoleX)+IRShieldSideY_Xpos } {0.0} {( 0.5 * IRShieldZ)-(0.5*IRShieldHoleZ)-IRShieldSideY_Hole2_Zpos-2*IRShieldHoleZ-2*IRShieldSideY_Zspace}

Shape Subtraction IRShieldBlockMinusHole7
IRShieldBlockMinusHole7.Parameters IRShieldBlockMinusHole6 IRShield_Hole1 IRShield_Hole7Ori

Orientation IRShield_Hole8Ori
IRShield_Hole8Ori.Position {-(0.5*IRShieldX)+ (0.5*IRShieldHoleX)+IRShieldSideY_Xpos } {0.0} {( 0.5 * IRShieldZ)-(0.5*IRShieldHoleZ)-IRShieldSideY_Hole2_Zpos-3*IRShieldHoleZ-3*IRShieldSideY_Zspace}

Shape Subtraction IRShieldBlockMinusHole8
IRShieldBlockMinusHole8.Parameters IRShieldBlockMinusHole7 IRShield_Hole1 IRShield_Hole8Ori

# Small rectangular hole for the DHB_Arm to pop out
Shape BRIK IRShield_RecHole
IRShield_RecHole.Parameters {0.5*IRShield_RecHoleX} {0.5 * IRShieldThickness+.1} {0.5*IRShield_RecHoleZ}
Orientation IRShield_RecHoleOri
IRShield_RecHoleOri.Position {0.0} {0.0} { 0.5 * IRShieldZ - 0.5*IRShield_RecHoleZ}

Shape Subtraction IRShieldBlockMinusRecHole
IRShieldBlockMinusRecHole.Parameters IRShieldBlockMinusHole8 IRShield_RecHole IRShield_RecHoleOri

# Circle hole
Shape TUBS IRShield_CircHole
IRShield_CircHole.Parameters 0.0 IRShield_CircHole_Rad {0.5 * IRShieldThickness+.1} 0.0 360.0
Orientation IRShield_CircHoleOri
IRShield_CircHoleOri.Rotation 90.0 0.0 0.0
IRShield_CircHoleOri.Position {0.0} {0.0} { 0.5 * IRShieldZ-IRShield_RecHoleZ-IRShield_CircHole_Rad-IRShield_CircHole_ZPos}

Shape Subtraction IRShieldBlockMinusCircHole
IRShieldBlockMinusCircHole.Parameters IRShieldBlockMinusRecHole IRShield_CircHole IRShield_CircHoleOri

Volume IRShieldSidePosY
IRShieldSidePosY.Material al6061
IRShieldSidePosY.Visibility 01
IRShieldSidePosY.Color 15
IRShieldSidePosY.Shape IRShieldBlockMinusCircHole
#IRShieldSidePosY.Position  0 { 0.5*IRShieldY + 0.5 * IRShieldThickness} { IRShieldPosZ + 0.5* IRShieldZ -DHB_HalfHeight}
IRShieldSidePosY.Position  0 { 0.5*IRShieldY + 0.5 * IRShieldThickness} {(ColdfingerBasePosZ-DHB_HalfHeight+.5*IRShieldZ)-CryoLidZ+0.5*CryostatXYFullThickness}
IRShieldSidePosY.Mother Cryostat_Interior

Volume IRShieldSideNegY
IRShieldSideNegY.Material al6061
IRShieldSideNegY.Visibility 0
IRShieldSideNegY.Color 15
IRShieldSideNegY.Shape IRShieldBlockMinusCircHole
IRShieldSideNegY.Position  {0.0} {- 0.5*IRShieldY - 0.5 * IRShieldThickness} {(ColdfingerBasePosZ-DHB_HalfHeight+.5*IRShieldZ)-CryoLidZ+0.5*CryostatXYFullThickness}
IRShieldSideNegY.Rotation 0.0 0.0 180.0
IRShieldSideNegY.Mother Cryostat_Interior

# Now for the IR Shields on the X side
Shape BRIK IRShieldX_Block
IRShieldX_Block.Parameters { 0.5 * IRShieldThickness } { 0.5 * IRShieldY } { 0.5 * IRShieldZ }
Shape BRIK IRShieldX_Hole1
IRShieldX_Hole1.Parameters { 0.5*IRShieldThickness+.01} { 0.5*IRShieldHoleX} {0.5*IRShieldHoleZ}
Orientation IRShieldX_Hole1Ori
IRShieldX_Hole1Ori.Position {0.0} {(0.5*IRShieldX)- (0.5*IRShieldHoleX)-IRShieldSideX_Xpos} {( 0.5 * IRShieldZ)-(0.5*IRShieldHoleZ)-IRShieldSideY_Hole1_Zpos}

Shape Subtraction IRShieldBlockXMinusHole1
IRShieldBlockXMinusHole1.Parameters IRShieldX_Block IRShieldX_Hole1 IRShieldX_Hole1Ori

Orientation IRShieldX_Hole2Ori
#IRShield_Hole2Ori.Position {(0.5*IRShieldX)- (0.5*IRShieldHoleX)-2.774 } {0.0} {( 0.5 * IRShieldZ)-(0.5*IRShieldHoleZ)-0.927-IRShieldHoleZ-IRShieldSideY_Zspace }
IRShieldX_Hole2Ori.Position {0.0} {(0.5*IRShieldX)- (0.5*IRShieldHoleX)-IRShieldSideX_Xpos} {( 0.5 * IRShieldZ )-(0.5*IRShieldHoleZ)-IRShieldHoleZ-IRShieldSideY_Hole1_Zpos-IRShieldSideY_Zspace}

Shape Subtraction IRShieldBlockXMinusHole2
IRShieldBlockXMinusHole2.Parameters IRShieldBlockXMinusHole1 IRShieldX_Hole1 IRShieldX_Hole2Ori

Orientation IRShieldX_Hole3Ori
IRShieldX_Hole3Ori.Position {0.0} {(0.5*IRShieldX)- (0.5*IRShieldHoleX)-IRShieldSideX_Xpos } {( 0.5 * IRShieldZ)-(0.5*IRShieldHoleZ)-IRShieldSideY_Hole1_Zpos-2*IRShieldHoleZ-2*IRShieldSideY_Zspace }

Shape Subtraction IRShieldBlockXMinusHole3
IRShieldBlockXMinusHole3.Parameters IRShieldBlockXMinusHole2 IRShieldX_Hole1 IRShieldX_Hole3Ori

Orientation IRShieldX_Hole4Ori
IRShieldX_Hole4Ori.Position {0.0} {(0.5*IRShieldX)- (0.5*IRShieldHoleX)-IRShieldSideX_Xpos } {( 0.5 * IRShieldZ)-(0.5*IRShieldHoleZ)-IRShieldSideY_Hole1_Zpos-3*IRShieldHoleZ-3*IRShieldSideY_Zspace}

Shape Subtraction IRShieldBlockXMinusHole4
IRShieldBlockXMinusHole4.Parameters IRShieldBlockXMinusHole3 IRShieldX_Hole1 IRShieldX_Hole4Ori


# Holes on the other side that are further from the top
Orientation IRShieldX_Hole5Ori
IRShieldX_Hole5Ori.Position {0.0} {-(0.5*IRShieldX)+ (0.5*IRShieldHoleX)+IRShieldSideX_Xpos } {( 0.5 * IRShieldZ )-(0.5*IRShieldHoleZ)-IRShieldSideY_Hole2_Zpos}

Shape Subtraction IRShieldBlockXMinusHole5
IRShieldBlockXMinusHole5.Parameters IRShieldBlockXMinusHole4 IRShieldX_Hole1 IRShieldX_Hole5Ori

Orientation IRShieldX_Hole6Ori
IRShieldX_Hole6Ori.Position {0.0} {-(0.5*IRShieldX)+ (0.5*IRShieldHoleX)+IRShieldSideX_Xpos } {( 0.5 * IRShieldZ)-(0.5*IRShieldHoleZ)-IRShieldSideY_Hole2_Zpos-IRShieldHoleZ-IRShieldSideY_Zspace}

Shape Subtraction IRShieldBlockXMinusHole6
IRShieldBlockXMinusHole6.Parameters IRShieldBlockXMinusHole5 IRShieldX_Hole1 IRShieldX_Hole6Ori

Orientation IRShieldX_Hole7Ori
IRShieldX_Hole7Ori.Position {0.0} {-(0.5*IRShieldX)+ (0.5*IRShieldHoleX)+IRShieldSideX_Xpos } {( 0.5 * IRShieldZ)-(0.5*IRShieldHoleZ)-IRShieldSideY_Hole2_Zpos-2*IRShieldHoleZ-2*IRShieldSideY_Zspace}

Shape Subtraction IRShieldBlockXMinusHole7
IRShieldBlockXMinusHole7.Parameters IRShieldBlockXMinusHole6 IRShieldX_Hole1 IRShieldX_Hole7Ori

Orientation IRShieldX_Hole8Ori
IRShieldX_Hole8Ori.Position {0.0} {-(0.5*IRShieldX)+ (0.5*IRShieldHoleX)+IRShieldSideX_Xpos } {( 0.5 * IRShieldZ)-(0.5*IRShieldHoleZ)-IRShieldSideY_Hole2_Zpos-3*IRShieldHoleZ-3*IRShieldSideY_Zspace}

Shape Subtraction IRShieldBlockXMinusHole8
IRShieldBlockXMinusHole8.Parameters IRShieldBlockXMinusHole7 IRShieldX_Hole1 IRShieldX_Hole8Ori

# Circle hole
Orientation IRShieldX_CircHoleOri
IRShieldX_CircHoleOri.Rotation 0.0 90.0 0.0
IRShieldX_CircHoleOri.Position {0.0} {0.0} {-0.5*IRShieldZ  + IRShield_CircHole_Rad + IRShieldX_CircHole_Zpos}

Shape Subtraction IRShieldBlockXMinusCircHole
IRShieldBlockXMinusCircHole.Parameters IRShieldBlockXMinusHole8 IRShield_CircHole IRShieldX_CircHoleOri

Volume IRShieldSidePosX
IRShieldSidePosX.Material al6061
IRShieldSidePosX.Visibility 1
IRShieldSidePosX.Color 15
IRShieldSidePosX.Shape IRShieldBlockXMinusCircHole
IRShieldSidePosX.Rotation 0.0 0.0 180.0
IRShieldSidePosX.Position { 0.5*IRShieldX + 0.5 * IRShieldThickness} {0.0} {(ColdfingerBasePosZ-DHB_HalfHeight+.5*IRShieldZ)-CryoLidZ+0.5*CryostatXYFullThickness}
IRShieldSidePosX.Mother Cryostat_Interior

Volume IRShieldSideNegX
IRShieldSideNegX.Material al6061
IRShieldSideNegX.Visibility 1
IRShieldSideNegX.Color 15
IRShieldSideNegX.Shape IRShieldBlockXMinusCircHole
IRShieldSideNegX.Position {- 0.5*IRShieldX - 0.5 * IRShieldThickness} {0.0} {(ColdfingerBasePosZ-DHB_HalfHeight+.5*IRShieldZ)-CryoLidZ+0.5*CryostatXYFullThickness}
IRShieldSideNegX.Mother Cryostat_Interior

# Now will add tabs to the top and sides of all IR Shields, starting with the IR shields on the posX and negX side
Volume IRShieldSideX_TopTab
IRShieldSideX_TopTab.Material al6061
IRShieldSideX_TopTab.Visibility 1
IRShieldSideX_TopTab.Color 15
IRShieldSideX_TopTab.Shape BRIK IRShieldSideX_TopTabX IRShieldSideX_TopTabY {.5*IRShieldThickness}

IRShieldSideX_TopTab.Copy IRShieldSideX_TopTabNegX
#May need to remove one of the IR shield thicknesses here. Just going to do it then check
IRShieldSideX_TopTabNegX.Position {- 0.5*IRShieldX - 0.5 * IRShieldThickness+IRShieldSideX_TopTabX} {0.0} {(ColdfingerBasePosZ-DHB_HalfHeight+IRShieldZ+.5*IRShieldThickness)-CryoLidZ+0.5*CryostatXYFullThickness}
IRShieldSideX_TopTabNegX.Mother Cryostat_Interior

IRShieldSideX_TopTab.Copy IRShieldSideX_TopTabPosX
#IRShieldSideX_TopTabPosX.Position { 0.5*IRShieldX +0.5 * IRShieldThickness-IRShieldSideX_TopTabX} {0.0} {IRShieldPosZ + 0.5* IRShieldZ -IRShieldThickness-DHB_HalfHeight+ 0.5 * IRShieldZ}
IRShieldSideX_TopTabPosX.Position { 0.5*IRShieldX +0.5 * IRShieldThickness-IRShieldSideX_TopTabX} {0.0}{(ColdfingerBasePosZ-DHB_HalfHeight+IRShieldZ+.5*IRShieldThickness)-CryoLidZ+0.5*CryostatXYFullThickness}
IRShieldSideX_TopTabPosX.Mother Cryostat_Interior

#IR Shield on the Y side
Volume IRShieldSideY_TopTab
IRShieldSideY_TopTab.Material al6061
IRShieldSideY_TopTab.Visibility 1
IRShieldSideY_TopTab.Color 15
IRShieldSideY_TopTab.Shape BRIK IRShieldSideY_TopTabX IRShieldSideX_TopTabX {.5*IRShieldThickness}

IRShieldSideY_TopTab.Copy IRShieldSideY_TopTab1NegY
#IRShieldSideY_TopTab1NegY.Position {0.5*IRShieldX-IRShieldSideY_TopTabX} {- 0.5*IRShieldY - 0.5 * IRShieldThickness+IRShieldSideX_TopTabX} { IRShieldPosZ + IRShieldZ -IRShieldThickness-DHB_HalfHeight}
IRShieldSideY_TopTab1NegY.Position {0.5*IRShieldX-IRShieldSideY_TopTabX} {- 0.5*IRShieldY - 0.5 * IRShieldThickness+IRShieldSideX_TopTabX} {(ColdfingerBasePosZ-DHB_HalfHeight+IRShieldZ+.5*IRShieldThickness)-CryoLidZ+0.5*CryostatXYFullThickness}
IRShieldSideY_TopTab1NegY.Mother Cryostat_Interior

IRShieldSideY_TopTab.Copy IRShieldSideY_TopTab2NegY
IRShieldSideY_TopTab2NegY.Position {-0.5*IRShieldX+IRShieldSideY_TopTabX} {- 0.5*IRShieldY - 0.5 * IRShieldThickness+IRShieldSideX_TopTabX} {(ColdfingerBasePosZ-DHB_HalfHeight+IRShieldZ+.5*IRShieldThickness)-CryoLidZ+0.5*CryostatXYFullThickness}
IRShieldSideY_TopTab2NegY.Mother Cryostat_Interior

IRShieldSideY_TopTab.Copy IRShieldSideY_TopTab1PosY
IRShieldSideY_TopTab1PosY.Position {-0.5*IRShieldX+IRShieldSideY_TopTabX} { 0.5*IRShieldY + 0.5 * IRShieldThickness-IRShieldSideX_TopTabX} {(ColdfingerBasePosZ-DHB_HalfHeight+IRShieldZ+.5*IRShieldThickness)-CryoLidZ+0.5*CryostatXYFullThickness}
IRShieldSideY_TopTab1PosY.Mother Cryostat_Interior

IRShieldSideY_TopTab.Copy IRShieldSideY_TopTab2PosY
IRShieldSideY_TopTab2PosY.Position {0.5*IRShieldX-IRShieldSideY_TopTabX} { 0.5*IRShieldY + 0.5 * IRShieldThickness-IRShieldSideX_TopTabX} {(ColdfingerBasePosZ-DHB_HalfHeight+IRShieldZ+.5*IRShieldThickness)-CryoLidZ+0.5*CryostatXYFullThickness}
IRShieldSideY_TopTab2PosY.Mother Cryostat_Interior

# Now for the IR Shields on the bottom
Volume IRShieldSideX_BotTab
IRShieldSideX_BotTab.Material al6061
IRShieldSideX_BotTab.Visibility 1
IRShieldSideX_BotTab.Color 15
IRShieldSideX_BotTab.Shape BRIK { IRShieldSideX_BotTabX } { IRShieldSideX_TopTabY } {.5*IRShieldThickness}

IRShieldSideX_BotTab.Copy IRShieldSideX_BotTabNegX
#IRShieldSideX_BotTabNegX.Position {- 0.5*IRShieldX - 0.5 * IRShieldThickness+IRShieldSideX_BotTabX} {0.0} {- (IRShieldPosZ + IRShieldZ -IRShieldThickness+3*DHB_HalfHeight)}
IRShieldSideX_BotTabNegX.Position {- 0.5*IRShieldX - 0.5 * IRShieldThickness+IRShieldSideX_BotTabX} {0.0} {(ColdfingerBasePosZ-DHB_HalfHeight- 0.5*IRShieldThickness)-CryoLidZ+0.5*CryostatXYFullThickness}
IRShieldSideX_BotTabNegX.Mother Cryostat_Interior

IRShieldSideX_BotTab.Copy IRShieldSideX_BotTabPosX
IRShieldSideX_BotTabPosX.Position { 0.5*IRShieldX +0.5 * IRShieldThickness-IRShieldSideX_BotTabX} {0.0} {(ColdfingerBasePosZ-DHB_HalfHeight- 0.5*IRShieldThickness)-CryoLidZ+0.5*CryostatXYFullThickness}
IRShieldSideX_BotTabPosX.Mother Cryostat_Interior

#IR Shield on the bottom of the  Y side
Volume IRShieldSideY_BotTab
IRShieldSideY_BotTab.Material al6061
IRShieldSideY_BotTab.Visibility 1
IRShieldSideY_BotTab.Color 15
IRShieldSideY_BotTab.Shape BRIK {0.5*IRShieldX} IRShieldSideX_TopTabX {.5*IRShieldThickness}

IRShieldSideY_BotTab.Copy IRShieldSideY_BotTabNegY
#IRShieldSideY_BotTabNegY.Position {0.0} {- 0.5*IRShieldY - 0.5 * IRShieldThickness+IRShieldSideX_TopTabX} {-(IRShieldPosZ + IRShieldZ -IRShieldThickness+3*DHB_HalfHeight)}
IRShieldSideY_BotTabNegY.Position {0.0} {- 0.5*IRShieldY - 0.5 * IRShieldThickness+IRShieldSideX_TopTabX} {(ColdfingerBasePosZ-DHB_HalfHeight- 0.5*IRShieldThickness)-CryoLidZ+0.5*CryostatXYFullThickness}
IRShieldSideY_BotTabNegY.Mother Cryostat_Interior

IRShieldSideY_BotTab.Copy IRShieldSideY_BotTabPosY
IRShieldSideY_BotTabPosY.Position {0.0} {0.5*IRShieldY + 0.5 * IRShieldThickness - IRShieldSideX_TopTabX} {(ColdfingerBasePosZ-DHB_HalfHeight- 0.5*IRShieldThickness)-CryoLidZ+0.5*CryostatXYFullThickness}
IRShieldSideY_BotTabPosY.Mother Cryostat_Interior

#Bottom IR shield with the holes
Shape BRIK IRShieldBottom_Block
IRShieldBottom_Block.Parameters { 0.5*IRShieldX } { 0.5 * IRShieldY } {0.5 * IRShieldThickness }
Shape TUBS IRShieldBot_CentHole
IRShieldBot_CentHole.Parameters 0.0 IRShieldBot_CentHoleRad {IRShieldThickness +0.1} 0.0 360.0
Orientation IRShieldBot_CentHoleOri
IRShieldBot_CentHoleOri.Position 0.0 0.0 0.0

Shape SUBTRACTION IRShieldBotBlockMinusCentHole
IRShieldBotBlockMinusCentHole.Parameters IRShieldBottom_Block IRShieldBot_CentHole IRShieldBot_CentHoleOri

#Now the four smaller holes
Shape TUBS IRShieldBot_Hole1
IRShieldBot_Hole1.Parameters 0.0 IRShieldBot_CircsRad {IRShieldThickness +0.1} 0.0 360.0
Orientation IRShieldBot_Hole1Ori
IRShieldBot_Hole1Ori.Position {0.5*IRShieldX-4.6235} {0.0} {0.0}

Shape SUBTRACTION IRShieldBotBlockMinusCircHole1
IRShieldBotBlockMinusCircHole1.Parameters IRShieldBotBlockMinusCentHole IRShieldBot_Hole1 IRShieldBot_Hole1Ori

Orientation IRShieldBot_Hole2Ori
IRShieldBot_Hole2Ori.Position {-0.5*IRShieldX+4.6235} {0.0} {0.0}

Shape SUBTRACTION IRShieldBotBlockMinusCircHole2
IRShieldBotBlockMinusCircHole2.Parameters IRShieldBotBlockMinusCircHole1 IRShieldBot_Hole1 IRShieldBot_Hole2Ori

Orientation IRShieldBot_Hole3Ori
IRShieldBot_Hole3Ori.Position {0.0} {-0.5*IRShieldY+2.841} {0.0}

Shape SUBTRACTION IRShieldBotBlockMinusCircHole3
IRShieldBotBlockMinusCircHole3.Parameters IRShieldBotBlockMinusCircHole2 IRShieldBot_Hole1 IRShieldBot_Hole3Ori

Orientation IRShieldBot_Hole4Ori
IRShieldBot_Hole4Ori.Position {0.0} {0.5*IRShieldY-2.841} {0.0}

Shape SUBTRACTION IRShieldBotBlockMinusCircHole4
IRShieldBotBlockMinusCircHole4.Parameters IRShieldBotBlockMinusCircHole3 IRShieldBot_Hole1 IRShieldBot_Hole4Ori

#Now the rectangular hole
Shape BRIK IRShieldBot_Rec
IRShieldBot_Rec.Parameters .7935 3.175 {0.5 * IRShieldThickness+.1}
Orientation IRShieldBot_RecOri
IRShieldBot_RecOri.Position {0.5*IRShieldY-2.286-3.175} {0.5*IRShieldX-.7935-6.766} {0.0}

Shape SUBTRACTION IRShieldBotBlockMinusRecHole
IRShieldBotBlockMinusRecHole.Parameters IRShieldBotBlockMinusCircHole4 IRShieldBot_Rec IRShieldBot_RecOri

Volume IRShieldBottom
IRShieldBottom.Visibility 1
IRShieldBottom.Material IRShieldMaterial
IRShieldBottom.Color 2
IRShieldBottom.Shape IRShieldBotBlockMinusRecHole
#IRShieldBottom.Position 0 0 {(ColdfingerBasePosZ+DHB_HalfHeight+0.5 * IRShieldThickness)}
IRShieldBottom.Position 0 0 {(ColdfingerBasePosZ-DHB_HalfHeight- 1.5*IRShieldThickness)-CryoLidZ+0.5*CryostatXYFullThickness}
IRShieldBottom.Mother Cryostat_Interior

#IR Shield Top
Shape BRIK IRShieldTopBlock
IRShieldTopBlock.Parameters { 0.5*IRShieldX } { 0.5 * IRShieldY } { 0.5 * IRShieldThickness }
Shape Brik IRShieldTopHole
IRShieldTopHole.Parameters {.1971*IRShieldX} {0.1931*IRShieldY} {0.5 * IRShieldThickness+ .1}
Orientation IRShieldTopHole1Ori
IRShieldTopHole1Ori.Position {.5*IRShieldX-0.1971*IRShieldX-2.127} {0.5 * IRShieldY-.1931*IRShieldY-1.98} {0.0}

Shape Subtraction IRShieldTopMinusHole1
IRShieldTopMinusHole1.Parameters IRShieldTopBlock IRShieldTopHole IRShieldTopHole1Ori

Orientation IRShieldTopHole2Ori
IRShieldTopHole2Ori.Position {.5*IRShieldX-0.1971*IRShieldX-2.127} {-0.5 * IRShieldY+.1931*IRShieldY+1.98} {0.0}

Shape Subtraction IRShieldTopMinusHole2
IRShieldTopMinusHole2.Parameters IRShieldTopMinusHole1 IRShieldTopHole IRShieldTopHole2Ori

Orientation IRShieldTopHole3Ori
IRShieldTopHole3Ori.Position {-.5*IRShieldX+0.1971*IRShieldX+2.127} {0.5 * IRShieldY-.1931*IRShieldY-1.98} {0.0}

Shape Subtraction IRShieldTopMinusHole3
IRShieldTopMinusHole3.Parameters IRShieldTopMinusHole2 IRShieldTopHole IRShieldTopHole3Ori

Orientation IRShieldTopHole4Ori
IRShieldTopHole4Ori.Position {-.5*IRShieldX+0.1971*IRShieldX+2.127} {-0.5 * IRShieldY+.1931*IRShieldY+1.98} {0.0}

Shape Subtraction IRShieldTopMinusHole4
IRShieldTopMinusHole4.Parameters IRShieldTopMinusHole3 IRShieldTopHole IRShieldTopHole4Ori

Volume IRShieldTop
IRShieldTop.Visibility 0
IRShieldTop.Material IRShieldMaterial
IRShieldTop.Color 2
IRShieldTop.Shape IRShieldTopMinusHole4
IRShieldTop.Position 0 0 {(ColdfingerBasePosZ-DHB_HalfHeight+IRShieldZ+1.5*IRShieldThickness)-CryoLidZ+0.5*CryostatXYFullThickness}
# { IRShieldPosZ + IRShieldZ - 0.5*IRShieldThickness}
IRShieldTop.Mother Cryostat_Interior


Constant IRShieldTopGapXY { 0.5 * 1.27 }
Constant IRShieldTopHoleSizeX  10.28
Constant IRShieldTopHoleSizeY   8.44 


#Volume IRShieldTopHole
#IRShieldTopHole.Visibility 0
#IRShieldTopHole.Material IRShieldMaterial
#IRShieldTopHole.Color 2
#IRShieldTopHole.Shape Box { 0.5*IRShieldTopHoleSizeX } { 0.5 * IRShieldTopHoleSizeY } { 0.5 * IRShieldThickness }

#IRShieldTopHole.Copy IRShieldTopHoleXPlusYPlus
#IRShieldTopHoleXPlusYPlus.Position { 0.5*IRShieldTopHoleSizeX + IRShieldTopGapXY } { 0.5*IRShieldTopHoleSizeY + IRShieldTopGapXY } 0
#IRShieldTopHoleXPlusYPlus.Mother IRShieldTop

#IRShieldTopHole.Copy IRShieldTopHoleXPlusYMinus
#IRShieldTopHoleXPlusYMinus.Position { 0.5*IRShieldTopHoleSizeX + IRShieldTopGapXY } { -0.5*IRShieldTopHoleSizeY - IRShieldTopGapXY } 0
#IRShieldTopHoleXPlusYMinus.Mother IRShieldTop

#IRShieldTopHole.Copy IRShieldTopHoleXMinusYPlus
#IRShieldTopHoleXMinusYPlus.Position { - 0.5*IRShieldTopHoleSizeX - IRShieldTopGapXY } { 0.5*IRShieldTopHoleSizeY + IRShieldTopGapXY } 0
#IRShieldTopHoleXMinusYPlus.Mother IRShieldTop

#IRShieldTopHole.Copy IRShieldTopHoleXMinusYMinus
#IRShieldTopHoleXMinusYMinus.Position { - 0.5*IRShieldTopHoleSizeX - IRShieldTopGapXY } { -0.5*IRShieldTopHoleSizeY - IRShieldTopGapXY } 0
#IRShieldTopHoleXMinusYMinus.Mother IRShieldTop


# Flexure Towers

Volume FlexureTower
FlexureTower.Material al6061
FlexureTower.Visibility 1
FlexureTower.Color 51
FlexureTower.Shape BRIK 1.4 0.246 5.375

FlexureTower.Copy FlexureTower1
FlexureTower1.Position 0.0 {CryoBaseStageY-0.246-2} {-(CryostatOuterZ+CryoLidZ-0.5*CryostatXYFullThickness)+5.375}
FlexureTower1.Mother Cryostat_Interior

FlexureTower.Copy FlexureTower2
FlexureTower2.Position 0.0 {-CryoBaseStageY+0.246+2} {-(CryostatOuterZ+CryoLidZ-0.5*CryostatXYFullThickness)+5.375}
FlexureTower2.Mother Cryostat_Interior

Volume Flexure
Flexure.Material ti_5
Flexure.Visibility 1
Vlexure.Color 53
Flexure.Shape TUBE 0.0 2.125 {.315/2} 0.0 360.0

Flexure.Copy Flexure1
Flexure1.Rotation 90.0 0.0 0.0
Flexure1.Position 0.0 {CryoBaseStageY-0.246-2} {-(CryostatOuterZ+CryoLidZ-0.5*CryostatXYFullThickness)+2*5.375+2.125}
Flexure1.Mother Cryostat_Interior

Flexure.Copy Flexure2
Flexure2.Rotation 90.0 0.0 0.0
Flexure2.Position 0.0 {-CryoBaseStageY+0.246+2} {-(CryostatOuterZ+CryoLidZ-0.5*CryostatXYFullThickness)+2*5.375+2.125}
Flexure2.Mother Cryostat_Interior

Flexure.Copy Flexure3
Flexure3.Rotation 90.0 0.0 90.0
Flexure3.Position {-CryoBaseStageX+0.246+2.5} 0.0 {-(CryostatOuterZ+CryoLidZ-0.5*CryostatXYFullThickness)+2.125}
Flexure3.Mother Cryostat_Interior


Flexure.Copy Flexure4
Flexure4.Rotation 90.0 0.0 90.0
Flexure4.Position {CryoBaseStageX-0.246-2.5} 0.0 {-(CryostatOuterZ+CryoLidZ-0.5*CryostatXYFullThickness)+2.125}
Flexure4.Mother Cryostat_Interior


#moved the Ribbon Cable Guards to the ACS model


