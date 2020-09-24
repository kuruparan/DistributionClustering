myFolder = 'C:\Users\kuruparans\Documents\seg7';
subfolder='\named';
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end
filePattern = fullfile(myFolder, '*.jpg');
jpegFiles = dir(filePattern);
for k = 1:length(jpegFiles)
  baseFileName = jpegFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
%  fprintf(1, 'Now reading %s\n', fullFileName);
  imageArray = imread(fullFileName);
  image277 = imresize(imageArray, [277, 277]);

  t=k-1;
  imwrite(image277, [myFolder,subfolder,'\img', num2str(t, '%.6d'),'.jpg']);
end