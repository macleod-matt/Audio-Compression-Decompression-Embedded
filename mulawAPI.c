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
	int j; 
	for(j = i -1 ; j >=0; j++){ 
		printf("%d", binaryVal[i]); 
	} 


}


int codeword_compression(unsigned int sample_magnitude, int sign)
{
    int chord, step;
    int codeword_tmp;
    
    sign = !(sign || sign);     //Flip Sign
    
    debug_print("\n<============== Checking Compression operation ==============>");

    debug_print("\nSample Megnatude: %d | ", sample_magnitude);
    if(DEBUG) decToBinary(sample_magnitude);
    debug_print("\nSample Sign: %d | ", sign);
    if(DEBUG) decToBinary(sign);
    debug_print("\n");
    
    if(sample_magnitude > 16383)    //check if input is within upper bound
    {
        printf("\n!!!!! INPUT IS TOO LARGE !!!!!\n");
        return 0;
    }
    
    if (sample_magnitude & (1 << 12))
    {
        chord = 0x7;
        step = (sample_magnitude >> 8) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("chord: %d, step: %d, codeword_tmp: %d | ", chord, step, codeword_tmp);
        return (codeword_tmp);
    }
    if (sample_magnitude & (1 << 11))
    {
        chord = 0x6;
        step = (sample_magnitude >> 7) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("chord: %d, step: %d, codeword_tmp: %d | ", chord, step, codeword_tmp);
        return (codeword_tmp);
    }
    if (sample_magnitude & (1 << 10))
    {
        chord = 0x5;
        step = (sample_magnitude >> 6) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("chord: %d, step: %d, codeword_tmp: %d | ", chord, step, codeword_tmp);
        return (codeword_tmp);
    }
    if (sample_magnitude & (1 << 9))
    {
        chord = 0x4;
        step = (sample_magnitude >> 5) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("\nchord: %d, step: %d, codeword_tmp: %d |", chord, step, codeword_tmp);
        return (codeword_tmp);
    }
    if (sample_magnitude & (1 << 8))
    {
        chord = 0x3;
        step = (sample_magnitude >> 4) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("\nchord: %d, step: %d, codeword_tmp: %d |", chord, step, codeword_tmp);
        return (codeword_tmp);
    }
    if (sample_magnitude & (1 << 7))
    {
        chord = 0x2;
        step = (sample_magnitude >> 3) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("chord: %d, step: %d, codeword_tmp: %d | ", chord, step, codeword_tmp);
        return (codeword_tmp);
    }
    if (sample_magnitude & (1 << 6))
    {
        chord = 0x1;
        step = (sample_magnitude >> 2) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("chord: %d, step: %d, codeword_tmp: %d | ", chord, step, codeword_tmp);
        return (codeword_tmp);
    }
    if (sample_magnitude & (1 << 5))
    {
        chord = 0x0;
        step = (sample_magnitude >> 1) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("chord: %d, step: %d, codeword_tmp: %d | ", chord, step, codeword_tmp);
        return (codeword_tmp);
    }
    
    debug_print("COULD NOT MEET IF STATMENT CONDITION");
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

      return (((codeWord << 6) & 0x2000 ) ^ 0x2000 ^ ((codeWord & 0xF) << ((codeWord >> 4) & 0x7))) | (33 << (((codeWord >> 4) & 0x7)-1));  //Decompressed Word
}





int Test(int sample)
{
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

