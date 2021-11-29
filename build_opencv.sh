#!/bin/bash
mkdir /icao/opencv_build/install
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/icao/opencv_build/install \
    -D INSTALL_C_EXAMPLES=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_GENERATE_PKGCONFIG=ON \
    -D OPENCV_EXTRA_MODULES_PATH=$EXTRA_MODULES \
    -D BUILD_EXAMPLES=ON ..

# Start the compilation process
# To get the number of cores in your processor, you can find it by typing nproc
export CPUS=$(nproc)
make -j $CPUS

# Install OpenCV with
make install