% function FFRTtable()
clear; clc; close all;
fontsize=15;
ffrtclnep=1;ffrtclnna=2;ffrtclnns=3;ffrtclnPsb=4;ffrtclnPsILS=5;ffrtclnPf_req=6;
ffrtclnmu=7;ffrtclnPfix=8;ffrtclnPscon=9; ffrtclnPftrue=10;

Pfs=[0.0005, 0.0006, 0.0007, 0.0008, 0.0009,...
    0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009, 0.01];
Pfslen=length(Pfs);
maxns=70;
xbins=[0.001:0.001:1];
load('options.mat');
PfPfixns=cell(Pfslen,maxns,3);
PfPfix=cell(Pfslen,3);
modeltext=cell(3,1); 
modeltext{1,1}='GPS DualFreq';
modeltext{2,1}='BDS DualFreq';
modeltext{3,1}='GPS+BDS DualFreq';
for imodel=1:3
    
    for i=1:Pfslen
        PfPfix{i,imodel}=[];
        for j=1:maxns
            PfPfixns{i,j,imodel}=[];
        end
    end
end

% PfILSbins=0.01:0.01:1;
% PfILSbinlen=length(PfILSbins);
% PfILSPfixns=cell(PfILSbinlen,maxns);
% PfILSPfix=cell(PfILSbinlen,1);
% for i=1:PfILSbinlen
%     PfILSPfix{i,1}=[];
%     for j=1:maxns
%         PfILSPfixns{i,j}=[];
%     end
% end

GSF=[1:20,181:200,361:380]; GDF=[21:40,201:220,381:400]; GTF=[41:60,221:240,401:420];
BSF=[61:80,241:260,421:440];BDF=[81:100,261:280,441:460];BTF=[101:120,281:300,461:480];
GBSF=[121:140,301:320,481:500];GBDF=[141:160,321:340,501:520];GBTF=[161:180,341:360,521:540];
strongm=[1:5:16]; mediumm=[2,3,7,8,12,13,17,18]; weakm=[4,5,9,10,14,15,19,20];
for imodel=1:3
    switch(imodel)
        case 1
            SatModel=BDF;
%             modelfiles=strongm;
        case 2
            SatModel=GDF;

%             modelfiles=mediumm;
        case 3
            SatModel=GBDF;
%             modelfiles=weakm;           
    end
%     modelfiles=[];
    for filei=SatModel([mediumm,weakm])%BTF%(modelfiles)
        filename=opts(filei).filename;%fgetl(fidfs)
        filenametxt=strcat('FFRT_',filename,'.txt');
        if ~exist(filenametxt,'file')
            continue;
        end
        resep=load(filenametxt);
        if size (resep,1)==0
            continue;
        end
        %     figure(1);
        
        for ifig=1:Pfslen
            Pfreq=Pfs(ifig);
            Pfreqrows=resep(:,ffrtclnPf_req)==Pfreq;
            resepa=resep(Pfreqrows,:);
            posiPfixrows=resepa(:,ffrtclnPfix)~=0;
            resepb=resepa(posiPfixrows,:);
            PfPfix{ifig,imodel}=[PfPfix{ifig,imodel};resepb];
            
            for ns=1:maxns
                nsrows=resepb(:,ffrtclnns)==ns;
                PfPfixns{ifig,ns,imodel}=[PfPfixns{ifig,ns,imodel};filei*ones(sum(nsrows),1),resepb(nsrows,ffrtclnPsb),resepb(nsrows,ffrtclnPsILS),resepb(nsrows,ffrtclnmu),resepb(nsrows,ffrtclnPfix)];
            end
            %         figure(ifig);
            %         scatter(1-resepb(:,ffrtclnPsILS),resepb(:,ffrtclnmu),5,resepb(:,ffrtclnns),'filled'); colorbar; hold on;
            
        end
        
        %     for ifig=1:PfILSbinlen
        %         tmprows1=resep(:,ffrtclnPsILS)>(PfILSbins(ifig)-0.01);
        %         tmprows2=resep(:,ffrtclnPsILS)<=PfILSbins(ifig);
        %         PfILSrows=tmprows1 & tmprows2;
        %         resepa=resep(PfILSrows,:);
        %         posiPfixrows=resepa(:,ffrtclnPfix)~=0;
        %         resepb=resepa(posiPfixrows,:);
        %         PfILSPfix{ifig,1}=[PfILSPfix{ifig,1}; resepb];
        %
        %         for ns=1:maxns
        %             nsrows=resepb(:,ffrtclnns)==ns;
        % %            PfILSPfixns=cell(PfILSbinlen,maxns);
        %             PfILSPfixns{ifig,ns}=[PfILSPfixns{ifig,ns};filei*ones(sum(nsrows),1),resepb(nsrows,ffrtclnPsb),resepb(nsrows,ffrtclnPsILS),resepb(nsrows,ffrtclnmu),resepb(nsrows,ffrtclnPfix)];
        %
        %         end
        %
        %     end
        
    end
