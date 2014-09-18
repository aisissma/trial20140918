%% preAutofocus.m
%%% 各ｚ位置の情報はposZに記録（絶対位置でいい）


%% set center position = [cx, cy, cz, 0]
disp('center = getNowPos()');

%% set delta = [dx, dy, dz, dt]
disp('delta = getDelta()');

%%% set dif = [sx, ex; sy, ex; sz, ez; 0, count]
disp('dif = getDif()');

difx = 0;
dify = 0;
difz = 1;
count = 1;

tSeq = 0:(count-1);
zSeq = -difz:difz; %=sz:ez;
xSeq = -difx:difx; %=sx:ex;
ySeq = -dify:dify; %=sy:ey;

lenX = length(xSeq);
lenY = length(ySeq);
lenZ = length(zSeq);
lenT = length(tSeq);

imageNo = zeros([lenX lenY lenZ lenT]);
nowNo = 1;
for tLoop = 1:lenT,
    for zLoop = 1:lenZ,
        for yLoop = 1:lenY,
            for xLoop = 1:lenX,
               disp('take a picture'); 
               imageNo(xLoop, yLoop, zLoop, tLoop) = nowNo;
               nowNo = nowNo + 1;
            end          
        end       
    end
end