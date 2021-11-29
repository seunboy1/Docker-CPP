// main.cpp

#include <iostream>
#include <opencv2/opencv.hpp>
#include <opencv2/highgui.hpp>

using std::cout;
using std::endl;

int main(int argc, char** argv) {

    if (argc != 2) {
        cout << "Expecting a image file to be passed to program" << endl;
        return -1;
    }
    
    cv::Mat img = cv::imread(argv[1]);
    
    if (img.empty()) {
        cout << "Not a valid image file" << endl;
        return -1;
    }
    
    cout << "Width : " << img.cols << endl;
    cout << "Height: " << img.rows << endl;

    return 0;
}