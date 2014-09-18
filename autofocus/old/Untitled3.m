


fh = figure
imshow(binaryIm) % “ñ’l‰»
saveas(fh,'test','bmp')

fh2 = figure
imshow(object, []); %showing image data 
if(0)
[r c] = find(BO==1);
len = length(r);
smpPos = 5;
data = zeros(diameter*diameter, smpPos);
pos = randi(len, 1, smpPos);
lenp = length(pos);
for iLoop = 1:lenp,
    tops = [(r(pos(iLoop))-radius) (c(pos(iLoop))-radius)];
    nz = [tops(2) tops(1)  (2*radius) (2*radius)];
    rectangle('Position', nz, 'EdgeColor', 'g');
    num = sprintf('%d', iLoop);
    text(c(pos(iLoop)), r(pos(iLoop)), num, 'Color', 'r');
    
    local = object(tops(1):tops(1)+2*radius, tops(2):tops(2)+2*radius);
    data(:, iLoop) = local(:);
end
end
saveas(fh2,'test2','bmp')

fh3 = figure
imshow(BO);
saveas(fh3,'test3','bmp')

