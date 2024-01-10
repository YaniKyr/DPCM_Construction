load source.mat 

signal = t;
p=5;

max_val =3.5;
min_val = -3.5;

N=8;
memory= zeros(size(signal));
y_hat_not = zeros(size(signal));
y_hat = zeros(size(signal));
y = zeros(size(signal));
y_tide = zeros(size(signal));
for n = 1: length(signal)
        disp(n)
     if n>1
         
        y(n) = signal(n) - y_tide(n-1);
     else
         y(n) = signal(n);
     end
    y_hat(n) = my_quantizer(y(n),N,max_val,min_val);
   
    if memory == zeros(size(signal))
        y_hat_not(n) = y_hat(n);
        memory(n) = y_hat_not(n);
        y_tide(n) = get_pred(memory,n,p);

        
    else
       
        y_hat_not(n) = y_hat(n) +  y_tide(n-1);
        memory(n) = y_hat_not(n);
        y_tide(n) = get_pred(memory,n,p);
        
    end
    
end


x = 1:length(signal);
plot(x,signal,x,y_hat,op);
