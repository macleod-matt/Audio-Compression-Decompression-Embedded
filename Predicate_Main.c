#include <stdio.h>

#define magnitude(sample) ((sample & 0x2000) ? sample & 0x1FFF : sample)

void main()
{
    magnitude(-3020);
    return;
}
