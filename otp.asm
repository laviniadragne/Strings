%include "io.mac"

section .text
    global otp
    extern printf

otp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the One Time Pad cipher

    xor     eax, eax            ; setez eax cu 0
    xor     ebx, ebx            ; setez ebx cu 0

my_xor:
    mov     al, byte [esi + ebx]; adaug in al elem din plain
    xor     al, byte [edi + ebx]; fac xor-ul in al
    mov     [edx + ebx], al     ; adaug in edx elem cu elem
    inc     ebx                 ; maresc contorul
    loop    my_xor
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY