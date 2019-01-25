library IEEE;  
use IEEE.STD_LOGIC_1164.ALL;  

-- CPU in VHDL  
entity cpu is  
port(  
	clock, reset: in std_logic;  
        address: out std_logic_vector(7 downto 0);  
        from_memory: in std_logic_vector(7 downto 0);  
        write: out std_logic;  
        to_memory: out std_logic_vector(7 downto 0)  
      );  
end cpu;  

architecture Behavioral of cpu is

component control_unit   
port (  
	clock,reset: in std_logic;  
        IR_Load: out std_logic;  
        IR: in std_logic_vector(7 downto 0);  
        MAR_Load: out std_logic;  
        PC_Load: out std_logic;  
        PC_Inc: out std_logic;  
        A_Load: out std_logic;  
        B_Load:out std_logic;  
        ALU_Sel:out std_logic_vector(2 downto 0);  
        CCR_Result: in std_logic_vector(3 downto 0);  
        CCR_Load: out std_logic;  
        Bus2_Sel: out std_logic_vector(1 downto 0);  
        Bus1_Sel: out std_logic_vector(1 downto 0);  
        write: out std_logic  
      );  
end component control_unit;  

component data_path   
port (            
	clock,reset: in std_logic;  
        IR_Load: in std_logic;  
        IR: out std_logic_vector(7 downto 0);  
        MAR_Load: in std_logic;  
        address: out std_logic_vector(7 downto 0);  
        PC_Load: in std_logic;  
        PC_Inc: in std_logic;  
        A_Load: in std_logic;  
        B_Load: in std_logic;  
        ALU_Sel: in std_logic_vector(2 downto 0);  
        CCR_Result: out std_logic_vector(3 downto 0);  
        CCR_Load: in std_logic;  
        Bus2_Sel: in std_logic_vector(1 downto 0);  
        Bus1_Sel: in std_logic_vector(1 downto 0);  
        from_memory: in std_logic_vector(7 downto 0);  
        to_memory: out std_logic_vector(7 downto 0)  
      );  
end component data_path; 

-- SIGNAL DECLARATIONS
signal IR_Load: std_logic;  
signal IR: std_logic_vector(7 downto 0);  
signal MAR_Load: std_logic;  
signal PC_Load: std_logic;  
signal PC_Inc: std_logic;  
signal A_Load: std_logic;  
signal B_Load: std_logic;  
signal ALU_Sel: std_logic_vector(2 downto 0);  
signal CCR_Result: std_logic_vector(3 downto 0);  
signal CCR_Load: std_logic;  
signal Bus2_Sel: std_logic_vector(1 downto 0);  
signal Bus1_Sel: std_logic_vector(1 downto 0);  

begin  
-- Instanciation  
-- control_unit  
control_unit_module: control_unit port map  
(  
	clock => clock,  
        reset => reset,  
        IR_Load => IR_Load,  
        IR => IR,  
        MAR_Load => MAR_Load,  
        PC_Load => PC_Load,  
        PC_Inc => PC_Inc,  
        A_Load => A_Load,  
        B_Load => B_Load,  
        ALU_Sel => ALU_Sel,  
        CCR_Result => CCR_Result,  
        CCR_Load => CCR_Load,  
        Bus2_Sel => Bus2_Sel,  
        Bus1_Sel => Bus1_Sel,  
        write => write  
      );  

-- data_path  
data_path_u: data_path port map   
(  
	clock => clock,  
        reset => reset,  
        IR_Load => IR_Load,   
        IR => IR,  
        MAR_Load => MAR_Load,  
        address => address,  
        PC_Load => PC_Load,  
        PC_Inc => PC_Inc,  
        A_Load => A_Load,  
        B_Load => B_Load,  
        ALU_Sel => ALU_Sel,  
        CCR_Result => CCR_Result,  
        CCR_Load => CCR_Load,  
        Bus2_Sel => Bus2_Sel,  
        Bus1_Sel => Bus1_Sel,  
        from_memory => from_memory,  
        to_memory => to_memory  
      );  
end Behavioral;
