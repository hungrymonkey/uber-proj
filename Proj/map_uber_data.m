%run external script run.m
run
varname = @(x) inputname(1);
uber_data_list = {uber4,uber5,uber6,uber7,uber8,uber9};
uber_number = 4:9;


OSM_url = 'http://geoint.nrlssc.navy.mil/osm/wms/OSM/basemap/Mapnik/OSM_BASEMAP?';
new_york_centroid = [40.6639206199602, -73.9383529238219];
%% centroid obtained from https://www.maptechnica.com/city-map/New+York/NY/3651000
map_database = 'Open Street Map';
%map_limits.lat = [new_york_centroid(1)-.4,new_york_centroid(1)+.4];
%map_limits.lon = [new_york_centroid(2)-.6,new_york_centroid(2)+.6];
for i=1:length(uber_data_list)
    lat_long = uber_data_list{i};
    lat = table2array(lat_long(:,1));
    lon = table2array(lat_long(:,2));

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
    
    saveas(fig, strcat('map_uber', num2str(uber_number(i)),'.png'));
end