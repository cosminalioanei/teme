%include "/home/cosmin/iocla-tema2-resurse/include/io.inc"

extern atoi
extern printf
extern exit

; Functions to read/free/print the image.
; The image is passed in argv[1].
extern read_image
extern free_image
; void print_image(int* image, int width, int height);
extern print_image

; Get image's width and height.
; Store them in img_[width, height] variables.
extern get_image_width
extern get_image_height

section .data
	use_str db "Use with ./tema2 <task_num> [opt_arg1] [opt_arg2]", 10, 0

section .bss
    task:       resd 1
    img:        resd 1
    img_width:  resd 1
    img_height: resd 1

section .text
global main
main:
    ; Prologue
    ; Do not modify!
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    cmp eax, 1
    jne not_zero_param

    push use_str
    call printf
    add esp, 4

    push -1
    call exit

not_zero_param:
    ; We read the image. You can thank us later! :)
    ; You have it stored at img variable's address.
    mov eax, [ebp + 12]
    push DWORD[eax + 4]
    call read_image
    add esp, 4
    mov [img], eax

    ; We saved the image's dimensions in the variables below.
    call get_image_width
    mov [img_width], eax

    call get_image_height
    mov [img_height], eax
       
    ; Let's get the task number. It will be stored at task variable's address.
    mov eax, [ebp + 12]
    push DWORD[eax + 8]
    call atoi
    add esp, 4
    mov [task], eax

    ; There you go! Have fun! :D
    mov eax, [task]
    push eax
    cmp eax, 1
    je solve_task1
    cmp eax, 2
    je solve_task2
    cmp eax, 3
    je solve_task3
    cmp eax, 4
    je solve_task4
    cmp eax, 5
    je solve_task5
    cmp eax, 6
    je solve_task6
    cmp eax, 7
    je solve_task7
    jmp done

solve_task1:
push eax
bruteforce_singlebyte_xor:
   mov esi, [img_width]
   dec esi
   mov edi, [img_height]
   dec edi
   imul esi , edi
   xor edx,edx
   xor edi,edi
   mov ebx,-1
   mov ecx, [img]

loop1:
  inc ebx
  xor edx,edx
  xor edi,edi
loop2:
   mov eax ,dword[ecx+4*edx]
   xor eax , ebx
 
   cmp edi ,0
   je r
   cmp edi , 1
   je e
   cmp edi ,2
   je v
   cmp edi , 3
   je i
   cmp edi , 4
   je e
   cmp edi , 5
   je n
   cmp edi , 6 
   je t
   cmp edi , 7
   je condition
   
   condition:
   cmp eax, 0x00
   je final
    
   resttt:
 ;  xor edi ,edi
   inc edx
   cmp edx , esi  
   jne loop2
   cmp ebx ,256
   jne loop1
   final:
   xor eax,eax
   mov eax , edx 
   xor edx,edx
   
   mov esi , eax
   mov edi , [img_width]
   idiv edi
    ;mov esi , eax
  ; aici am in edx ... lungimea .... in eax
   mov edi , esi
  ; push eax
   sub edi ,edx
   xor edx,edx
   pop  edx
   push eax
   cmp edx , 2
   je lalala
   cmp edx , 1
   je afisare
   lalala:
   jmp rezolvare
   afisare: 
 mov eax , dword[ecx+4*edi]
 xor eax , ebx
 PRINT_CHAR eax
 inc edi
 cmp edi , esi
 jne afisare
 NEWLINE
 PRINT_DEC 4 , ebx
 NEWLINE
