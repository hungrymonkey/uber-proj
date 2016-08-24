file_id = fopen('uber-raw-data-apr14.csv');
OSM_url = 'http://geoint.nrlssc.navy.mil/osm/wms/OSM/basemap/Mapnik/OSM_BASEMAP?';
new_york_centroid = [40.6639206199602, -73.9383529238219];
%% centroid obtained from https://www.maptechnica.com/city-map/New+York/NY/3651000
map_database = 'Open Street Map';
%map_limits.lat = [new_york_centroid(1)-.4,new_york_centroid(1)+.4];
%map_limits.lon = [new_york_centroid(2)-.6,new_york_centroid(2)+.6];

data_title =  textscan( file_id,'%s %s %s %s',1,'Delimiter', ',');
uber_data =  textscan( file_id,'%s %f %f %s',7500,'Delimiter', ',');
lat = uber_data{2};
lon = uber_data{3};

map_limits.lat = [min(lat),max(lat)];
map_limits.lon = [min(lon),max(lon)];


%layers = wmsfind('osm*basemap','Latlim',map_limits.lat, 'Lonlim', map_limits.lon);
%poi_map = layers.refine('poi', 'SearchField', 'layertitle');
wms = wmsinfo(OSM_url);
layer = wms.Layer(1);
%layer = layers;
fig = figure;
%usamap(map_limits.lat, map_limits.lon);      % limit to New York area
[A,R] = wmsread(layer,'Latlim',map_limits.lat, 'Lonlim', map_limits.lon);
geoshow(A,R);
hold on;
geoshow(lat,lon, 'DisplayType', 'point');
%wmsread
fclose(file_id);
