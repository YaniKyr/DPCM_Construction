load source.mat 

signal = t;
p=8;

max_val =3.5;
min_val = -3.5;
a = get_correlation(signal,p);

N=3;
memory = zeros(size(signal));
y_hat = zeros(size(signal));
y_tide = 0;
centers = GetCenters(N,min_val,max_val);

for n = 1: length(signal)
    if mod(n,1000)==0
        disp("Encoded Round:")
        disp(n)
    end
    
   
         
        y(n) = signal(n) - y_tide;
        y_hat(n) = my_quantizer1(y(n),N,min_val,max_val,centers);
        memory(n) = y_hat(n) +  y_tide;
        
        y_tide = get_pred(memory,n,p,a);
end

%@@@@@@@decoding
memory = zeros(size(signal));
x_hat = zeros(size(signal));
x_tide = 0;

for n = 1: length(signal)
    if mod(n,1000)==0
        disp("Decoded Round:")
        disp(n)
    end
        
       x_hat(n) = y_hat(n)+  x_tide;
        x_tide = get_pred(x_hat,n,p,a);
        
       

end
x= 1:length(signal);
plot(x,signal,x,x_hat,Marker=".")


figure;

% Original Signal
subplot(3, 1, 1);
plot(signal,Marker='.');
title('Original Signal');

% Encoded-Original Difference
subplot(4, 1, 2);
plot(x,signal,x,y_hat,Marker='.');
title('Encoded - Original');

% Decoded Signal
subplot(4, 1, 3);
plot(x,signal,x,x_hat,Marker='.');
title('Decoded-Original Signal');