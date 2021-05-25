--SENG 440
--May 24 2021
--REV 2.0

--Audio Compression using Mu Law
--Input 14 bits.  First bit is a 0 and the following are data.
--The most significat four bits following the leading 1 are kept as 'step' and the remainbits are truncated.
--The size of the input value is stored as the data's 'chord'.  this value is later used to decompress the data.  
--The compressed bits consist of a leading 1 or 0 for sign (1 for positive) followed by three bits for the 'chord' followed by the step.

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity SourceF is
Port ( 
INPUT: IN std_logic_vector(13 downto 0);
OUTPUT: OUT std_logic_vector(7 downto 0)
);
end SourceF;

architecture Behavioral of SourceF is
signal input_local: signed(13 downto 0);
signal output_local : signed(6 downto 0);
signal chord : signed(2 downto 0);
signal step : signed(3 downto 0);

begin
    process(INPUT) is
    begin
    
    input_local <= signed(INPUT);
     
        --Determine the signals chord and step
        if(input_local > 800) then 
            chord <= "111";
            step <= resize((shift_right(signed(input_local), 8)), step ' length );
            output_local <= resize("1100000" OR (shift_right(signed(input_local), 8)), output_local ' length );
        elsif (input_local > 400) then 
           chord <= "110";
            step <= resize((shift_right(signed(input_local), 7)), step ' length );
            output_local <= resize("1100000" OR (shift_right(signed(input_local), 7)), output_local ' length );
        elsif(input_local > 200) then 
            chord <= "101";
            step <= resize((shift_right(signed(input_local), 6)), step ' length );
            output_local <= resize("1010000" OR (shift_right(signed(input_local), 7)), output_local ' length );            
        elsif(input_local > 100)  then 
            chord <= "100";
            step <= resize((shift_right(signed(input_local), 5)), step ' length );
            output_local <= resize("1000000" OR (shift_right(signed(input_local), 7)), output_local ' length );
        elsif(input_local > 80) then 
            chord <= "011";
            step <= resize((shift_right(signed(input_local), 4)), step ' length );
            output_local <= resize("0110000" OR (shift_right(signed(input_local), 7)), output_local ' length );
        elsif(input_local > 40) then 
            chord <= "010";
            step <= resize((shift_right(signed(input_local), 3)), step ' length );
            output_local <= resize("0100000" OR (shift_right(signed(input_local), 7)), output_local ' length );
        elsif(input_local > 20) then 
            chord <= "001";
            step <= resize((shift_right(signed(input_local), 2)), step ' length );
            output_local <= resize("0010000" OR (shift_right(signed(input_local), 7)), output_local ' length );
        elsif(input_local > 10) then 
            chord <= "000";
            step <= resize((shift_right(signed(input_local), 1)), step ' length );
            output_local <= resize(shift_right(signed(input_local), 7), output_local ' length );
        end if;
    
    end process;

end Behavioral;
