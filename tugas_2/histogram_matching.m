
source_img = imread('../img_data/img1.png');
target_img = imread('../img_data/img2.png');


function hist = manual_hist(img)
    max_gray_level= 256;
    hist = zeros(max_gray_level,1);
    for i= 1:numel(img)
      hist(img(i) + 1) = hist(img(i) + 1) + 1;
    endfor
end

if size(source_img,3) == 3
  source = rgb2gray(source_img);
end

if size(target_img,3) == 3
  target = rgb2gray(target_img);
end

% Compute histogram
source_freq = manual_hist(source)
target_freq = manual_hist(target)

intensity = (0:255);

% Histogram Matching
source_cdf = cumsum(source_freq) / numel(source);
target_cdf = cumsum(target_freq) / numel(target);

mapping = zeros(256,1);
for i = 1:256
      [~, idx] = min(abs(source_cdf(i) - target_cdf));
    mapping(i) = idx - 1;
end
matched = mapping(double(source) + 1);
matched = uint8(reshape(matched, size(source)));
matched_freq = manual_hist(matched);

figure

subplot(3,2,1);
imshow(source);
title("Source Image");

subplot(3,2,2)
bar(intensity, source_freq);
xlabel('Pixel Intensity');
ylabel('Frequency');
title('Source Histogram');

subplot(3,2,3)
imshow(target)
title("Target Image")

subplot(3,2,4)
bar(intensity, target_freq);
xlabel('Pixel Intensity');
ylabel('Frequency');
title('Target Histogram');

subplot(3,2,5);
imshow(matched);
title("Matched Image");

subplot(3,2,6);
bar(intensity, matched_freq);
xlabel('Pixel Intensity');
ylabel('Frequency');
title('Matched Histogram');
