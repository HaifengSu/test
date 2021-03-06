# Minimum build environment
cmake_minimum_required(VERSION 2.8.3)

# Project name
project(hal_quadrotor)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages

# Add custom cmake
SET(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${PROJECT_SOURCE_DIR}/cmake")

# Find catkin
find_package(catkin REQUIRED COMPONENTS 
  roscpp
  std_msgs
	message_generation
  hal
  hal_sensor_altimeter
  hal_sensor_compass
  hal_sensor_gnss
  hal_sensor_imu
  hal_sensor_orientation
) 

# Find GPS toolkit
find_package(GeographicLib REQUIRED)

## Uncomment this if the package has a setup.py. This macro ensures
## modules and global scripts declared therein get installed
## See http://ros.org/doc/api/catkin/html/user_guide/setup_dot_py.html
# catkin_python_setup()

################################################
## Declare ROS messages, services and actions ##
################################################

## To declare and build messages, services or actions from within this
## package, follow these steps:
## * Let MSG_DEP_SET be the set of packages whose message types you use in
##   your messages/services/actions (e.g. std_msgs, actionlib_msgs, ...).
## * In the file package.xml:
##   * add a build_depend and a run_depend tag for each package in MSG_DEP_SET
##   * If MSG_DEP_SET isn't empty the following dependencies might have been
##     pulled in transitively but can be declared for certainty nonetheless:
##     * add a build_depend tag for "message_generation"
##     * add a run_depend tag for "message_runtime"
## * In this file (CMakeLists.txt):
##   * add "message_generation" and every package in MSG_DEP_SET to
##     find_package(catkin REQUIRED COMPONENTS ...)
##   * add "message_runtime" and every package in MSG_DEP_SET to
##     catkin_package(CATKIN_DEPENDS ...)
##   * uncomment the add_*_files sections below as needed
##     and list every .msg/.srv/.action file to be processed
##   * uncomment the generate_messages entry below
##   * add every package in MSG_DEP_SET to generate_messages(DEPENDENCIES ...)

## Generate messages in the 'msg' folder
add_message_files(
  DIRECTORY
    msg
  FILES  
    State.msg
    Control.msg
)

## Generate services in the 'srv' folder
add_service_files(
  DIRECTORY
    srv
  FILES
    Emergency.srv
    Takeoff.srv
    Hover.srv
    Land.srv
    AnglesHeight.srv
    Velocity.srv
    VelocityHeight.srv
    Waypoint.srv
    SetEstimate.srv
    SetTruth.srv
    SetControl.srv
    GetEstimate.srv
    GetTruth.srv
    GetControl.srv
)

## Generate actions in the 'action' folder
# add_action_files(
#   DIRECTORY 
#     action
#  FILES 
# )

## Generate added messages and services with any dependencies listed here
generate_messages(
  DEPENDENCIES
    std_msgs
)

###################################
## catkin specific configuration ##
###################################
## The catkin_package macro generates cmake config files for your package
## Declare things to be passed to dependent projects
## INCLUDE_DIRS: uncomment this if you package contains header files
## LIBRARIES: libraries you create in this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## DEPENDS: system dependencies of this project that dependent projects also need

catkin_package(
  INCLUDE_DIRS 
    include
  LIBRARIES
    hal_quadrotor
  DEPENDS 
    roscpp
    message_runtime
    hal
    hal_sensor_altimeter
    hal_sensor_compass
    hal_sensor_gnss
    hal_sensor_imu
    hal_sensor_orientation
)

###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
include_directories(
  include 
  ${catkin_INCLUDE_DIRS}
  ${CMAKE_CURRENT_BINARY_DIR}
  ${GEOGRAPHICLIB_INCLUDE_DIR} 
)

## Specify additional locations of library files
link_directories(
  ${CMAKE_CURRENT_BINARY_DIR}
  ${catkin_LIBRARY_DIRS}
  ${GEOGRAPHICLIB_LIBRARY_DIRS}
)


## Declare a cpp library
add_library(hal_quadrotor
  src/control/Controller.cpp
  src/control/Idle.cpp
  src/control/Takeoff.cpp
  src/control/Hover.cpp
  src/control/Land.cpp
  src/control/Emergency.cpp
  src/control/AnglesHeight.cpp
  src/control/Velocity.cpp
  src/control/VelocityHeight.cpp
  src/control/Waypoint.cpp
  src/Actuation.cpp
  src/Navigation.cpp
  src/Quadrotor.cpp
)

## Declare a cpp executable
# add_executable(uav_driver 
#	src/checksum.cpp
#)

## Add cmake target dependencies of the executable/library
## as an example, message headers may need to be generated before nodes
add_dependencies(hal_quadrotor 
  hal_quadrotor_generate_messages_cpp
)

## Specify libraries to link a library or executable target against
target_link_libraries(hal_quadrotor 
  ${catkin_LIBRARIES}
  ${GEOGRAPHICLIB_LIBRARY}
)

#############
## Install ##
#############

# all install targets should use catkin DESTINATION variables
# See http://ros.org/doc/api/catkin/html/adv_user_guide/variables.html

## Mark executable scripts (Python etc.) for installation
## in contrast to setup.py, you can choose the destination
# install(PROGRAMS
#   scripts/my_python_script
#   DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark executables and/or libraries for installation
install(TARGETS hal_quadrotor
  ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

## Mark cpp header files for installation
install(DIRECTORY include/${PROJECT_NAME}/
  DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
  FILES_MATCHING PATTERN "*.h"
  PATTERN ".svn" EXCLUDE
)

## Mark other files for installation (e.g. launch and bag files, etc.)
# install(FILES
#   # myfile1
#   # myfile2
#   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
# )

#############
## Testing ##
#############

## Add gtest based cpp test target and link libraries
##catkin_add_gtest(${PROJECT_NAME}_QuadrotorHAL-test test/TEST_QuadrotorHAL.cpp)
##target_link_libraries(${PROJECT_NAME}_QuadrotorHAL-test hal_quadrotor)

## Add folders to be run by python nosetests
# catkin_add_nosetests(test)