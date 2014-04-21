using BinDeps

@BinDeps.setup

deps = [ arduino = library_dependency("Arduino", aliases = ["libarduino"]) ]

@linux_only begin
    prefix = joinpath(BinDeps.depsdir(arduino), "usr")
    ardsrcdir = joinpath(BinDeps.depsdir(arduino), "src", "arduino-serial-lib")
    ardbuilddir = joinpath(BinDeps.depsdir(arduino), "builds", "arduino-serial-lib")
    provides(BuildProcess,
            (@build_steps begin
                CreateDirectory(ardbuilddir)
                @build_steps begin
                    ChangeDirectory(ardbuilddir)
                    FileRule(joinpath(prefix, "lib", "libarduino.so"), @build_steps begin
                        `g++ -c -O -Wall -fpic -std=gnu99 $ardsrcdir/arduino-serial-lib.c`
                        `g++ -shared -o libarduino.so arduino-serial-lib.o`
                        `cp libarduino.so $prefix/lib`
                        `cp arduino-serial-lib.h $prefix/include`
                    end)
                end
             end), arduino, os = :Linux)
    run()
end

@osx_only begin
    prefix = joinpath(BinDeps.depsdir(arduino), "usr")
    ardsrcdir = joinpath(BinDeps.depsdir(arduino), "src", "arduino-serial-lib")
    ardbuilddir = joinpath(BinDeps.depsdir(arduino), "builds", "arduino-serial-lib")
    provides(BuildProcess,
            (@build_steps begin
                CreateDirectory(ardbuilddir)
                @build_steps begin
                    ChangeDirectory(ardbuilddir)
                    FileRule(joinpath(prefix, "lib", "libarduino.dylib"), @build_steps begin
                        `g++ -c -arch i386 -arch x86_64 -mmacosx-version-min=10.6 -O -Wall -fpic -std=gnu99 $ardsrcdir/arduino-serial-lib.c`
                        `g++ -dynamiclib -undefined suppress -flat_namespace arduino-serial-lib.o -o libarduino.dylib`
                        `cp libarduino.dylib $prefix/lib`
                        `cp arduino-serial-lib.h $prefix/include`
                    end)
                end
             end), arduino, os = :Darwin)
    run()
end

@windows_only begin
    prefix = joinpath(BinDeps.depsdir(arduino), "usr")
    ardsrcdir = joinpath(BinDeps.depsdir(arduino), "src", "arduino-serial-lib")
    ardbuilddir = joinpath(BinDeps.depsdir(arduino), "builds", "arduino-serial-lib")
    provides(BuildProcess,
            (@build_steps begin
                CreateDirectory(ardbuilddir)
                @build_steps begin
                    ChangeDirectory(ardbuilddir)
                    FileRule(joinpath(prefix, "lib", "libarduino.dll"), @build_steps begin
                        `g++ -c -O -Wall -std=gnu99 $ardsrcdir/arduino-serial-lib.c`
                        `g++ -shared -o libarduino.dll arduino-serial-lib.o -Wl,--out-implib,libarduino.a
                        `cp libarduino.dll $prefix/lib`
                        `cp libarduino.a $prefix/lib`
                        `cp arduino-serial-lib.h $prefix/include`
                    end)
                end
             end), arduino, os = :Windows)
    run()
end

@BinDeps.install