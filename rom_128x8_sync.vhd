library IEEE;  
use IEEE.STD_LOGIC_1164.ALL; 
--
-- The program  perform a load, store, and a branch always. 
-- This program will continually write x”AA” to port_out_00:
type rom_type is array (0 to 127) of std_logic_vector(7 downto 0);
constant ROM : rom_type := (0=> LDA_IMM,
			    1=> x"AA",
			    2=> STA_DIR,
			    3=> x"E0",
			    4=> BRA,
			    5=> x"00",
			    others => x"00");

-- The second step is to create an internal enable line that will only allow assignments from
-- ROM to data_out when a valid address is entered. create an internal enable (EN) that will 
--only be asserted when the address falls within the valid program memory range of 0–127:
enable : process (address)
begin
	if ((to_integer(unsigned(address)) >= 0) and
	(to_integer(unsigned(address)) <1= 127)) then
		EN <= ’1’;
	else
		EN <= ’0’;
	end if;
end process;


-- This enable line can now be used in the behavioral model for 
-- the ROM process as follows:
memory : process (clock)
begin
	-- COMILLAS POSIBLE FOCO DE FALLO
	if (clock’event and clock=’1’) then
		if (EN=’1’) then
			data_out <= ROM(to_integer(unsigned(address)));	
		end if;
	end if;
end process;

