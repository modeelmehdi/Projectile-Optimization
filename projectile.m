function [x,y] = projectile(v0,theta,g,t)

x = v0*cosd(theta).*t;

y = v0*sind(theta).*t - 0.5*g*t.^2;

end