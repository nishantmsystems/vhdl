

entity PriorityEncoder1 is
	Port(x: IN bit_VECTOR(7 downto 0):="00000000";
		 s: OUT bit_VECTOR(2 downto 0):="000";
		 N: OUT bit);
end PriorityEncoder1;

Architecture Program of PriorityEncoder1 is
begin
	s<="000" when x(0)='1' else
	   "001" when x(1)='1' else
           "010" when x(2)='1' else
	   "011" when x(3)='1' else
	   "100" when x(4)='1' else
	   "101" when x(5)='1' else
	   "110" when x(6)='1' else
	   "111" when x(7)='1';
		
	N<='1' when x="00000000" else
		'0';
		
end Program;
