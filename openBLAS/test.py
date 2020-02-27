from ctypes import *
import os
import numpy as np
import ctypes

mylib = cdll.LoadLibrary('%s/libmylib.so' % os.getcwd())
c_float_p = ctypes.POINTER(ctypes.c_float)



size = 4;

arr1 = np.array([1,0,1,0,0,1,0,2,0,0,1,0,2,2,0,1])
arr1 = arr1.astype(np.float32)
arr1_p = arr1.ctypes.data_as(c_float_p)

arr2 = np.array([1,0,1,0,0,1,0,2,0,0,1,0,2,2,0,1])
arr2 = arr2.astype(np.float32)
arr2_p = arr2.ctypes.data_as(c_float_p)

arr3 = np.zeros(size*size)
arr3 = arr3.astype(np.float32)
arr3_p = arr3.ctypes.data_as(c_float_p)


mylib.mat_mul_func(size, arr1_p, arr2_p, arr3_p)
print (arr3)
