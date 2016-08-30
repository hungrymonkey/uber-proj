weekday_data = cellfun(@weekday, pickup_time);
weekday_hour = cellfun(@hour, pickup_time);
weekday_minute = cellfun(@minute, pickup_time);

%figure; hist3([weekday_data, weekday_hour*60+weekday_minute],[7,24] );

%figure; imagesc(hist3([weekday_data, weekday_hour*60+weekday_minute],[7,24] ));
time_minutes = weekday_hour*60+weekday_minute;


[weights, out_sse, out_perm_time, out_perm_week] = two_model_rules(weekday_data, time_minutes );
%[n,c] = hist3([weekday_data, time_minutes],[7,48] );
%figure;  contour(c{1}, c{2}, n.');


%sse output
%1st 2nd 3rd order
%[201506925.523622,205388143.156732,208944328.498217]