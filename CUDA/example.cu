// Kernel definition 
// Run on GPU

#include <stdio.h>
#define N 4
__global__ void add(int* c, const int* a, const int* b)
{
    int i = threadIdx.x;
    c[1] = a[1] + b[1];
}

void mat_mul_func(int size, float *arr1, float *arr2, float *arr3) {
	
    float *d_a, *d_b, *d_c; // device copies of a, b, c
    // Allocate space for device copies of a, b, c
    int _size = sizeof(float)*size;
    cudaMalloc((void **)&d_a, _size);
    cudaMalloc((void **)&d_b, _size);
    cudaMalloc((void **)&d_c, _size);
	
    // Copy a & b from the host to the device
    cudaMemcpy(d_a, &a, _size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, &b, _size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_c, &c, _size, cudaMemcpyHostToDevice);
	
    // Launch add() kernel on GPU
    add<<<N,1>>>(arr3, arr1, arr2);
	
    // Copy result back to the host
    cudaMemcpy(&c, d_c, size, cudaMemcpyDeviceToHost);
    for (int i = 0; i<size; i++)
	    printf("%d", c[i]);
    // Cleanup
    cudaFree(d_a); cudaFree(d_b); cudaFree(d_c);
    return 0;
}

/*
#include <stdio.h>
__global__ void add(int *a){
    *a = *a+2;
}
int main(void){
    int a = 3;
    int *d_a;

    cudaMalloc((void **)&d_a, sizeof(int));
    cudaMemcpy(d_a, &a, sizeof(int), cudaMemcpyHostToDevice);
    add<<<1,1>>>(d_a);
    cudaMemcpy(&a, d_a, sizeof(int), cudaMemcpyDeviceToHost);
    printf("%d",a);
    cudaFree(d_a);
    return 0;
}
*/

//그래픽 카드에 메모리 사용하기
/*
#include <stdio.h>
#define gpuErrchk(ans) { gpuAssert((ans), __FILE__, __LINE__); }
inline void gpuAssert(cudaError_t code, const char *file, int line, bool abort=true)
{
   if (code != cudaSuccess) 
   {
      fprintf(stderr,"GPUassert: %s %s %d\n", cudaGetErrorString(code), file, line);
      if (abort) exit(code);
   }
}

int main()
{
    int InputData[5] = {1, 2, 3, 4, 5};
    int OutputData[5] = {0};
 
    int* GraphicsCard_memory;
 
    //그래픽카드 메모리의 할당
    gpuErrchk( cudaMalloc(&GraphicsCard_memory, 5*sizeof(int)) );

    //PC에서 그래픽 카드로 데이터 복사
    cudaMemcpy(GraphicsCard_memory, InputData, 5*sizeof(int), cudaMemcpyHostToDevice);
 
    //그래픽 카드에서 PC로 데이터 복사
    cudaMemcpy(OutputData, GraphicsCard_memory, 5*sizeof(int), cudaMemcpyDeviceToHost);
 
    //결과 출력
    for( int i = 0; i < 5; i++)
    {
        printf(" OutputData[%d] : %d\n", i, OutputData[i]);
    }
 
    //그래픽 카드 메모리의 해체
    cudaFree(GraphicsCard_memory);
 
    return 0;
}
*/