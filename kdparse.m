example = matfile('save.mat');
D=example.D

[mmz, i]=min(min(D, [], 1))
[mmz, j]=min(D(i,:))


Q=mmz
Mdl = createns(D(:,j),'Distance','minkowski')
IdxNN = knnsearch(Mdl,Q,'K',5)
D(IdxNN,j)

Mdl2 = createns(transpose(D(i,:)),'Distance','minkowski')
IdxNN2 = knnsearch(Mdl2,Q,'K',5)
D(i,IdxNN2)

ii = double(IdxNN')
jj = double(repelem(j,length(IdxNN))')
v1 = double(D(IdxNN,j)')

S = sparse(ii,jj,v1)

jj2 = double(IdxNN2')
ii2 = double(repelem(i,length(IdxNN2))')
v2 = double(D(i,IdxNN2)')

S(i,jj2)=v2
%S = sparse(ii2,jj2,v2)

e=full(S)