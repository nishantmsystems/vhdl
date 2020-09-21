 
package MyFsmPack is
 type fsm_state is (phi,A, B, C, D,COMPUTE, ERROR);
end MyFsmPack;
 
library work;
use work.MyFsmPack.all;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity SimpleCalci is 
  port (data_in : in std_logic_vector(3 downto 0);
		data_valid : in std_logic;
		data_out : out std_logic_vector(7 downto 0);
		clk, reset: in std_logic);
end entity SimpleCalci;
-----------------------------------------------------------------
architecture Behave of SimpleCalci is
 
 signal state_sig: fsm_state; 
begin
process(data_valid,clk,state_sig,data_in)
    	variable D1,D2,D3,D4,D5: std_logic_vector(3 downto 0) ;
   	variable temp1,temp3:integer;
		variable temp2: std_logic_vector(3 downto 0);
	variable nstate: fsm_state;

begin
   --nstate := state_sig;
   case state_sig is
     when  phi => 
	data_out <= "11111111";
	 if ( data_valid='1') then
      		 if(data_in ="1010") then    ----- (
			nstate := A;   
	  	 elsif ((data_in<"1010")or(data_in>"1010")) then
			nstate:=ERROR;
		end if;
	end if;
------------------------------------------------------------------------------------
     when A =>
	 if (data_valid='1') then
      		 if(data_in <"1010")  then     -------0,1,2,3,4,5,6,7,8,9
			D2:=data_in;
         		nstate:= B;		 
      		 elsif (data_in>="1010") then 
			 nstate:=ERROR;
       		end if;
	end if;
	
------------------------------------------------------------------------------------
     when B =>
	  if (data_valid='1') then
		if(data_in >= "1100") then    --------12*,13+,14-,15/
			D3:=data_in;
			nstate := C;
		elsif (data_in<"1100") then
			nstate:= ERROR;
	end if;
end if;
	
-------------------------------------------------------------------------------------
     when C =>
	  if ( data_valid='1') then
     	   	if(data_in <= "1001")  then    -------0,1,2,3,4,5,6,7,8,9
			 D4:=data_in;
         		nstate := D;
       		elsif (data_in>"1001") then
		 nstate:=ERROR;  
	 	end if;
	  end if;
-----------------------------------------------------------------------------------
     when D =>
	 if (data_valid='1') then
        	 if(data_in = "1011") then     ------)
		 	nstate := COMPUTE;			  
        	elsif ((data_in<"1011")or(data_in>"1011")) then
          		 nstate := ERROR;
         	end if;
		 
	 end if;
----------------------------------------------------------------------------------------
     when COMPUTE =>
		if (D3="1101") then	
			temp1:=conv_integer(D2)+conv_integer(D4);
			data_out<=conv_std_logic_vector(temp1,8);
		elsif D3="1110" then 
			if (D2>=D4) then
			temp1:=conv_integer(D2)-conv_integer(D4);
			data_out<=conv_std_logic_vector(temp1,8);
			elsif(D2<D4) then
			temp1:=conv_integer(D2)-conv_integer(D4);
			temp1:=(15+temp1)+1;
			data_out<=conv_std_logic_vector(temp1,8);
			end if;
		elsif D3="1100" then
			temp1:=conv_integer(D2)*conv_integer(D4);
			data_out<=conv_std_logic_vector(temp1,8);
		elsif D3="1111" then
			if (D4="0000") then
				nstate:=ERROR;
			else
				temp1:=conv_integer(D2)/conv_integer(D4);
				data_out<=conv_std_logic_vector(temp1,8);
			end if;
	end if;
------------------------------------------------------------------------------------------
	when ERROR =>
	data_out <= "11111111";
end case; 
   if (clk'event and clk='1') then 
		if(reset='1') then
			--data_out <= "11111111";
			state_sig <= phi;
		elsif(reset='0') then
			if (data_valid='0') then
				state_sig <= nstate;
			else
				state_sig<=state_sig;
			end if;
		end if;
	 end if;        
end process;
end Behave;




