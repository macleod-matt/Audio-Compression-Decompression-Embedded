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
    while (n > 0)
    {

        // storing remainder in binary array
        binaryNum[i] = n % 2;
        n = n / 2;
        i++;
    }

    // printing binary array in reverse order
    for (int j = i - 1; j >= 0; j--)
        printf("%d", binaryNum[j]);
}

int codeword_compression(int sample_magnitude, int sign)
{
    sample_magnitude += 33;

    if(sample_magnitude >= 8192)
    {
        sample_magnitude = (sample_magnitude - 8192);
    }

    int chord, step;
    int codeword_tmp;

    debug_print("\n<============== Checking Compression operation ==============>");

    debug_print("\nSign before flip: %d", sign);
    sign = !sign; //Flip Sign

    debug_print("\nSample Megnatude: %d | ", sample_magnitude);
    if (DEBUG)
        decToBinary(sample_magnitude);
    debug_print("\nSample Sign: %d | ", sign);
    if (DEBUG)
        decToBinary(sign);
    debug_print("\n");

    if (sample_magnitude > 16383) //check if input is within upper bound
    {
        printf("\n!!!!! INPUT IS TOO LARGE !!!!!\n");
        return 0;
    }

    if (sample_magnitude >= 4096)
    {
        chord = 0x7;
        step = (sample_magnitude >> 8) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("chord: %d, step: %d, codeword_tmp: %d | ", chord, step, codeword_tmp);
        return (codeword_tmp);
    }
    if (sample_magnitude >= 2048)
    {
        chord = 0x6;
        step = (sample_magnitude >> 7) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("chord: %d, step: %d, codeword_tmp: %d | ", chord, step, codeword_tmp);
        return (codeword_tmp);
    }
    if (sample_magnitude >= 1024)
    {
        chord = 0x5;
        step = (sample_magnitude >> 6) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("chord: %d, step: %d, codeword_tmp: %d | ", chord, step, codeword_tmp);
        return (codeword_tmp);
    }
    if (sample_magnitude >= 512)
    {
        chord = 0x4;
        step = (sample_magnitude >> 5) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("\nchord: %d, step: %d, codeword_tmp: %d |", chord, step, codeword_tmp);
        return (codeword_tmp);
    }
    if (sample_magnitude >= 256)
    {
        chord = 0x3;
        step = (sample_magnitude >> 4) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("\nchord: %d, step: %d, codeword_tmp: %d |", chord, step, codeword_tmp);
        return (codeword_tmp);
    }
    if (sample_magnitude >= 128)
    {
        chord = 0x2;
        step = (sample_magnitude >> 3) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("chord: %d, step: %d, codeword_tmp: %d | ", chord, step, codeword_tmp);
        return (codeword_tmp);
    }
    if (sample_magnitude >= 64)
    {
        chord = 0x1;
        step = (sample_magnitude >> 2) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("chord: %d, step: %d, codeword_tmp: %d | ", chord, step, codeword_tmp);
        return (codeword_tmp);
    }
    if (sample_magnitude >= 32)
    {
        chord = 0x0;
        step = (sample_magnitude >> 1) & 0xF;
        codeword_tmp = (sign << 7) ^ (chord << 4) ^ step;
        debug_print("chord: %d, step: %d, codeword_tmp: %d | ", chord, step, codeword_tmp);
        return (codeword_tmp);
    }

    debug_print("COULD NOT MEET IF STATMENT CONDITION");
    return 0; //Error
}

int codeword_decompression(int codeWord)
{
    debug_print("\n<============== Checking Decompression operation ==============>");

    int sign = ((codeWord << 6) & 0x2000);
    sign = !sign;

    int sign_Most_Sig_Bit = ((sign << 13) & 0x2000); //shift sign to correct position and mask
    int step = (codeWord & 0x0F);                    //Step
    int chord = ((codeWord >> 4) & 0x07);            //chord
    int step_shifted_by_chord = step << (chord + 1);
    int add_ones_on_either_side = (0x21 << chord); // add the 1 A B C D 1 33 dec, 100001 bin, 21 hex
    int megnatude = add_ones_on_either_side | step_shifted_by_chord;
    int finalVal = sign_Most_Sig_Bit | megnatude;

    finalVal -= 33;
    
    if (DEBUG)
    {

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
        debug_print("\n Decompressed Work: %d | ", finalVal);
        decToBinary(finalVal);
    }
    return finalVal;
}

int signum(int sample)
{
    if (sample > 8192)
    {
        debug_print("\nNegative\n");
        return (1); /* sign is ’0’ for negative samples */
    }
    else
    {
        debug_print("\nPositive\n");
        return (0); /* sign is ’1’ for positive samples */
    }
}

int magnitude(int sample)
{
    if (sample > 0x2000)
    {
        sample = (sample & 0x1FFF);
    }
    debug_print("Magnatude: %d", sample);
    return (sample);
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
