function [a,y,y_hat_not] = DPCM(signal,p,N)

%@@@@@@@@@@@@@@@@@@@@@@@@@
%@@@@@@@ init-vars @@@@@@@
%@@@@@@@@@@@@@@@@@@@@@@@@@



max_val =3.5;
min_val = -3.5;
a = get_correlation(signal,p);

y_hat_not = [];
memory = zeros(size(signal));
y_hat = zeros(size(signal));
y_tide = 0;
centers = get_centers(N,min_val,max_val);

%@@@@@@@@@@@@@@@@@@@@@@@@
%@@@@@@@ encoding @@@@@@@
%@@@@@@@@@@@@@@@@@@@@@@@@

for n = 1: length(signal)

        y = signal(n) - y_tide;
        y_hat_not =[y_hat_not y];
        y_hat(n) = my_quantizer(y,max_val,min_val,centers);
        memory(n) = y_hat(n) +  y_tide;
        
        y_tide = get_pred(memory,n,p,a);
end


%@@@@@@@@@@@@@@@@@@@@@@@@
%@@@@@@@ decoding @@@@@@@
%@@@@@@@@@@@@@@@@@@@@@@@@



x_hat = zeros(size(signal));
x_tide = 0;

for n = 1: length(signal)
       x_hat(n) = y_hat(n)+  x_tide;
       x_tide = get_pred(x_hat,n,p,a);  
end


y=x_hat;

end

