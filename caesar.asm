%include "io.mac"

section .text
    global caesar
    extern printf

caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the caesar cipher

    xor     eax, eax            ; setez eax cu 0
    xor     ebx, ebx            ; setez ebx cu 0

start:
    mov    al,  byte [esi + ebx]   ; adaug in al elem din plain

    cmp    al,  65                 ; al < A
    jl     write_char

    cmp    al,  122                ; al > z
    jg     write_char

    cmp    al,  97                 ; al < a
    jl     upper_char

    ;                              e litera mica
    add     eax, edi               ; fac deplasamentul

lowerchar_out:
    cmp     eax, 122
    jg      decreases_lowerchar
    jmp     write_char

decreases_lowerchar:
    sub     eax, 26
    jmp     lowerchar_out
    
 upper_char:                       ; poate fi litera mare sau nu e
                                   ; caracter
    cmp     al, 90                 ; al > z
    jg    write_char               ; nu e litera

    ;                              e litera MARE
    add     eax, edi               ; fac deplasamentul

upperchar_out:
    cmp     eax, 90
    jg      decreases_upperrchar
    jmp     write_char

decreases_upperrchar:
    sub     eax, 26
    jmp     upperchar_out

write_char:
    mov     [edx + ebx], al        ; adaug in edx elem cu elem
    inc     ebx                    ; maresc contorul
    loop    start
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY