#include <stdio.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <cublas.h>
#include <iostream>



using namespace std;



void checkCUBLAS(cublasStatus status)
{
    if (status != CUBLAS_STATUS_SUCCESS)
        cout << "[ERROR] CUBLAS " << status << endl;
}

void print(char* title, float* src, int h, int w)
{
    cout << title << endl;
    for (int y = 0; y < h; y++) 
    {
        for (int x = 0; x < w; x++) 
        {
            int index = y * w + x;
            printf("%5.0f", src[index]);
        }
        printf("\n");
    }
    printf("\n");
}


int main(int argc, char *argv[])
{

    const int N = 2;// Height
    const int M = 5;// Width
    float* a = new float[M * N];
    float* a_d;

    for (int i = 0; i < M*N; i++) 
        a[i] = i;

    print("src", a, N, M);
    checkCUBLAS(cublasInit());
    checkCUBLAS(cublasAlloc(M*N, sizeof(float), (void**)&a_d));
    checkCUBLAS(cublasSetMatrix(M, N, sizeof(float), a, M, a_d, M));

    float alpha = 2;
    // a_d[j] = alpha * a_d[j]

    cublasSscal(M*N, alpha, a_d, 1);
    checkCUBLAS(cublasGetMatrix(M, N, sizeof(float), a_d, M, a, M));
    print("src * 2", a, N, M);

    cudaThreadSynchronize();
    checkCUBLAS(cublasFree(a_d));
    checkCUBLAS(cublasShutdown());

    delete []a;

    return 0;
}
