%%%%%
%%% k-means JK original
%%% cn: cluster number
function index = kmeansJK(data, cn)

%%% 1) �e�f�[�^�Ƀ����_���ɃN���X�^�����蓖�Ă�
index = randi(cn, size(data));

means = zeros(1, cn);
distance = zeros(length(data), cn);
%%% �J��Ԃ��̍ő��ݒ�ł���悤�ɂ���
iterMax = 100;
for fLoop = 1:iterMax,
    
    for iLoop = 1:cn,
        %%% 2) �N���X�^���ɕ��ς��v�Z
        means(iLoop) = mean(data(find(index==iLoop)));
        
        %%% 3) ��ԋ߂��N���X�^��index������U��Ȃ���
        distance(:,iLoop) = abs(data - means(iLoop))
    end
    [minv newIndex] = min(distance, [], 2);
    
    %%% 4) �����Aindex�̍X�V���s���Ȃ���ΏI��
    if(sum(abs(index - newIndex))==0)
        break;
    else
        index = newIndex;
    end
end
