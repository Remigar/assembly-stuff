;Eric Lara
;3/7/2015
;Homework 4
;Program Description: This program reverses the elements of the array DWArray.

INCLUDE Irvine32.inc

.data
DWArray DWORD 3,5,7,9,13,15,17,19
loopCount = (LENGTHOF DWArray / 2);the loop will execute n / 2 times

.code
main PROC
	mov esi, OFFSET DWArray
	mov ecx, loopCount
	mov ebx, TYPE DWArray
	
	;reverse the elements of the array
	ReverseLoop:
		
		push ecx

		shl ecx, 1; multiply ecx by two to caculate the offset we swap with
		dec ecx
		shl ecx, 2; multiply ecx by four, ecx now holds the offset of the memory location we want to swap with

		mov eax, [esi];cant use the XCHG instruction from memory to memory, eax will hold the current item
		XCHG eax, [esi + ecx]
		mov [esi], eax
		
		add esi, ebx ;move onto next item

		pop ecx

		loop ReverseLoop

	mov esi, OFFSET DWArray
	mov ecx, LENGTHOF DWArray
	call DumpMem
	exit

main ENDP
END main