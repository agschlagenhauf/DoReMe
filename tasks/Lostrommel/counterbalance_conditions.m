%% RUN 1: combines SD5/EV35 i.e. blocks(:,1) & SD15/EV65 i.e. blocks (:,6)
order = randsample([1 6],2);
r1 = blocks(:,order(1)); 
r1(:,2) = blocks(:,order(2));

sd = round(std(r1));
ev = round(mean(r1));

idx =  [6 5 4 6];
idxA = randsample(idx,4);
idxB = randsample(idx,4);

cum_idxA = [0 cumsum(idxA)];
cum_idxB = [0 cumsum(idxB)];
out_start = 1;
out = NaN(2 * size(r1, 1), 3);

for i = 1:length(idxA)
    out_end = out_start + cum_idxA(i+1) - cum_idxA(i) - 1;
    out(out_start:out_end, 1) = r1(cum_idxA(i)+1:cum_idxA(i+1), 1);
    out(out_start:out_end, 2) = sd(1);
    out(out_start:out_end, 3) = ev(1);
    out_start = out_end + 1;
    
    out_end = out_start + cum_idxB(i+1) - cum_idxB(i) - 1;
    out(out_start:out_end, 1) = r1(cum_idxB(i)+1:cum_idxB(i+1), 2);
    out(out_start:out_end, 2) = 2;
    
   out(out_start:out_end, 2) = sd(2);
    out(out_start:out_end, 3) = ev(2);
    
    out_start = out_end + 1;
end

run1 = out;

%% RUN 2: combines SD5/EV65 i.e. blocks (:,4) & SD15/EV35 i.e. blocks(:,3)
order = randsample([3 4],2);
r2 = blocks(:,order(1)); 
r2(:,2) = blocks(:,order(2));

sd = round(std(r2));
ev = round(mean(r2));


idx =  [6 5 4 6];
idxA = randsample(idx,4);
idxB = randsample(idx,4);

cum_idxA = [0 cumsum(idxA)];
cum_idxB = [0 cumsum(idxB)];
out_start = 1;
out = NaN(2 * size(r2, 1), 2);

for i = 1:length(idxA)
    out_end = out_start + cum_idxA(i+1) - cum_idxA(i) - 1;
    out(out_start:out_end, 1) = r2(cum_idxA(i)+1:cum_idxA(i+1), 1);
    out(out_start:out_end, 2) = sd(1);
    out(out_start:out_end, 3) = ev(1);
    out_start = out_end + 1;
    
    out_end = out_start + cum_idxB(i+1) - cum_idxB(i) - 1;
    out(out_start:out_end, 1) = r2(cum_idxB(i)+1:cum_idxB(i+1), 2);
    out(out_start:out_end, 2) = 2;
    
   out(out_start:out_end, 2) = sd(2);
    out(out_start:out_end, 3) = ev(2);
    
    out_start = out_end + 1;
end

run2 = out;

