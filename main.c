#include "mulawAPI.h"
#include "read_wav.h"
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>


int main(int argc, char **argv){ 

    char *inFileName;
    char *compressedFileName;
    char *decompressedFileName;

    inFileName = (char*) malloc(sizeof(char) * 1024);
    compressedFileName = (char*) malloc(sizeof(char) * 1024);
    decompressedFileName = (char*) malloc(sizeof(char) * 1024);

    char cwd[1024];


    if (getcwd(cwd, sizeof(cwd)) != NULL) {

        strcpy(inFileName, cwd);
        strcpy(compressedFileName, cwd);
        strcpy(decompressedFileName, cwd);
        // get inFileName from command line

        if (argc < 2) {

        printf("No wave file specifiedn");

        return 0;

        }
        
        strcat(inFileName, "/");
        strcat(inFileName, argv[1]);
        strcat(compressedFileName, "/compressed.wav");
        strcat(decompressedFileName, "/decompressed.wav");

        
        
        encode_wave_file(inFileName,compressedFileName, COMPRESS);
        encode_wave_file(compressedFileName,decompressedFileName, DECOMPRESS);


        }


        return 0; 
    }