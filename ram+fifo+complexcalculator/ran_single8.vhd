 library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--- operation stack
entity ran_single8 is
port(   clk : in std_logic;  --Clock for the stack.
        enable : in std_logic;  --enable the stack. Otherwise neither push nor pop will happen.
        data_in : in std_logic_vector(31 downto 0);  --Data to be pushed to stack
        data_out : out std_logic_vector(31 downto 0);  --Data popped from the stack.
        push : in std_logic;  --active low for POP and active high for PUSH.
        is_full : out std_logic;  --Goes high when the stack is full.
        is_empty : out std_logic  --Goes high when the stack is empty.
        );
end ran_single8;

architecture Behavioral of ran_single8 is

type mem_type is array (7 downto 0) of std_logic_vector(31 downto 0);-- definition for memory is given.
signal stack_mem : mem_type := (others => (others => '0')); --- now the stack array is initialized to all element being zero.
signal stack_ptr : integer := 7;--- the stack pointer is initialized to 7 which means the depth of the stack is 7 which can be increased as per ones wish
signal s_full,s_empty : std_logic := '0';-- the stack full and empty is initialized to zero

begin

is_full <= s_full;  --- first of all the full and empty are assigned to each other to prevent latching
is_empty <= s_empty;
---- This is a downward growing stack
--PUSH and POP process for the stack starts here.
 process(Clk,enable)
begin
    if(rising_edge(Clk)) then  --- rising edge trigger circuit
      -----This is push operation
        if (enable = '1' and push = '1' and s_full = '0') then  ---- if enable&push=1 and stack is not full then
             --data is pushed to the addrs
            stack_mem(stack_ptr) <= data_in;---- the input data is entered into the stack mem where the pointer points.
            if(stack_ptr /= 0) then ----- if stack pointer is not equal to zero then 
                stack_ptr <= stack_ptr - 1;  --- go on decrementing the pointer as it is a downward growing pointer.
            end if;
            --checking and setting full and empty stack
            if(stack_ptr = 0) then --- if stalk pointer is 0 then we say tht the stack is full else empty
                s_full <= '1';
                s_empty <= '0';
            elsif(stack_ptr = 7) then
                s_full <= '0';
                s_empty <= '1';
            else
                s_full <= '0';
                s_empty <= '0';
            end if;
        --POP 
        elsif (enable = '1' and push = '0') then --if enable is equal to 1 and push is 0 then start popping
       --- since it is a downward growing stack for popping we would add the pointer to fetch the elements from stack
            if(stack_ptr /= 7) then  --- if pointer is not equal to 7 then
                data_out <= stack_mem(stack_ptr+1); --- increment stack pointer by 1 and fetch the data and send it to data out
                stack_ptr <= stack_ptr + 1;  --- increment the pointer to next location
            end if;
            
            if(stack_ptr = 0) then
                s_full <= '1';
                s_empty <= '0';
            elsif(stack_ptr = 7) then
                s_full <= '0';
                s_empty <= '1';
            else
                s_full <= '0';
                s_empty <= '0';
            end if;
           
      
       
    end if;
	 end if;
end process;

end Behavioral;