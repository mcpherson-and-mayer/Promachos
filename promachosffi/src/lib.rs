// Copyright © 2019 Sharice Mayer
// [This program is licensed under the "MIT License"]
// Please see the file LICENSE in the source
// distribution of this software for license terms.

// This is just a test program for making sure workflow using rust python FFI works
// Modify to work with LEDS and motors later

#[macro_use]
extern crate cpython;
extern crate rust_gpiozero;
use cpython::{Python, PyResult};
//use std::str::FromStr;
//use std::fmt::Write;
use rust_gpiozero::*;
use std::thread;
use std::time::Duration;
use std::convert::TryInto;
//use std::fmt::Debug;

///! A package for ffi between rust and python
///! Functions to help communicate and light up leds
///! using a python rust FFI
///! This package provides python bindings for the rust crate
///! [cpython]

/// Type of GPIO function. If the function
/// is ill-defined, `None` will be returned.
pub type GPIOFn = fn(Python, &[String]) -> PyResult<String>;

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

/// Basic Usage:
/// >>> count_doubles(val)
/// 'promachos::foo(double)'
///
/// Passing an invalid identifier will throw a ValueError:
///
/// >>> functioncall('invalid c++ symbol')
/// Traceback (most recent call last):
/// ...
/// ValueError: symbol is not well-formed

// This function count_doubles is an example from Bruno Rocha's blog:
//https://developers.redhat.com/blog/2017/11/16/speed-python-using-rust/
pub fn count_doubles(_py: Python, val: &str) -> PyResult<u64> {
    let mut total = 0u64;
    for (c1, c2) in val.chars().zip(val.chars().skip(1)) {
        if c1 == c2 {
            total += 1;
        }
    }
    Ok(total)
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
//fn blink_led(_py: Python, val:&str) -> PyResult<&str> {
pub fn blink_led(_py: Python, args: &str) -> PyResult<String> {
    let args = args.to_owned().to_string();
    let mut message = String::new();
    let mut count = 0;

    if !args.is_empty() {
        for slice in &[args] { 
            for arg in slice.lines(){
                let line = arg.to_string(); 
                if count == 0 {  
                    message = line.to_string();  // get the message
                    println!("{}", message);
                    count +=1;
                } else {
                    let mut iter = line.split_ascii_whitespace(); // separate args by spaces
                    let curr_command = Command {
                        msg: message,
                        pin: iter.next().unwrap().to_string().parse().unwrap(),
                        ontime: iter.next().unwrap().to_string().parse().unwrap(),
                        offtime: iter.next().unwrap().to_string().parse().unwrap(),
                    };  
                    // new led on given pin
                    let pin = curr_command.pin;
                    let x_led = LED::new(pin.try_into().unwrap());
                    message = curr_command.msg + " ";
                    message = message + &(curr_command.ontime.to_string());
                    message = message + " seconds\n";
                    // blink on for x seconds, off for y seconds
                    //x_led.blink(curr_command.ontime, curr_command.offtime);
                    x_led.on();
                    thread::sleep(Duration::from_secs(curr_command.ontime.try_into().unwrap()));
                    x_led.off();
                    thread::sleep(Duration::from_secs(curr_command.offtime.try_into().unwrap()));
                } //end if else //count
            } // end for arg in slice.lines()
        } // end for slice in &args[..]
    } // end if !args.is_empty()
    else{
        message = "No Command Found\n".to_string();
    }
    Ok(message)
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




py_module_initializer!(libpromachosffilib, initlibpromachosffilib, PyInit_promachosffilib, |py, m | {
    r#try!(m.add(py, "__doc__", "This module is implemented in Rust"));
    r#try!(m.add(py, "count_doubles", py_fn!(py, count_doubles(val: &str))));
    r#try!(m.add(py, "blink_led", py_fn!(py, blink_led(args: &str))));
    Ok(())
});



//#[cfg(test)]
//mod tests {
//    #[test]
//    fn it_works() {
//        assert_eq!(2 + 2, 4);
//    }
//}

