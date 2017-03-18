
BUILD =build
SOURCE=source
CC=gcc
CC_INPUT=main.cpp
CC_OUTPUT=main.o
#CC_PARAM1=-c -g -Os -march=x86-64 -ffreestanding -Wall -Werror 
CC_PARAM1=-c -g -Os -march=x86-64 -Wall -Werror 
CC_PARAM2=-o
CC_PARAM3=-m32

ASM=ld
ASM_INPUT=EntryPoint.ld
ASM_ELF=Boot.elf
ASM_PARAM1=-static -T
ASM_PARAM2=-nostdlib --nmagic -o

install: clean CPP ASM

CPP:	$(CURDIR)/$(SOURCE)/main.cpp
		@echo
		$(CC) $(CC_PARAM1) $(CURDIR)/$(SOURCE)/$(CC_INPUT) $(CC_PARAM2) $(CURDIR)/$(BUILD)/$(CC_OUTPUT) $(CC_PARAM3) 
		ls $(CURDIR)/$(BUILD)
		@echo		"C++ файлы скомпилированы успешно"
		@echo
ASM:
		ls $(CURDIR)/$(BUILD)
		$(ASM) $(ASM_PARAM1)$(CURDIR)/$(SOURCE)/$(ASM_INPUT) $(ASM_PARAM2) $(CURDIR)/$(BUILD)/$(ASM_ELF) $(CURDIR)/$(BUILD)/$(CC_OUTPUT) -m elf_i386
		@echo		"ASM файлы скомпилированы успешно"
		@echo
clean:
	rm -v $(CURDIR)/$(BUILD)/*.*
	
