clc;
clear all;

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
nBits = 16;
nChannels = 1;
datatype = 'int16';
ouvir = audiorecorder(fs,nBits,nChannels);
disp('Iniciando Gravação:');
disp(' ');
recordblocking(ouvir,10);
disp('Finalizando Gravação');
disp(' ');
x = getaudiodata(ouvir,'double');
x_f = fftshift(fft(x));
f = linspace(-fs/2,fs/2,length(x));
fpf = 1.*(abs(f)<5100 & abs(f)>3100);
x_filter = x_f.*fpf';
x_fpf = ifft(fftshift(x_filter));
x = real(x_fpf);

y = mls(4,1);
y2 = fliplr(y);
y = y';
y2 = y2';
g = (y+1)./2;
g2 = (y2+1)./2;
vec11 = [];
vec22 = [];
 for i=1:3:length(g)-2
    if (g(i)==0 && g(i+1)== 0 && g(i+2) == 0)
        vec11=[vec11 onda1];
    end
    if (g(i)==0 && g(i+1)== 0 && g(i+2) == 1)
            vec11=[vec11 onda2];
    end
    if (g(i)==0 && g(i+1)== 1 && g(i+2) == 0)
            vec11=[vec11 onda3];
    end
    if (g(i)==0 && g(i+1)== 1 && g(i+2) == 1)
           vec11=[vec11 onda4];
    end
    if (g(i)==1 && g(i+1)== 0 && g(i+2) == 0)
           vec11=[vec11 onda5];
    end
    if (g(i)==1 && g(i+1)== 0 && g(i+2) == 1)
           vec11=[vec11 onda6];
    end
    if (g(i)==1 && g(i+1)== 1 && g(i+2) == 0)
           vec11=[vec11 onda7];
    end 
    if (g(i)==1 && g(i+1)== 1 && g(i+2) == 1)
           vec11=[vec11 onda8];
    end
 end

 for i=1:3:length(g2)-2
    if (g2(i)==0 && g2(i+1)== 0 && g2(i+2) == 0)
        vec22=[vec22 onda1];
    end
    if (g2(i)==0 && g2(i+1)== 0 && g2(i+2) == 1)
        vec22=[vec22 onda2];
    end
    if (g2(i)==0 && g2(i+1)== 1 && g2(i+2) == 0)
        vec22=[vec22 onda3];
    end
    if (g2(i)==0 && g2(i+1)== 1 && g2(i+2) == 1)
        vec22=[vec22 onda4];
    end
    if (g2(i)==1 && g2(i+1)== 0 && g2(i+2) == 0)
        vec22=[vec22 onda5];
    end
    if (g2(i)==1 && g2(i+1)== 0 && g2(i+2) == 1)
        vec22=[vec22 onda6];
    end
    if (g2(i)==1 && g2(i+1)== 1 && g2(i+2) == 0)
        vec22=[vec22 onda7];
    end 
    if (g2(i)==1 && g2(i+1)== 1 && g2(i+2) == 1)
        vec22=[vec22 onda8];
    end
 end

[h1,lag1] = xcorr(vec11,x);
[h2,lag2] = xcorr(vec22,x);

[~,I] = max(abs(h1));
[~,I2] = max(abs(h2));

Inic = -1*lag1(I);
Ifim = -1*lag1(I2);

vec = x(Inic+1:Ifim+length(vec22));

demu = [];
k = 1;
for i=1:length(t):(round(length(vec)/length(t))-1)*length(t)
vec1 = conv(onda1,vec(i:k*length(t)));

vec2 = conv(onda2,vec(i:k*length(t)));

vec3 = conv(onda3,vec(i:k*length(t)));

vec4 = conv(onda4,vec(i:k*length(t)));

vec5 = conv(onda5,vec(i:k*length(t)));

vec6 = conv(onda6,vec(i:k*length(t)));

vec7 = conv(onda7,vec(i:k*length(t)));

vec8 = conv(onda8,vec(i:k*length(t)));

fil = [norm(vec1) norm(vec2) norm(vec3) norm(vec4) norm(vec5) ...
    norm(vec6) norm(vec7) norm(vec8)];
[~,id] = max(fil);
demu = [demu id];
k = k + 1;
end
ytx = zeros((3*round(length(vec)/length(t))),1);
j = 0;
for i=1:3:3*length(demu)
if demu(i-j) == 1
    ytx(i) = 0;
    ytx(i+1) = 0;
    ytx(i+2) = 0;
end
if demu(i-j) == 2
    ytx(i) = 0;
    ytx(i+1) = 0;
    ytx(i+2) = 1;
end
if demu(i-j) == 3
    ytx(i) = 0;
    ytx(i+1) = 1;
    ytx(i+2) = 0;
end
if demu(i-j) == 4
    ytx(i) = 0;
    ytx(i+1) = 1;
    ytx(i+2) = 1;
end
if demu(i-j) == 5
    ytx(i) = 1;
    ytx(i+1) = 0;
    ytx(i+2) = 0;
end
if demu(i-j) == 6
    ytx(i) = 1;
    ytx(i+1) = 0;
    ytx(i+2) = 1;
end
if demu(i-j) == 7
    ytx(i) = 1;
    ytx(i+1) = 1;
    ytx(i+2) = 0;
end
if demu(i-j) == 8
    ytx(i) = 1;
    ytx(i+1) = 1;
    ytx(i+2) = 1;
end
j = j + 2;
end
ytx2 = ytx(length(y)+1:length(ytx)-length(y));
as = reshape(ytx2,[9,length(ytx2)/9]);
as = as';
msgasc = bi2de(as);
msg = char(msgasc)';
disp('A Mensagem Recebida é: ');
disp(' ');
disp(msg)
