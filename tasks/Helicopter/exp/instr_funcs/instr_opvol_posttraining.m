i=0; clear tx ypos func;
func{1}=[];

i=i+1; 
	ypos{i}=ypost;
	if site == 'B';
        tx{i}=['Die �bung ist jetzt zu Ende. Die bessere Karte war:'];
    else 
        tx{i}=['L�exercice est termin�.\n La meilleure carte �tait:'];
    end
    if S(1) == 1 
        func{i}='Screen(''DrawTexture'',wd,Card2, [],boxl(1,:)); getleftrightarrow;';
        
    elseif S(1)==2
        func{i}='Screen(''DrawTexture'',wd,Card1, [],boxl(1,:)); getleftrightarrow;';
    end
if site == 'B';
i=i+1; 
	ypos{i}=yposm;
	tx{i}=['Sie haben ' num2str(nansum(C)) ' Mal von ' num2str(Z.Ntrials) ' Durchg�ngen die bessere Karte ausgew�hlt!'];
    
i=i+1; 
	ypos{i}=yposm;
    tx{i}='Wie Sie vielleicht bemerkt haben, gibt es immer eine bessere Karte. Die bessere Karte wird h�ufiger, aber nicht immer belohnt.'; 

i=i+1; 
	ypos{i}=yposm;
    tx{i}='Nun werden Sie zwei neue Karten gezeigt bekommen. Eine davon ist zun�chst wieder besser als die andere. \n\nAber nun kann es passieren, dass die zun�chst h�ufiger belohnte Karte schlechter wird. Im Gegenzug wird dann die andere Karte besser.'; 

i=i+1; 
	ypos{i}=yposm;
    tx{i}='Welche Karte die bessere ist, kann mehrmals wechseln! Bitte achten Sie stets wachsam auf solche Ver�nderungen, um so viel Geld wie m�glich zu gewinnen!';

i=i+1; 
	ypos{i}=yposm;
	tx{i}='Gleich haben Sie f�r dieses Gewinnspiel 25 Minuten Zeit. Ihren Gewinn bekommen Sie danach ausgezahlt!';
    
i=i+1; 
	ypos{i}=yposm;
	tx{i}='Wir m�chten jetzt sicher stellen, dass Sie alles verstanden haben. Bitte erkl�ren Sie, was Ihre Aufgabe in diesem Gewinnspiel ist.';

elseif site == 'G'; 
i=i+1; 
	ypos{i}=yposm;
	tx{i}=['Vous avez choisi la meilleure carte ' num2str(nansum(C)) ' fois parmi ' num2str(Z.Ntrials) ' essais !'];

i=i+1; 
	ypos{i}=yposm;
    tx{i}='Comme vous l''avez peut-�tre remarqu�, il y a toujours une carte qui est meilleure que les autres. Cette carte est plus souvent r�mun�r�e, mais pas toujours.'; 

i=i+1; 
	ypos{i}=yposm;
    tx{i}='Maintenant, vous allez voir deux nouvelles cartes. Au d�but, l''une d''elles sera � nouveau meilleure que l''autre. \n\nCependant, cela peut arriver que la carte qui �tait initialement mieux r�mun�r�e devienne moins bonne. D�s lors, c''est l''autre carte qui deviendra meilleure.'; 

i=i+1; 
	ypos{i}=yposm;
    tx{i}='La carte qui est la mieux r�mun�r�e peut changer plusieurs fois ! Restez attentif � ces changements afin de gagner le plus d''argent possible !';

i=i+1; 
	ypos{i}=yposm;
	tx{i}='Ce jeu va durer 25 minutes. Apr�s cela, vous recevrez votre gain !';
    
i=i+1; 
	ypos{i}=yposm;
	tx{i}='Nous voudrions nous assurer que vous avez bien compris les instructions. Pourriez-vous, s''il vous plait, nous expliquer en quoi consiste votre t�che dans ce jeu ?';

end
instr_display;
checkabort;