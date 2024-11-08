# Original ACT space craft - modified for COSI

Include COSISMEX.GlobalDimensions.geo



Volume SCbody
SCbody.Material SC_Vacuum
SCbody.Visibility 1
SCbody.Shape PGON 0.0 360.0 6  2    0.0 0.0 SCRadius   50.0 0.0 SCRadius  

Volume SCouter
SCouter.Material SC_Al80St10Cu10_Dens281
SCouter.Shape PGON 0.0  360.0  6  6   0.0 0.0 SCRadius   SCBottomEffectiveThickness 0.0 SCRadius    SCBottomEffectiveThickness { SCRadius - SCSideEffectiveThickness } SCRadius    { SCHeight - SCTopEffectiveThickness } { SCRadius - SCSideEffectiveThickness } SCRadius    { SCHeight - SCTopEffectiveThickness } 0.0 SCRadius    SCHeight 0.0 SCRadius
#SCouter.Shape PGON 0.0  360.0  6  6   0.0 0.0 SCRadius  0.4 0.0 SCRadius   0.4 52.0 SCRadius   48 52.0 SCRadius    48 0.0 52.18    50.0 0.0 SCRadius
SCouter.Visibility 1
SCouter.Color 1
SCouter.Mother SCbody
SCouter.Position 0.0 0.0 0.0


# Holes in the top deck

Volume TopDeckRoundHole
TopDeckRoundHole.Material vacuum
TopDeckRoundHole.Visibility 1
TopDeckRoundHole.Color 1
TopDeckRoundHole.Shape TUBS 0 BGOBottomRoundHoleRadius { SCTopEffectiveThickness / 2.0 }
TopDeckRoundHole.Mother SCouter
TopDeckRoundHole.Position { -BGOBottomRoundHoleRadius - 0.1 } 0.0 { SCHeight - SCTopEffectiveThickness / 2.0 }

Volume TopDeckSquareHole
TopDeckSquareHole.Material vacuum
TopDeckSquareHole.Visibility 1
TopDeckSquareHole.Color 1
TopDeckSquareHole.Shape BRIK BGOBottomDogHouseHoleHalfXY BGOBottomDogHouseHoleHalfXY { SCTopEffectiveThickness / 2.0 }
TopDeckSquareHole.Mother SCouter
TopDeckSquareHole.Position 5.0 5.0 { SCHeight - SCTopEffectiveThickness/ 2.0 }


# COSI crycooler and dog house:

Include COSISMEX.Cryocooler.geo

Cryocooler.Position 13.0 6.0 { SCHeight - SCTopEffectiveThickness - 4.55 }
Cryocooler.Rotation 90 90 270
Cryocooler.Mother SCbody



// cryocooler (4kg for 2 coolers, random box)


Volume Cooler
Cooler.Visibility 1
Cooler.Color 4
Cooler.Material al6061
Cooler.Shape BRIK 10.0 4.631  4.0
Cooler.Mother SCbody
Cooler.Position 0.0 45.0  40.0


// these electronics total weight estimates are based on
// McBride numbers from May 15, 2007

// ACTEL & DSP boxes (4 kg electronics goo total)
// less than 10 cm below the BGO at the bottom

Volume ACTELaDSP
ACTELaDSP.Visibility 1
ACTELaDSP.Color 4
ACTELaDSP.Material Elect
ACTELaDSP.Shape BRIK 20.0  2.5 10.0
ACTELaDSP.Mother SCbody
ACTELaDSP.Position 0.0 35.0 32.0



// cabling assuming 50 cm on average between ASIC and ACTEL
// place this block between ACTELaDSP and BGO ... until we do 
// a more realistic geometry where ASICs etc are better 
// accounted for ... (currently block below cryostat above BGO ...)
// total weight for 50cm: 3960g 
// 50% of this is placed inside BGO, other 50% here
// Elect is not the BEST material for this ... but best we have

Volume Cables
Cables.Visibility 1
Cables.Color 4
Cables.Material Elect
Cables.Shape BRIK 25.0  15.0 1.0
Cables.Mother SCbody
Cables.Position 0.0 33.0 46.0 

// from Peter Berg's "assume RHESSI volume at density 1" - 2400g

