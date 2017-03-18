/*generate 16-bit code*/
__asm__(".code16\n");
/*jump boot code entry*/
__asm__("jmpl $0x0000, $main\n");

#include "stdio.h"

int main(int argc, char const *argv[])
{
	printf("Hello");
	return 0;
}
