OUTPUT_ARCH(mips)
ENTRY(vec_reset)
SECTIONS
{
  . = 0x9FC00000;
  .text : 
   AT ( 0xBFC00000 )
   {
     _ftext = . ;
    *(.init)
     eprol  =  .;
    *(.text)
    PROVIDE (__runtime_reloc_start = .);
    *(.rel.sdata)
    PROVIDE (__runtime_reloc_stop = .);
    *(.fini)
    *(.rodata)
     _etext  =  .;
   }
  .data 0x80001000 :
    AT ( ((ADDR(.text)|0xB0000000) + SIZEOF ( .text ) + 15) & 0xFFFFFFF0)
  {
    _gp = ALIGN(16) + 0x8000;
    _fdata = .;
    *(.rdata)
    *(.data)
    CONSTRUCTORS
    *(.sdata)
  }
   . = ALIGN(16);
   _edata  =  .;
   _fbss = .;
  .sbss : {
    *(.sbss)
    *(.scommon)
  }
  .bss : {
    *(.bss)
    *(COMMON)
  }
  . = ALIGN(16);
   _end = .;
}
