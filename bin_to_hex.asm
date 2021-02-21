%include "io.mac"

section .data
    length_hex  dd 0
    length_bin  dd 0
    four_group  dd 0

section .text
    global bin_to_hex
    extern printf

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]          ; hexa_value
    mov     esi, [ebp + 12]         ; bin_sequence
    mov     ecx, [ebp + 16]         ; length_hex

    ;; DO NOT MODIFY

    ;; TODO: Implement bin to hex

    mov     dword [length_hex], 0    ; lungimea sirului in hexa e 0 initial
    mov     dword [length_bin], ecx  ; salvez lungimea sirului in binar in mem
    mov     eax, ecx
    mov     cl, 4
    div     cl                       ; impart lungimea sirului la 4
    mov     byte [four_group], al    ; catul (numarul de grupuri de 4 bytes) e in al
    mov     cl,  ah                  ; restul va fi in cl
    cmp     cl, 0                    ; daca are bytes negrupati in grup de 4
    jne     write_rest               ; ii scriu separat

                         
    xor     ebx, ebx
    xor     eax, eax

while:
    
    push    edx
    xor     eax, eax
    mov     cl, 4

write_four:

    mov     dl, byte [esi + ebx]    ; caractertul din bin_sequence e adus in dl
    sub     dl, '0'                 ; prelucrez caracterul
    dec     cl
    shl     edx, cl                 ; shiftez byte-ul cu 3-pozitia in grupare    
    add     eax, edx                ; il adaug in gruparea de 4 
    inc     ebx
    cmp     cl, 0                   ; verific daca am scris o grupa de 4
    jnz     write_four

    dec     ebx
    pop     edx

    cmp     al, 10                  ; prelucrez numarul format din cei 4 bytes
    jge     decreases
    add     al, '0'

back_write_four:

    mov     ecx, [length_hex]
    mov     byte [edx + ecx], al   ; pe al ultimul pozitie din edx scriu caract
                                   ; corespunzator
    inc     ecx
    mov     [length_hex], ecx      ; retin in mem indicele la care am scris si cresc
                                   ; dimensiunea numarului in hex

    inc     ebx
    mov     cl, byte [four_group]  ; verific cate grupe de 4 caractere mai am de scris
    dec     cl                     ; am scris inca o grupa
    mov     byte[four_group], cl   ; retin in memorie cate mi-au mai ramas
    cmp     cl, 0                  ; verifc daca nu am scris deja toate grupele
    jnz     while


    mov     ecx, [length_hex]
    mov     byte [edx + ecx], 10   ; pun '\n' la final
    jmp     final

write_rest:

    push    edx
    xor     ebx, ebx
    xor     eax, eax

while_rest:

    xor     edx, edx

    mov     dl, byte [esi + ebx]   ; un char e in dl, ebx e poz la care sunt in 
    sub     dl, '0'                ; bin_sequence 
    dec     cl
    shl     edx, cl                ; shiftez cu cl (care e restul de bytes nescrisi) - 1
    inc     cl
    add     eax, edx               ; adaug in eax caracterul cobverit si shiftat 
    inc     ebx                    ; trec la urmatoarea poz din sirul bin_sequence
    loop    while_rest

    cmp     al, 10                 ; compar ce trebuie sa scriu in hexa cu 10
    jge     decreases_rest
    add     al, '0'

back_write_rest:

    pop     edx
    mov     byte [edx], al         ; scriu caracterul coresp(restul de bytes) din hexa
    mov     byte [length_hex], 1   ; lungimea sirului in hexa e 1
    jmp     while

decreases:

    sub    al, 10                  ; daca numarul e peste 10 fac al - 10 + 'A'
    add    al, 'A'
    jmp    back_write_four

decreases_rest:

    sub    al, 10                  ; daca numarul e peste 10 fac al - 10 + 'A'
    add    al, 'A'
    jmp    back_write_rest

final:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
