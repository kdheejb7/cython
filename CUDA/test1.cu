#include <stdio.h>
#include <cuda.h>
#include <cuda_runtime.h>
#include "cublas_v2.h"
#define IDX2C(i,j,ld) (((j)*(ld))+(i))
#define m 4
#define n 4
#define k 4
extern "C" void mat_mul_func(int size, float *a, float *b, float *c){

	cudaError_t cudaStat;	//cudaMalloc status
	cublasStatus_t stat;	//CUBLAS functions status
	cublasHandle_t handle;	//CUBLAS context

	int i, j;
	

	//on the device
	float* d_a;
	float* d_b;
	float* d_c;

	cudaStat = cudaMalloc((void**)&d_a, m*k*sizeof(a));
	cudaStat = cudaMalloc((void**)&d_b, k*n*sizeof(b));
	cudaStat = cudaMalloc((void**)&d_c, m*n*sizeof(c));
	
	stat = cublasCreate(&handle);	//initialize CUBLAS context

	//copy matrixes from the host to the device
	stat = cublasSetMatrix(m, k, sizeof(a), a, m, d_a, m);
	stat = cublasSetMatrix(k, n, sizeof(*b), b, k, d_b, k);
	stat = cublasSetMatrix(m, n, sizeof(*c), c, m, d_c, m);

	float al = 1.0f;
	float bet = 0.0f;

	stat = cublasSgemm(handle, CUBLAS_OP_N, CUBLAS_OP_N, m, n, k, &al, d_a, m, d_b, k, &bet, d_c, m);

	stat = cublasGetMatrix(m, n, sizeof(*c), d_c, m, c, m);
	printf("c after Sgemm : \n");
	for(i=0; i<m; i++){
		for(j=0; j<n; j++){
			printf("%7.0f", c[IDX2C(i, j, m)]);
		}
		printf("\n");
	}

	cudaFree(d_a);
	cudaFree(d_b);
	cudaFree(d_c);

	cublasDestroy(handle);


	
}
int main(){
	return 0;
}
