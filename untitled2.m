
function a = train_predictor (X , p )
    N = length ( X ) ;
    R = zeros (p , p ) ;
    r = zeros (p , 1) ;
% Compute the elements of R and r
    for i = 1: p
        for j = 1: p
            sum_idx = ( p +1) :( N - max (i , j ) +1) ;
            R (i , j ) = sum ( X ( sum_idx ) .* X ( sum_idx +i - j ) ) / (N - p ) ;
        end
    r ( i ) = sum ( X (( p +1) :( N - i ) ) .* X (( p +1+ i ) : N ) ) / (N - p ) ;
    end
    disp(R)
    a = R \ r ;
end