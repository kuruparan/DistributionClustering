

function [vec_tmp2,vec_k2,out_I2,out_K2]=organize(out_I,vec_tmp,out_K,vec_k,n)
vec_tmp2=zeros(1,2*n);
vec_k2=zeros(1,2*n);
out_I2=zeros(1,2*n);
out_K2=zeros(1,2*n);
[val,pos]=intersect(out_I,out_K);
 for i=1:length(out_I)
     t=0;
    for j=1:length(out_K)
        if out_I(i)==out_K(j)
            vec_tmp2(i)=vec_tmp(i);
            out_I2(i)=out_I(i);
            vec_k2(i)=vec_k(j);
            out_K2(i)=out_K(j);
            vec_k(i)=0;
            out_K(i)=0;
            t=1;
            break
        end
    end
    if t==0
        vec_tmp2(i)=vec_tmp(i);
        vec_k2(i)=0;
    end
      
 end
vec_tmp2(1,n+1:2*n)=vec_k;

end