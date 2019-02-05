
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

**Encoding modes can be mixed as needed within a QR symbol. (e.g., a url with a long string of alphanumeric characters )**

`[ Mode Indicator][ Mode bitstream ] --> [ Mode Indicator][ Mode bitstream ] --> etc... --> [ 0000 End of message (Terminator) ]`

**After every indicator that selects an encoding mode is a length field that tells how many characters are encoded in that mode. The number of bits in the length field depends on the encoding and the symbol version.**

**Number of bits in a length field (Character Count Indicator)**
First Header | Second Header | First Header | Second Header
------------ | ------------- | ------------ | -------------

Encoding | Ver. 1–9 | 10–26 | 27–40
------------ | ------------- 
Numeric |	`10`	|  `12`	  |  `14`
Alphanumeric|	`9`	 | `11`	   | `13`
Byte	  |      `8`	|  `16`	 |   `16`
Kanji   |     `8`	|  `10`	  |  `12`

**Alphanumeric encoding mode stores a message more compactly than the byte mode can, but cannot store lower-case letters and has only a limited selection of punctuation marks, which are sufficient for rudimentary web addresses. Two characters are coded in an 11-bit value by this formula:**

[V = 45 × C1 + C2]
[This has the exception that the last character in an alphanumeric string with an odd length is read as a 6-bit value instead.]

**Alphanumeric character codes**
#Code	Character
`00`	[0]	`09`	[9]	`18`	[I]	`27`	[R]	`36`	[Space]
`01`	[1]	`10`	[A]	`19`	[J]	`28`	[S]	`37`	[$]
`02`	[2]	`11`	[B]	`20`	[K]	`29`	[T]	`38`	[%]
`03`	[3]	`12`	[C]	`21`	[L]	`30`	[U]	`39`	[*]
`04`	[4]	`13`	[D]	`22`	[M]	`31`	[V]	`40`	[+]
`05`	[5]	`14`	[E]	`23`	[N]	`32`	[W]	`41`	[–]
`06`	[6]	`15`	[F]	`24`	[O]	`33`	[X]	`42`	[.]
`07`	[7]	`16`	[G]	`25`	[P]	`34`	[Y]	`43`	[/]
`08`	[8]	`17`	[H]	`26`	[Q]	`35`	[Z]	`44`	[:]


