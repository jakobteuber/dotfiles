# aengelke's .gdbinit for x86(-64) and ARM(64).
# How to install: place this into ~/.gdbinit on your machine. That's it.
#
#
#
# Copyright (c) 2016-2019, Alexis Engelke
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

set pagination off
set follow-fork-mode child
catch fork
catch exec

set output-radix 16

python

try:
    gdb.execute('set disassembly-flavor intel')
except Exception:
    # On non-x86 architectures, this doesn't work.
    pass

archs = [
    {
        "name": "i386:x86-64", "long": True,
        "regs": "rdi rsi rdx rcx rax rbx rbp rsp".split() + ["r"+str(i) for i in range(8, 16)],
    }, {
        "name": "i386",
        "regs": "edi esi edx ecx eax ebx ebp esp".split(),
    }, {
        "name": "arm",
        "regs": ["r"+str(i) for i in range(11)] + "fp ip sp lr pc".split(),
    }, {
        "name": "aarch64", "long": True,
        "regs": ["x"+str(i) for i in range(31)] + ["sp"],
    }
]
regsFmt = {}
isLong = {arch["name"]: "long" in arch for arch in archs}
for arch in archs:
    fmt = ["{:>3}: %{}lx".format(r, 16 if "long" in arch else 8) for r in arch["regs"]]
    fmt = "".join([" ".join(fmt[i:i+4]) + "\\n" for i in range(0, len(fmt), 4)])
    regsFmt[arch["name"]] = 'printf "{0}\\n", {1}'.format(fmt, ",".join(["$"+r for r in arch["regs"]]))


def py_stop_hook():
    try:
        arch = gdb.selected_frame().architecture().name()
        if arch not in isLong: return

        gdb.write('\n\033[92m')
        try:
            gdb.execute('x/5i $pc')
        except Exception:
            gdb.execute('printf "Could not parse instructions at %#lx", $pc\n')
        gdb.write('\033[0m\n')

        gdb.execute(regsFmt[arch])

        try:
            if isLong[arch]:
                stackFormat = 'printf "\033[2m%#lx:\033[0m %#018lx %#018lx %#018lx %#018lx\\n", $sp+8*{0}, *((long*)$sp + {0}), *((long*)$sp + {1}), *((long*)$sp + {2}), *((long*)$sp + {3})'
            else:
                stackFormat = 'printf "\033[2m%#lx:\033[0m %#010lx %#010lx %#010lx %#010lx\\n", $sp+4*{0}, *((int*)$sp + {0}), *((int*)$sp + {1}), *((int*)$sp + {2}), *((int*)$sp + {3})'
            for i in range(4):
                gdb.execute(stackFormat.format(i*4, i*4+1, i*4+2, i*4+3))
        except Exception:
            gdb.execute('printf "Could not read stack at %#lx", $sp\n')
            pass
        gdb.write('\033[0m\n')
    except Exception:
        pass
end

define hook-stop
    python py_stop_hook()
end
