# Promachos

Copyright © 2019 Chris McPherson and Sharice Mayer  
chris@techfocus.net  
mayers.research@gmail.com  

## Explanation of what the program is and does  

_Promachos: Automated Pet Deterrent_ 

Promachos Automated Pet Deterrent system is software designed to run on
a stationary turret, which is designed to fire a non-lethal projectile at a cat or dog 
if it enters a restricted area (e.g. countertop).  
This is accomplished using a neural network to classify images
from a video stream and determine if a pet is where it doesn't belong.  
This project is written in Rust and Python, and is dependent on Tensorflow, OpenCV and Protobuf.  
The project was designed using a web camera, Raspberry Pi, 
and a set of servos to pan the camera (and eventually fire projectiles).  
[Currently servo system uses RadioshackRobotics kits+Arduino Uno R3]

## Build and Run  
Promachos is in development for the Raspberry pi 3 or 4. 
The scripts written are based on a fresh install of Raspbian Stretch

Once the repository is cloned, a set of scripts are in the 
install folder with a specific to install all the prerequisites. 
Currently the scripts are in the testing phase.


Build and run (install?)this program with `insertruncommandhere`
passing in arguments listed here.  
*Install folder contains build scripts for opencv pieces*
Installation instructions here. 
Insert links to documents elsewhere here that describe important things.  
TBD  
   
For example:  
An example illustrating the operation of your code  

    $ python3 go target_cat
    running ...
    found cat ...
    targeting ...
    firing ...
    target out of range
    returning position ...
    $


## Bugs, Defects, Failing Tests, etc  

Bugs, Defects, and Failing Test information goes here as needed.  

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


