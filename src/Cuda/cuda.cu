#include "cuda.h"
#include "improc.h"
#include <stdio.h>
#include <chrono>

#include <iostream>

#define PI 3.14159265
#define NUM_STREAMS 2
#define WIDTH	640
#define HEIGHT	480


using namespace std;



void cv::gpu::mj::blur(const int rows,const int cols, const int k, unsigned char *src, unsigned char* dst){
	
	auto start1 = std::chrono::system_clock::now();
	int N = WIDTH;
	int M = HEIGHT;
	//cudaSetDeviceFlags(cudaDeviceMapHost);
	
	unsigned char* gpudataSrc;
	unsigned char* gpudataOut;
	unsigned char* cpudataOut;
	
	int size = sizeof(unsigned char)*rows*cols;
	
	cudaMallocHost 	((void **)&cpudataOut,size);	
	
	auto stop1 = std::chrono::system_clock::now();
	cudaMalloc((void **)&gpudataSrc, size);
	cudaMalloc((void **)&gpudataOut, size);
	//cudaHostGetDevicePointer((void **)&gpudataOut,  (void *) dst , 0);
	cudaMemcpy(gpudataSrc, src, size, cudaMemcpyHostToDevice);
	
	auto stop2 = std::chrono::system_clock::now();
	dim3 threadsPerBlock(16,16);
	dim3 numbBlocks(N/ threadsPerBlock.x,M/ threadsPerBlock.y); 
	//auto start1 = std::chrono::system_clock::now();
	//cudaDeviceSynchronize();
	auto stop3 = std::chrono::system_clock::now();
	//blur_noShare_GPU<<<numbBlocks, threadsPerBlock>>>(rows, cols, k, gpudataSrc, gpudataOut );
	//cudaDeviceSynchronize();
	auto stop4 = std::chrono::system_clock::now();
	//cudaDeviceSynchronize();
	cout<<"1: Done!!!"<<endl;
	//blur_GPU<<<numbBlocks, threadsPerBlock>>>(rows, cols, k, gpudataSrc, gpudataOut);
	cout<<"3: Done!!!"<<endl;
	//cudaDeviceSynchronize();
	auto stop5 = std::chrono::system_clock::now();
	cudaMemcpy(dst, gpudataOut, size, cudaMemcpyDeviceToHost);
	cudaFree(gpudataSrc);
	cudaFree(gpudataOut);
	auto duration1 = (std::chrono::duration_cast<std::chrono::microseconds>(stop1 - start1).count());
	auto duration2 = (std::chrono::duration_cast<std::chrono::microseconds>(stop2 - stop1).count());
	auto duration3 = (std::chrono::duration_cast<std::chrono::microseconds>(stop3 - stop2).count());
	auto duration4 = (std::chrono::duration_cast<std::chrono::microseconds>(stop4 - stop3).count());
	auto duration5 = (std::chrono::duration_cast<std::chrono::microseconds>(stop5 - stop4).count());
	auto duration =(std::chrono::duration_cast<std::chrono::microseconds>(stop5 - start1).count());
	
    //cout<<(int)duration1<<" "<<(int)duration2<<" " <<(int)duration3<<" " <<(int)duration4<<" " <<(int)duration5<<(int)duration6<< endl;
}
void cv::gpu::mj::sobel(const int rows,const int cols, unsigned char *src, unsigned char* dst, int mode){
	
	int N = WIDTH;
	int M = HEIGHT;
	
	unsigned char* gpudataSrc;
	
	unsigned char* gpudataOut;
	
	const int size = sizeof(unsigned char)*rows*cols;
		
	
	cudaMalloc((void **)&gpudataSrc, size);
	cudaMalloc((void **)&gpudataOut, size);
	
	cudaMemcpyAsync(gpudataSrc, src, size, cudaMemcpyHostToDevice);
	
	dim3 threadsPerBlock(32,32);
	dim3 numbBlocks(N/ threadsPerBlock.x,M/ threadsPerBlock.y); 
	

	sobel_abs_GPU<<<numbBlocks, threadsPerBlock>>>(rows,cols, gpudataSrc, gpudataOut, mode);
	cudaMemcpyAsync(dst, gpudataOut, size, cudaMemcpyDeviceToHost);
	
	cudaFree(gpudataSrc);
	cudaFree(gpudataOut);
}

unsigned char** cv::gpu::mj::initDisp(const int size){
	
	unsigned char** temps = (unsigned char**)malloc(8*sizeof(unsigned char*));
	
	int i = 0;
	
	for(i = 0; i < 8; i++){
		cudaMalloc((void **)&(temps[i]), size);
	} 
	return temps;
}


