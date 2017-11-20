function result_img = segmentate(img)
    % This function returns segmentated and cropped image.
    
    %Run segmentation algorithm 
    img2 = k_means(img);
    
    %Switch backround to black and hand to white color if needed
    img2 = background_manager(img2);
   
    s = regionprops(img2,'FilledImage'); %returns an image with filled holes and cropping the image 
    img2 = s.FilledImage;

    % Return result
    result_img = img2;
end
