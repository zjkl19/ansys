# -*- coding: utf-8 -*-
"""
Created on Sun Sep 24 18:42:38 2017

@author: bdl
"""

import numpy as np
import os


#数组使用参考：
#http://blog.csdn.net/taoyanqi8932/article/details/52703686

loopCount=2    #循环模拟次数

nElems=178    #输出单元
controlOption=np.zeros((nElems)) 
#controlOption=np.array([0,0,1])  #随机控制选项
                        #举例：[0 0 1]表示第1、2个单元不进行随机控制，第3个单元进行随机控制
controlOption[88]=1

#controlOption==0对应项不予考虑
MU=np.ones((nElems))
MU[88]=0.90
#MU=np.array([1,1,0.9])
SIGMA=MU*0.01

xlsFileName = 'mseResult.xlsx'

firstFileName='firstFile.inp'      #第1个拼接文件
secondFileName='secondFile.inp'
thirdFileName='thirdFile.inp'

sourcePath='e:\\sen_result.txt' #ansys计算结果存储文件路径
ansysPath='C:\\progra~1\\ANSYSI~1\\v160\\ansys\\bin\\winx64\\ansys160.exe'    #ansys安装路径

inputFile='GuanheNoDama.inp'   #ansys cmd 中输入文件（无损结构）
outputFile='e:\\ansysOutput.txt'    #ansys cmd中输出文件

#----------------------------------------------
#计算无损情况下各个单元的模态应变能
cmdStr=ansysPath + ' -b -p ane3fl -i ' + inputFile + ' -o ' + outputFile

os.system(cmdStr)

mseData = np.loadtxt(sourcePath)    #读取数据  
mseNoDama=np.transpose([mseData])    #无损工况各单元单元应变能 
#----------------------------------------------

inputFile='GuanheDamageCombine.inp'   #ansys cmd 中输入文件（组合文件）

#mseDama=[]  损伤后各单元模态应变能
midFileStr=''  #中间文件字符串
i=1

while i<=loopCount:
    R=np.multiply(SIGMA,np.random.randn(1, MU.shape[0])) + MU    #损伤系数;MU.shape[0]:MU列数
      
    #防止随机数中出现R<0的情况
    #必须每个都>=0
    #while R<0:
    #    R=multiply(SIGMA,np.random.randn(1, MU.shape[0])) + MU    #损伤系数;MU.shape[0]:MU列数
    
    for j in range(0,len(R[0])):
        if controlOption[j]==0:
             R[0,j]=1

    midFileStr=[]
    
    midFileStr=''
    for j in range(0,len(R[0])):
        midFileStr=midFileStr+'dFactor('+str(j+1)+')='+str(R[0,j])+chr(13)+chr(10)
                
    
    with open(secondFileName, 'w') as f:
        f.write(midFileStr);
    
    with open(firstFileName,'rb') as f1:
        data1 = f1.read()
    
    with open(secondFileName,'rb') as f2:
        data2 = f2.read()
    
    with open(thirdFileName,'rb') as f3:
        data3 = f3.read()
    
    with open(inputFile, 'wb') as f:
        f.write(data1)
        f.write(data2)
        f.write(data3)
    
    cmdStr=ansysPath + ' -b -p ane3fl -i ' + inputFile + ' -o ' + outputFile
    
    os.system(cmdStr)
    
    mseData = np.loadtxt(sourcePath) 
    mseData=np.transpose([mseData])
    
    if i==1:
        mseDama=mseData    #损伤后各单元模态应变能
    else:
        mseDama=np.hstack((mseDama,mseData))
        
  
    print('progress:' + str(i) + 'th:' + str(i*100/loopCount)+'%')
    
    i=i+1

import pandas as pd

nElems=mseDama.shape[0]      #单元个数

sheetHeader=['seneNoDama']   #第1个表头id需要自己补

for i in range(0,loopCount):
    sheetHeader.append(i+1);

lst=[n for n in range(1,nElems+1)]   #列表

sheetName=str(nElems)

mseCombine=np.hstack((mseNoDama,mseDama))

# prepare for data
data_df = pd.DataFrame(mseCombine)
# change the index and column name
data_df.columns = sheetHeader
data_df.index = lst

# create and writer pd.DataFrame to excel
writer = pd.ExcelWriter(xlsFileName)
data_df.to_excel(writer,sheetName,float_format='%.5f') # float_format 控制精度
#writer.save() 

#下一张表
#-------------------
sheetHeader=[]    #空list,#第1个表头id需要自己补
for i in range(0,loopCount):
    sheetHeader.append(i+1)

div=mseNoDama#除数扩展,对应matlabdiv=repmat(mseNoDama,1,loopCount)  
betaResult=(mseDama-div)/div    #对应matlab ./

#第2张表存储"各单元各损伤工况模态应变能变化率"


sheetName=str(nElems)+'_beta'

# prepare for data
data_df2 = pd.DataFrame(betaResult)
# change the index and column name
data_df2.columns = sheetHeader
data_df2.index = lst

# create and writer pd.DataFrame to excel
#writer = pd.ExcelWriter(xlsFileName)
data_df2.to_excel(writer,sheetName,float_format='%.5f') # float_format 控制精度
writer.save() 

"""
xlsxFileName='fitResult.xlsx'
sheetName='Sheet1'

data=xlrd.open_workbook(xlsxFileName)
sh=data.sheet_by_name(sheetName)

print(sh.cell_value(0,0))
"""