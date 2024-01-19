include mk/common.mk

CC ?= gcc
CFLAGS = -O2 -Wall
LDFLAGS = -lpthread
SHELL := /bin/bash

# For building riscv-tests
CROSS_COMPILE ?= riscv64-unknown-elf-

BIN := semu

ifeq ("$(CC)", "emcc")
BIN := $(BIN).js
EMCC_CFLAGS += -sINITIAL_MEMORY=2GB --pre-js pre.js --embed-file kernel.bin --embed-file fs.img \
			        -sEXPORTED_FUNCTIONS=_main \
				-sEXPORTED_RUNTIME_METHODS=getValue,setValue,stringToNewUTF8,addFunction \
				-sALLOW_TABLE_GROWTH \
				-sSTACK_SIZE=4MB \
				-sMALLOC=mimalloc \
				-sUSE_PTHREADS \
				-sPTHREAD_POOL_SIZE=3
endif

OBJS := semu.o

# Whether to enable riscv-tests
ENABLE_RISCV_TESTS ?= 0
ifeq ("$(ENABLE_RISCV_TESTS)", "1")
CFLAGS += -DENABLE_RISCV_TESTS
OBJS += tests/isa-test.o
endif

deps := $(OBJS:%.o=%.o.d)

%.o: %.c
	$(VECHO) "  CC\t$@\n"
	$(Q)$(CC) -o $@ $(CFLAGS) -c -MMD -MF $@.d $<

all: $(BIN)

$(BIN): $(OBJS)
	$(VECHO) "  LD\t$@\n"
	$(Q)$(CC) -o $@ $(EMCC_CFLAGS) $^ $(LDFLAGS)
	sudo cp semu.html /var/www/html/xv6
	sudo cp semu.js /var/www/html/xv6
	sudo cp semu.worker.js /var/www/html/xv6
	sudo cp semu.wasm /var/www/html/xv6
	sudo cp -r node_modules /var/www/html/xv6

# Rules for downloading xv6 kernel and root file system
include mk/external.mk

check: $(BIN) $(KERNEL_DATA) $(ROOTFS_DATA)
	@$(call notice, Ready to launch xv6. Please be patient.)
	$(Q)./$(BIN) $(KERNEL_DATA) $(ROOTFS_DATA)

# unit tests for RISC-V processors
include mk/riscv-tests.mk

clean:
	$(Q)$(RM) $(BIN) $(OBJS) $(deps) semu.js semu.worker.js semu.wasm
distclean: clean
	$(Q)rm -rf $(KERNEL_DATA) $(ROOTFS_DATA)
	-$(Q)$(MAKE) -C $(RISCV_TESTS_DIR)/isa clean $(REDIR)
	$(Q)rm -rf $(RISCV_TESTS_BIN_DIR)

-include $(deps)
