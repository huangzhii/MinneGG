% Greenhat
close all; clear all; clc;
%%
%To detect Face
FDetect = vision.CascadeObjectDetector;
%Read the input image
I = imread('face3.jpg');
hat = imread('greenhat.png');
%Returns Bounding Box values based on number of objects
BB = step(FDetect,I);
%BB(1): bonding box's upper left x coordinate
%BB(2): bonding box's upper left y coordinate
%BB(3) = BB(4): bonding box's size
scale_h = 1;
scale_w = 1.5;
hat = imresize(hat, [BB(3)*scale_h BB(3)*scale_w]);
[h, w, c] = size(I);
h_h = h; h_w = w;
dh = ceil(BB(2)-0.5*scale_h*BB(3)); % delta height
dw = ceil(BB(1)-0.5*(scale_w-1)*BB(3)); % delta width
% if the hat's edge excess the image
if dh < 0
    h_h = h - dh;
end
if dw < 0
    h_w = w - dw;
end
% To add green hat
if 1
hatmask = zeros(h_h, h_w ,c);
hatmask(h_h - h + dh + 1 : ceil(h_h - h + dh + scale_h * BB(3)), h_w - w + dw + 1 : ceil((h_w - w + dw) + scale_w * BB(3)), :, :) = hat;
%figure
%imshow(hatmask);
hatmask_2 = uint8(hatmask(h_h-h+1 :h_h, h_w-w+1 :h_w, :));
hat_screen = hatmask_2(:,:,1) + hatmask_2(:,:,2) + hatmask_2(:,:,3);
Ihat = I - hat_screen*255; 
Ihat = Ihat + hatmask_2;
figure
imshow(Ihat)
end
%% This part shows the bonding box
if 1 %show it or not
figure
imshow(I); hold on
for i = 1:size(BB,1)
    rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
end
title('Face Detection');
hold off;
end