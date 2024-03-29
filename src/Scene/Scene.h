
#include "../pch.h"
#include "Obstacle.h"

using namespace cv;
using namespace std;

class Scene{
	public:
		Scene(int minDepth, int maxDept);
		~Scene();
		vector<Obstacle*> getScene();
		void update(vector<vector<Point>*> points);
	public:
		int maxDepth;
		int minDepth;
	private:
		vector<Obstacle*> obstacles;
};
