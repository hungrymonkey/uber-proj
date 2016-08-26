%% 7 points
function [] = reignItIn(result,k)

x=[5;7;8;9];
%figure;
for i=1:k
    figure(i);
    %subplot(1,k,i);
    y = result(:,i)
    scatter(x,y,200,'filled');
    hold on
    %xlim([3 9]);
    %ylim([-10 40]);
    %set(gca,'fontsize',20);

    x_test = 3:.1:10;
    x_test = x_test'; %make it a column vector

    %% 1st order
    A1=[x ones(length(x),1)];
    w1=A1\y;
    A1_test = [x_test ones(length(x_test),1)];
    y1_test = A1_test*w1;
    hold on
    plot(x_test,y1_test,'k','linewidth',2);

    y_hat1 = A1*w1;
    sse1 = sum((y_hat1-y).^2);

    legend('Data',sprintf('SSE1= %d',round(sse1)),'location','SouthEast');

    %% 3rd order
    A3=[x.^3 x.^2 x ones(length(x),1)];
    w3=A3\y;
    A3_test = [x_test.^3 x_test.^2 x_test ones(length(x_test),1)];
    y3_test = A3_test*w3;
    hold on
    plot(x_test,y3_test,'r','linewidth',2);

    y_hat3 = A3*w3;
    sse3 = sum((y_hat3-y).^2);

    legend('Data',sprintf('SSE1= %d',round(sse1)),sprintf('SSE3= %d',round(sse3)),'location','SouthEast');


    %% 6th order
    A6=[x.^6 x.^5 x.^4 x.^3 x.^2 x ones(length(x),1)];
    w6=A6\y;
    A6_test = [x_test.^6 x_test.^5 x_test.^4 x_test.^3 x_test.^2 x_test ones(length(x_test),1)];
    y6_test = A6_test*w6;
    plot(x_test,y6_test,'g','linewidth',2);

    y_hat6 = A6*w6;
    sse6 = sum((y_hat6-y).^2);

    legend('Data',sprintf('SSE1= %d',round(sse1)),sprintf('SSE3= %d',round(sse3)),...
        sprintf('SSE6= %d',round(sse6)),'location','SouthEast');
end
% legend('Data','1st order fit','3rd order fit','6th order fit');