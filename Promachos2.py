######## Picamera Object Detection Using Tensorflow Classifier #########
#
# Author: Chris McPherson and Sharice Mayer originally based on work by Evan Juras
# Date: 8/6/19
# Description: 
# This program uses a TensorFlow classifier to perform object detection.
# It loads the classifier uses it to perform object detection on a Picamera feed.
# It draws boxes and scores around the objects of interest in each frame from
# the Picamera. It also can be used with a webcam by adding "--usbcam"
# when executing this script from the terminal. With added functionality
# of identifying a pair of scissors and giving the x,y coordinants relative to the 
# center of the frame as well as the distance

## Some of the code is copied from Google's example at
## https://github.com/tensorflow/models/blob/master/research/object_detection/object_detection_tutorial.ipynb

## and some is copied from Dat Tran's example at
## https://github.com/datitran/object_detector_app/blob/master/object_detection_app.py

## but I changed it to make it more understandable to me.

#test imports
#import sys
#sys.path
#sys.path.insert(0, '~/tensorflow1/models/research/object_detection')

# The lines with calls to rust are # 39# 138 # 185-186 #213

# Import packages
import os
import cv2
import numpy as np
from picamera.array import PiRGBArray
from picamera import PiCamera
import tensorflow as tf
import argparse
import sys
import math
#import camera_control_lib as ccont

# Set up camera constants -- RESOLUTION
#IM_WIDTH = 320
#IM_HEIGHT = 240
#IM_WIDTH = 640    #Use smaller resolution for original 1280 x 720
#IM_HEIGHT = 480   #slightly faster framerate
IM_WIDTH = 640
IM_HEIGHT = 480



# Select camera type (if user enters --usbcam when calling this script,
# a USB webcam will be used)
camera_type = 'usb'
parser = argparse.ArgumentParser()
parser.add_argument('--picam', help='Use a pi webcam instead of usb',
                    action='store_true')
args = parser.parse_args()
if args.picam:
    camera_type = 'picamera'

# This is needed since the working directory is the object_detection folder.
sys.path.append('..')

# Import utilites
from utils import label_map_util
from utils import visualization_utils as vis_util

# Name of the directory containing the object detection module we're using
MODEL_NAME = 'ssdlite_mobilenet_v2_coco_2018_05_09'

# Grab path to current working directory
CWD_PATH = os.getcwd()

# Path to frozen detection graph .pb file, which contains the model that is used
# for object detection.
PATH_TO_CKPT = os.path.join(CWD_PATH,MODEL_NAME,'frozen_inference_graph.pb')

# Path to label map file
PATH_TO_LABELS = os.path.join(CWD_PATH,'data','mscoco_label_map.pbtxt')

# Number of classes the object detector can identify
NUM_CLASSES = 90

## Load the label map.
# Label maps map indices to category names, so that when the convolution
# network predicts `5`, we know that this corresponds to `airplane`.
# Here we use internal utility functions, but anything that returns a
# dictionary mapping integers to appropriate string labels would be fine
label_map = label_map_util.load_labelmap(PATH_TO_LABELS)
categories = label_map_util.convert_label_map_to_categories(label_map, max_num_classes=NUM_CLASSES, use_display_name=True)
category_index = label_map_util.create_category_index(categories)

# Load the Tensorflow model into memory.
detection_graph = tf.Graph()
with detection_graph.as_default():
    od_graph_def = tf.GraphDef()
    with tf.gfile.GFile(PATH_TO_CKPT, 'rb') as fid:
        serialized_graph = fid.read()
        od_graph_def.ParseFromString(serialized_graph)
        tf.import_graph_def(od_graph_def, name='')

    sess = tf.Session(graph=detection_graph)


# Define input and output tensors (i.e. data) for the object detection classifier

# Input tensor is the image
image_tensor = detection_graph.get_tensor_by_name('image_tensor:0')

# Output tensors are the detection boxes, scores, and classes
# Each box represents a part of the image where a particular object was detected
detection_boxes = detection_graph.get_tensor_by_name('detection_boxes:0')

# Each score represents level of confidence for each of the objects.
# The score is shown on the result image, together with the class label.
detection_scores = detection_graph.get_tensor_by_name('detection_scores:0')
detection_classes = detection_graph.get_tensor_by_name('detection_classes:0')

# Number of objects detected
num_detections = detection_graph.get_tensor_by_name('num_detections:0')

