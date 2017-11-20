function has_little = has_little_finger( seg_img )
    %HAS_LITTLE_FINGER This function decides whether hand on image has
    % little finger raised
    %   Detailed explanation goes here

    set1 = seg_img(int32(end*0.1):int32(end*0.1), 1:end); %takes a row
    count = 0;
    total_areas = 0;
    good_areas = 0;
    percentage = 0;
    
    for i = 1:size(set1, 2)
        count =  count + set1(1, i);
        
        if set1(1, i) == 0
            percentage = count / size(set1, 2);
            count = 0;
            
            if (0.03 < percentage)
                total_areas = total_areas + 1;
                
                if (0.05 < percentage) && (0.2 > percentage) && (i < size(set1, 2)*0.2)
                    good_areas = good_areas + 1;
                end
            end
        end
    end
    
    if (0.03 < percentage)
        total_areas = total_areas + 1;
    end
    
    if total_areas == 1 && good_areas == 1
        has_little = 1;
    else
        has_little = 0;
    end
    
    disp(['Has little finger: ',num2str(has_little)]);
end

