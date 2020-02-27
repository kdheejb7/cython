#include <stdio.h>
#include <iostream>
#include <cublas.h>
#include "cublas_v2.h"
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
using namespace std;

#define N 4
int main(){
    cublasHandle_t handle;
    float arr1[] = {1,0,1,0,0,1,0,2,0,0,1,0,2,2,0,1};
    float arr2[] = {1,0,1,0,0,1,0,2,0,0,1,0,2,2,0,1};
    float arr3[] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
    float* arr1_d;
    float* arr2_d;
    float* arr3_d;

    cublasCreate(&handle);
    cublasAlloc(N*N, sizeof(float), (void**)&arr1_d);
    cublasAlloc(N*N, sizeof(float), (void**)&arr2_d);
    cublasAlloc(N*N, sizeof(float), (void**)&arr3_d);
    cublasSetMatrix(N, N, sizeof(float), arr1, N, arr1_d, N);
    cublasSetMatrix(N, N, sizeof(float), arr2, N, arr2_d, N);
    float alpha = 1;
    float beta = 0;
    cublasSgemm(handle, CUBLAS_OP_N, CUBLAS_OP_N, N, N, N, &alpha, arr1_d, N, arr2_d, N, &beta, arr3_d, N);

    cublasGetMatrix(N, N, sizeof(float), arr3_d, N, arr3, N);

    cudaThreadSynchronize();
    cublasFree(arr1_d);
    cublasFree(arr2_d);
    cublasFree(arr3_d);

    cublasShutdown();
    for(int i=0; i<16; i++)
    	printf("%f",arr3_d[i]);

    return 0;
}
