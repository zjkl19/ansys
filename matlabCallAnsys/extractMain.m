%extractMain
%������ȡansys�����ASCII�ļ��еĽ��������������
tic;
clear;clc;

firstFileName='firstFile.inp';      %��1��ƴ���ļ�
secondFileName='secondFile.inp';
thirdFileName='thirdFile.inp';

sourcePath='d:\sen_result.txt'; %ansys�������洢�ļ�·��
ansysPath='C:\progra~1\ANSYSI~1\v160\ansys\bin\winx64\ansys160.exe';    %ansys��װ·��

inputFile='E:\niujie\BeamExampleDamage\BeamExampleDamageTotal.inp';   %ansys cmd �������ļ�
outputFile='d:\ansysOutput.txt';    %ansys cmd������ļ�

damaFactorArray=[];   %������������
cnst=0.9;       %�ۼӳ���
result=[];  %���ս��


loopCount=100;
noDamaResult=ones(loopCount,1)*5.938;

i=1;
while i<=loopCount
    rndNum=rand;  %����һ��0~1����̫�ֲ������
    
    damaFactorArray=[damaFactorArray;cnst+rndNum*0.1];
    
    midFileStr=['rndNum=' num2str(rndNum)];     %��2���ļ�������
    
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
    
    rData=load(sourcePath);     %��ȡ����
    
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