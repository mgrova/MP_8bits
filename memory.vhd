library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-----------------------------------------------------------------
------------ MEMORY SYSTEM for 8-BIT COMPUTER -------------------
-----------------------------------------------------------------
entity memory is
port (
	-- Conections with cpu
        address: in std_logic_vector(7 downto 0);
        data_in: in std_logic_vector(7 downto 0);
        write_en: in std_logic;
        data_out: out std_logic_vector(7 downto 0);

        clock,reset: in std_logic;
	-- Inputs
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
      	port_in_15: in std_logic_vector(7 downto 0);
	-- Outputs
	port_out_00: out std_logic_vector(7 downto 0);
     	port_out_01: out std_logic_vector(7 downto 0);
      	port_out_02: out std_logic_vector(7 downto 0);
      	port_out_03: out std_logic_vector(7 downto 0);
      	port_out_04: out std_logic_vector(7 downto 0);
      	port_out_05: out std_logic_vector(7 downto 0);
      	port_out_06: out std_logic_vector(7 downto 0);
      	port_out_07: out std_logic_vector(7 downto 0);
      	port_out_08: out std_logic_vector(7 downto 0);
     	port_out_09: out std_logic_vector(7 downto 0);
      	port_out_10: out std_logic_vector(7 downto 0);
     	port_out_11: out std_logic_vector(7 downto 0);
      	port_out_12: out std_logic_vector(7 downto 0);
      	port_out_13: out std_logic_vector(7 downto 0);
      	port_out_14: out std_logic_vector(7 downto 0);
      	port_out_15: out std_logic_vector(7 downto 0)
      );
end memory;

architecture Behavioral of memory is
	-- Memory program (128 bytes)
	component rom_128x8_sync
	port (
		address: in std_logic_vector(7 downto 0);
		data_out: out std_logic_vector(7 downto 0);
		clock: in std_logic
	      );
	end component rom_128x8_sync;
	-- Data Memory (96 bytes)
	component rw_96x8_sync
	port(
		address: in std_logic_vector(7 downto 0);
		data_in: in std_logic_vector(7 downto 0);
		write_en: in std_logic;
		clock: in std_logic;
		data_out: out std_logic_vector(7 downto 0)
	);  
	 end component rw_96x8_sync;
	-- Outputs ports (16x8 bits)
	component Output_Ports
	port (
		address: in std_logic_vector(3 downto 0);
		data_in: in std_logic_vector(7 downto 0);
		write_en: in std_logic;
		clock: in std_logic;
		reset: in std_logic;
		port_out_00: out std_logic_vector(7 downto 0);
		port_out_01: out std_logic_vector(7 downto 0);
		port_out_02: out std_logic_vector(7 downto 0);
		port_out_03: out std_logic_vector(7 downto 0);
		port_out_04: out std_logic_vector(7 downto 0);
		port_out_05: out std_logic_vector(7 downto 0);
		port_out_06: out std_logic_vector(7 downto 0);
		port_out_07: out std_logic_vector(7 downto 0);
		port_out_08: out std_logic_vector(7 downto 0);
		port_out_09: out std_logic_vector(7 downto 0);
		port_out_10: out std_logic_vector(7 downto 0);
		port_out_11: out std_logic_vector(7 downto 0);
		port_out_12: out std_logic_vector(7 downto 0);
		port_out_13: out std_logic_vector(7 downto 0);
		port_out_14: out std_logic_vector(7 downto 0);
		port_out_15: out std_logic_vector(7 downto 0)
	      );
	end component Output_Ports;
	
		-- mux
	component mux_out
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
	end component mux_out;


	signal rom_out_s,ram_out_s:std_logic_vector(7 downto 0);
	signal output_port_addr: std_logic_vector(3 downto 0);
	signal ram_address,rom_address,mux_address: std_logic_vector(7 downto 0);
	begin
		mux_address <= address;
	
       ram_address <= address(7 downto 0) when (address(7)= '1') else  
                                "00000000";  
       rom_address <= address(7 downto 0) when (address(7)='0') else  
                                "00000000";  
       output_port_addr <= address(3 downto 0) when (address(7 downto 4)= x"E") else  
                                "0000"; 

	      rom_128x8_sync_u: rom_128x8_sync port map
		             (
		                  address  => rom_address,
		                  clock    => clock,
		                  data_out => rom_out_s
		             );

	      rw_96x8_sync_u: rw_96x8_sync port map
		             (
		                  address    => ram_address,
		                  data_in    => data_in,
		                  write_en      => write_en,
		                  clock      => clock,
		                  data_out   => ram_out_s
		             );

	      Output_Ports_u: output_Ports port map
		             (
		                  address     => output_port_addr,
		                  data_in     => data_in,
		                  write_en       => write_en,
		                  clock       => clock,
		                  reset       => reset,
		                  port_out_00 => port_out_00,
		                  port_out_01 => port_out_01,
		                  port_out_02 => port_out_02,
		                  port_out_03 => port_out_03,
		                  port_out_04 => port_out_04,
		                  port_out_05 => port_out_05,
		                  port_out_06 => port_out_06,
		                  port_out_07 => port_out_07,
		                  port_out_08 => port_out_08,
		                  port_out_09 => port_out_09,
		                  port_out_10 => port_out_10,
		                  port_out_11 => port_out_11,
		                  port_out_12 => port_out_12,
		                  port_out_13 => port_out_13,
		                  port_out_14 => port_out_14,
		                  port_out_15 => port_out_15
		             );

	      -- Multiplexer Output for manage input ports
			mux_out_u: mux_out port map
		          (
			data_out => data_out,
	      rom_out => rom_out_s,
			ram_out => ram_out_s,
			address => mux_address,
			port_in_00 => port_in_00,
			port_in_01 => port_in_01,
      	port_in_02 => port_in_02,
      	port_in_03 => port_in_03,
      	port_in_04 => port_in_04,
      	port_in_05 => port_in_05,
      	port_in_06 => port_in_06,
      	port_in_07 => port_in_07,
      	port_in_08 => port_in_08,
      	port_in_09 => port_in_09,
      	port_in_10 => port_in_10,
      	port_in_11 => port_in_11,
      	port_in_12 => port_in_12,
      	port_in_13 => port_in_13,
      	port_in_14 => port_in_14,
      	port_in_15 => port_in_15
					             );
			
 end Behavioral;
