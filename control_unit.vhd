 -- Submodule VHDL code for the control unit of the microcontroller
library IEEE;  
use IEEE.STD_LOGIC_1164.ALL;  
-- control unit  
entity control_unit is  
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
        write_en: out std_logic  
      );  
end control_unit;  
architecture Behavioral of control_unit is 

type FSM is (S_FETCH_0,S_FETCH_1,S_FETCH_2,
	      S_DECODE_3,
	      S_LOAD_AND_STORE_4,S_LOAD_AND_STORE_5,S_LOAD_AND_STORE_6,S_LOAD_AND_STORE_7,
	      S_DATA_MAN_4,
	      S_BRANCH_4,S_BRANCH_5,S_BRANCH_6
 	    );  

-- Internal signals
signal current_state,next_state: FSM;  
signal LOAD_STORE_OP,DATA_MAN_OP,BRANCH_OP: std_logic;  

begin  
      -- Syncro process to update nest state of fsm
      process(clock,reset)  
      begin  
           if(reset='0') then  
                current_state <= S_FETCH_0;  
           elsif(rising_edge(clock)) then  
                current_state <= next_state;  
           end if;  
      end process;
	  
      -- FSM Implementation
      process(current_state,IR,CCR_Result,LOAD_STORE_OP,DATA_MAN_OP,BRANCH_OP)  
      begin
		 -- Avoid latches
		 next_state<=current_state;
		 -- Signals inicialization
		  IR_Load <= '0';  
        MAR_Load <= '0';  
        PC_Load <= '0';  
        PC_Inc <= '0';  
        A_Load <= '0';  
        B_Load <= '0';  
        ALU_Sel <= "000";  
        CCR_Load <= '0';  
        Bus2_Sel <= "00";  
        Bus1_Sel <= "00";  
        write_en <= '0';  
        case(current_state) is  
    
	   when S_FETCH_0 =>   
              Bus1_Sel <= "00"; -- PC  
              Bus2_Sel <= "01"; -- BUS1  
              MAR_Load <= '1';  
              next_state <= S_FETCH_1;  

           when S_FETCH_1 =>  
              PC_Inc <= '1';  
              next_state <= S_FETCH_2;  

           when S_FETCH_2 =>  
              Bus2_Sel <= "10";  
              IR_Load <= '1';  
              next_state <= S_DECODE_3;  

           when S_DECODE_3 =>  
              if(LOAD_STORE_OP='1') then  
                 next_state <= S_LOAD_AND_STORE_4;  
              elsif(DATA_MAN_OP='1') then  
                 next_state <= S_DATA_MAN_4;  
              elsif(BRANCH_OP='1') then  
                 next_state <= S_BRANCH_4;  
              end if;  

	   -- -- LOAD AND STORE INSTRUCTIONS:  
           when S_LOAD_AND_STORE_4 =>  
              if(IR >= x"86" and IR <= x"89")then -- LOAD IMMEDIATE  
                 Bus1_Sel <= "00";  
                 Bus2_Sel <= "01";  
                 MAR_Load <= '1';            
              elsif(IR = x"96" or IR = x"97")then -- LOAD IMMEDIATE  
                 Bus1_Sel <= "00";  
                 Bus2_Sel <= "01";  
                 MAR_Load <= '1';                                
              end if;  
              next_state <= S_LOAD_AND_STORE_5;  
           
	   when S_LOAD_AND_STORE_5 =>  
              if(IR >= x"86" and IR <= x"89")then -- LOAD IMMEDIATE  
                 PC_Inc <= '1';  
              elsif(IR = x"96" or IR = x"97")then  
                 PC_Inc <= '1';  
              end if;  
              next_state <= S_LOAD_AND_STORE_6;  
           
           when S_LOAD_AND_STORE_6 =>  
              if(IR=x"86")then -- LOAD IMMEDIATE A  
                 Bus2_Sel <= "10";  
                 A_Load <= '1';  
                 next_state <= S_FETCH_0;  
              elsif(IR=x"87" or IR=x"89") then -- LOAD A DIRECT  
                 Bus2_Sel <= "10";  
                 MAR_Load <= '1';            
                 next_state <= S_LOAD_AND_STORE_7;  
              elsif(IR=x"88")then -- LOAD IMMEDIATE B  
                 Bus2_Sel <= "10";  
                 B_Load <= '1';  
                 next_state <= S_FETCH_0;       
              elsif(IR = x"96" or IR = x"97")then  
                 Bus2_Sel <= "10";  
                 MAR_Load <= '1';            
                 next_state <= S_LOAD_AND_STORE_7;                           
              end if;  
       
	   when S_LOAD_AND_STORE_7 =>  
              if(IR=x"87") then  
                 Bus2_Sel <= "10";  
                 A_Load <= '1';            
                 next_state <= S_FETCH_0;  
              elsif(IR=x"89") then  
                 Bus2_Sel <= "10";  
                 B_Load <= '1';            
                 next_state <= S_FETCH_0;       
              elsif(IR=x"96") then  
                 write_en <= '1';  
                 Bus1_Sel <= "01";  
                 next_state <= S_FETCH_0;  
             elsif(IR=x"97") then  
                 write_en <= '1';  
                 Bus1_Sel <= "10";  
                 next_state <= S_FETCH_0;  
             end if;  
    
          -- -- DATA MANIPULATION INSTRUCTIONS:  
          when S_DATA_MAN_4 =>   
             CCR_Load <= '1';  
             if(IR=x"42") then  
                 ALU_Sel <= "000";  
                 Bus1_Sel <= "01";  
                 Bus2_Sel <= "00";  
                 A_Load <= '1';  
             elsif(IR=x"43") then  
                 ALU_Sel <= "001";  
                 Bus1_Sel <= "01";  
                 Bus2_Sel <= "00";  
                 A_Load <= '1';  
             elsif(IR=x"44") then  
                 ALU_Sel <= "010";  
                 Bus1_Sel <= "01";  
                 Bus2_Sel <= "00";  
                 A_Load <= '1';            
             elsif(IR=x"45") then  
                 ALU_Sel <= "011";  
                 Bus1_Sel <= "01";  
                 Bus2_Sel <= "00";  
                 A_Load <= '1';            
             elsif(IR=x"46") then  
                 ALU_Sel <= "100";  
                 Bus1_Sel <= "01";  
                 Bus2_Sel <= "00";  
                 A_Load <= '1';                      
            elsif(IR=x"47") then  
                 ALU_Sel <= "100";  
                 Bus1_Sel <= "10";  
                 Bus2_Sel <= "00";  
                 B_Load <= '1';                 
            elsif(IR=x"48") then  
                 ALU_Sel <= "101";  
                 Bus1_Sel <= "01";  
                 Bus2_Sel <= "00";  
                 A_Load <= '1';       
            elsif(IR=x"49") then  
                 ALU_Sel <= "101";  
                 Bus1_Sel <= "10";  
                 Bus2_Sel <= "00";  
                 B_Load <= '1';                                
            end if;  
            next_state <= S_FETCH_0;  

         when S_BRANCH_4 =>  
            if(IR >= x"20" and IR <= x"28")then -- BRA  
               Bus1_Sel <= "00";  
               Bus2_Sel <= "01";  
               MAR_Load <= '1';                                
            end if;  
            next_state <= S_BRANCH_5;  

         when S_BRANCH_5 =>  
            if(IR >= x"20" and IR <= x"28")then -- BRA  
               PC_Inc <= '1';  
            end if;  
            next_state <= S_BRANCH_6;  

         when S_BRANCH_6 =>  
            if(IR=x"20")then -- BRA  
               Bus2_Sel <= "10";  
               PC_Load <= '1';       
            elsif(IR=x"21")then -- BMI  
               Bus2_Sel <= "10";  
               if(CCR_Result(3)='1') then  
                  PC_Load <= '1';  
               end if;  
            elsif(IR=x"22")then -- BPL  
               Bus2_Sel <= "10";  
               if(CCR_Result(3)='0') then  
                  PC_Load <= '1';  
               end if;  
            elsif(IR=x"23")then -- BEQ  
               Bus2_Sel <= "10";  
               if(CCR_Result(2)='1') then-- Z = '1'?  
                  PC_Load <= '1';  
               end if;  
            elsif(IR=x"24")then -- BNE  
               Bus2_Sel <= "10";  
               if(CCR_Result(2)='0') then-- Z = '0'?  
                  PC_Load <= '1';  
               end if;  
            elsif(IR=x"25")then -- BVS  
               Bus2_Sel <= "10";  
               if(CCR_Result(1)='1') then-- V = '1'?  
                  PC_Load <= '1';  
               end if;  
            elsif(IR=x"26")then -- BVC  
               Bus2_Sel <= "10";  
               if(CCR_Result(1)='0') then-- V = '0'?  
                  PC_Load <= '1';  
               end if;  
            elsif(IR=x"27")then -- BCS  
               Bus2_Sel <= "10";  
               if(CCR_Result(0)='1') then-- C = '1'?  
                  PC_Load <= '1';  
               end if;  
            elsif(IR=x"28")then -- BCC  
               Bus2_Sel <= "10";  
               if(CCR_Result(0)='0') then-- C = '0'?  
                  PC_Load <= '1';  
               end if;  
            end if;  
            next_state <= S_FETCH_0;  

         when others =>  
            next_state <= S_FETCH_0;       
         end case;  
      end process;  
  
-- Option code to manage the next state to decode (S_DECODE_3)
   LOAD_STORE_OP <= '1' when IR = x"86" else  
                    '1' when IR = x"87" else  
                    '1' when IR = x"88" else  
                    '1' when IR = x"89" else  
                    '1' when IR = x"96" else  
                    '1' when IR = x"97" else            
    	            '0';  
   DATA_MAN_OP <= '1' when (IR >= x"42" and IR <=x"49") else       
                  '0';  
   BRANCH_OP  <=  '1' when (IR >= x"20" and IR <= x"28") else       
                  '0';  
 end Behavioral;  
