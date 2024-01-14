img = imread("parrot.png"); 
% Read an image

% Convert the image to a column vector
img_vector = img(:);

tabulated_data = tabulate(img_vector);

% tabulated data returns counts and propability (%)
unique_pixel_values = tabulated_data(:, 1);
pixel_counts = tabulated_data(:, 2);
pixel_probabilities = pixel_counts / sum(pixel_counts);

%figure;
%bar(unique_pixel_values, pixel_probabilities);
%title('Pixel Value Probability Distribution');
%xlabel('Pixel Value');
%ylabel('Probability');

%huffenco
dict = huffmandict(unique_pixel_values,pixel_probabilities);


entropy= -sum(pixel_probabilities.*log2(pixel_probabilities));

avglength = sum(cellfun(@length, dict(:,2)) .* pixel_probabilities);

h = entropy/avglength;



keys = [];
values = [];


%@@@@@@@@@@@ FIX THIS @@@@@@@@@@@@@@@@@@@@
for i = 1:length(unique_pixel_values)
    for j = 1:length(unique_pixel_values)
        newString = strcat(int2str(unique_pixel_values(i)), int2str(unique_pixel_values(j)));
        keys = [keys, {newString}];
        values = [values pixel_probabilities(i)* pixel_probabilities(j)];
    end
end

tdict = huffmandict(keys,values);
tentropy= -sum(values.*log2(values));

tavglength = sum(cellfun(@length, tdict(:,2))' .* values);

th = tentropy/tavglength;

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


%mutual information
