


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
            cluster{i} =[cluster{i}  val];
            fid = fopen( [cluster_folder,'\img', num2str(val, '%.6d'),'.csv'], 'w' );
                fprintf( fid, '%s,%d\n', num2str(i), val);
            fclose( fid );
            
            for h=length(plotIndex):-1:1
                val
                h

             
                if h>1
                    if val > cumi(h-1) 
                        Ib=Imgg{h};

                        subt=cumi(h-1)
                        ff=plotter{h};
                        break
                    end  
                    
                elseif  h==1
                    if val <= cumi(h) 
                        Ib=Imgg{h};
                        h
                        subt=0
                        ff=plotter{h};
                        break
                    end
%                     
%                 elseif 2 < h < length(plotIndex)-1
%                     if val <= cumi(length(cumi)-h) 
%                         Ib=Imgg{length(cumi)-h};
%                         length(cumi)-h
%                         subt=cumi(length(cumi)-h-1)
%                         ff=plotter{length(cumi)-h};
% 
%                     end
                end
            end
            
 
                figure(3)
                image(Ib);   %display image
                hold on
              %  scatter(ff(1,val-subt), ff(2,val-subt), 'b*');   %overlay some points
                labels = cellstr( num2str(i) ); 
                plot(ff(1,val-subt), ff(2,val-subt), 'bx')
                text(ff(1,val-subt), ff(2,val-subt), labels, 'VerticalAlignment','bottom', ...
                             'HorizontalAlignment','right')
                hold off
                F = getframe ;
                % save the image:
                imwrite(F.cdata,[cluster_folder,'\img', num2str(val, '%.6d'),'.jpg'])
                close(figure)
 
 



            
        end;
    end;
end;