CC = xtensa-lx106-elf-gcc
CFLAGS = -I. -mlongcalls
LDLIBS = -nostdlib -Wl,--start-group -lmain -lnet80211 -lwpa -llwip -lpp -lphy -Wl,--end-group -lgcc
LDFLAGS = -Teagle.app.v6.ld

espdht-0x00000.bin: espdht
	esptool.py elf2image $^

espdht: espdht.o

espdht.o: espdht.c

flash: espdht-0x00000.bin
	esptool.py write_flash 0 espdht-0x00000.bin 0x40000 espdht-0x40000.bin
