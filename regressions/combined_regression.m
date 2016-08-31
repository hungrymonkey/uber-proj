week_t_cell = cell(6,1);
week_d_cell = cell(6,1);

dTime = {dateTime_apr, dateTime_may, dateTime_jun, dateTime_jul, dateTime_aug, dateTime_sep};

for i=1:length(week_t_cell)
    weekday_data = cellfun(@weekday, dTime{i});
    weekday_hour = cellfun(@hour, dTime{i});
    weekday_minute = cellfun(@minute, dTime{i});

    week_t_cell{i} = weekday_hour*60+weekday_minute;
    week_d_cell{i} =  cellfun(@weekday, dTime{i});
end

weekday_day = [week_d_cell{1};week_d_cell{2};week_d_cell{3};week_d_cell{4};week_d_cell{5};week_d_cell{6}];
weekday_time = [week_t_cell{1};week_t_cell{2};week_t_cell{3};week_t_cell{4};week_t_cell{5};week_t_cell{6}];

%{

out sse cluster:3
   1.0e+06 *

    1.2113    1.2172    1.2342

out sse cluster:4
   1.0e+09 *

    2.2045    2.2305    2.2657

%}
%sse values for all points

for i=3:4
    w = weekday_day(closestMean==i);
    t_min = weekday_time(closestMean==i);
    [weights, out_sse, out_perm_time, out_perm_week] = ...
                two_model_rules(w, t_min, strcat('regression_all','_cl_', num2str(i)) );
    disp(strcat( 'out sse cluster: ', num2str(i)));
    disp(out_sse);
end



