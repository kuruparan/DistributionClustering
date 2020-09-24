

function [out_I]=kdtreee2(D,mmz,i,slice,nn)
n=nn;

ip=i;

size(D);
mask=floor(i/slice);
maski = mask*slice+1:(mask+1)*slice;
D2=D;
D2(1,maski)=2000;

Q=mmz;
Mdl = createns(transpose(D2),'Distance','minkowski');
IdxNN = knnsearch(Mdl,Q,'K',n);
D2(IdxNN);

ii = double(IdxNN');
%jj = double(repelem(length(IdxNN))');
v1 = double(D2(IdxNN)');

S = sparse(ii,1,v1);


out_I=IdxNN;

end


