ghdl -a FSM_PARITY_SEQUENCE.vhd
ghdl -a FSM_PARITY_SEQUENCE_TEST.vhd
ghdl -m FSM_PARITY_SEQUENCE_TEST
ghdl -r FSM_PARITY_SEQUENCE_TEST --stop-time=300ns --wave=run.ghw
