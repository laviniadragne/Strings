%include "io.mac"

section .data
    haystack_len dd 0

section .text
    global my_strstr
    extern printf

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index - int  *
    mov     esi, [ebp + 12]     ; haystack     - char *  - string ul in care caut
    mov     ebx, [ebp + 16]     ; needle       - char *  - cuv_cautat
    mov     ecx, [ebp + 20]     ; haystack_len - int     - lung string ului in care caut
    mov     edx, [ebp + 24]     ; needle_len   - int     - lung cuv ului cautat
    ;; DO NOT MODIFY

    ;; TO DO: Implement my_strstr


    inc ecx
    mov     dword [edi], ecx           ; cazul nefavorabil in care nu e subsirul prezent
    dec     ecx

    dec     ecx
    mov     dword [haystack_len], ecx  ; salvez lungimea sirului in 
                                       ; memorie/ pozitia max a unui caract

    cmp     edx, 1                     ; needle-ul are 1 litera
    je      one_charact

    xor     ecx, ecx
    xor     eax, eax
    xor     edx, edx

while:
    cmp  ecx, dword [haystack_len]      ; s-a terminat haystack-ul
    je   final
    mov  edx, [esi + ecx]
    cmp  edx, [ebx]                     ; compar ce am in haystack cu needle-ul                   
    je   write                          ; daca am gasit cuvantul, ii scriu prima aparitie
    inc  ecx                            ; daca nu l-am gasit, continui cautarea
    jmp  while

write:
    mov     dword [edi], ecx           ; scriu prima aparitie in edi
    jmp     final

one_charact:                           ; needle-ul are 1 litera si caut caracter cu caracter
    xor     eax, eax
    xor     edx, edx
    xor     ecx, ecx

one_charact_while:
    cmp  ecx, dword [haystack_len];
    je   final                         ; s-a terminat haystack-ul
    mov  dl, byte [esi + ecx]          ; aduc in registru caracterul corespunzator din haystack
    cmp  dl, byte [ebx]                ; il compar cu caracterul needle-ului
    je   write                         ; daca sunt egale, ii scriu prima aparitie
    inc  ecx                           ; daca nu l-am gasit, continui cautarea
    jmp  one_charact_while

final:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY