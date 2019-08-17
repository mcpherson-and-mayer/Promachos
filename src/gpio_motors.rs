// Copyright © 2019 Sharice Mayer
// [This program is licensed under the "MIT License"]
// Please see the file LICENSE in the source
// distribution of this software for license terms.

// This is just a stub of a program that still needs to be written to communicate with the motors
// using rust FFI

use std::fmt::Write;
//use std::fmt::Debug;

///! Functions to help start and run a motor
///! using a python rust FFI

/// Type of motor function. If the function
/// is ill-defined, `None` will be returned.
pub type MotorsFn = fn(&[String]) -> Option<String>;

/// Struct to hold command data for moving motor.
/// xst: x starting coordinate
/// yst: y starting coordinate
/// dir: direction to move motor
/// (l=left; r=right; f=forward; b=back; pl=pan left; pr= pan right)
/// dis: distance to move(maybe seconds to move instead?)
#[derive(Debug, Clone)]
pub struct Command {
        pub xst:  i32, //cs
        pub yst:  i32, //rs
        pub dir: String,
        pub dis: i32,
}

/// Start Motor
/// Initialise with starting coordinates?
/// x_start, y_start
///
/// # Examples:
///
/// ```
/// # use promachos::*;
/// assert_eq!(Some("Motor Started at: 3, 5\n".to_string()), start_motor(&[String::from("3 5")]));
/// ```
/// ```
/// # use promachos::*;
/// assert_eq!(Some("No Coordinates Found\n".to_string()), start_motor(&[String::from("")]));
/// ```
pub fn start_motor(coords: &[String]) -> Option<String> {
    println!("\nStarting motor control test...");
    // declare variables for storing message and coordinates
    let mut xycoords: Vec<u32> = Vec::new();
    let mut message = String::new();
    
    // get xy coords
    if coords.len() != 0 {
        for coord in get_dims(&coords).unwrap().lines() {
            xycoords.push(line.parse().unwrap());
        }
        // build start message
        let mut curr_str = "Motor Started at: ".to_string();
        let y = xycoords.pop();  // get y
        let x = xycoords.pop();  // get x
        curr_str = curr_str + x;
        curr_str = curr_str + ",";
        curr_str = curr_str + y;
        writeln!(&mut message, "{}", curr_str).unwrap();
    }
    else{
        let curr_str = "No Coordinates Found".to_string();
        writeln!(&mut message, "{}", curr_str).unwrap();
    }
    Some(message)
}

#[test]
fn test_nostart_motor() {
    assert_eq!(Some("No Coordinates Found\n"), start_motor&[""]));
}


#[test]
fn test_start_motor_10_15() {
    assert_eq!(Some("Motor Started at: 10, 15\n".to_string()), start_motor(&[String::from("10 15")]));
}


// Optionally run as a binary file with main?
//fn main() {
    //code to start gpio motor control with rust/python
    // Start Code Here! :)
    // Start of program message

    // Start Motor
//    println!("\nStarting motor control test...");

    // Pan Camera Left
//    println!("\nPanning camera left");

    // Pan Camera Right
//    println!("\nPanning camera right");

    // Move robot forward
//    println!("\nDriving robot forward");

    // Move robot backwards
//    println!("\nDriving robot backwards");

    // Turn robot right
//    println!("\nTurning robot right");
    // Turn robot left

    // End of program message
//    println!("\nExiting motor control test... ");
//}
