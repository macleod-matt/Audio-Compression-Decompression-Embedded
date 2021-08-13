#include <stdio.h>

#define magnitude(sample) ((sample & 0x2000) ? sample & 0x1FFF : sample)

int main()
{
    printf("%d",magnitude(-3020));
    return 0;
}
