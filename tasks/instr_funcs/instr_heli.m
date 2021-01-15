fprintf('............. Displaying instructions \n');
i=0; clear tx ypos func;
func{1}=[];

i=i+1; 
	ypos{i}=yposm;
	tx{i}=['Willkommen zu diesem Computerspiel.\n\n Wir werden es Ihnen jetzt erklären.\n\n Benutzen Sie bitte die rechte Pfeiltaste, um vorwärts zu blättern und die linke Pfeiltaste, um zurück zu blättern.'];

i=i+1; 
	ypos{i}=yposm;
	tx{i}=['Sie werden gleich einen Helikopter sehen. Der Helikopter wirft manchmal Geldsäcke ab. Ihre Aufgabe ist es diese zu fangen. Versuchen Sie so viel Geld wie möglich zu gewinnen.\n\n Ihren Geldgewinn bekommen Sie am Ende ausgezahlt!'];

i=i+1;
	ypos{i}=ypost;    
    tx{i}=['Der Helikopter bei klarem Himmel:'];bag_location_inst = screenXpixels*0.5;%(rect(3)-edge_scale*2)/100 * 50;
    func{i}='Screen(''DrawTexture'',wd,background_handle); Screen(''DrawTexture'',wd,helicopter_handle,[], [bag_location_inst-heli_width/2 heli_y1 bag_location_inst+heli_width/2 heli_y2], 0, 0);';

i=i+1;
	ypos{i}=ypost;    
	tx{i}=['Der Joystick steuert den weißen Cursor als Eimer. Damit fangen Sie auf, was der Helikopter abwirft. \n\n Versuchen Sie später den Eimer direkt unter dem Helikopter zu positionieren']; x_bucket_inst = screenXpixels*0.5;
    func{i}='Screen(''DrawTexture'',wd,background_handle); Screen(''DrawLine'',wd, txtcolor, scale_x1, scale_y1, scale_x2, scale_y2, lineWidthPix); Screen(''DrawLine'',wd, white, x_bucket_inst, screenYpixels*(scalepos-.03), x_bucket_inst, screenYpixels*(scalepos+.03), lineWidthPix*1.75);';

i=i+1; 
	ypos{i}=ypost;
	tx{i}=['Sie haben später 3 Sekunden, um sich für eine Position zu entscheiden. \n Sie werden dann den Joystick drücken, um die Entscheidung zu bestätigen. \n Dann wird der Eimer schwarz und lässt sich nicht mehr bewegen.']; x_bucket_inst = screenXpixels*0.5; x_bucket_locked_inst = screenXpixels*0.6; bag_location_inst = screenXpixels*0.5;
    func{i}='Screen(''DrawTexture'',wd,background_handle); Screen(''DrawLine'',wd, txtcolor, scale_x1, scale_y1, scale_x2, scale_y2, lineWidthPix); Screen(''DrawLine'',wd, black, x_bucket_locked_inst, screenYpixels*(scalepos-.03), x_bucket_locked_inst, screenYpixels*(scalepos+.03), lineWidthPix*1.75);';
    
i=i+1; 
	ypos{i}=ypost;
	tx{i}=['Dann sehen Sie den Abstand zwischen Eimer und tatsächlicher Position:']; x_bucket_inst = screenXpixels*0.5; bag_location_inst = screenXpixels*0.5; x_bucket_locked_inst = screenXpixels*0.6;
    func{i}='Screen(''DrawTexture'',wd,background_handle); Screen(''DrawLine'',wd, txtcolor, scale_x1, scale_y1, scale_x2, scale_y2, lineWidthPix); Screen(''DrawLine'',wd, black, x_bucket_locked_inst, screenYpixels*(scalepos-.03), x_bucket_locked_inst, screenYpixels*(scalepos+.03), lineWidthPix*1.75); Screen(''DrawLine'',wd, red, bag_location_inst, screenYpixels*(scalepos-.03), bag_location_inst, screenYpixels*(scalepos+.03), lineWidthPix*1.75);Screen(''DrawLine'',wd, red, bag_location_inst, scale_y1, x_bucket_locked_inst, scale_y2, lineWidthPix);';

