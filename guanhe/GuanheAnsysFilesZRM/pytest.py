# -*- coding: utf-8 -*-
"""
Created on Sun Sep 24 18:42:38 2017

@author: bdl
"""

"""
import numpy as np
from numpy.linalg import cholesky
import matplotlib.pyplot as plt

sampleNo = 1000
mu = np.array([[1, 5]])
Sigma = np.array([[10, 5], [5, 5]])
R = cholesky(Sigma).T
va,vc = np.linalg.eig(Sigma); R2 = (np.diag(va)**0.5)@vc.T

s1 = np.random.randn(sampleNo, 2) @ R + mu #法1
s2 = np.random.randn(sampleNo, 2) @ R2 + mu #法2
s3 = np.random.multivariate_normal(mu[0],Sigma,sampleNo) #法3

plt.plot(*s1.T,'.',label = 's1')
plt.plot(*s2.T,'.',label = 's2')
plt.plot(*s3.T,'.',label = 's3')
plt.axis('scaled')
plt.legend()
"""
import numpy as np
#print(np.random.randn(2, 4) )


#数组使用参考：
#http://blog.csdn.net/taoyanqi8932/article/details/52703686

loopCount=10    #循环模拟次数

controlOption=np.array([0,0,1])  #随机控制选项
                        #举例：[0 0 1]表示第1、2个单元不进行随机控制，第3个单元进行随机控制


    #防止随机数中出现R<0的情况
    #必须每个都>=0
    #while R<0:
    #    R=multiply(SIGMA,np.random.randn(1, MU.shape[0])) + MU    #损伤系数;MU.shape[0]:MU列数
  #controlOption==0对应项不予考虑
MU=np.array([1,1,0.9])
SIGMA=MU*0.01
R=np.multiply(SIGMA,np.random.randn(1, MU.shape[0])) + MU    #损伤系数;MU.schr(13)hape[0]:MU列数      

print(R)
midFileStr=''
for j in range(1,len(R[0])+1):
    midFileStr=midFileStr+'dFactor('+str(j)+')='+str(R[0,j-1])+chr(13)+chr(10)
      
print(R)

print(midFileStr) 
           
t = [
[1,2,0],
[1,-1,3],
[2,4,-1]
]

p=list(map(lambda x:[[i,0][i<0] for i in x],t))
print(p)

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

#os.system(cmdStr)

mseData = np.loadtxt(sourcePath)    #读取数据  
mseNoDama=np.transpose([mseData])    #无损工况各单元单元应变能

#mseNoDama=mseNoDama.T
#----------------------------------------------

inputFile='GuanheDamageCombine.inp'   #ansys cmd 中输入文件（组合文件）

mseData = np.loadtxt(sourcePath) 
mseData=np.transpose([mseData])

print(mseData)
print(type(mseData))


c=np.hstack((mseNoDama,mseData))

import pandas as pd

# prepare for data
data = np.arange(1,101).reshape((10,10))
data_df = pd.DataFrame(data)

# change the index and column name
data_df.columns = ['A','B','C','D','E','F','G','H','I','J']
data_df.index = ['a','b','c','d','e','f','g','h','i','j']

# create and writer pd.DataFrame to excel
writer = pd.ExcelWriter('Save_Excel.xlsx')
data_df.to_excel(writer,'page_1',float_format='%.5f') # float_format 控制精度
writer.save() 
 
 
 