function []=mult_vlad_release(main_folder, sub_folder_string)

%  Author: Relja Arandjelovic (relja@relja.info)

% This file contains a few examples of how to train and test CNNs for place recognition, refer to README.md for setup instructions, and to our project page for all relevant information (e.g. our paper): http://www.di.ens.fr/willow/research/netvlad/


%  The code samples use the GPU by default, if you want to use the CPU instead (very slow especially for training!), add `'useGPU', false` to the affected function calls (trainWeakly, addPCA, serialAllFeats, computeRepresentation)

% For a tiny example of running the training on a small dataset, which takes only a few minutes to run, refer to the end of this file.
% addpath('D:\matlab_code\vlfeat-0.9.20\toolbox');
% vl_setup
% addpath('C:\Users\Daniel\Documents\MATLAB\vlfeat-0.9.20\toolbox');
% vl_setup;

%clear all;
% Set the MATLAB paths
setup;
%227x227 image

% ---------- Use/test our networks

% Load our network
%netID= 'vd16_tokyoTM_conv5_3_vlad_preL2_intra_white';
netID = 'vd16_pitts30k_conv5_3_vlad_preL2_intra_white';  % best network according to proj. web page

paths= localPaths();

%load( sprintf('%s%s.mat','C:\Users\kuruparans\Documents\Clustering_w_Nevlad\Clustering_w_Nevlad\Clustering_w_Nevlad\Data\models\', netID), 'net' );

load( sprintf('%s%s.mat', paths.ourCNNs, netID), 'net' );
net= relja_simplenn_tidy(net);

%  Compute the image representation by simply running the forward pass using
% the network `net` on the appropriately normalized image
% (see `computeRepresentation.m`).

% im= vl_imreadjpeg({which('football.jpg')}); im= im{1}; % slightly convoluted because we need the full image path for `vl_imreadjpeg`, while `imread` is not appropriate - see `help computeRepresentation`
% feats= computeRepresentation(net, im); % add `'useGPU', false` if you want to use the CPU
% 
% 
% return;
% 
% To compute representations for many images, use the `serialAllFeats` function
% which is much faster as it uses batches and it moves the network to
% the GPU only once:
%
%          serialAllFeats(net, imPath, imageFns, outputFn);
%
%  `imageFns` is a cell array containing image file names relative to the `imPath` (i.e. `[imPath, imageFns{i}]` is a valid JPEG image), the representations are saved in binary format (single 4-byte floats). 
% Batch size used for computing the forward pass can be changed by adding the `batchSize` parameter, e.g. `'batchSize', 10`. Note that if your input images are not all of same size (they are in place recognition 
% datasets), you should set `batchSize` to 1.
% Set the output filenames for the database/query image representations

% base_dir = 'D:\utility_progs\data\group2\group2_small\';
% feature_save_dir = 'd:/utility_progs/feature_data/group2/';

% name_list ={};
% name_list{1} = 'books';
% name_list{2} = 'cereal';
% name_list{3} = 'cup';

base_dir = main_folder;
feature_save_dir = main_folder;
name_list{1} = sub_folder_string;

for i = 1:1
    
    dbTest.name = name_list{i};
    dbTest.dbPath = strcat(base_dir, name_list{i}, '\');   % path to image data
    dbTest.dbImageFns= relja_dir_image(dbTest.dbPath);
    
    feature_save_path = strcat(feature_save_dir, dbTest.name, '/');
    
    feature_save_path
    
%     strcat(dbTest.dbPath, dbTest.dbImageFns{i})   
%     im = vl_imreadjpeg({strcat(dbTest.dbPath, dbTest.dbImageFns{i})});
%     im = im{1};
%     feats= computeRepresentation(net, im );
%     break;
    
    if ~exist(feature_save_path)
        mkdir(feature_save_path);
    end
    
    paths.outPrefix = feature_save_path;
    
    dbFeatFn= sprintf('%s%s_%s_db.bin', paths.outPrefix, netID, dbTest.name);
    
    % Compute db/query image representations
    serialAllFeats(net, dbTest.dbPath, dbTest.dbImageFns, dbFeatFn, 'batchSize', 1); % adjust batchSize depending on your GPU / network size
    dbTest.numImages = length(dbTest.dbImageFns);
    
    fprintf('num images: %d\n', dbTest.numImages);
    
end


%% ******** how to read feature file
dbTest.numImages = length(dbTest.dbImageFns);

%%%%%%%%%%%%%%%%%%%  read features
% path='D:\utility_progs\feature_data\cmu_robot\vd16_pitts30k_conv5_3_vlad_preL2_intra_white_cmu_robot_db.bin';
% dbFeat= fread( fopen(path, 'rb'), inf, 'float32=>single');
% numImages=length(dbFeat)/4096;
% dbFeat= reshape(dbFeat, [], numImages);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



dbFeat= fread( fopen(dbFeatFn, 'rb'), inf, 'float32=>single');
dbFeat= reshape(dbFeat, [], dbTest.numImages);
nDims= size(dbFeat, 1);
% qFeat= dbFeat(:, dbTest.queryIDs);







% Measure recall@N
% mAP= relja_retrievalMAP(dbTest, struct('db', dbFeat, 'qs', qFeat), true);
% relja_display('Performance on %s (%s), %d-D: %.2f', dbTest.name, strMode, size(dbFeat,1), mAP*100);

% Measure recall@N
% addpath(paths.libYaelMatlab);
% [recall, ~, ~, opts]= testFromFn(dbTest, dbFeatFn, qFeatFn);
% plot(opts.recallNs, recall, 'ro-'); grid on; xlabel('N'); ylabel('Recall@N');

return;

