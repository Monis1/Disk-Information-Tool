.386

.model flat,stdcall 

option casemap:none 
include \masm32\include\masm32rt.inc 

.data 

consoleOutHandle dd ? 
consoleInHandle dd ?
prompt db "*****************************DISK INFORMATION TOOL******************************",0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah
byteswritten dw ?
space db "                         "
msg0 db 'W',"    "
msg1 db 'E',"    "
msg2 db 'L',"    "
msg3 db 'C',"    "
msg4 db 'O',"    "
msg5 db 'M',"    "
msg6 db 'E',"    ",0ah,0ah,0ah
prompt1 db "Press Enter to continue..."
lpbuffer db 2 dup(' ')
NumberOfCharsRead dw ?
character dd " "
prompt2 db 0ah,"Enter Drive number(1=A,2=B,3=C...)="
SectorsPerCluster dd ?
BytesPerSector dd ?
NumberOfFreeClusters dd ?
TotalNumberOfClusters dd ?
RootPathName db 3 dup ('$')
string db 20 dup(' ')
gb real4 1024.0
prompt3 db 0ah,"Drive Not Present...."
prompt4 db 0ah,"Sectors per Cluster="
prompt5 db 0ah,"Bytes per Sector="
prompt6 db 0ah,"Free Clusters on drive="
prompt7 db 0ah,"Total number of clusters on drive="
prompt8 db 0ah,"ERROR=Invalid Input....Enter Again="
prompt9 db 0ah,"Total Space in gb="
prompt10 db 0ah,"Free Space in gb="
bytesingb dq ?
freebytesingb dq ?
spc real4 512.0
bps real4 8.0
prompt11 db 0ah,0ah,"Program will exit in...","         "
prompt12 db 1 dup(' '),"    "
prompt13 db 0ah,0ah,"Press any key to exit..."
prompt14 db 0ah,"Drive="
.code 

writestring proc
invoke GetStdHandle,STD_OUTPUT_HANDLE
mov consoleOutHandle,eax
mov eax,ebx
pushad
 invoke WriteConsoleA,consoleOutHandle,edx,eax,offset byteswritten,0
 popad
 ret
writestring endp


read proc
invoke GetStdHandle,STD_INPUT_HANDLE
mov consoleInHandle,eax
pushad
mov eax,ebx
invoke ReadConsole,consoleInHandle,edx,eax,offset NumberOfCharsRead,0
popad
ret
read endp

diskinfo proc
mov edx,offset prompt14
mov ebx,lengthof prompt14
call writestring
mov edx,offset RootPathName
mov ebx,lengthof RootPathName
call writestring
mov edx,offset prompt4
mov ebx,lengthof prompt4
call writestring
mov eax,SectorsPerCluster
invoke dwtoa,eax,addr string
mov edx,offset string
mov ebx,lengthof string
call writestring
mov edx,offset prompt5
mov ebx,lengthof prompt5
call writestring
mov eax,BytesPerSector
invoke dwtoa,eax,addr string
mov edx,offset string
mov ebx,lengthof string
call writestring
mov edx,offset prompt6
mov ebx,lengthof prompt6
call writestring
mov eax,NumberOfFreeClusters
invoke dwtoa,eax,addr string
mov edx,offset string
mov ebx,lengthof string
call writestring
mov edx,offset prompt7
mov ebx,lengthof prompt7
call writestring
mov eax,TotalNumberOfClusters
invoke dwtoa,eax,addr string
mov edx,offset string
mov ebx,lengthof string
call writestring
ret
diskinfo endp

diskcapacity proc
fild TotalNumberOfClusters
fdiv gb
fmul spc 
fmul bps
fdiv gb
fdiv gb
 fst bytesingb
invoke FloatToStr,bytesingb,addr string
mov edx,offset prompt9
mov bx,lengthof prompt9
call writestring
mov edx,offset string
mov ebx,lengthof string
call writestring
fild NumberOfFreeClusters
fdiv gb
fmul spc 
fmul bps
fdiv gb
fdiv gb
 fst freebytesingb
