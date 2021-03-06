unit u_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.AppEvnts,
  Horse,System.JSON;

type
  TForm1 = class(TForm)
    TrayIcon1: TTrayIcon;
    ApplicationEvents1: TApplicationEvents;
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure iniciarServidor;
    procedure configurarAutenticacao;
  private
   Data: TJSONArray;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Horse.Jhonson, Horse.BasicAuthentication, postController, u_Util;

procedure TForm1.ApplicationEvents1Minimize(Sender: TObject);
begin
  Self.Hide();
  Self.WindowState := wsMinimized;
  TrayIcon1.Visible := True;
  TrayIcon1.Animate := True;
end;

procedure TForm1.configurarAutenticacao;
begin
  THorse.Use(HorseBasicAuthentication(
    function(const AUsername, APassword: string): Boolean
    begin
      Result := AUsername.Equals('trocolegal') and APassword.Equals('troco2021');
    end));
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Self.Hide();
  Self.WindowState := wsMinimized;

  configurarAutenticacao;
  iniciarServidor;
end;

procedure TForm1.iniciarServidor;
begin
try
  //
  THorse.Use(Jhonson());
  Data :=TJSONArray.Create;

  THorse.Post('/imprimir',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
     Dados : TJSONObject;
     retorno: TJSONObject;
    begin
      Dados := Req.Body<TJSONObject>.Clone as TJSONObject;
      Data.AddElement(Dados);

//      retorno.AddPair('sucesso','true');
//      Res.Send(retorno).Status(THTTPStatus.Created);
         Res.Send(respostaErro('Erro pau')).Status(THTTPStatus.BadRequest);
    end);

  THorse.Get('/teste',procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.Send('ok').Status(THTTPStatus.Created);
    end);

    THorse.Listen(9000);
except
  ShowMessage('erro ao tratar');
end;
end;

procedure TForm1.TrayIcon1DblClick(Sender: TObject);
begin
//
ShowMessage('Servidor de Impress?o');
end;

end.
