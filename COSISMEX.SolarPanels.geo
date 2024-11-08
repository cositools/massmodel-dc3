Volume SolarArray
SolarArray.Material SC_Vacuum
SolarArray.Visibility 0
#If we dont want this to be a virtual volume then we will need to move the solar arrays ~5 cm away from the pip body so that their mother volumes don't overlap
#SolarArray.Virtual true
SolarArray.Color 6
#SolarArray.Shape PGON 0.0 360.0 6  2    -SCHeight 0.0 {SCRadius+SCSideEffectiveThickness}   {SCHeight} 0.0 {SCRadius+SCSideEffectiveThickness}
SolarArray.Shape BRIK {PanelDepth} {5*PanelWidth/2+5*PanelSeparation/2+DriveHeight/2} {PanelLength/2}

# Deployed Solar array # 
# 5 panels at equidistant separation 

# Change this to set the angle of the solar array 
Constant panel_angle 90

# Mounting point 
Constant array_drive_y {(SCRadius+SCSideEffectiveThickness)+(DriveHeight/2)}
Volume array_drive
array_drive.Color 1
array_drive.Material SC_Elect1
array_drive.Shape TRD1 {DriveLength_1/2} {DriveLength_2/2}  {DriveDepth/2} {DriveHeight/2}
array_drive.Mother SolarArray
#array_drive.Position 0 array_drive_y {SCHeight}
array_drive.Position 0 {-1*(5*PanelWidth/2+5*PanelSeparation/2)} {0.0}
array_drive.Rotation 90 {-1*panel_angle} 180

Constant array_1_y {array_drive_y+40}
Volume array_panel_1
array_panel_1.Color 3
array_panel_1.Material SC_Elect1
array_panel_1.Shape BRIK {PanelWidth/2} {PanelLength/2} {PanelDepth/2}
array_panel_1.Mother SolarArray
#array_panel_1.Position 0 array_1_y {SCHeight}
array_panel_1.Position 0 {-4*PanelWidth/2-3*PanelSeparation/2+DriveHeight/2} {0.0}
array_panel_1.Rotation panel_angle 0 90

Constant array_2_y {array_1_y+PanelWidth+PanelSeparation}
Volume array_panel_2
array_panel_2.Color 3
array_panel_2.Material SC_Elect1
array_panel_2.Shape BRIK {PanelWidth/2} {PanelLength/2} {PanelDepth/2}
array_panel_2.Mother SolarArray
#array_panel_2.Position 0 array_2_y {SCHeight}
array_panel_2.Position 0 {-2*PanelWidth/2-PanelSeparation/2+DriveHeight/2} {0.0}
array_panel_2.Rotation panel_angle 0 90

Constant array_3_y {array_2_y+PanelWidth+PanelSeparation}
Volume array_panel_3
array_panel_3.Color 3
array_panel_3.Material SC_Elect1
array_panel_3.Shape BRIK {PanelWidth/2} {PanelLength/2} {PanelDepth/2}
array_panel_3.Mother SolarArray
#array_panel_3.Position 0 array_3_y {SCHeight}
array_panel_3.Position 0 {PanelSeparation/2+DriveHeight/2} {0.0}
array_panel_3.Rotation panel_angle 0 90

Constant array_4_y {array_3_y+PanelWidth+PanelSeparation}
Volume array_panel_4
array_panel_4.Color 3
array_panel_4.Material SC_Elect1
array_panel_4.Shape BRIK {PanelWidth/2} {PanelLength/2} {PanelDepth/2}
array_panel_4.Mother SolarArray
#array_panel_4.Position 0 array_4_y {SCHeight}
array_panel_4.Position 0 {2*PanelWidth/2+3*PanelSeparation/2+DriveHeight/2} {0.0}
array_panel_4.Rotation panel_angle 0 90

Constant array_5_y {array_4_y+PanelWidth+PanelSeparation}
Volume array_panel_5
array_panel_5.Color 3
array_panel_5.Material SC_Elect1
array_panel_5.Shape BRIK {PanelWidth/2} {PanelLength/2} {PanelDepth/2}
array_panel_5.Mother SolarArray
array_panel_5.Position 0 {4*PanelWidth/2+5*PanelSeparation/2+DriveHeight/2} {0.0}
array_panel_5.Rotation panel_angle 0 90
