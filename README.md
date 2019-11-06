At the moment, this is a set of basic functions to communicate with the Arduino
(http://www.arduino.cc). It should probably cover 98% of use cases. It uses the
MIT licensed Arduino-serial library, made by Tod E. Kurt,
(https://github.com/todbot/arduino-serial) and the
GetC macro of Jasper den Ouden (https://github.com/o-jasper).

#Installation

```julia
Pkg.add("Arduino")
```

#Usage

```julia
using Arduino

fd = init("/dev/tty.usbserial",9600) # open usb port with 9600 baud rate and get back FD to communicate with Arduino on

writebyte(fd,uint8(1)) # send a byte to the Arduino

write(fd,"string") # send a string to the Arduino

buf = Array(Char, 256)
read_until(fd, buf, '\n', , ) # read Arduino data into buf until a newline char is reached

flush(fd) # clear all contents of the receiving buffer
```

#Credit

Thanks to the Julia team (http://julialang.org) for making Julia, a programming
language that many have been longing for, whether they knew about it or not.
The "Octave-for-C-programmers," as I like to think of it, is an incredibly fast
and powerful programming language that is a welcome breath of fresh air in the
technical and numerical programming communities.

--rennis250 
