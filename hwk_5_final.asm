;3/17/2016
;Eric Lara
;Homework 5
;Program Description: this program sorts an array in increasing order using in place selection sort
;programmed in Microsoft Visual Studio 2015

INCLUDE Irvine32.inc

.data
Array BYTE 20, 10, 60, 5, 120, 90, 100, 7, 25, 12
sortedZoneCount BYTE 0
.code
main PROC

	mov ebx, TYPE Array
	mov esi, OFFSET Array
	mov ecx, LENGTHOF Array
	
	OuterLoop:
		push ecx
		mov esi, OFFSET Array
		mov ecx, LENGTHOF Array
		sub ecx, DWORD PTR sortedZoneCount			;the inner loop executes n-(size of sorted zone)-1 times
		mov edx, esi
		add edx, DWORD PTR sortedZoneCount			;the default least value will be the first element of the unsorted zone
		add esi, DWORD PTR sortedZoneCount			;the loop starts at the first byte of the unsorted zone

	InnerLoop:
		mov al, [esi]
		push esi
		mov esi, edx								;eax will hold the current element, by default it will be the first one
		cmp al, [esi]								;is al greater than the next element? if, not ZF and CF is zero
		pop esi										
		jnc NoNewLeast								;if CF is 1 (al < the contents byte edx), then fall through and set edx to hold the address of esi 
		mov edx, esi								;edx now holds the address of the new least element
		NoNewLeast:
		inc esi
		loop InnerLoop								;once this loop is done, do a swap
		
		mov esi, OFFSET Array
		add esi, DWORD PTR sortedZoneCount			
		mov al, [esi]
		XCHG al, [edx]							
		mov [esi], al
		inc sortedZoneCount
		pop ecx
		loop OuterLoop
	;dump registers
	mov esi, OFFSET Array
	mov ecx, LENGTHOF Array
	mov ebx, TYPE Array
	call DumpMem
	exit

main ENDP
END main