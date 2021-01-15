%% Lostrommel Task adapted from AdaptivePE_task by Kelly Diederen
% February 2020
% Lara Wieland

%% Open file for writing data out
  
outfile = fopen(fullfile(datadir,outputname),'a'); % open a file for writing data out

% establish header in first trial
if i == 1
fprintf(outfile,'subid\t trial\t block\t startPred\t prediction\t reward\t PE\t RTpred\t SD\t EV\t BeginITI\t CueOnset\t LogPrediction\t Feedback\t OnsetTooSlow\t BaselineStart\t \n'); %add \baseline_start
end

% needs to match the following at the bottom of each trial:
%  fprintf(outfile, '%s\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t \n', ...
             % subid, i, num2str(run), inY, B, reward, (reward - B), (round(timepred - timestartP,2)), ...
             % run1(i,2), run1(i,3), T.BeginITI(i), T.CueOnset(i), T.LogPrediction(i), T.Feedback(i), T.OnsetTooSlow(i));
  
%% Initial fixation cross
    Screen('FillRect', window, background_color);
    DrawFormattedText(window,'+','center','center',black_color);
    T.BeginITI(i) = Screen(window,'Flip');
    pause(ITI(i)); % 
    
%% Show SD cues (CAVE this is where variable 'blocks' comes from counterbalance and is ~= 'blocks' in WS
Screen('FillRect', window, background_color);
     if run == 1
         if run1(i,2) == 5
            Screen('DrawTexture', window,textS,[],[xmiddle/1.1 ymiddle/1.4  xmiddle/0.9375 ymiddle/.8]);
         elseif run1(i,2) == 15
            Screen('DrawTexture', window,textL,[],[xmiddle/1.1 ymiddle/1.4  xmiddle/0.9375 ymiddle/.8]);
         end
   
        T.CueOnset(i) = Screen (window,'Flip');
        pause(Z.cue_display_time);
        
     elseif run == 2
         if run2(i,2) == 5
            Screen('DrawTexture', window,textS,[],[xmiddle/1.1 ymiddle/1.4  xmiddle/0.9375 ymiddle/.8]);
         elseif run2(i,2) == 15
            Screen('DrawTexture', window,textL,[],[xmiddle/1.1 ymiddle/1.4  xmiddle/0.9375 ymiddle/.8]);
         end
         
        T.CueOnset(i) = Screen (window,'Flip');
        pause(Z.cue_display_time);
        
     elseif doinstr == 1 % for practice session
         if blocks(i,7)<= 55  %these are adapted to n = 1-10 of block 7, just to make participants accustomed with cues
            Screen('DrawTexture', window,textS,[],[xmiddle/1.1 ymiddle/1.4  xmiddle/0.9375 ymiddle/.8]);
         elseif blocks(i,7) >= 56 
            Screen('DrawTexture', window,textL,[],[xmiddle/1.1 ymiddle/1.4  xmiddle/0.9375 ymiddle/.8]);
         end
      
        T.CueOnset(i) = Screen (window,'Flip');
        pause(Z.cue_display_time);
     end % doscanner = or ~=1

%% Fixation cross
    DrawFormattedText(window,'+','center','center',black_color);
    T.CueOffset(i) = Screen (window,'Flip');
    pause(Z.fixation_cross_time_post_cue); % indicates length of initial fixation cross        

%% Prediction indication phase
    
    % draw background
    Screen('FillRect', window, background_color);

    % sets initial start location to a random location on the scale
    Ystart = randsample(upper_limit:lower_limit,1); 
    
    SetMouse(xmiddle, Ystart);
    
    timestartP = GetSecs;
    
    % normalize pixel length of scale to 100, scale_pred will be factor
    scale_pred = (lower_limit - upper_limit)/100;
    
    % make the initial location fit in the later predictions
    intermedY = round(((Ystart - upper_limit)/scale_pred));
    if intermedY < 1
        intermedY=1;
    end  
    if intermedY >100
        intermedY = 100;
    end;
        
    % because screenYpixels are lower in upper part of screen, one needs to
    % translate A to prepared vector preds - so that bottom of
    % scales corresponds to 0 and top of scale to 100
    preds = [abs(-100:-1)]';
    
    too_long_Prediction = 0;
    click = 0;
    
    while ~click && ~ too_long_Prediction 

        % draw scale with 0 written at bottom and 100 at top 
        Screen('DrawLine', window, black_color, vert_line.x0, vert_line.y0, vert_line.x1, vert_line.y1);
        Screen('DrawLine', window, black_color, hor_bottom_line.x0, hor_bottom_line.y0, hor_bottom_line.x1, hor_bottom_line.y1);
        Screen('DrawLine', window, black_color, hor_top_line.x0, hor_top_line.y0, hor_top_line.x1, hor_top_line.y1);   
        Screen('DrawLine', window, black_color, xmiddle - width/2, vert_line.y0 + (vert_line.y1 - vert_line.y0)/2, xmiddle + width/2, vert_line.y0 + (vert_line.y1 - vert_line.y0)/2);  
    
        DrawFormattedText(window,'100','center',upper_limit/1.1,[0 0 0]);
        DrawFormattedText(window,'0','center',lower_limit/0.95,[0 0 0]);
       
        % get Mouse Y position
        [~, cursorY, clicks] = GetMouse;
        click = clicks(1);
        
        % limits Mouse to stay on scale and not go beyond 0 or 100
        if cursorY > lower_limit
            cursorY = lower_limit;
        elseif cursorY < upper_limit
            cursorY = upper_limit;
        end

         % Prediction between 1 and 100 on the displayed scale
        Screen('FrameRect', window, black_color, [xmiddle - siz, cursorY - siz, xmiddle + siz, cursorY + siz ], width);
        
        % the following is only for better readability in drawing P later
        P =  cursorY;
        
        % A = normalized to Scale P
        A = (round((cursorY - upper_limit)/scale_pred));

        % A cannot go below 0 because then not normalizable, set back to 1
        if A == 0 A = 1; end

        inY = preds(intermedY); %Ystart needs to be larger than upper_limit
      
        % here preds translates A to B to have 0 at bottom, 100 at top
        B = preds(A); 
        
        if click == 1 && too_long_Prediction ~= 1
            % again draw scale with 0 written at bottom and 100 at top 
            Screen('DrawLine', window, black_color, vert_line.x0, vert_line.y0, vert_line.x1, vert_line.y1);
            Screen('DrawLine', window, black_color, hor_bottom_line.x0, hor_bottom_line.y0, hor_bottom_line.x1, hor_bottom_line.y1);
            Screen('DrawLine', window, black_color, hor_top_line.x0, hor_top_line.y0, hor_top_line.x1, hor_top_line.y1);   
            Screen('DrawLine', window, black_color, xmiddle - width/2, vert_line.y0 + (vert_line.y1 - vert_line.y0)/2, xmiddle + width/2, vert_line.y0 + (vert_line.y1 - vert_line.y0)/2);  

            DrawFormattedText(window,'100','center',upper_limit/1.1,[0 0 0]);
            DrawFormattedText(window,'0','center',lower_limit/0.95,[0 0 0]);            
            
            % this time draw cursor in blue after choosing and display 0.5
            Screen('FrameRect', window, blue_color, [xmiddle - siz, cursorY - siz, xmiddle + siz, cursorY + siz ], width);
            DrawFormattedText(window,num2str(B), xmiddle + screenXpixels/50 ,P + screenYpixels/50,[blue_color]);
            DrawFormattedText(window,num2str(B), xmiddle - screenXpixels/20 ,P + screenYpixels/50,[blue_color]);

            Screen (window,'Flip');
            WaitSecs(0.5);
        end
 
        % continuously write Prediction in numbers on the left and right side of cursor   
        DrawFormattedText(window,num2str(B), xmiddle + screenXpixels/50 ,P + screenYpixels/50,[black_color]);
        DrawFormattedText(window,num2str(B), xmiddle - screenXpixels/20 ,P + screenYpixels/50,[black_color]);
                
        timepred = Screen (window,'Flip');
      
        if timepred > (timestartP + Z.maxpredtime); too_long_Prediction = 1;
            T.LogPrediction(i) = NaN; 
            B = NaN;
            R = NaN;
            T.OnsetTooSlow(i) = timepred;
            DrawFormattedText(window,'Zu langsam!','center','center',[black_color]);
            Screen (window,'Flip');
            T.Feedback(i) = NaN;
            pause(Z.tooslow);  
        end        
        
    end %while 

%%  Feedback phase
    % send into ISI + feedback display OR send into "Zu langsam"
    if ~ too_long_Prediction
      T.LogPrediction(i) = timepred; 
      T.OnsetTooSlow(i) = NaN;        
      
      % fixation cross (ISI)
      DrawFormattedText(window,'+','center','center',black_color);
      T.OffsetPrediction(i) = Screen (window,'Flip');  
      pause(ISI(i)); % indicates length of fixation cross
      
      % get reward from expparams and adapt to pixelsize
      R = (100 - reward(i))*scale_pred + upper_limit;
      
      % draw scale with 0 written at bottom and 100 at top 
      Screen('DrawLine', window, black_color, vert_line.x0, vert_line.y0, vert_line.x1, vert_line.y1);
      Screen('DrawLine', window, black_color, hor_bottom_line.x0, hor_bottom_line.y0, hor_bottom_line.x1, hor_bottom_line.y1);
      Screen('DrawLine', window, black_color, hor_top_line.x0, hor_top_line.y0, hor_top_line.x1, hor_top_line.y1);   
      Screen('DrawLine', window, black_color, xmiddle - width/2, vert_line.y0 + (vert_line.y1 - vert_line.y0)/2, xmiddle + width/2, vert_line.y0 + (vert_line.y1 - vert_line.y0)/2);  
        
      DrawFormattedText(window,'100','center',upper_limit/1.1,[0 0 0]);
      DrawFormattedText(window,'0','center',lower_limit/0.95,[0 0 0]);    
      
      % draw prediction error (first so gets overwritten by P and R)
      Screen('DrawLine', window, red_color, xmiddle, cursorY, xmiddle, R,5); 
      
      % display P in blue and write Prediction in numbers on the left and right side of cursor  
      Screen('FrameRect', window, blue_color, [ xmiddle - siz,P - siz, xmiddle + siz, P + siz ], width);
      DrawFormattedText(window,num2str(B), xmiddle + screenXpixels/50 ,P + screenYpixels/50,[blue_color]);
      DrawFormattedText(window,num2str(B), xmiddle - screenXpixels/20 ,P + screenYpixels/50,[blue_color]);
      
      % display R in green and write Prediction in numbers on the left and right side of cursor  
      Screen('FrameRect', window, green_color, [ xmiddle - siz, R - siz, xmiddle + siz, R + siz ], width); 
      DrawFormattedText(window,num2str(reward(i)), xmiddle + screenXpixels/50 ,R + screenYpixels/50,[green_color]);
      DrawFormattedText(window,num2str(reward(i)), xmiddle - screenXpixels/20 ,R + screenYpixels/50,[green_color]);
      
      % only during doinstr = 1 display feedback with written labels   
      if doinstr == 1;
    
        DrawFormattedText(window,'Vorhersage',xmiddle - screenXpixels/4, P, blue_color);
        DrawFormattedText(window,'Vorhersage',xmiddle + screenXpixels/10, P, blue_color);

        DrawFormattedText(window,'Belohnung',xmiddle - screenXpixels/3.5, R, green_color);
        DrawFormattedText(window,'Belohnung',xmiddle + screenXpixels/7, R, green_color);
          
        end %doinstr = 1

      T.Feedback(i) = Screen (window,'Flip');
                
      pause(Z.feedback_display_time);

        % ITI
    
    end

%% Save data 
% after every trial in txt file      
if doscanner == 0 && run == 1 || run == 2
        %added baseline_start\t BeginITI\t CueOnset\t LogPrediction\t Feedback\t OnsetTooSlow\t begin_end_baseline\t final_triggers \t
        %end_end_baseline \t
      fprintf(outfile, '%s\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t \n', ...
             subid, i, run, inY, B, reward(i), (reward(i) - B), (round(timepred - timestartP,2)), ...
             run1(i,2), run1(i,3), T.BeginITI(i), T.CueOnset(i), T.LogPrediction(i), T.Feedback(i), T.OnsetTooSlow(i));
elseif doscanner == 1 && run == 1 || run == 2
      fprintf(outfile, '%s\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t \n', ...
             subid, i, run, inY, B, reward(i), (reward(i) - B), (round(timepred - timestartP,2)), ...
             run2(i,2), run2(i,3), T.BeginITI(i), T.CueOnset(i), T.LogPrediction(i), T.Feedback(i), T.OnsetTooSlow(i),T.baseline_start);
elseif doinstr == 1
      fprintf(outfile, '%s\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t \n', ...
             subid, i, 7, inY, B, reward(i), (reward(i) - B), (round(timepred - timestartP,2)), ...
             round(std(reward)), round(nanmean(reward)), T.BeginITI(i), T.CueOnset(i), T.LogPrediction(i), T.Feedback(i), T.OnsetTooSlow(i));
end
      
fclose(outfile); %close the data file