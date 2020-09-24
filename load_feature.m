function feat = load_feature(feature_path)

p=fopen(feature_path, 'rb');
feat = fread(p, inf, 'float32=>single');
num_img = size(feat,1)/4096;

feat = reshape(feat, [], num_img);
fclose(p);