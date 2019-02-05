![QR image](https://github.com/Thecreator1/images/blob/master/qrcode.png)

![My image](https://github.com/Thecreator1/images/blob/master/1024px-QR_Character_Placement.png)

**Encoding modes** 

ENC

Indicator | Meaning
------------ | -------------
`0001`  | Numeric encoding (10 bits per 3 digits)
`0010`	| Alphanumeric encoding (11 bits per 2 characters)
`0100`	| Byte encoding (8 bits per character)
`1000`	| Kanji encoding (13 bits per character)
`0011`	| Structured append (used to split a message across multiple QR symbols)
`0111`	| Extended Channel Interpretation (select alternate character set or encoding)
`0101`	| FNC1 in first position (see Code 128 for more information)
`1001`	| FNC1 in second position
`0000`	| End of message (Terminator)

**Encoding modes can be mixed as needed within a QR symbol. (e.g., a url with a long string of alphanumeric characters)**

`[ Mode Indicator][ Mode bitstream ] --> [ Mode Indicator][ Mode bitstream ] --> etc... --> [ 0000 End of message (Terminator) ]`

**After every indicator that selects an encoding mode is a length field that tells how many characters are encoded in that mode. The number of bits in the length field depends on the encoding and the symbol version.**

**Number of bits in a length field (Character Count Indicator)**

LEN

Encoding | Ver. 1–9 | 10–26 | 27–40
------------ | ------------- | ------------ | -------------
Numeric |	`10`	|  `12`	  |  `14`
Alphanumeric|	`9`	 | `11`	   | `13`
Byte	  |      `8`	|  `16`	 |   `16`
Kanji   |     `8`	|  `10`	  |  `12`

**Alphanumeric encoding mode stores a message more compactly than the byte mode can, but cannot store lower-case letters and has only a limited selection of punctuation marks, which are sufficient for rudimentary web addresses. 
Two characters are coded in an 11-bit value by this formula:**

`V = 45 × C1 + C2`

This has the exception that the last character in an alphanumeric string with an odd length is read as a 6-bit value instead.


**Alphanumeric character codes**

Code	| Character	| Code	| Character	| Code	| Character	| Code	| Character	| Code	| Character
----- | --------- | ----- | --------- |------ | --------- | ----- | --------- | ----- | ---------
`00`	|0|	`09`|	9	|`18`	|I	|`27`|	R	|`36`	|Space
`01`	|1|	`10`|	A	|`19`|	J	|`28`|	S	|`37`	|$
`02`	|2|	`11`|	B	|`20`	|K	|`29`	|T	|`38`	|%
`03`	|3|	`12`|	C	|`21`|	L	|`30`	|U	|`39`	|*
`04`	|4|	`13`|	D	|`22`	|M	|`31`	|V	|`40`	|+
`05`	|5|	`14`|	E	|`23`	|N	|`32`	|W	|`41`	|–
`06`	|6|	`15`|	F	|`24`	|O	|`33`	|X	|`42`	|.
`07`	|7|	`16`|	G	|`25`	|P	|`34`	|Y	|`43`	|/
`08`	|8|	`17`|	H	`|26`	|Q	|`35`	|Z	|`44`	|:

**Creating the Format String**

![ECL image](https://github.com/Thecreator1/images/blob/master/640px-QR_Format_Information.png)

The first two bits specify the error correction level:

```MQL5
//+------------------------------------------------------------------+
//| ECL - Error Correction Level Bits
//+------------------------------------------------------------------+
enum ECL// Error Correction Level Bits
  {
   L=01,// L Bits 01 Integer Equivalent 1
   M=00,// M Bits 00 Integer Equivalent 0
   Q=11,// Q Bits 11 Integer Equivalent 3
   H=10,// H Bits 10 Integer Equivalent 2
  };
//+------------------------------------------------------------------+
```
The next three bits specify the mask pattern:

![MASK image](https://github.com/Thecreator1/images/blob/master/QR_Code_Mask_Patterns.png)

```MQL5
//+------------------------------------------------------------------+
//| MASK - Mask Pattern Bits
//+------------------------------------------------------------------+
enum MASK// Mask Pattern Bits  
  {
   MASK0=000,// Mask Bits 000 (i+j) mod 2 = 0 
   MASK1=001,// Mask Bits 001 i mod 2 = 0
   MASK2=010,// Mask Bits 001 j mod 3 = 0
   MASK3=011,// Mask Bits 011 (i+j) mod 3 = 0
   MASK4=100,// Mask Bits 100 ((i div 2)+(j div 3)) mod 2 = 0
   MASK5=101,// Mask Bits 101 (ij) mod 2 + (ij) mod 3 = 0
   MASK6=110,// Mask Bits 110 ((ij) mod 2 +(ij) mod 3) mod 2 = 0
   MASK7=111,// Mask Bits 111 ((ij)mod 3 + (i+j) mod 2) mod 2 = 0
  };
//+------------------------------------------------------------------+
```
The two parameters to pass to form the format string:

```MQL5
//+------------------------------------------------------------------+
//--- input parameters
 ECL  error_correction = L;// Error Correction
 MASK mask_pattern = MASK1;// Mask Pattern
//+------------------------------------------------------------------+
```

Put it together in whichever way works for you:

```MQL5
//+------------------------------------------------------------------+
string FormatString(ECL ecl,MASK mask)
  {
   string format_string="";
   switch(ecl)
     {
      case L:format_string+="01";break;
      case M:format_string+="00";break;
      case Q:format_string+="11";break;
      case H:format_string+="10";break;
     }
   switch(mask)
     {
      case MASK0:format_string+="000";break;
      case MASK1:format_string+="001";break;
      case MASK2:format_string+="010";break;
      case MASK3:format_string+="011";break;
      case MASK4:format_string+="100";break;
      case MASK5:format_string+="101";break;
      case MASK6:format_string+="110";break;
      case MASK7:format_string+="111";break;
     }
   return(format_string);
  }
//+------------------------------------------------------------------+
```
Then the output should correspond to the desired format string:

```MQL5
//---
   Print("Format String: "+FormatString(error_correction,mask_pattern));
//---
```
`QR Code Test EURUSD,H1: Format String:01001`
