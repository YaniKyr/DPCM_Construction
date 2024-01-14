function y_t = my_quantizer(y,max_val,min_val,centers)
    y = min(max(y,min_val),max_val);

    [~, index] = min(abs(centers - y));

    % Set y_t to the corresponding center value
   
    y_t = centers(index);
   
end
