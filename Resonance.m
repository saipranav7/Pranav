clc;
clear all;
close all;
fs=5000;
fm=100;
n=10;
t=(0:1/fs:1/fm)';
y=sin(2*pi*fm*t*n);
plot(t,y);
figure;
stem(y);
%Ploting the Sampled Signal.
figure(2); 
stem(y);
title('Sampled signal');
xlabel('time');
ylabel('amplitude');

%Quantization 
n1=3;
L=2^n1;
Xmax=2;
Xmin=-2;
del=(Xmax-Xmin)/L;
partition=Xmin:del:Xmax;
codebook=Xmin-(del/2):del:Xmax+(del/2);
[index,quants]=quantiz(y,partition,codebook);

%Ploting the Quantized Signal.
figure(3);
stem(quants);
title('quantized signal');
xlabel('Time');
ylabel('Amplitude');

%Encoding
l1=length(index);
for i=1:l1
if(index(i)~=0)
index(i)=index(i)-1;
end
end

%normalization
l2=length(quants);
for i=1:l2
    if (quants(i)==Xmax-del/2)
        quants(i)=Xmax+del/2;
    end
    if (quants(i)==Xmax+del/2)
        quants(i)=Xmax-del/2;
    end
end

code=de2bi(index,'left-msb');

k=1;
for i=1:l1
    for j=1:n1
        coded(k)=code(i,j);
        j=j+1;
        k=k+1;
    end
    i=i+1;
end

%Ploting the Encoded Signal
figure(4);
stairs(coded);
title('encoded signal');
xlabel('n');
ylabel('amplitude');

%Decoding
index1=bi2de(code,'left-msb');
de_signal=(del*index1)+Xmin+(del/2);

%Ploting the Decoded Signal
figure(5);
plot(de_signal);
title('demodulated signal');
xlabel('n');
ylabel('amplitude');