i=i+1; 
	ypos{i}=ypost;
	tx{i}=['Entweder wirft der Helikopter einen Sack mit Geld ab. \n\n Wenn Sie diesen fangen, bekommen Sie das Geld nach Spielende ausgezahlt.'];x_bucket_inst = screenXpixels*0.5; bag_location_inst = screenXpixels*0.5; bag_y_inst = (screenYpixels*scalepos)-bag_euro_height/2; x_bucket_locked_inst = screenXpixels*0.6;
    func{i}='Screen(''DrawTexture'',wd,background_handle); Screen(''DrawLine'',wd, txtcolor, scale_x1, scale_y1, scale_x2, scale_y2, lineWidthPix); Screen(''DrawLine'',wd, black, x_bucket_locked_inst, screenYpixels*(scalepos-.03), x_bucket_locked_inst, screenYpixels*(scalepos+.03), lineWidthPix*1.75); Screen(''DrawLine'',wd, red, bag_location_inst, screenYpixels*(scalepos-.03), bag_location_inst, screenYpixels*(scalepos+.03), lineWidthPix*1.75);Screen(''DrawLine'',wd, red, bag_location_inst, scale_y1, x_bucket_locked_inst, scale_y2, lineWidthPix); Screen(''DrawTexture'',wd,bag_euro_handle, [], [bag_location_inst-bag_euro_width/2 bag_y_inst-bag_euro_height/2 bag_location_inst+bag_euro_width/2 bag_y_inst+bag_euro_height/2], 0, 0)';
    
i=i+1; 
	ypos{i}=ypost;
	tx{i}=['Oder der Helikopter wirft einen Sandsack ab. \n\n Dafür bekommen Sie kein Geld. Versuchen Sie trotzdem ihn zu fangen.'];x_bucket_inst = screenXpixels*0.5; bag_location_inst = screenXpixels*0.5; bag_y_inst = (screenYpixels*scalepos)-bag_neutral_height/2; x_bucket_locked_inst = screenXpixels*0.6;
    func{i}='Screen(''DrawTexture'',wd,background_handle); Screen(''DrawLine'',wd, txtcolor, scale_x1, scale_y1, scale_x2, scale_y2, lineWidthPix); Screen(''DrawLine'',wd, black, x_bucket_locked_inst, screenYpixels*(scalepos-.03), x_bucket_locked_inst, screenYpixels*(scalepos+.03), lineWidthPix*1.75); Screen(''DrawLine'',wd, red, bag_location_inst, screenYpixels*(scalepos-.03), bag_location_inst, screenYpixels*(scalepos+.03), lineWidthPix*1.75);Screen(''DrawLine'',wd, red, bag_location_inst, scale_y1, x_bucket_locked_inst, scale_y2, lineWidthPix); Screen(''DrawTexture'',wd,bag_neutral_handle, [], [bag_location_inst-bag_neutral_width/2 bag_y_inst-bag_neutral_height/2 bag_location_inst+bag_neutral_width/2 bag_y_inst+bag_neutral_height/2], 0, 0)';    

i=i+1;
	ypos{i}=ypost;    
    tx{i}=['Normalerweise bleibt der Helikopter ungefähr an der gleichen Stelle. Manchmal ändert er aber \n auch völlig den Ort:'];bag_location_2_inst = screenXpixels*0.8%(rect(3)-edge_scale*2)/100 * 50;
    func{i}='Screen(''DrawTexture'',wd,background_handle); Screen(''DrawTexture'',wd,helicopter_handle,[], [bag_location_2_inst-heli_width/2 heli_y1 bag_location_2_inst+heli_width/2 heli_y2], 0, 0);';
    
i=i+1;
	ypos{i}=yposm;    
    tx{i}=['Bei wolkigem Himmel funktioniert alles genauso. Probieren Sie mal!'];
    func{i}='Screen(''DrawTexture'',wd,background_handle); Screen(''DrawTexture'',wd,clouds_handle,[],[0 0 screenXpixels clouds_height]); Screen(''DrawLine'',wd, txtcolor, scale_x1, scale_y1, scale_x2, scale_y2, lineWidthPix); Screen(''DrawLine'',wd, white, x_bucket_inst, screenYpixels*(scalepos-.03), x_bucket_inst, screenYpixels*(scalepos+.03), lineWidthPix*1.75);';

i=i+1; 
	ypos{i}=yposm;
	tx{i}=['Uebung 1'];
    func{i}='Screen(''FillRect'',wd,white);'

page=1;
instr_display_heli;

for nt      = 1:5
    heli_trial
end

i=i+1; 
	ypos{i}=yposm;
	tx{i}=['Uebung 2'];
    func{i}='Screen(''FillRect'',wd,white);'
    
page=i;    
instr_display_heli;
for nt      = 6:10
    heli_trial
end

i=i+1; 
	ypos{i}=yposm;
	tx{i}=['Uebung 3'];
    func{i}='Screen(''FillRect'',wd,white);'

page=i;     
instr_display_heli;