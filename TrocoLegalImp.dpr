program TrocoLegalImp;

uses
  Vcl.Forms,
  u_main in 'u_main.pas' {Form1},
  Horse.BasicAuthentication in 'Horse.BasicAuthentication.pas',
  Horse.Jhonson in 'Horse.Jhonson.pas',
  postController in 'postController.pas',
  u_Util in 'u_Util.pas',
  u_DM in 'u_DM.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
