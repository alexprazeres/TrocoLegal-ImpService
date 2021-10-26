unit u_Util;
interface

USES System.JSON;


function respostaOk(): TJSonValue;
function respostaErro(erro: String): TJSonValue;

implementation


function respostaOk():TJSonValue;
  var
    JSonValue : TJSonValue;
    data:String;
  begin
    data:='{"sucesso":"sim"}';
    JsonValue := TJSonObject.ParseJSONValue(data);

    Result:= JsonValue;
  end;
function respostaErro(erro:String):TJSonValue;
  var
    JSonValue : TJSonValue;
    data:String;
  begin
    data:='{"error":"'+erro+'"}';
    JsonValue := TJSonObject.ParseJSONValue(data);

    Result:= JsonValue;
  end;
end.
