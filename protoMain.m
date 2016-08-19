file_id = fopen('uber-raw-data-jun14.csv');
map_database = 'Open Street Map';
map_limits.lat = [39.4,41.7];
map_limits.lon = [-75,-73];

data_title =  textscan( file_id,'%s %s %s %s',1,'Delimiter', ',');
uber_data =  textscan( file_id,'%s %f %f %s','Delimiter', ',');

fig = figure
usamap(map_limits.lat, map_limits.lon);      % limit to New York area
wmsread
fclose(file_id);
