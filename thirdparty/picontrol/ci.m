function CI = ci(x)

SEM = nanstd(x)/sqrt(length(x));               % Standard Error
ts = tinv([0.025  0.975],length(x)-1);      % T-Score
CI = repmat(nanmean(x),2,1) + ts'*SEM;                      % Confidence Intervals



