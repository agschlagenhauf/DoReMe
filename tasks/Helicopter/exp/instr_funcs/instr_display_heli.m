if length(func)<i;func{i}=[];end
Pages=i;

while 1
    
    if ~isempty(func{page});
		eval(func{page}); % must NOT contain 'getleftrightarrow' command
    end
    
    DrawFormattedText(wd,tx{page},'center', ypos{page},backcolor,40,[],[],1.3); % Wrapat changed to 40 from 45
    getleftrightarrow;
    
    if page>Pages; break; end
%     checkabort;
end


