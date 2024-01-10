function y_t = my_quantizer(y,N,max_val,min_val)
    y = min(max(y,min_val),max_val);

    cc = get_centers(N,max_val,min_val);
    
    [~, index] = min(abs(cc - y));

    % Set y_t to the corresponding center value
    
    y_t = cc(index);
   
end
