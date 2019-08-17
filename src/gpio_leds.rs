// Copyright © Sharice Mayer
// [This program is licensed under the "MIT License"]
// Please see the file LICENSE in the source 
// distribution of this software for license terms


// Right now this is a main function. Needs to be changed to be a library file?

// include statements
use rust_gpiozero::*;
use std::thread;
use std::time::Duration;

fn main() {
    // new led on pin 17
    let blue_led = LED::new(17);
    // new led on pin 27
    let red_led = LED::new(27);
    // new led on pin 22
    let green_led = LED::new(22);
    // new led on pin 23
    let yellow1_led = LED::new(23);
    // new led on pin 24
    let yellow2_led = LED::new(24);
    // new led on pin 25
    let yellow3_led = LED::new(25);
    // new led on pin 12
    let yellow4_led = LED::new(12);
    // new led on pin 24
    //let x_led = LED::new(24);

    // blink on for 3 seconds, off for 2 seconds
    // x_led.blink(3.0, 2.0);

    // Test each light setup for proper gpio connection
    // blinking them on for 2 seconds in succession.
    // 4 times each (in a loop)
    for _ in 0.. 4 {
        // Uncomment these these lines for more single light testing
        //yellow1_led.on();
        //thread::sleep(Duration::from_secs(2));
        //yellow1_led.off();
        //yellow2_led.on();
        //thread::sleep(Duration::from_secs(2));
        //yellow2_led.off();
        //yellow3_led.on();
        //thread::sleep(Duration::from_secs(2));
        //yellow3_led.off();
        //yellow4_led.on();
        //thread::sleep(Duration::from_secs(2));
        //yellow4_led.off();

        // Testing Functionality Communication
        println!("\n\nFIRING!!!");
        red_led.on();
        thread::sleep(Duration::from_secs(2));
        red_led.off();

        println!("TARGET LOST");
        blue_led.on();
        thread::sleep(Duration::from_secs(2));
        blue_led.off();

        println!("RETURN HOME\n");
        green_led.on();
        thread::sleep(Duration::from_secs(2));
        green_led.off();

        // Testing Target Movement Direction
        println!("UP");
        yellow2_led.on();
        yellow3_led.on();
        thread::sleep(Duration::from_secs(2));
        yellow2_led.off();
        yellow3_led.off();

        println!("DOWN");
        yellow1_led.on();
        yellow4_led.on();
        thread::sleep(Duration::from_secs(2));
        yellow1_led.off();
        yellow4_led.off();

        println!("LEFT");
        yellow1_led.on();
        yellow2_led.on();
        thread::sleep(Duration::from_secs(2));
        yellow1_led.off();
        yellow2_led.off();

        println!("RIGHT");
        yellow3_led.on();
        yellow4_led.on();
        thread::sleep(Duration::from_secs(2));
        yellow3_led.off();
        yellow4_led.off();

        //println!("turning x_led on");
        //x_led.on();
        //thread::sleep(Duration::from_secs(2));
        //println!("turning x_led off");
        //x_led.off();
        //thread::sleep(Duration::from_secs(1));
    } // end for

    // prevent program for immediate exit
    // x_led.wait();
} // end main



// This is just a stub of a program that still needs to be written to communicate with the led
// lights
// using rust FFI

use std::fmt::Write;
//use std::fmt::Debug;

///! Functions to help communicate and light up leds
///! using a python rust FFI

/// Type of led function. If the function
/// is ill-defined, `None` will be returned.
pub type LedsFn = fn(&[String]) -> Option<String>;

/// Struct to hold command data for lighting up led
/// pin: GPIO Pin
/// ontime: time in seconds to stay on
/// msg: message to print
/// offtime: tim in seconds to stay off(if any)
#[derive(Debug, Clone)]
pub struct Command {
        pub msg: String,
        pub pin:  i32,
        pub ontime:  i32,
        pub offtime: i32,
}

/// Blink Light
/// Initialise with GPIO pin number
/// Print given message
/// Blink for specified on time
/// Stay off for specified offtime(if any)
///
/// # Examples:
///
/// ```
/// # use promachos::*;
/// assert_eq!(Some("Firing!! 2 seconds\n".to_string()), blink_led(&[String::from("Firing!! \n17 2 0")]));
/// ```
/// ```
/// # use promachos::*;
/// assert_eq!(Some("No Command Found\n".to_string()), blink_led(&[String::from("")]));
/// ```
pub fn blink_led(args: &[String]) -> Option<String> {
    //println!("Printing passed in args: \n {:?} \n", args);
    let mut args = args.to_owned();
    let mut message = String::new();
    let mut count = 0;
    let mut x_led: LED;

    if !args.is_empty() {
        for slice in &args[..] { //println!("slice={:?}", slice);
            for arg in slice.lines(){
                let line = arg.to_string(); //println!("line=\n{}", line);
                if count == 0 {  
                    message = line.to_string();  // get the message
                    println!("{}", message);
                    count +=1;
                } else {
                    let mut iter = line.split_ascii_whitespace(); // separate args by spaces
                    let mut new_canvas = String::new();
                    let mut position = 0;
                    let curr_command = Command {
                        msg: message,
                        pin: iter.next().unwrap().to_string().parse().unwrap(),
                        ontime: iter.next().unwrap().to_string().parse().unwrap(),
                        offtime: iter.next().unwrap().to_string(),parse().unwrap(),
                    };  //println!("{:?}\n", iter.next());
                    //println!("\n\tcurr_command:\n\t{:?}", curr_command);
                    // new led on given pin
                    let x_led = LED::new(cur_command.pin);
                    message = message + " ";
                    //let secs: &String = &curr_command.ontime;//necessary?
                    message = message + &(curr_command.ontime);
                    message = message + " seconds\n";
                    // blink on for x seconds, off for y seconds
                    //x_led.blink(curr_command.ontime, curr_command.offtime);
                    x_led.on();
                    thread::sleep(Duration::from_secs(curr_command.ontime));
                    x_led_led.off();
                    thread::sleep(Duration::from_secs(curr_command.offtime));
                } //end if else //count
            } // end for arg in slice.lines()
        } // end for slice in &args[..]
    } // end if !args.is_empty()
    else{
        message = "No Command Found\n".to_string();
    }
    Some(message);
}

#[test]
fn test_add_to_canvas_01() {
    assert_eq!(
        Some("Target Lost... 4 seconds\n".to_string()),
        blink_led(&["Target Lost... 23 4 0"])
    );
}


#[test]
fn test_nostart_motor() {
    assert_eq!(Some("No Command Found\n"), blink_led(&[""]));
}


#[test]
fn test_blink_led17_3() {
    assert_eq!(Some("Returning Home... 3 seconds\n".to_string()), blink_led(&[String::from("Returning Home... \n17 3 0")]));
}

