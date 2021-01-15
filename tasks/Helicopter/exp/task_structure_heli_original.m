close all; clear all
Z.Ntrials = 75;

noise = ones(Z.Ntrials);
noise_level = [8];
hazard_rate = 0.125;

m = round(rand(1)*100);
first_three = 0 ;
criterion = 0;

while ~criterion
    m = round(rand(1)*100);
    first_three = 0;
    for nt=1:Z.Ntrials

        bag_location_100(nt) = m + rand * noise_level(noise(nt));
        first_three = first_three + 1;

        if first_three > 3 && rand < hazard_rate 
            m = round(rand(1)*100);
            first_three = 0;
        end

    end
    criterion = ~sum(bag_location_100 > 100) && ~sum(bag_location_100 < 0)
end


figure; plot(bag_location_100);axis([0 Z.Ntrials 0 100]);
save bag_location_100_B.mat bag_location_100
