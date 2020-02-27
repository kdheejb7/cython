#include <cblas.h>
#include <stdio.h>

void mat_mul_func(int size, float *A, float *B, float *C)
{
  
  cblas_sgemm(CblasColMajor, CblasNoTrans, CblasNoTrans, size, size, size, 1 ,A, size, B, size,0,C,size);

}
int main(){
  return 0;
}
