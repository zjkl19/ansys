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
import os
import xlwt

import datetime

starttime = datetime.datetime.now()

#long running



m=[-1,-2,-3]

path=os.sys.path[0]
w=xlwt.Workbook()
ws=w.add_sheet('test')

for i in range(0,len(m)):
    ws.write(i,2,m[i])

localPath=os.path.join(path,'example.xls')
w.save(localPath)

for i in range(0,99999999):
    i=i+1
endtime = datetime.datetime.now()


print((endtime - starttime).seconds)
 
 