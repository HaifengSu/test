Overview
========

CRATES stands for "Cognitive Robotics Architecture for Tightly-Coupled Experiments and Simulation". The goal of the project is to create an easy-to-use architecture for writing high-level cognitive controllers for simulated robot problems, which can easily be transferred to real experiments.

The overarching idea is that both simulated and actual hardware platforms inherit functionality from a common HAL, which exposes itself over a messaging backbone. In so doing the HAL abstracts away from the detailed implementation, and presents itself as a general robot type, like a 'quadrotor'. 

In addition to offering this abstraction service, the HAL may also include type-specific perception, navigation and low-level control algorithms. By implementing such functionality directly in the HAL, it is reused between experiments and simulation, and the mission-critical functions do not contend with bandwidth-intensive applications on the ROS messaging system.

CRATES is based upon several open source and actively-developed libraries. ROS is used for the entire messaging backbone, while Gazebo is used for simulation and visualisation. In addition, the GPS toolkit is used to simulate global navigation satellite systems, while GeographicLib is used to to project between coordinate frames and calculate gravitational and magnetic fields.

Installation instructions
==========================

Install Ubuntu 14.04 "Trusty Tahr" as an dual-boot (recommended) or in a Virtual Machine. If you choose to install in a VM, then the guest VM will need (a) at least 2GB ram, (b) two cores, (c) 3D support, and (d) guest drivers for 3D support. I have only managed to get CRATES working in vmware,  and so I would suggest using this. For Intel graphics cards mesa doesn't support GLSL 1.Please be sure to read the 'known issues' sections at the bottom of this page if you choose to run within a VM.

	Visit http://releases.ubuntu.com/14.04/

Install git

	sudo apt-get install git mercurial build-essential cmake

Checkout the CRATES framework and pull the submodules

	mkdir -p ~/workspace
	cd ~/workspace
	git clone https://bitbucket.org/asymingt/crates.git
	cd crates
	git submodule init
	git submodule update

This is a forked version of the original repo. If you want to clone from here replace 

	git clone https://bitbucket.org/vicengomez/crates.git

Install system dependencies, ROS, gazebo and gpstk libraries using the bash scripts supplied in the the thirdparty directory. You'll probably want to look at each of these scripts to see what they are doing, as they call sudo.

	cd  ~/workspace/crates/thirdparty
	./install_sysdeps.sh
	./install_ros.sh
	./install_gazebo.sh
	./install_gpstk.sh

Make your bash environment aware of the ROS binaries

	source /opt/ros/indigo/setup.bash

Initialise the catkin workspace
	
	cd  ~/workspace/crates/src
	catkin_init_workspace