Volume CryoPower
CryoPower.Visibility 1
CryoPower.Color 4
CryoPower.Material SC_Elect1
CryoPower.Shape BRIK 10.0 5.0 1.5
CryoPower.Mother SCbody
CryoPower.Position 0.0 40.0 18.0



Volume InstrumentPower
InstrumentPower.Visibility 1
InstrumentPower.Color 4
InstrumentPower.Material SC_Elect1
InstrumentPower.Shape BRIK 10.0 5.0 1.5
InstrumentPower.Mother SCbody
InstrumentPower.Position 0.0 40.0 12.0


Volume IDPU
IDPU.Visibility 1
IDPU.Color 4
IDPU.Material SC_Elect1
IDPU.Shape BRIK 5.0 5.0 1.0
IDPU.Mother SCbody
IDPU.Position 0.0 40.0 7.5

Volume PlasticBGOelectr
PlasticBGOelectr.Visibility 1
PlasticBGOelectr.Color 4
PlasticBGOelectr.Material SC_Elect1
PlasticBGOelectr.Shape BRIK 5.0 10.0 1.0
PlasticBGOelectr.Mother SCbody
PlasticBGOelectr.Position 0.0 40.0 5.0


///// rough SC components


Volume AspectControlMechanical
AspectControlMechanical.Visibility 1
AspectControlMechanical.Color 3
AspectControlMechanical.Material SC_Al80St10Cu10_Dens281
AspectControlMechanical.Shape BRIK 5.0 9.5 5.0
AspectControlMechanical.Mother SCbody
AspectControlMechanical.Position 40.0 0.0 40.0



Volume AspectControlElectronics
AspectControlElectronics.Visibility 1
AspectControlElectronics.Color 3
AspectControlElectronics.Material SC_Elect1
AspectControlElectronics.Shape BRIK 5.0 7.5 11.4
AspectControlElectronics.Mother SCbody
AspectControlElectronics.Position 0.0 -40.0 36.0


Volume PowerElectronicsSC
PowerElectronicsSC.Visibility 1
PowerElectronicsSC.Color 3
PowerElectronicsSC.Material SC_Elect1
PowerElectronicsSC.Shape BRIK 20.0 5.0 4.74
PowerElectronicsSC.Mother SCbody 
PowerElectronicsSC.Position 0.0 -40.0 15.0

// battery apparently 50% nickel, 50% Ni(OH)2 by mass according to some IEEE article I found on the www ... so:
// density of Ni(OH)2 unknown ... so I'll put in something arbitrary (same as Ni, 8.8 g/cm3) 

Volume Battery1
Battery1.Visibility 1
Battery1.Color 3
Battery1.Material NiH2
Battery1.Shape BRIK  10.0 10.0 2.53
Battery1.Mother SCbody 
Battery1.Position 40.0 0.0 25.0 

Volume Battery2
Battery22.Visibility 1
Battery2.Color 3
Battery2.Material nickel
Battery2.Shape BRIK  10.0 10.0 3.53
Battery2.Mother SCbody
Battery2.Position 30.0 0.0 17.0 

Volume CaDH
CaDH.Visibility 1
CaDH.Color 3
CaDH.Material SC_Elect1
CaDH.Shape BRIK  20.0 13.162 4.0
CaDH.Mother SCbody
CaDH.Position 25.0 0.0 6.0

Volume RFcomm
RFcomm.Visibility 1
RFcomm.Color 3
RFcomm.Material SC_Elect1
RFcomm.Shape BRIK 5.0 10.0 8
RFcomm.Mother SCbody
RFcomm.Position -40.0 0.0 38.0

Volume MiscThermal
MiscThermal.Visibility 1
MiscThermal.Color 3
MiscThermal.Material SC_Elect1
MiscThermal.Shape BRIK 6.0 15.0 5.0
MiscThermal.Mother SCbody
MiscThermal.Position -40.0 0.0 22.0

Volume Harness
Harness.Visibility 1
Harness.Color 3
Harness.Material electr   // density 10
Harness.Shape BRIK  1.834 1.834  20.0
Harness.Mother SCbody
Harness.Position -10.0 0.0 24.0 














