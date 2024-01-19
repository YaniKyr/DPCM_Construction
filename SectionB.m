load source.mat 

p = 10;
N = [1,2,3];
sig = t;
signals = [];


%graphs(sig,N,p);


sig1 = sig(1:5000);
sig2 = sig(5001:10000);
sig3 = sig(10001:15000);
sig4 = sig(15001:20000);
tgraph = [sig1,sig2,sig3,sig4];
graphs(tgraph,sig,N,p);
%mceCacl(sig,sig,p,N);

%mceCacl(tgraph,sig,p,N);


function graphs(sig,signal,N,p)
x = 1:length(signal);
    count =1;
    
   for i = N
       for j = p
           temp_sig = [];
           for n =1: length(sig(1,:))
            [~,~,y]=   DPCM(sig(:,n),j,i);
            temp_sig= [temp_sig y];
           end
           disp(size(temp_sig))
            temp =  temp_sig;
            subplot(length(N)*length(p), 1, count);
           
            plot(x,signal,x, temp,Marker='.');
            titleString = ['Simmilarity Plot, N=' num2str(i) ', p=' num2str(j)];
            title(titleString);
            count = count+1;
            
        end
    end
end
function mceCacl(sig,signal, p,N)
    hold on
    p_value = 0;
    for j = p
       
        msey=[];
        for i = 1:length(N)
            temp_sig = [];
            for n = 1:length(sig(1,:))
                
            [a,y,~]=   DPCM(sig(:,n),j,i);
            %disp(a)
            temp_sig= [temp_sig ;y];
            end
            
            msey=[msey immse(signal,temp_sig)];
            
        end
        disp(msey)
        p_value = p_value+1;
        plot(N,msey);
        legendEntries{p_value} = ['p=' num2str(j)];
    end
    legend(legendEntries);


end