

namespace cv{
	namespace gpu{
		namespace mj{	 
			void test();
			void blur(const int rows,const int cols,const int k, const unsigned char *src, unsigned char *dest);
			void realocHostMem(int sizec, unsigned char *img);
			void cudaMemAlocImagePtr(unsigned char *dest, int size);
			void cudaMemcpyHtoH(unsigned char *src, unsigned char *dest, int size);
		}
	}	
}
