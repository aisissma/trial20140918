clear; 
figure(3);
clf;

row = 3;
col = 3;

%tiffname = 'C:\Home\Works\2010\Programing\2D\001_imshow2011\RawR1105nM120424_202636_ch1.tif';
tiffname = 'apertureRICM.tif';
tiffname = 'E:\share2\video\RawS1PR2TMRx60x4x1120803_155604_ch2.tif';
tiffname = '\\spectra2\share2\video\RawS1PR2TMRx60x4x1120803_155604_ch2.tif';

%% 180 in focus
object = double(imread(tiffname, 1));

subplot(row,col,1);
imshow(object, []); %showing image data 
title('load image'); %attaching a label

fObj = object;
% subplot(row,col,2);
% hist(fObj(:), 100);

I = fObj;
% level = graythresh(I);
% binaryIm = im2bw(I,level);

binaryIm = zeros(size(object));
binaryIm(find(fObj<2600))=1;
subplot(row,col,4);
imshow(binaryIm) % 二値化

I = binaryIm;

% BW1 = edge(I,'prewitt');
% BW2 = edge(I,'canny');
%BW2 = edge(I,'sobel');
BW2 = edge(I,'roberts');
%BW2 = edge(I,'log');

% subplot(row,col,6);
% imshow(BW1);

subplot(row,col,5);
imshow(BW2);
% モフォロジー処理
se1 = strel('disk',1);
ic2 = imclose(BW2, se1);
subplot(row,col,6);
imshow(ic2, []);

 % 指定ピクセル以上のエリアを残す
BO = bwareaopen(ic2, 100);

radius = 30;
diameter = 2*radius+1;
mask = ones(size(object));
mask(1:radius, :) = 0;
mask(end-radius+1:end,:) = 0;
mask(:, 1:radius) = 0;
mask(:, end-radius+1:end) = 0;

BO = BO .*  mask;

subplot(row,col,7);
imshow(BO);


subplot(row,col,1);
[r c] = find(BO==1);
len = length(r);
smpPos = 5;
data = zeros(diameter*diameter, smpPos);
pos = randi(len, 1, smpPos);
lenp = length(pos);
for iLoop = 1:lenp,
    subplot(row,col,1);
    tops = [(r(pos(iLoop))-radius) (c(pos(iLoop))-radius)];
    nz = [tops(2) tops(1)  (2*radius) (2*radius)];
    rectangle('Position', nz, 'EdgeColor', 'g');
    num = sprintf('%d', iLoop);
    text(c(pos(iLoop)), r(pos(iLoop)), num, 'Color', 'r');
    
    local = object(tops(1):tops(1)+2*radius, tops(2):tops(2)+2*radius);
    data(:, iLoop) = local(:);
end

data = data(:)';
%%% fitting
funcNum = 2;
paraNum = 3;
func  = @(pp, xx)(multiFunction(pp, xx, funcNum, paraNum));

%%%% fitting option
ub=[inf,inf];lb=[0,0];
options=optimset('MaxFunEvals',1000,...
    'MaxIter',10000,...
    'TolFun',1e-8,...
    'TolX',1e-7);

range = [min(object(:)) max(object(:))];
binNum = 40;
binWidth = (range(2)-range(1))/binNum;
x = range(1):binWidth:range(2);

freq = histc(data, x);
freq = freq / (sum(freq) * binWidth);
edges = x(1:end-1) + (binWidth/2);
freq2 = freq(1:end-1);

%%%% クラスタ毎のパラメータを計算
index = kmeans(data', funcNum);
lenData = length(data);
initPara = [];
for iLoop = 1:funcNum,
    cData = data(find(index==iLoop));
    
    cMean = mean(cData);%%% 1) 各クラスタの平均を計算
    cSD = std(cData);%%% 2) 各クラスタの分散を計算
    cRatio = length(cData)/lenData;
    initPara = [initPara cMean cSD cRatio];
end

parasF = lsqcurvefit(func, initPara, edges, freq2, lb, ub, options)
retF = multiFunction(parasF, edges, funcNum, paraNum);

subplot(row,col,3);
hold on;
bar(edges, freq2);
plot(edges, retF, 'r');


%%%%%%%%%% fitting 2%%%%%%%%%%%%%%%%%%%%
data = object(:)';

freq = histc(data, x);
freq = freq / (sum(freq) * binWidth);
edges = x(1:end-1) + (binWidth/2);
freq2 = freq(1:end-1);

%%%% クラスタ毎のパラメータを計算
index = kmeans(data', funcNum);
lenData = length(data);
initPara = [];
for iLoop = 1:funcNum,
    cData = data(find(index==iLoop));
    
    cMean = mean(cData);%%% 1) 各クラスタの平均を計算
    cSD = std(cData);%%% 2) 各クラスタの分散を計算
    cRatio = length(cData)/lenData;
    initPara = [initPara cMean cSD cRatio];
end

parasF = lsqcurvefit(func, initPara, edges, freq2, lb, ub, options)
retF = multiFunction(parasF, edges, funcNum, paraNum);

subplot(row,col,2);
hold on;
bar(edges, freq2);
plot(edges, retF, 'r');
