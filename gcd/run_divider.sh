chmod 777 run.sh
ghdl -a dividerrr.vhd
ghdl -a dividerr_test.vhd
ghdl -m dividerr_test
ghdl -r dividerr_test --stop-time=600ns --wave=run_divider.ghw
gtkwave run_divider.ghw
