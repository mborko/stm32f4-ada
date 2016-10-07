
GNATDIR = /home/mike/opt/gnat-arm/bin
export PATH := $(GNATDIR):$(PATH)

OUTDIR	= build

MKDIR	= mkdir -p
RM	= rm -rf

all: $(OUTDIR)
	gprbuild -P main.gpr

$(OUTDIR):
	$(MKDIR) $(OUTDIR)

clean:
	gprclean -P main.gpr

cleanall:
	-$(RM) $(OUTDIR)/*

flash:
	openocd -f /usr/share/openocd/scripts/board/stm32f4discovery.cfg -f ocd.cfg

