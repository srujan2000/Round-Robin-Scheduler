CC= arm-none-eabi-gcc#cross-compiler
MACH= cortex-m4#machine
CFLAGS= -c -mcpu=$(MACH) -mthumb -g -std=gnu11 -Wall -O0 -ffunction-sections #cpu is cortex-m4 , thumb ISA, c standard is GNU11, -wall is enable warning ,-O0 is zero level optmization 
LFLAGS= -nostdlib -T sched_ls.ld -Wl,-Map=final.map #no standard library and linker script
GDB= arm-none-eabi-gdb

all: main.o final.elf debug

#target:dependency $@=main.c(dependency) $^=main.o(target)
main.o:main.s
	$(CC) $(CFLAGS) -o $@ $^  

final.elf:main.o 
	$(CC) $(LFLAGS) -o $@ $^

debug:
	arm-none-eabi-objdump -D  -S final.elf > final.lst


qemu:
	qemu-system-arm -S -M stm32vldiscovery -cpu cortex-m3 -nographic -kernel final.elf -gdb tcp::1234
	
gdb:
	gdb-multiarch final.elf -ex "target remote localhost:1234" -ex "break Reset_Handler"

.PHONY: clean
clean:
	rm -rf *.o *.elf *.lst .gdb_history final.map