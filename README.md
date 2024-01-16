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

## Usage

1. make check
2. press Ctrl+a, release, then press x
3. make clean
4. source ~/emsdk/emsdk_env.sh
5. make CC=emcc
6. run your web server to host the semu.html

## License

`semu` is released under the MIT License.
Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.
