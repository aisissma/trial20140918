clear; 
figure(3);
clf;

row = 3;
col = 3;

%tiffname = 'C:\Home\Works\2010\Programing\2D\001_imshow2011\RawR1105nM120424_202636_ch1.tif';
tiffname = 'apertureRICM.tif';
%tiffname = 'E:\share2\video\RawS1PR2TMRx60x4x1120803_155604_ch2.tif';
tiffname = '\\spectra2\share2\video\RawS1PR2TMRx60x4x1120803_155604_ch2.tif';

%% 180 in focus
object = double(imread(tiffname, 1));

subplot(row,col,1);
imshow(object, []); %showing image data 
title('load image'); %attaching a label

flt = 1/9 * ones(5, 5, 'double'); % making flt filter
flt = [[-1 0 1]; [-1 -0 1]; [- 1 0 1]]; % making 微分 filter
%flt = [[0 1 0]; [1 -4 1]; [0 1 0]]; % making laplasian filter
%flt = [[0 -1 0]; [-1 -5 -1]; [0 -1 0]]; % making edge enhanced filter
% flt = [[0 -1 0]; [-1 5 -1]; [0 -1 0]]; % making edge enhanced filter
% flt = [[-1 -1 -1]; [-1 -9 -1]; [-1 -1 -1]]; % making edge enhanced filter
%flt = [[-1 -1 -1]; [-1 8 -1]; [-1 -1 -1]];
%flt = [[1 -2 1]; [-2 4 -2]; [1 -2 1]];

fObj1 = filter2(flt, double(object));


% roiRadius = 3;
% roi = 0:2*roiRadius;
% %roi = -roiRadius:1:roiRadius;
% roiSize = size(roi);
% 
% imSize = size(object);
% fObj = zeros(imSize - 2*roiRadius);
% fSize = size(fObj);
% 
% for rLoop = 1:fSize(1),
%     for cLoop = 1:fSize(2),        
%         data = object(rLoop+roi, cLoop+roi);
%         fObj(rLoop, cLoop) = std(data(:))/mean(data(:));
%     end
% end
% 
% subplot(row,col,2);
% imshow(fObj, []);
% title('cv image'); %attaching a label

fObj = object;
subplot(row,col,3);
hist(fObj(:), 100);

I = fObj;
level = graythresh(I);
binaryIm = im2bw(I,level);

binaryIm = zeros(size(object));
binaryIm(find(fObj<2600))=1;
subplot(row,col,4);imshow(binaryIm) % 二値化

I = binaryIm;

BW1 = edge(I,'prewitt');
BW2 = edge(I,'canny');
%BW2 = edge(I,'sobel');
BW2 = edge(I,'roberts');
%BW2 = edge(I,'log');

subplot(row,col,2);
%figure(1)
%clf;
imshow(fObj1,[]);
% image(fObj1);
% colormap(gray(256));

subplot(row,col,5);
hist(fObj1(:), 100);

subplot(row,col,6);
imshow(BW1);

subplot(row,col,7);
imshow(BW2);
% モフォロジー処理
%figure(1);
se1 = strel('disk',1);
ic2 = imclose(BW2, se1);
subplot(row,col,8);
imshow(ic2, []);
% 
% % 閉空間を埋める
% BWdfill = imfill(ic2, 'holes'); 
% subplot(row,col,6);imshow(BWdfill);
% 
 % 指定ピクセル以上のエリアを残す
figure(1);
clf;
BO = bwareaopen(ic2, 100);
%subplot(row,col,9);
imshow(BO);

% %%%%%% 2012,0,806
% %距離変換
% BD = -bwdist(~BO);
% BD(~BO) = -Inf; %% バックグラウンドを取り除く
% subplot(row,col,8); imshow(BD, []);
% %watershed
% wi = watershed(BD); % 0:back, 1:boundary, 2-n:label
% subplot(row,col,9); imshow(label2rgb(wi, prism));
% 
% status = regionprops(wi, 'BoundingBox', 'Centroid');
% figure(3);
% hold on;
% imshow(object, []); %showing image data
% for iLoop = 2:length(status),
%     xy = status(iLoop).Centroid;
%     z = status(iLoop).BoundingBox;
%     
%     sc = z(3)*z(4); % superficial content
%     minSC = minRad*minRad; % minmum superficial content
%     if(minSC<sc)
%         nz = z;
%         nz(3) = x60fv;
%         nz(4) = x60fv;
%         rectangle('Position', nz, 'EdgeColor', 'g');
%         num = sprintf('%d', iLoop);
%         text(xy(1), xy(2), num, 'Color', 'r');
%     end
% end


% subplot(row,col,8);
% mask = zeros(imSize);
% mask(roiRadius+1:roiRadius+fSize(1), roiRadius+1:roiRadius+fSize(2)) = BO;
% ci = object .* mask;
% subplot(row,col,8);imshow(ci,[]);

