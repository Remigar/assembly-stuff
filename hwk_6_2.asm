;4/12/16
;Homework 6
;Eric Lara
;Program Description: This program will hash the following 10 strings and print their hash value. The algorithm used is FNV-1 (more info: https://en.wikipedia.org/wiki/Fowler%E2%80%93Noll%E2%80%93Vo_hash_function)
;There are still several collisions with a hash address of 3 but the collisions on address 8 and 2 gave been eliminated
;programmed in Microsoft Visual Studio 2015

INCLUDE Irvine32.inc

.data
	str1  BYTE "Herman Smith"
	str2  BYTE "Louie Jones"
	str3  BYTE "Robert Sherman"
	str4  BYTE "Barbara Goldenstein"
	str5  BYTE "Johnny Unitas"
	str6  BYTE "Tyler Abrams"
	str7  BYTE "April Perkins"
	str8  BYTE "William Jones"
	str9  BYTE "Steve Schockley"
	str10 BYTE "Steve Williams"
	
	displayStr BYTE "Hash Value: ",0

	TABLE_SIZE DWORD 11

	FNV_32_PRIME DWORD 01000193h			;"Magic number"
	FNV_32_OFFSET_BASIS DWORD 811C9DC5h		;"Magic number"
.code
main PROC
	
	push OFFSET str1
	push LENGTHOF str1
	call hashFunc

	push OFFSET str2
	push LENGTHOF str2
	call hashFunc

	push OFFSET str3
	push LENGTHOF str3
	call hashFunc

	push OFFSET str4
	push LENGTHOF str4
	call hashFunc

	push OFFSET str5
	push LENGTHOF str5
	call hashFunc

	push OFFSET str6
	push LENGTHOF str6
	call hashFunc

	push OFFSET str7
	push LENGTHOF str7
	call hashFunc

	push OFFSET str8
	push LENGTHOF str8
	call hashFunc

	push OFFSET str9
	push LENGTHOF str9
	call hashFunc

	push OFFSET str10
	push LENGTHOF str10
	call hashFunc

	exit
main ENDP


hashFunc PROC							;takes offset and length of an array of bytes and returns a hash value in eax
	push ebp
	mov ebp, esp
	
	mov eax, FNV_32_OFFSET_BASIS
	mov edx, 0
	mov esi, [ebp+12]					;get first arg, offset of the array
	mov ecx, [ebp+8]					;get second arg, length of the array
	mov ebx, TABLE_SIZE
	fnvLoop:							;main part of the hashing algorithm
		mul FNV_32_PRIME
		xor al, [esi]
		inc esi
		loop fnvLoop
	sub edx, edx						; have to set edx to 0 before using the div instruction
	div DWORD PTR ebx
	mov eax, edx						; move the remainder (our hash value) into the eax register
	
										;print the hash value in the format "Value: eax\n"
	mov edx, OFFSET displayStr
	call WriteString
	call WriteDec
	call crlf


	pop ebp
	ret 8			;clean up the stack
hashFunc ENDP


END main