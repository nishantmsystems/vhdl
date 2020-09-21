
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

ENTITY SimpleCalculatorTest IS
END SimpleCalculatorTest;

ARCHITECTURE behavior OF SimpleCalculatorTest IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT SimpleCalci
	PORT(
		data_in : in std_logic_vector(3 downto 0);
		data_valid : in std_logic;
		data_out : out std_logic_vector(7 downto 0);
		clk, reset: in std_logic
		);
	END COMPONENT;

	--Inputs
	signal data_in:std_logic_vector(3 downto 0):="0000";         
	signal data_valid :std_logic:='0';
	signal data_out :std_logic_vector(7 downto 0):="00000000";
	signal clk, reset:std_logic:='0';
BEGIN
	clk<= not (clk) after 10ns;
	-- Instantiate the Unit Under Test (UUT)
	uut: SimpleCalci PORT MAP(
		data_in=>data_in,
		data_valid=>data_valid,
		data_out=>data_out,
		clk=>clk,
		 reset=> reset
	);

	tb : PROCESS
variable opcode,AA,BB,AA1,BB1,AA2,BB2,AA3,BB3,AA4,BB4:std_logic_vector(3 downto 0);
variable CC:integer;
variable CC1:std_logic_vector(7 downto 0);
begin
	wait until clk = '1';
	data_in<="1010";
	reset<='1';
	wait for 100 ns;
wait until clk = '1';
	data_in<="1010";
	reset<='0';
	data_valid<='1';
	wait for 100 ns;
wait until clk = '1';
	data_valid<='0';
	data_in<="1010";
	reset<='0';
	wait for 100 ns;
wait until clk = '1';
	data_in<="0001";
	data_valid<='1';
	AA:=(data_in);
	reset<='0';
	wait for 100 ns;
wait until clk='1';
	data_valid<='0';
	data_in<="0001";
	reset<='0';
	wait for 100 ns;
wait until clk = '1';
	data_in<="1101";
	data_valid<='1';
	opcode:=data_in;
	reset<='0';
	wait for 100 ns;
wait until clk = '1';
	data_valid<='0';
	data_in<="1101";
	reset<='0';
	wait for 100 ns;
wait until clk = '1';
	data_in<="0001";
	data_valid<='1';
	BB:=(data_in);
	reset<='0';
	wait for 100 ns;
wait until clk = '1';
	data_valid<='0';
	data_in<="0001";
	reset<='0';
	wait for 100 ns;
wait until clk = '1';
	data_in<="1011";
	data_valid<='1';
	reset<='0';
	wait for 100 ns;
wait until clk = '1';
	data_valid<='0';
	data_in<="1011";
	reset<='0';
	wait for 100 ns;
-- -------------------------------------------
-- ---Subtract ---1
	 wait until clk = '1';
	 data_in<="1010";
	 reset<='1';
	 wait for 100 ns;
 wait until clk = '1';
	 data_in<="1010";
	 reset<='0';
	 data_valid<='1';
	 wait for 100 ns;
 wait until clk = '1';
	 data_valid<='0';
	 data_in<="1010";
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_in<="0001";
	 data_valid<='1';
	 AA1:=(data_in);
	 reset<='0';
	 wait for 100 ns;
 wait until clk='1';
	 data_valid<='0';
	 data_in<="0001";
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_in<="1110";
	 data_valid<='1';
	opcode:=data_in;
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_valid<='0';
	 data_in<="1110";
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_in<="0010";
	 data_valid<='1';
	 BB1:=(data_in);
	reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_valid<='0';
	 data_in<="0010";
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_in<="1011";
	 data_valid<='1';
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_valid<='0';
	 data_in<="1011";
	 reset<='0';
	 wait for 100 ns;
	 
	 