pop eax
 PRINT_DEC 4 , eax

 NEWLINE
   jmp done
 r:
   cmp eax ,"r"
   
   je count
   jne restt
   e:
   cmp eax ,"e"
   
   je count
   jne restt
   v:
   cmp eax ,"v"
  
   je count
   jne restt
    i:
   cmp eax ,"i"
  
   je count
   jne restt
    n:
   cmp eax ,"n"
  
   je count
   jne restt
    t:
   cmp eax ,"t"

   je count
   jne restt
  count:
   inc edi
   jmp resttt  
  restt:
   xor edi , edi
   jmp resttt    
 solve_task2:
    ;TODO Task2
    push eax
    jmp bruteforce_singlebyte_xor
    rezolvare:
    inc eax
    imul eax , [img_width]
    xor edi , edi 
    xor esi , esi
    mov esi, [img_width]

    mov edi, [img_height]
 
    imul esi , edi
    ;dec esi
    xor edi ,edi
    mov ecx, [img]
    mov edx , ebx
    push eax
    imul edx , 2
    add edx , 3
    mov edi , edx
    xor edx , edx
    mov eax , edi
    mov edi , 5
    idiv edi
    
    xchg edx , eax
    sub edx , 4   
    ;PRINT_DEC 4 ,edx
        xor edi , edi
        pop eax
    conditie:
    cmp edi , esi
    jne xorare
    je finall
    xorare:
    xor dword[ecx+4*edi] , ebx
   xor dword[ecx+4*edi] , edx
    inc edi
    cmp edi , eax
    je inlocuire
    jne conditie
    inlocuire:
    xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 67
     xor dword[ecx+4*edi] , edx
    inc edi
    xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 39
    xor dword[ecx+4*edi] , edx
    inc edi
    xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 101
     xor dword[ecx+4*edi] , edx
    inc edi
    xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 115
     xor dword[ecx+4*edi] , edx
    inc edi
    xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 116
     xor dword[ecx+4*edi] , edx
    inc edi
    xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 32
     xor dword[ecx+4*edi] , edx
    inc edi
    xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 117
    xor dword[ecx+4*edi] , edx
    inc edi
    xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 110
     xor dword[ecx+4*edi] , edx
    inc edi
    xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 32
     xor dword[ecx+4*edi] , edx
    inc edi
    xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 112
     xor dword[ecx+4*edi] , edx
     inc edi
     xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 114
     xor dword[ecx+4*edi] , edx
     inc edi
     xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 111
      xor dword[ecx+4*edi] , edx
     inc edi
   xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 118
      xor dword[ecx+4*edi] , edx
     inc edi
     xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 101
      xor dword[ecx+4*edi] , edx
     inc edi
     xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 114
      xor dword[ecx+4*edi] , edx
     inc edi
     xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 98
     xor dword[ecx+4*edi] , edx
     inc edi
     xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 101
      xor dword[ecx+4*edi] , edx
     inc edi
     xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 32
     xor dword[ecx+4*edi] , edx
     inc edi
     xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 102
     xor dword[ecx+4*edi] , edx
     inc edi
     xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 114
      xor dword[ecx+4*edi] , edx
     inc edi
     xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 97
      xor dword[ecx+4*edi] , edx
     inc edi
     xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 110
      xor dword[ecx+4*edi] , edx
     inc edi
     xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 99
     xor dword[ecx+4*edi] , edx
     inc edi
     xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 97
      xor dword[ecx+4*edi] , edx
     inc edi
     xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 105
     xor dword[ecx+4*edi] , edx
     inc edi
     xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 115
     xor dword[ecx+4*edi] , edx
     inc edi
     xor dword[ecx+4*edi] , ebx
    mov dword[ecx+4*edi] , 46
     xor dword[ecx+4*edi] , edx
     inc edi
     xor dword[ecx+4*edi] , ebx
     mov dword[ecx+4*edi] , 0
     xor dword[ecx+4*edi] , edx
     inc edi
     jmp conditie
 finall:
    push dword [img_height]
    push dword [img_width]
    push dword [img]   
    call print_image
    jmp done
   ; jmp done
solve_task3:
    ; TODO Task3
    mov ecx , [ebp+12]
    mov ecx , [ecx+12]
    mov ebx , [ebp+12]
    add ebx ,16
   mov ebx , [ebx]
    xor eax, eax
    xor edi, edi
   
string:
    xor esi,esi
    mov al, byte [ebx+edi]
    cmp al,0x00
    je final_
    inc edi   
    jmp string
     mov eax ,0
    xor esi , esi
    xor edx , edx
    final_:
  
   xor eax, eax
    xor edx , edx
    xor esi , esi
