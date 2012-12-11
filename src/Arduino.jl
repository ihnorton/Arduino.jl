require("GetC")

module Arduino

import GetC.@get_c_fun

arduino = dlopen("libarduino.so")

@get_c_fun arduino init serialport_init(serialport::Ptr{Uint8}, baud::Int32)::Int32
export init
@get_c_fun arduino writebyte serialport_writebyte(fd::Int32, b::Uint8)::Int32
export writebyte
@get_c_fun arduino write serialport_write(fd::Int32, str::Ptr{Uint8})::Int32
export write
@get_c_fun arduino read_until serialport_read_until(fd::Int32, buf::Ptr{Uint8}, until::Char)::Int32
export read_until

end
