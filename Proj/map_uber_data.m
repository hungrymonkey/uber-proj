%run external script run.m
run
varname = @(x) inputname(1);
uber_data_list = {uber5,uber7,uber8,uber9};
closest_mean_list = {closestMean1,closestMean2,closestMean3,closestMean4};
uber_number = [5,7,8,9];


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
    for j=unique( closest_mean_list{i}')
        cl_mean = closest_mean_list{i};
        hold on;
        geoshow(lat(j==cl_mean),lon(j==cl_mean), 'DisplayType', 'point','MarkerEdgeColor', rand(1,3));
        %wmsread
    end
    saveas(fig, strcat('map_uber', num2str(uber_number(i)),'.png'));
end