end
clear resep; clear resepa; clear resepb; clear nsrows; clear posiPfixrows; clear Pfreqrows;

% for i=1:Pfslen
%     for j=1:maxns
%         filename=strcat('PfPfixns','Pfidx',num2str(i),'ns',num2str(j),'.txt');
%         filename=fullfile('./PfPfixns/',filename);
%         fpw=fopen(filename,'w');
%         fprintf(fpw,'%12.5f %12.5f %12.5f %12.5f %12.5f\n',PfPfixns{i,j}');
%         fclose(fpw);
%     end
% end
stdofpfix= NaN(3,maxns);
% % figure(1);
% cmin=1;cmax=50;
for ifig=15%[1,6,10,15]%1:Pfslen
    figure(ifig);
%     imodel=2;
    for imodel=1:3
    subplot(2,3,imodel);
%     subplot(2,1,1);
    scatter(1-PfPfix{ifig,imodel}(:,ffrtclnPsb),PfPfix{ifig,imodel}(:,ffrtclnmu),5,PfPfix{ifig,imodel}(:,ffrtclnns),'filled'); colorbar; %hold on;
%     scatter(1-PfPfix{ifig,imodel}(:,ffrtclnPsILS),PfPfix{ifig,imodel}(:,ffrtclnmu),5,PfPfix{ifig,imodel}(:,ffrtclnns),'filled'); colorbar; hold on;

    for ns=1:maxns
        mydata=PfPfixns{ifig,ns,imodel};
        if isempty(mydata), continue; end
        
        %data screen
        % screen when mu=1
        idx=mydata(:,4)~=1;
        mydata=mydata(idx,:);
        if isempty(mydata), continue; end
               
%         % screen Pfix>0.5
%         idx=mydata(:,5)>=0.3;
%         mydata=mydata(idx,:);
%         if isempty(mydata), continue; end
        
        
        xstep=0.001;
        Pf_ILS=1-mydata(:,3);
        mu=mydata(:,4);
        Pfix=mydata(:,5);
%                 if length(mu)<5, continue; end
% 
%         [fitres,gofit,xData, yData]=Fit_PfILS_mu(Pf_ILS, mu);

        [minmu,minPf_ILS,minPfix]=group_and_min(Pf_ILS,mu,Pfix,xstep);  
        if length(minmu)<5, continue; end
        [fitres,gofit,xData, yData]=Fit_PfILS_mu(minPf_ILS, minmu);
%         stdofpfix(imodel,ns)=gofit.rmse;
% figure( 'Name', 'y=a*x^b' );
% 
% % Plot fit with data.
% subplot( 2, 1, 1 );
% h = plot( fitres, xData, yData, 'predobs', 0.9 ); hold on;
% legend( h, '\mu_m_i_n vs. P_f_,_I_L_S', 'y=a*x^b', 'Lower bounds', 'Upper bounds', 'Location', 'NorthEast' );
% % Label axes
% xlabel ('P_f_,_I_L_S');
% ylabel ('\mu_m_i_n');
% grid on
% 
% % Plot residuals.
% subplot( 2, 1, 2 );
% h = plot( fitres, xData, yData, 'residuals' );
% legend( h, 'Residuals', 'Zero Line', 'Location', 'NorthEast' );
% % Label axes
% xlabel ('P_f_,_I_L_S');
% ylabel ('Fitted resudual');
% grid on

    end
%      
%  [minmu,minPf_ILS,minPfix]=group_and_min(Pf_ILS,mu,Pfix,xstep)
%  [fitres,gofit]=Fit_PfILS_mu(minPf_ILS, minmu)
    % ffrtclnep=1;ffrtclnna=2;ffrtclnns=3;ffrtclnPsb=4;ffrtclnPsILS=5;ffrtclnPf_req=6;
    % ffrtclnmu=7;ffrtclnPfix=8;ffrtclnPscon=9; ffrtclnPftrue=10;
    %     subplot(4,4,ifig);
    xlim([0,1]);
    ylim([0,1]);
% %     caxis([cmin,cmax]);
%     end
    titletxt=modeltext{imodel,1};%strcat('P_f^t^o^l=',num2str(Pfs(ifig)));

%     titletxt=strcat('P_f^t^o^l=',num2str(Pfs(ifig)));
    title(titletxt,'FontSize',fontsize);
    xlabel('Pf,ILS','FontSize',fontsize);
    ylabel('\mu','FontSize',fontsize);
    set(gca,'FontSize',fontsize);
    subplot(2,3,imodel+3);
    scatter(1-PfPfix{ifig,imodel}(:,ffrtclnPsb),PfPfix{ifig,imodel}(:,ffrtclnPfix),5,PfPfix{ifig,imodel}(:,ffrtclnns),'filled'); colorbar; %hold on;
%     scatter(1-PfPfix{ifig,imodel}(:,ffrtclnPsILS),PfPfix{ifig,imodel}(:,ffrtclnPfix),5,PfPfix{ifig,imodel}(:,ffrtclnns),'filled'); colorbar; %hold on;

    xlim([0,1]);
    ylim([0,1]);
%     caxis([cmin,cmax]);

    xlabel('Pf,ILS','FontSize',fontsize);
    ylabel('P_f_i_x','FontSize',fontsize);
    set(gca,'FontSize',fontsize);
    end
    %     hold off;
    set(gcf,'units','normalized','outerposition',[0 0 1 1]);
    colormap hsv;%jet;

end
% stdofpfix
% for ifig=90:PfILSbinlen
%     figure(ifig+100);
%     scatter(1-PfILSPfix{ifig,1}(:,ffrtclnPsILS),PfILSPfix{ifig,1}(:,ffrtclnmu),5,PfILSPfix{ifig,1}(:,ffrtclnns),'filled'); colorbar; %hold on;
% % ffrtclnep=1;ffrtclnna=2;ffrtclnns=3;ffrtclnPsb=4;ffrtclnPsILS=5;ffrtclnPf_req=6;
% % ffrtclnmu=7;ffrtclnPfix=8;ffrtclnPscon=9; ffrtclnPftrue=10;
% %     subplot(4,4,ifig);
% %     titletxt=strcat('Pf_r_e_q=',num2str(PfILSPfix(ifig)));
% %     title(titletxt);
%     xlabel('Pf');
%     ylabel('\mu');
% %     hold off;
%     set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%
% end



% h=figure(1);
% set(gcf,'units','normalized','outerposition',[0 0 1 1]);
% savefig(h,'FFRTtable.fig','compact');
% saveas(gcf,'FFRTtable.jpg');

% close all;
