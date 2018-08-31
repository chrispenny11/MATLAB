%% new_bbox.m is a function that produces successive bounding boxes.

function bbnew=new_bbox(bbox, dimensions, max_mov_frame)

bbnew(1)=bbox(1)-max_mov_frame;
bbnew(2)=bbox(2)-max_mov_frame;
bbnew(3)=bbox(3)+2*max_mov_frame;
bbnew(4)=bbox(4)+2*max_mov_frame;
bbnew=floor(bbnew);

if bbnew(1)<1
    bbnew(1)=1;
elseif bbnew(1)>dimensions(2)
    bbnew(1)=dimensions(1)-1.5*max_mov_frame;
end

if bbnew(2)<1
    bbnew(2)=1;
elseif bbnew(2)>dimensions(1)
    bbnew(2)=dimensions(2)-1.5*max_mov_frame;
end

if bbnew(1)+bbnew(3)>dimensions(2)
   bbnew(3)=dimensions(2)-bbnew(1)-2;
end
if bbnew(2)+bbnew(4)>dimensions(1)
   bbnew(4)=dimensions(1)-bbnew(2)-2; 
end

bbnew=floor(bbnew);