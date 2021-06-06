#include <stdio.h>
#include <stdint.h>

long decimalToBinary(int decimalnum)
{
    long binarynum = 0;
    int rem, temp = 1;

    while (decimalnum!=0)
    {
        rem = decimalnum%2;
        decimalnum = decimalnum / 2;
        binarynum = binarynum + rem*temp;
        temp = temp * 10;
    }
    return binarynum;
}

int main()

{   


	FILE *file_ptr;
    FILE * out_file ; 
	int data;

    
	int i=0;
	int a;

	file_ptr = fopen("audio_test.m4a","rb");


	if (file_ptr !=NULL)
	{
		printf("settings file found\n");
        out_file = fopen("Output.txt", "w");
		
		for (i=0;!feof(file_ptr);i++)
			{
	
				fread(&data, 1, 2, file_ptr);
                printf("%ld	\n", decimalToBinary((int)data));
               // fprintf(out_file, "%ld\n",decimalToBinary((int)data));
				//would have funtion here passing the 8 bits to arm assembler code, hence the necessatity for 8 btis only!
			}
		fclose(file_ptr);
        fclose(out_file); 
		
	}
	else { 
		printf("file not found\n");
    }
	return 0;



}