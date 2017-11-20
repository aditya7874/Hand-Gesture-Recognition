function finger_count = count_fingers( seg_img )
    % This method counts all raised fingers, 
    % returns number 0 - 4
    
    set1 = seg_img(int32(end*0.13):int32(end*0.13), 1:end); %takes a row
    figure; 
    imshow(seg_img);
    
    
    count = 0;
    total_areas = 0;
    good_areas = 0;
    percentage = 0;
    
    for i = 1:size(set1, 2)
        count =  count + set1(1, i);
        
        if set1(1, i) == 0
            percentage = count / size(set1, 2);
            count = 0;
            
            if (0.05 < percentage)
                total_areas = total_areas + 1;
                
                if (0.05 < percentage) && (0.3 > percentage)
                    good_areas = good_areas + 1;
                end
            end

        end
    end
    
    percentage = count / size(set1, 2);
    if (0.05 < percentage) && (0.3 > percentage)
        good_areas = good_areas + 1;
        total_areas = total_areas + 1;
    end
    
    good_areas;
    total_areas;
    
    disp(['Good areas: ',num2str(good_areas)]);
    disp(['Total areas: ',num2str(total_areas)]);
    
    if good_areas == total_areas
        finger_count =  good_areas;
    elseif good_areas == 0 && total_areas == 1
        finger_count = 0;
    else
        finger_count = 0;
   
    disp(['Fingers: ',num2str(finger_count)]);
end

