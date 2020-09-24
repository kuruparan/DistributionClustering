

function [out]=kdtreee(D,mmz,i,j,slice)

mask=floor(i/slice);
maski = mask*slice+1:(mask+1)*slice;
D(maski)=2000

Q=mmz
Mdl = createns(D(:,j),'Distance','minkowski')
IdxNN = knnsearch(Mdl,Q,'K',2)
D(IdxNN,j)

Mdl2 = createns(transpose(D(i,:)),'Distance','minkowski')
IdxNN2 = knnsearch(Mdl2,Q,'K',2)
D(i,IdxNN2)

ii = double(IdxNN')
jj = double(repelem(j,length(IdxNN))')
v1 = double(D(IdxNN,j)')

S = sparse(ii,jj,v)

jj2 = double(IdxNN2')
ii2 = double(repelem(i,length(IdxNN2))')
v2 = double(D(i,IdxNN2)')

S(i,jj2)=v2
%S = sparse(ii2,jj2,v2)

e=full(S)

end

slice=4
[out]=kdtreee(D,mmz,i,j,slice)
