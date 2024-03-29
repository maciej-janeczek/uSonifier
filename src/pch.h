
#include <iostream>
#include <vector>
#include <stdio.h>
#include <termios.h>
#include <unistd.h>
#include <fcntl.h>
	
#include <math.h>
#include <time.h>

#include <opencv2/opencv.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/gpu/gpu.hpp>



#define OBSTACLE 1
#define WALL 2

#define WIDTH	640
#define HEIGHT	480
#define ACC 	0.3
#define	DIST	20
#define TH		50
#define TH_HIGH	110

#define FULL_SCAN 2000
#define	ACTIVE_TIME 1500
#define UPDATE_TIME 50

#define STIFF_MAX 	400.0
#define STIFF_MIN	100.0
#define STIFF_WALL 	50.0
#define WIDTH_MAX	2.0
#define WIDTH_MIN	0.2
#define STRVEL_MIN 	2000.0
#define STRVEL_MAX	15000.0
#define TO_DEGREES 57.29577
#define SCENE_MAX_DEPTH 5.0
#define SCENE_MIN_DEPTH 0.0

using namespace std;
using namespace cv;
using namespace cv::gpu;