char_by_char:
    mov dl,byte[ebx]
    sub dl, '0'
    imul eax, 10 
    add eax, edx
    add esi,1
    inc ebx
    cmp esi,edi
    jne char_by_char
    mov ebx , [img] 
    mov esi ,0
   
    verification:
     cmp byte[ecx+esi],0x00
     je final_cuvant
    cmp byte[ecx+esi],65
    je A
    cmp byte[ecx+esi],66
    je B
    cmp byte[ecx+esi],67
    je C
    cmp byte[ecx+esi],68
    je D
    cmp byte[ecx+esi],69
    je E
    cmp byte[ecx+esi],70
    je F
    cmp byte[ecx+esi],71
    je G
    cmp byte[ecx+esi],72
    je H
    cmp byte[ecx+esi],73
    je I
    cmp byte[ecx+esi],74
    je J
    cmp byte[ecx+esi],75
    je K
    cmp byte[ecx+esi],76
    je L
    cmp byte[ecx+esi],77
    je M
    cmp byte[ecx+esi],78
    je N
    cmp byte[ecx+esi],79
    je O
    cmp byte[ecx+esi],80
    je P
    cmp byte[ecx+esi],81
    je Q
    cmp byte[ecx+esi],82
    je R
     cmp byte[ecx+esi],83
    je S
     cmp byte[ecx+esi],84
    je T
     cmp byte[ecx+esi],85
    je U
     cmp byte[ecx+esi],86
    je V
     cmp byte[ecx+esi],87
    je W
     cmp byte[ecx+esi],88
    je X
     cmp byte[ecx+esi],89
    je Y
     cmp byte[ecx+esi],90
    je Z
     cmp byte[ecx+esi],'0'
    je zero_
     cmp byte[ecx+esi],'1'
    je one_
     cmp byte[ecx+esi],'2'
    je two_
     cmp byte[ecx+esi],'3'
    je three_
     cmp byte[ecx+esi],'4'
    je four_
     cmp byte[ecx+esi],'5'
    je five_
     cmp byte[ecx+esi],'6'
    je six_
     cmp byte[ecx+esi],'7'
    je seven_
     cmp byte[ecx+esi],'8'
    je eight_
     cmp byte[ecx+esi],'9'
    je nine_
    cmp byte[ecx+esi],44
    je virgula_
 
   
    
A:
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
B:  
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
C:
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
D:
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
E:
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
F:
     mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],45
    inc eax        
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
G:
     mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],46
    inc eax  
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
H:
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],46
    inc eax        
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
I:
     mov dword[ebx+4*eax],46
    inc eax        
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
J:
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],45
    inc eax        
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
K:  
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],46
    inc eax        
    mov dword[ebx+4*eax],45
    inc eax  
    mov dword[ebx+4*eax],32
    inc eax 
    inc esi
    jmp verification   
L:
      mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],46
    inc eax        
    mov dword[ebx+4*eax],46
    inc eax  
    mov dword[ebx+4*eax],32
    inc eax 
    inc esi
    jmp verification 
M:
     mov dword[ebx+4*eax],45
    inc eax        
    mov dword[ebx+4*eax],45
    inc eax  
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
N:
     mov dword[ebx+4*eax],45
    inc eax        
    mov dword[ebx+4*eax],46
    inc eax   
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification  
O:
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],45
    inc eax        
    mov dword[ebx+4*eax],45
    inc eax    
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
P:
     mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],45
    inc eax        
    mov dword[ebx+4*eax],46
    inc eax  
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification 
Q:
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],46
    inc eax        
    mov dword[ebx+4*eax],45
    inc eax   
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
R:
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],46
    inc eax 
    mov dword[ebx+4*eax],32
    inc eax 
    inc esi
    jmp verification   
S:
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],46
    inc eax 
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
 T: 
    mov dword[ebx+4*eax],45
    inc eax   
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
 U:
     mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],45
    inc eax  
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification 
  V:
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],46
    inc eax        
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
 W:
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],45
    inc eax   
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification     
 X:
     mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],46
    inc eax        
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
  Y:
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],45
    inc eax        
    mov dword[ebx+4*eax],45
    inc eax  
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
  Z:  
     mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],46
    inc eax        
    mov dword[ebx+4*eax],46
    inc eax  
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
  one_:
   mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],45
    inc eax        
    mov dword[ebx+4*eax],45
    inc eax  
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
  two_:
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],45
    inc eax        
    mov dword[ebx+4*eax],45
    inc eax  
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
   three_:
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],46
    inc eax        
    mov dword[ebx+4*eax],45
    inc eax  
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
    four_:
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],46
    inc eax        
    mov dword[ebx+4*eax],46
    inc eax  
    mov dword[ebx+4*eax],45
    inc eax
   mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
    five_:
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],46
    inc eax        
    mov dword[ebx+4*eax],46
    inc eax  
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
    six_:
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],46
    inc eax        
    mov dword[ebx+4*eax],46
    inc eax  
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],32
   inc eax
    inc esi
    jmp verification
    seven_:
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],46
    inc eax        
    mov dword[ebx+4*eax],46
    inc eax  
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],32
   inc eax
    inc esi
    jmp verification
    eight_:
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],45
    inc eax        
    mov dword[ebx+4*eax],46
    inc eax  
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
     nine_:
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],45
    inc eax        
    mov dword[ebx+4*eax],45
    inc eax  
    mov dword[ebx+4*eax],46
    inc eax
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
     zero_:
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],45
    inc eax        
    mov dword[ebx+4*eax],45
    inc eax  
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
    virgula_:
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],46
    inc eax        
    mov dword[ebx+4*eax],46
    inc eax  
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],45
    inc eax
    mov dword[ebx+4*eax],32
    inc eax
    inc esi
    jmp verification
    final_cuvant:
    dec eax
    mov dword[ebx+4*eax],0
    ;inc eax
    jmp afara
 afara:
    push dword [img_height]
    push dword [img_width]
    push dword [img]   
    call print_image
  
    jmp done
