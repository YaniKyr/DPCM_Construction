function y_tide = get_pred(sig,a)
    y_tide = zeros(1,length(sig));
    for n =1:length(sig)
        if n>p
            for i =1:p
                y_tide = y_tide + a(i)* sig(n-i);
            end
        else
            y_tide = signal(n);
    
        end
    end
end
