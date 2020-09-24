
main_folder='C:\Users\kuruparans\Documents\SIFT_check\slice';
im1_small_folder='July_release2';


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
cumi=cumsum(plotIndex);
cumi2=cumsum(plotIndex2);
cumi=cumi2
% for i=1:max(final_sol)
%     cluster_folder=[sub_folder, num2str(i)];
% 
%     if( exist(cluster_folder, 'dir') )
%         rmdir( cluster_folder, 's' );
%     end;
%     
%     mkdir(cluster_folder);
% 
%     cluster{i} =[];
    
   for h=length(plotIndex):-1:1
        
    figure
    Ib=Imgg{h};
    image(Ib);   %display image
    hold on
    for k=1:length(final_sol)
        if final_sol(k)>0 && final_sol(k)<100
        %if(final_sol(k)==i)
        %    val=k;
        %    cluster{i} =[cluster{i}  val];
            
        %    fid = fopen( [cluster_folder,'\img', num2str(val, '%.6d'),'.csv'], 'w' );
        %        fprintf( fid, '%s,%d\n', num2str(i), val);
        %    fclose( fid );
            val=k;
                val;
                h;
                if  h==1
                    if val <= cumi(h) 
                        Ib=Imgg{h};
                        h;
                        subt=0;
                        ff=plotter{h};
                       % break
                                                 %  scatter(ff(1,val-subt), ff(2,val-subt), 'b*');   %overlay some points
                        labels = cellstr( num2str(final_sol(k)) ); 
                        plot(ff(1,val-subt), ff(2,val-subt), 'bx')
                        text(ff(1,val-subt), ff(2,val-subt), labels, 'VerticalAlignment','bottom', ...
                                     'HorizontalAlignment','right')
                        hold on
                    end
             
                  elseif h>1
                    if  val > cumi(h-1) && val < cumi(h)
                        Ib=Imgg{h};

                        subt=cumi(h-1);
                        ff=plotter{h};
                       % break
                                                                        %  scatter(ff(1,val-subt), ff(2,val-subt), 'b*');   %overlay some points
                        labels = cellstr( num2str(final_sol(k)) ); 
                        plot(ff(1,val-subt), ff(2,val-subt), 'bx')
                        text(ff(1,val-subt), ff(2,val-subt), labels, 'VerticalAlignment','bottom', ...
                                     'HorizontalAlignment','right')
                        hold on
                        
                    end  
                    

                end
            end
        end
        F = getframe ;
        % save the image:
        imwrite(F.cdata,[sub_folder,'\img', num2str(h, '%.6d'),'.jpg'])
        close(figure)
 
 
            
       end
            







