#include "read_wav.h"
#include "mulawAPI.h"
#include <stdint.h> 
#include <stdbool.h> 
#include <stdio.h>
#include <string.h>
#include <time.h>
//Convers decimal to bin
void decToBinary(int n)
{
    // array to store binary number
    int binaryVal[32];
 
    // counter for binary array
    int i = 0;
    while (n > 0) {
 
        // storing remainder in binary array
        binaryVal[i] = n % 2;
        n = n / 2;
        i++;
    }
 
    // printing binary array in reverse order
    for (int j = i - 1; j >= 0; j--)
        printf("%d", binaryVal[j]);
}

int signum(int sample)
{
    if (sample < 0)
    {
        debug_print("\nNegative\n");
        return (0); /* sign is ’0’ for negative samples */
    }
    else
    {
        debug_print("\nPositive\n");
        return (1); /* sign is ’1’ for positive samples */
    }
}

int magnitude(int sample)
{   
    if (sample < 0)
    {
        sample = -sample;
    }
    debug_print("Magnatude: %d", sample);
    return (sample);
}

int codeword_compression(unsigned int sample_magnitude, unsigned int sign)
{
    int register chord, step;
    int register codeword_tmp;

    sign = !(sign || sign);

    if((DEBUG) && (sample_magnitude > 16383))
    {
        printf("\n!!!!! INPUT IS TOO LARGE !!!!!\n");
    }

    int register Number_Of_Bits = 0;

    while(sample_magnitude)
    {   
        Number_Of_Bits++;
        sample_magnitude = sample_magnitude >> 1;
    }
    debug_print("\Number Of Bits: %d Sample: %d\n\n", Number_Of_Bits, sample_magnitude);

    switch (Number_Of_Bits)
    {
    case (14):
        chord = 0x7;
        step = (sample_magnitude >> 8) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("chord: %d, step: %d, codeword_tmp: %d | ", chord, step, codeword_tmp);

        return (codeword_tmp);
        break;
    case (13):
        chord = 0x6;
        step = (sample_magnitude >> 7) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("chord: %d, step: %d, codeword_tmp: %d | ", chord, step, codeword_tmp);

        return (codeword_tmp);
        break;
    case (11):
        chord = 0x5;
        step = (sample_magnitude >> 6) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("chord: %d, step: %d, codeword_tmp: %d | ", chord, step, codeword_tmp);

        return (codeword_tmp);
        break;
    case (10):
        chord = 0x4;
        step = (sample_magnitude >> 5) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("\nchord: %d, step: %d, codeword_tmp: %d |", chord, step, codeword_tmp);

        return (codeword_tmp);
        break;
    case (9):
        chord = 0x3;
        step = (sample_magnitude >> 4) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("\nchord: %d, step: %d, codeword_tmp: %d |", chord, step, codeword_tmp);

        return (codeword_tmp);
        break;
    case (8):
        chord = 0x2;
        step = (sample_magnitude >> 3) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("chord: %d, step: %d, codeword_tmp: %d | ", chord, step, codeword_tmp);

        return (codeword_tmp);
        break;
    case (7):
        chord = 0x1;
        step = (sample_magnitude >> 2) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("chord: %d, step: %d, codeword_tmp: %d | ", chord, step, codeword_tmp);

        return (codeword_tmp);
        break;
    case (6):
        chord = 0x0;
        step = (sample_magnitude >> 1) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("chord: %d, step: %d, codeword_tmp: %d | ", chord, step, codeword_tmp);

        return (codeword_tmp);
        break;

    default:
        debug_print("\n\nNo case was found!\n\n");
        break;
    }
    return 0;   //Error
}

int codeword_decompression(int codeWord)
{
    debug_print("\n<============== Checking Decompression operation ==============>");

    if(DEBUG)
    {
        int Pos_Neg_Shift = (codeWord << 6);    //get sign
        int Pos_Neg_Mask = !(Pos_Neg_Shift & 8192) || (Pos_Neg_Shift & 8192);   //Flip sign back
        int shift_val = ((codeWord >> 4) & 7);  //Get Chord
        int Word_Mask = (codeWord & 0xF);   //Get Step
        int Word_Shift =  ((codeWord & 0xF) << ((codeWord >> 4) & 7));  //Get shifted Step
        int FinalDecompressedWord = (((codeWord << 6) & 0x2000 ) ^ 0x2000 ^ ((codeWord & 0xF) << ((codeWord >> 4) & 0x7))) | (33 << (((codeWord >> 4) & 0x7)-1));


       debug_print("\n Shift to 14 bit: %d | ", Pos_Neg_Shift);
        decToBinary(Pos_Neg_Shift);
        debug_print("\n Sign: %d | ", Pos_Neg_Mask);
        decToBinary(Pos_Neg_Mask);
        debug_print("\n Step: %d | ", Word_Mask);
        decToBinary(Word_Mask);
        debug_print("\n Chord: %d | ", shift_val);
        decToBinary(shift_val);
        debug_print("\n Step_Decompressed: %d | ", Word_Shift);
        decToBinary(Word_Shift);
        debug_print("\n Word_Decompressed: %d | ", FinalDecompressedWord);
        decToBinary(FinalDecompressedWord);
    }

   return (((codeWord << 6) & 0x2000 ) ^ 0x2000 ^ ((codeWord & 0xF) << ((codeWord >> 4) & 0x7))) | (33 << (((codeWord >> 4) & 0x7)-1));   //Decompressed Word
}

int Test(int sample)
{
    int Compressed_Word = codeword_compression(magnitude(sample), signum(sample));
    int Decompressed_Word = codeword_decompression(Compressed_Word);

    printf("\n<========================= TESTING ============================>");
    printf("\nInput: %d | ", sample);
    convertToBinary(sample);
    printf("\nCompressed: %d | ", Compressed_Word);
    convertToBinary(Compressed_Word);
    printf("\nDecompressed: %d | ", Decompressed_Word);
    convertToBinary(Decompressed_Word);

    return 0;
}

