/* 
    All Wave File Notation was referenced here: https://web.archive.org/web/20130510081513/https://ccrma.stanford.edu/courses/422/projects/WaveFormat/


*/  
#include <stdlib.h>
#include <stdint.h> 
#include <stdbool.h> 
#include <stdio.h>
#include <string.h>
#include <time.h>
#include "mulawAPI.h"
#include "read_wav.h"


int encode_wave_file(char* input_file_name, char* output_file_name, bool encodeType){

    FILE *input_file, *output_file;
    wave_header_t wav_header; 

    unsigned char byte_buffer_2[2], byte_buffer_4[4];
    unsigned char *inputfile_data_buffer, *output_file_data_buffer;    
    
    int16_t input_data1, input_data2, input_data3, input_data4;
    int8_t codeword1, codeword2, codeword3, codeword4;

    input_file = fopen(input_file_name, "rb+");
    output_file = fopen(output_file_name, "wb");

    // Riff - does not change
    fread(wav_header.riff, sizeof(wav_header.riff), 1, input_file);
    fwrite(wav_header.riff, sizeof(wav_header.riff), 1, output_file);

    // Overall Size (ChunkSize) - the new size must be calculated and written
    fread(wav_header.overall_size, sizeof(wav_header.overall_size), 1, input_file);
    unsigned int overall_size = wav_header.overall_size[0]
                                | (wav_header.overall_size[1] << 8)
                                | (wav_header.overall_size[2] << 16)
                                | (wav_header.overall_size[3] << 24);
    unsigned int new_overall_size = overall_size + 8 - 44;
    
    new_overall_size = new_overall_size / 2;
    new_overall_size = new_overall_size + 44 - 8;
    byte_buffer_4[0] = (new_overall_size >> 24) & 0xFF;
    byte_buffer_4[1] = (new_overall_size >> 16) & 0xFF;
    byte_buffer_4[2] = (new_overall_size >> 8) & 0xFF;
    byte_buffer_4[3] = new_overall_size & 0xFF;
    fwrite(&byte_buffer_4[3], 1, 1, output_file);
    fwrite(&byte_buffer_4[2], 1, 1, output_file);
    fwrite(&byte_buffer_4[1], 1, 1, output_file);
    fwrite(&byte_buffer_4[0], 1, 1, output_file);

    // Wave(Format) - does not change between I/O
    fread(wav_header.format, sizeof(wav_header.format), 1, input_file);
    fwrite(wav_header.format, sizeof(wav_header.format), 1, output_file);

    // Wave (Subchunk1ID) - does not change between I/O
    fread(wav_header.subChunk1ID, sizeof(wav_header.subChunk1ID), 1, input_file);
    fwrite(wav_header.subChunk1ID, sizeof(wav_header.subChunk1ID), 1, output_file);

    // Wave (Subchunk1Size) - does not change between I/O
    fread(wav_header.subChunk1Size, sizeof(wav_header.subChunk1Size), 1, input_file);
    fwrite(wav_header.subChunk1Size, sizeof(wav_header.subChunk1Size), 1, output_file);

    // Wave (Audio Format) :  1=PCM; 6=ALAW; 7=MuLaw
    fread(wav_header.audioFormat, sizeof(wav_header.audioFormat), 1, input_file);
    byte_buffer_2[0] = 7;
    byte_buffer_2[1] = '\0';
    fwrite(&byte_buffer_2[0], 1, 1, output_file);
    fwrite(&byte_buffer_2[1], 1, 1, output_file);

    // Number of Channels - record the value but do not change it
    fread(wav_header.numChannels, sizeof(wav_header.numChannels), 1, input_file);
    unsigned int numChannels = wav_header.numChannels[0]
                                | (wav_header.numChannels[1] << 8);
    fwrite(wav_header.numChannels, sizeof(wav_header.numChannels), 1, output_file);

    // Sample Rate - Record the value but do not change it
    fread(wav_header.sampleRate, sizeof(wav_header.sampleRate), 1, input_file);
    unsigned int sampleRate = wav_header.sampleRate[0]
                               | (wav_header.sampleRate[1] << 8)
                               | (wav_header.sampleRate[2] << 16)
                               | (wav_header.sampleRate[3] << 24);
    fwrite(wav_header.sampleRate, sizeof(wav_header.sampleRate), 1, output_file);

    // Byte Rate = (SampleRate * NumChannels * BitsPerSample) / 8
    fread(wav_header.byteRate, sizeof(wav_header.byteRate), 1, input_file);
    unsigned int byteRate = (sampleRate * numChannels * BITS_PER_SAMPLE) / 8;
    byte_buffer_4[0] = (byteRate >> 24) & 0xFF;
    byte_buffer_4[1] = (byteRate >> 16) & 0xFF;
    byte_buffer_4[2] = (byteRate >> 8) & 0xFF;
    byte_buffer_4[3] = byteRate & 0xFF;
    fwrite(&byte_buffer_4[3], 1, 1, output_file);
    fwrite(&byte_buffer_4[2], 1, 1, output_file);
    fwrite(&byte_buffer_4[1], 1, 1, output_file);
    fwrite(&byte_buffer_4[0], 1, 1, output_file);

    // Wave (Block Align)  = (NumChannels * BitsPerSample) / 8
    fread(wav_header.blockAlign, sizeof(wav_header.blockAlign), 1, input_file);
    unsigned int blockAlign = (numChannels * BITS_PER_SAMPLE) / 8;
    byte_buffer_2[0] = (blockAlign >> 8) & 0xFF;
    byte_buffer_2[1] = blockAlign & 0xFF;
    fwrite(&byte_buffer_2[1], 1, 1, output_file);
    fwrite(&byte_buffer_2[0], 1, 1, output_file);

    // Bits per sample = 8
    fread(wav_header.bitsPerSample, sizeof(wav_header.bitsPerSample), 1, input_file);
    byte_buffer_2[0] = BITS_PER_SAMPLE;
    byte_buffer_2[1] = '\0';
    fwrite(&byte_buffer_2[0], 1, 1, output_file);
    fwrite(&byte_buffer_2[1], 1, 1, output_file);

    // Wave (subChunk2ID) - does not change between I/O
    fread(wav_header.subChunk2ID, sizeof(wav_header.subChunk2ID), 1, input_file);
    fwrite(wav_header.subChunk2ID, sizeof(wav_header.subChunk2ID), 1, output_file);

    // Wave (Data size) - needs to be calculated 
    fread(wav_header.subChunk2Size, sizeof(wav_header.subChunk2Size), 1, input_file);
    int chunk_header = new_overall_size + 8 - 44;
    byte_buffer_4[0] = (chunk_header >> 24) & 0xFF;
    byte_buffer_4[1] = (chunk_header >> 16) & 0xFF;
    byte_buffer_4[2] = (chunk_header >> 8) & 0xFF;
    byte_buffer_4[3] = chunk_header & 0xFF;
    fwrite(&byte_buffer_4[3], 1, 1, output_file);
    fwrite(&byte_buffer_4[2], 1, 1, output_file);
    fwrite(&byte_buffer_4[1], 1, 1, output_file);
    fwrite(&byte_buffer_4[0], 1, 1, output_file);

    overall_size -= 36;


    inputfile_data_buffer = malloc(overall_size * sizeof(char));

    fread(inputfile_data_buffer, overall_size, 1, input_file);

    register int i;

    if (encodeType == COMPRESS){ 


        output_file_data_buffer = malloc((overall_size / 2) * sizeof(char));

     
        for (i = 0; i < overall_size; i = i + 8) {
            
            input_data1 = bytes_to_int16(inputfile_data_buffer[i], inputfile_data_buffer[i + 1]);
            input_data2 = bytes_to_int16(inputfile_data_buffer[i + 2], inputfile_data_buffer[i + 3]);
            input_data3 = bytes_to_int16(inputfile_data_buffer[i + 4], inputfile_data_buffer[i + 5]);
            input_data4 = bytes_to_int16(inputfile_data_buffer[i + 6], inputfile_data_buffer[i + 7]);
            
            codeword1 = codeword_compression(magnitude(input_data1),signum(input_data1));
            codeword2 = codeword_compression(magnitude(input_data2),signum(input_data2));
            codeword3 = codeword_compression(magnitude(input_data3),signum(input_data3));
            codeword4 = codeword_compression(magnitude(input_data4),signum(input_data4));
        

            output_file_data_buffer[i / 2] = codeword1;
            output_file_data_buffer[(i / 2) + 1] = codeword2;
            output_file_data_buffer[(i / 2) + 2] = codeword3;
            output_file_data_buffer[(i / 2) + 3] = codeword4;
        }

        fwrite(output_file_data_buffer, (overall_size / 2), 1, output_file);

    }

    if (encodeType == DECOMPRESS){ 

        output_file_data_buffer = malloc((overall_size * 2) * sizeof(char));


        for (i = 0; i < overall_size; i = i + 8) {
            
            input_data1 = bytes_to_int14(inputfile_data_buffer[i], inputfile_data_buffer[i + 1]);
            input_data2 = bytes_to_int14(inputfile_data_buffer[i + 2], inputfile_data_buffer[i + 3]);
            input_data3 = bytes_to_int14(inputfile_data_buffer[i + 4], inputfile_data_buffer[i + 5]);
            input_data4 = bytes_to_int14(inputfile_data_buffer[i + 6], inputfile_data_buffer[i + 7]);
            
            codeword1 = codeword_decompression(input_data1);
            codeword2 = codeword_decompression(input_data2);
            codeword3 = codeword_decompression(input_data3);
            codeword4 = codeword_decompression(input_data4);
         
            
            output_file_data_buffer[i / 2] = codeword1;
            output_file_data_buffer[(i / 2) + 1] = codeword2;
            output_file_data_buffer[(i / 2) + 2] = codeword3;
            output_file_data_buffer[(i / 2) + 3] = codeword4;


            }
            fwrite(output_file_data_buffer, (overall_size * 2), 1, output_file);

    }




    fclose(input_file);
    fclose(output_file);

    return 0;
}