invoke FloatToStr,freebytesingb,addr string
mov edx,offset prompt10
mov bx,lengthof prompt10
call writestring
mov edx,offset string
mov ebx,lengthof string
call writestring
ret
diskcapacity endp

main proc

mov edx,offset prompt
mov ebx,lengthof prompt
call writestring

mov edx,offset space
mov ebx,lengthof space
call writestring

mov eax,0
mov eax,500
invoke Sleep,eax

mov edx,offset msg0
mov ebx,lengthof msg0
call writestring
mov eax,0
mov eax,500
invoke Sleep,eax


mov edx,offset msg1
mov ebx,lengthof msg1
call writestring
mov eax,0
mov eax,500
invoke Sleep,eax

mov edx,offset msg2
mov ebx,lengthof msg2
call writestring
mov eax,0
mov eax,500
invoke Sleep,eax

mov edx,offset msg3
mov ebx,lengthof msg3
call writestring
mov eax,0
mov eax,500
invoke Sleep,eax

mov edx,offset msg4
mov ebx,lengthof msg4
call writestring
mov eax,0
mov eax,500
invoke Sleep,eax

mov edx,offset msg5
mov ebx,lengthof msg5
call writestring
mov eax,0
mov eax,500
invoke Sleep,eax

mov edx,offset msg6
mov ebx,lengthof msg6
call writestring
mov eax,0
mov eax,500
invoke Sleep,eax

mov edx,offset prompt1
mov ebx,lengthof prompt1
call writestring


mov edx,offset lpbuffer
mov ebx,lengthof lpbuffer
call read 
invoke GetStdHandle,STD_INPUT_HANDLE
mov consoleInHandle,eax
invoke FlushConsoleInputBuffer,consoleInHandle

invoke GetStdHandle,STD_OUTPUT_HANDLE
mov consoleOutHandle,eax
mov eax,1000
mov edx,character
invoke FillConsoleOutputCharacter,consoleOutHandle,edx,eax,0,offset byteswritten

invoke GetStdHandle,STD_OUTPUT_HANDLE
mov consoleOutHandle,eax
mov edx,offset prompt
mov eax,lengthof prompt
sub eax,8
invoke WriteConsoleOutputCharacter,consoleOutHandle,edx,eax,0,offset byteswritten



mov edx,offset prompt2
mov ebx,lengthof prompt2
call writestring


up:

invoke GetStdHandle,STD_INPUT_HANDLE
mov consoleInHandle,eax
invoke FlushConsoleInputBuffer,consoleInHandle

mov edx,offset lpbuffer
mov ebx,lengthof lpbuffer
call read
mov eax,0
invoke atodw,offset lpbuffer

cmp eax,2520
je l1
cmp eax,2620
je l2
cmp eax,2720
je l3
cmp eax,2820
je l4
cmp eax,2920
je l5
cmp eax,3020
je l6
cmp eax,3120
je l7
cmp eax,3220
je l8
cmp eax,3320
je l9
cmp eax,310
je l10
cmp eax,320
je l11
cmp eax,330
je l12
cmp eax,340
je l13
cmp eax,350
je l14
cmp eax,360
je l15
cmp eax,370
je l16
cmp eax,380
je l17
cmp eax,390
je l18
cmp eax,400
je l19
cmp eax,410
je l20
cmp eax,420
je l21
cmp eax,430
je l22
cmp eax,440
je l23
cmp eax,450
je l24
cmp eax,460
je l25
cmp eax,470
je l26

jmp el




l1:
mov si,0
mov dl,'A'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin1
call diskinfo
call diskcapacity
jmp outer
lin1:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

l2:
mov si,0
mov dl,'B'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin2
call diskinfo
call diskcapacity
jmp outer
lin2:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

l3:
mov si,0
mov dl,'C'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin3
call diskinfo
call diskcapacity
jmp outer
lin3:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

l4:
mov si,0
mov dl,'D'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin4
call diskinfo
call diskcapacity

jmp outer
lin4:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

l5:
mov si,0
mov dl,'E'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin5
call diskinfo
call diskcapacity

jmp outer
lin5:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

l6:
mov si,0
mov dl,'F'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin6
call diskinfo
call diskcapacity

