clear;
file_id = fopen('uber-raw-data-jul14.csv'); 
outfile_name = 'uber_data_grouped_jul.mat';
data_header =  textscan( file_id, '%s %s %s %s',1,'Delimiter', ',');

uber_data =  textscan( file_id, '%s %f %f %s', 50000,'Delimiter', ',' );

remove_quotes = @(x) strrep(x, '"','');

str_datetime = cellfun(@(x)(strsplit(remove_quotes(x))), uber_data{1}(:), 'UniformOutput', false );
data_header = cellfun(remove_quotes, [data_header  'Group' 'MeanLoc'],'UniformOutput', false);
time_str = cellfun(@(x)(x{2}), str_datetime, 'UniformOutput', false);
date_str = cellfun(@(x)(x{1}), str_datetime, 'UniformOutput', false );
str2datetime = @(x) (datetime(x, 'InputFormat', '"M/dd/yyyy HH:mm:ss"'));

pickup_time = cellfun(str2datetime, uber_data{1}(:), 'UniformOutput', false );


pickup_data.header = data_header;
pickup_data.datetimeData = pickup_time;
pickup_data.lat = uber_data{2}(:);
pickup_data.lon = uber_data{3}(:);
pickup_data.dateData = date_str;
pickup_data.timeData = time_str;

[pickup_data.closestMean, pickup_data.meanLocs, nIters ] = huang_shuo_clusterKMeans([pickup_data.lat pickup_data.lon], 5, 100);
pickup_data.minuteData = time2min(pickup_data.timeData);
save(outfile_name, '-struct','pickup_data' );