; Nombre: López Mercado Brayan
; Matrícula: 1280838
; Organización y Arquitectura De Computadoras
; Practica 6
; Fecha: 30 de marzo de 2021
section .data
    ;1 corregir para que cumpla lo que se indica arriba
    NL      db  13,10
    NL_L    equ $-NL

section .bss
    ;2 corregir para que cumpla lo que se indica arriba
    X       resd 8
    Y       resd 8
    Z       resd 8
    W       resd 64
    tmp     resb 32
    cad     resb 32

section .text
global _start

_start:
    ;3 Inicializaci�n de variables X = 10h, Y = 20h, Z = 30h y W = 4000000000000000h
    ;corregir para que cumpla lo que se indica arriba
    mov dword [X], 10h
    mov dword [Y], 20h
    mov dword [Z], 30h
    mov eax, W 
    mov edx,[W+4]
    mov dword [eax], 00000000h ;Parte baja
    mov dword [edx], 40000000h ;Parte Significativa

    ;4 imprimir y comprobar que se cumpla lo que se les indico
    call printHex
    call salto_linea
    call salto_linea


    ;5 Suma de X e Y con modo de direccionamiento de registro y guardarlo en Z
    ;corregir para que cumpla lo que se indica arriba
    mov eax,[X]
    mov ebx,[Y]
    add eax, ebx
    mov [Z],eax 

    ;6 imprimir y comprobar que se cumpla lo que se les indico
    call printHex
    call salto_linea

    ;7 Resta de Y a W y guardado en tmp con modo de direccionamiento indirecto
    ;corregir para que cumpla lo que se indica arriba ****

    mov eax, dword [W] ; Cargar MSB de W en eax
    mov ebx, dword [W+4] ; Cargar MSB de W en edx
    mov edx, dword [Y] ;
    sub ebx,edx
    sbb eax,ecx
    mov eax,ebx

    ;8 imprimir y comprobar que se cumpla lo que se les indico
    mov dword [tmp],ebx
    call printHex
    call salto_linea
    mov dword [tmp+4],eax
    call printHex
    call salto_linea

    ;9 Incremento en 16777216 decimal a W con modo de direccionamiento base más índice escalado mas desplazamiento trabajando con movimientos de 8 bits 
    ;corregir para que cumpla lo que se indica arriba
    mov edi, 1
    inc byte [W + edi * 1 + 1]

    ;10 imprimir y comprobar que se cumpla lo que se les indico


    mov edx, NL
    ;11 Sumar W con W sin utilizar memoria en la suma y guardarlo en W
    ;add word [W+W]
    mov ebx,[W]
    mov edx,[W+4]
    add edx,edx
    adc ebx,ebx
    mov [W],edx
    mov [W+4],ebx


    ;12 imprimir y comprobar que se cumpla lo que se les indico
    ;corregir para que cumpla lo que se indica arriba
    mov eax, dword [W + edi * 2]
    call printHex
    call salto_linea

    lea eax, [W] ;vemos la direccion de W
    call printHex
    call salto_linea

    lea eax, [W + edi * 2]
    call printHex
    call salto_linea

    lea eax, [tmp]
    call printHex
    call salto_linea



    ;13 Multiplicación con signo de X por Y y guardado en tmp con modo de direccionamiento de memoria directa
    ;corregir para que cumpla lo que se indica arriba
    imul dword [Y]
    mov [Z], eax 
    ; el resultado esta en edx:eax y debe ir la direccion de W

    ;14 imprimir y comprobar que se cumpla lo que se les indico



    ;15 División de Y entre X y guardado en Z con modo de direccionamiento de memoria indirecta
    ;corregir para que cumpla lo que se indica arriba
    cdq ;revisen esta instruccion, les sirve
    idiv dword [X]
    mov [Z], eax

    ;16 imprimir y comprobar que se cumpla lo que se les indico



    ;17 Invertir del octavo al onceavo byte de tmp y guardado en tmp con modo de direccionamiento base m�s desplazamiento
    ; y negar del noveno al decimo
    ;corregir para que cumpla lo que se indica arriba
    mov ebx, tmp
    neg bit [ebx + 8]
    neg bit [ebx + 9]
    neg bit [ebx + 10]
    neg bit [ebx + 11]
    neg bit [ebx + 12]
    

    ;18 imprimir y comprobar que se cumpla lo que se les indico



    ;19 Comprobación de resultados en cada una de las variables
    ;corregir para que cumpla lo que se indica arriba
    mov eax, [X]
    call printHex
    call salto_linea
    mov eax, [Y]
    call printHex
    call salto_linea
    mov eax, [Z]
    call printHex
    call salto_linea
    mov eax, [W]
    call printHex
    call salto_linea
    mov eax, [tmp]
    call printHex
    call salto_linea

    ;20 Finalización del programa
    ;corregir para que cumpla lo que se indica arriba
    mov eax, 1
    mov ecx, 0
    int 0x80



salto_linea:
    ;21 corregir para que cumpla lo que se indica arriba
    pushad
    mov eax, 4
    mov ebx, 1
    mov ecx, NL
    mov edx, NL_L
    int 80h
    popad
    ret



printHex:
    pushad
    mov edx, eax
    mov ebx, 0fh
    mov cl, 28
    popad
nxt:
    shr eax, cl
msk:
    and eax, ebx
    cmp al, 9
    jbe menor
    add al, 7
menor:
    add al, '0'
    mov byte [esi], al
    inc esi
    mov eax, edx
    cmp cl, 0
    je print
    sub cl, 4
    cmp cl, 0
    ja nxt
    je msk
print:
    mov eax, 4
    mov ebx, 1
    sub esi, 8
    mov ecx, esi
    mov edx, 8
    int 80h
    popad
    ret


; Why am i still here?
; Just to suffer?