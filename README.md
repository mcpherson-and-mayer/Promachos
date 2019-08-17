# Promachos

Copyright © 2019 Chris McPherson and Sharice Mayer  
chris@techfocus.net  
mayers.research@gmail.com  


_Promachos: Automated Pet Deterrent_ 

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
The scripts written are based on a fresh install of Raspbian Stretch

In order for Promachos to work, either a picamera is require. It must be enabled in the Rasperry pi configuration menue
If git is not installed then the repo can be downloaded as a zip file or cloned from the command line. Once the repo is cloned or extracted, there is a set of scripts are in the install folder with a specifics scripts to install the prerequisites. 

```
00-vimscript.sh
```
Is an optional script which updates the the system and currently installed packages as well as installs vim. There are two scripts for installing the prerequisites for tensorflow. 
```
01opt-dockerscript.sh
```
or 
```
01opt-pipscript.sh
```
both scripts had some errors along the way however, *01opt-script.sh* was less error prone and only required the command
```
sudo pip install -U --ignore-installed wrapt
```
should fix it.
Next run 
```
02-tensorflowscript.sh
```
This script takes takes little while to run so please be patient
Next run 
```
03-opencvscript.sh
```
The next script will take quite a while to install protobuf. 
```
04-protobuf.sh
```
Once the protobuf script finishes running
```
sudo reboot
```
```
git clone --recurse-submodules https://github.com/tensorflow/models.git
```
The environment needs to be modified in order to call the tensorflow models for object detection
```
sudo nano ~/.bashrc
```
add the following line to end of the file
```
export PYTHONPATH=$PYTHONPATH:/home/pi/tensorflow1/models/research:/home/pi/tensorflow1/models/research/slim
```
Then, save and exit the file. This makes it so the “export PYTHONPATH” command is called every time you open a new terminal, so the PYTHONPATH variable will always be set appropriately. Close and then re-open the terminal.

Now, we need to use Protoc to compile the Protocol Buffer (.proto) files used by the Object Detection API. The .proto files are located in /research/object_detection/protos, but we need to execute the command from the /research directory. Issue:

```
cd /home/pi/models/research
protoc object_detection/protos/*.proto --python_out=.
```

move Promachos.py and the rust files to the file /home/pi/models/research/object_detection
```
mv Promachos.py /models/research/object_detection
mv gpio_rust /models/research/object_detection
```

```
cd models/research/object_detection
wget http://download.tensorflow.org/models/object_detection/ssdlite_mobilenet_v2_coco_2018_05_09.tar.gz
tar -xzvf ssdlite_mobilenet_v2_coco_2018_05_09.tar.gz
```

And that's it, in order to run Promachos. 
```
python3 Promachos.py
```
As a default it runs a usb camera. A picamera may be used with the arguement --picam
```
python3 Promachos.py --picam
```

## Bugs, Defects, Failing Tests, etc  

Bugs, Defects, and Failing Test information goes here as needed.  
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
is "placed" to begin tracking.  //Is this a bug? Expected behavior?


## License  

This program is licensed under the "MIT License".  
Please see the file `LICENSE` in the source distribution of this
software for license terms.  


## Acknowledgements 
Thanks to professor Bart Massey for project encouragement.  
Thanks to Evan Juras @EdjeElectronics for his help with 
raspberry pi - tensorflow object detection.   

Thank you to Docker for their install instructions:
https://docs.docker.com/install/linux/docker-ce/debian/

Thank you to Bruno Rocha for his guidance with FFI and cpython:
https://developers.redhat.com/blog/2017/11/16/speed-python-using-rust/


