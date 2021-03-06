#!/bin/bash

# Add to apt
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list' 

# Add the key
wget http://packages.ros.org/ros.key -O - | sudo apt-key add -

# Update the libraries
sudo apt-get update

# Install base libraries
sudo apt-get -y install ros-indigo-roscpp ros-indigo-roslaunch ros-indigo-rosbash ros-indigo-geometry-msgs ros-indigo-std-msgs \
ros-indigo-std-srvs ros-indigo-rostopic ros-indigo-rosservice ros-indigo-nodelet ros-indigo-multimaster-fkie ros-indigo-rosserial

# Make BASH aware of ROS
source /opt/ros/indigo/setup.bash

# Initialise ROS
sudo rosdep init 
rosdep update