
package MyFsmPack is
 type fsm_state is (phistart,phi,s1,s2,s3,compute,errorstate,final,s7,s8,void1,void2,s9,sx2);
end MyFsmPack;
 
library work;
use work.MyFsmPack.all;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity SimpleCalculator is
port ( data_in :in std_logic_vector(31 downto 0):="00000000000000000000000000000000";
		data_is_digit: in std_logic:='0';
		data_valid : in std_logic:='0';
		data_out : out std_logic_vector(31 downto 0):="00000000000000000000000000000000";
		error: out std_logic:='0';
		clk : in std_logic;
		reset: in std_logic:='0');
end entity SimpleCalculator;

architecture Behave of SimpleCalculator is


component ran_single16 is
port(   clk : in std_logic;  --Clock for the stack.
        enable : in std_logic;  --enable the stack. Otherwise neither push nor pop will happen.
        data_in : in std_logic_vector(31 downto 0);  --Data to be pushed to stack
        data_out : out std_logic_vector(31 downto 0);  --Data popped from the stack.
        push : in std_logic;  --active low for POP and active high for PUSH.
        is_full : out std_logic;  --Goes high when the stack is full.
        is_empty : out std_logic  --Goes high when the stack is empty.
        );
end component ran_single16;

component ran_single8 is
port(   clk : in std_logic;  --Clock for the stack.
        enable : in std_logic;  --enable the stack. Otherwise neither push nor pop will happen.
        data_in : in std_logic_vector(31 downto 0);  --Data to be pushed to stack
        data_out : out std_logic_vector(31 downto 0);  --Data popped from the stack.
        push : in std_logic;  --active low for POP and active high for PUSH.
        is_full : out std_logic;  --Goes high when the stack is full.
        is_empty : out std_logic  --Goes high when the stack is empty.
        );
end component ran_single8;

signal pushoperand: std_logic;
signal pushoperation,enable_operation,enable_operand:std_logic;
signal data_inoperand,data_out_operand:std_logic_vector(31 downto 0);
signal data_inoperation,data_out_operation:std_logic_vector(31 downto 0);
signal is_full_operation :std_logic;
signal is_empty_operation :std_logic;
signal is_full_operand :std_logic;
signal is_empty_operand:std_logic;
signal state_sig: fsm_state; 
begin

duta: ran_single8 PORT MAP		(---- component of operation ram
											clk =>clk,
										   enable=>enable_operation,
										   data_in =>data_inoperation,
										   data_out=>data_out_operation,
										   push => pushoperation,
										   is_full=> is_full_operation,
										   is_empty=> is_empty_operation
										);
						
dutb: ran_single16 PORT MAP	(--- component of operand ram
											clk =>clk,
										   enable=>enable_operand,
										   data_in =>data_inoperand,
										   data_out=>data_out_operand,
										   push => pushoperand,
										   is_full=> is_full_operand ,
										   is_empty=> is_empty_operand
										);

										
