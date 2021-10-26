unit u_DM;

interface

uses
   Winapi.Windows, Winapi.Messages,System.SysUtils, System.Classes, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, IniFiles,Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  ACBrBase, ACBrPosPrinter;

type
  TDM = class(TDataModule)
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    imprime: TACBrPosPrinter;
    procedure DataModuleCreate(Sender: TObject);
    procedure conexaoError(ASender: TObject; const AInitiator: IFDStanObject;
      var AException: Exception);

    procedure configuraImp();
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  DM: TDM;
  imp, codigocorte, codigotxtgrande:AnsiString;
  espacamento, colunastraco,codloja,colunas,codterminal,modelo : Integer;
  repetir,imprimirnota,corta,imprimeD,impGrande,impProd: Boolean;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}



procedure TDM.conexaoError(ASender: TObject; const AInitiator: IFDStanObject;
  var AException: Exception);
begin
//ShowMessage('Houve um problema na conexão com o banco de dados. Tente novamente ou contate o suporte.');
end;

procedure TDM.configuraImp;
begin
    imprime.Porta:=imp;
    imprime.LinhasEntreCupons:=espacamento;

    if (modelo = 0) then
      imprime.Modelo := ppEscDaruma else
    if (modelo = 1) then
      imprime.Modelo := ppEscBematech else
    if (modelo = 2) then
      imprime.Modelo := ppEscDiebold else
    if (modelo = 3) then
      imprime.Modelo := ppEscEpsonP2 else
    if (modelo = 4) then
      imprime.Modelo := ppEscPosEpson else
    if (modelo = 5) then
      imprime.Modelo := ppEscVox else
    if (modelo = 6) then
      imprime.Modelo := ppTexto;

    imprime.ColunasFonteNormal := colunas;
    imprime.CortaPapel := corta;

end;

procedure TDM.DataModuleCreate(Sender: TObject);
var ini:TIniFile;
    banco:string;
begin
if FileExists('config.ini') then
  begin
    try
     ini          :=  TIniFile.Create(GetCurrentDir + '\' + 'config.ini');
     banco        :=  ini.ReadString('MySQL','DriverName','');
     imp          :=  ini.ReadString('Config','Imp','');
     espacamento  :=  StrToInt(ini.ReadString('Config','Espaco',''));
     codloja      :=  StrToInt(ini.ReadString('Config','Loja',''));
     codterminal  :=  StrToInt(ini.ReadString('Config','Terminal',''));
     colunastraco :=  StrToInt(ini.ReadString('Config','ColunasTraco',''));
     colunas      :=  StrToInt(ini.ReadString('Config','Colunas',''));
     corta        :=  StrToBool(ini.ReadString('Config','Corta',''));
     imprimeD     :=  StrToBool(ini.ReadString('Config','ImprimeD',''));

    except
     ShowMessage('Arquivo de configuração incorreto.');
    end;

    try
      impProd := StrToBool(ini.ReadString('Config','ImpProd',''));
    except
     ini.WriteString('Config','ImpProd','1');
     impProd := True;
    end;

    try
      impGrande := StrToBool(ini.ReadString('Config','ImpGrande',''));
    except
      ini.WriteString('Config','ImpGrande','0');
      impGrande := False;
    end;

    try
      modelo  :=  StrToInt(ini.ReadString('Config','Modelo',''));
    except
      ini.WriteString('Config','Modelo','1');
      modelo  :=  1;
    end;

  end else
  if not FileExists('config.ini') then
    begin
      ShowMessage('Arquivo de configuração inexistente. Finalizando Sistema');
      Application.Terminate;
    end;

    configuraImp;
end;

end.
