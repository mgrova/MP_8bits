-- MULTIPLEXER FOR DATA OUT OF MEMORY
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity mux_out is
	port (
		data_out: out std_logic_vector(7 downto 0);
 	   rom_out: in std_logic_vector(7 downto 0);
		ram_out: in std_logic_vector(7 downto 0);
		address: in std_logic_vector(7 downto 0);
		port_in_00: in std_logic_vector(7 downto 0);
		port_in_01: in std_logic_vector(7 downto 0);
		port_in_02: in std_logic_vector(7 downto 0);
      port_in_03: in std_logic_vector(7 downto 0);
      port_in_04: in std_logic_vector(7 downto 0);
      port_in_05: in std_logic_vector(7 downto 0);
      port_in_06: in std_logic_vector(7 downto 0);
      port_in_07: in std_logic_vector(7 downto 0);
      port_in_08: in std_logic_vector(7 downto 0);
      port_in_09: in std_logic_vector(7 downto 0);
      port_in_10: in std_logic_vector(7 downto 0);
      port_in_11: in std_logic_vector(7 downto 0);
      port_in_12: in std_logic_vector(7 downto 0);
      port_in_13: in std_logic_vector(7 downto 0);
      port_in_14: in std_logic_vector(7 downto 0);
      port_in_15: in std_logic_vector(7 downto 0)
	 );
end mux_out;

architecture Behavioral of mux_out is

begin

MUX1 : process (address, rom_out, ram_out,
					port_in_00, port_in_01, port_in_02, port_in_03,
					port_in_04, port_in_05, port_in_06, port_in_07,
					port_in_08, port_in_09, port_in_10, port_in_11,
					port_in_12, port_in_13, port_in_14, port_in_15)
begin
	if ( (to_integer(unsigned(address)) >= 0) and (to_integer(unsigned(address)) <= 127)) then
		data_out <= rom_out;
	elsif ( (to_integer(unsigned(address)) >= 128) and (to_integer(unsigned(address)) <= 223)) then
		data_out <= ram_out;
	elsif (address = x"F0") then data_out <= port_in_00;
	elsif (address = x"F1") then data_out <= port_in_01;
	elsif (address = x"F2") then data_out <= port_in_02;
	elsif (address = x"F3") then data_out <= port_in_03;
	elsif (address = x"F4") then data_out <= port_in_04;
	elsif (address = x"F5") then data_out <= port_in_05;
	elsif (address = x"F6") then data_out <= port_in_06;
	elsif (address = x"F7") then data_out <= port_in_07;
	elsif (address = x"F8") then data_out <= port_in_08;
	elsif (address = x"F9") then data_out <= port_in_09;
	elsif (address = x"FA") then data_out <= port_in_10;
	elsif (address = x"FB") then data_out <= port_in_11;
	elsif (address = x"FC") then data_out <= port_in_12;
	elsif (address = x"FD") then data_out <= port_in_13;
	elsif (address = x"FE") then data_out <= port_in_14;
	elsif (address = x"FF") then data_out <= port_in_15;
	else data_out <= x"00";
	end if;
end process;

--	      data_out <= rom_out when address < x"80" else
--		          ram_out when address < x"E0" else
--		       port_in_00 when address = x"F0" else
--		       port_in_01 when address = x"F1" else
--		       port_in_02 when address = x"F2" else
--		       port_in_03 when address = x"F3" else
--		       port_in_04 when address = x"F4" else
--		       port_in_05 when address = x"F5" else
--		       port_in_06 when address = x"F6" else
--		       port_in_07 when address = x"F7" else
--		       port_in_08 when address = x"F8" else
--		       port_in_09 when address = x"F9" else
--		       port_in_10 when address = x"FA" else
--		       port_in_11 when address = x"FB" else
--		       port_in_12 when address = x"FC" else
--		       port_in_13 when address = x"FD" else
--		       port_in_14 when address = x"FE" else
--		       port_in_15 when address = x"FF" else
--		                  x"00";
end Behavioral;

