FROM ubuntu:latest 

# This to elimate request for user input from interactive commands
ENV DEBIAN_FRONTEND noninteractive

# Install OpenCV
# Update package ubuntu system packages and Required tools and packages
RUN apt-get update \
 && apt-get upgrade \
 && apt-get install --assume-yes --no-install-recommends --quiet \ 
 build-essential cmake git pkg-config libgtk-3-dev libtool \
 autoconf apt-file libavcodec-dev libavformat-dev libswscale-dev \
 libv4l-dev libxvidcore-dev libx264-dev libjpeg-dev libpng-dev \
 libtiff-dev gfortran openexr libatlas-base-dev python3-dev libtbb2 \
 python3-numpy  libtbb-dev libdc1394-22-dev libopenexr-dev libgstreamer1.0-dev \
 libgstreamer-plugins-base1.0-dev software-properties-common wget unzip \
 && apt-get clean all

# Sets the working directory
WORKDIR /icao/opencv_build 

# Download and unzip OpenCV’s and OpenCV contrib repositories
RUN wget https://github.com/opencv/opencv/archive/4.3.0.zip 
RUN mv 4.3.0.zip opencv.zip && unzip opencv.zip && rm opencv.zip
RUN wget https://github.com/opencv/opencv_contrib/archive/4.3.0.zip && mv 4.3.0.zip opencv_contrib.zip && unzip opencv_contrib.zip && rm opencv_contrib.zip


WORKDIR /icao/opencv_build/opencv-4.3.0/build
ENV EXTRA_MODULES /icao/opencv_build/opencv_contrib-4.3.0/modules

# Set up the OpenCV build with CMake
ADD build_opencv.sh .
RUN chmod +x build_opencv.sh
RUN ./build_opencv.sh


# # Verify installation
# RUN pkg-config --modversion opencv4

# These commands copy your files into the specified directory in the image
# and set that as the working location
WORKDIR /icao
COPY . ./

# This command builds and compiles your app using cmake, adjust for your source code
RUN cmake -H. -B build 
RUN cmake --build build

# # This command runs your application
CMD ["./build/simple-demo", "black.jpeg"]

LABEL Name=democppdocker Version=0.0.1