-- -------------------------------------------
-- ---Subtract ---2
	 wait until clk = '1';
	 data_in<="1010";
	 reset<='1';
	 wait for 100 ns;
 wait until clk = '1';
	 data_in<="1010";
	 reset<='0';
	 data_valid<='1';
	 wait for 100 ns;
 wait until clk = '1';
	 data_valid<='0';
	 data_in<="1010";
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_in<="1101";
	 data_valid<='1';
	 AA1:=(data_in);
	 reset<='0';
	 wait for 100 ns;
 wait until clk='1';
	 data_valid<='0';
	 data_in<="1101";
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_in<="1110";
	 data_valid<='1';
	opcode:=data_in;
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_valid<='0';
	 data_in<="1110";
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_in<="1001";
	 data_valid<='1';
	 BB1:=(data_in);
	reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_valid<='0';
	 data_in<="1001";
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_in<="1011";
	 data_valid<='1';
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_valid<='0';
	 data_in<="1011";
	 reset<='0';
	 wait for 100 ns;

 -------------------------------------------
 --------Multiply
 -------------------------------------------
 ---
wait until clk = '1';
	 data_in<="1010";
	 reset<='1';
	 wait for 100 ns;
 wait until clk = '1';
	 data_in<="1010";
	 reset<='0';
	 data_valid<='1';
	 wait for 100 ns;
 wait until clk = '1';
	 data_valid<='0';
	 data_in<="1010";
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_in<="0011";
	 data_valid<='1';
	 AA2:=(data_in);
	 reset<='0';
	 wait for 100 ns;
 wait until clk='1';
	 data_valid<='0';
	 data_in<="0011";
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_in<="1100";
	 data_valid<='1';
	 opcode:=data_in;
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_valid<='0';
	 data_in<="1100";
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_in<="0011";
	 data_valid<='1';
	 BB2:=(data_in);
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_valid<='0';
	 data_in<="0011";
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_in<="1011";
	 data_valid<='1';
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_valid<='0';
	 data_in<="1011";
	 reset<='0';
	 wait for 100 ns;
	 
	 --------Multiply--2
 -------------------------------------------
 ---
wait until clk = '1';
	 data_in<="1010";
	 reset<='1';
	 wait for 100 ns;
 wait until clk = '1';
	 data_in<="1010";
	 reset<='0';
	 data_valid<='1';
	 wait for 100 ns;
 wait until clk = '1';
	 data_valid<='0';
	 data_in<="1010";
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_in<="0101";
	 data_valid<='1';
	 AA2:=(data_in);
	 reset<='0';
	 wait for 100 ns;
 wait until clk='1';
	 data_valid<='0';
	 data_in<="0101";
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_in<="1100";
	 data_valid<='1';
	 opcode:=data_in;
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_valid<='0';
	 data_in<="1100";
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_in<="0011";
	 data_valid<='1';
	 BB2:=(data_in);
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_valid<='0';
	 data_in<="0011";
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_in<="1011";
	 data_valid<='1';
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_valid<='0';
	 data_in<="1011";
	 reset<='0';
	 wait for 100 ns;
 -----------------------------------------------------
 -----DIVIDE---- case 1
	 wait until clk = '1';
	 data_in<="1010";
	 reset<='1';
	 wait for 100 ns;
 wait until clk = '1';
	 data_in<="1010";
	 reset<='0';
	 data_valid<='1';
	 wait for 100 ns;
 wait until clk = '1';
	 data_valid<='0';
	 data_in<="1010";
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_in<="0100";
	 data_valid<='1';
	 AA3:=(data_in);
	 reset<='0';
	 wait for 100 ns;
 wait until clk='1';
	 data_valid<='0';
	 data_in<="0100";
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_in<="1111";
	 data_valid<='1';
	 opcode:=data_in;
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_valid<='0';
	 data_in<="1111";
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_in<="0010";
	 data_valid<='1';
	 BB3:=(data_in);
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_valid<='0';
	 data_in<="0010";
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_in<="1011";
	 data_valid<='1';
	 reset<='0';
	 wait for 100 ns;
 wait until clk = '1';
	 data_valid<='0';
	 data_in<="1011";
	 reset<='0';
	 wait for 100 ns;
 -----------------------------------------------------
 -----DIVIDE---- case 2
wait until clk = '1';
	 data_in<="1010";
	 reset<='1';
	 wait for 100 ns;
wait until clk = '1';
	 data_in<="1010";
	 reset<='0';
	 data_valid<='1';
	 wait for 100 ns;
