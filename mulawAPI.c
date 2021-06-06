
#include "read_wav.h"
#include "mulawAPI.h"
#include <stdint.h> 
#include <stdbool.h> 
#include <stdio.h>
#include <string.h>
#include <time.h>
//Convers decimal to bin
void convertToBinary(unsigned int n)
{
    if (n / 2 != 0) {
        convertToBinary(n / 2);
    }
    printf("%d", n % 2);
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

int codeword_compression(unsigned int sample_magnitude, int sign)
{
    int chord, step;
    int codeword_tmp;

    debug_print("\n<============== Checking Compression operation ==============>");

    debug_print("\nSample Megnatude: %d | ", sample_magnitude);
    if(DEBUG) convertToBinary(sample_magnitude);
    debug_print("\nSample Sign: %d | ", sign);
    if(DEBUG) convertToBinary(sign);
    debug_print("\n");

    if (sample_magnitude & (1 << 12))
    {
        chord = 0x7;
        step = (sample_magnitude >> 8) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("chord: %d, step: %d, codeword_tmp: %d | ", chord, step, codeword_tmp);
        convertToBinary(codeword_tmp);
        return (codeword_tmp);
    }
    if (sample_magnitude & (1 << 11))
    {
        chord = 0x6;
        step = (sample_magnitude >> 7) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("chord: %d, step: %d, codeword_tmp: %d | ", chord, step, codeword_tmp);
        convertToBinary(codeword_tmp);
        return (codeword_tmp);
    }
    if (sample_magnitude & (1 << 10))
    {
        chord = 0x5;
        step = (sample_magnitude >> 6) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("chord: %d, step: %d, codeword_tmp: %d | ", chord, step, codeword_tmp);
        convertToBinary(codeword_tmp);
        return (codeword_tmp);
    }
    if (sample_magnitude & (1 << 9))
    {
        chord = 0x4;
        step = (sample_magnitude >> 5) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("\nchord: %d, step: %d, codeword_tmp: %d |", chord, step, codeword_tmp);
        convertToBinary(codeword_tmp);
        return ((int)codeword_tmp);
    }
    if (sample_magnitude & (1 << 8))
    {
        chord = 0x3;
        step = (sample_magnitude >> 4) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("\nchord: %d, step: %d, codeword_tmp: %d |", chord, step, codeword_tmp);
        convertToBinary(codeword_tmp);
        return (codeword_tmp);
    }
    if (sample_magnitude & (1 << 7))
    {
        chord = 0x2;
        step = (sample_magnitude >> 3) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("chord: %d, step: %d, codeword_tmp: %d | ", chord, step, codeword_tmp);
        convertToBinary(codeword_tmp);
        return (codeword_tmp);
    }
    if (sample_magnitude & (1 << 6))
    {
        chord = 0x1;
        step = (sample_magnitude >> 2) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("chord: %d, step: %d, codeword_tmp: %d | ", chord, step, codeword_tmp);
        convertToBinary(codeword_tmp);
        return (codeword_tmp);
    }
    if (sample_magnitude & (1 << 5))
    {
        chord = 0x0;
        step = (sample_magnitude >> 1) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("chord: %d, step: %d, codeword_tmp: %d | ", chord, step, codeword_tmp);
        convertToBinary(codeword_tmp);
        return (codeword_tmp);
    }
}

int codeword_decompression(int codeWord)
{
    debug_print("\n<============== Checking Decompression operation ==============>");

    if(DEBUG)
    {
        int Pos_Neg_Shift = (codeWord << 6);
        int Pos_Neg_Mask = Pos_Neg_Shift & 8192;        //good
        int shift_val = ((codeWord >> 4) & 7);
        int Word_Mask = (codeWord & 0xF);
        int Word_Shift =  ((codeWord & 0xF) << ((codeWord >> 4) & 7));
        int word1 = (codeWord << 6) & 8192 ^ ((codeWord & 0xF) << ((codeWord >> 4) & 7));

        debug_print("\n Shift to 14 bit: %d | ", Pos_Neg_Shift);
        convertToBinary(Pos_Neg_Shift);
        debug_print("\n Sign: %d | ", Pos_Neg_Mask);
        convertToBinary(Pos_Neg_Mask);
        debug_print("\n Step: %d | ", Word_Mask);
        convertToBinary(Word_Mask);
        debug_print("\n Chord: %d | ", shift_val);
        convertToBinary(shift_val);
        debug_print("\n Step_Decompressed: %d | ", Word_Shift);
        convertToBinary(Word_Shift);
        debug_print("\n Word_Decompressed: %d | ", word1);
        convertToBinary(word1);
    }

   return ((codeWord << 6) & 0x2000 ) ^ 0x2000   ^ ((codeWord & 0xF) << ((codeWord >> 4) & 0x7));   //Decompressed Word
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

