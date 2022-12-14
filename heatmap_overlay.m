% img = image on which to overlay heatmap
% heatmap = the heatmap
% (optional) colorfunc .. this can be 'jet' , or 'hot' , or 'flag'
function omap = heatmap_overlay(img ,heatmap, colorfun)

% if (ischar(class(img))) 
%     img = imread(img); 
% end
% if (ischar(class(img))) 
%     img = double(img)/255; 
% end

szh = size(heatmap);
szi = size(img);

% had black surrounding around heatmap in beginning, changed to 'bilinear'
% -> black pixel outline was gone
if (szh(1))~=szi(1) || (szh(2)~=szi(2) )
  heatmap = imresize( heatmap , [szi(1) szi(2)] , 'bilinear' );
end
  
if ( size(img,3) == 1 )
  img = repmat(img,[1 1 3]);
end
  
if ( nargin == 2 )
    colorfun = 'jet';
end
colorfunc = eval(sprintf('%s(50)',colorfun));

heatmap = double(heatmap) / max(heatmap(:));
omap = 0.8*(1-repmat(heatmap.^0.8,[1 1 3])).*double(img)/max(double(img(:))) + repmat(heatmap.^0.8,[1 1 3]).* shiftdim(reshape( interp2(1:3,1:50,colorfunc,1:3,1+49*reshape( heatmap , [ numel(heatmap)  1 ] ))',[ 3 size(heatmap) ]),1);
omap = real(omap);
end 
