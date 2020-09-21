chmod 777 run.sh
ghdl -a dividerrr.vhd
ghdl -a gcdsin1.vhd
ghdl -a gcdsin_test1.vhd
ghdl -m gcdsin_test1
ghdl -r gcdsin_test1 --stop-time=13us --wave=run.ghw
gtkwave run.ghw
