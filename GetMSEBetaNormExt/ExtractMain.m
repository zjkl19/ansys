%ExtractMain
%功能：计算跨中单元各种损伤状况下，各单元的模态应变能及模态应变能变化率（暂时只算其中特定阶数模态）

%mse:模态单元应变能
tic;
clear;clc;

controlOption=[1 1 0];  %随机控制选项
                        %举例：[0 0 1]表示第1、2个单元不进行随机控制，第3个单元进行随机控制

%损伤单元弹性模量的损伤系数服从N(MU,SIGMA)
%MU=0.9; 
%SIGMA=MU*0.01;

%controlOption==0对应项不予考虑
MU=[0.95 0.9 0.97]; 
SIGMA=[MU(1)*0.01 MU(2)*0.01 MU(3)*0.01];

xlsFileName = 'mseResult.xlsx';

firstFileName='firstFile.inp';      %第1个拼接文件
secondFileName='secondFile.inp';
thirdFileName='thirdFile.inp';

sourcePath='e:\sen_result.txt'; %ansys计算结果存储文件路径
ansysPath='C:\progra~1\ANSYSI~1\v160\ansys\bin\winx64\ansys160.exe';    %ansys安装路径

inputFile='BeamExampleNoDamageSetPositionNoDama.inp';   %ansys cmd 中输入文件
outputFile='e:\ansysOutput.txt';    %ansys cmd中输出文件

%----------------------------------------------
%计算无损情况下各个单元的模态应变能
cmdStr=[ansysPath ' -b -p ane3fl -i ' inputFile ' -o ' outputFile];
system(cmdStr);
mseData=load(sourcePath);     %读取数据
mseNoDama=mseData;    %无损工况各单元单元应变能

%----------------------------------------------

inputFile='BeamExampleDamageCombine.inp';   %ansys cmd 中输入文件

loopCount=10;   %模拟次数
mseDama=[];  %损伤后各单元模态应变能
midFileStr=[];  %中间文件字符串
i=1;
while i<=loopCount
    R = normrnd(MU,SIGMA);    %损伤系数,0.9左右
    %防止随机数中出现R<0的情况
    %必须每个都>=0
    while R<0
        R = normrnd(MU,SIGMA);
    end
    
    for j=1:size(MU,2)
        if controlOption(j)==0
            R(j)=1;
        end
    end
    
    midFileStr=[];
    for j=1:size(MU,2)
        midFileStr=[midFileStr 'dFactor(' num2str(j) ')=' num2str(R(j)) char(13,10)'];     %第2个文件的内容
    end
    
    fid=fopen(secondFileName,'w');
    fprintf(fid,'%s\n',midFileStr);
    fclose(fid);
    
    fid1=fopen(firstFileName,'r');
    fid2=fopen(secondFileName,'r');
    fid3=fopen(thirdFileName,'r');
    Data1=fread(fid1);
    Data2=fread(fid2);
    Data3=fread(fid3);
    
    fid=fopen(inputFile,'w');   %合并写入的文件
    
    fwrite(fid,Data1);
    fwrite(fid,Data2);
    fwrite(fid,Data3);
    fclose(fid1);
    fclose(fid2);
    fclose(fid3);
    
    fclose(fid);
    
    cmdStr=[ansysPath ' -b -p ane3fl -i ' inputFile ' -o ' outputFile];
    
    system(cmdStr);
    
    mseData=load(sourcePath);     %读取数据
    
    mseDama=[mseDama mseData];
    
    disp(['progress:' num2str(i) 'th:' num2str(i*100/loopCount) '%']);
    toc;
    i=i+1;
end

nElems=size(mseDama,1);     %单元个数

sheetHeader={'id','seneNoDama'};
for i=1:loopCount
    sheetHeader{i+2}=i;
end

lst(1:nElems,1)=1:nElems;   %列表


sheetName=num2str(nElems);

xlRange = 'A1';
xlswrite(xlsFileName,sheetHeader,sheetName,xlRange)
xlRange = 'A2';
xlswrite(xlsFileName,lst,sheetName,xlRange)
xlRange = 'B2';
xlswrite(xlsFileName,mseNoDama,sheetName,xlRange)
xlRange = 'C2';
xlswrite(xlsFileName,mseDama,sheetName,xlRange)

%下一张表
%-------------------
sheetHeader={'id'};
for i=1:loopCount
    sheetHeader{i+1}=i;
end

div=repmat(mseNoDama,1,loopCount);  %除数扩展
betaResult=(mseDama-div)./div;
sheetNo = 2;    %存储"各单元各损伤工况模态应变能变化率"

sheetName=[num2str(nElems) '_beta'];

xlRange = 'A1';
xlswrite(xlsFileName,sheetHeader,sheetName,xlRange)
xlRange = 'A2';
xlswrite(xlsFileName,lst,sheetName,xlRange)
xlRange = 'B2';
xlswrite(xlsFileName,betaResult,sheetName,xlRange)

toc;