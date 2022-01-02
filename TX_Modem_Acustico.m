clc;
clear all;
mensagem='Oi Gustavo';
disp('Mensagem Transmitida: ')
disp(' ')
disp(mensagem)
mensagemReal=real(mensagem);
x=de2bi(mensagemReal,9);
xlinha=x';
xtx=xlinha(:);
y = mls(4,1);
y2 = fliplr(y);
y = y';
y2 = y2';
xtx = [(y+1)./2;xtx];
xtx = [xtx;(y2+1)./2];

fs=11000;
TempoBit=0.1;
t=[0:1/fs:TempoBit];

f1 = 3200;
f2 = 3500;
f3 = 3800;
f4 = 4000;
f5 = 4200;
f6 = 4500;
f7 = 4800;
f8 = 5000;
onda1=cos(2.*pi.*f1.*t);
onda2=cos(2.*pi.*f2.*t);
onda3=cos(2.*pi.*f3.*t);
onda4=cos(2.*pi.*f4.*t);
onda5=cos(2.*pi.*f5.*t);
onda6=cos(2.*pi.*f6.*t);
onda7=cos(2.*pi.*f7.*t);
onda8=cos(2.*pi.*f8.*t);
vec = [];

for i=1:3:length(xtx)-2
    if (xtx(i)==0 && xtx(i+1)== 0 && xtx(i+2) == 0)
       vec=[vec onda1];
    end
    if (xtx(i)==0 && xtx(i+1)== 0 && xtx(i+2) == 1)
           vec=[vec onda2];
    end
    if (xtx(i)==0 && xtx(i+1)== 1 && xtx(i+2) == 0)
           vec=[vec onda3];
    end
    if (xtx(i)==0 && xtx(i+1)== 1 && xtx(i+2) == 1)
           vec=[vec onda4];
    end
    if (xtx(i)==1 && xtx(i+1)== 0 && xtx(i+2) == 0)
           vec=[vec onda5];
    end
    if (xtx(i)==1 && xtx(i+1)== 0 && xtx(i+2) == 1)
           vec=[vec onda6];
    end
    if (xtx(i)==1 && xtx(i+1)== 1 && xtx(i+2) == 0)
           vec=[vec onda7];
    end 
    if (xtx(i)==1 && xtx(i+1)== 1 && xtx(i+2) == 1)
           vec=[vec onda8];
    end
end
sound(vec,fs)