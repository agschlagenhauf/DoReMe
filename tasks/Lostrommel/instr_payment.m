%% payout settings

% subid	 trial	 block	 startPred	 prediction	 reward	 PE	 RTpred	 SD EV
% BeginITI CueOnset LogPrediction Feedback OnsetTooSlow
% '*%s\t   %*d\t    %*d\t    %*d\t      %d\t        %*d\t    %*d\t  %*d\t  %*d\t  %d\t
% %*d\t    %*d\t   %*d\t    %*d\t    %*d\t                                       %*[^\n]'   
% payment calculation, pseudorandomized trials (20%) for accurate
% performance and 20% of average reward

cd(datadir);

prediction = []; EV = [];  
    
 if run == 2
        outputfile = outputname;
        [prediction, EV] = textread(outputfile, '%*s\t%*d\t%*d\t%*d\t%d\t%*d\t%*d\t%*f\t%*d\t%d\t%*f\t%*f\t%*f\t%*f\t%*f\t%*[^\n]','headerlines',1);        
        prediction = [prediction; prediction]; 
        EV = [EV; EV];
 end

    diff = abs(EV(~isnan(prediction))-prediction(~isnan(prediction)));
    mean_selected_SD = mean(diff(randperm(length(diff),8)));

    if mean_selected_SD  <= 15
        fprintf('Within 1 SD - pay 5€ bonus\n')
    elseif mean_selected_SD  >= 15 && mean_selected_SD <= 30  
         fprintf('Within 2 SD - pay 2.50€ bonus\n')
    else fprintf('No bonus!\n')  
    end
    
 cd(taskdir);