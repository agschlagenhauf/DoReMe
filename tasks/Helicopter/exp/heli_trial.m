% Heli Task adapted from Reversal
% July 2019
% Lara Wieland

% experimentally manipulated variables:
% 1. bag_location(nt): generative mean
% 2. x_bucket_start(nt): position from trial before
% 3. catch_trial(nt): clouds or none
% 4. bag_type(nt): reward or neutral

%% preparations
x_bucket = x_bucket_start(nt); % positions of bucket on the rating scale at x=0
SetMouse(x_bucket,0, wd); % positions the mouse cursor at x_bucket location
 
%% loop for each trial

    % First prediction phase: Draw background
    Screen('DrawTexture',wd,background_handle);
   
    % Draw only heli in catch trials and only clouds in non-catch trials
    if catch_trial(nt) == 0; Screen('DrawTexture',wd,clouds_handle,[],[0 0 screenXpixels clouds_height]); end
    if catch_trial(nt) == 1; Screen('DrawTexture',wd,helicopter_handle,[], [bag_location(nt)-heli_width/2 heli_y1 bag_location(nt)+heli_width/2 heli_y2], 0, 0); end
    Screen('DrawLine',wd, txtcolor, scale_x1, scale_y1, scale_x2, scale_y2, lineWidthPix);  % draw rating scale
    Screen('DrawLine',wd, white, x_bucket, screenYpixels*(scalepos-.03), x_bucket, screenYpixels*(scalepos+.03), lineWidthPix*1.75); % draw bucket
    
    [T.TrialOnset(nt),RatingOnsetTime(nt)] = Screen(wd, 'Flip'); 
    VBLTimestamp = T.TrialOnset(nt); 
    RatingTimeOut = RatingOnsetTime(nt) + Z.rating_duration; % gives max 60s to make rating
    
    resp = 0;
 
    %%%%%%%%%%%%%%%%%%%% get resonse i.e. bucket position %%%%%%%%%%%%%%%%%%%% 

    while GetSecs < RatingTimeOut
          
        [keyIsDown, secs, keyCode] = KbCheck; % check whether a keyboard response is made
        [input_position_x, my, input_button] = GetMouse(wd);

        x_bucket = input_position_x; % log response with mouse button
        
        % don't let the vertical bar go further than the edges
            if x_bucket < scale_x1
                x_bucket = scale_x1;
            elseif x_bucket > scale_x2
                x_bucket = scale_x2;
            end

        if input_button(1) == 1
            T.Response(nt)=GetSecs;
            RT(nt) = (T.Response(nt) - T.TrialOnset(nt)); % compute reaction time RT in secs
            
       
            % don't let the vertical bar go further than the edges
            if x_bucket < scale_x1
                x_bucket = scale_x1;
            elseif x_bucket > scale_x2
                x_bucket = scale_x2;
            end

            %%%%%%%%%%%%%%%%%%%%%  bag falls %%%%%%%%%%%%%%%%%%%% 
            bag_y = heli_y2;
            BagDropTimeOut = T.Response(nt)+Z.TimeBagDrop; % in expparams predefined TimeBagDrop + current timing
            i=1;
            while GetSecs < BagDropTimeOut 
                bag_y = heli_y2 + (scale_y1-heli_y2-bag_euro_height/2)*((GetSecs-T.Response(nt))/Z.TimeBagDrop); %here it becomes important that both bags have same size
                Screen('DrawTexture',wd,background_handle);
                if catch_trial(nt) == 0; Screen('DrawTexture',wd,clouds_handle,[],[0 0 screenXpixels clouds_height]); end
                if catch_trial(nt) == 1; Screen('DrawTexture',wd,helicopter_handle,[], [bag_location(nt)-heli_width/2 heli_y1 bag_location(nt)+heli_width/2 heli_y2], 0, 0); end
                Screen('DrawLine',wd, txtcolor, scale_x1, scale_y1, scale_x2, scale_y2, lineWidthPix);  % draw rating scale
                Screen('DrawLine',wd, black, x_bucket, screenYpixels*(scalepos-.03), x_bucket, screenYpixels*(scalepos+.03), lineWidthPix*1.75); % input response on rating scale                       
                if bag_type(nt) == 1
                            Screen('DrawTexture',wd,bag_neutral_handle, [], [bag_location(nt)-bag_neutral_width/2 bag_y-bag_neutral_height/2 bag_location(nt)+bag_neutral_width/2 bag_y+bag_neutral_height/2], 0, 0);                
                elseif bag_type(nt) == 2
                            Screen('DrawTexture',wd,bag_euro_handle, [], [bag_location(nt)-bag_euro_width/2 bag_y-bag_euro_height/2 bag_location(nt)+bag_euro_width/2 bag_y+bag_euro_height/2], 0, 0);               
                end
                VBLTimestamp  = Screen('Flip', wd, VBLTimestamp + (waitframes - 0.5) * ifi);
                if i==1; T.BagDropBeginn(nt) = VBLTimestamp; end
                i=i+1;
             end % while    
             T.BagDropEnd(nt) = GetSecs;
             
             %%%%%%%%%%%%%%%%%%%% feedback screen %%%%%%%%%%%%%%%%%%%% 
             % draw background
                Screen('DrawTexture',wd,background_handle);
                if catch_trial(nt) == 0; Screen('DrawTexture',wd,clouds_handle,[],[0 0 screenXpixels clouds_height]); end
                if catch_trial(nt) == 1; Screen('DrawTexture',wd,helicopter_handle,[], [bag_location(nt)-heli_width/2 heli_y1 bag_location(nt)+heli_width/2 heli_y2], 0, 0); end
             % draw rating scale
                Screen('DrawLine',wd, txtcolor, scale_x1, scale_y1, scale_x2, scale_y2, lineWidthPix); 
             % draw response / locked bucket
                Screen('DrawLine', wd, black, x_bucket, screenYpixels*(scalepos-.03), x_bucket, screenYpixels*(scalepos+.03), lineWidthPix*1.75); % draw bar to move
             
             % if caught draw bag 
             if (x_bucket > bag_location(nt)-bucket_size/2) && (x_bucket < bag_location(nt)+bucket_size/2) % bag caught
                    if bag_type(nt) == 1
                                Screen('DrawTexture',wd,bag_neutral_bright_handle, [], [bag_location(nt)-bag_neutral_bright_width/2 bag_y-bag_neutral_bright_height/2 bag_location(nt)+bag_neutral_bright_width/2 bag_y+bag_neutral_bright_height/2], 0, 0);                
                                % add pleasant sound feedback if neutral bag caught
                                PsychPortAudio('FillBuffer', pahandle,beep2);
                                PsychPortAudio('Start', pahandle, repetitions, startCue, waitForDeviceStart);
                                bag_caught(nt) = 1; 
                    elseif bag_type(nt) == 2
                                % add cash sound feedback if money caught
                                Screen('DrawTexture',wd,bag_euro_bright_handle, [], [bag_location(nt)-bag_euro_bright_width/2 bag_y-bag_euro_bright_height/2 bag_location(nt)+bag_euro_bright_width/2 bag_y+bag_euro_bright_height/2], 0, 0);
                                PsychPortAudio('FillBuffer', pahandle,beep2);
                                PsychPortAudio('Start', pahandle, repetitions, startCue, waitForDeviceStart);
                                bag_caught(nt) = 1;   
                    end
                    
             % and redraw locked bucket
                    Screen('DrawLine', wd, black, x_bucket, screenYpixels*(scalepos-.03), x_bucket, screenYpixels*(scalepos+.03), lineWidthPix*1.75); % draw bar to move             
    
                
             elseif (x_bucket < bag_location(nt)-bucket_size/2) || (x_bucket > bag_location(nt)+bucket_size/2)   % non caught
                 % add unpleasant sound feedback if not caught
                 PsychPortAudio('FillBuffer', pahandle,beep1);
                 PsychPortAudio('Start', pahandle, repetitions, startCue, waitForDeviceStart);
                 bag_caught(nt) = 0;   
             end
                
             % plot PE line
                Screen('DrawLine',wd, red, bag_location(nt), screenYpixels*(scalepos-.03), bag_location(nt), screenYpixels*(scalepos+.03), lineWidthPix*1.75);                  
                Screen('DrawLine',wd, red, bag_location(nt), scale_y1, x_bucket, scale_y2, lineWidthPix); 
                T.FeedbackOnset(nt) = Screen('Flip',wd);
                WaitSecs(Z.fb_duration)
                T.FeedbackOffset(nt) = GetSecs;
                
                break
                
        elseif keyCode(escapeKey)
        error('Escape key pressed.');
           
     
        end % if mouse button
        
