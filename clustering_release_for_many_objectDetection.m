
function [final_sol,clus_dist]=clustering_release(D, thres, min_num_per_clus, max_dis)
if(~exist('thres', 'var'));
    thres=0.07;
end;
if(~exist('min_num_per_clus', 'var'));
    min_num_per_clus=5; 
end;

if(~exist('max_dis', 'var'));
    max_dis=2; 
end;

global slice 
slice=4;


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
        [mmz, i]=min(min(D, [], 1))
        [mmz, j]=min(D(i,:))
        mmz;
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        maska=floor(i/slice)
        maskb=floor(j/slice)
        
        if (mod(i,slice)==0 && (i>0))
            maska=floor(i/slice)-1
        end
        if (mod(j,slice)==0&& (j>0))
            maskb=floor(j/slice)-1
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        
        D(i,j)=1000;
        D(j,i)=1000;
        
        [cur_vec]=compute_vec(D_base, [i,j], mmz);
        
        a=D_base(i,:);
        b=D_base(j,:);
        a(j)=0;
        b(i)=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       % a_mask = a([1:mask1*slice, (mask1+1)*slice+1:end])  ;
       % b_mask = b([1:mask2*slice, (mask2+1)*slice+1:end])  ;
        a_mask=a;
        a_mask([maskb*slice+1:(maskb+1)*slice ])=0;
        
        b_mask=b;
        b_mask([maska*slice+1:(maska+1)*slice ])=0;
        


        a1=a_mask
        b1=b_mask
        meanof=sum(abs(a1-b1)/(length(a1)-2))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        if(sum(abs(a1-b1)/(length(a1)-2))>thres && mmz<max_dis)   %why mean(abs(a-b)  1.  filterout a,b from same picture to get abs(a-b) --done
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
            [alloc_tmp]=clus_strange(D_base, alloc_tmp, cur_vec, mmz, thres, thres, target);


            
            sum(alloc_tmp==target);
            %loc_ind=find(alloc_tmp==target);
            loc_ind=alloc_tmp==target

            [mmz]=compute_dist(D_base,loc_ind);
            [cur_vec]=compute_vec(D_base, loc_ind, mmz);
            [alloc_tmp]=clus_strange(D_base, alloc_tmp, cur_vec, mmz, thres, thres, target);
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



%        [cur_vec]=compute_vec(D_base, [i,j], mmz);

function [out]=compute_vec(D_base, ind, mmz)
D11=D_base(ind,:)
global slice 
slice=4;
mmz=mmz
i=ind(1)
j=ind(2)
%%%%%%%%%%%%%%%%%
mask1=floor(ind(1)/slice)
mask2=floor(ind(2)/slice)


if (mod(ind(1),slice)==0 && (ind(1)>0))
    mask1=floor(ind(1)/slice)-1
end
if (mod(ind(2),slice)==0 && (ind(2)>0))
    mask2=floor(ind(2)/slice)-1
end

% D11(2, mask1*slice+1:i-1)=0;
% D11(2, i+1:(mask1+1)*slice)=0;
% 
% D11(1, mask2*slice+1:j-1)=0;
% D11(1, j+1:(mask2+1)*slice)=0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for i=1: size(D11,1)%length(ind)
    D11(i, ind(i))=mmz
end;

D11(2, mask1*slice+1:(mask1+1)*slice)=0
D11(1, mask2*slice+1:(mask2+1)*slice)=0
out=mean(D11, 1);       % 2. can filterout the computed vector



end


% [alloc_tmp]=clus_strange(D_base, alloc_tmp, cur_vec, mmz, thres, thres, target);

function [alloc]=clus_strange(D, alloc, cur_vec, cur_dis, thres_all, thres_loc, target)
change=1;
global slice 
slice=4;
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
            
%             vec_tmp=cur_vec;
%             vec_tmp(k)=0;
%             
%             vec_k=D(k,:);
%             vec_k(ind_cur)=0;
            vec_tmp=cur_vec
            
            vec_k=D(k,:);           % 3. filter same photoes vector
            vec_k(k)=cur_dis;       
            
            
            maskk=floor(k/slice);
        
            if (mod(k,slice)==0  && (k>0))
                maskk=floor(k/slice)-1
            end
        
            if (mod(k,slice)==0  && (k==0))
                maskk=floor(k/slice)
            end            

            vec_k_mask=vec_k;
            vec_k_mask([maskk*slice+1:(maskk+1)*slice ])=0;
            vec_k=vec_k_mask
            dis=mean(abs(vec_tmp-vec_k))
            
            t=squeeze(D(k,:))
            alloc
            t=t(alloc==target)     %count of alloc has to be filtered
            t=mean(t)
            dsi2=abs(t-cur_dis)

          %  [k,dis]
            
            if(dis<thres_all && abs(t-cur_dis)< thres_loc)
                disp(k)
                alloc(k)=alloc(i)
                disp(i)
                change=1;
            end;
        end;
    end;
end;


end
