load source.mat 

signal = t;
p=10;

quantized_sig = zeros(size(signal));

for i = 1:quantized_sig
    quantized_sig(i) = my_quantizer(signal(i),8,3.5,-3.5);
end

a = get_correlation(signal,p);

y_tide = get_pred(quantized_sig,a);

y = signal - y_tide;

for i = 1:quantized_sig
    quantized_sig(i) = my_quantizer(y(i),8,3.5,-3.5);
end