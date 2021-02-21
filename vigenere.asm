%include "io.mac"

section .data
    key_len     dd 0
    count_key   dd 0            ; pe ce pozitie e contorul din key
    type        dd 0            ; daca in plaintext am litera mica sau
                                ; mare

section .text
    global vigenere
    extern printf


vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY

    ;; TODO: Implement the Vigenere cipher

    mov     dword [key_len], ebx       ; mut key_len in memorie 
    xor     eax, eax                   ; setez eax cu 0
    xor     ebx, ebx                   ; setez ebx cu 0

start:
    mov    al,  byte [esi + ebx]       ; adaug in al elem din plain

    cmp    al,  65                     ; al < A
    jl     write_char

    cmp    al,  122                    ; al > z
    jg     write_char

    cmp    al,  97                     ; al < a
    jl     upper_char

                                      ; e litera mica si o voi coda
                                      ; in type cu 0
    mov    dword[type], 0
    jmp    increment_char             ; o incrementez cu ajutorul key

jump_lower:
lowerchar_out:
    cmp     eax, 122
    jg      decreases_lowerchar
    push    ecx
    mov     ecx, dword [count_key]    ; numar cate caractere litere sunt in plaintext
    inc     ecx                       ; pentru a putea tine cont sa le codez doar pe ele 
    mov     dword [count_key], ecx    ; cu key
    pop     ecx
    jmp     write_char

decreases_lowerchar:
    sub     eax, 26
    jmp     lowerchar_out
    
upper_char:                            ; poate fi litera mare sau nu e
                                       ; caracter
    cmp     al, 90                     ; al > z
    jg      write_char                 ; nu e litera

                                       ; e majuscula si o voi coda cu type-ul 1
    mov     dword[type], 1  
    jmp     increment_char             ; o incrementez cu ajutorul key

jump_upper:
upperchar_out:
    cmp     eax, 90
    jg      decreases_upperrchar
    push    ecx
    mov     ecx, dword [count_key]      ; count_key numara cate litere sunt in plaintext
    inc     ecx
    mov     dword [count_key], ecx
    pop     ecx
    jmp     write_char

decreases_upperrchar:
    sub     eax, 26
    jmp     upperchar_out

write_char:
    mov     [edx + ebx], al             ; adaug in edx elem cu elem
    inc     ebx                         ; maresc contorul
    dec     ecx
    jnz     start
    mov     dword [count_key], 0        ; resetez numarul de caractere-litera la 0
    jmp     final                       ; sar la final


increment_char:                              
    push    ebx                         ; prelucrez key-ul cu care trebuie sa codez
    mov     ebx, dword [count_key]      ; mut in ebx valoarea pozitiei ultimei key cu
                                        ; cu care am codat

verif_key:                              ; verific daca am depasit lungimea key-ului
    cmp    ebx, dword [key_len]
    jge    dec_key                      ; am depasit lungimea si trebuie sa o scad
    jmp    add_key

dec_key:
    sub    ebx, dword [key_len]
    jmp    verif_key                    ; verific daca am ajuns la lungimea coresp.

add_key:
    mov    bl, byte [edi + ebx]         ; al catelea elem din edi trebuie adaugat
    sub    bl, 'A'                      ; aflam pozitia elem in alfabet
    add    eax, ebx                     ; fac deplasamentul
    pop    ebx

    cmp    dword[type], 0               ; sar inapoi la codul pentru litera mica
    je     jump_lower
    cmp    dword[type], 1               ; sar inapoi la codul pentru majuscula
    je     jump_upper

final:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY