%include "/home/cosmin/Desktop/skel/includes/io.inc"

extern getAST
extern freeAST

section .bss
    ; La aceasta adresa, scheletul stocheaza radacina arborelui
    root: resd 1

section .text
global main

atoiForPositives:
    push ebp
    mov ebp, esp
    
    ; extrag argumentul funcției ( adresa de început a șirului )
    mov ebx, [ebp + 8]
    
    ; salvez adresa șirului deoarece am nevoie să calculez lungimea șirului,
    ; iar în acest proces adresa de început a șirului se pierde
    push ebx
    
    ; pentru stocări intermediare
    xor eax, eax
    
    ; pentru lungimea șirului
    xor ecx, ecx 

loopString:
    mov al, byte [ebx]
    test al, al
    jz outStringLoop
    inc ecx
    inc ebx
    
    jmp loopString
    
    outStringLoop:
    
    ; restaurez adresa de început a șirului
    pop ebx
    
    ; pentru stocări intermediare
    xor edx, edx
    
    ; pentru rezultatul numeric
    xor eax, eax

    ; în ecx am salvată lungimea șirului
loopString2:

    ; parcurg sirul caracter cu caracter 
    mov dl, byte [ebx]
    
    ; fac conversia din tabelul ascii
    sub dl, 48
    
    ; adun cifra
    add eax, edx
    
    ; ca acest algoritm de conversie să funcționeze, am grijă ca
    ; ultimul caracter din șir să nu fie înmulțit cu 10, deoarece
    ; el reprezintă cifra unităților
    
    cmp ecx,1
    jle doNotImul
    
    ; se înmulțește numărul curent cu 10
    imul eax, 10 
    
    ; merg la următorul caracter
    inc ebx
    loop loopString2
    
    ; când s-a ajuns aici, a fost adăugată și ultima cifră, iar numarul
    ; rezultat este complet. Loop-ul s-a oprit când ecx era 1, deoarece
    ; oricum ultimul caracter din string era terminatorul de șir
    doNotImul:    
    
    leave
    
    ; returnez valoarea numerică șirului ( salvată în registrul eax )
    ret


atoi:
    push ebp
    mov ebp, esp
    
    ; extrag argumentul funcției, adresa de început a șirului ce urmează
    ; a fi convertit
    mov ebx, [ebp + 8]
    
    ; pun primul caracter în registrul dl
    xor edx, edx
    mov dl, byte [ebx]
    
    ; verific dacă primul caracter este '-' ( minus e)
    sub dl, 0x2D ;test for '-'
    jz negativeNumber
    
    ;Numar pozitiv
    push ebx
    call atoiForPositives
    add esp, 4
    
    leave
    ret ;returnez rezultatul (salvat în registrul eax)
    
    
    ;Număr negativ
negativeNumber:   
    inc ebx; sar peste '-'
    
    ; si calculez valoarea numerica a sirului
    push ebx
    call atoiForPositives
    add esp, 4
    
    ; fac numarul negativ
    not eax
    inc eax
    
    leave
    ret ; returnez rezultatul(salvat in registrul eax)


recTree:
    push ebp
    mov ebp, esp
    
    ; salvam in memorie argumentul functiei ( adresa nodului curent ) 
    mov ebx, [ebp + 8]
    
    
    ; verificăm dacă nodul curent este frunză ( nu are noduri copil )
    cmp dword [ebx + 4], 0
    jz getLeaf
    
    ; salvez adresa nodului curent pe stivă deoarece voi folosi registrul ebx
    ; pentru alte operații de-a lungul execuției programului
    push ebx
    
    ; setez ca argument pentru următoarea execuție a funcției recTree adresa
    ; nodului din stânga
    push dword [ebx + 4]
    call recTree
    add esp, 4
    
    ; restaurez adresa nodului curent de pe stivă, pentru a putea apela funcția
    ; recTree pentru nodul din dreapta
    pop ebx
    
    ; salvez din nou adresa nodului curent, deoarece registrul ebx este folosit
    ; în interiorul apelulu funcției recTree pentru nodul din dreapta
    push ebx
    
    ; în registrul eax, momentan, se află valoarea întoarsă de apelul funcției
    ; recTree pe nodul din stânga
    ; o salvez pe stivă, deoarece funcția recTree apelată pentru nodul din dreapta
    ; va întoarce valoarea tot în registrul eax
    push eax; save eax
    
    ; apelez funcția recTree pentru nodul din dreapta al nodului curent
    push dword [ebx + 8]
    call recTree
    add esp, 4
    
    ; restaurez de pe stivă rezultatul apelului funcției recTree pentru nodul din stânga
    pop edx;
    
    ; restaurez adresa nodului curent de pe stivă
    pop ebx
    
    ; pun în registrul ecx, adresa stringului din nodul curent
    mov ecx, [ebx]
    
    ; valoarea din primul subarbore in edx
    ; valoarea din al doilea subarbore in eax
    push eax
    mov eax, edx
    pop edx
    ; le interschimb
    
    cmp byte [ecx], '+'
    je addThem
    
    cmp byte [ecx], '-'
    je subtractThem
    
    cmp byte [ecx], '/'
    je divideThem
    
    cmp byte [ecx], '*'
    je multiplyThem

addThem:
    add eax, edx
    
    leave
    ret

subtractThem:
    sub eax, edx
       
    leave
    ret

divideThem:
    mov ecx, edx
    cdq
    idiv ecx
    
    leave
    ret

multiplyThem:
    imul eax, edx
    
    leave
    ret

getLeaf:
    ; in frunze se află valori numerice sub formă de șiruri de caractere
    ; fac conversia cu funcția atoi
    push dword [ebx]
    call atoi
    add esp, 4
    
    leave
    ret

main:
    mov ebp, esp; for correct debugging
    ; NU MODIFICATI
    push ebp
    mov ebp, esp
    
    ; Se citeste arborele si se scrie la adresa indicata mai sus
    call getAST
    mov [root], eax
    
    ; Implementati rezolvarea aici:    
    
    push dword [root]; punem pe stiva adresa primului nod din arbore
    call recTree
    add esp, 4
    
    PRINT_DEC 4, eax ; afisam rezultatul functiei
    
    ; NU MODIFICATI
    ; Se elibereaza memoria alocata pentru arbore
    push dword [root]
    call freeAST
    
    xor eax, eax
    leave
    ret