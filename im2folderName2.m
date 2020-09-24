
%%%%%%%%%%%%% create output folders
accepts_folder=[main_folder, im1_small_folder, '/', outputMainFolder];
if( ~exist(accepts_folder, 'dir') )
    mkdir(accepts_folder);
end;
%%%%%%%%%%%%%%%%%%%%

sub_folder=[accepts_folder, '/', outputSubFolder, '/'];
if( exist(sub_folder, 'dir') )
    rmdir(sub_folder, 's' );
end;
mkdir(sub_folder);


myFodler=[main_folder, im1_small_folder]
filePattern = fullfile(myFolder, '*.jpg');
jpegFiles = dir(filePattern);
files={};
for k = 1:length(jpegFiles)
   baseFileName = jpegFiles(k).name;
   files{k}=baseFileName;
   fullFileName = fullfile(myFolder, baseFileName);
%  fprintf(1, 'Now reading %s\n', fullFileName);
   rgbImage = imread(fullFileName);
   %imwrite(rgbImage, [cluster_folder,'\img', num2str(k, '%.6d'),'.jpg']);
   %imwrite(rgbImage, [cluster_folder,'\img',files{k}]);

end
for i=1:max(final_sol)
    cluster_folder=[sub_folder, num2str(i)];

    if( exist(cluster_folder, 'dir') )
        rmdir( cluster_folder, 's' );
    end;
    mkdir(cluster_folder);
    
    for k=1:length(final_sol)
        if(final_sol(k)==i)
            val=k;
            fullFileName = fullfile(myFolder, files{k});
            rgbImage = imread(fullFileName);
            %im=imread([main_folder, im1_small_folder,'\img', num2str(val, '%.6d')], 'jpg');
            %imwrite(im, [cluster_folder,'\img', num2str(val, '%.6d'),'.jpg']);
            imwrite(rgbImage, [cluster_folder,'\img',files{k}]);
            nn=split(files{k},["_","."]);
            imwrite(rgbImage, [sub_folder,'\',nn{2},'_',nn{3},'_',num2str(i),'.jpg']);

        end;
    end;
end;