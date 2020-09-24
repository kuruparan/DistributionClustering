

main_folder='C:\Users\kuruparans\Documents\SIFT_check\';
im1_small_folder='img';

outputMainFolder='clusters';
outputSubFolder='distribution';

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

siz=size(da)

for i=1:max(final_sol)
    cluster_folder=[sub_folder, num2str(i)];

    if( exist(cluster_folder, 'dir') )
        rmdir( cluster_folder, 's' );
    end;
    
    mkdir(cluster_folder);

    cluster{i} =[];
    for k=1:length(final_sol)
        if(final_sol(k)==i)
            val=k;
            cluster{i} =[cluster{i}  val]
            fid = fopen( [cluster_folder,'\img', num2str(val, '%.6d'),'.csv'], 'w' );
                fprintf( fid, '%s,%d\n', num2str(i), val);
            fclose( fid );

        
                
            %im=imread([main_folder, im1_small_folder,'\img', num2str(val, '%.6d')], 'jpg');
            %imwrite(im, [cluster_folder,'\img', num2str(val, '%.6d'),'.jpg']);
            
        end;
    end;
end;