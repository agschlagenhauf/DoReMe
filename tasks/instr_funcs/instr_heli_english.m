fprintf('............. Displaying instructions \n');
i=0; clear tx ypos func;
func{1}=[];

i=i+1; 
	ypos{i}=yposm;
	tx{i}=['Welcome to this computer game.\n\n We will now explain it.\n\n Please use the right arrow to go forward and the left arrow to go backward.'];

i=i+1; 
	ypos{i}=yposm;
	tx{i}=['Later you will see a helicopter. Bags with money will drop from the helicopter. Your task is to catch them. Try to win as much money as possible.\n\n The money you win will turn into real payment after the experiment.'];

i=i+1;
	ypos{i}=ypost;    
    tx{i}=['The helicopter when the sky is clear:'];bag_location_inst = screenXpixels*0.5;%(rect(3)-edge_scale*2)/100 * 50;
    func{i}='Screen(''DrawTexture'',wd,background_handle); Screen(''DrawTexture'',wd,helicopter_handle,[], [bag_location_inst-heli_width/2 heli_y1 bag_location_inst+heli_width/2 heli_y2], 0, 0);';

i=i+1;
	ypos{i}=ypost;    
	tx{i}=['The joystick moves the white cursor as a bucket. You use the bucket to catch what the helicopter drops. \n\n Try to position the bucket directly under the helicopter!']; x_bucket_inst = screenXpixels*0.5;
    func{i}='Screen(''DrawTexture'',wd,background_handle); Screen(''DrawLine'',wd, txtcolor, scale_x1, scale_y1, scale_x2, scale_y2, lineWidthPix); Screen(''DrawLine'',wd, white, x_bucket_inst, screenYpixels*(scalepos-.03), x_bucket_inst, screenYpixels*(scalepos+.03), lineWidthPix*1.75);';

i=i+1; 
	ypos{i}=ypost;
	tx{i}=['You will have 3 seconds to decide. \n You will press the joystick to confirm. \n Then the bucket will turn black and stop moving.']; x_bucket_inst = screenXpixels*0.5; x_bucket_locked_inst = screenXpixels*0.6; bag_location_inst = screenXpixels*0.5;
    func{i}='Screen(''DrawTexture'',wd,background_handle); Screen(''DrawLine'',wd, txtcolor, scale_x1, scale_y1, scale_x2, scale_y2, lineWidthPix); Screen(''DrawLine'',wd, black, x_bucket_locked_inst, screenYpixels*(scalepos-.03), x_bucket_locked_inst, screenYpixels*(scalepos+.03), lineWidthPix*1.75);';
    
i=i+1; 
	ypos{i}=ypost;
	tx{i}=['Then you can see the distance between the bucket and the actual position.']; x_bucket_inst = screenXpixels*0.5; bag_location_inst = screenXpixels*0.5; x_bucket_locked_inst = screenXpixels*0.6;
    func{i}='Screen(''DrawTexture'',wd,background_handle); Screen(''DrawLine'',wd, txtcolor, scale_x1, scale_y1, scale_x2, scale_y2, lineWidthPix); Screen(''DrawLine'',wd, black, x_bucket_locked_inst, screenYpixels*(scalepos-.03), x_bucket_locked_inst, screenYpixels*(scalepos+.03), lineWidthPix*1.75); Screen(''DrawLine'',wd, red, bag_location_inst, screenYpixels*(scalepos-.03), bag_location_inst, screenYpixels*(scalepos+.03), lineWidthPix*1.75);Screen(''DrawLine'',wd, red, bag_location_inst, scale_y1, x_bucket_locked_inst, scale_y2, lineWidthPix);';

