%%%%%%%%% gauss distribution
%% para 1:mean value, 2:standard deviation, 3:amplitude
%% x : value
function ret = gauss_distribution1D(para, x)

mv = para(1);
sd = para(2);
amp = para(3);

coef = -1/(2*sd^2) * (x-mv).^2;
ret = amp*exp(coef) / (sqrt(2*pi)*sd);