jmp outer
lin6:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

l7:
mov si,0
mov dl,'G'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin7
call diskinfo
call diskcapacity

jmp outer
lin7:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

l8:
mov si,0
mov dl,'H'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin8
call diskinfo
call diskcapacity

jmp outer
lin8:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

l9:
mov si,0
mov dl,'I'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin9
call diskinfo
call diskcapacity

jmp outer
lin9:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

l10:
mov si,0
mov dl,'J'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin10
call diskinfo
call diskcapacity

jmp outer
lin10:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

l11:
mov si,0
mov dl,'K'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin11
call diskinfo
call diskcapacity

jmp outer
lin11:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

l12:
mov si,0
mov dl,'L'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin12
call diskinfo
call diskcapacity

jmp outer
lin12:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

l13:
mov si,0
mov dl,'M'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin13
call diskinfo
call diskcapacity

jmp outer
lin13:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

l14:
mov si,0
mov dl,'N'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin14
call diskinfo
call diskcapacity

jmp outer
lin14:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

l15:
mov si,0
mov dl,'O'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin15
call diskinfo
call diskcapacity

jmp outer
lin15:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

l16:
mov si,0
mov dl,'P'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin16
call diskinfo
call diskcapacity

jmp outer
lin16:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

l17:
mov si,0
mov dl,'Q'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin17
call diskinfo
call diskcapacity

jmp outer
lin17:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

l18:
mov si,0
mov dl,'R'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin18
call diskinfo
call diskcapacity

jmp outer
lin18:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

l19:
mov si,0
mov dl,'S'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin19
call diskinfo
call diskcapacity

jmp outer
lin19:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

l20:
mov si,0
mov dl,'T'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin20
call diskinfo
call diskcapacity

jmp outer
lin20:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

l21:
mov si,0
mov dl,'U'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin21
call diskinfo
call diskcapacity

jmp outer
lin21:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

l22:
mov si,0
mov dl,'V'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin22
call diskinfo
call diskcapacity

jmp outer
lin22:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

l23:
mov si,0
mov dl,'W'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin23
call diskinfo
call diskcapacity

jmp outer
lin23:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

l24:
mov si,0
mov dl,'X'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin24
call diskinfo
call diskcapacity

jmp outer
lin24:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

l25:
mov si,0
mov dl,'Y'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin25
call diskinfo
call diskcapacity

jmp outer
lin25:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

l26:
mov si,0
mov dl,'Z'
mov RootPathName[si],dl
inc si
mov dl,':'
mov RootPathName[si],dl
inc si
mov dl,"\"
mov RootPathName[si],dl
mov edx,offset RootPathName
mov eax,0
invoke GetDiskFreeSpace,edx,offset SectorsPerCluster,offset BytesPerSector,offset NumberOfFreeClusters,offset TotalNumberOfClusters
cmp eax,0
je lin26
call diskinfo
call diskcapacity

jmp outer
lin26:
mov edx,offset prompt3
mov ebx,lengthof prompt3
call writestring
jmp up

el:

mov edx,offset prompt8
mov ebx,lengthof prompt8
call writestring
jmp up

outer:
mov edx,offset prompt13
mov ebx,lengthof prompt13
call writestring
invoke GetStdHandle,STD_INPUT_HANDLE
mov consoleInHandle,eax
mov edx,offset lpbuffer
mov eax,lengthof lpbuffer
invoke ReadConsoleInput,consoleInHandle,edx,eax,offset NumberOfCharsRead
mov edx,offset prompt11
mov ebx,lengthof prompt11
call writestring
mov dl,'3'
mov prompt12,dl
mov edx,offset prompt12
mov ebx,lengthof prompt12
call writestring
mov eax,0
mov eax,1000
invoke Sleep,eax
mov dl,'2'
mov prompt12,dl
mov edx,offset prompt12
mov ebx,lengthof prompt12
call writestring
mov eax,0
mov eax,1000
invoke Sleep,eax
mov dl,'1'
mov prompt12,dl
mov edx,offset prompt12
mov ebx,lengthof prompt12
call writestring
invoke ExitProcess,0
main endp
end main