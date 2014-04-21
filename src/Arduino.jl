module Arduino

import GetC.@getCFun

const ardLib = "libarduino"

@getCFun ardLib init serialport_init(serialport::Ptr{Uint8}, baud::Int32)::Int32
export init
@getCFun ardLib writebyte serialport_writebyte(fd::Int32, b::Uint8)::Int32
export writebyte
@getCFun ardLib write serialport_write(fd::Int32, str::Ptr{Uint8})::Int32
export write
@getCFun ardLib read_until serialport_read_until(fd::Int32, buf::Ptr{Uint8}, until::Char, buf_max::Int32, timeout::Int32)::Int32
export read_until
@getCFun ardLib flush serialport_flush(fd::Int32)::Int32
export flush
@getCFun ardLib close serialport_close(fd::Int32)::Int32
export close

end
