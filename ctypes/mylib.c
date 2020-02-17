#include <stdio.h>


void arr_add_func(int size, float * arr1, float * arr2, float * arr3){
    for (int i=0; i<size; i++)
        arr3[i] = arr1[i]+arr2[i];
}
