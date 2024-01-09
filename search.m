function out = search(y,cc,start,stop)
    median = round((stop-start)/2);
    disp(median)
    if median==64
        out = cc(median);
        
    elseif cc(median)>= y
        
        search(y,cc,start,median)
    elseif cc(median) <y
        search(y,cc,median,stop)
    end
    
end