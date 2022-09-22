#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2022.1.2 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Wed Sep 21 19:10:25 PDT 2022
# SW Build 3605665 on Fri Aug  5 22:52:02 MDT 2022
#
# IP Build 3603185 on Sat Aug  6 04:07:44 MDT 2022
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# simulate design
echo "xsim fifo_tb_behav -key {Behavioral:sim_1:Functional:fifo_tb} -tclbatch fifo_tb.tcl -log simulate.log"
xsim fifo_tb_behav -key {Behavioral:sim_1:Functional:fifo_tb} -tclbatch fifo_tb.tcl -log simulate.log