Build the CRATES framework. We are building the code in release mode for two reasons. Firstly, it will run significantly faster without debug symbols. Secondly, there is a race condition bug on Trusty (https://bitbucket.org/osrf/gazebo/issue/1204/trusty-remote_endpoint-transport-endpoint) that causes a transport end point failure on launching.

	cd ~/workspace/crates
	catkin_make -DCMAKE_BUILD_TYPE=Release

Make your bash environment aware of the CRATES binaries. You will need to do this each time that you start a new terminal. If you want to avoid having to type this in each time, add the line to ~/.bashrc

	source ~/workspace/crates/devel/setup.bash

Finally, test the simulator to make sure everything is working as expected Make sure you are connected to the internet, as gazebo will need to download and cache some third party models on first starting up. Note that the first start up

	roslaunch sim sw.launch

If you have an error similar to the one below, it's because the gazebo libraries are not in the search path.

	gazebo: error while loading shared libraries: libgazebo_common.so.1: cannot open shared object file: No such file or directory

 This is likely because you're using 64 bit Ubuntu, and the gazebo libraries get dumped into the non-standard /usr/local/lib/x86_64-linux-gnu directory. To resolve this, add the library search path.

	echo '/usr/local/lib/x86_64-linux-gnu' | sudo tee /etc/ld.so.conf.d/gazebo.conf 
	sudo ldconfig

Some additional information about the installation process:
1. We compile gazebo3 from source in order to obtain gdal support, which allows us to load maps containing geographic projections. This simplifies the conversion between various geographic coordinate systems.
2. We compile gpstk from source because no Ubuntu PPA exists for this library. This library allows us to accurately model GPS and Glonass trajectories, and perform full GPS solutions from pseudoranges.
3. We don't use the gazebo simulator distributed with ROS, as it's quite old (version 2.2) and doesn't support loading DEM files.
4. We need java and gradle in order to compile our custom messages into java objects for use by the Java language binding.

Example usage instructions
==========================

The ROS messaging architecture offers broadcast-style 'topics' or request-response style 'services'. We'll use the 'roslaunch' application to launch the simulator from the command line:

	roslaunch sim sw.launch

The argument 'sim' is the package in CRATES containing the sw.launch file. The last argument is the world that we want to load in stead of an empty default.

If you have setup your development environment correctly, you should see a simulated version of the Royal Veterinary College Hawkshead Campus.

At the bottom of the interface you will see that the simulator provides the ability to step, pause and reset wrld time. All ROS clocks are bound to simulated time, and so any ROS timer (eg. sensor data rates, control update loops in the HAL, etc.) will abide by this simulated time.

For your convenience, time has been paused. Like any platform, the simulator offers several services on the messaging backbone. To see these, type:

	rosservice list

The list will contain the following, amongst others:

	/simulator/Delete    # Delete a model
	/simulator/Insert    # Insert a model
	/simulator/Noise     # Turn on and off noise
	/simulator/Pause     # Pause simulation
	/simulator/Reset     # Reset simulation
	/simulator/Resume    # Resume simulation
	/simulator/Step      # Step the simulator one tick
	/simulator/Seed      # Seed the random number generator

To resume the simulation we are going to need to call the /simulator/Resume service. Let's get a list of the arguments we'll need to send to this service:

	rosservice args /simulator/Resume

You will see that it takes none. So, go ahead and call it without arguments:

	rosservice call /simulator/Resume

Time should now be ticking in the simulation. Try playing with the Pause and Step services. Note that the Step service takes an integer number of steps as an argument. Also note that the commands all support tab-completion. 

Arguments follow JSON-like syntax:

	rosservice call /simulator/Step "num_steps: 1"

But this useful shorthand also works for simple messages

	rosservice call /simulator/Step 1

Now, add a single 'hummingbird' quadrotor model to the simulation:

	rosservice call /simulator/Insert UAV1 model://hummingbird

You should see a model appear in simulation. In addition to appearing in the simulation, the HAL inherited by the simulator has also presented itself on the messaging backbone. Use the rosservice tool to see what services it offers.

Take note that, for safety reasons, quadrotor control adheres to the finite state machine pictured below.

![Quadrotor HAL](https://bytebucket.org/asymingt/crates/raw/199f5e9a2750208e9866c1456d0913b90e5d7393/docs/images/quadrotor_state.png "Finite State Machine for Control coded into the Quadrotor HAL")

A quadrotor is always spawned in the idle state (motors off). Hence, when simulation time resumes, you will notice that gravity pulls the platform to the ground. To actually begin flying you'll need to takeoff first. To takeoff to a five meter altitude, type the following.

	rosservice call /hal/UAV1/controller/Takeoff 5

In addition to offering request-response services, the simulated entity also offers some broadcast-style messages on topics. To see what the platform offers, use the rostopic tool. 

For example, each platform has a truthful state (Truth) and an estimated version of this state (Estimate). Since we are currently in simulated mode, both of these states are observable. For example, to see the estimated state, use the following command.

	rostopic echo /hal/UAV1/Estimate

If nothing appears, its likely that you have the simulation paused. Remember that clocks are bound to simulated time, and if you have time paused then no callbacks will be triggered. In the very special case where you have no wind, dynamic or sensor noise, then the Estimate equals the Truth.

Finally, it is possible to launch a hardware version of an experiment using the hw.launch file using the following command

	roslaunch sim hw.launch

This command will again open an interface to a similar-looking world. However, you will notice that there are no /simulator services. This is because the gazebo is listening for real (hardware) platforms on the ROS backbone. If a platform broadcasts its state, then the simulator will pick up on this, and spawn a model representing the hardware platform.

Language bindings
=================

Although interacting with the simulator over the command prompt is an interesting exercise, it is impractical to make system calls to 'rostopic' and 'rosservice' from the language of your choice. CRATES supports bindings for C++, Python, Matlab and Java. Please refer to READMEs in the examples directory for usage instructions.

Known issues
============

CRATES is currently a work in progress. Bugs are continually being fixed, and you are therefore strongly urged to pull and recompile on a regular basis. 

At height zero the quadrotor jumps in and out of the ground plane. This has to do with the fact that the GeoTiff used to draw the ground does not provide a perfectly flat surface. The heightmap generated from this image therefore has little bumps all over it, and simulated gravity causes small oscillations.

Periodically, the following message is received on starting the simulator

	terminate called after throwing an instance of 'boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::system::system_error> >'what():  remote_endpoint: Transport endpoint is not connected
	Aborted (core dumped)
  
This is a known bug with Gazebo running on Trusty Tahr, and it is caused by a race condition between the Gazebo client and server, when gazebo plugins are compiled with debug flags. If you need to debug the simulator for some reason, here's a workaround that will prevent this error. This will also start the server in debug mode (assuming of course you've compiled crates with catkin_make -DCMAKE_BUILD_TYPE=Release) so you can drop to GDB and backtrace.

	roslaunch sim sw.launch gui:=false bin:=server_debug
	roslaunch sim gui.launch
 
If you experience any strange GCC errors when running the install scripts within a VM then you're probably running out of memory. Try increasing the VM memory to 2GB and changing the variable NT=2 to NT=1 in the install scripts.

	c++: internal compiler error: Killed (program cc1plus)

VMWare blacklists intel graphics drivers from direct rendering. You can hack the vmx config file to allow blacklisted drivers, and Ubuntu works well. For even better performance install a non-compiz window manager.

	sudo apt-get install gnome-session-flashback

You can switch to this new window manager by logging out and clicking on the Ubuntu icon next to your name in the login screen.

For Intel systems the VMWare host graphics drivers provide GL Shading Language 1.20, where 1.30 is required to texture terrain in Gazebo. If you find the simulator is starting, but all you see is a black screen then you've likely got GLSL 1.20. To verify this, type 

	sudo apt-get install mesa-utils
	glxinfo | grep version

This will print out all sorts of interesting information about your GL environment. Most importantly, you're looking for this line:

	OpenGL shading language version string: x.y

If you see any x.y version less than 1.30, then you'll need to work out how to increase it to 1.30. I've only managed to get the simulator working with software rendering in VMware on a host with an Intel, but it may very well be possible to get it up and running with other graphics cards. To check if this is a problem that affects you, try this:

	LIBGL_ALWAYS_SOFTWARE=1 roslaunch sim sw.launch

This is essentially a full version of the simulator, which uses software 3D rendering in place of hardware 3d rendering. It will therefore run very slowly.
