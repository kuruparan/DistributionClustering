function [feat1, feat2, D]=feature_diff2(folder1, folder2)

if(nargin==0)
    folder1='E:\tmp\im_a\';
    folder2='E:\tmp\im_b\';
    type1='vd16_pitts30k_conv5_3_vlad_preL2_intra_white_im_a_db.bin';
    type2='vd16_pitts30k_conv5_3_vlad_preL2_intra_white_im_b_db.bin';
    
    feat1 = load_feature([folder1,type1]);
    feat2 = load_feature([folder2,type2]);
else
    feat1 = load_feature([folder1]);
    feat2 = load_feature([folder2]);  
    
end;

feat1=single(feat1);
feat2=single(feat2);
D = vl_alldist2(feat1,feat2);



end