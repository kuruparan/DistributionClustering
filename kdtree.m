load fisheriris
% X = meas;
% Mdl = KDTreeSearcher(X)
% Mdl.Distance = 'minkowski'

% rng(1);                     % For reproducibility
% n = size(meas,1);           % Sample size
% qIdx = randsample(n,1);     % Indices of query data
% tIdx = ~ismember(1:n,qIdx); % Indices of training data
% Q = meas(qIdx,:);
% Q=Q(:,1);
% X = meas(tIdx,:);
% X=X(:,1);

X=rand(1,100)*100
X=transpose(X)
q=5
Mdl = createns(X,'Distance','minkowski')
IdxNN = knnsearch(Mdl,Q,'K',10)
X(IdxNN )

