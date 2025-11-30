COMPILER = riscv64-unknown-elf
CC = $(COMPILER)-gcc
OBJDUMP = $(COMPILER)-objdump
CFLAGS = -O0 -g -mabi=ilp32 -march=rv32i_zicsr -std=gnu11
LFLAGS = -nostdlib -Wl,-Map=output.map -T linker.ld

all:
	$(CC) $(CFLAGS) $(LFLAGS) main.s -o main.elf

objdump:
	$(OBJDUMP) -h main.elf >> objdump.txt
	$(OBJDUMP) -D -s main.elf >> final.lst

qemu:
	qemu-system-riscv32 -S -nographic -machine virt -bios none -kernel main.elf -gdb tcp::1234

gdb:
	gdb-multiarch main.elf -ex "target remote localhost:1234" -ex "break main"

.PHONY:clean
clean:
	rm *.elf *.map .gdb_history *.lst objdump.txt