%         % don't let the vertical bar go further than the edges
%         if x_bucket < scale_x1
%         	x_bucket = scale_x1;
%         elseif x_bucket > scale_x2
%         	x_bucket = scale_x2;
%         end
        
        % draw white bucket if no response was made
        Screen('DrawTexture',wd,background_handle);
        if catch_trial(nt) == 0; Screen('DrawTexture',wd,clouds_handle,[],[0 0 screenXpixels clouds_height]); end
        if catch_trial(nt) == 1; Screen('DrawTexture',wd,helicopter_handle,[], [bag_location(nt)-heli_width/2 heli_y1 bag_location(nt)+heli_width/2 heli_y2], 0, 0); end
        Screen('DrawLine',wd, txtcolor, scale_x1, scale_y1, scale_x2, scale_y2, lineWidthPix); % draw rating scale 
        Screen('DrawLine', wd, white, x_bucket, screenYpixels*(scalepos-.03), x_bucket, screenYpixels*(scalepos+.03), lineWidthPix*1.75); % draw bucket
        VBLTimestamp  = Screen('Flip', wd, VBLTimestamp + (waitframes - 0.5) * ifi);
    end  % while

%% saves all variables as NaNs when no response and trialwise if response
    
if  input_button(1) == 0  % no response made within TimeWindow
    T.Response(nt)= NaN;
    position_bucket(nt) = NaN;
    heli_rating(nt) = NaN; 
    RT(nt)=NaN;
    x_bucket_start(nt+1) = screenXpixels/2; % lets heli starts at the middle of screen
    bag_caught(nt) = NaN;
    
    Screen('FillRect', wd, grey)
    DrawFormattedText(wd,'Zu langsam!','center', 'center',txtcolor,40,[],[]);
    T.TooSlowOnset(nt) = Screen('Flip', wd);
    WaitSecs(Z.TooSlow);  
else
    position_bucket(nt) = x_bucket; 
    x_bucket_start(nt+1)= x_bucket; 
	heli_rating(nt) = bag_location(nt)-((-1)*x_bucket);  
end
%% fixation cross commented out for now
    Screen('DrawTexture',wd,background_handle);
%     Screen('DrawLine',wd, txtcolor, scale_x1, scale_y1, scale_x2, scale_y2, lineWidthPix);  % draw rating scale
    if catch_trial(nt) == 0; Screen('DrawTexture',wd,clouds_handle,[],[0 0 screenXpixels clouds_height]); end
%     Screen('DrawLines', wd, allCoords, lineWidthPix, crosscolor_iti, [xCenter yCenter], 2); % draw fixation cross
    T.ITIOnset(nt) = Screen('Flip', wd);
    if isnan(RT(nt)); WaitSecs(Z.ITI(nt)); else WaitSecs(Z.ITI(nt) + Z.rating_duration-RT(nt)); end 
    T.ITIOffset(nt) = GetSecs;  