solve_task4:
   ; in ebx am numarul
   ;in ecx am textul
    mov ecx , [ebp+12]
    mov ecx , [ecx+12]
    mov ebx , [ebp+12]
    add ebx ,16
    mov ebx , [ebx]
    xor esi , esi
   
     xor edi , edi
 stringg:
    xor esi,esi
    mov al, byte [ebx+edi]
    cmp al,0x00
    je finall_
    inc edi   
    jmp stringg
     mov eax ,0
    xor esi , esi
    xor edx , edx
    finall_:
  
   xor eax, eax
    xor edx , edx
    xor esi , esi
char_by_cchar:
    mov dl,byte[ebx]
    sub dl, '0'
    imul eax, 10 
    add eax, edx
    add esi,1
    inc ebx
    cmp esi,edi
    jne char_by_cchar
   mov ebx ,eax
  ;  mov ecx , [ecx]
   mov eax , [img]
   mov esi , 1
    mov edi , -1
  push edi
  dec ebx
  jmp bit
 

  bit:

    inc edi
   
 ;PRINT_DEC 4 , edi
 mov dl , byte[ecx+edi]
 ;PRINT_CHAR dl
   
   ; cmp edi ,19
   ; je aff
    
    
      until_bit:
   
  ; inc esi
   ;PRINT_DEC 4 , esi
  cmp esi , 9
    je egal
    jne biti
    egal: 
    ;NEWLINE
cmp byte[ecx+edi],0x00
je aff
    mov esi , 1
    jmp bit 
    biti:
    inc esi
  ;  PRINT_DEC 4 , esi
    shl dl ,1
    jc lala
    jnc sala
    
    lala:
    ;  PRINT_CHAR dl
  
   
    or  dword[eax+4*ebx] ,1
   
  inc ebx
   jmp until_bit
   sala:
    
   
    and dword[eax+4*ebx] , 254
  inc ebx
    jmp until_bit
   aff:
   push dword [img_height]
    push dword [img_width]
    push dword [img]   
    call print_image
    jmp done
solve_task5:
    ; TODO Task5
     mov ebx , [ebp+12]
    mov ebx , [ebx+12]
   ; mov ebx , [ebx]
     stringgg:
    xor esi,esi
    mov al, byte [ebx+edi]
    cmp al,0x00
    je finalll_
    inc edi   
    jmp stringgg
     mov eax ,0
    xor esi , esi
    xor edx , edx
    finalll_:
  
   xor eax, eax
    xor edx , edx
    xor esi , esi
char_by_ccChar:
    mov dl,byte[ebx]
    sub dl, '0'
    imul eax, 10 
    add eax, edx
    add esi,1
    inc ebx
    cmp esi,edi
    jne char_by_ccChar
   mov ebx ,eax
    ; in ebx am de unde pornesc 
    mov eax , [img]
    dec ebx
    mov edx , 1
    xor ecx , ecx
    mov esi , 1
    start:
  
      mov edi , 0   
    or edi , dword[eax+4*ebx]
    inc ebx
 
    cmp esi , 9
    je lac
    jne comp
    lac:
   cmp ecx , 0
   je doneee
    sub esi , 8
     PRINT_CHAR  ecx 
    mov edx , 1
    xor ecx , ecx
   
   comp:
     mov edx , 1
     lal:
      push esi
     repet:
     inc esi
    
     repetare:
     imul edx , 2
      cmp esi , 9
     jne repet
     pop esi
     clal:
    inc esi
    shr edi , 1
    jc unu
    jnc doi
    unu:
   ; PRINT_DEC 4,1
    ;NEWLINE
    ;PRINT_STRING "edx = "
    ;PRINT_DEC 4 , edx
    ;NEWLINE
    ;NEWLINE
   
    push eax
    push edi
    mov eax , edx
    xor edx , edx
    mov edi , 2
    idiv edi
    add ecx,eax
    pop edi
    pop eax
   
    jmp start
    doi:
 
    jmp start
    doneee:
    jmp done
solve_task6:
    ; TODO Task6
    jmp done
solve_task7:
    ; TODO Task7
    jmp done

    ; Free the memory allocated for the image.
done:
    push DWORD[img]
    call free_image
    add esp, 4

    ; Epilogue
    ; Do not modify!
    xor eax, eax
    leave
    ret
    