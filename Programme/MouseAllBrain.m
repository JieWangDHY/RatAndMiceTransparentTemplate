clear all;
clc;

filePath        = 'I:\WIPM\4Manuscript\2021\8Patent\Mouse\MouseCoro';

AllFile         = dir([filePath '\*.jpg']);

for i = 1:length(AllFile)
    FileName            = AllFile(i).name;
    FileDir             = [filePath filesep FileName];
    ImgData             = imread(FileDir);
    ImgNewData          = im2gray(ImgData);

    for j = 1:size(ImgNewData, 1)
            for k = 1:size(ImgNewData, 2)
                if(ImgNewData(j, k)<100 |ImgNewData(j, k)>140)
                    ImgNewData(j, k) = 255;
                end
            end
    end
    
    for j = 1:size(ImgNewData, 1)
            for k = 1:size(ImgNewData, 2)
                if(ImgNewData(j, k)<140 & ImgNewData(j, k)>100)
                    ImgNewData(j, k) = 0;
                end
            end
    end
    
    for j = 1:size(ImgNewData, 1)
            for k = 1:size(ImgNewData, 2)
                if(ImgNewData(j, k)>0)
                    ImgNewData(j, k) = 255;
                end
            end
    end
    
    NewData         = 255-ImgNewData; 
    C1              = sum(NewData);
    R1              = sum(NewData');
    normalvalue     = 5000;
    for i = 1:length(C1)
        if(C1(i)>normalvalue)
            L   = i;
        end
    end
    for i = length(C1):-1:1
        if(C1(i)>normalvalue)
            R   = i;
        end
    end
    for i = 1:length(R1)
        if(R1(i)>normalvalue)
            U   = i;
        end
    end
    for i = length(R1):-1:1
        if(R1(i)>normalvalue)
            D   = i;
        end
    end
    
    CutImgData      = ImgNewData(D:U, R:L);
    figure(3)
%     image(CutImgData)
    NewFileName     = ['Mice_' FileName(end-6:end)];
    NewDir          = [filePath filesep NewFileName];

    imwrite(CutImgData, NewDir);    

end