
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


slice=4;

ori_num=length(D);
mask=[1:ori_num];
D=D(mask, mask);
D_base=D;

D=D+1000*eye(size(D,1));


alloc=zeros(ori_num,1);


go_=1;
target=1;

D_temp=D;
for i=1:(ori_num/slice)-1
       D_temp(1: (slice),1: (slice))= ones((slice))*1000;
       D_temp(slice*i+1: (slice*(i+1)),slice*i+1: (slice*(i+1)))= ones((slice))*1000;
end


D=D_temp
    
    
    
clus_dist={};
while(go_)
    go_=0;
    
   
    
    
    if(sum(alloc>0)< length(alloc))
        ind=find(alloc);
        D(ind,:)=1000;
        D(:,ind)=1000;
        [mmz, i]=min(min(D, [], 1))
        [mmz, j]=min(D(i,:))
        imin=i
        jmin=j

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
            [alloc_tmp]=clus_strange(D_base, alloc_tmp, cur_vec, mmz, thres, thres, target,i,j);


            
            sum(alloc_tmp==target)
            %loc_ind=find(alloc_tmp==target);
            loc_ind=alloc_tmp==target

            [mmz]=compute_dist(D_base,loc_ind);
            [cur_vec]=compute_vec(D_base, loc_ind, mmz);
         %   pause(5);

            [alloc_tmp]=clus_strange(D_base, alloc_tmp, cur_vec, mmz, thres, thres, target,i,j);
            % sum(alloc_tmp==target)
            % return;
            disp(loc_ind)
         %   pause(5);

            if(sum(alloc_tmp==target)>=min_num_per_clus)
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




function [out]=compute_vec(D_base, ind, mmz)
D=D_base(ind,:);
a1=ind(1)
a2=ind(2)
for i=1: size(D,1)%length(ind)
    D(i, ind(i))=mmz;
end;

out=mean(D, 1);

end



function [alloc]=clus_strange(D, alloc, cur_vec, cur_dis, thres_all, thres_loc, target,i,j)
change=1;
ini_i=i
ini_j=j
slice=4;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mask_ini=floor(i/slice);

if (mod(i,slice)==0  && (i>0))
    mask_ini=floor(i/slice)-1
end

if (mod(i,slice)==0  && (i==0))
    mask_ini=floor(i/slice)
end            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5%%5

mask_inilist = mask_ini*slice+1:(mask_ini+1)*slice
pause(1);
        
while(change)
    change=0;
    iin=0;
    for i=1:length(alloc)
        if(~(alloc(i)==target))
            continue;
        end;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        maskk=floor(i/slice);

        if (mod(i,slice)==0  && (i>0))
            maskk=floor(i/slice)-1
        end

        if (mod(i,slice)==0  && (i==0))
            maskk=floor(i/slice)
        end            
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5%%5

        maskklist=maskk*slice+1:(maskk+1)*slice

        for k=1:length(alloc)
            if(alloc(k)>0 || i==k)
                continue;
            end;

            if(alloc(k)>0 || ismember(k,maskklist))
                continue;
            end;            

            if(alloc(k)>0 || ismember(k,mask_inilist))
                continue;
            end;      
%             vec_tmp=cur_vec;
%             vec_tmp(k)=0;
%             
%             vec_k=D(k,:);
%             vec_k(ind_cur)=0;
            vec_tmp=cur_vec;
            ii=i
            kk=k
            vec_k=D(k,:);
            vec_k(k)=cur_dis;
            
            dis=mean(abs(vec_tmp-vec_k));
            
            t=squeeze(D(k,:));
            disp(alloc)
            disp(target)
%            t=t(alloc==target)
                        t=t(alloc==target);

            t=mean(t);
            dis2=abs(t-cur_dis);

          %  [k,dis]
           % pause(1);
            if(dis<thres_all && abs(t-cur_dis)< thres_loc && ~ismember(k,maskklist))
               % result = strcat(num2str(i),num2str(alloc(i)));
               %result = str2num(result)
                alloc(k)=alloc(i)
%                          
%                    if (~(iin==i) && iin>0)
%                        target2=target2+1  
%                        alloc(i)=target2
%                    end
%                 alloc(k)=target2

                iin=i
                kin=k
                change=1;
            end;
        
        
        end;
    end;
end;


end
