fprintf('............. Displaying instructions \n');
i=0; clear tx ypos func;
func{1}=[];


if site == 'B'
i=i+1; 
	ypos{i}=yposm;
	tx{i}=['Hier noch einmal die Regeln f�r das Gewinnspiel: \n\n Benutzen Sie bitte die rechte Pfeiltaste, um vorw�rts zu bl�ttern und die linke Pfeiltaste, um zur�ck zu bl�ttern.'];

i=i+1; 
	ypos{i}=yposm;
	tx{i}=['Dieses Gewinnspiel ist ein einfaches Kartenspiel. Es geht darum, so viel Geld wie m�glich zu gewinnen.\n\n Ihren Geldgewinn bekommen Sie am Ende ausgezahlt!'];

i=i+1; 
	ypos{i}=yposm;
	tx{i}=['In jedem Durchgang w�hlen Sie zwischen zwei Karten.'];

i=i+1; 
	ypos{i}=ypost;
	tx{i}=['Immer, wenn Sie die zwei Karten sehen, haben Sie 1.5 Sekunden Zeit, eine der beiden auszuw�hlen.'];
    func{i}='Screen(''DrawTexture'',wd,Card1, [],box(1,:)); Screen(''DrawTexture'',wd,Card2, [],box(2,:));getleftrightarrow;';

i=i+1; 
	ypos{i}=ypost;
	tx{i}=['Dazu dr�cken Sie mit Ihren Zeigefingern bitte die Taste "' num2str(keyleft) '" f�r die linke Karte und die Taste "'  num2str(keyright) '" f�r die rechte Karte.']; 
    func{i}='Screen(''DrawTexture'',wd,Card1, [],box(1,:)); Screen(''DrawTexture'',wd,Card2, [],box(2,:));getleftrightarrow;';

i=i+1; 
	ypos{i}=ypost;
	tx{i}=['Nach der Auswahl bekommen Sie eine R�ckmeldung. Entweder gewinnen Sie mit der gew�hlten Karte 10 Cent...'];
    func{i}='Screen(''DrawTexture'',wd,squareframe,[],boxl(1,:)); Screen(''DrawTexture'',wd,Card1, [],box(1,:)); Screen(''DrawTexture'',wd,Card2, [],box(2,:));Screen(''DrawTexture'',wd,win,[],box_center);getleftrightarrow;';
    
i=i+1; 
	ypos{i}=ypost;
	tx{i}=['... oder Sie verlieren mit der ausgew�hlten Karte 10 Cent.'];
    func{i}='Screen(''DrawTexture'',wd,squareframe,[],boxl(1,:)); Screen(''DrawTexture'',wd,Card1, [],box(1,:)); Screen(''DrawTexture'',wd,Card2, [],box(2,:));Screen(''DrawTexture'',wd,loss,[],box_center);getleftrightarrow;';

i=i+1; 
	ypos{i}=yposm;
	tx{i}=['Wie bei einem Gewinnspiel so �blich ist auch ein bi�chen Gl�ck dabei, denn keine Karte gewinnt oder verliert immer.'];

i=i+1; 
	ypos{i}=yposm;
	tx{i}=['Sie sollen die Karte ausw�hlen, welche am h�ufigsten gewinnt.\n So gewinnen Sie insgesamt m�glichst viel Geld, denn Ihren Gewinn bekommen Sie am Ende ausgezahlt.'];
 
i=i+1; 
	ypos{i}=yposm;
	tx{i}='Lassen Sie uns das kurz �ben.';


elseif site == 'G'
i=i+1; 
	ypos{i}=yposm;
	tx{i}=['Bienvenue dans ce jeu de hasard.\n\n Nous allons vous expliquer\n comment ce jeu se d�roule.\n\n S''il vous plait, utilisez la fl�che droite pour passer � la page suivante et la fl�che gauche pour revenir en arriere.'];

i=i+1; 
	ypos{i}=yposm;
	tx{i}=['Ce jeu de hasard est un jeu de cartes.\n\n Votre but est de gagner\n le plus d''argent possible.\n\n Nous vous donnerons vos\n gains � la fin du jeu!'];

i=i+1; 
	ypos{i}=yposm;
	tx{i}=['Dans chaque essai, vous devrez choisir entre deux cartes.'];

i=i+1; 
	ypos{i}=ypost;
	tx{i}=['Vous avez 1.5 seconde pour choisir entre les deux cartes.'];    
    func{i}='Screen(''DrawTexture'',wd,Card1, [],box(1,:)); Screen(''DrawTexture'',wd,Card2, [],box(2,:));getleftrightarrow;';
   
i=i+1; 
	ypos{i}=ypost;
	tx{i}=['Pour choisir la carte, veuillez pousser la touche f pour la carte de gauche et la touche j pour la carte de droite.'];  % please translate ("For that, please press the "f" key for the left card and the "j" key for the right card with your respective index finger.") 
    func{i}='Screen(''DrawTexture'',wd,Card1, [],box(1,:)); Screen(''DrawTexture'',wd,Card2, [],box(2,:));getleftrightarrow;';

    
    
i=i+1; 
	ypos{i}=ypost;
	tx{i}=['Apr�s avoir fait votre choix, le programme vous indiquera si vous avez gagn� 20 centimes...'];
    func{i}='Screen(''DrawTexture'',wd,squareframe,[],boxl(1,:)); Screen(''DrawTexture'',wd,Card1, [],box(1,:)); Screen(''DrawTexture'',wd,Card2, [],box(2,:));Screen(''DrawTexture'',wd,win,[],box_center);getleftrightarrow;';
    
i=i+1; 
	ypos{i}=ypost;
	tx{i}=['... ou perdu 20 centimes avec la carte que vous avez choisie.'];
    func{i}='Screen(''DrawTexture'',wd,squareframe,[],boxl(1,:)); Screen(''DrawTexture'',wd,Card1, [],box(1,:)); Screen(''DrawTexture'',wd,Card2, [],box(2,:));Screen(''DrawTexture'',wd,loss,[],box_center);getleftrightarrow;';

i=i+1; 
	ypos{i}=yposm;
	tx{i}=['Comme il s''agit d''un jeu de hasard, il y aura une part de hasard. Il n''y a pas de carte qui gagne toujours.'];

i=i+1; 
	ypos{i}=yposm;
	tx{i}=['Vous devrez choisir la carte qui gagne le plus souvent.\n En faisant ainsi, vous gagnerez le plus possible. Souvenez-vous qu''apr�s le jeu, vous recevrez vos gains acquis pendant le jeu.'];
 
i=i+1; 
	ypos{i}=yposm;
	tx{i}='Nous allons maintenant commencer par un petit entra�nement !';
end


instr_display;
