function y_tide = get_pred(sig,n,p,a)
        y_tide =0;
        if n>p
            
            for i =1:p
                y_tide = y_tide + (a(i)* sig(n-i+1));
            end
        else
            y_tide = 0;
    
        end
    
end
