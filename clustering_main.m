clear all;

% needs vl_feat toolbox from oxford, http://www.vlfeat.org/
addpath('C:\Users\kuruparans\Downloads\vlfeat-0.9.21-bin_2\vlfeat-0.9.21\toolbox');
%addpath('C:\Users\Daniel\Documents\MATLAB\vlfeat-0.9.20\toolbox');
vl_setup;

main_folder='C:\Users\kuruparans\Downloads\release_data (1)\release_data\';
%main_folder='E:\tmp\';

%type='vd16_pitts30k_conv5_3_vlad_preL2_intra_white_';
type='vd16_pitts30k_conv5_3_vlad_preL2_intra_white_release_data';

%im1_small_folder='col_small';
%im1_small_folder='named';
im1_small_folder='seg0';


feat_folder1=[main_folder,im1_small_folder, '\', type, '_db.bin'];


thres=0.07; % second order distance for acceptance to a cluster
min_clus=5; % minimum number of images for creation of a clutser
max_dis=1.7; % ignore higher variance classes for speed, maximum is 2

outputMainFolder='clusters';
outputSubFolder='distribution';


%mult_vlad_release(main_folder, im1_small_folder); % uncoment to run feature computation



[feat1, feat2, D]=feature_diff2(feat_folder1, feat_folder1);
[final_sol,clus_dist]=clustering_release(D, thres, min_clus, max_dis); 

im2folder



