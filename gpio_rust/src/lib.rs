// Copyright © 2019 Sharice Mayer 
// [This program is licensed under the "MIT License"]
// Please see the file LICENSE in the source
// distribution of this software for license terms.

//! All code common to binaries will be in this file

//! Functions for implementing FFI 
//! from Rust through C to use with Python

/// Type of my_ffi function. If the ffi
/// is ill-defined, `None` will be returned.
pub type MyFFIFn = fn(&[i64]) -> Option<i64>;

// None set_origin(origin_x, origin_y)
//pub fn set_origin(origin_x: &[i64], origin_y: &[i64]) -> Option<i64> {
pub fn set_origin(origin_coords: &[i64]) -> Option<i64> {
    println!("Setting x_coord and y_coord");
    //return coords if set. else None?
    None
}

// None set_new_x(new_x)
pub fn set_new_x(new_x: &[i64]) -> Option<i64> {
    println!("setting new x_coord");
    None
}

// None set_new_y(new_y)
pub fn set_new_y(new_y: &[i64]) -> Option<i64> {
    println!("setting new y_coord");
    None
}

// i64 get_cur_x()
pub fn get_cur_x(an_x: &[i64]) -> Option<i64> {
    println!("getting x coord");
    None
}

// i64 get_cur_y()
pub fn get_cur_y(a_y: &[i64]) -> Option<i64> {
    println!("getting y coord");
    None
}

// None fire()
pub fn fire(curr_coords: &[i64]) -> Option<i64> {
    println!("firing!");
    None
}

// None return_to_origin()
pub fn return_to_origin(ret_coords: &[i64]) -> Option<i64> {
    println!("returning to origin...");
    None
}


///// Type of my_ffi function. If the ffi
///// is ill-defined, `None` will be returned.
//pub type MyFFIFn = fn(&[f64]) -> Option<f64>;
//ALL BELOW FOR STRUCTURAL EX ONLY... REMOVE AS REPLACED

///// Arithmetic mean of input values. The mean of an empty
///// list is 0.0.
/////
///// # Examples:
/////
///// ```
///// # use stats::*;
///// assert_eq!(Some(0.0), mean(&[]));
///// ```
///// ```
///// # use stats::*;
///// assert_eq!(Some(0.0), mean(&[-1.0, 1.0]));
///// ```
//pub fn mean(nums: &[f64]) -> Option<f64> {
//    let count = nums.len() as f64;
//    let mut arithmetic = 0.0;
//    let mut sum = 0.0;
//    if count != 0.0 {
//        for num in &nums[..] {
//            sum += num;
//        }
//        arithmetic = sum / count;
//    }
//    Some(arithmetic)
//}

//#[test]
//fn test_mean_100() {
//    assert_eq!(Some(100.0), mean(&[75.5, 100.5, 95.5, 265.5, -37.0]));
//}

//#[test]
//fn test_mean_single() {
//    assert_eq!(Some(25.0), mean(&[25.0]));
//}

//#[test]
//fn test_mean_two() {
//    assert_eq!(Some(1.0), mean(&[-1.0, 3.0]));
//}

