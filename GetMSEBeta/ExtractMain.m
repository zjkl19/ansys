%ExtractMain
%功能：计算跨中单元各种损伤状况下，各单元的模态应变能及模态应变能变化率（暂时只算一阶模态）

%mse:模态单元应变能
tic;
clear;clc;

damaFactor=[0.05 0.10 0.20 0.30];   %损伤因子系数

firstFileName='firstFile.inp';      %第1个拼接文件
secondFileName='secondFile.inp';
thirdFileName='thirdFile.inp';

sourcePath='d:\sen_result.txt'; %ansys计算结果存储文件路径
ansysPath='C:\progra~1\ANSYSI~1\v160\ansys\bin\winx64\ansys160.exe';    %ansys安装路径

inputFile='BeamExampleNoDamage.inp';   %ansys cmd 中输入文件
outputFile='d:\ansysOutput.txt';    %ansys cmd中输出文件

%----------------------------------------------
%计算无损情况下各个单元的模态应变能
cmdStr=[ansysPath ' -b -p ane3fl -i ' inputFile ' -o ' outputFile];
system(cmdStr);
mseData=load(sourcePath);     %读取数据
mseNoDama=mseData;    %无损工况各单元单元应变能

%----------------------------------------------

inputFile='BeamExampleDamageCombine.inp';   %ansys cmd 中输入文件
loopCount=size(damaFactor,2);   %计算各种损伤工况的次数
mseDama=[];  %损伤后各单元模态应变能
i=1;
while i<=loopCount
        
    midFileStr=['dFactor=' num2str(1-damaFactor(i))];     %第2个文件的内容
    
    fid=fopen(secondFileName,'w');
    fprintf(fid,'%s\n',midFileStr);
    fclose(fid);
    
    fid1=fopen(firstFileName,'r');
    fid2=fopen(secondFileName,'r');
    fid3=fopen(thirdFileName,'r');
    Data1=fread(fid1);
    Data2=fread(fid2);
    Data3=fread(fid3);
    
    fid=fopen(inputFile,'w');
    fwrite(fid,Data1);
    fwrite(fid,Data2);
    fwrite(fid,Data3);
    fclose(fid1);
    fclose(fid2);
    fclose(fid3);
    
    cmdStr=[ansysPath ' -b -p ane3fl -i ' inputFile ' -o ' outputFile];
    
    system(cmdStr);
    
    mseData=load(sourcePath);     %读取数据
    
    mseDama=[mseDama mseData];
    
    disp(['progress:' num2str(i) 'th:' num2str(i*100/loopCount) '%']);
    toc;
    i=i+1;
end

xlsFileName = 'mseResult.xlsx';
sheetNo = 1;    %第1个标签存储"各单元[无损模态应变能 各损伤工况模态应变能]"
xlRange = 'B2';
xlswrite(xlsFileName,mseNoDama,sheetNo,xlRange)
xlRange = 'C2';
xlswrite(xlsFileName,mseDama,sheetNo,xlRange)


div=repmat(mseNoDama,1,loopCount);  %除数扩展
betaResult=(mseDama-div)./div;
sheetNo = 2;    %第2个标签存储"各单元各损伤工况模态应变能变化率"
xlRange = 'B2';
xlswrite(xlsFileName,betaResult,sheetNo,xlRange)

toc;