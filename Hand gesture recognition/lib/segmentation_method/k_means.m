function [img_seg] = k_means(img)
    cform = makecform('srgb2lab'); %lab L:Luminosity a:color in red green axis and b "in blue-yellow axis
    lab_he = applycform(img, cform);
    %getting a and b components
    ab = double(lab_he(:,:,2:3));
    nrows = size(ab,1);
    ncols = size(ab,2);
    ab = reshape(ab,nrows*ncols,2);
    n_colors = 2;
    %kmeans is performed 
    cluster_idx = kmeans(ab,n_colors,'distance','sqEuclidean','Replicates',3);
% after kmeans 
    pixel_labels = reshape(cluster_idx,nrows,ncols);
    
    % Structural element
    se = strel('disk',25);
    %Erosion 
    img_erode = imerode(pixel_labels, se);
    img_obr = imreconstruct(img_erode, pixel_labels); %identify the high intensty 
    
    % Dilation 
    img_obrd = imdilate(img_obr, se);
    
    img_obrcbr = imreconstruct(imcomplement(img_obrd),imcomplement(img_obr));
    
    % return segmentated result
    img_seg = imcomplement(img_obrcbr); 
   

end