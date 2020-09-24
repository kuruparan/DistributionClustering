
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



for i=1:max(final_sol)
    cluster_folder=[sub_folder, num2str(i)];

    if( exist(cluster_folder, 'dir') )
        rmdir( cluster_folder, 's' );
    end;
    mkdir(cluster_folder);
    numPlotsC=10;
    numPlotsR=10;
    color = {'red','green','yellow','white','magenta','cyan','black','green','red','green','yellow','white','magenta','cyan','black'};

    for k=1:length(final_sol)
        if(final_sol(k)==i)
            val=k;
            r=floor(val/15);
            c=mod(val,15);
            im=imread([main_folder, im1_small_folder,'\img', num2str(val, '%.6d')], 'jpg');
            image277 = imresize(im, [277, 277]);
            siz=round(size(image277)/2);
            position=siz(1:2);
            
%             redChannel = im(:, :, 1);
%             greenChannel = im(:, :, 2);
%             blueChannel = im(:, :, 3);
%             if mod(i,3)==0 
%                 redChannel=255* ones(277);
%             elseif mod(i,3)==2
%                      greenChannel=255* ones(277);
%             else mod(i,3)==1
%                      blueChannel=255* ones(277);
%             end
%             im2= cat(3, redChannel, greenChannel, blueChannel);    
            im = insertText(im,[0 0], num2str(i),'FontSize',108,'BoxOpacity',0.1,'TextColor','white');
            subplot(numPlotsR, numPlotsC,val);

            imshow(im);
            drawnow;

            %subplot(numPlotsR, numPlotsC,val);
            %imshow(im2);
            %drawnow;
            imwrite(im, [main_folder, im1_small_folder,'\segmented','\img_out', num2str(val, '%.6d'),'.jpg']);

            imwrite(im, [cluster_folder,'\img', num2str(val, '%.6d'),'.jpg']);
        end;
    end;
end;

%im2Fullimage
