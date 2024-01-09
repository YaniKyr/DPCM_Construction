function centers = get_centers(N,max_val,min_val)
    N_d = 2^N;

    step = (max_val-min_val)/ N;

    centers = zeros(1,2^N);
    
    centers(1) = max_val -step/2;

    for i = 2:N_d
        centers(i) = centers(i-1) -step;
    end


end
