#include <stdio.h>

#define N (1024*1024)
#define M (1000000)


int main()
{
    float data[N]; int count = 0;
    int k = 524288;
    
    data[k] = 1.0f * k / N;
    printf("%f",data[k]);
    
    data[k] = data[k] * data[k] - 0.25f;
    printf("%f",data[k]);
    int sel;

    printf("data[%d] = %f\n", k, data[k]);
    return 0;
}