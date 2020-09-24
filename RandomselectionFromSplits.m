% clc;    % Clear the command window.
% close all;  % Close all figures (except those of imtool.)
myFolder = 'C:\Users\kuruparans\Documents\seg16\named';
subfolder='\rand';
% Read the image from disk.
%rgbImage = imread('C:\Users\kuruparans\Documents\seg4\1.jpg');



if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end
filePattern = fullfile(myFolder, '*.jpg');
jpegFiles = dir(filePattern);

spliter=length(jpegFiles)/100;
n=1;
plotIndex=1;
for k = 1:spliter: length(jpegFiles)

    xmin=k;
    xmax=k+spliter-1;
    x=round(xmin+rand(1,n)*(xmax-xmin))
    baseFileName = jpegFiles(x).name
    fullFileName = fullfile(myFolder, baseFileName);
    rgbImage = imread(fullFileName);
    imshow(rgbImage); 
    imwrite(rgbImage, [myFolder,subfolder,'\img',num2str(plotIndex, '%.6d'),'.jpg']);
    plotIndex= plotIndex+1;

end

