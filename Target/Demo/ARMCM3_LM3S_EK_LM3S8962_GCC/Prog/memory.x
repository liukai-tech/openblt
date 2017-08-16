MEMORY
{
    FLASH (rx) : ORIGIN = 0x00004000, LENGTH = 240K
    SRAM (rwx) : ORIGIN = 0x20000000, LENGTH = 64K
}

SECTIONS
{
    __STACKSIZE__ = 1024;

    .text :
    {
        KEEP(*(.isr_vector))
        *(.text*)
        *(.rodata*)
        _etext = .;
    } > FLASH

    .data : AT (ADDR(.text) + SIZEOF(.text))
    {
        _data = .;
        *(vtable)
        *(.data*)
        _edata = .;
    } > SRAM

    .bss :
    {
        _bss = .;
        *(.bss*)
        *(COMMON)
        _ebss = .;
        _stack = .;
        . = ALIGN(MAX(_stack + __STACKSIZE__ , .), 4);
        _estack = .;
    } > SRAM
}
