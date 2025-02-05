% plot comparison GRW-FD
close all

iplot=1; %  GRW
% iplot=1; % Truncation Scheme
if iplot==0
    load pGRWe3.mat
    pGRWe3=p;
    load pGRWe6.mat
    pGRWe6=p;
    load pGRWe10.mat
    pGRWe10=p;
    load pGRWe18.mat
    pGRWe18=p;
    load pGRWe24.mat
    pGRWe24=p;
else
    load rGRWe3.mat
    pGRWe3=p;
    load rGRWe6.mat
    pGRWe6=p;
    load rGRWe10.mat
    pGRWe10=p;
    load rGRWe18.mat
    pGRWe18=p;
    load rGRWe24.mat
    pGRWe24=p;
end
load pFD.mat
pFD=p;

figure; hold on;
plot(pGRWe3,x,'rd','LineWidth',1.2,'MarkerFaceColor','yellow','MarkerSize',4) ;
plot(pGRWe6,x,'b+','LineWidth',1.2,'MarkerFaceColor','yellow','MarkerSize',4) ;
plot(pGRWe10,x,'m*','LineWidth',1.2,'MarkerFaceColor','yellow','MarkerSize',4) ;
plot(pGRWe18,x,'gs','LineWidth',1.2,'MarkerFaceColor','yellow','MarkerSize',4) ;
plot(pGRWe24,x,'yo','LineWidth',1.2,'MarkerFaceColor','yellow','MarkerSize',4) ;
plot(pFD,x,'k.','LineWidth',1.2,'MarkerFaceColor','yellow','MarkerSize',4) ;
ylabel('$z$','Interpreter','latex'); xlabel('$\psi(z)$','Interpreter','latex');
legend('N=1e3','N=1e6','N=1e10','N=1e18','N=1e24','FD','Interpreter','latex'); box on;

figure; hold on;
plot(abs(pFD-pGRWe3)./abs(pFD),x,'rd','LineWidth',1.2,'MarkerFaceColor','yellow','MarkerSize',4) ;
plot(abs(pFD-pGRWe6)./abs(pFD),x,'b+','LineWidth',1.2,'MarkerFaceColor','yellow','MarkerSize',4) ;
plot(abs(pFD-pGRWe10)./abs(pFD),x,'m*','LineWidth',1.2,'MarkerFaceColor','yellow','MarkerSize',4) ;
plot(abs(pFD-pGRWe18)./abs(pFD),x,'gs','LineWidth',1.2,'MarkerFaceColor','yellow','MarkerSize',4) ;
plot(abs(pFD-pGRWe24)./abs(pFD),x,'k.','LineWidth',1.2,'MarkerFaceColor','yellow','MarkerSize',4) ;
ylabel('$z$','Interpreter','latex'); xlabel('$(|\psi^{GRW}(z)-\psi^{FD}(z)|/|\psi^{FD}(z)|$','Interpreter','latex')
legend('N=1e3','N=1e6','N=1e10','N=1e18','N=1e24','Interpreter','latex','FontSize',8,'location','best'); %  ,'Box','off'
set(gca,'xscale','log'); box on; xlim([1e-20 1e5]); xlim([1e-20 1e10]); xticks([1e-20 1e-15 1e-10 1e-5 1 1e5 1e10]);
% 'Orientation','horizontal',


format shortE
fprintf('z-averaged relative errors \n');
err1e3=mean(abs(pFD-pGRWe3)./abs(pFD));
err1e6=mean(abs(pFD-pGRWe6)./abs(pFD));
err1e10=mean(abs(pFD-pGRWe10)./abs(pFD));
err1e18=mean(abs(pFD-pGRWe18)./abs(pFD));
err1e24=mean(abs(pFD-pGRWe24)./abs(pFD));
table(err1e3,err1e6,err1e10,err1e18,err1e24)


% GRW:
% 
%       err1e3        err1e6       err1e10       err1e18       err1e24  
%     __________    __________    __________    __________    __________
% 
%     2.3955e-02    8.5837e-05    5.7327e-09    3.2705e-15    4.2861e-15
% 
% 
% truncation scheme:
% 
%       err1e3        err1e6       err1e10       err1e18       err1e24  
%     __________    __________    __________    __________    __________
% 
%     1.3490e+02    5.3361e-03    5.7684e-07    3.2840e-15    4.2861e-15
% 
