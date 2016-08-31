function [weights, out_sse, out_perm_time, out_perm_week] = two_model_rules(weekday,time, figurename)
rng(149);

number_weekdays = 7;
ntime_bins = 48;
time_len = length(time);
weekday_len = length(weekday);

time_idx = randperm(time_len);
weekday_idx = time_idx;

train_weekday = weekday( weekday_idx(1:uint64(.7*weekday_len)));
train_time = time( time_idx(1:uint64(.7*time_len)));
[train_z,c] = hist3([train_weekday, train_time],[number_weekdays,ntime_bins] );

[x_weekday,x_time] = meshgrid(1:ntime_bins,1:number_weekdays);

x_ = x_weekday(:);
y_ = x_time(:);
z_train = train_z(:);
a1_test = [ ones(size(x_)), x_, y_];
a2_test = [ ones(size(x_)), x_, y_,...
    x_.^2, y_.*x_, y_.^2];
a3_test = [ ones(length(x_) ,1), x_, y_.^2,...
     x_.^2, y_.*x_, y_.^2, ...
     x_.^3, (x_.^2).*y_, x_.*(y_.^2), y_.^3 ];
 
a4_test = [ ones(length(x_) ,1), x_, y_.^2,...
     x_.^2, y_.*x_, y_.^2, ...
     x_.^3, (x_.^2).*y_, x_.*(y_.^2), y_.^3,...
     x_.^4, (x_.^3).*y_, (x_.^2).*y_.^2, x_.*y_.^3,  y_.^4];
a5_test = [ ones(length(x_) ,1), x_, y_.^2,...
     x_.^2, y_.*x_, y_.^2, ...
     x_.^3, (x_.^2).*y_, x_.*(y_.^2), y_.^3,...
     x_.^4, (x_.^3).*y_, (x_.^2).*y_.^2, x_.*y_.^3,  y_.^4,...
     x_.^5, (x_.^4).*y_, (x_.^3).*y_.^2, (x_.^2).*y_.^3, x_.*y_.^4,  y_.^5];
a6_test = [ ones(length(x_) ,1), x_, y_.^2,...
     x_.^2, y_.*x_, y_.^2, ...
     x_.^3, (x_.^2).*y_, x_.*(y_.^2), y_.^3,...
     x_.^4, (x_.^3).*y_, (x_.^2).*y_.^2, x_.*y_.^3,  y_.^4,...
     x_.^5, (x_.^4).*y_, (x_.^3).*y_.^2, (x_.^2).*y_.^3, x_.*y_.^4,  y_.^5, ...
     x_.^6, (x_.^5).*y_, (x_.^4).*y_.^2, (x_.^3).*y_.^3, (x_.^2).*(y_.^4), x_.*(y_.^5),  y_.^6];
k1 = a1_test\z_train;
k2 = a2_test\z_train;
k3 = a3_test\z_train;
k4 = a4_test\z_train;
k5 = a5_test\z_train;
k6 = a6_test\z_train;

test_weekday = weekday( weekday_idx(uint64(.7*weekday_len)+1:end));
test_time = time( time_idx(uint64(.7*time_len)+1:end));

[test_z,c] = hist3([test_weekday, test_time], [7,48] );

c1_fit = reshape(a1_test * k1, size(x_weekday));
c2_fit = reshape(a2_test * k2, size(x_weekday));
c3_fit = reshape(a3_test * k3, size(x_weekday));
c4_fit = reshape(a4_test * k4, size(x_weekday));
c5_fit = reshape(a5_test * k5, size(x_weekday));
c6_fit = reshape(a6_test * k6, size(x_weekday));

fig = figure('visible','off');
surfl(x_weekday,x_time,c4_fit);
hold on
plot3(x_weekday(:),x_time(:),test_z(:), '.r');
hold on
plot3(x_weekday(:),x_time(:),train_z(:), '.b');
saveas(fig, strcat(figurename,'_4th_','.png'));
saveas(fig, strcat(figurename,'_4th_','.fig'));

fig = figure('visible','off');
surfl(x_weekday,x_time,c5_fit);
hold on
plot3(x_weekday(:),x_time(:),test_z(:), '.r');
hold on
plot3(x_weekday(:),x_time(:),train_z(:), '.b');
saveas(fig, strcat(figurename,'_5th_','.png'));
saveas(fig, strcat(figurename,'_5th_','.fig'));

fig = figure('visible','off');
surfl(x_weekday,x_time,c6_fit);
hold on
plot3(x_weekday(:),x_time(:),test_z(:), '.r');
hold on
plot3(x_weekday(:),x_time(:),train_z(:), '.b');
saveas(fig, strcat(figurename,'_6th_','.png'));
saveas(fig, strcat(figurename,'_6th_','.fig'));

sse_fun = @(o,p) sum((o(:) - p(:)).^2);
weights = [ k1',k2',k3',k4',k5',k6'];
out_sse =  [ sse_fun( c1_fit,test_z),sse_fun( c2_fit,test_z),...
    sse_fun( c3_fit,test_z),sse_fun( c4_fit,test_z),sse_fun( c5_fit,test_z),sse_fun( c6_fit,test_z) ];
out_perm_time = time_idx;
out_perm_week = weekday_idx;

end