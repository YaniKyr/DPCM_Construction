load source.mat 

p = 10;
N = [1,2,3];
sig = t;
signals = [];
count =1;
x = 1:length(sig);
sig1 = sig(1:5000);
sig2 = sig(5001:10000);
sig3 = sig(10001:15000);
sig4 = sig(15001:20000);
calculatron
function calculatron(sigs)
for n = sigs
for i = N
   for j = p
        [~,~,y_hat]=   DPCM(sig,j,i);
        
        temp =y_hat';
        subplot(length(N)*length(p), 1, count);
        
        plot(x,sig,x, temp,Marker='.');
        titleString = ['Simmilarity Plot, N=' num2str(i) ', p=' num2str(j)];
        title(titleString);
        count = count+1;
        
    end
end
end
end
%{
hold on
for n = p
    y = [];
    for i = 1:length(N)
        [a,signal]=   DPCM(sig,n,i);
        y=[y immse(sig,signal)];
        disp(a)
    end 
    
    plot(N,y);
    legendEntries{p_value} = ['p=' num2str(n)];
end
legend(legendEntries);
%}


