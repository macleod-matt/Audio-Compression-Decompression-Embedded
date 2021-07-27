#include "mulawAPI.h"
#include "read_wav.h"
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>

time_t start, stop, start2, stop2;
double compression_time, decompression_time;

int main(int argc, char **argv)
{
    char *inFileName;
    char *compressedFileName;
    char *decompressedFileName;

    inFileName = (char *)malloc(sizeof(char) * 1024);
    compressedFileName = (char *)malloc(sizeof(char) * 1024);
    decompressedFileName = (char *)malloc(sizeof(char) * 1024);

    char cwd[1024];

    if (getcwd(cwd, sizeof(cwd)) != NULL)
    {

        strcpy(inFileName, cwd);
        strcpy(compressedFileName, cwd);
        strcpy(decompressedFileName, cwd);
        // get inFileName from command line

        if (argc < 2)
        {

            printf("No wave file specified");

            return 0;
        }

        strcat(inFileName, "/");
        strcat(inFileName, argv[1]);
        strcat(compressedFileName, "/compressed.wav");
        strcat(decompressedFileName, "/decompressed.wav");

        start = clock();

        encode_wave_file(inFileName, compressedFileName, COMPRESS);

        stop = clock();

        compression_time = (double)((double)stop - (double)start) / CLOCKS_PER_SEC;

        start2 = clock();

        encode_wave_file(compressedFileName, decompressedFileName, DECOMPRESS);

        stop2 = clock();

        decompression_time = (double)((double)stop2 - (double)start2) / CLOCKS_PER_SEC;

        printf("Complete\n");
        printf("Audio Compression Time:%lf  Seconds\n", compression_time);
        printf("Audio Decompression Time: %lf  Seconds \n", decompression_time);
    }

    return 0;
}
