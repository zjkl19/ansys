%ExtractMain
%���ܣ�������е�Ԫ��������״���£�����Ԫ��ģ̬Ӧ���ܼ�ģ̬Ӧ���ܱ仯�ʣ���ʱֻ��һ��ģ̬��

%mse:ģ̬��ԪӦ����
tic;
clear;clc;

damaFactor=[0.05 0.10 0.20 0.30];   %��������ϵ��

firstFileName='firstFile.inp';      %��1��ƴ���ļ�
secondFileName='secondFile.inp';
thirdFileName='thirdFile.inp';

sourcePath='d:\sen_result.txt'; %ansys�������洢�ļ�·��
ansysPath='C:\progra~1\ANSYSI~1\v160\ansys\bin\winx64\ansys160.exe';    %ansys��װ·��

inputFile='BeamExampleNoDamage.inp';   %ansys cmd �������ļ�
outputFile='d:\ansysOutput.txt';    %ansys cmd������ļ�

%----------------------------------------------
%������������¸�����Ԫ��ģ̬Ӧ����
cmdStr=[ansysPath ' -b -p ane3fl -i ' inputFile ' -o ' outputFile];
system(cmdStr);
mseData=load(sourcePath);     %��ȡ����
mseNoDama=mseData;    %���𹤿�����Ԫ��ԪӦ����

%----------------------------------------------

inputFile='BeamExampleDamageCombine.inp';   %ansys cmd �������ļ�
loopCount=size(damaFactor,2);   %����������˹����Ĵ���
mseDama=[];  %���˺����Ԫģ̬Ӧ����
i=1;
while i<=loopCount
        
    midFileStr=['dFactor=' num2str(1-damaFactor(i))];     %��2���ļ�������
    
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
    
    mseData=load(sourcePath);     %��ȡ����
    
    mseDama=[mseDama mseData];
    
    disp(['progress:' num2str(i) 'th:' num2str(i*100/loopCount) '%']);
    toc;
    i=i+1;
end

nElems=size(mseDama,1);     %��Ԫ����

xlsFileName = 'mseResult.xlsx';

sheetHeader={'id','seneNoDama'};
for i=1:loopCount
    sheetHeader{i+2}=damaFactor(i);
end

lst(1:nElems,1)=1:nElems;   %�б�

%sheetNo = 1;    %�洢"����Ԫ[����ģ̬Ӧ���� �����˹���ģ̬Ӧ����]"

interStr=num2str(damaFactor(1:end));
while strfind(interStr,'  ')
    interStr = strrep(interStr,'  ',' ');
end
interStr=strrep(interStr,' ','-');

sheetName=[num2str(nElems) '_', interStr , '_sene'];

xlRange = 'A1';
xlswrite(xlsFileName,sheetHeader,sheetName,xlRange)
xlRange = 'A2';
xlswrite(xlsFileName,lst,sheetName,xlRange)
xlRange = 'B2';
xlswrite(xlsFileName,mseNoDama,sheetName,xlRange)
xlRange = 'C2';
xlswrite(xlsFileName,mseDama,sheetName,xlRange)

%-------------------
sheetHeader={'id'};
for i=1:loopCount
    sheetHeader{i+1}=damaFactor(i);
end

div=repmat(mseNoDama,1,loopCount);  %������չ
betaResult=(mseDama-div)./div;
sheetNo = 2;    %�洢"����Ԫ�����˹���ģ̬Ӧ���ܱ仯��"

sheetName=[num2str(nElems) '_', interStr , '_beta'];

xlRange = 'A1';
xlswrite(xlsFileName,sheetHeader,sheetName,xlRange)
xlRange = 'A2';
xlswrite(xlsFileName,lst,sheetName,xlRange)
xlRange = 'B2';
xlswrite(xlsFileName,betaResult,sheetName,xlRange)

toc;