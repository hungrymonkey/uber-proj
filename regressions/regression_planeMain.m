apr_size = length(dateTime_apr);
may_size = length(dateTime_may);
jun_size = length(dateTime_jun);
jul_size = length(dateTime_jul);
aug_size = length(dateTime_aug);
sep_size = length(dateTime_sep);

may_off = apr_size;
jun_off = may_off + may_size;
jul_off = jun_off + jun_size;
aug_off = jul_off + jul_size;
sep_off = aug_off + aug_size;

apr_clu = closestMean(1:apr_size);
may_clu = closestMean((1:may_size)+may_off);
jun_clu = closestMean((1:jun_size)+jun_off );
jul_clu = closestMean((1:jul_size)+jul_off);
aug_clu = closestMean((1:aug_size)+aug_off);
sep_clu = closestMean((1:sep_size)+sep_off);

ofnames = {'regreesion_apr_3rd','regreesion_may_3rd','regreesion_jun_3rd','regreesion_jul_3rd',...
        'regreesion_aug_3rd','regreesion_sep_3rd'};
    
clusters = {apr_clu, may_clu, jun_clu, jul_clu, aug_clu, sep_clu};
dTime = {dateTime_apr, dateTime_may, dateTime_jun, dateTime_jul, dateTime_aug, dateTime_sep};

for i=1:length(ofnames)
        weekday_data = cellfun(@weekday, dTime{i});
        weekday_hour = cellfun(@hour, dTime{i});
        weekday_minute = cellfun(@minute, dTime{i});

        %figure; hist3([weekday_data, weekday_hour*60+weekday_minute],[7,24] );

        %figure; imagesc(hist3([weekday_data, weekday_hour*60+weekday_minute],[7,24] ));
        time_minutes = weekday_hour*60+weekday_minute;
        clu_num = unique( clusters{i});
        for k = 1:numel(clu_num)
            j = clu_num(k);
            w = weekday_data(clusters{i}==j);
            t_min = time_minutes(clusters{i}==j);
            [weights, out_sse, out_perm_time, out_perm_week] = ...
                two_model_rules(w, t_min, strcat(ofnames{i},'_cl_', num2str(j)) );
            disp(strcat(ofnames{i}, '_cluster: ', num2str(j), 'sse : '));
            disp(out_sse)
%[n,c] = hist3([weekday_data, time_minutes],[7,48] );
%figure;  contour(c{1}, c{2}, n.');
        end
end
%sse output
%1st 2nd 3rd order
%{
regreesion_apr_3rd_cluster:1sse :
   1.0e+05 *

    2.4214    2.4809    2.5090

regreesion_apr_3rd_cluster:2sse :
   1.0e+07 *

    3.0655    3.1979    3.2767

regreesion_apr_3rd_cluster:3sse :
   1.0e+04 *

    1.5407    1.5218    1.5136

regreesion_apr_3rd_cluster:4sse :
   1.0e+07 *

    4.2261    4.3087    4.4056

regreesion_apr_3rd_cluster:5sse :
   1.0e+06 *

    2.0098    2.0573    2.0629

regreesion_apr_3rd_cluster:6sse :
   1.0e+05 *

    1.3761    1.3820    1.4036

regreesion_may_3rd_cluster:1sse :
   1.0e+05 *

    3.9439    4.0290    4.0642

regreesion_may_3rd_cluster:2sse :
   1.0e+07 *

    4.2800    4.4461    4.5405

regreesion_may_3rd_cluster:3sse :
   1.0e+04 *

    2.6486    2.6777    2.6540

regreesion_may_3rd_cluster:4sse :
   1.0e+07 *

    5.4150    5.5137    5.5849

regreesion_may_3rd_cluster:5sse :
   1.0e+06 *

    3.0541    3.1631    3.1936

regreesion_may_3rd_cluster:6sse :
   1.0e+05 *

    2.4275    2.4352    2.4707

regreesion_jun_3rd_cluster:1sse :
   1.0e+05 *

    5.2414    5.3151    5.3367

regreesion_jun_3rd_cluster:2sse :
   1.0e+07 *

    4.0564    4.1862    4.2572

regreesion_jun_3rd_cluster:3sse :
   1.0e+04 *

    3.6959    3.6883    3.7664

regreesion_jun_3rd_cluster:4sse :
   1.0e+07 *

    4.5989    4.6375    4.7032

regreesion_jun_3rd_cluster:5sse :
   1.0e+06 *

    3.1896    3.2760    3.2932

regreesion_jun_3rd_cluster:6sse :
   1.0e+05 *

    2.9871    2.9865    2.9913

regreesion_jul_3rd_cluster:1sse :
   1.0e+05 *

    8.3464    8.4134    8.4702

regreesion_jul_3rd_cluster:2sse :
   1.0e+07 *

    5.5662    5.8080    5.9322

regreesion_jul_3rd_cluster:3sse :
   1.0e+04 *

    3.7195    3.7132    3.7954

regreesion_jul_3rd_cluster:4sse :
   1.0e+07 *

    6.7259    6.8660    7.0401

regreesion_jul_3rd_cluster:5sse :
   1.0e+06 *

    5.7136    5.7555    5.7678

regreesion_jul_3rd_cluster:6sse :
   1.0e+05 *

    4.3429    4.3501    4.3935

regreesion_aug_3rd_cluster:1sse :
   1.0e+06 *

    1.2867    1.3004    1.3071

regreesion_aug_3rd_cluster:2sse :
   1.0e+07 *

    4.7870    4.8786    4.9350

regreesion_aug_3rd_cluster:3sse :
   1.0e+04 *

    4.6517    4.6110    4.6379

regreesion_aug_3rd_cluster:4sse :
   1.0e+07 *

    6.6268    6.6627    6.7564

regreesion_aug_3rd_cluster:5sse :
   1.0e+06 *

    8.9984    9.3332    9.3632

regreesion_aug_3rd_cluster:6sse :
   1.0e+05 *

    5.5457    5.6103    5.6759

regreesion_sep_3rd_cluster:1sse :
   1.0e+06 *

    1.7136    1.7368    1.7604

regreesion_sep_3rd_cluster:2sse :
   1.0e+07 *

    8.0693    8.3206    8.4184

regreesion_sep_3rd_cluster:3sse :
   1.0e+04 *

    6.9498    6.9836    7.1081

regreesion_sep_3rd_cluster:4sse :
   1.0e+08 *

    1.0884    1.0982    1.1203

regreesion_sep_3rd_cluster:5sse :
   1.0e+07 *

    1.1102    1.1238    1.1276

regreesion_sep_3rd_cluster:6sse :
   1.0e+05 *

    6.9956    7.0306    7.0672
%}