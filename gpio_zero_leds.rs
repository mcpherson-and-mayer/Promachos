// Copyright © Sharice Mayer
// [This program is licensed under the "MIT License"]
// Please see the file LICENSE in the source 
// distribution of this software for license terms

// include statements
use rust_gpiozero::*;
use std::thread;
use std::time::Duration;

fn main() {
    // new led on pin 17
    let green_led = LED::new(17);
    // new led on pin 27
    let red_led = LED::new(27);
    // new led on pin 22
    let blue_led = LED::new(22);
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
    // green_led.blink(3.0, 2.0);
    // 4 times
    for _ in 0.. 4 {
        red_led.on();
        thread::sleep(Duration::from_secs(2));
        red_led.off();

        green_led.on();
        thread::sleep(Duration::from_secs(2));
        green_led.off();

        blue_led.on();
        thread::sleep(Duration::from_secs(2));
        blue_led.off();

        yellow1_led.on();
        thread::sleep(Duration::from_secs(2));
        yellow1_led.off();

        yellow2_led.on();
        thread::sleep(Duration::from_secs(2));
        yellow2_led.off();

        yellow3_led.on();
        thread::sleep(Duration::from_secs(2));
        yellow3_led.off();

        yellow4_led.on();
        thread::sleep(Duration::from_secs(2));
        yellow4_led.off();

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
    }

    // prevent program for immediate exit
    // green_led.wait();
}

