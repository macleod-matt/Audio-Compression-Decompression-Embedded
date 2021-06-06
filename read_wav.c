/* 
    All Wave File Notation was referenced here: https://web.archive.org/web/20130510081513/https://ccrma.stanford.edu/courses/422/projects/WaveFormat/


*/  

#include <stdint.h> 
#include <stdbool.h> 
#include <stdio.h>
#include <string.h>
#include <time.h>
#include "mulawAPI.h"
#include "read_wav.h"


FILE *inFilePtr, *outFilePtr; 
uint8_t file_size = 0;   



// unsigned int  char_to_int(unsigned char *arr, int len){ 

//    unsigned int num = 0;

//     for (int i =0; i < len;  i ++){ 
//         printf("%d, %d", arr[i], len); 
//         printf("\n"); 
//         num |= (arr[i] << (8*i)); 


//     }

//     return num; 

// } 



int encode_wave_file(char* inFileName, char* outFileName, bool encodeType){

    wave_header_t wav_header;

    int16_t input_data1, input_data2, input_data3, input_data4;
    int8_t codeword1, codeword2, codeword3, codeword4;
    unsigned char *inputfile_data_buffer, *output_file_data_buffer;
  

    unsigned char byte_buffer_2[2], byte_buffer_4[4];

    inFilePtr = fopen(inFileName, "rb+");
    outFilePtr = fopen(outFileName, "wb");
    
    // Riff - does not change
    fread(wav_header.riff, sizeof(wav_header.riff), 1, inFilePtr);
    fwrite(wav_header.riff, sizeof(wav_header.riff), 1, outFilePtr);


    // Overall Size (ChunkSize) - the new size must be calculated and written
    fread(wav_header.size, sizeof(wav_header.size), 1, inFilePtr);
    uint8_t file_size = wav_header.size[0] | (wav_header.size[1] << 8) | (wav_header.size[2] << 16) | (wav_header.size[3] << 24);


    unsigned int new_overall_size = file_size + 8 - 44;
    
    new_overall_size = new_overall_size / 2;
    new_overall_size = new_overall_size + 44 - 8;
    byte_buffer_4[0] = (new_overall_size >> 24) & 0xFF;
    byte_buffer_4[1] = (new_overall_size >> 16) & 0xFF;
    byte_buffer_4[2] = (new_overall_size >> 8) & 0xFF;
    byte_buffer_4[3] = new_overall_size & 0xFF;
    fwrite(&byte_buffer_4[3], 1, 1, outFilePtr);
    fwrite(&byte_buffer_4[2], 1, 1, outFilePtr);
    fwrite(&byte_buffer_4[1], 1, 1, outFilePtr);
    fwrite(&byte_buffer_4[0], 1, 1, outFilePtr);



    // Wave (Format) - No change between I/O files 
    fread(wav_header.format, sizeof(wav_header.format), 1, inFilePtr);
    fwrite(wav_header.format, sizeof(wav_header.format), 1, outFilePtr);


    // Wave (Subchunk1ID)  - No change between I/O files 
    fread(wav_header.subChunk1ID, sizeof(wav_header.subChunk1ID), 1, inFilePtr);
    fwrite(wav_header.subChunk1ID, sizeof(wav_header.subChunk1ID), 1, outFilePtr);

    // Wave (subChunk1Size)  - No change between I/O files 
    fread(wav_header.subChunk1Size, sizeof(wav_header.subChunk1Size), 1, inFilePtr);
    fwrite(wav_header.subChunk1Size, sizeof(wav_header.subChunk1Size), 1, outFilePtr);

    // Wave (Audio Format)  - PCM = 1 , mu Law =  5
    fread(wav_header.audioFormat, sizeof(wav_header.audioFormat), 1, inFilePtr);
    byte_buffer_2[0] = 7;
    byte_buffer_2[1] = '\0';
    fwrite(&byte_buffer_2[0], 1, 1, inFilePtr);
    fwrite(&byte_buffer_2[1], 1, 1, inFilePtr);


    
   // Number of Channels - No change between I/O files 
    fread(wav_header.numChannels, sizeof(wav_header.numChannels), 1, inFilePtr);
    
    
   // unsigned int num_channels = char_to_int(wav_header.numChannels, 2); 

    // printf("Num Channels: %u", num_channels); 
    uint8_t num_channels = wav_header.numChannels[0]
                                | (wav_header.numChannels[1] << 8);
   
    // printf("\n"); 
    // printf("Num Channels: %u", num_channels2); 
    
    fwrite(wav_header.numChannels, sizeof(wav_header.numChannels), 1, outFilePtr);


    // Wave (Sample rate)  -  No change between I/O files 
    fread(wav_header.subChunk1Size, sizeof(wav_header.subChunk1Size), 1, inFilePtr);
    
    uint8_t sample_rate = wav_header.sampleRate[0]
                               | (wav_header.sampleRate[1] << 8)
                               | (wav_header.sampleRate[2] << 16)
                               | (wav_header.sampleRate[3] << 24);
    
    
    fwrite(wav_header.sampleRate, sizeof(wav_header.sampleRate), 1, outFilePtr);
    
    
    // Wave (byteRate)  - (SampleRate * NumChannels * BitsPerSample) / 8
    fread(wav_header.byteRate, sizeof(wav_header.byteRate), 1, inFilePtr);
    

    unsigned int byte_rate = (sample_rate * num_channels * BITS_PER_SAMPLE) / 8;


    byte_buffer_4[0] = (byte_rate >> 24) & 0xFF;
    byte_buffer_4[1] = (byte_rate >> 16) & 0xFF;
    byte_buffer_4[2] = (byte_rate >> 8) & 0xFF;
    byte_buffer_4[3] = byte_rate & 0xFF;
    fwrite(&byte_buffer_4[3], 1, 1, outFilePtr);
    fwrite(&byte_buffer_4[2], 1, 1, outFilePtr);
    fwrite(&byte_buffer_4[1], 1, 1, outFilePtr);
    fwrite(&byte_buffer_4[0], 1, 1, outFilePtr);


    // Wave (block align)  - (NumChannels * BitsPerSample) / 8

    
    fread(wav_header.blockAlign, sizeof(wav_header.blockAlign), 1, inFilePtr);
    
    unsigned int block_align = (num_channels * BITS_PER_SAMPLE) / 8;

    byte_buffer_2[0] = (block_align >> 8) & 0xFF;
    byte_buffer_2[1] = block_align & 0xFF;
    fwrite(&byte_buffer_2[1], 1, 1, outFilePtr);
    fwrite(&byte_buffer_2[0], 1, 1, outFilePtr);

    // Wave (Bits per sample ) - 8 BPS
    fread(wav_header.bitsPerSample, sizeof(wav_header.bitsPerSample), 1, inFilePtr);
    byte_buffer_2[0] = BITS_PER_SAMPLE;
    byte_buffer_2[1] = '\0';
    fwrite(&byte_buffer_2[0], 1, 1, inFilePtr);
    fwrite(&byte_buffer_2[1], 1, 1, inFilePtr);


    // Wave (Subchunk2ID)  - No change between I/O files 

    fread(wav_header.subChunk2ID, sizeof(wav_header.subChunk2ID), 1, inFilePtr);
    fwrite(wav_header.subChunk2ID, sizeof(wav_header.subChunk2ID), 1, outFilePtr);



    // determining remaining data size (Subtract 36 to remove allocated bytes from above sections)

    // Data size - calculate the size of the remaining input_data
    fread(wav_header.subChunk2Size, sizeof(wav_header.subChunk2Size), 1, inFilePtr);
    int data_header = new_overall_size + 8 - 44;
    byte_buffer_4[0] = (data_header >> 24) & 0xFF;
    byte_buffer_4[1] = (data_header >> 16) & 0xFF;
    byte_buffer_4[2] = (data_header >> 8) & 0xFF;
    byte_buffer_4[3] = data_header & 0xFF;
    fwrite(&byte_buffer_4[3], 1, 1, outFilePtr);
    fwrite(&byte_buffer_4[2], 1, 1, outFilePtr);
    fwrite(&byte_buffer_4[1], 1, 1, outFilePtr);
    fwrite(&byte_buffer_4[0], 1, 1, outFilePtr);
    
    file_size -= 36;


    inputfile_data_buffer = malloc(file_size * sizeof(char));
    output_file_data_buffer = malloc((file_size / 2) * sizeof(char));

    fread(inputfile_data_buffer, file_size, 1, inFilePtr);


    int i;
    for (i = 0; i < file_size; i = i + 8) {
        input_data1 = bytes_to_int16(inputfile_data_buffer[i], inputfile_data_buffer[i + 1]);
        input_data2 = bytes_to_int16(inputfile_data_buffer[i + 2], inputfile_data_buffer[i + 3]);
        input_data3 = bytes_to_int16(inputfile_data_buffer[i + 4], inputfile_data_buffer[i + 5]);
        input_data4 = bytes_to_int16(inputfile_data_buffer[i + 6], inputfile_data_buffer[i + 7]);
        
        if (encodeType == COMPRESS){ 
        
            codeword1 = codeword_compression(input_data1,signum(input_data1));
            codeword2 = codeword_compression(input_data2,signum(input_data2));
            codeword3 = codeword_compression(input_data3,signum(input_data3));
            codeword4 = codeword_compression(input_data4,signum(input_data4));
        
        } 
        if (encodeType == DECOMPRESS){ 
        
            codeword1 = codeword_decompression(input_data1);
            codeword2 = codeword_decompression(input_data2);
            codeword3 = codeword_decompression(input_data3);
            codeword4 = codeword_decompression(input_data4);
        
        } 


        output_file_data_buffer[i / 2] = codeword1;
        output_file_data_buffer[(i / 2) + 1] = codeword2;
        output_file_data_buffer[(i / 2) + 2] = codeword3;
        output_file_data_buffer[(i / 2) + 3] = codeword4;
    }
    
    fwrite(output_file_data_buffer, (file_size / 2), 1, outFilePtr);

    fclose(inFilePtr);
    fclose(outFilePtr);
    free(inFileName);
    free(outFileName);
    free(inputfile_data_buffer);
    free(output_file_data_buffer);


    return 0; 
}