i=i+1; 
	ypos{i}=ypost;
	tx{i}=['Either the helicopter drops a money bag. \n\n When you catch it, you will be paid the money after the experiment.'];x_bucket_inst = screenXpixels*0.5; bag_location_inst = screenXpixels*0.5; bag_y_inst = (screenYpixels*scalepos)-bag_euro_height/2; x_bucket_locked_inst = screenXpixels*0.6;
    func{i}='Screen(''DrawTexture'',wd,background_handle); Screen(''DrawLine'',wd, txtcolor, scale_x1, scale_y1, scale_x2, scale_y2, lineWidthPix); Screen(''DrawLine'',wd, black, x_bucket_locked_inst, screenYpixels*(scalepos-.03), x_bucket_locked_inst, screenYpixels*(scalepos+.03), lineWidthPix*1.75); Screen(''DrawLine'',wd, red, bag_location_inst, screenYpixels*(scalepos-.03), bag_location_inst, screenYpixels*(scalepos+.03), lineWidthPix*1.75);Screen(''DrawLine'',wd, red, bag_location_inst, scale_y1, x_bucket_locked_inst, scale_y2, lineWidthPix); Screen(''DrawTexture'',wd,bag_euro_handle, [], [bag_location_inst-bag_euro_width/2 bag_y_inst-bag_euro_height/2 bag_location_inst+bag_euro_width/2 bag_y_inst+bag_euro_height/2], 0, 0)';
    
i=i+1; 
	ypos{i}=ypost;
	tx{i}=['Or the helicopter drops a sand bag. \n\n You will not get money for it. Try to catch it anyway!'];x_bucket_inst = screenXpixels*0.5; bag_location_inst = screenXpixels*0.5; bag_y_inst = (screenYpixels*scalepos)-bag_neutral_height/2; x_bucket_locked_inst = screenXpixels*0.6;
    func{i}='Screen(''DrawTexture'',wd,background_handle); Screen(''DrawLine'',wd, txtcolor, scale_x1, scale_y1, scale_x2, scale_y2, lineWidthPix); Screen(''DrawLine'',wd, black, x_bucket_locked_inst, screenYpixels*(scalepos-.03), x_bucket_locked_inst, screenYpixels*(scalepos+.03), lineWidthPix*1.75); Screen(''DrawLine'',wd, red, bag_location_inst, screenYpixels*(scalepos-.03), bag_location_inst, screenYpixels*(scalepos+.03), lineWidthPix*1.75);Screen(''DrawLine'',wd, red, bag_location_inst, scale_y1, x_bucket_locked_inst, scale_y2, lineWidthPix); Screen(''DrawTexture'',wd,bag_neutral_handle, [], [bag_location_inst-bag_neutral_width/2 bag_y_inst-bag_neutral_height/2 bag_location_inst+bag_neutral_width/2 bag_y_inst+bag_neutral_height/2], 0, 0)';    

i=i+1;
	ypos{i}=ypost;    
    tx{i}=['Usually the helicopter stays in the same place. Occasionally it moves to a new location:'];bag_location_2_inst = screenXpixels*0.8%(rect(3)-edge_scale*2)/100 * 50;
    func{i}='Screen(''DrawTexture'',wd,background_handle); Screen(''DrawTexture'',wd,helicopter_handle,[], [bag_location_2_inst-heli_width/2 heli_y1 bag_location_2_inst+heli_width/2 heli_y2], 0, 0);';
  
i=i+1;
	ypos{i}=yposm;    
    tx{i}=['When the sky is cloudy everything else works the same way. Give it a try!'];
    func{i}='Screen(''DrawTexture'',wd,background_handle); Screen(''DrawTexture'',wd,clouds_handle,[],[0 0 screenXpixels clouds_height]); Screen(''DrawLine'',wd, txtcolor, scale_x1, scale_y1, scale_x2, scale_y2, lineWidthPix); Screen(''DrawLine'',wd, white, x_bucket_inst, screenYpixels*(scalepos-.03), x_bucket_inst, screenYpixels*(scalepos+.03), lineWidthPix*1.75);';

i=i+1; 
	ypos{i}=yposm;
	tx{i}=['Practice 1'];
    func{i}='Screen(''FillRect'',wd,white);'

page=1;
instr_display;

for nt      = 1:5
    heli_trial
end

i=i+1; 
	ypos{i}=yposm;
	tx{i}=['Practice 2'];
    func{i}='Screen(''FillRect'',wd,white);'
    
page=i;    
instr_display;
for nt      = 6:10
    heli_trial
end

i=i+1; 
	ypos{i}=yposm;
	tx{i}=['Practice 3'];
    func{i}='Screen(''FillRect'',wd,white);'

page=i;     
instr_display;