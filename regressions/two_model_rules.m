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
k1 = a1_test\z_train;
k2 = a2_test\z_train;
k3 = a3_test\z_train;
test_weekday = weekday( weekday_idx(uint64(.7*weekday_len)+1:end));
test_time = time( time_idx(uint64(.7*time_len)+1:end));

[test_z,c] = hist3([test_weekday, test_time], [7,48] );

c1_fit = reshape(a1_test * k1, size(x_weekday));
c2_fit = reshape(a2_test * k2, size(x_weekday));
c3_fit = reshape(a3_test * k3, size(x_weekday));
fig = figure('visible','off');
surfl(x_weekday,x_time,c3_fit);
hold on
plot3(x_weekday(:),x_time(:),test_z(:), '.r');
hold on
plot3(x_weekday(:),x_time(:),train_z(:), '.b');
saveas(fig, strcat(figurename,'.png'));
saveas(fig, strcat(figurename,'.fig'));

sse_fun = @(o,p) sum((o(:) - p(:)).^2);
weights = [ k1',k2',k3'];
out_sse =  [ sse_fun( c1_fit,test_z),sse_fun( c2_fit,test_z),sse_fun( c3_fit,test_z) ];
out_perm_time = time_idx;
out_perm_week = weekday_idx;

end