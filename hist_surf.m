weekday_data = cellfun(@weekday, pickup_time);
weekday_hour = cellfun(@hour, pickup_time);
weekday_minute = cellfun(@minute, pickup_time);

%figure; hist3([weekday_data, weekday_hour*60+weekday_minute],[7,24] );

%figure; imagesc(hist3([weekday_data, weekday_hour*60+weekday_minute],[7,24] ));

figure; surf(hist3([weekday_data, weekday_hour*60+weekday_minute],[7,48] ));
