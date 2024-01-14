load source.mat 

signal = t;
p=10;

max_val =3.5;
min_val = -3.5;

N=16;
memory= zeros(size(signal));
y_hat = zeros(size(signal));
y_tide = 0;
centers = get_centers(N,max_val,min_val);


for n = 1: length(signal)
    if mod(n,1000)==0
        disp("Encoded Round:")
        disp(n)
    end
    
     if n>1
         
        y(n) = signal(n) - y_tide;
        y_hat(n) = my_quantizer(y(n),max_val,min_val,centers);
        memory(n) = y_hat(n) +  y_tide;
        y_tide = get_pred(memory,n,p);
     else
         y(n) = signal(n);
         y_hat(n) = my_quantizer(y(n),max_val,min_val,centers);
         memory(n) = y_hat(n);
        y_tide = get_pred(memory,n,p);
     end
    
end

%@@@@@@@decoding
x_hat = zeros(size(signal));
x_tide = zeros(size(signal));

for n = 1: length(signal)
    if mod(n,1000)==0
        disp("Decoded Round:")
        disp(n)
    end
    if n>1
        x_hat(n) = y_hat(n) +  x_tide(n-1);
        x_tide(n) = get_pred(x_hat,n,p);
    else
        x_hat(n) = y_hat(n);
        
    end
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