i=0; clear tx ypos func;
func{1}=[];
fprintf('............. payout\n');

payout =(Z.cent_per_point*(sum(reward_caught==1)));
if payout <= minpayout;
   payout = minpayout;
end

if payout >= maxpayout;
    payout = maxpayout;
end
if payment
	i=i+1;
	ypos{i}=yposm;
        tx{i}= ['Sie haben insgesamt ' num2str(payout) ' Euro verdient!\n\nVielen Dank für Ihre Teilnahme!'];
end
display_payment; 

