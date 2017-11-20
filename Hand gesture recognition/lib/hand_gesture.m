function [letter] = hand_gesture(seg_img)
    % This function uses segmentated image to find letter
    % updated dimensions after crop
    
    letter = '.';
    
    count = count_fingers(seg_img); %returns total number of fingers(0,1,2,3)
    
    if has_thumb(seg_img) && count < 2   %has thumb returns 1 if it has thumb
        if has_little_finger(seg_img)    %has little finger returns 1 if it has little finger.
            letter = 'Y';
        else
            letter = 'L';
        end
    else
        if count == 1
            letter = 'I';
        elseif count == 2
            letter = 'V';
        elseif count == 3
            letter = 'W';
        elseif count == 0
            if hand_raised(seg_img)         %returns 1 if hand is raised
                letter = 'B';
            else
                letter = 'A';
            end
        end
    end
    
    disp(['Letter: ',letter]);
    
    
end