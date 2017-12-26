% Greenhat
close all; clear all; clc;
%%
%To detect Face
FDetect = vision.CascadeObjectDetector;

%Read the input image
I = imread('lenna.jpeg');
hat = imread('greenhat.png');
%Returns Bounding Box values based on number of objects
BB = step(FDetect,I);

hat = imresize(hat, [BB(3) BB(3)*2]);
[h, w, c] = size(I);
h_h = h; h_w = w;
dh = ceil(BB(1)-0.5*BB(3));
dw = ceil(BB(2)-0.75*BB(3));
% if the hat's edge excess the image
if dh < 0
    h_h = h - dh;
end
if dw < 0
    h_w = h-dw;
end

hatmask = zeros(h_h, h_w ,c);
hatmask(h_h-h+dh+1 : h_h-h+dh + BB(3), (h_w - w + dw)+1 : (h_w - w + dw)+2*BB(3), :, :) = hat;
imshow(hatmask);
hatmask_2 = uint8(hatmask(h_h-h+1 :h_h, h_w-w+1 :h_w, :));
Ihat = I + hatmask_2.*2;
imshow(Ihat)

%%
figure
imshow(I); hold on
for i = 1:size(BB,1)
    rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
end
title('Face Detection');
hold off;