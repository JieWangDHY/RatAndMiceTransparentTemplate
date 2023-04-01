filePath        = 'I:\WIPM\4Manuscript\2021\8Patent\Mouse\MouseCrop';

AllFile             = dir([filePath '\*.jpg']);

for i = 1:length(AllFile)
    FileName        = AllFile(i).name;
%     FileName        = 'Mice_077.jpg';
    FileDir         = [filePath '\' FileName];
    data2           = imread(FileDir);
    data2double     = double(data2);
    dataLoc         = find(data2double>200);
    dataLineLoc     = find(data2double<200);
    data2double(dataLineLoc)    = 255;  % for white color template
%     data2double(dataLineLoc)    = 0;  % for black color template
    alphadata       = data2double;
    alphadata(dataLoc)  = 0;
    alphadata(dataLineLoc)  = 1;
    SaveName        = [FileName(1:end-3) 'png'];
    imwrite(data2double, [filePath '\' SaveName], 'Alpha',alphadata);
end