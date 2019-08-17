# Copyright © 2019 Sharice Mayer
# mayers.research@gmail.com
# [This program is licensed under the "MIT License"]
# Please see the file LICENSE in the source
# distribution of this software for license terms.

# This is just a python test program for making sure workflow using rust python FFI works
# Modify to work with LEDS and motors later

import re
import string
import random
import itertools
import promachosffilib  # <-- Importing Rust Implemented Library

# This function count_doubles is an example from Bruno Rocha's blog:
#https://developers.redhat.com/blog/2017/11/16/speed-python-using-rust/
def count_doubles(val):
    total = 0
    for c1, c2 in zip(val, val[1:]):
        if c1 == c2:
            total += 1
    return total

def blink_led(args):
    for line in args:
        print("line = {}", line)
        total = total + line

    return total

val = ''.join(random.choice(string.ascii_letters) for i in range(1000000))

def test_pure_python(benchmark):
    print(benchmark(count_doubles, val))

def test_rust(benchmark):
    print(benchmark(promachosffilib.count_doubles, val))


