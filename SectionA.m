img = imread("parrot.png"); 
% Read an image

% Convert the image to a column vector
img_vector = img(:);

tabulated_data = tabulate(img_vector);

unique_pixel_values = tabulated_data(:, 1);
pixel_counts = tabulated_data(:, 2);
pixel_probabilities = pixel_counts / sum(pixel_counts);

figure;
bar(unique_pixel_values, pixel_probabilities);
title('Pixel Value Probability Distribution');
xlabel('Pixel Value');
ylabel('Probability');
disp(unique_pixel_values)
disp(pixel_probabilities)
%huffenco
dict = huffmandict(unique_pixel_values,pixel_probabilities);


entropy= -sum(pixel_probabilities.*log2(pixel_probabilities));

avglength = sum(cellfun(@length, dict(:,2)) .* pixel_probabilities);

h = entropy/avglength;

%2

myMap = containers.Map('KeyType', 'int32', 'ValueType', 'double');


% Iterate through img_vector
for i = 1:length(img_vector)-1
    newString = str2num(strcat(int2str(img_vector(i)), int2str(img_vector(i+1))));
    
    % Check if newString already exists in the map
    if isKey(myMap, newString)
        % Increment the count for existing key
        myMap(newString) = myMap(newString) + 1;
    else
        % Add a new key with count initialized to 1
        myMap(newString) = 1;
    end
end


keys = cell2mat(myMap.keys);
for i = 1:myMap.Count
    key = keys(i);
    myMap(key) = myMap(key) / length(img_vector);
end

values = cell2mat(myMap.values);
probabilities = values / sum(values);


tdict = huffmandict(keys,probabilities);


tentropy= -sum(probabilities.*log2(probabilities));

tavglength = sum(cellfun(@length, tdict(:,2))' .* probabilities);

th = tentropy/tavglength;

disp('Entropy =')
disp(tentropy)
disp('Code Length =')
disp(tavglength)
disp('H =')
disp(th)


%q 4
enco = huffmanenco(img_vector,dict);
deco = huffmandeco(enco,dict);
isequal(img_vector,deco)

bI = reshape((dec2bin(typecast(img_vector,'uint8'),4)-'0').',1,[]);
J = length(enco)/length(bI);


figure;
imshow(img);
title('Orginal Image')

DecodedImage = uint8(reshape(deco, [200, 150]));
figure;
imshow(DecodedImage);
title('Decoded Image')

%5
y = binary_symmetric_channel(enco);

vec = y==enco;

data = tabulate(vec);

counts = data(:, 3);
p = counts{2} /100;

ChannelSpan = 1-(-p*log2(p)-(1-p)*log2(1-p));



