{*******************************************************************************
Title: T2Ti ERP
Description: Janela Cadastro de SituacaoColaborador

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
           t2ti.com@gmail.com</p>

t2ti.com@gmail.com | fernandololiver@gmail.com
@author Albert Eije (T2Ti.COM) | Fernando L Oliveira
@version 1.0
*******************************************************************************}
unit USituacaoColaborador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, SituacaoColaboradorVO,
  SituacaoColaboradorController, Tipos, Atributos, Constantes, LabeledCtrls;

type
  [TFormDescription(TConstantes.MODULO_CADASTROS,'Situacao Colaborador')]
  TFSituacaoColaborador = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditNome: TLabeledEdit;
    MemoDescricao: TLabeledMemo;
    EditCodigo: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;

    //Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;
  end;

var
  FSituacaoColaborador: TFSituacaoColaborador;

implementation

{$R *.dfm}

{$REGION 'Infra'}
procedure TFSituacaoColaborador.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TSituacaoColaboradorVO;
  ObjetoController := TSituacaoColaboradorController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFSituacaoColaborador.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditCodigo.SetFocus;
  end;
end;

function TFSituacaoColaborador.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditCodigo.SetFocus;
  end;
end;

function TFSituacaoColaborador.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TSituacaoColaboradorController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TSituacaoColaboradorController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFSituacaoColaborador.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TSituacaoColaboradorVO.Create;

      TSituacaoColaboradorVO(ObjetoVO).Codigo := EditCodigo.Text;
      TSituacaoColaboradorVO(ObjetoVO).Nome := EditNome.Text;
      TSituacaoColaboradorVO(ObjetoVO).Descricao := MemoDescricao.Text;

      if StatusTela = stInserindo then
        Result := TSituacaoColaboradorController(ObjetoController).Insere(TSituacaoColaboradorVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TSituacaoColaboradorVO(ObjetoVO).ToJSONString <> TSituacaoColaboradorVO(ObjetoOldVO).ToJSONString then
        begin
          TSituacaoColaboradorVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TSituacaoColaboradorController(ObjetoController).Altera(TSituacaoColaboradorVO(ObjetoVO), TSituacaoColaboradorVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
    except
      Result := False;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFSituacaoColaborador.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TSituacaoColaboradorVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoVO.Clone;
  end;

  if Assigned(ObjetoVO) then
  begin
    EditCodigo.Text := TSituacaoColaboradorVO(ObjetoVO).Codigo;
    EditNome.Text := TSituacaoColaboradorVO(ObjetoVO).Nome;
    MemoDescricao.Text := TSituacaoColaboradorVO(ObjetoVO).Descricao;
  end;
end;
{$ENDREGION}

end.
