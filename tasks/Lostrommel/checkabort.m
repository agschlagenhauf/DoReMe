[foo, foo, key ] = KbCheck;
if strcmpi(KbName(key),'escape')
	aborted=1; 
	Screen('Fillrect',window,ones(1,3)*100);
	text='Aborting experiment';
	col=[200 30 0];
	Screen('TextSize',window,60);
	DrawFormattedText(window,text,'center','center',col,60);
    Screen('CloseAll')
    fclose('all')
    ShowCursor
	error('Pressed ESC --- aborting experiment')
end
