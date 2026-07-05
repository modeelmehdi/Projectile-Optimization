clc;
clear;
close all;

v0 = input('Enter Initial Velocity (m/s): ');
theta = input('Enter Launch Angle (degrees): ');

g = 9.81;

T = (2*v0*sind(theta))/g;

t = linspace(0,T,100);

[x_actual,y_actual] = projectile(v0,theta,g,t);

t_sample = linspace(0,T,8);

[x_sample,y_sample] = projectile(v0,theta,g,t_sample);

y_forward = newton_forward(t_sample,y_sample,t);

y_backward = newton_backward(t_sample,y_sample,t);

y_divided = divided_difference(t_sample,y_sample,t);

y_lagrange = lagrange_interp(t_sample,y_sample,t);

x_interp = v0*cosd(theta).*t;

Hmax = (v0^2*(sind(theta))^2)/(2*g);

Range = (v0^2*sind(2*theta))/g;

[best_angle,max_range] = optimize_angle(v0,g);

fprintf('\n');
fprintf('Maximum Height = %.2f m\n',Hmax);
fprintf('Range = %.2f m\n',Range);
fprintf('Time of Flight = %.2f s\n',T);
fprintf('Optimal Angle = %.2f Degrees\n',best_angle);
fprintf('Maximum Possible Range = %.2f m\n',max_range);

figure;
plot(x_actual,y_actual,'k','LineWidth',3);
grid on;
xlabel('Distance (m)');
ylabel('Height (m)');
title('Actual Projectile Trajectory');

figure;
plot(x_actual,y_actual,'k','LineWidth',2);
hold on;
plot(x_interp,y_forward,'r--','LineWidth',2);
scatter(x_sample,y_sample,80,'filled');
grid on;
legend('Actual','Newton Forward','Sample Points');
title('Newton Forward Interpolation');

figure;
plot(x_actual,y_actual,'k','LineWidth',2);
hold on;
plot(x_interp,y_backward,'b--','LineWidth',2);
scatter(x_sample,y_sample,80,'filled');
grid on;
legend('Actual','Newton Backward','Sample Points');
title('Newton Backward Interpolation');

figure;
plot(x_actual,y_actual,'k','LineWidth',2);
hold on;
plot(x_interp,y_divided,'g--','LineWidth',2);
scatter(x_sample,y_sample,80,'filled');
grid on;
legend('Actual','Divided Difference','Sample Points');
title('Newton Divided Difference');

figure;
plot(x_actual,y_actual,'k','LineWidth',2);
hold on;
plot(x_interp,y_lagrange,'m--','LineWidth',2);
scatter(x_sample,y_sample,80,'filled');
grid on;
legend('Actual','Lagrange','Sample Points');
title('Lagrange Interpolation');

err1 = mean(abs(y_actual-y_forward));
err2 = mean(abs(y_actual-y_backward));
err3 = mean(abs(y_actual-y_divided));
err4 = mean(abs(y_actual-y_lagrange));

errors = [err1 err2 err3 err4];

figure;
bar(errors);
set(gca,'XTickLabel',{'Forward','Backward','Divided','Lagrange'});
ylabel('Mean Error');
title('Interpolation Error Comparison');
grid on;

angles = 1:1:89;

ranges = (v0^2*sind(2*angles))/g;

figure;
plot(angles,ranges,'LineWidth',3);
grid on;
xlabel('Launch Angle (Degrees)');
ylabel('Range (m)');
title('Projectile Range vs Launch Angle');