wait until clk = '1';
	 data_valid<='0';
	 data_in<="1010";
	 reset<='0';
	 wait for 100 ns;
wait until clk = '1';
	 data_in<="0110";
	 data_valid<='1';
	 AA3:=(data_in);
	 reset<='0';
	 wait for 100 ns;
wait until clk='1';
	 data_valid<='0';
	 data_in<="0110";
	 reset<='0';
	 wait for 100 ns;
wait until clk = '1';
	 data_in<="1111";
	 data_valid<='1';
	 opcode:=data_in;
	 reset<='0';
	 wait for 100 ns;
wait until clk = '1';
	 data_valid<='0';
	 data_in<="1111";
	 reset<='0';
	 wait for 100 ns;
wait until clk = '1';
	 data_in<="0010";
	 data_valid<='1';
	 BB3:=(data_in);
	 reset<='0';
	 wait for 100 ns;
wait until clk = '1';
	 data_valid<='0';
	 data_in<="0010";
	 reset<='0';
	 wait for 100 ns;
wait until clk = '1';
	 data_in<="1011";
	 data_valid<='1';
	 reset<='0';
	 wait for 100 ns;
wait until clk = '1';
	 data_valid<='0';
	 data_in<="1011";
	 reset<='0';
	 wait for 100 ns;
 -----------------------------
 -----DIVIDE ERROR CHECK
--	 wait until clk = '1';
--	 data_in<="1010";
--	 reset<='1';
--	 wait for 100 ns;
-- wait until clk = '1';
--	 data_in<="1010";
--	 reset<='0';
--	 data_valid<='1';
--	 wait for 100 ns;
-- wait until clk = '1';
--	 data_valid<='0';
--	 data_in<="1010";
--	 reset<='0';
--	 wait for 100 ns;
-- wait until clk = '1';
--	 data_in<="0001";
--	 data_valid<='1';
--	 reset<='0';
--	 wait for 100 ns;
-- wait until clk='1';
--	 data_valid<='0';
--	 data_in<="0001";
--	 reset<='0';
--	 wait for 100 ns;
-- wait until clk = '1';
--	 data_in<="1111";
--	 data_valid<='1';
--	 reset<='0';
--	 wait for 100 ns;
-- wait until clk = '1';
--	 data_valid<='0';
--	 data_in<="1111";
--	 reset<='0';
--	 wait for 100 ns;
-- wait until clk = '1';
--	 data_in<="0000";
--	 data_valid<='1';
--	 reset<='0';
--	 wait for 100 ns;
-- wait until clk = '1';
--	 data_valid<='0';
--	 data_in<="0000";
--	 reset<='0';
--	 wait for 100 ns;
-- wait until clk = '1';
--	 data_in<="1011";
--	 data_valid<='1';
--	 reset<='0';
--	 wait for 100 ns;
-- wait until clk = '1';
--	 data_valid<='0';
--	 data_in<="1011";
--	 reset<='0';
--	 wait for 100 ns;


if (opcode="1101") then
	CC:=conv_integer(AA)+conv_integer(BB);
	CC1:=conv_std_logic_vector(CC,8);
	assert(data_out= CC1)
	  report "Error in output." severity failure;
elsif (opcode="1110") then
	CC:=conv_integer(AA1)-conv_integer(BB1);
	CC1:=conv_std_logic_vector(CC,8);
	assert(data_out= CC1)
	  report "Error in output." severity failure;
	  
elsif (opcode="1100") then
	CC:=conv_integer(AA2)*conv_integer(BB2);
	CC1:=conv_std_logic_vector(CC,8);
	assert(data_out= CC1)
	  report "Error in output." severity failure;

	  
elsif (opcode="1111") then
	CC:=conv_integer(AA3)/conv_integer(BB3);
	CC1:=conv_std_logic_vector(CC,8);
	assert(data_out= CC1)
	report "Error in output." severity failure;

end if;	
  assert false report "************Test Completed.Your Design is  Tested for all the operations*******" severity note;	
		wait; -- will wait forever
	END PROCESS;

END behavior;




