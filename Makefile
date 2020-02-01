###################################################################
# Quartus default path
###################################################################
export QUARTUS ?= /opt/intelFPGA_lite/19.1/quartus/bin

###################################################################
# Project Configuration
###################################################################
export PROJECT = DE0NanoExample
export TOP_LEVEL_ENTITY = top_level

###################################################################
# Part, Family, Boardfile DE0 / DE1 / DE2
###################################################################
export FAMILY = "Cyclone IV E"
export PART = EP4CE22F17C6
export BOARDFILE = $(CURDIR)/cfgs/de0_pins

###################################################################
# Setup your sources here
###################################################################
export SRCS = $(wildcard $(CURDIR)/fpga/*)

all:
	@make -C output $@

program:
	@make -C output $@

clean:
	@make -C output $@

.PHONY: all program clean
