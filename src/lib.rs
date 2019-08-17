
//https://developers.redhat.com/blog/2017/11/16/speed-python-using-rust/
/// A package for ffi between rust and python
///
/// This package provides python bindings for the rust crate
/// [cpython]
///
/// Basic usage:
///
/// >>> count_doubles(val)
/// 'promachos::foo(double)'
///
/// Passing an invalid identifier will throw a ValueError:
///
/// >>> functioncall('invalid c++ symbol')
/// Traceback (most recent call last):
/// ...
/// ValueError: symbol is not well-formed
#[macro_use]
extern crate cpython;
use cpython::{Python, PyResult};
use std::str::FromStr;


fn count_doubles(_py: Python, val: &str) -> PyResult<u64> {
    let mut total = 0u64;
    for (c1, c2) in val.chars().zip(val.chars().skip(1)) {
        if c1 == c2 {
            total += 1;
        }
    }
    Ok(total)
}

py_module_initializer!(libpromachosffilib, initlibpromachosffilib, PyInit_promachosffilib, |py, m | {
    r#try!(m.add(py, "__doc__", "This module is implemented in Rust"));
    r#try!(m.add(py, "count_doubles", py_fn!(py, count_doubles(val: &str))));
    Ok(())
});



//#[cfg(test)]
//mod tests {
//    #[test]
//    fn it_works() {
//        assert_eq!(2 + 2, 4);
//    }
//}

