;Eric Lara
;4/19/16
;Homework 7
;This program takes two 3x3 matrices and multiply them, then display the output
;Programmed in Visual Studio 2015
INCLUDE Irvine32.inc

.data

matrice1 SDWORD 1, 3, 5
Rowsize1 = ($ - matrice1)
		 SDWORD 1, 1, -2
		 SDWORD 4, -3, 2

matrice2 SDWORD 3, 5, 7
Rowsize2 = ($ - matrice2)
		 SDWORD 4, -3, 9
		 SDWORD -1, 2, -6

result SDWORD 1, 2, 3
Rowsize3 = ($ - result)
		SDWORD 4, 5, 6
		SDWORD 7, 8, 9

temp SDWORD ?

count1 DWORD 0		 ;counter for outer loop
count2 DWORD 0		 ;counter for inner loop
addressCount DWORD 0 ;keep track of what index of result we're storing

.code

calcDotProduct PROTO, m1:PTR SDWORD, m2:PTR SDWORD, r1:DWORD, c2:DWORD



main PROC
	OuterLoop:
		mov count2, 0
	InnerLoop:
		INVOKE calcDotProduct, ADDR matrice1, ADDR matrice2, count1, count2
		mov temp, eax
		;here we calculate the address for the result
		mov eax, addressCount
		shl eax, 2
		mov ebx, eax
		mov eax, temp


		mov result[ebx], eax ;move the result into the proper address


		mov eax, count2
		cmp eax, 2 ;is the inner loop done?
		jz IsTwo	 ;if yes, go to outer loop
		inc count2
		inc addressCount
		jmp InnerLoop
		IsTwo: 
		mov eax, count1
		cmp eax, 2 ;is the outer loop done?
		jz Done	 ;if yes, we're done
		inc addressCount
		inc count1 
		jmp OuterLoop
	Done:
		;show the output matrix
		mov esi, OFFSET result
		mov ecx, LENGTHOF result
		mov ebx, TYPE result
		call DumpMem
		add esi, 12
		mov ecx, 3
		call DumpMem
		add esi, 12
		mov ecx, 3
		call DumpMem
		exit
main ENDP


;given a row and col number, two matrice offsets, calculate the dot product of the row number of matrice 1 and the col number of matrice 2 and store it in eax
calcDotProduct PROC, m1:PTR SDWORD, m2:PTR SDWORD, r1:DWORD, c2:DWORD
	LOCAL tempVar:SDWORD, sum:SDWORD 
	;INVOKE WriteStackFrame, 4, 2, 0
	mov sum, 0

	mov esi, m1 ;offset of m1

	mov edx, m2 ;offset of m2

	push edx
	mov eax, r1
	mov ebx, 3
	mul ebx
	mov ebx, TYPE DWORD
	mul ebx
	pop edx
	add esi, eax ;esi now points to the first element of the row in matrix 1 we wish to multiply
	push edx

	mov eax, c2
	mul ebx

	pop edx

	add edx, eax ;edx now points to the first element of the column  in matrix 2 we wish to multiply
	mov tempVar, 0
	dotProdLoop:
		mov eax, [esi]
		mov ebx, [edx]
		push edx
		imul ebx
		pop edx
		add sum, eax
		mov eax, tempVar
		cmp eax, 2
		jz Finished
		inc tempVar
		add esi, 4
		add edx, 12
		jmp dotProdLoop
	Finished:
	mov eax, sum
	ret
calcDotProduct ENDP

END main