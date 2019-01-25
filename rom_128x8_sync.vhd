library IEEE;  
use IEEE.STD_LOGIC_1164.ALL; 

entity rom_128x8_sync is 
port( 
	address: in std_logic_vector(6 downto 0);  
	data_out: out std_logic_vector(7 downto 0);  
	clock: in std_logic  
      );  	

architecture Behavioral of rom_128x8_sync is

--  ----- INSTRUCTION SET -----
-- These instructions are sufficient to provide a baseline of functionality.
-- Additional instructions can be added as desired to increase the complexity of the system.
constant LDA_IMM: std_logic_vector (7 downto 0) := x"86";
constant LDA_DIR: std_logic_vector (7 downto 0) := x"87";
constant LDB_IMM: std_logic_vector (7 downto 0) := x"88";
constant LDB_DIR: std_logic_vector (7 downto 0) := x"89";
constant STA_DIR: std_logic_vector (7 downto 0) := x"96";
constant STB_DIR: std_logic_vector (7 downto 0) := x"97";
constant ADD_AB : std_logic_vector (7 downto 0) := x"42";
constant SUB_AB : std_logic_vector (7 downto 0) := x"43";
constant AND_AB : std_logic_vector (7 downto 0) := x"44";
constant OR_AB  : std_logic_vector (7 downto 0) := x"45";
constant INCA   : std_logic_vector (7 downto 0) := x"46";
constant INCB   : std_logic_vector (7 downto 0) := x"47";
constant DECA   : std_logic_vector (7 downto 0) := x"48";
constant DECB   : std_logic_vector (7 downto 0) := x"49";
constant BRA    : std_logic_vector (7 downto 0) := x"20";
constant BMI    : std_logic_vector (7 downto 0) := x"21";
constant BPL    : std_logic_vector (7 downto 0) := x"22";
constant BEQ    : std_logic_vector (7 downto 0) := x"23";
constant BNE    : std_logic_vector (7 downto 0) := x"24";
constant BVS    : std_logic_vector (7 downto 0) := x"25";
constant BVC    : std_logic_vector (7 downto 0) := x"26";
constant BCS    : std_logic_vector (7 downto 0) := x"27";
constant BCC    : std_logic_vector (7 downto 0) := x"28";

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


-- FALTA DECLARAR LAS SEÑALES INTERNAS !!

begin
-- The second step is to create an internal enable line that will only allow assignments from
-- ROM to data_out when a valid address is entered. create an internal enable (EN) that will 
-- only be asserted when the address falls within the valid program memory range of 0–127:
ENABLE: process (address)
begin
	if ((to_integer(unsigned(address)) >= 0) and
	(to_integer(unsigned(address)) <= 127)) then
		EN <= ’1’;
	else
		EN <= ’0’;
	end if;
end process;


-- This enable line can now be used in the behavioral model for 
-- the ROM process as follows:
MEMORY: process (clock)
begin
	if (rising_edge(clock)) then
		if (EN=’1’) then
			data_out <= ROM(to_integer(unsigned(address)));	
		end if;
	end if;
end process;

end Behavioral;
