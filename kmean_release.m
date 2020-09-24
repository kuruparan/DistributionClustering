clear all;

addpath('C:\Users\Daniel\Documents\MATLAB\vlfeat-0.9.20\toolbox');
vl_setup;


main_folder='E:\tmp\';
type='vd16_pitts30k_conv5_3_vlad_preL2_intra_white_';
im1_small_folder='release_data';
feat_folder1=[main_folder,im1_small_folder, '\', type, im1_small_folder, '_db.bin'];
k_means_num=12;
outputMainFolder='clusters';
outputSubFolder='kmeans';

%mult_vlad_release(main_folder, im1_small_folder); % uncoment to run feature computation

[feat1, feat2, D]=feature_diff2(feat_folder1, feat_folder1);


[sol,~, SUMD] = kmeans(feat1',k_means_num);

tot_clus=max(max(sol));
for i=1:tot_clus    
    mask=sol==i;
    SUMD(i)=SUMD(i)/nnz(mask);
end;
[val, ind]=sort(SUMD);

final_sol=zeros(length(sol),1);


for i=1:tot_clus
    index=ind(i);
    mask=sol==index;
    final_sol(mask)=i;
end;

%final_sol=sol;


im2folder

