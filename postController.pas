unit postController;

interface
       uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.AppEvnts,
  Horse,System.JSON;

procedure imp(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

var
  Data: TJSONArray;
//uses Horse.Jhonson, Horse.BasicAuthentication;

//procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
//    var
//     Dados : TJSONObject;
//    begin
//      Dados := Req.Body<TJSONObject>.Clone as TJSONObject;
//      Data.AddElement(Dados);
//      Res.Send<TJSONAncestor>(Dados.Clone).Status(THTTPStatus.Created);
//    end);
//end.

procedure imp(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
Dados : TJSONObject;
begin
  Dados := Req.Body<TJSONObject>.Clone as TJSONObject;
  Data.AddElement(Dados);
  Res.Send<TJSONAncestor>(Dados.Clone).Status(THTTPStatus.Created);
end;


end.