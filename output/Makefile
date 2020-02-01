###################################################################
# Project Configuration: 
###################################################################
PROJECT ?= altera-fpga-example
TOP_LEVEL_ENTITY ?= top_level

VHDL2008 ?= set_global_assignment -name VHDL_INPUT_VERSION VHDL_2008

###################################################################
# Part, Family, Boardfile DE0 / DE1 / DE2
###################################################################
FAMILY ?= "Cyclone IV E"
PART ?= EP4CE22F17C6
BOARDFILE ?= ../cfgs/de0_pins

###################################################################
# Setup your sources here
###################################################################
SRCS ?= $(wildcard ../fpga/*)

###################################################################
# Main Targets
###################################################################
all: $(PROJECT).sof

program: $(PROJECT).sof
	$(QUARTUS)/quartus_pgm --no_banner --mode=jtag -o "P;$(PROJECT).sof"

clean:
	rm -rf *.rpt *.chg smart.log *.htm *.eqn *.pin *.sof *.pof \
		*.done db incremental_db $(PROJECT).*

.PHONY: all program clean

###################################################################
# Executable Configuration
###################################################################
MAP_ARGS = --read_settings_files=on $(addprefix --source=,$(SRCS))

FIT_ARGS = --part=$(PART) --read_settings_files=on
ASM_ARGS =
STA_ARGS =

###################################################################
# Target implementations
###################################################################
$(PROJECT).sof: sta.done
$(PROJECT).pof: sta.done

###################################################################
# Project initialization
###################################################################
STAMP = @date > $@

cfg.done: $(BOARDFILE)
	$(QUARTUS)/quartus_sh --prepare -f $(FAMILY) -t $(TOP_LEVEL_ENTITY) $(PROJECT)
	@cat $(BOARDFILE) >> $(PROJECT).qsf
	@echo $(VHDL2008) >> $(PROJECT).qsf
	$(QUARTUS)/quartus_sh --determine_smart_action $(PROJECT) > smart.log
	$(STAMP)

map.done: cfg.done $(SRCS)
	$(QUARTUS)/quartus_map $(MAP_ARGS) $(PROJECT)
	$(STAMP)

fit.done: map.done
	$(QUARTUS)/quartus_fit $(FIT_ARGS) $(PROJECT)
	$(STAMP)

asm.done: fit.done
	$(QUARTUS)/quartus_asm $(ASM_ARGS) $(PROJECT)
	$(STAMP)

sta.done: asm.done
	$(QUARTUS)/quartus_sta $(STA_ARGS) $(PROJECT) 
	$(STAMP)
