function result_img = background_manager(img)
    %function find out if backround is black, if not, switch hand and 
    %background color.
    
    %constant how far from edge get color
    control_padding_const = 10;
    [n,m] = size(img);
    imgMin = min(min(img));
   
    img = img - imgMin;
    
    %detection background color - look at color in corners and make
    %decision by avarage color
    sum = 0;
    sum = sum + img(control_padding_const,control_padding_const);
    sum = sum + img(n - control_padding_const,m - control_padding_const);
    sum = sum + img(control_padding_const,m - control_padding_const);
    sum = sum + img(n - control_padding_const,control_padding_const);
    
    %switch colors if needed
    if(sum > 2)
       img = imcomplement(img);
    end
    result_img = img; %return result
end