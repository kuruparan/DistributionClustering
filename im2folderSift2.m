


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

            if val<=siz(2)

                figure(3)
                image(Ia);   %display image
                hold on
                scatter(fa(1,val), fa(2,val), 'r*');   %overlay some points
                hold off
                F = getframe ;
                % save the image:
                imwrite(F.cdata,[cluster_folder,'\img', num2str(val, '%.6d'),'.jpg'])
                close(figure)
 
            
            
            elseif val> siz(2) 

                figure(4)
                image(Ib);   %display image
                hold on
                scatter(fb(1,val-siz(2)), fb(2,val-siz(2)), 'b*');   %overlay some points
                hold off
                F2 = getframe ;
                % save the image:
                imwrite(F2.cdata,[cluster_folder,'\img2', num2str(val, '%.6d'),'.jpg'])
                close(figure)
            end
                
            %im=imread([main_folder, im1_small_folder,'\img', num2str(val, '%.6d')], 'jpg');
            %imwrite(im, [cluster_folder,'\img', num2str(val, '%.6d'),'.jpg']);
            
        end;
    end;
end;