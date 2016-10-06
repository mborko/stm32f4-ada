# STM32F4-Discovery Makefile
#
# Part of the stm32f4-discovery project
#
#######################################
PATH := "$(PATH):/home/mike/opt/gnat-arm/bin"
SHELL := env PATH=$(PATH) /bin/bash -c

# TARGET: name of the output file
TARGET = demo

# MCU: part number to build for
MCU = STM32F4XX

# OUTDIR: directory to use for output
OUTDIR = build
MAINFILE = $(OUTDIR)/$(TARGET).bin

#######################################
# output configs
#######################################
ifeq ($(NOCOLOR),1)
	CYAN            = ""
	NORMAL          = ""
else
	CYAN        = `tput setaf 6`
	NORMAL      = `tput sgr0`
endif
#######################################
# binaries
#######################################
OBJCOPY = arm-none-eabi-objcopy
OPENOCD = openocd
BUILD	= @$(SHELL) gprbuild -v
CLEAN	= @$(SHELL) gprclean -v
FLASH	= st-flash
RM      = rm -rf
MKDIR	= mkdir -p
#######################################

# list of object files, placed in the build directory regardless of source path
OBJECTS = $(addprefix $(OUTDIR)/,$(notdir $(SOURCES:.c=.o)))
ASM_OBJECTS = $(addprefix $(OUTDIR)/,$(notdir $(ASM_SOURCES:.s=.o)))
LIB_OBJECTS = $(addprefix $(LIB_OUTDIR)/,$(notdir $(LIB_SOURCES:.c=.o)))

# default: build bin
all: $(OUTDIR)/$(TARGET).bin

$(OUTDIR)/$(TARGET): $(OUTDIR)
	@echo -e "Building\t\t"$(CYAN)$^$(NORMAL)
	$(BUILD)

$(MAINFILE): $(OUTDIR)/$(TARGET)
	@$(OBJCOPY) -O binary $< $@

# create the output directory
$(OUTDIR):
	$(MKDIR) $(OUTDIR)

program: $(MAINFILE) 
	$(OPENOCD) -f config/openocd.cfg

flash: $(MAINFILE)
	$(FLASH) --reset write $(MAINFILE) 0x08000000

debug: flash
	./debug/nemiver.sh $(TARGET)

cleanall:
	-$(RM) $(OUTDIR)/*

clean:
	$(CLEAN)

test:
	$(BUILD)

.PHONY: all clean
