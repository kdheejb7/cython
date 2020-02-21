#include <stdio.h>


void arr_add_func(int size, float * arr1, float * arr2, float * arr3){

    int i,j,k;
    int sum;

    for(i=0; i<size; i++){
        for(j=0; j<size; j++){
            sum=0;
            for(k=0; k<size; k++){
                sum+=arr1[i*size+k]*arr2[k*size +j];
            }
            arr3[i*size+j]=sum;
        }
    }
 

}
