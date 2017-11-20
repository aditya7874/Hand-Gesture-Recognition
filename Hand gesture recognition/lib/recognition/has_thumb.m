function has_thumb = has_thumb( seg_img )
    %HAS_THUMB Detect if segmentated img has thumb raised
    height = size(seg_img, 1);
    width = size(seg_img, 2);
    %Taking specified right coloum of the segmented image
    set1 = seg_img(int32(end*0.25):int32(end*0.65), int32(end*0.9):int32(end*0.9)); 
    count = 0;
    total_areas = 0;
    good_areas = 0;
    
    percentage = 0;
    
    for i = 1:size(set1, 1)
        count =  count + set1(i, 1);
        
        if set1(i, 1) == 0    
            percentage = count / size(set1, 1);
            count = 0;
            
            if (0.03 < percentage)
                total_areas = total_areas + 1;
                
                if (0.1 < percentage) && (0.35 > percentage)
                    good_areas = good_areas + 1;
                end
            end
        end
    end

    percentage = count / size(set1, 1);
    if (0.03 < percentage)
        total_areas = total_areas + 1;

        if (0.2 < percentage) && (0.35 > percentage)
            good_areas = good_areas + 1;
        end
    end
  
    if total_areas == 1 && good_areas == 1
        has_thumb = 1;
    else
        has_thumb = 0;
    end
    
    disp(['Has thumb: ',num2str(has_thumb)]);
end