# Initialize frame rate calculation
frame_rate_calc = 1
freq = cv2.getTickFrequency()
font = cv2.FONT_HERSHEY_SIMPLEX

# Initialize camera and perform object detection.
# The camera has to be set up and used differently depending on if it's a
# Picamera or USB webcam.

# I know this is ugly, but I basically copy+pasted the code for the object
# detection loop twice, and made one work for Picamera and the other work
# for USB.
detect_flag = False
detect_limit = 3
detect_counter = 0
object_coord = []
obj_x = None
obj_y = None
#ccont.set_origin(IM_WIDTH/2,IM_HEIGHT/2)

anchor_flag = False
anchor_x = None
anchor_y = None
anchor_code = 76 #keyboard
origin_x = 0 #IM_WIDTH/2
origin_y = 0#IM_HEIGHT/2
cam_x = origin_x
cam_y = origin_y
home = True
tolerance = 100

### USBcamera ###
if camera_type == 'usb':
    # Initialize USB webcam feed
    camera = cv2.VideoCapture(0)
    ret = camera.set(3,IM_WIDTH)
    ret = camera.set(4,IM_HEIGHT)

    while(True):
        origin_x = int(IM_WIDTH/2)
        origin_y = int(IM_HEIGHT/2)
        t1 = cv2.getTickCount()

        # Acquire frame and expand frame dimensions to have shape: [1, None, None, 3]
        # i.e. a single-column array, where each item in the column has the pixel RGB value
        ret, frame = camera.read()
        frame_expanded = np.expand_dims(frame, axis=0)

        # Perform the actual detection by running the model with the image as input
        (boxes, scores, classes, num) = sess.run(
            [detection_boxes, detection_scores, detection_classes, num_detections],
            feed_dict={image_tensor: frame_expanded})

        # Draw the results of the detection (aka 'visulaize the results')
        vis_util.visualize_boxes_and_labels_on_image_array(
            frame,
            np.squeeze(boxes),
            np.squeeze(classes).astype(np.int32),
            np.squeeze(scores),
            category_index,
            use_normalized_coordinates=True,
            line_thickness=6,
            min_score_thresh=0.55)
        
        cv2.putText(frame,"FPS: {0:.2f}".format(frame_rate_calc),(30,50),font,1,(255,255,0),2,cv2.LINE_AA)
        print(classes[0][0],classes[0][1], classes[0][2])

        # setting anchor
        if anchor_flag == False and int(classes[0][0]) == anchor_code:
            anchor_x = int(((boxes[0][0][1]+boxes[0][0][3])/2)*IM_WIDTH)
            anchor_y = int(((boxes[0][0][0]+boxes[0][0][2])/2)*IM_HEIGHT)
            anchor_flag = True

        #using anchor to find camera coordinates
        if anchor_flag == True:
            if classes[0][2] == anchor_code:
                new_anchor_x = int(((boxes[0][2][1]+boxes[0][2][3])/2)*IM_WIDTH)
                new_anchor_y = int(((boxes[0][2][0]+boxes[0][2][2])/2)*IM_HEIGHT)
            if classes[0][1] == anchor_code:
                new_anchor_x = int(((boxes[0][1][1]+boxes[0][1][3])/2)*IM_WIDTH)
                new_anchor_y = int(((boxes[0][1][0]+boxes[0][1][2])/2)*IM_HEIGHT)
            if classes[0][0] == anchor_code:
                new_anchor_x = int(((boxes[0][0][1]+boxes[0][0][3])/2)*IM_WIDTH)
                new_anchor_y = int(((boxes[0][0][0]+boxes[0][0][2])/2)*IM_HEIGHT)
            
            delta_x = new_anchor_x - anchor_x
            delta_y = new_anchor_y - anchor_y
            cam_x += delta_x
            cam_y += delta_y
            anchor_x = new_anchor_x
            anchor_y = new_anchor_y
            #print(cam_x, cam_y)

        if cam_x > tolerance or cam_y > tolerance or cam_x < -tolerance or cam_y < -tolerance:
            home = False
        else:
            home = True

        # checking for specific class
        if int(classes[0][0]) == 44 or int(classes[0][1]) == 44: #44 is water bottle class
            if classes[0][0] == 44:
                x = int(((boxes[0][0][1]+boxes[0][0][3])/2)*IM_WIDTH)
                y = int(((boxes[0][0][0]+boxes[0][0][2])/2)*IM_HEIGHT)
            if classes[0][1] == 44:
                x = int(((boxes[0][1][1]+boxes[0][1][3])/2)*IM_WIDTH)
                y = int(((boxes[0][1][0]+boxes[0][1][2])/2)*IM_HEIGHT)
            #ccont.set_new_x(x)
            #ccont.set_new_y(y)
            object_coord.append([x,y])
            detect_flag = True
            detect_counter = detect_limit
            # center of object frame
            cv2.circle(frame,(x,y),2,(0,255,0),-1) #circle to find (0,0)
            dist = math.sqrt((x - origin_x )**2 + (y - origin_y)**2)
            if object_coord != []:
                cv2.circle(frame,(object_coord[0][0],object_coord[0][1]),2,(255,255,255), -1)

            print("there is a bottle at ", str(x - origin_x), str(y - origin_y), str(dist), " from origin")
        if int(classes[0][0]) != 44 or int(classes[0][1]) != 44: 
            detect_counter -=1 
            if detect_flag == True:
                if detect_counter <= 0:
                    init_x = object_coord[0][0]
                    init_y = object_coord[0][1]
                    fin_x = object_coord[-1][0]
                    fin_y = object_coord[-1][1]
                    x_dist = fin_x - init_x
                    y_dist = fin_y - init_y
                    print("object lost")
                    print("object moved distance x: " + str(x_dist) + ", y: " + str(y_dist))
                    detect_flag = False
                    object_coord = []
                    detect_counter = 0
                    #ccont.return_to_origin()
            elif detect_flag == True:
                print("bottle not detected")
            else:
                print("no object found")
                if home == False:
                    print("returning home")
                    print(str(-cam_x),  str(-cam_y))
            
        # draw circle in center of camera frame
        cv2.circle(frame,(origin_x,origin_y),4,(0,0,255),-1) #circle to find (0,0)

        # All the results have been drawn on the frame, so it's time to display it.
        cv2.imshow('Object detector', frame)

        t2 = cv2.getTickCount()
        time1 = (t2-t1)/freq
        frame_rate_calc = 1/time1

        # Press 'q' to quit
        if cv2.waitKey(1) == ord('q'):
            #print("classes", classes)
            #print("scores", scores)
            #print("boxes", boxes)
            break

    camera.release()
