function [Crop] = Cropping10(X,Y,Ux, Uy, Uz)
% Plots Z (defined at co-ordinates [X],[Y]) and the associated horizontal
% line defined by lineX and lineY
% Asks for user input to crop a region
close all;                  fig=subplot(1,1,1);
U  = (Ux.^2+Uy.^2).^0.5;
imagesc(X(1,:),Y(:,1),U);   title('1^{st} Z data: Select Area to Crop');  
axis image;                 set(gca,'Ydir','normal');   %axis off;  
colorbar;   %colormap jet;                           
set(gcf,'position',[30 50 1300 950])
xlabel('X [Raw Data Units]');          ylabel('Y [Raw Data Units]');

[Xcrop,Ycrop] = ginput(2);
Xcrop = [min(Xcrop);max(Xcrop)];
Ycrop = [min(Ycrop);max(Ycrop)];
% Xcrop = [4;-1]; Ycrop=[2,-2];
%% Data
xLin          = X(1,:);                     yLin         = Y(:,1); 
[~, Xcrop(1)] = min(abs(xLin-Xcrop(1)));   [~, Xcrop(2)] = min(abs(xLin-Xcrop(2)));         
[~, Ycrop(1)] = min(abs(yLin-Ycrop(1)));   [~, Ycrop(2)] = min(abs(yLin-Ycrop(2)));  
hold on
plot([xLin(Xcrop(1)) xLin(Xcrop(2)) xLin(Xcrop(2)) xLin(Xcrop(1)) xLin(Xcrop(1))],...
     [yLin(Ycrop(1)) yLin(Ycrop(1)) yLin(Ycrop(2)) yLin(Ycrop(2)) yLin(Ycrop(1))],'color','k')
hold off
%% Z data
naro = {'x','y','z'};
for i=1:nargin-2
    eval(sprintf('Crop.U%s = U%s(min(Ycrop):max(Ycrop),min(Xcrop):max(Xcrop));',...
        naro{i},naro{i}));
end

%% XY, steps and stifness
Crop.X   = X(min(Ycrop):max(Ycrop),min(Xcrop):max(Xcrop));
Crop.Y   = Y(min(Ycrop):max(Ycrop),min(Xcrop):max(Xcrop));
Crop.X   = Crop.X - min(min(Crop.X));  	Crop.Y   = Crop.Y - min(min(Crop.Y));
if (Crop.X(1) - Crop.X(end))>0;         Crop.X   = flip(Crop.X,2);         end
if (Crop.Y(1) - Crop.Y(end))>0;         Crop.Y   = flip(Crop.Y,1);         end

%%
close all;              fig = subplot(1,1,1); 
U  = (Crop.Ux.^2+Crop.Uy.^2).^0.5;
imagesc(Crop.X(1,:),Crop.Y(:,1),U)
axis image;             set(gca,'Ydir','normal');   % axis off;  
colormap jet;           colorbar;                            
xlabel('X [Raw Data Units]');          ylabel('Y [Raw Data Units]');
set(gcf,'position',[30 50 1300 950]);    
end