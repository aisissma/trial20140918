%%% funcNum : ŠÖ”‚Ì”
%%% paraNum : single model‚Ìparameter”
function ret = multiFunction(para, x, funcNum, paraNum)

ret = zeros(size(x));
for iLoop = 1:funcNum,
    paraRange = (1+(iLoop-1)*paraNum):(iLoop*paraNum);
    ret = ret + gauss_distribution1D(para(paraRange), x);
end