### Picamera ###
elif camera_type == 'picamera':
    # Initialize Picamera and grab reference to the raw capture
    camera = PiCamera()
    camera.resolution = (IM_WIDTH,IM_HEIGHT)
    camera.framerate = 10
    rawCapture = PiRGBArray(camera, size=(IM_WIDTH,IM_HEIGHT))
    rawCapture.truncate(0)

    for frame1 in camera.capture_continuous(rawCapture, format="bgr",use_video_port=True):

        t1 = cv2.getTickCount()
        
        # Acquire frame and expand frame dimensions to have shape: [1, None, None, 3]
        # i.e. a single-column array, where each item in the column has the pixel RGB value
        frame = np.copy(frame1.array)
        frame.setflags(write=1)
        frame_expanded = np.expand_dims(frame, axis=0)

        # Perform the actual detection by running the model with the image as input
        (boxes, scores, classes, num) = sess.run(
            [detection_boxes, detection_scores, detection_classes, num_detections],
            feed_dict={image_tensor: frame_expanded})

        # Draw the results of the detection (aka 'visulaize the results')
        vis_util.visualize_boxes_and_labels_on_image_array(
            frame,
            np.squeeze(boxes),
            np.squeeze(classes).astype(np.int32),
            np.squeeze(scores),
            category_index,
            use_normalized_coordinates=True,
            line_thickness=8,
            min_score_thresh=0.40)

        cv2.putText(frame,"FPS: {0:.2f}".format(frame_rate_calc),(30,50),font,1,(255,255,0),2,cv2.LINE_AA)

        # All the results have been drawn on the frame, so it's time to display it.
        cv2.imshow('Object detector', frame)

        t2 = cv2.getTickCount()
        time1 = (t2-t1)/freq
        frame_rate_calc = 1/time1

        # Press 'q' to quit
        if cv2.waitKey(1) == ord('q'):
            break

        rawCapture.truncate(0)

    camera.close()

cv2.destroyAllWindows()

