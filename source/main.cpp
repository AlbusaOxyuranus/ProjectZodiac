/*generate 16-bit code*/
__asm__(".code16\n");
/*jump boot code entry*/
__asm__("jmpl $0x0000, $main\n");

void main()
{
	__asm__ __volatile__ ("movb $'X'  , %al\n");
     __asm__ __volatile__ ("movb $0x0e, %ah\n");
     __asm__ __volatile__ ("int $0x10\n");
}