--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:01:04 01/30/2019
-- Design Name:   
-- Module Name:   /home/marrcogrova/mc_8bits/computer_tb.vhd
-- Project Name:  mc_8bits
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: computer
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY computer_tb IS
END computer_tb;
 
ARCHITECTURE behavior OF computer_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT computer
    PORT(
         clock : IN  std_logic;
         reset : IN  std_logic;
         port_in_00 : IN  std_logic_vector(7 downto 0);
         port_in_01 : IN  std_logic_vector(7 downto 0);
         port_in_02 : IN  std_logic_vector(7 downto 0);
         port_in_03 : IN  std_logic_vector(7 downto 0);
         port_in_04 : IN  std_logic_vector(7 downto 0);
         port_in_05 : IN  std_logic_vector(7 downto 0);
         port_in_06 : IN  std_logic_vector(7 downto 0);
         port_in_07 : IN  std_logic_vector(7 downto 0);
         port_in_08 : IN  std_logic_vector(7 downto 0);
         port_in_09 : IN  std_logic_vector(7 downto 0);
         port_in_10 : IN  std_logic_vector(7 downto 0);
         port_in_11 : IN  std_logic_vector(7 downto 0);
         port_in_12 : IN  std_logic_vector(7 downto 0);
         port_in_13 : IN  std_logic_vector(7 downto 0);
         port_in_14 : IN  std_logic_vector(7 downto 0);
         port_in_15 : IN  std_logic_vector(7 downto 0);
         port_out_00 : OUT  std_logic_vector(7 downto 0);
         port_out_01 : OUT  std_logic_vector(7 downto 0);
         port_out_02 : OUT  std_logic_vector(7 downto 0);
         port_out_03 : OUT  std_logic_vector(7 downto 0);
         port_out_04 : OUT  std_logic_vector(7 downto 0);
         port_out_05 : OUT  std_logic_vector(7 downto 0);
         port_out_06 : OUT  std_logic_vector(7 downto 0);
         port_out_07 : OUT  std_logic_vector(7 downto 0);
         port_out_08 : OUT  std_logic_vector(7 downto 0);
         port_out_09 : OUT  std_logic_vector(7 downto 0);
         port_out_10 : OUT  std_logic_vector(7 downto 0);
         port_out_11 : OUT  std_logic_vector(7 downto 0);
         port_out_12 : OUT  std_logic_vector(7 downto 0);
         port_out_13 : OUT  std_logic_vector(7 downto 0);
         port_out_14 : OUT  std_logic_vector(7 downto 0);
         port_out_15 : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal reset : std_logic := '1';
   signal port_in_00 : std_logic_vector(7 downto 0) := (others => '0');
   signal port_in_01 : std_logic_vector(7 downto 0) := (others => '0');
   signal port_in_02 : std_logic_vector(7 downto 0) := (others => '0');
   signal port_in_03 : std_logic_vector(7 downto 0) := (others => '0');
   signal port_in_04 : std_logic_vector(7 downto 0) := (others => '0');
   signal port_in_05 : std_logic_vector(7 downto 0) := (others => '0');
   signal port_in_06 : std_logic_vector(7 downto 0) := (others => '0');
   signal port_in_07 : std_logic_vector(7 downto 0) := (others => '0');
   signal port_in_08 : std_logic_vector(7 downto 0) := (others => '0');
   signal port_in_09 : std_logic_vector(7 downto 0) := (others => '0');
   signal port_in_10 : std_logic_vector(7 downto 0) := (others => '0');
   signal port_in_11 : std_logic_vector(7 downto 0) := (others => '0');
   signal port_in_12 : std_logic_vector(7 downto 0) := (others => '0');
   signal port_in_13 : std_logic_vector(7 downto 0) := (others => '0');
   signal port_in_14 : std_logic_vector(7 downto 0) := (others => '0');
   signal port_in_15 : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal port_out_00 : std_logic_vector(7 downto 0);
   signal port_out_01 : std_logic_vector(7 downto 0);
   signal port_out_02 : std_logic_vector(7 downto 0);
   signal port_out_03 : std_logic_vector(7 downto 0);
   signal port_out_04 : std_logic_vector(7 downto 0);
   signal port_out_05 : std_logic_vector(7 downto 0);
   signal port_out_06 : std_logic_vector(7 downto 0);
   signal port_out_07 : std_logic_vector(7 downto 0);
   signal port_out_08 : std_logic_vector(7 downto 0);
   signal port_out_09 : std_logic_vector(7 downto 0);
   signal port_out_10 : std_logic_vector(7 downto 0);
   signal port_out_11 : std_logic_vector(7 downto 0);
   signal port_out_12 : std_logic_vector(7 downto 0);
   signal port_out_13 : std_logic_vector(7 downto 0);
   signal port_out_14 : std_logic_vector(7 downto 0);
   signal port_out_15 : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: computer PORT MAP (
          clock => clock,
          reset => reset,
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
          port_in_15 => port_in_15,
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

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
			reset<='0';
      wait for clock_period*10;
			reset<='1';
		wait for clock_period*50;
			reset<='0';
		wait for clock_period*50;
			reset<='1';

      -- insert stimulus here 

      wait;
   end process;

END;
