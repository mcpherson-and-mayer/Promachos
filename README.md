# Promachos

Copyright © 2019 Chris McPherson and Sharice Mayer  
chris@techfocus.net  
mayers.research@gmail.com  


_*Promachos: Automated Pet Deterrent*_ 

Promachos Automated Pet Deterrent system is software designed to run on
a stationary turret, which is designed to fire a non-lethal projectile at a cat or dog 
if it enters a restricted area (e.g. countertop).
This is accomplished using a neural network to classify images
from a video stream and determine if a pet is where it doesn't belong.  

The software for this project extends a Tutorial for setting up an object detection API 
by Edje Electronics, but was written using C, C++, and Rust for hardware control and 
Python for image recognition and tracking. 
The software is also dependent on Tensorflow, OpenCV and Protobuf.  

The 'turret' hardware for this project was designed using:  

Program Control:  
-  Raspberry Pi 4 - 4GB(for improved processing speed) 
-  32GB MicroSD card containing a fresh NOOBS v3.1 install for Raspian Buster OS  

Camera:  
-  Logitech C920S HD Pro Webcam (any Raspberry-Pi4 compatible webcam will do)   

LED Directional Indicators _For GPIO Testing - Optional_:  
-  Various Colored LED lights (used 7 in the testing code)
-  220 Ohm Resistors (used 5, but is dependent on individual configuration used)
-  Breadboard (used full-size, but smaller size is fine)
-  Jumper Wires (used 12, but is dependent on the individual configuration used)  

Camera Movement:  
-  Servo system for panning the camera(and eventually fire projectiles)[Our components listed below]  
_NOTE: Currently the servo system is an independently operating entity from the rest of the project, and was used to manually move the cameras in response to Camera input for testing. *This piece is not required to build and use the software*. Future builds will include a more cohesive option to communicate with the image recognition and tracking software, and move autonomously in response (Ideally we plan to use Rust FFI between servos and pi so no Arduino is required, and have stubbed out some code to begin this piece of the program)_  

- RadioShackRobotics Starter Kit _Loosely used Line-following base build_  
- RadioShack Make:it Add-On Kit 2 _Loosely used Surveillance build_  
- IR Remote Control  
- Arduino Uno R3 _Required for Starter Kit Build_   
_NOTE: The operation of this servo system required using the Arduino IDE to build the program for servo behavior_   



## Build and Run   

Promachos is in development for the Raspberry Pi 4, but has been tested and built successfully on the Raspberry Pi 3 as well. 
The scripts written are based on a fresh install of Raspbian Buster using NOOBS v3.1.

### Pre-Requisite Software Installs: Tensorflow + OpenCV + Protobuf   

In order for Promachos to work, either a picamera or webcam is required. 
The Camera option must be enabled in the Rasperry pi configuration menu.  
Here's a link if you're unsure how to do so:   
`https://www.raspberrypi.org/documentation/configuration/camera.md`    

If git is not installed on your pi, this repo can still be downloaded as a zip file or cloned from the command line.  

Once this repo is cloned or extracted, there are a set of scripts in the `install` folder, which can be run in order to help bootstrap your pi with all the pre-requisites necessary for Promachos to run.  


1.   
To begin with, we recommend you install your favorite text editor(since we don't love nano).
We chose vim, so we've included it as an optional script. This script updates the system and currently installed packages before installing vim.   


To Run:  
*NOTE:THIS SCRIPT WILL REBOOT YOUR PI AT THE END OF THE SCRIPT*  

```
sudo sh optional-vimscript.sh
```


2.   
Next, install tensorflow. There are two scripts available for installing prerequisites for tensorflow depending on what your system preferences are. If you are familiar with using containers, 01opt-dockerscript.sh is slightly more advanced, and may require decent in-depth knowledge of your system to debugi if you run into issues. We ran into several issues while trying this method, and it appears that there are a myriad of bugs that completely depend on your particular OS configuration and othersystem  software. For this reason, if you are at all unsure, we recommend using the pip install, with 01opt-pipscript.sh instead.   
_NOTE: There are TWO scripts required to go the docker route, and only one for the pip route to tensorflow.  
ALSO: Although the Docker Route takes a significant amount of time, the pip option still took awhile, although noticeably less time. Try to be patient :)_   


To Install Using Docker:  
*NOTE:THE DOCKER SCRIPT WILL REBOOT YOUR PI AT THE END OF THE SCRIPT*  

```
sudo sh 01opt-dockerscript.sh

sudo sh 02-tensorflowscript.sh
```


*OR* To Install Using Pip:  

```
sudo sh 01opt-pipscript.sh
```


_NOTE: We only ran into a single error while running *01opt-pipscript.sh*, involving distutils being unable to uninstall wrapt to update it._   
This command fixed the issue for us:  

```
sudo pip install -U --ignore-installed wrapt
```


3.   
Next, we need to install OpenCV. This script was fairly short. This method worked for us after several very frustrating and unsuccessful attempts to use the official OpenCV site instructions for the Raspberry Pi, so we were glad this worked easily instead.  
  

To Run:  