process(reset,data_valid,data_is_digit,clk,state_sig,data_in)
variable nstate: fsm_state:=phistart;
variable number1,number2,operation,data_out_sample:std_logic_vector(31 downto 0):="00000000000000000000000000000000";
variable temp1:integer:=0;
variable count: integer :=0;
variable valid: std_logic:='0';
begin

		nstate:=state_sig;
			
				case state_sig is
						when phistart =>  --- when in phistart  state
												if (data_is_digit='0') then   --- if data digit is 0 then for brackets and operation check
														
														if ( data_valid='1' and valid='0') then   --- if data old is 0 and data new is 1 
															if(data_in="00000000000000000000000000000001") then   --- if bracket enters
																if clk='1' then     ----increment the counter
																count:=count+1;
																end if;
																nstate:=phi;     ---go to next state phi
															else 
																nstate:=errorstate;   ---anything other than bracket go to error state
															end if;
														end if;

												elsif(data_is_digit='1') then --- if data is a digit then
														if ( data_valid='1' and valid='0') then    ---if data old is 0 and data new is 1 then
															if(data_in<="11111111111111111111111111111111") then   ---if operand is entered
																nstate:=errorstate;   -- go to error state
															end if;
														end if;

												end if;
													
						when phi =>   -- when in phi state
										if (data_is_digit='0') then   --- if data is not a digit
												
												if ( data_valid='1' and valid='0') then  --- if data new is 1 and data old is 0 then
											
													if(data_in="00000000000000000000000000000001") then  --- if bracket comes
															if clk='1' then 
																count:=count+1;   --- increment bracket
																end if;
															nstate:=phi;  -- loop to same state
													else 
															nstate:=errorstate;  --- any other no digit input go to error state
													end if;
												end if;

										elsif(data_is_digit='1') then   --when data is digit 
												if ( data_valid='1' and valid='0') then   --- if datavalid new equal to 1 and datavalid =0 then
													if(data_in<="11111111111111111111111111111111") then   ---- if data in is operand less than or equal to 32 bit
													--number1:=data_in;--------NUMBER
													data_inoperand<=data_in; --- send the data to input to stack input
													enable_operand<='1'; ---enable push
													pushoperand<='1';  ---push value
													---push
														nstate:=s1;  --- go to S1
													else
														nstate:=errorstate; -- else go to error
													end if;
												end if;

										end if;
					
						when s1 =>	
										enable_operand<='0';   ---make enable 0 to stop pushing
										
										if (data_is_digit='0') then --if data is not a digit then
											if ( data_valid='1' and valid='0') then  -- if valid new is 1 and valid old is 0 then
												if((data_in>="00000000000000000000000000000011") and (data_in<="00000000000000000000000000000110")) then  --if operation
												--operation:=data_in; -----operation
												data_inoperation<=data_in;  --- send value to operation stack
													enable_operation<='1'; --enable push
													pushoperation<='1'; --send operation to stack
													---push
													nstate:=sx2; --- go to wait state
												else
													nstate:=errorstate;  --- else send to error state
												end if;
											end if;
	
										elsif(data_is_digit='1') then  --if digit then go to error state
											if ( data_valid='1' and valid='0') then
												nstate:=errorstate;
											end if;
	
										end if;
						when sx2 =>
										nstate:=s2; ---wait state
												
						when s2 =>
							enable_operation<='0';  ---make enable of operation stack 0
									  if (data_is_digit='1') then   --- if data is digit then
										  if ( data_valid='1' and valid='0') then   ---if valid new is 1 and valid old is 0 then
												if(data_in<="11111111111111111111111111111111") then  --- if number
												--number2:=data_in; -----number
												data_inoperand<=data_in;   --- send the number to input of stack
													enable_operand<='1';   -- enable push for operand
													pushoperand<='1';  --- make push 1
												--push
													nstate:=s3;  -- go to state s3
												else
													nstate:=errorstate;  -- else go to error
												end if;
										  end if;
	
								     elsif(data_is_digit='0') then  ---- if data is not digit
											if ( data_valid='1' and valid='0') then   ---if valid new is 1 and valid old is 0 then
												if(data_in="00000000000000000000000000000001") then  --- if open bracket
													nstate:=phi;  --- go to phi state
												else
													nstate:=errorstate;  --- else go to error state
												end if;
											end if;

										end if;
						when s3 =>
									enable_operand<='0';  --- make enable of operand low
										if (data_is_digit='0') then  -- if data is not digit
											if ( data_valid='1' and valid='0') then  -- if valid new is 1 and valid old is 0 then
												if (data_in="00000000000000000000000000000010") then  -- if closing bracket
													if clk='1' then 
														count:=count-1;  --- decrement count
													end if;
													enable_operand<='1';  ------ make enable operand high
													enable_operation<='1'; --- make enable operation high
													pushoperation<='0';   --pop the first operation 
													pushoperand<='0';	  -- pop the first operand
														nstate:=void1;  --- wait state
												else
													nstate:=errorstate;
												end if;
											end if;
										elsif(data_is_digit='1') then   -- if data is digit then
											if ( data_valid='1' and valid='0') then  -- if data valid =1 and datavalid old is 0 then
												nstate:=errorstate; --error state;
											end if;

										end if;
						when void1  => ---- stop all the pop
											number1:=data_out_operand;--- send the value to a variable
											operation:=data_out_operation;   --- send operation to variable
											enable_operation<='0';
											pushoperation<='0';
											pushoperand<='0';	
											nstate:=void2;
											
						when void2  => 
											number2:=data_out_operand;
											enable_operand<='0';
											pushoperation<='0';
											pushoperand<='0';	
											nstate:=compute;
											
												
						when compute =>
									
											if (operation="00000000000000000000000000000100") then	---- if 4 add
												temp1:=conv_integer(number1)+conv_integer(number2);
												data_out_sample:=conv_std_logic_vector(temp1,32);
												data_out<=data_out_sample;
												
												---pop
											elsif (operation="00000000000000000000000000000101") then    --- if 5 subtract
												if (number1<number2) then
												temp1:=conv_integer(number1)-conv_integer(number2);
												data_out_sample:=conv_std_logic_vector(temp1,32);
												data_out<=data_out_sample;
												elsif(number1>=number2) then    --- if number2>=number 1 do 2s complement 
												temp1:=conv_integer(number1)-conv_integer(number2);
												temp1:=(15+temp1)+1;
												data_out_sample:=conv_std_logic_vector(temp1,32);
												data_out<=data_out_sample;
												end if;
											elsif (operation="00000000000000000000000000000011") then   ---- if 3 multiply
												temp1:=conv_integer(number1)*conv_integer(number2);
												data_out_sample:=conv_std_logic_vector(temp1,32);
												data_out<=data_out_sample;
											elsif (operation="00000000000000000000000000000110")then   ---- if 5 divide
													temp1:=conv_integer(number1)/conv_integer(number2);
													data_out_sample:=conv_std_logic_vector(temp1,32);
													data_out<=data_out_sample;
										
											elsif  ((operation="00000000000000000000000000000110") and (number2="00000000000000000000000000000000"))then
													nstate:=errorstate;---divide by 0
											end if;
											
											
												nstate:=s9;
							
							when s9 =>  --- push computed data to stack
										if count/=0 then
												enable_operand<='1';
										end if;
												pushoperand<='1';
												data_inoperand<=data_out_sample;
											
												nstate:=s8;
												
					
									
							when s8 =>
											--- disable all push pop operations
											enable_operand<='0';
											pushoperand<='0';
											if count=0 then--if count equal 0 then go to final state to do no operation further
																nstate:=final;
											end if;
											-----do all operation here
											if (data_is_digit='0') then
													if ( data_valid='1' and valid='0') then
														
														if (data_in="00000000000000000000000000000010") then    --- else if bracket go to compute state
															
															if clk='1' then 
																count:=count-1;   --- decrement count
															end if;
															nstate:=compute;
														elsif((data_in>"00000000000000000000000000000010") and (data_in<="00000000000000000000000000000110")) then
															operation:=data_in;  ------operation
															data_inoperation<=operation;
															enable_operation<='1';
															pushoperation<='1';
															---push
															nstate:=s7;
														end if;
													end if;
											elsif(data_is_digit='1') then
													if ( data_valid='1' and valid='0') then
														nstate:=errorstate;
													end if;
											end if;
						
						when s7 => 
										enable_operation<='0';
										pushoperation<='0';
										if (data_is_digit='1') then
											if ( data_valid='1' and valid='0') then
												if(data_in<="11111111111111111111111111111111") then    --- if number
												number2:=data_in; -----number
												data_inoperand<=number2;
													enable_operand<='1'; ---- push the number
													pushoperand<='1';
												--push
													nstate:=s3;  --- go to S3
												else
													nstate:=errorstate;
												end if;
										  end if;
	
										elsif(data_is_digit='1') then
											if ( data_valid='1' and valid='0') then
												nstate:=errorstate;
											end if;
	
										end if;
						
					
						
						when errorstate  =>
														data_out<="11111111111111111111111111111111";
														error<='1';	
												
						when final =>
												
						end case;
						
		
			
			if(reset = '0') then
				state_sig <= phistart;
				data_out <= "00000000000000000000000000000000";
				count:=0;
				
			elsif (clk'event AND clk='1')then	
			valid:=data_valid;
				-- update state
			state_sig <= nstate;
				--data_out <=operand;
		--	end if;
		   end if;
		
	end process;
	end Behave;
	