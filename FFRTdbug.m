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
PfPfixns=cell(Pfslen,maxns);
PfPfix=cell(Pfslen,1);
    for i=1:Pfslen
        PfPfix{i,1}=[];
        for j=1:maxns
            PfPfixns{i,j}=[];
        end
    end


GSF=[1:20,181:200,361:380]; GDF=[21:40,201:220,381:400]; GTF=[41:60,221:240,401:420];
BSF=[61:80,241:260,421:440];BDF=[81:100,261:280,441:460];BTF=[101:120,281:300,461:480];
GBSF=[121:140,301:320,481:500];GBDF=[141:160,321:340,501:520];GBTF=[161:180,341:360,521:540];
strongm=[1:5:16]; mediumm=[2,3,7,8,12,13,17,18]; weakm=[4,5,9,10,14,15,19,20];
%     switch(imodel)
%         case 1
%             SatModel=BDF;
% %             modelfiles=strongm;
%         case 2
%             SatModel=GDF;
% 
% %             modelfiles=mediumm;
%         case 3
%             SatModel=GBDF;
% %             modelfiles=weakm;           
%     end
%     modelfiles=[];
modeleppairs=[23,24,24,25,25,25,25,27,28,31,37,202,213,213,216,384,385,387,387,388,390,390,84,90,92,93,94,94,95,100,263,264,265,266,268,271,272,274,277,445,445,447,453,453,454,454,455,455,155,160,330,335,335,335,335,510,515,515,520,520;
    9,14,33,6,12,24,28,11,3,8,37,29,1,30,31,30,8,10,30,11,14,41,17,12,7,18,23,35,30,40,2,33,12,1,12,2,32,6,9,10,12,8,1,27,9,31,4,5,32,43,18,8,13,22,23,32,1,25,6,27];
problemflags=zeros(size(modeleppairs,2),1);
    for ipair=1:size(modeleppairs,2)
        filei=modeleppairs(1,ipair);%[GBDF(mediumm),GBDF(weakm)]%SatModel([mediumm])%BTF%(modelfiles)
        filename=opts(filei).filename;%fgetl(fidfs)
        filenametxt=strcat('../FFRT_',filename,'.txt');
        if ~exist(filenametxt,'file')
            continue;
        end
        resep=load(filenametxt);
        if size (resep,1)==0
            problemflags(ipair)=1;
            continue;
        end
        if ipair==20 || ipair==28 || ipair==41 ||ipair==55
%          display(ipair);
        end
        %     figure(1);
        ep=modeleppairs(2,ipair);
        ind=resep(:,ffrtclnep)==ep;
        resepa=resep(ind,:); clear resep;
        ind1=resepa(:,ffrtclnns)==1;
%         ind2=resepa(:,ffrtclnns)==2;
        resepb=resepa(ind1,:);
%         resepc=resepa(ind2,:);
        psb1=resepb(1,ffrtclnPsb);
        if psb1<=0.9991 && psb1>=0.999% %???psb1???0.99909??0.99905????????????????????????????0.9991.
            problemflags(ipair)=1;
        end
        

        
    end
figure;
plot(problemflags);
% save('myfitgroupAllPftol','myfitgroup');

