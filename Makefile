all: dt-blob.bin

dt-blob.bin: dt-blob.dts
	dtc -I dts -O dtb -o $@ $<

install: dt-blob.bin
	cp $< /boot/

.PHONY: all install
