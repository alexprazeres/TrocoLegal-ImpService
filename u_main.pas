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

uses Horse.Jhonson, Horse.BasicAuthentication;

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
  //
  THorse.Use(Jhonson());
  Data :=TJSONArray.Create;

  THorse.Post('/imprimir',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
     Dados : TJSONObject;
    begin
      Dados := Req.Body<TJSONObject>.Clone as TJSONObject;
      Data.AddElement(Dados);
      Res.Send<TJSONAncestor>(Dados.Clone).Status(THTTPStatus.Created);
    end);

    THorse.Listen(9000);
end;

procedure TForm1.TrayIcon1DblClick(Sender: TObject);
begin
//
ShowMessage('Servidor de Impress�o');
end;

end.
