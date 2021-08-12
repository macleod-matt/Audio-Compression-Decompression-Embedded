#include "read_wav.h"
#include "mulawAPI.h"
#include <stdint.h> 
#include <stdbool.h> 
#include <stdio.h>
#include <string.h>
#include <time.h>
//Convers decimal to bin

// function to convert decimal to binary
void decToBinary(int n)
{
    // array to store binary number
    int binaryNum[32];
 
    // counter for binary array
    int i = 0;
    while (n > 0) {
 
        // storing remainder in binary array
        binaryNum[i] = n % 2;
        n = n / 2;
        i++;
    }
    int j;  
    // printing binary array in reverse order
    for (j = i - 1; j >= 0; j--)
        printf("%d", binaryNum[j]);
}

int codeword_compression(register int sample_magnitude, register int sign)
{
    /*
    Code for hardware implementation - If uncommented the code will not compline.

    bool Op = 1;    //1 for Compression 0 for Decompression

    __asm__ ("AC   %0, %1, %2":"=r"(Op):"r"(sample_magnitude),"r"(sign));
    */

    return 0;
}

int codeword_decompression(int register codeWord)
{
    //Return statment at the end

    if(DEBUG)
    {
        int sign = ((codeWord << 6) & 0x2000 );
        sign = !sign;

        int sign_Most_Sig_Bit = ((sign << 13) & 0x2000);        //shift sign to correct position and mask
        int step = (codeWord & 0x0F);   //Step
        int chord = ((codeWord >> 4) & 0x07);  //chord
        int step_shifted_by_chord = step << (chord+1);
        int add_ones_on_either_side = (0x21 << chord);        // add the 1 A B C D 1 33 dec, 100001 bin, 21 hex
        int megnatude = add_ones_on_either_side | step_shifted_by_chord;
        int finalVal = sign_Most_Sig_Bit | megnatude;
        int OptimisedWord = (((!((codeWord << 6) & 0x2000 )) << 13) & 0x2000) | ((0x21 << ((codeWord >> 4) & 0x07)) | ((codeWord & 0x0F) << (((codeWord >> 4) & 0x07) + 1)));

        debug_print("\n<============== Checking Decompression operation ==============>");

        debug_print("\n Sign before flip: %d | ", !sign);
        decToBinary(!sign);

        debug_print("\n Sign after flip: %d | ", sign);
        decToBinary(sign);

        //int sign_Most_Sig_Bit = ((sign << 13) & 0x2000);        //shift sign to correct position and mask

        debug_print("\n Sign in 14th place: %d | ", sign_Most_Sig_Bit);
        decToBinary(sign_Most_Sig_Bit);

        //int step = (codeWord & 0x0F);   //Step

        debug_print("\n Step: %d | ", step);
        decToBinary(step);

       // int chord = ((codeWord >> 4) & 0x07);  //chord
        debug_print("\n Chord: %d | ", chord);
        decToBinary(chord);

        //int step_shifted_by_chord = step << (chord+1);
        debug_print("\n step_shifted_by_chord: %d | ", step_shifted_by_chord);
        decToBinary(step_shifted_by_chord);

        //int add_ones_on_either_side = (0x21 << chord);        // add the 1 A B C D 1 33 dec, 100001 bin, 21 hex
        debug_print("\n add_ones_on_either_side: %d | ", add_ones_on_either_side);
        decToBinary(add_ones_on_either_side);

        //int megnatude = add_ones_on_either_side | step_shifted_by_chord;
        debug_print("\n megnatude: %d | ", megnatude);
        decToBinary(megnatude);

        //int finalVal = sign_Most_Sig_Bit | megnatude;
        debug_print("\n Decompressed Word: %d | ", finalVal);
        decToBinary(finalVal);

        //(((!((codeWord << 6) & 0x2000 )) << 13) & 0x2000) | ((0x21 << ((codeWord >> 4) & 0x07)) | ((codeWord & 0x0F) << (((codeWord >> 4) & 0x07) + 1)));
        debug_print("\n Decompressed Word Optimised Result: %d | ", OptimisedWord);
        decToBinary(OptimisedWord);
    }



    return ((((!((codeWord << 6) & 0x2000 )) << 13) & 0x2000) | ((0x21 << ((codeWord >> 4) & 0x07)) | ((codeWord & 0x0F) << (((codeWord >> 4) & 0x07) + 1))));
} 



int Test(int sample)
{
    printf("\nTurn debugging to 1 in mulawAPI.h for debugging mode\n\n");

    int Compressed_Word = codeword_compression(magnitude(sample), signum(sample));
    int Decompressed_Word = codeword_decompression(Compressed_Word);

    printf("\n<Testing..");
    printf("\nInput: %d | ", sample);
    decToBinary(sample);
    printf("\nCompressed: %d | ", Compressed_Word);
    decToBinary(Compressed_Word);
    printf("\nDecompressed: %d | ", Decompressed_Word);
    decToBinary(Decompressed_Word);

    return 0;
}
