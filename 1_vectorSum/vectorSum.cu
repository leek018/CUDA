#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <iostream>
#include <cstring>
#include <string>
using namespace std;

#define NUM_DATA 512

__global__ void vecAdd(int *a,int *b,int *c)
{
    int tid = threadIdx.x;
    c[tid] = a[tid] + b[tid];
}

int main()
{
    int *a,*b,*c;
    int *d_a,*d_b,*d_c;
    
    int memSize = sizeof(int)*NUM_DATA;
    cout << "elements : " << NUM_DATA <<"\n";
   
    a = new int[NUM_DATA]; memset(a,0,memSize);
    b = new int[NUM_DATA]; memset(a,0,memSize);
    c = new int[NUM_DATA]; memset(a,0,memSize);

    for(int i = 0 ; i < NUM_DATA; i++)
    {
        a[i] = rand() % 10;
        b[i] = rand() % 10;
    }
    
    cudaMalloc(&d_a,memSize);
    cudaMalloc(&d_b,memSize);
    cudaMalloc(&d_c,memSize);

    cudaMemcpy(d_a,a,memSize,cudaMemcpyHostToDevice);
    cudaMemcpy(d_b,b,memSize,cudaMemcpyHostToDevice);
    
    vecAdd<<<1,NUM_DATA>>>(d_a,d_b,d_c);
    cudaDeviceSynchronize();
    cudaMemcpy(c,d_c,memSize,cudaMemcpyDeviceToHost);
    
    bool result = true;
    for(int i = 0 ; i < NUM_DATA; i++)
    {
        if(a[i] + b[i] != c[i]){
            cout << "Gpu has error in vecAdd\n";
            result = false;
        }
    }

    if(result)
        cout << "GPU WORKS WELL \n";
    
    cudaFree(d_a); 
    cudaFree(d_b); 
    cudaFree(d_c); 
    delete[] a; delete[] b; delete[] c;
    return 0;
}
 
