library IEEE;  
use IEEE.STD_LOGIC_1164.ALL; 
--
-- This code model the local enable and signal assignments for the R/W memory
--
type rw_type is array (128 to 223) of std_logic_vector(7 downto 0);
signal RW : rw_type;

enable : process (address)
begin
	if ( (to_integer(unsigned(address)) >= 128) and
	(to_integer(unsigned(address)) <= 223)) then
		EN <= ’1’;
	else
		EN <= ’0’;
	end if;
end process;

memory : process (clock)
begin
	if (clock’event and clock=’1’) then
	  if (EN=’1’ and write=’1’) then
		RW(to_integer(unsigned(address))) <= data_in;
	  elsif (EN=’1’ and write=’0’) then
		data_out <= RW(to_integer(unsigned(address)));
	  end if;
end if;
end process;

