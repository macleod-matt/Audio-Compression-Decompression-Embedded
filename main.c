#include "mulawAPI.h"
#include "read_wav.h"



char *inFileName;
char *outFileName;


int main(int argc, char **argv){ 

    inFileName = (char*) malloc(sizeof(char) * 1024);
    outFileName = (char*) malloc(sizeof(char) * 1024);
    char cwd[1024];


    if (getcwd(cwd, sizeof(cwd)) != NULL) {

        strcpy(inFileName, cwd);
        strcpy(outFileName, cwd);
        // get inFileName from command line

        if (argc < 2) {

        printf("No wave file specifiedn");

        return 0;

        }
        
        strcat(inFileName, "/");
        strcat(inFileName, argv[1]);
        strcat(outFileName, "/compressed.wav");

        printf("\n"); 

        encode_wave_file(inFileName,outFileName, COMPRESS);

    }

        return 0; 
    }