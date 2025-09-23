source_img = imread('../img_data/img1.png');

function hist = manual_hist(img)
    max_gray_level = 256;
    hist = zeros(max_gray_level, 1);
    for i=1:numel(img)
        hist(img(i) + 1) = hist(img(i) + 1) + 1;
    end
end

if size(source_img, 3) == 3
    source = rgb2gray(source_img);
end

%Compute Histogram
source_freq = manual_hist(source)

intensity = (0:255);

%Histogram Equalization
pdf = source_freq / numel(source);
source_cdf = cumsum(pdf);

mapping = uint8(255 * source_cdf);
eq_img = zeros(size(source), 'uint8');
for i = 1:numel(source)
    eq_img(i) = mapping(source(i) + 1);
end

eq_hist = manual_hist(eq_img);

figure;
subplot(2,2,1);
imshow(source);
title("Source Image");

subplot(2,2,2);
imshow(eq_img);
title("Equalized Image");

subplot(2,2,3);
bar(intensity, source_freq);
title('Source Histogram');

subplot(2,2,4);
bar(intensity, eq_hist);
title('Equalized Histogram');
