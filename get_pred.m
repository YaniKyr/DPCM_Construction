function y_tide = get_pred(sig,n,p)
        y_tide =0;
        if n>p
            a = get_correlation(sig,p);
            
            for i =1:p
                y_tide = y_tide + (a(i)* sig(n-i));
            end
        else
            y_tide = 0;
    
        end
    
end
