function [best_angle,max_range] = optimize_angle(v0,g)

angles = 1:0.1:89;

ranges = (v0.^2 .* sind(2*angles))/g;

[max_range,index] = max(ranges);

best_angle = angles(index);

end