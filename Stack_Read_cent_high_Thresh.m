for Date = 181206
for Time = 1301
    
       
%Read in the file    
fname=['C:\Users\Peter Barker\Documents\PCO Data\' num2str(Date) '\' num2str(Time) '.tif'];
info = imfinfo(['C:\Users\Peter Barker\Documents\PCO Data\' num2str(Date) '\' num2str(Time) '.tif']);
num_images = numel(info);
A0 = imread(fname, 1, 'Info', info);
%Set background to 0, based on pixel value
A1 = im2bw(A0,0.017);
%Idnetify areas of hotspots
A1(801:803,102:104)=0;

%Convert in order to add images
A = im2double(A1);

%Find centre of each atom atrrival signal
s=regionprops(A1,'centroid');
centroids = cat(1, s.Centroid);
%Create a new 0 image
A2 = zeros(1040,1392);
%Place a 0 where the centroid of each hit is
A3 = size(centroids);
for i=1:A3(1,1)
    A2(round(centroids(i,2)), round(centroids(i,1))) = 1;
end

%Repeat the above for a new image
for k = 2:num_images
    B0 = imread(fname, k, 'Info', info);
    B1 = im2bw(B0,0.0170);
B1(801:803,102:104)=0;
    B = im2double(B1);
    
  %Create image of centroids, B2
  s=regionprops(B1,'centroid');
  centroids = cat(1, s.Centroid);  
  B2 = zeros(1040,1392);
  B3 = size(centroids);
 for i=1:B3(1,1)
    B2(round(centroids(i,2)), round(centroids(i,1))) = 1;
 end
 
  %Add the two frames
  A = imadd(A,B);
  %Add the two centroid frames
  A2 = double(imadd(A2,B2));
end

Aav1=A/num_images;
Aav2=Aav1.*(Aav1.*60000);
Image=im2uint16(Aav2);
imwrite(Image,['C:\Users\Peter Barker\Documents\PCO Data\' num2str(Date) '\thresh17a' num2str(Time) '.tif']);
imwrite(A2,['C:\Users\Peter Barker\Documents\PCO Data\' num2str(Date) '\thresh17c' num2str(Time) '.tif']);
whitecount = sum(sum(A2))
end
end
