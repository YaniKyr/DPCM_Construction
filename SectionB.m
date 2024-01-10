load source.mat 

signal = t;
p=5;


a = get_correlation(signal,p);

y_tide = get_pred(signal,a,p);
y = zeros(size(y_tide));
for i =2:length(y_tide)
    y(i) = signal(i) - y_tide(i-1);
end


quantized_err= zeros(size(signal));

for i = 1:size(quantized_err)
    quantized_err(i) = my_quantizer(y(i),3,3.5,-3.5);
end



x = 1:length(signal);
plot(x,signal,x,quantized_err,Marker=".")


abb = get_correlation(quantized_err,p);

x_tide_not = get_pred(quantized_err,abb,p);
x_tide = zeros(size(x_tide_not));
for i =2:length(y_tide)
    x_tide(i) = x_tide_not(i-1) + quantized_err(i);
end



sound(signal)
sound(x_tide)
plot(x,signal,x,x_tide,Marker=".")