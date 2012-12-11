require("Arduino")
using Arduino

fd = init("/dev/tty.usbserial",9600) # open usb port with 9600 baud rate and get back FD to communicate with Arduino on

writebyte(fd,uint8(1)) # send a byte to the Arduino

write(fd,"string") # send a string to the Arduino

buf = Array(Char, 256)
read_until(fd, buf, '\n') # read Arduino data into buf until a newline char is reached
