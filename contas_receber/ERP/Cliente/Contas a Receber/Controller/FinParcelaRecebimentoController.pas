{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Cliente relacionado � tabela [FIN_PARCELA_RECEBIMENTO] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2010 T2Ti.COM                                          
                                                                                
Permission is hereby granted, free of charge, to any person                     
obtaining a copy of this software and associated documentation                  
files (the "Software"), to deal in the Software without                         
restriction, including without limitation the rights to use,                    
copy, modify, merge, publish, distribute, sublicense, and/or sell               
copies of the Software, and to permit persons to whom the                       
Software is furnished to do so, subject to the following                        
conditions:                                                                     
                                                                                
The above copyright notice and this permission notice shall be                  
included in all copies or substantial portions of the Software.                 
                                                                                
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,                 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES                 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                        
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT                     
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,                    
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING                    
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR                   
OTHER DEALINGS IN THE SOFTWARE.                                                 
                                                                                
       The author may be contacted at:                                          
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (t2ti.com@gmail.com)                    
@version 1.0                                                                    
*******************************************************************************}
unit FinParcelaRecebimentoController;

interface

uses
  Classes, DBXJSON, DSHTTP, Dialogs, SysUtils, DBClient, DB, Windows, Forms, Controller,
  Rtti, Atributos, FinParcelaRecebimentoVO, FinParcelaReceberVO, FinChequeRecebidoVO,
  Generics.Collections;


type
  TFinParcelaRecebimentoController = class(TController)
  private
    class var FDataSet: TClientDataSet;
  public
    class procedure Consulta(pFiltro: String; pPagina: Integer);
    class function Insere(pFinParcelaRecebimento: TFinParcelaRecebimentoVO): Boolean;
    class function Altera(pFinParcelaReceber: TFinParcelaReceberVO; pFinParcelaRecebimento: TFinParcelaRecebimentoVO; pFinChequeRecebido: TFinChequeRecebidoVO): Boolean; overload;
    class function Altera(pListaParcelaReceber: TObjectList<TFinParcelaReceberVO>; pListaParcelaRecebimento: TObjectList<TFinParcelaRecebimentoVO>; pFinChequeRecebido: TFinChequeRecebidoVO): Boolean; overload;
    class function Exclui(pId: Integer): Boolean;

    class function GetDataSet: TClientDataSet; override;
    class procedure SetDataSet(pDataSet: TClientDataSet); override;

    class function MethodCtx: String; override;
  end;

implementation

uses UDataModule, Conversor;

class procedure TFinParcelaRecebimentoController.Consulta(pFiltro: String; pPagina: Integer);
var
  StreamResposta: TStringStream;
begin
  try
    StreamResposta := TStringStream.Create;
    try
      Get([pFiltro, IntToStr(pPagina)], StreamResposta);
      PopulaGrid<TFinParcelaRecebimentoVO>(StreamResposta);
    finally
      StreamResposta.Free;
    end;
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro durante a consulta. Informe a mensagem ao Administrador do sistema.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

class function TFinParcelaRecebimentoController.Insere(pFinParcelaRecebimento: TFinParcelaRecebimentoVO): Boolean;
var
  DataStream: TStringStream;
  StreamResposta: TStringStream;
  jRegistro: TJSONArray;
begin
  Result := False;
  try
    StreamResposta := TStringStream.Create;
    try
      DataStream := TStringStream.Create(pFinParcelaRecebimento.ToJSONString);
      try
        Put([], DataStream, StreamResposta);
      finally
        DataStream.Free;
      end;

      jRegistro := TConversor.JSONArrayStreamToJSONArray(StreamResposta);
      try
        if jRegistro.Size > 0 then
        begin
          Result := True;
          PopulaGrid<TFinParcelaRecebimentoVO>(StreamResposta);
        end;
      finally
        jRegistro.Free;
      end;
    finally
      StreamResposta.Free;
    end;
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro na inclus�o do registro. Informe a mensagem ao Administrador do sistema.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

class function TFinParcelaRecebimentoController.Altera(pFinParcelaReceber: TFinParcelaReceberVO; pFinParcelaRecebimento: TFinParcelaRecebimentoVO; pFinChequeRecebido: TFinChequeRecebidoVO): Boolean;
var
  DataStream: TStringStream;
  StreamResposta: TStringStream;
  ObjetosJson: TJSONArray;
begin
  try
    StreamResposta := TStringStream.Create;
    ObjetosJson := TJSONArray.Create;
    ObjetosJson.AddElement(pFinParcelaReceber.ToJSON);
    ObjetosJson.AddElement(pFinParcelaRecebimento.ToJSON);
    ObjetosJson.AddElement(pFinChequeRecebido.ToJSON);
    try
      DataStream := TStringStream.Create(ObjetosJson.ToString);
      try
        Post([], DataStream, StreamResposta);
      finally
        DataStream.Free;
        ObjetosJson.Free;
      end;
      Result := TConversor.JSONObjectStreamToBoolean(StreamResposta);
    finally
      StreamResposta.Free;
    end;
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro na altera��o do registro. Informe a mensagem ao Administrador do sistema.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

class function TFinParcelaRecebimentoController.Altera(pListaParcelaReceber: TObjectList<TFinParcelaReceberVO>; pListaParcelaRecebimento: TObjectList<TFinParcelaRecebimentoVO>; pFinChequeRecebido: TFinChequeRecebidoVO): Boolean;
var
  DataStream: TStringStream;
  StreamResposta: TStringStream;
  ObjetosJson, ListaParcelaReceber, ListaParcelaRecebimento: TJSONArray;
  i: Integer;
begin
  try
    StreamResposta := TStringStream.Create;
    ObjetosJson := TJSONArray.Create;
    ListaParcelaReceber := TJSONArray.Create;
    ListaParcelaRecebimento := TJSONArray.Create;

    for i := 0 to pListaParcelaReceber.Count - 1 do
    begin
      ListaParcelaReceber.AddElement(pListaParcelaReceber.Items[i].ToJSON);
    end;
    for i := 0 to pListaParcelaRecebimento.Count - 1 do
    begin
      ListaParcelaRecebimento.AddElement(pListaParcelaRecebimento.Items[i].ToJSON);
    end;

    ObjetosJson.AddElement(ListaParcelaReceber);
    ObjetosJson.AddElement(ListaParcelaRecebimento);
    ObjetosJson.AddElement(pFinChequeRecebido.ToJSON);
    try
      DataStream := TStringStream.Create(ObjetosJson.ToString);
      try
        Post('TFinParcelaRecebimentoController', 'FinParcelaRecebimentoCheque', [], DataStream, StreamResposta);
        //Post([], DataStream, StreamResposta);
      finally
        DataStream.Free;
        ObjetosJson.Free;
      end;
      Result := TConversor.JSONObjectStreamToBoolean(StreamResposta);
    finally
      StreamResposta.Free;
    end;
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro na altera��o do registro. Informe a mensagem ao Administrador do sistema.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

class function TFinParcelaRecebimentoController.Exclui(pId: Integer): Boolean;
begin
  try
    Result := TConversor.JSONPairStrToBoolean(Delete([IntToStr(pId)]));
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro na exclus�o do registro. Informe a mensagem ao Administrador do sistema.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

class function TFinParcelaRecebimentoController.GetDataSet: TClientDataSet;
begin
  Result := FDataSet;
end;

class procedure TFinParcelaRecebimentoController.SetDataSet(pDataSet: TClientDataSet);
begin
  FDataSet := pDataSet;
end;

class function TFinParcelaRecebimentoController.MethodCtx: String;
begin
  Result := 'FinParcelaRecebimento';
end;

end.