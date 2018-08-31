%% plot_bbox.m is a function designed to demonstrate to the user the automatically determined bounding box.
%This allows user to verify accuracy.
function plot_bbox(bbox,color)

xax=get(gca,'XLim');
yax=get(gca,'YLim');
xmax=round(xax(2));
ymax=round(yax(2));

if bbox(1)<1
    bbox(1)=xax(1);
end
if bbox(2)<1
    bbox(2)=yax(1);
end
if bbox(1)+bbox(3)>xmax
   bbox(3)=xmax;
end
if bbox(2)+bbox(4)>ymax;
   bbox(4)=ymax; 
end

%scatter
scatter(bbox(1), bbox(2),color,'filled') %upper left (lower keft)
scatter(bbox(1)+bbox(3), bbox(2),color,'filled') %upper right (lower right)
scatter(bbox(1), bbox(2)+bbox(4),color,'filled') %lower left (upper left)
scatter(bbox(1)+bbox(3), bbox(2)+bbox(4),color,'filled') %lower right (upper right)
%line
plot([bbox(1) bbox(1)+bbox(3)], [bbox(2)+bbox(4) bbox(2)+bbox(4)],color) %top line
plot([bbox(1) bbox(1)+bbox(3)], [bbox(2) bbox(2)],color) %bottom line
plot([bbox(1) bbox(1)], [bbox(2) bbox(2)+bbox(4)],color) %left line
plot([bbox(1)+bbox(3) bbox(1)+bbox(3)], [bbox(2) bbox(2)+bbox(4)],color)  %right line