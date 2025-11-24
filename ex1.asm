.global _start

.section .data
vowels:
	.byte 'a', 'e', 'i', 'o', 'u'
	
.section .text
_start:
	xor %esi, %esi # %esi=i is the counter for the string
	xor %eax, %eax # %eax=k is the counter for the array
	movl %esi, count(%rip) # count=0
	movb $'A', %cl
	subb $'a', %cl
loop:
	movb string(%rip, %esi, 1), %bl # copy the i-th letter to %bl
	cmp 0, %bl # check whether we are at the end of the string
	je end
check_vowels:
	cmp %bl, vowels(%rip, %eax, 1)
	je found
	movb vowels(%rip, %eax, 1), %bh 
	addb %cl, %bh # %bh=vowel+('A'-'a')
	cmp %bl, %bh
	je found
	inc %eax
	cmp $4, %eax
	jne check_vowels
	xor %eax, %eax
	inc %esi # ++i
	jmp loop
found:
	movl count(%rip), %edx
	inc %edx
	movl %edx, count(%rip)
	inc %esi
	jmp loop
end:
nop