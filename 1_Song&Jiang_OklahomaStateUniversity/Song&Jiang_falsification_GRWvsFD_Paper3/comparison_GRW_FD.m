%% see red comment on page 14 of Paper3_commented.pdf:
%% plots with comparisons between FD and GRW solutions show that by increasing the number of particles 
%% the two solutions become identical in the limit of machine precission; this results invalidates the claim  
%% that "the relationship between the number of particles and pressure head is neither smooth nor explicit"
%% used as principal motivation in all the tree papers of Song and Jiang. 

close all

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
load pFD.mat
pFD=p;

figure; hold on;
plot(pGRWe3,x,'rd','LineWidth',1.2,'MarkerFaceColor','yellow','MarkerSize',4) ;
plot(pGRWe6,x,'b+','LineWidth',1.2,'MarkerFaceColor','yellow','MarkerSize',4) ;
plot(pGRWe10,x,'m*','LineWidth',1.2,'MarkerFaceColor','yellow','MarkerSize',4) ;
plot(pGRWe18,x,'gs','LineWidth',1.2,'MarkerFaceColor','yellow','MarkerSize',4) ;
plot(pGRWe24,x,'yo','LineWidth',1.2,'MarkerFaceColor','yellow','MarkerSize',4) ;
plot(pFD,x,'k.','LineWidth',1.2,'MarkerFaceColor','yellow','MarkerSize',4) ;
ylabel('$z$','Interpreter','latex','FontSize',12); xlabel('$\psi(z)$','Interpreter','latex','FontSize',12);
legend('N=1e3','N=1e6','N=1e10','N=1e18','N=1e24','FD','Interpreter','latex','FontSize',12,'location','best'); box on;

figure; hold on;
plot(abs(pFD-pGRWe3)./abs(pFD),x,'rd','LineWidth',1.2,'MarkerFaceColor','yellow','MarkerSize',4) ;
plot(abs(pFD-pGRWe6)./abs(pFD),x,'b+','LineWidth',1.2,'MarkerFaceColor','yellow','MarkerSize',4) ;
plot(abs(pFD-pGRWe10)./abs(pFD),x,'m*','LineWidth',1.2,'MarkerFaceColor','yellow','MarkerSize',4) ;
plot(abs(pFD-pGRWe18)./abs(pFD),x,'gs','LineWidth',1.2,'MarkerFaceColor','yellow','MarkerSize',4) ;
plot(abs(pFD-pGRWe24)./abs(pFD),x,'k.','LineWidth',1.2,'MarkerFaceColor','yellow','MarkerSize',4) ;
ylabel('$z$','Interpreter','latex','FontSize',12); xlabel('$(|\psi^{GRW}(z)-\psi^{FD}(z)|/|\psi^{FD}(z)|$','Interpreter','latex','FontSize',12)
legend('N=1e3','N=1e6','N=1e10','N=1e18','N=1e24','Interpreter','latex','FontSize',12,'location','best'); 
set(gca,'xscale','log'); box on; xlim([1e-20 1e5]); xticks([1e-20 1e-15 1e-10 1e-5 1 1e5]);
