
#ifndef MULAWAPI_H
#define MULAWAPI_H

#include <stdio.h>
#include <string.h>
#include "read_wav.h"
// macros


//Chage to 1 for Debugging mode and 0 otherwise
#define DEBUG (0)

#if DEBUG == 1
    #define debug_print printf
#else 
    #define debug_print
#endif 


#define magnitude(sample) ((sample < 0) ? -sample : sample) 

#define signum(num) (unsigned int)((num > 0)) 


// Functions 

// int signum(int sample); 

 

int codeword_compression(unsigned int sample_magnitude, unsigned int sign); 

int codeword_decompression(int codeWord); 

int Test(int sample); 


#endif 

