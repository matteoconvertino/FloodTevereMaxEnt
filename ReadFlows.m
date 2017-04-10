%----------------------------------------
%Lettura dati idrometrici CFD Lazio
%Portate giornaliere Bacino tevere

% by Antonio Annis 
%------------------------------------------
Fiume=menu('River','Tevere','Aniene', 'Nera', 'Velino', 'Salto', 'Turano',...
    'Paglia', 'Chiani', 'Chiascio', 'Topino','Marroggia', 'Nestore');

if Fiume==1
    Staz=menu('Idrometer:', 'Mezzocammino', 'Porta Portese', 'Ripetta',...
        'Villa Spada', 'Fidene', 'Castel Giubileo', 'Ponte del Grillo',...
        'Nazzano', 'Stimigliano', 'Ponte Felice', 'Orte Scalo',...
        'Ponte di Attigliano', 'Alviano', 'Corbara', 'Monte Molino',...
        'Ponte Nuovo', 'Ponte Felcino', 'Pierantonio', 'Santa Lucia', ...
        'Gorgabuia');
    
else if Fiume==2
        Staz=menu('Idrometer:', 'Ponte Salario', 'Lunghezza',...
            'Ponte Lucano', 'Centrale Acquoria', 'Marano Equo', 'Subiaco');
        
    else if Fiume==3
            Staz=menu('Idrometer:', 'Nera Montoro', 'Terni',...
                'Torre Orsina', 'Vallo di Nera')
            
        else if Fiume==4
                Staz=menu('Idrometer:', 'Terria', 'Rieti','Antrodoco')
                
            else if Fiume==7
                    Staz=menu('Idrometer:', 'Orvieto Scalo', 'Allerona')
                    
                else if Fiume==8
                        Staz=menu('Idrometer:', 'Morrano', 'Ponte Osteria'...
                            ,'Ponte Santa Maria', 'Ponticelli')
                    end
                end
            end
        end
    end
end




%choose teh type of data to read (Flow or heigh)

DataType=menu('Type of data','Heigh','Flow');
%Take the column useful in the CFD lazio data format
if DataType==1
    Col_data=3;
    TD='Altezza [m]';
else
    Col_data=3;
    TD='Portata [m^3/s]';
end
 
%----------------------------------------------------------------------

%-----------------------------------------------------------------

%load data (Date Hour H.. etc)
[name_inp path_inp] = uigetfile('*.xls;*.txt;*.csv', 'Input data');
INPUT= [path_inp name_inp];
% %DATA = textscan(INPUT, '%s', 'delimiter','\n', 'headerlines',4);
DATA = textread(INPUT, '%s', 'bufsize', 120000, 'delimiter','\n', 'headerlines',4);
% %DATA = textread(INPUT, '%s', 'delimiter','\n', 'headerlines',4);
% [Date Hour T H H1 e]  = textread(INPUT, '%s %s %s %s %s %s', 'bufsize', 120000, 'delimiter',';', 'headerlines',4);

% fileID = fopen(INPUT);
% formatSpec = '%s%s%f%f%f%s%s';
% DATA = textscan(fileID,formatSpec,'CommentStyle','%','Delimiter',';', 'headerlines',4);
% fclose(fileID);
% % 

n_rows = length(DATA);



%Initializing variables
Date=[]; %date
Months=[];
Hour=[]; %Hour
H=[];


rows_del=0;
for i=1:n_rows
    Line = num2str(cell2mat(DATA(i)));
    Line = strread(Line,'%s','delimiter',';');
    %Date = [ Date; (num2str(cell2mat(Line(1))))];
    if length(Line{1})==0;
        rows_del=rows_del+1;
    else
        Date = [ Date; Line(1)];
        Months=[Months; month(Line(1),'dd/mm/yyyy')];
        Hour = [Hour; Line(2)];
        %Hour = [Hour; (num2str(cell2mat(Line(2))))];
        Hpro=str2num(num2str(cell2mat((strrep(Line(Col_data),',','.')))));
        if isempty(Hpro)==1
            Hpro=-99;
        end
        H=[H; Hpro];
    end
end

n_rows=n_rows-rows_del;
%Trasformaz altezze-Portate
Q=H;
indQ=find(H~=-99);


if Fiume==1
    if Staz==3
        Name='Ripetta';
        if DataType==1
            Q(indQ)=-236.751-135.499.*H(indQ)+244.620.*((H(indQ)).^2) ...
                -103.839.*((H(indQ)).^3)+21.1103*((H(indQ)).^4)-2.28075*((H(indQ)).^5) ...
                +0.136011*((H(indQ)).^6) +0.00423675*((H(indQ)).^7);
        end
    end
    if Staz==7
        Name='PonteDelGrillo';
        if DataType==1
            Q(indQ)=3680.*exp(-7.53./H(indQ));
        end
    end
    if Staz==10
        Name='PonteFelice';
        if DataType==1
            Q(indQ)=56.5*(1.08.^ H(indQ)).*((H(indQ)).^0.995)
        end
    end
    if Staz==13
        Name='Alviano';
        Q(indQ)=5.54 + 25.2.* H(indQ)-5.97.*((H(indQ)).^2)+ 11.1.*((H(indQ)).^3)
    end
end

if Fiume==2
    if Staz==2
        Name='Lunghezza';
        if DataType==1
            Q(indQ)=-16.0268+58.179.*H(indQ)-57.0768.*((H(indQ)).^2) ...
                +35.4526.*((H(indQ)).^3) -9.54794*((H(indQ)).^4) + 1.13754*((H(indQ)).^5) ...
                -0.0477905*((H(indQ)).^6);
        end
    end
end

        
Datet=num2str(cell2mat(Date(1)));
Date1=[Datet(1:end)];
indi=1;
Qm=[];



for i=2:n_rows
    %if  Months(i)~=Months(i-1)
    if strcmp(Date(i),Date(i-1))==0
        
        Datet=num2str(cell2mat(Date(i)));
        %Date1=[Date1; Datet(4:end)];
        Date1=[Date1; Date(i)];
        Qp=Q(indi:i);
        
        ind_del=find(Qp)==-99;
        Qp(ind_del)='';
        if isempty(Qp)==1
            Qmpro=-99;
        else
            Qmpro=mean(Qp);
        end
        Qm=[Qm;Qmpro];
        indi=i;
    end
    if i==n_rows
        Qp=Q(indi:end);
        ind_del=find(Qp)==-99;
        Qp(ind_del)='';
        if isempty(Qp)==1
            Qmpro=-99;
        else
            Qmpro=mean(Qp);
        end
        Qm=[Qm;Qmpro];
    end  
    
end

Name=name_inp;
% Namefile = inputdlg('Name of the output file with the monthly flows');
% Namefile = num2str(cell2mat(Namefile));
RESULTS = sprintf('%s.txt',name_inp);
fileID = fopen(RESULTS,'wt');

fprintf(fileID,'%s\n', Name);
fprintf(fileID,'%10s %14s\n', 'Data',TD);

for i=1:length(Date1)
    fprintf(fileID,'%10s %15.2f\n', num2str(cell2mat(Date1(i))), Qm(i) );
end

fclose(fileID);
        
        

