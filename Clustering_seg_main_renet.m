clear all;

% needs vl_feat toolbox from oxford, http://www.vlfeat.org/
%addpath('C:\Users\kuruparans\Downloads\vlfeat-0.9.21-bin\vlfeat-0.9.21\toolbox');
addpath('C:\Users\kuruparans\Documents\vlfeat-0.9.21-bin\vlfeat-0.9.21\toolbox');

%addpath('C:\Users\Daniel\Documents\MATLAB\vlfeat-0.9.20\toolbox');
vl_setup;

main_folder='C:\Users\kuruparans\Documents\release_data (1)\release_data\';
%main_folder='E:\tmp\';
type='vd16_pitts30k_conv5_3_vlad_preL2_intra_white_resnet50_';

%im1_small_folder='col_small';
%im1_small_folder='named';
myFolder = 'C:\Users\kuruparans\Documents\release_data (1)\release_data\seg20\';
im1_small_folder='seg20';

%feat_folder1=[main_folder,im1_small_folder, '\', type, im1_small_folder, '_db.mat'];
%feat_folder1=[main_folder,im1_small_folder, '\', type, '_db.bin'];


thres=0.5; % second order distance for acceptance to a cluster
min_clus=2; % minimum number of images for creation of a clutser
max_dis=1.1; % ignore higher variance classes for speed, maximum is 2

outputMainFolder='clusters_resnet50_releasekd2';
outputSubFolder='distribution';



%mult_vlad_release(main_folder, im1_small_folder); % uncoment to run feature computation

%[D]= resnetfeat(myFolder,im1_small_folder)

feat_folder1=[main_folder,im1_small_folder, '\', type, im1_small_folder, '_db.mat'];

outt=load(feat_folder1)
D2=outt.D;
D=D2./1000;

%[final_sol,clus_dist]=clustering_release(D, thres, min_clus, max_dis); 

[final_sol,clus_dist]=clustering_release2_kdtree(D, thres, min_clus, max_dis,9); 

%[final_sol,clus_dist]=clustering_release_for_many_objectDetection5mini(D, thres, min_clus, max_dis,9); 

%im2Fullimage
%ReconstructImage2
%ReconstructImage

im2folder



