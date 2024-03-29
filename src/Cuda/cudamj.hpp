#include "../pch.h"
#include "cuda.h"

namespace cv{
	namespace gpu{
		void test();
		void blurmj(Mat &src, Mat &out, const int k);
		void sobelmj(Mat &src, Mat &out, const int mode);
		void dispmj(Mat &L, Mat &R, Mat &Out, unsigned char* l, unsigned char* r, unsigned char* disp, unsigned char** temps);
		void disp2mj(Mat &L, Mat &R, Mat &Out, unsigned char* l, unsigned char* r, unsigned char* disp, unsigned char** tempsC,unsigned int** tempsI);
		void disp3mj(Mat &L, Mat &R, Mat &Out, Mat &uDepth, unsigned char* l, unsigned char* r, unsigned char* disp, unsigned char** tempsC,unsigned short** tempsUS);
		void realocHostMem(Mat &in);
		void setImageForCuda(Mat &mat, int size);
		void cpyImageForCuda(unsigned char* src, Mat &dest);
		void rectifmj(Mat &L, Mat &R, Mat &Out);
		void cudaInit(unsigned char** g_src1, unsigned char** g_src2, unsigned char** g_disp, const int rows, const int cols);
		void cudaDestroy(unsigned char* g_src1, unsigned char* g_src2, unsigned char* g_disp, unsigned char** g_temps);
		void cudaDestroyDisp2(unsigned char* g_src1, unsigned char* g_src2, unsigned char* g_disp, unsigned char** g_tempsC, unsigned int** g_tempsI);
		void cudaDestroyDisp3(unsigned char* g_src1, unsigned char* g_src2, unsigned char* g_disp, unsigned char** g_tempsC, unsigned short** g_tempsUS);
		
		unsigned char** initDisp(const int size);
		unsigned char** initDisp2C(const int size);
		unsigned int** initDisp2I(const int size);
		unsigned char** initDisp3C(const int size);
		unsigned short** initDisp3US(const int size);

	
	}
}

	
