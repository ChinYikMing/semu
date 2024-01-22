# semu

A minimalist RISC-V system emulator capable of running Linux the kernel and corresponding userland.
`semu` implements the following:
- RISC-V instruction set architecture: RV32IMA
- Privilege levels: S and U modes
- Control and status registers (CSR)
- Virtual memory system: RV32 MMU
- UART: 8250/16550
- PLIC (platform-level interrupt controller): 32 interrupts, no priority
- Standard SBI, with the timer extension
- VirtIO: virtio-blk acquires disk image from the host, and virtio-net is mapped as TAP interface

## Steps to reproduce

1. git clone https://github.com/ChinYikMing/semu.git --depth=1 -b linux-wasm
2. cd semu
2. source ~/emsdk/emsdk_env.sh
3. make CC=emcc
4. node semu.js

## License

`semu` is released under the MIT License.
Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.
