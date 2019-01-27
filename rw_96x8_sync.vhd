library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
--
-- This code model the local enable and signal assignments for the R/W memory
--
entity rw_96x8_sync is
port(
	address: in std_logic_vector(7 downto 0);
	data_in: in std_logic_vector(7 downto 0);
	write_en: in std_logic;
	clock: in std_logic;
	data_out: out std_logic_vector(7 downto 0)
);
end rw_96x8_sync;

architecture Behavioral of rw_96x8_sync is

type rw_type is array (128 to 223) of std_logic_vector(7 downto 0);

signal RW : rw_type;
signal EN: std_logic;

begin
	enable : process (address)
	begin
		if ( (to_integer(unsigned(address)) >= 128) and
		(to_integer(unsigned(address)) <= 223)) then
			EN <= '1';
		else
			EN <= '0';
		end if;
	end process;

	memory : process (clock,EN,write_en)
	begin
		if (rising_edge(clock)) then
		  if (EN='1' and write_en='1') then
			RW(to_integer(unsigned(address))) <= data_in;
		elsif (EN='1' and write_en='0') then
			data_out <= RW(to_integer(unsigned(address)));
		  end if;
	end if;
	end process;

end Behavioral;