void cv::gpu::mj::disp(const int rows,const int cols, unsigned char *g_srcL, unsigned char *g_srcR, unsigned char* g_disp, unsigned char** temps){
	
	int N = WIDTH;
	int M = HEIGHT;
	
	unsigned char* g_L_low_ext = temps[0];
	unsigned char* g_R_low_ext = temps[1];
	unsigned char* g_L_high_out = temps[2];
	unsigned char* g_R_high_out = temps[3];
	unsigned char* g_L_lowEdge = temps[4];
	unsigned char* g_R_lowEdge = temps[5];
	unsigned char* g_L_highEdge = temps[6];
	unsigned char* g_R_highEdge = temps[7];
	
	const int size = sizeof(unsigned char)*rows*cols;
	
	cudaMemset(g_disp, 0, size);
	
	dim3 threadsPerBlock(16, 16);
	dim3 numbBlocks(N/ threadsPerBlock.x,M/ threadsPerBlock.y); 
	
	edgeDetect2x_GPU<<<numbBlocks, threadsPerBlock>>>(rows, cols, g_srcL, g_L_high_out, g_L_low_ext, 50, 20);
	edgeDetect2x_GPU<<<numbBlocks, threadsPerBlock>>>(rows, cols, g_srcR, g_R_high_out, g_R_low_ext, 50, 20);
	
	cudaDeviceSynchronize();
	
	edgeTypeDetect<<<numbBlocks, threadsPerBlock>>>(rows, cols, g_L_low_ext, g_L_lowEdge);
	edgeTypeDetect<<<numbBlocks, threadsPerBlock>>>(rows, cols, g_L_high_out, g_L_highEdge);
	edgeTypeDetect<<<numbBlocks, threadsPerBlock>>>(rows, cols, g_R_low_ext, g_R_lowEdge);
	edgeTypeDetect<<<numbBlocks, threadsPerBlock>>>(rows, cols, g_R_high_out, g_R_highEdge);
	
	cudaDeviceSynchronize();
	extender<<<numbBlocks, threadsPerBlock>>>( rows, cols, g_L_lowEdge, g_L_highEdge, g_L_low_ext);
	extender<<<numbBlocks, threadsPerBlock>>>( rows, cols, g_R_lowEdge, g_R_highEdge, g_R_low_ext);
	
	cudaDeviceSynchronize();
	
	inprove<<<numbBlocks, threadsPerBlock>>>(rows, cols, g_L_highEdge, g_L_low_ext, g_L_high_out);
	inprove<<<numbBlocks, threadsPerBlock>>>(rows, cols, g_R_highEdge, g_R_low_ext, g_R_high_out);
	//------------difference<<<numbBlocks, threadsPerBlock>>>(rows, cols, g_srcL, g_tmpLOUT,  g_disp);
	
	cudaDeviceSynchronize();
	
	
	dim3 threadsPerBlockDisp(32, 8);
	dim3 numbBlocksDisp(N/8, M/8); 
	
	blend_GPU<<<numbBlocks, threadsPerBlock>>>(rows, cols, g_L_high_out, g_R_high_out, g_disp, 0.5, 1);
	
	cudaMemset(g_L_low_ext, 0, size);
	cudaMemset(g_R_low_ext, 0, size);
	cudaMemset(g_L_high_out, 0, size);
	cudaMemset(g_R_high_out, 0, size);
	cudaMemset(g_L_lowEdge, 0, size);
	cudaMemset(g_R_lowEdge, 0, size);
	cudaMemset(g_L_highEdge, 0, size);
	cudaMemset(g_R_highEdge, 0, size);
	
}


void cv::gpu::mj::rectif(const int rows,const int cols, unsigned char *srcL, unsigned char *srcR, unsigned char *dstL, unsigned char *dstR, unsigned char * out){
	
	
}

void cv::gpu::mj::realocHostMem(int sizec, unsigned char *img){
	unsigned char* cpudataSrc;
	cudaMallocHost 	((void **)&cpudataSrc,sizeof(unsigned char));
	//cudaMemcpy(cpudataSrc, img, sizec, cudaMemcpyHostToHost);
	//img = cpudataSrc;		
}

void cv::gpu::mj::cudaMemAlocImagePtr(unsigned char *dest, int size){
	//cudaSetDeviceFlags(cudaDeviceMapHost);
	cudaMallocHost 	((void **)&dest, size);
	//cudaHostAlloc((void **)&dest,  size,  cudaHostAllocMapped);
}

void cv::gpu::mj::cudaMemcpyHtoH(unsigned char *src, unsigned char *dest, int size){
	//cudaMallocHost 	((void **)&dest,size);
	cudaMemcpy(dest, src, size, cudaMemcpyHostToHost);	
}

void cv::gpu::mj::cudaMemcpyHtoD(unsigned char *src, unsigned char* dest, int size){

	cudaMemcpy(dest, src, size, cudaMemcpyHostToDevice);
}

void cv::gpu::mj::cudaMemcpyDtoH(unsigned char *src, unsigned char* dest, int size){

	cudaMemcpy(dest, src, size, cudaMemcpyDeviceToHost);
}

void cv::gpu::mj::cudaInit(unsigned char** g_src1, unsigned char** g_src2, unsigned char** g_disp, const int rows, const int cols){
	
	const int size = sizeof(unsigned char)*rows*cols;

	cudaMalloc((void **)g_src1, size);
	cudaMalloc((void **)g_src2, size);
	cudaMalloc((void **)g_disp, size);
	
}

void cv::gpu::mj::cudaDestroy(unsigned char* g_src1, unsigned char* g_src2, unsigned char* g_disp, unsigned char** g_temps){
	
	cudaFree(g_src1);
	cudaFree(g_src2);
	cudaFree(g_disp);
	int i;
	for(i = 0; i < 8; i++){
		cudaFree(g_temps[i]);
	} 
}




























