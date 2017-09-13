%extractMain
%功能提取ansys输出到ASCII文件中的结果，并进行整合
tic;
clear;clc;

firstFileName='firstFile.inp';      %第1个拼接文件
secondFileName='secondFile.inp';
thirdFileName='thirdFile.inp';

sourcePath='d:\sen_result.txt'; %ansys计算结果存储文件路径
ansysPath='C:\progra~1\ANSYSI~1\v160\ansys\bin\winx64\ansys160.exe';    %ansys安装路径

inputFile='E:\niujie\BeamExampleDamage\BeamExampleDamageTotal.inp';   %ansys cmd 中输入文件
outputFile='d:\ansysOutput.txt';    %ansys cmd中输出文件

damaFactorArray=[];   %损伤因子数组
cnst=0.9;       %累加常数
result=[];  %最终结果


loopCount=100;
noDamaResult=ones(loopCount,1)*5.938;

i=1;
while i<=loopCount
    rndNum=rand;  %产生一个0~1的正太分布随机数
    
    damaFactorArray=[damaFactorArray;cnst+rndNum*0.1];
    
    midFileStr=['rndNum=' num2str(rndNum)];     %第2个文件的内容
    
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
    
    rData=load(sourcePath);     %读取数据
    
    result=[result;rData];
    
    disp(['progress:' num2str(i) 'th:' num2str(i*100/loopCount) '%']); 
    i=i+1;
end

xlsFileName = 'SeneResult.xlsx';
sheetNo = 1;
xlRange = 'B2';
xlswrite(xlsFileName,damaFactorArray,sheetNo,xlRange)
xlRange = 'C2';
xlswrite(xlsFileName,result,sheetNo,xlRange)

toc;