function a = get_correlation(signal,p)
    correlation_vector = zeros(p,1);
    correlation_matrix = zeros(p,p);
    for i =1:p
        
        sum2=0;
    
        for j =1:p
            sum1 =0;
            for n = p+1:length(signal)
               sum1 = sum1+signal(n-j)*signal(n-i);
            end
            correlation_matrix(i,j) = sum1/(length(signal)-p);
        end
    
        for n = p+1:length(signal)
            
            sum2 = sum2 + signal(n)*signal(n-i);
        end
    
        correlation_vector(i) = sum2/(length(signal)-p);
    
    end

    a = correlation_matrix\ correlation_vector;
end