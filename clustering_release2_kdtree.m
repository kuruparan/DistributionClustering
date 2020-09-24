
function [final_sol,clus_dist]=clustering_release2_kdtree(D, thres, min_num_per_clus, max_dis,mini)
if(~exist('thres', 'var'));
    thres=0.07;
end;
if(~exist('min_num_per_clus', 'var'));
    min_num_per_clus=5; 
end;

if(~exist('max_dis', 'var'));
    max_dis=2; 
end;




ori_num=length(D);
mask=[1:ori_num];
D=D(mask, mask);
D_base=D;

D=D+1000*eye(size(D,1));


alloc=zeros(ori_num,1);


go_=1;
target=1;

clus_dist={};
while(go_)
    go_=0;
    
   
    
    
    if(sum(alloc>0)< length(alloc))
        ind=find(alloc);
        D(ind,:)=1000;
        D(:,ind)=1000;
        [mmz, i]=min(min(D, [], 1));
        [mmz, j]=min(D(i,:));
        mmz
        D(i,j)=1000;
        D(j,i)=1000;
        [cur_vec]=compute_vec(D_base, [i,j], mmz);
        
        a=D_base(i,:);
        b=D_base(j,:);
        a(j)=0;
        b(i)=0;

        if(mean(abs(a-b))>thres && mmz<max_dis)   %why mean(abs(a-b)
            go_=1;
            continue;
        end;
        
        
        if(mmz==0)
            go_=1;
            continue;
        end;
        
        
        if(mmz<max_dis)
            
            alloc_tmp=alloc;
            alloc_tmp(i)=target;
            alloc_tmp(j)=target;
            [alloc_tmp]=clus_strange(D_base, alloc_tmp, cur_vec, mmz, thres, thres, target,i,j,mini);


            
            sum(alloc_tmp==target)
            %loc_ind=find(alloc_tmp==target);
            loc_ind=alloc_tmp==target;

            [mmz]=compute_dist(D_base,loc_ind);
            [cur_vec]=compute_vec(D_base, loc_ind, mmz);
            [alloc_tmp]=clus_strange(D_base, alloc_tmp, cur_vec, mmz, thres, thres, target,i,j,mini);
            % sum(alloc_tmp==target)
            % return;
            
            if(sum(alloc_tmp==target)>min_num_per_clus)
                alloc=alloc_tmp;
                %[mmz]=compute_dist(D_base,find(alloc_tmp==target));
                clus_dist{target}=mmz;
                target=target+1;
            end;
            
            go_=1;
        end;
    end;
     if(mmz>max_dis)
        go_=0;
    end;
    
     if(target>200)
        go_=0;
    end;    
    
end;



alloc_tmp=zeros(length(ori_num),1);
alloc_tmp(1:length(alloc))=alloc;
alloc=alloc_tmp;


%setting  cluster labelling
final_sol=zeros(ori_num,1);
for i=1:ori_num
    if(i<=length(alloc))
        final_sol(mask(i))=alloc(i);
    end;
end;
return;


end


function [dist]=compute_dist(D,index)

D_=D(index, index);
num=size(D_,1);

dist=sum(sum(D_))/(num*num-num);   %why this tyoe of compute distance eventhoiugh it outputs mmz


end




function [out]=compute_vec(D_base, ind, mmz)
D=D_base(ind,:);

for i=1: size(D,1)%length(ind)
    D(i, ind(i))=mmz;
end;

out=mean(D, 1);

end



function [alloc]=clus_strange(D, alloc, cur_vec, cur_dis, thres_all, thres_loc, target,i,j,mini)
change=1;
ini_i=i;
ini_j=j;
%pause(1)
slice=mini;
mmz=cur_dis;
[out_I]=kdtreee(D,mmz,ini_i,ini_j,slice,20);

while(change)
    change=0;
    for i=1:length(alloc)
        if(~(alloc(i)==target))
            continue;
        end;
        for k=1:length(alloc)
            if(alloc(k)>0 || i==k)
                continue;
            end;
            
            if(alloc(k)>0 || not(ismember(k,out_I)))
                continue;
            end;    
            
%             vec_tmp=cur_vec;
%             vec_tmp(k)=0;
%             
%             vec_k=D(k,:);
%             vec_k(ind_cur)=0;
            vec_tmp=cur_vec;

            vec_tmp_5=vec_tmp(out_I);
            vec_tmp=vec_tmp_5;
            
            vec_k=D(k,:);
            vec_k(k)=cur_dis;
            vec_k_5=vec_k(out_I);
            vec_k=vec_k_5;    
            
            dis=mean(abs(vec_tmp-vec_k));
            
            t=squeeze(D(k,:));
            t=t(alloc==target);
            t=mean(t);

          %  [k,dis]
            
            if(dis<thres_all && abs(t-cur_dis)< thres_loc)
                alloc(k)=alloc(i);
                change=1;
            end;
        end;
    end;
end;


end
