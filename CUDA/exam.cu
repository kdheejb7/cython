#include <stdio.h>
/*
#define N (1024*1024)
#define M (1000000)

__global__ void cudakernel(int *buf)
{
   int i = threadIdx.x + blockIdx.x * blockDim.x;
   buf[i] = i;
   for(int j = 0; j < M; j++)
      buf[i] = buf[i] * buf[i] + 1;
}

int main()
{
   int data[N]; 
   int count = 0;
   int *d_data;
   cudaMalloc(&d_data, N * sizeof(int));
   cudakernel<<<N/256, 256>>>(d_data);
   cudaMemcpy(data, d_data, N * sizeof(int), cudaMemcpyDeviceToHost);
   cudaFree(d_data); 

   int sel;
   printf("Enter an index: ");
   scanf("%d", &sel);
   printf("data[%d] = %d\n", sel, data[sel]);
}
*/

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