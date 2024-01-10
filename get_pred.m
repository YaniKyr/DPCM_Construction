function y_tide = get_pred(sig,a,p)

    y_tide = zeros(size(sig));

    for n =1:length(sig)
        if n>p
            for i =1:p
                y_tide(n) = y_tide(n) + (a(i)* sig(n-i));
            end
        else
            y_tide(n) = 0;
    
        end
    end
end
