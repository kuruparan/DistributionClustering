

function [out_I]=kdtreee(D,mmz,i,j,slice,nn)
n=nn;

ip=i;
jp=j;

mask=floor(i/slice);
maski = mask*slice+1:(mask+1)*slice;
D2=D;
D2(maski,j)=2000;



Q=mmz;
Mdl = createns(D2(:,j),'Distance','minkowski');
IdxNN = knnsearch(Mdl,Q,'K',n);
D2(IdxNN,j);

ii = double(IdxNN');
jj = double(repelem(j,length(IdxNN))');
v1 = double(D2(IdxNN,j)');

S = sparse(ii,jj,v1);


mask=floor(j/slice);
maskj = mask*slice+1:(mask+1)*slice;
D3=D;
D2(i,maskj)=2000;

Mdl2 = createns(transpose(D3(i,:)),'Distance','minkowski');
IdxNN2 = knnsearch(Mdl2,Q,'K',n);
D3(i,IdxNN2);


jj2 = double(IdxNN2');
ii2 = double(repelem(i,length(IdxNN2))');
v2 = double(D3(i,IdxNN2)');

%%S(i,jj2)=v2;
%S = sparse(ii2,jj2,v2)

v2from1=double(D3(i,IdxNN)');
%s2= sparse(ii2(2:n),ii(2:n),v2from1)

S(i,ii)=v2from1;
%e=full(S)

out_I=IdxNN;

end


