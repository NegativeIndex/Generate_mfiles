clc
clear all
close all

%%
nm=1e-9;
data=load('TRA_data.txt');
data=sortrows(data,get_index_from_name('nr'));
%% Reflection
figx=[100,600,25];
figy=[75,450,25];
figure('position',[2280,160,sum(figx),sum(figy)])

hold on
xdata=data(:,get_index_from_name('nr'));
ydata=data(:,get_index_from_name('absp'));
plot(xdata,ydata,'r-','linewidth',3)

hold off
box on
axis([00,20,0,1]) %copynew
% legend(legs,'location','nw',...
%     'fontsize',16,'interpreter','latex');
set(gca,'position',...
    [figx(1)/sum(figx),figy(1)/sum(figy),figx(2)/sum(figx),figy(2)/sum(figy)]);
set(gca,'fontsize',16)
xlabel('Wavelength (nm)',...
    'fontsize',24,'interpreter','latex')
ylabel('Absorptance',...
    'fontsize',24,'interpreter','latex')
figname=sprintf('Absorption_NR.png');
print('-dpng',figname);


%%
%copyold_begin
function v=get_index_from_name(var)
switch var
    case 'wl';        v=1;
    case 'a';         v=2;
    case 'd';         v=3;
    case 'L';         v=4;
    case 'w';         v=5;
    case 'refl';      v=6;
    case 'tran';      v=7;
    case 'absp';      v=8; 
    case 'nr';        v=9;
    otherwise; error('Wrong name');
end
end
%copyold_end

