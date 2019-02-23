 fontsize=15;
 funcnames=cell(1,4);
 funcnames{1}='$y=p_1x^{p_2}$';
  funcnames{2}='$y=p_1x^{p_2}+p_3$';
   funcnames{3}='$y=p_1e^{p_2x}+p_3e^{p_4x}$';
    funcnames{4}='$y=(p_1x^2+p_2x+p_3)/(x+p_4)$';



for i=1:4
subplot(2,2,i);
xlabel('$P_{f,ILS}$','interpreter','Latex','FontSize',fontsize);
ylabel('$\mu_{min}$','interpreter','Latex','FontSize',fontsize);
title(funcnames{i},'interpreter','Latex','FontSize',fontsize);
set(gca,'FontSize',fontsize);
end
