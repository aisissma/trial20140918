%%%%%
%%% k-means JK original
%%% cn: cluster number
function index = kmeansJK(data, cn)

%%% 1) 各データにランダムにクラスタを割り当てる
index = randi(cn, size(data));

means = zeros(1, cn);
distance = zeros(length(data), cn);
%%% 繰り返しの最大を設定できるようにする
iterMax = 100;
for fLoop = 1:iterMax,
    
    for iLoop = 1:cn,
        %%% 2) クラスタ毎に平均を計算
        means(iLoop) = mean(data(find(index==iLoop)));
        
        %%% 3) 一番近いクラスタにindexを割り振りなおす
        distance(:,iLoop) = abs(data - means(iLoop))
    end
    [minv newIndex] = min(distance, [], 2);
    
    %%% 4) もし、indexの更新が行われなければ終了
    if(sum(abs(index - newIndex))==0)
        break;
    else
        index = newIndex;
    end
end
