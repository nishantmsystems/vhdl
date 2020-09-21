
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

ENTITY testbench IS
END testbench;

ARCHITECTURE behavior OF testbench IS 

COMPONENT SimpleCalculator
	PORT(
		 data_in :in std_logic_vector(31 downto 0);
		data_is_digit: in std_logic;
		data_valid : in std_logic;
		data_out : out std_logic_vector(31 downto 0);
		error: out std_logic;
		clk, reset: in std_logic
		);
END COMPONENT;

		signal data_in : std_logic_vector(31 downto 0);
		signal data_is_digit: std_logic;
		signal data_valid :  std_logic;
		signal data_out : std_logic_vector(31 downto 0);
		signal error:  std_logic;
		signal clk:std_logic:='0'; 
		signal reset:std_logic:='0';
		
BEGIN
	
	clk<= not (clk) after 10ns;
	-- Instantiate the Unit Under Test (UUT)
	uut: SimpleCalculator PORT MAP(
												data_in=> data_in,
												data_is_digit=>data_is_digit,
												data_valid=>data_valid,
												data_out =>data_out,
												error=>error,
												clk=>clk,
												reset=>reset
								  );

tb : PROCESS
begin
reset<='0';
data_is_digit<='0';
data_valid<='0';
data_in<="00000000000000000000000000000001";
wait for 30 ns;
reset<='1';
data_is_digit<='0';
data_valid<='0';
data_in<="00000000000000000000000000000001";			---bracket
wait for 20 ns;
data_valid<='1';
wait for 40 ns;
data_valid<='0';
wait for 40 ns;

data_is_digit<='0';
data_valid<='0';
data_in<="00000000000000000000000000000001";			---bracket
wait for 20 ns;
data_valid<='1';
wait for 40 ns;
data_valid<='0';
wait for 40 ns;



data_is_digit<='0';
data_valid<='0';
data_in<="00000000000000000000000000000001";			---bracket
wait for 20 ns;
data_valid<='1';
wait for 40 ns;
data_valid<='0';
wait for 40 ns;



data_is_digit<='1';
data_in<="00000000000000000000000000000100";			----first number
wait for 20 ns;
data_valid<='1';
wait for 40 ns;
data_valid<='0';



data_is_digit<='0';
data_in<="00000000000000000000000000000100";			----+---
wait for 20 ns;
data_valid<='1';
wait for 40 ns;
data_valid<='0';
--3      *
--4      +
--5      -
--6      /


data_is_digit<='1';
data_in<="00000000000000000000000000000001";	----- 2nd number
wait for 20 ns;
data_valid<='1';
wait for 40 ns;
data_valid<='0';



data_is_digit<='0';
data_in<="00000000000000000000000000000010";			---- close bracket
wait for 20 ns;
data_valid<='1';
wait for 120 ns;
data_valid<='0';
wait for 80 ns;

data_is_digit<='0';
data_in<="00000000000000000000000000000100";			----+---
wait for 20 ns;
data_valid<='1';
wait for 40 ns;
data_valid<='0';

data_is_digit<='1';
data_in<="00000000000000000000000000001100";	----- 2nd number
wait for 20 ns;
data_valid<='1';
wait for 40 ns;
data_valid<='0';

data_is_digit<='0';
data_in<="00000000000000000000000000000010";			---- close bracket
wait for 20 ns;
data_valid<='1';
wait for 120 ns;
data_valid<='0';
wait for 80 ns;

data_is_digit<='0';
data_in<="00000000000000000000000000000100";			----+---
wait for 20 ns;
data_valid<='1';
wait for 40 ns;
data_valid<='0';

data_is_digit<='1';
data_in<="00000000000000000000000000001100";	----- 2nd number
wait for 20 ns;
data_valid<='1';
wait for 40 ns;
data_valid<='0';

data_is_digit<='0';
data_in<="00000000000000000000000000000010";			---- close bracket
wait for 20 ns;
data_valid<='1';
wait for 120 ns;
data_valid<='0';
wait for 130 ns;

--------------------------------------------------------------------------------------------------
reset<='0';
data_is_digit<='0';
data_valid<='0';
data_in<="00000000000000000000000000000001";
wait for 60 ns;
reset<='1';
data_is_digit<='0';
data_valid<='0';
data_in<="00000000000000000000000000000001";			---bracket
wait for 20 ns;
data_valid<='1';
wait for 40 ns;
data_valid<='0';
wait for 40 ns;

data_is_digit<='0';
data_valid<='0';
data_in<="00000000000000000000000000000001";			---bracket
wait for 20 ns;
data_valid<='1';
wait for 40 ns;
data_valid<='0';
wait for 40 ns;

data_is_digit<='1';
data_in<="00000000000000000000000000000100";			----first number
wait for 20 ns;
data_valid<='1';
wait for 40 ns;
data_valid<='0';



data_is_digit<='0';
data_in<="00000000000000000000000000000100";			--------
wait for 20 ns;
data_valid<='1';
wait for 40 ns;
data_valid<='0';
--3      *
--4      +
--5      -
--6      /


data_is_digit<='1';
data_in<="00000000000000000000000000000001";	----- 2nd number
wait for 20 ns;
data_valid<='1';
wait for 40 ns;
data_valid<='0';



data_is_digit<='0';
data_in<="00000000000000000000000000000010";			---- close bracket
wait for 20 ns;
data_valid<='1';
wait for 120 ns;
data_valid<='0';
wait for 80 ns;

data_is_digit<='0';
data_in<="00000000000000000000000000000100";			----+---
wait for 20 ns;
data_valid<='1';
wait for 40 ns;
data_valid<='0';

data_is_digit<='1';
data_in<="00000000000000000000000000001100";	----- 2nd number
wait for 20 ns;
data_valid<='1';
wait for 40 ns;
data_valid<='0';

data_is_digit<='0';
data_in<="00000000000000000000000000000010";			---- close bracket
wait for 20 ns;
data_valid<='1';
wait for 120 ns;
data_valid<='0';
wait for 80 ns;

wait;
end process;
end behavior;