```
sudo sh 03-opencvscript.sh
```


4.   
Next, we need to install protobuf. Although there are more updated protobuf versions available, this is the most recent version that actually compiled. We tried installing several other versions over many long hours, since this install takes a hefty amount of time each try, and for us every versin past this one was unsuccessful.    
_This install takes *quite* a while to install as well... Enough time to eat and go to coffee..._  


To Run:   
*NOTE:THIS SCRIPT WILL REBOOT YOUR PI AT THE END OF THE SCRIPT*  

```
sudo sh 04-protobufscript.sh
```



### Get Tensorflow Models for Object Detection  

Now we need to get Tensorflow Models and modify our environment to run Promachos:  


Run:   

```
git clone --recurse-submodules https://github.com/tensorflow/models.git
```


Now modify your environment in order to call the tensorflow models for object detection. Theis command makes it so the “export PYTHONPATH” command is called every time you open a new terminal, so the PYTHONPATH variable will always be set appropriately.   


Run:   

```
sudo vim ~/.bashrc
```


Add the following line to end of the file:  

```
export PYTHONPATH=$PYTHONPATH:/home/pi/tensorflow/models/research:/home/pi/tensorflow/models/research/slim
```


Then, save and exit the file, close and then re-open the terminal.  


Now, we need to use Protoc to compile the Protocol Buffer (.proto) files used by the Object Detection API. The .proto files are located in `tensorflow/models/research/object_detection/protos`, but we need to execute the python program command from the `tensorflow/models/research/*` directory.


Run:   

```
cd /home/pi/tensorflow/models/research/object_detection/
protoc object_detection/protos/*.proto --python_out=.
```


Now move Promachos.py (and Rust files) to the location Promachos must be run:
 `/home/pi/tensorflow/models/research/object_detection` 
_NOTE: moving the entire git project file into this directory is the easiest way_


Run:  

```
sudo mv Promachos.py tensorflow/models/research/object_detection
sudo mv Promachos tensorflow/models/research/object_detection
```


Now downlad the mscoco models to the correct location:  

Run: 

```
cd tensorflow/models/research/object_detection
wget http://download.tensorflow.org/models/object_detection/ssdlite_mobilenet_v2_coco_2018_05_09.tar.gz
tar -xzvf ssdlite_mobilenet_v2_coco_2018_05_09.tar.gz
```



### Let's Run it!  


_*Now we can finally run Promachos!*_  


First we need to build the rust package. This builds files that can run LED lights(and eventially motors). I made a make file so this part is easy:  


From the Promachos Project Folder Run:   

```
make clean compile-rust
cargo run --release
```


Now run the python file! From the `tensorflow/models/research/object_detection` folder location(The same one `Promachos.py` is currently located):  


Run:    

```
python3 Promachos.py
```


_NOTE: As a default it runs a usb camera. A picamera may be used instead with the arguement --picam_
Alternatively you can Run:    

```
python3 Promachos.py --picam
```



Example of running the program:  

	$ python3 Promachos.py
    	Running...
    	There is an object at -12, 236 -176 from origin
    	targeting ...
    	There is an object at -82, 236 -189 from origin
    	firing ...
    	There is an object at -82, 130 -101 from origin
    	target object not found
    	returning home ...
    	$



## Bugs, Defects, Failing Tests, etc  

Bugs, Defects, and Failing Test information:
The Raspberry Pi is quite underpowered, even with the raspi 4 with 4 gigs of ram
The program currently lights up LED lights to indicate
the direction in which the camera should be moving to 
follow the chosen target.  

### Defects    
Currently only capable of following a single target.  
If there are multiple targets in frame, the camera 
will only track the target with the highest 
probable correct identification confidence value.  

The current motor control system we are using 
requires the RadioShackRobotics Starter kit, 
as well as the RadioShackRobotics Make:it 
Robotics Add-on Project Kit 1.   
Future work will involve a system that is completely
run through the Raspbery Pi 4 and direct peripherals, 
rather than the current system's extra communication 
component to motors through the Arduino Uno R3.  

### Bugs  
The servo we are currently using to move the motor is weaker
in the left-ward panning direction, which causes some 
miscalculation regarding the current frame vs previous frame 
reference values.    

The object origin is identified as soon as the object is recognized,
which means that if an object is brought into the frame, it's origin
location begins towards the edge of the frame, rather than where it
is "placed" to begin tracking.  


## License  

This program is licensed under the "MIT License".  
Please see the file `LICENSE` in the source distribution of this
software for license terms.  


## Acknowledgements 
Thanks to professor Bart Massey for project encouragement.  

Thanks to Evan Juras @EdjeElectronics for his help with 
raspberry pi - tensorflow object detection.   
`https://github.com/EdjeElectronics/TensorFlow-Object-Detection-on-the-Raspberry-Pi`  

Thank you to Docker for their install instructions:
`https://docs.docker.com/install/linux/docker-ce/debian/ ` 

Thank you to Bruno Rocha for his guidance with FFI and cpython:
`https://developers.redhat.com/blog/2017/11/16/speed-python-using-rust/ ` 


