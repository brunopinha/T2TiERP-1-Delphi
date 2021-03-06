{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela de Vendas

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

  @author Albert Eije
  @version 1.0
  ******************************************************************************* }
unit UVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, LabeledCtrls, Atributos, Constantes,
  Mask, JvExMask, JvToolEdit, JvBaseEdits, DB, DBClient, Generics.Collections,
  WideStrings, DBXMySql, FMTBcd, Provider, SqlExpr, StrUtils, ToolWin, ActnMan,
  ActnCtrls, ActnList, PlatformDefaultStyleActnCtrls;

type
  [TFormDescription(TConstantes.MODULO_VENDAS, 'Vendas')]

  TFVenda = class(TFTelaCadastro)
    CDSVendaDetalhe: TClientDataSet;
    DSVendaDetalhe: TDataSource;
    GroupBoxParcelas: TGroupBox;
    GridParcelas: TJvDBUltimGrid;
    ScrollBox1: TScrollBox;
    BevelEdits: TBevel;
    EditLocalEntrega: TLabeledEdit;
    MemoObservacao: TLabeledMemo;
    EditValorSubtotal: TLabeledCalcEdit;
    EditValorFrete: TLabeledCalcEdit;
    EditValorComissao: TLabeledCalcEdit;
    EditTaxaComissao: TLabeledCalcEdit;
    EditVendedor: TLabeledEdit;
    EditCliente: TLabeledEdit;
    EditCondicoesPagamento: TLabeledEdit;
    EditTransportadora: TLabeledEdit;
    ComboBoxTipoVenda: TLabeledComboBox;
    ComboBoxTipoFrete: TLabeledComboBox;
    EditDataVenda: TLabeledDateEdit;
    EditDataSaida: TLabeledDateEdit;
    EditValorDesconto: TLabeledCalcEdit;
    EditTaxaDesconto: TLabeledCalcEdit;
    EditValorTotal: TLabeledCalcEdit;
    EditIdVendedor: TLabeledCalcEdit;
    EditIdCliente: TLabeledCalcEdit;
    EditIdCondicoesPagamento: TLabeledCalcEdit;
    EditIdTransportadora: TLabeledCalcEdit;
    CDSVendaDetalheID: TIntegerField;
    CDSVendaDetalheID_PRODUTO: TIntegerField;
    CDSVendaDetalheID_VENDA_CABECALHO: TIntegerField;
    CDSVendaDetalheQUANTIDADE: TFloatField;
    CDSVendaDetalheVALOR_UNITARIO: TFloatField;
    CDSVendaDetalheVALOR_SUBTOTAL: TFloatField;
    CDSVendaDetalheTAXA_DESCONTO: TFloatField;
    CDSVendaDetalheVALOR_DESCONTO: TFloatField;
    CDSVendaDetalheVALOR_TOTAL: TFloatField;
    CDSVendaDetalheTAXA_COMISSAO: TFloatField;
    CDSVendaDetalheVALOR_COMISSAO: TFloatField;
    EditIdTipoNotaFiscal: TLabeledCalcEdit;
    EditTipoNotaFiscal: TLabeledEdit;
    EditIdOrcamentoVendaCabecalho: TLabeledCalcEdit;
    EditOrcamentoVendaCabecalho: TLabeledEdit;
    EditHoraSaida: TLabeledMaskEdit;
    EditNumeroFatura: TLabeledCalcEdit;
    EditLocalCobranca: TLabeledEdit;
    ComboBoxFormaPagamento: TLabeledComboBox;
    CDSVendaDetalhePRODUTONOME: TStringField;
    CDSVendaDetalhePERSISTE: TStringField;
    ActionManager1: TActionManager;
    ActionAtualizarTotais: TAction;
    ActionToolBar1: TActionToolBar;
    CDSOrcamentoPedidoVendaDet: TClientDataSet;
    CDSOrcamentoPedidoVendaDetID: TIntegerField;
    CDSOrcamentoPedidoVendaDetID_PRODUTO: TIntegerField;
    CDSOrcamentoPedidoVendaDetID_VENDA_ORCAMENTO_CABECALHO: TIntegerField;
    CDSOrcamentoPedidoVendaDetQUANTIDADE: TFMTBCDField;
    CDSOrcamentoPedidoVendaDetVALOR_UNITARIO: TFMTBCDField;
    CDSOrcamentoPedidoVendaDetVALOR_SUBTOTAL: TFMTBCDField;
    CDSOrcamentoPedidoVendaDetTAXA_DESCONTO: TFMTBCDField;
    CDSOrcamentoPedidoVendaDetVALOR_DESCONTO: TFMTBCDField;
    CDSOrcamentoPedidoVendaDetVALOR_TOTAL: TFMTBCDField;
    CDSOrcamentoPedidoVendaDetVALOR_IPI: TFMTBCDField;
    CDSOrcamentoPedidoVendaDetVALOR_ICMS_ST: TFMTBCDField;
    CDSOrcamentoPedidoVendaDetPRODUTONOME: TStringField;
    CDSOrcamentoPedidoVendaDetPERSISTE: TStringField;
    DSOrcamentoPedidoVendaDet: TDataSource;
    ActionAdicionarProduto: TAction;
    EditValorSeguro: TLabeledCalcEdit;
    ActionExcluirItem: TAction;
    procedure FormCreate(Sender: TObject);
    procedure EditIdVendedorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdTransportadoraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdCondicoesPagamentoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdCondicoesPagamentoExit(Sender: TObject);
    procedure EditTaxaDescontoExit(Sender: TObject);
    procedure CDSVendaDetalheBeforePost(DataSet: TDataSet);
    procedure EditIdOrcamentoVendaCabecalhoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdTipoNotaFiscalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ComboBoxTipoVendaChange(Sender: TObject);
    procedure EditIdVendedorExit(Sender: TObject);
    procedure EditIdClienteExit(Sender: TObject);
    procedure EditIdTransportadoraExit(Sender: TObject);
    procedure EditIdTipoNotaFiscalExit(Sender: TObject);
    procedure EditIdOrcamentoVendaCabecalhoExit(Sender: TObject);
    procedure CDSVendaDetalheAfterEdit(DataSet: TDataSet);
    procedure EditIdOrcamentoVendaCabecalhoKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdTipoNotaFiscalKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdClienteKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdCondicoesPagamentoKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdTransportadoraKeyPress(Sender: TObject; var Key: Char);
    procedure ActionAtualizarTotaisExecute(Sender: TObject);
    procedure GridParcelasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ActionAdicionarProdutoExecute(Sender: TObject);
    procedure ActionExcluirItemExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure LimparCampos; override;
    procedure ControlaBotoes; override;
    procedure ControlaPopupMenu; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;
    procedure HabilitarEditVendaOrcamento;
  end;

var
  FVenda: TFVenda;

implementation

uses VendaCabecalhoController, VendaCabecalhoVO, NotificationService,
  VendaDetalheVO, ULookup, VendedorVO, VendedorController, VendaCondicoesPagamentoVO,
  VendaCondicoesPagamentoController, VendaOrcamentoCabecalhoVO, TipoNotaFiscalVO,
  VendaOrcamentoCabecalhoController, TipoNotaFiscalController, TransportadoraVO,
  TransportadoraController, ClienteVO, ClienteController, VendaComissaoVO,
  ProdutoVO, ProdutoController, VendaOrcamentoDetalheController, VendaDetalheController;
{$R *.dfm}
//

{$REGION 'Infra'}
procedure TFVenda.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TVendaCabecalhoVO;
  ObjetoController := TVendaCabecalhoController.Create;

  inherited;
end;

procedure TFVenda.ComboBoxTipoVendaChange(Sender: TObject);
begin
  HabilitarEditVendaOrcamento;
  if ComboBoxTipoVenda.ItemIndex = 0 then
    EditIdOrcamentoVendaCabecalho.SetFocus
  else
    EditIdTipoNotaFiscal.SetFocus;
end;

procedure TFVenda.EditTaxaDescontoExit(Sender: TObject);
begin
  EditValorDesconto.Value := EditValorSubtotal.Value * (EditTaxaDesconto.Value / 100);
  EditValorTotal.Value := EditValorSubtotal.Value - EditValorDesconto.Value;
end;

procedure TFVenda.LimparCampos;
begin
  inherited;
  CDSVendaDetalhe.EmptyDataSet;
end;

procedure TFVenda.ControlaBotoes;
begin
  inherited;

  BotaoImprimir.Visible := False;
end;

procedure TFVenda.ControlaPopupMenu;
begin
  inherited;

  MenuImprimir.Visible := False;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFVenda.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    ComboBoxTipoVenda.SetFocus;
  end;
end;

function TFVenda.DoEditar: Boolean;
var
  Mensagem: String;
begin
  if CDSGrid.FieldByName('SITUACAO').AsString <> 'D' then
  begin
    case AnsiIndexStr(CDSGrid.FieldByName('SITUACAO').AsString, ['P', 'X', 'F', 'E']) of
      0:
        Mensagem := ' - Situa��o: Em Produ��o';
      1:
        Mensagem := ' - Situa��o: Em Expedi��o';
      2:
        Mensagem := ' - Situa��o: Faturado';
      3:
        Mensagem := ' - Situa��o: Entregue';
    end;

    Application.MessageBox(PChar('Esse registro n�o pode ser alterado' + Mensagem), 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    Exit(False);
  end;

  Result := inherited DoEditar;

  if Result then
  begin
    ComboBoxTipoVenda.SetFocus;
  end;
end;

function TFVenda.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TVendaCabecalhoController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TVendaCabecalhoController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFVenda.DoSalvar: Boolean;
var
  VendaDetalhe: TVendaDetalheVO;
  VendaComissao: TVendaComissaoVO;
begin
  try
    DecimalSeparator := '.';

    if EditIdCondicoesPagamento.AsInteger <= 0 then
    begin
      Application.MessageBox('� necess�rio informar as condi��es de pagamento.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      EditIdCondicoesPagamento.SetFocus;
      Exit(False);
    end;
    if EditIdTipoNotaFiscal.AsInteger <= 0 then
    begin
      Application.MessageBox('� necess�rio informar o tipo de nota fiscal.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      EditIdTipoNotaFiscal.SetFocus;
      Exit(False);
    end;
    if EditIdCliente.AsInteger <= 0 then
    begin
      Application.MessageBox('� necess�rio informar o cliente.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      EditIdCliente.SetFocus;
      Exit(False);
    end;
    if EditIdVendedor.AsInteger <= 0 then
    begin
      Application.MessageBox('� necess�rio informar o vendedor.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      EditIdVendedor.SetFocus;
      Exit(False);
    end;

    Result := inherited DoSalvar;

    if Result then
    begin
      try
        if not Assigned(ObjetoVO) then
          ObjetoVO := TVendaCabecalhoVO.Create;

        ActionAtualizarTotais.Execute;

        TVendaCabecalhoVO(ObjetoVO).IdTipoNotaFiscal := EditIdTipoNotaFiscal.AsInteger;
        TVendaCabecalhoVO(ObjetoVO).TipoNotaFiscalModelo := EditTipoNotaFiscal.Text;
        TVendaCabecalhoVO(ObjetoVO).IdVendedor := EditIdVendedor.AsInteger;
        TVendaCabecalhoVO(ObjetoVO).VendedorNome := EditVendedor.Text;
        TVendaCabecalhoVO(ObjetoVO).IdTransportadora := EditIdTransportadora.AsInteger;
        TVendaCabecalhoVO(ObjetoVO).TransportadoraNome := EditTransportadora.Text;
        TVendaCabecalhoVO(ObjetoVO).IdCliente := EditIdCliente.AsInteger;
        TVendaCabecalhoVO(ObjetoVO).ClienteNome := EditCliente.Text;
        TVendaCabecalhoVO(ObjetoVO).IdVendaCondicoesPagamento := EditIdCondicoesPagamento.AsInteger;
        TVendaCabecalhoVO(ObjetoVO).VendaCondicoesPagamentoNome := EditCondicoesPagamento.Text;
        TVendaCabecalhoVO(ObjetoVO).IdOrcamentoVendaCabecalho := EditIdOrcamentoVendaCabecalho.AsInteger;
        TVendaCabecalhoVO(ObjetoVO).VendaOrcamentoCabecalhoCodigo := EditOrcamentoVendaCabecalho.Text;
        TVendaCabecalhoVO(ObjetoVO).DataVenda := EditDataVenda.Date;
        TVendaCabecalhoVO(ObjetoVO).DataSaida := EditDataSaida.Date;
        TVendaCabecalhoVO(ObjetoVO).HoraSaida := EditHoraSaida.Text;
        TVendaCabecalhoVO(ObjetoVO).NumeroFatura := EditNumeroFatura.AsInteger;
        TVendaCabecalhoVO(ObjetoVO).LocalEntrega := EditLocalEntrega.Text;
        TVendaCabecalhoVO(ObjetoVO).LocalCobranca := EditLocalCobranca.Text;
        TVendaCabecalhoVO(ObjetoVO).ValorSubtotal := EditValorSubtotal.Value;
        TVendaCabecalhoVO(ObjetoVO).TaxaComissao := EditTaxaComissao.Value;
        TVendaCabecalhoVO(ObjetoVO).ValorComissao := EditValorComissao.Value;
        TVendaCabecalhoVO(ObjetoVO).TaxaDesconto := EditTaxaDesconto.Value;
        TVendaCabecalhoVO(ObjetoVO).ValorDesconto := EditValorDesconto.Value;
        TVendaCabecalhoVO(ObjetoVO).ValorTotal := EditValorTotal.Value;
        TVendaCabecalhoVO(ObjetoVO).TipoFrete := IfThen(ComboBoxTipoFrete.ItemIndex = 0, 'C', 'F');
        TVendaCabecalhoVO(ObjetoVO).FormaPagamento := Copy(ComboBoxFormaPagamento.Text, 1, 1);
        TVendaCabecalhoVO(ObjetoVO).ValorFrete := EditValorFrete.Value;
        TVendaCabecalhoVO(ObjetoVO).ValorSeguro := EditValorSeguro.Value;
        TVendaCabecalhoVO(ObjetoVO).Observacao := MemoObservacao.Text;
        TVendaCabecalhoVO(ObjetoVO).Situacao := 'D';

        if StatusTela = stEditando then
          TVendaCabecalhoVO(ObjetoVO).Id := IdRegistroSelecionado;

        // Itens da venda
        TVendaCabecalhoVO(ObjetoVO).ListaVendaDetalheVO := TObjectList<TVendaDetalheVO>.Create;
        CDSVendaDetalhe.DisableControls;
        CDSVendaDetalhe.First;
        while not CDSVendaDetalhe.Eof do
        begin
          if (CDSVendaDetalhePERSISTE.AsString = 'S') or (CDSVendaDetalheID.AsInteger = 0) then
          begin
            VendaDetalhe := TVendaDetalheVO.Create;
            VendaDetalhe.Id := CDSVendaDetalheID.AsInteger;
            VendaDetalhe.IdVendaCabecalho := TVendaCabecalhoVO(ObjetoVO).Id;
            VendaDetalhe.IdProduto := CDSVendaDetalheID_PRODUTO.AsInteger;
            VendaDetalhe.Quantidade := CDSVendaDetalheQUANTIDADE.AsExtended;
            VendaDetalhe.ValorUnitario := CDSVendaDetalheVALOR_UNITARIO.AsExtended;
            VendaDetalhe.ValorSubtotal := CDSVendaDetalheVALOR_SUBTOTAL.AsExtended;
            VendaDetalhe.TaxaDesconto := CDSVendaDetalheTAXA_DESCONTO.AsExtended;
            VendaDetalhe.ValorDesconto := CDSVendaDetalheVALOR_DESCONTO.AsExtended;
            VendaDetalhe.ValorTotal := CDSVendaDetalheVALOR_TOTAL.AsExtended;
            VendaDetalhe.TaxaComissao := CDSVendaDetalheTAXA_COMISSAO.AsExtended;
            VendaDetalhe.ValorComissao := CDSVendaDetalheVALOR_COMISSAO.AsExtended;
            TVendaCabecalhoVO(ObjetoVO).ListaVendaDetalheVO.Add(VendaDetalhe);
          end;

          CDSVendaDetalhe.Next;
        end;
        CDSVendaDetalhe.EnableControls;

        // ObjetoVO - libera objetos vinculados (TAssociation) - n�o tem necessidade de subir
        TVendaCabecalhoVO(ObjetoVO).VendaCondicoesPagamentoVO := Nil;
        TVendaCabecalhoVO(ObjetoVO).TipoNotaFiscalVO := Nil;
        TVendaCabecalhoVO(ObjetoVO).VendedorVO := Nil;
        TVendaCabecalhoVO(ObjetoVO).ClienteVO := Nil;
        TVendaCabecalhoVO(ObjetoVO).VendaCondicoesPagamentoVO := Nil;
        TVendaCabecalhoVO(ObjetoVO).TransportadoraVO := Nil;

        // ObjetoOldVO - libera objetos vinculados (TAssociation) - n�o tem necessidade de subir
        if Assigned(ObjetoOldVO) then
        begin
          TVendaCabecalhoVO(ObjetoOldVO).VendaCondicoesPagamentoVO := Nil;
          TVendaCabecalhoVO(ObjetoOldVO).TipoNotaFiscalVO := Nil;
          TVendaCabecalhoVO(ObjetoOldVO).VendedorVO := Nil;
          TVendaCabecalhoVO(ObjetoOldVO).ClienteVO := Nil;
          TVendaCabecalhoVO(ObjetoOldVO).VendaCondicoesPagamentoVO := Nil;
          TVendaCabecalhoVO(ObjetoOldVO).TransportadoraVO := Nil;
        end;

        if StatusTela = stInserindo then
          Result := TVendaCabecalhoController(ObjetoController).Insere(TVendaCabecalhoVO(ObjetoVO))
        else if StatusTela = stEditando then
        begin
          if TVendaCabecalhoVO(ObjetoVO).ToJSONString <> TVendaCabecalhoVO(ObjetoOldVO).ToJSONString then
          begin
            TVendaCabecalhoVO(ObjetoVO).Id := IdRegistroSelecionado;
            Result := TVendaCabecalhoController(ObjetoController).Altera(TVendaCabecalhoVO(ObjetoVO), TVendaCabecalhoVO(ObjetoOldVO));
          end
          else
            Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
        end;
      except
        Result := False;
      end;
    end;
  finally
    DecimalSeparator := ',';
  end;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
// Or�amento
procedure TFVenda.EditIdOrcamentoVendaCabecalhoExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdOrcamentoVendaCabecalho.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdOrcamentoVendaCabecalho.Text +  ' AND SITUACAO = ' + QuotedStr('D');
      EditIdOrcamentoVendaCabecalho.Clear;
      EditOrcamentoVendaCabecalho.Clear;
      if not PopulaCamposTransientes(Filtro, TVendaOrcamentoCabecalhoVO, TVendaOrcamentoCabecalhoController) then
        PopulaCamposTransientesLookup(TVendaOrcamentoCabecalhoVO, TVendaOrcamentoCabecalhoController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdOrcamentoVendaCabecalho.Text := CDSTransiente.FieldByName('ID').AsString;
        EditOrcamentoVendaCabecalho.Text := CDSTransiente.FieldByName('CODIGO').AsString;
        // Vendedor
        EditIdVendedor.Text := CDSTransiente.FieldByName('ID_VENDEDOR').AsString;
        EditVendedor.Text := CDSTransiente.FieldByName('VENDEDOR.NOME').AsString;
        // Cliente
        EditIdCliente.Text := CDSTransiente.FieldByName('ID_CLIENTE').AsString;
        EditCliente.Text := CDSTransiente.FieldByName('CLIENTE.NOME').AsString;
        // Condicoes Pagamento
        EditIdCondicoesPagamento.Text := CDSTransiente.FieldByName('ID_VENDA_CONDICOES_PAGAMENTO').AsString;
        EditCondicoesPagamento.Text := CDSTransiente.FieldByName('CONDICOESPAGAMENTO.NOME').AsString;
        // Transportadora
        EditIdTransportadora.Text := CDSTransiente.FieldByName('ID_TRANSPORTADORA').AsString;
        EditTransportadora.Text := CDSTransiente.FieldByName('TRANSPORTADORA.NOME').AsString;
        // Frete
        EditValorFrete.Value := CDSTransiente.FieldByName('VALOR_FRETE').AsExtended;
        ComboBoxTipoFrete.ItemIndex := AnsiIndexStr(CDSTransiente.FieldByName('TIPO_FRETE').AsString, ['C', 'F']);
        // Valores
        EditValorSubtotal.Value := CDSTransiente.FieldByName('VALOR_SUBTOTAL').AsExtended;
        EditTaxaComissao.Value := CDSTransiente.FieldByName('TAXA_COMISSAO').AsExtended;
        EditValorComissao.Value := CDSTransiente.FieldByName('VALOR_COMISSAO').AsExtended;
        EditTaxaDesconto.Value := CDSTransiente.FieldByName('TAXA_DESCONTO').AsExtended;
        EditValorDesconto.Value := CDSTransiente.FieldByName('VALOR_DESCONTO').AsExtended;
        EditValorTotal.Value := CDSTransiente.FieldByName('VALOR_TOTAL').AsExtended;

        MemoObservacao.Text := CDSTransiente.FieldByName('OBSERVACAO').AsString;

        // Detalhes
        if StatusTela = stInserindo then
        begin
          CDSVendaDetalhe.EmptyDataSet;
          TVendaOrcamentoDetalheController.SetDataSet(CDSOrcamentoPedidoVendaDet);
          TVendaOrcamentoDetalheController.Consulta('ID_VENDA_ORCAMENTO_CABECALHO=' + QuotedStr(EditIdOrcamentoVendaCabecalho.Text), 0);
          while not CDSOrcamentoPedidoVendaDet.Eof do
          begin
            CDSVendaDetalhe.Append;
            CDSVendaDetalheID_PRODUTO.AsInteger := CDSOrcamentoPedidoVendaDetID_PRODUTO.AsInteger;
            CDSVendaDetalhePRODUTONOME.AsString := CDSOrcamentoPedidoVendaDetPRODUTONOME.AsString;
            CDSVendaDetalheQUANTIDADE.AsExtended := CDSOrcamentoPedidoVendaDetQUANTIDADE.AsExtended;
            CDSVendaDetalheVALOR_UNITARIO.AsExtended := CDSOrcamentoPedidoVendaDetVALOR_UNITARIO.AsExtended;
            CDSVendaDetalheVALOR_SUBTOTAL.AsExtended := CDSOrcamentoPedidoVendaDetVALOR_SUBTOTAL.AsExtended;
            CDSVendaDetalheTAXA_DESCONTO.AsExtended := CDSOrcamentoPedidoVendaDetTAXA_DESCONTO.AsExtended;
            CDSVendaDetalheVALOR_DESCONTO.AsExtended := CDSOrcamentoPedidoVendaDetVALOR_DESCONTO.AsExtended;
            CDSVendaDetalheVALOR_TOTAL.AsExtended := CDSOrcamentoPedidoVendaDetVALOR_TOTAL.AsExtended;
            CDSVendaDetalhe.Post;

            CDSOrcamentoPedidoVendaDet.Next;
          end;
        end;
        //
        HabilitarEditVendaOrcamento;
      end
      else
      begin
        Exit;
        EditIdOrcamentoVendaCabecalho.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditOrcamentoVendaCabecalho.Clear;
  end;
end;

procedure TFVenda.EditIdOrcamentoVendaCabecalhoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdOrcamentoVendaCabecalho.Value := -1;
    EditIdTipoNotaFiscal.SetFocus;
  end;
end;

procedure TFVenda.EditIdOrcamentoVendaCabecalhoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdTipoNotaFiscal.SetFocus;
  end;
end;

// Tipo de Nota Fiscal
procedure TFVenda.EditIdTipoNotaFiscalExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdTipoNotaFiscal.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdTipoNotaFiscal.Text;
      EditIdTipoNotaFiscal.Clear;
      EditTipoNotaFiscal.Clear;
      if not PopulaCamposTransientes(Filtro, TTipoNotaFiscalVO, TTipoNotaFiscalController) then
        PopulaCamposTransientesLookup(TTipoNotaFiscalVO, TTipoNotaFiscalController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdTipoNotaFiscal.Text := CDSTransiente.FieldByName('ID').AsString;
        EditTipoNotaFiscal.Text := CDSTransiente.FieldByName('MODELO').AsString;
      end
      else
      begin
        Exit;
        EditIdTipoNotaFiscal.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditTipoNotaFiscal.Clear;
  end;
end;

procedure TFVenda.EditIdTipoNotaFiscalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdTipoNotaFiscal.Value := -1;
    if ComboBoxTipoVenda.ItemIndex = 1 then
      EditIdVendedor.SetFocus
    else
      ComboBoxTipoFrete.SetFocus;
  end;
end;

procedure TFVenda.EditIdTipoNotaFiscalKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if ComboBoxTipoVenda.ItemIndex = 1 then
      EditIdVendedor.SetFocus
    else
      ComboBoxTipoFrete.SetFocus;
  end;
end;

// Vendedor
procedure TFVenda.EditIdVendedorExit(Sender: TObject);
var
  Filtro: String;
begin
  if ComboBoxTipoVenda.ItemIndex = 1 then
  begin
    if EditIdVendedor.Value <> 0 then
    begin
      try
        Filtro := 'ID = ' + EditIdVendedor.Text;
        EditIdVendedor.Clear;
        EditVendedor.Clear;
        if not PopulaCamposTransientes(Filtro, TVendedorVO, TVendedorController) then
          PopulaCamposTransientesLookup(TVendedorVO, TVendedorController);
        if CDSTransiente.RecordCount > 0 then
        begin
          EditIdVendedor.Text := CDSTransiente.FieldByName('ID').AsString;
          EditVendedor.Text := CDSTransiente.FieldByName('COLABORADORPESSOA.NOME').AsString;
          EditTaxaComissao.Value := CDSTransiente.FieldByName('COMISSAO').AsExtended;
        end
        else
        begin
          Exit;
          EditIdVendedor.SetFocus;
        end;
      finally
        CDSTransiente.Close;
      end;
    end
    else
    begin
      EditVendedor.Clear;
    end;
  end;
end;

procedure TFVenda.EditIdVendedorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ComboBoxTipoVenda.ItemIndex = 1 then
  begin
    if Key = VK_F1 then
    begin
      EditIdVendedor.Value := -1;
      EditIdCliente.SetFocus;
    end;
  end;
end;

procedure TFVenda.EditIdVendedorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdCliente.SetFocus;
  end;
end;

// Cliente
procedure TFVenda.EditIdClienteExit(Sender: TObject);
var
  Filtro: String;
begin
  if ComboBoxTipoVenda.ItemIndex = 1 then
  begin
    if EditIdCliente.Value <> 0 then
    begin
      try
        Filtro := 'ID = ' + EditIdCliente.Text;
        EditIdCliente.Clear;
        EditCliente.Clear;
        if not PopulaCamposTransientes(Filtro, TClienteVO, TClienteController) then
          PopulaCamposTransientesLookup(TClienteVO, TClienteController);
        if CDSTransiente.RecordCount > 0 then
        begin
          EditIdCliente.Text := CDSTransiente.FieldByName('ID').AsString;
          EditCliente.Text := CDSTransiente.FieldByName('PESSOA.NOME').AsString;
        end
        else
        begin
          Exit;
          EditIdCliente.SetFocus;
        end;
      finally
        CDSTransiente.Close;
      end;
    end
    else
    begin
      EditCliente.Clear;
    end;
  end;
end;

procedure TFVenda.EditIdClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ComboBoxTipoVenda.ItemIndex = 1 then
  begin
    if Key = VK_F1 then
    begin
      EditIdCliente.Value := -1;
      EditIdCondicoesPagamento.SetFocus;
    end;
  end;
end;

procedure TFVenda.EditIdClienteKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdCondicoesPagamento.SetFocus;
  end;
end;

// Condicoes Pagamentos
procedure TFVenda.EditIdCondicoesPagamentoExit(Sender: TObject);
var
  Filtro: String;
begin
  if ComboBoxTipoVenda.ItemIndex = 1 then
  begin
    if EditIdCondicoesPagamento.Value <> 0 then
    begin
      try
        Filtro := 'ID = ' + EditIdCondicoesPagamento.Text;
        EditIdCondicoesPagamento.Clear;
        EditCondicoesPagamento.Clear;
        if not PopulaCamposTransientes(Filtro, TVendaCondicoesPagamentoVO, TVendaCondicoesPagamentoController) then
          PopulaCamposTransientesLookup(TVendaCondicoesPagamentoVO, TVendaCondicoesPagamentoController);
        if CDSTransiente.RecordCount > 0 then
        begin
          EditIdCondicoesPagamento.Text := CDSTransiente.FieldByName('ID').AsString;
          EditCondicoesPagamento.Text := CDSTransiente.FieldByName('NOME').AsString;
        end
        else
        begin
          Exit;
          EditIdCondicoesPagamento.SetFocus;
        end;
      finally
        CDSTransiente.Close;
      end;
    end
    else
    begin
      EditCondicoesPagamento.Clear;
    end;
  end;
end;

procedure TFVenda.EditIdCondicoesPagamentoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdCondicoesPagamento.Value := -1;
    EditIdTransportadora.SetFocus;
  end;
end;

procedure TFVenda.EditIdCondicoesPagamentoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdTransportadora.SetFocus;
  end;
end;

// Transportadora
procedure TFVenda.EditIdTransportadoraExit(Sender: TObject);
var
  Filtro: String;
begin
  if ComboBoxTipoVenda.ItemIndex = 1 then
  begin
    if EditIdTransportadora.Value <> 0 then
    begin
      try
        Filtro := 'ID = ' + EditIdTransportadora.Text;
        EditIdTransportadora.Clear;
        EditTransportadora.Clear;
        if not PopulaCamposTransientes(Filtro, TTransportadoraVO, TTransportadoraController) then
          PopulaCamposTransientesLookup(TTransportadoraVO, TTransportadoraController);
        if CDSTransiente.RecordCount > 0 then
        begin
          EditIdTransportadora.Text := CDSTransiente.FieldByName('ID').AsString;
          EditTransportadora.Text := CDSTransiente.FieldByName('PESSOA.NOME').AsString;
        end
        else
        begin
          Exit;
          EditIdTransportadora.SetFocus;
        end;
      finally
        CDSTransiente.Close;
      end;
    end
    else
    begin
      EditTransportadora.Clear;
    end;
  end;
end;

procedure TFVenda.EditIdTransportadoraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdTransportadora.Value := -1;
    ComboBoxTipoFrete.SetFocus;
  end;
end;

procedure TFVenda.EditIdTransportadoraKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    ComboBoxTipoFrete.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFVenda.GridParaEdits;
var
  VendaDetEnumerator: TEnumerator<TVendaDetalheVO>;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TVendaCabecalhoVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TVendaCabecalhoVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin

    if TVendaCabecalhoVO(ObjetoVO).IdOrcamentoVendaCabecalho = 0 then
      ComboBoxTipoVenda.ItemIndex := 0
    else
    begin
      ComboBoxTipoVenda.ItemIndex := 1;
      EditIdOrcamentoVendaCabecalho.AsInteger := TVendaCabecalhoVO(ObjetoVO).IdOrcamentoVendaCabecalho;
      EditOrcamentoVendaCabecalho.Text := TVendaCabecalhoVO(ObjetoVO).VendaOrcamentoCabecalhoCodigo;
    end;

    EditIdVendedor.AsInteger := TVendaCabecalhoVO(ObjetoVO).IdVendedor;
    EditVendedor.Text := TVendaCabecalhoVO(ObjetoVO).VendedorVO.ColaboradorVO.PessoaVO.Nome;
    EditIdTransportadora.AsInteger := TVendaCabecalhoVO(ObjetoVO).IdTransportadora;
    EditTransportadora.Text := TVendaCabecalhoVO(ObjetoVO).TransportadoraVO.PessoaVO.Nome;
    EditIdCliente.AsInteger := TVendaCabecalhoVO(ObjetoVO).IdCliente;
    EditCliente.Text := TVendaCabecalhoVO(ObjetoVO).ClienteVO.PessoaVO.Nome;
    EditIdCondicoesPagamento.AsInteger := TVendaCabecalhoVO(ObjetoVO).IdVendaCondicoesPagamento;
    EditCondicoesPagamento.Text := TVendaCabecalhoVO(ObjetoVO).VendaCondicoesPagamentoVO.Nome;
    EditIdTipoNotaFiscal.AsInteger := TVendaCabecalhoVO(ObjetoVO).IdTipoNotaFiscal;
    EditTipoNotaFiscal.Text := TVendaCabecalhoVO(ObjetoVO).TipoNotaFiscalModelo;
    EditDataVenda.Date := TVendaCabecalhoVO(ObjetoVO).DataVenda;
    EditDataSaida.Date := TVendaCabecalhoVO(ObjetoVO).DataSaida;
    EditHoraSaida.Text := TVendaCabecalhoVO(ObjetoVO).HoraSaida;
    EditNumeroFatura.AsInteger := TVendaCabecalhoVO(ObjetoVO).NumeroFatura;
    EditLocalEntrega.Text := TVendaCabecalhoVO(ObjetoVO).LocalEntrega;
    EditLocalCobranca.Text := TVendaCabecalhoVO(ObjetoVO).LocalCobranca;
    EditValorSubtotal.Value := TVendaCabecalhoVO(ObjetoVO).ValorSubtotal;
    EditTaxaComissao.Value := TVendaCabecalhoVO(ObjetoVO).TaxaComissao;
    EditValorComissao.Value := TVendaCabecalhoVO(ObjetoVO).ValorComissao;
    EditTaxaDesconto.Value := TVendaCabecalhoVO(ObjetoVO).TaxaDesconto;
    EditValorDesconto.Value := TVendaCabecalhoVO(ObjetoVO).ValorDesconto;
    EditValorTotal.Value := TVendaCabecalhoVO(ObjetoVO).ValorTotal;
    EditValorFrete.Value := TVendaCabecalhoVO(ObjetoVO).ValorFrete;
    EditValorSeguro.Value := TVendaCabecalhoVO(ObjetoVO).ValorSeguro;

    ComboBoxTipoFrete.ItemIndex := AnsiIndexStr(TVendaCabecalhoVO(ObjetoVO).TipoFrete, ['C', 'F']);

    ComboBoxFormaPagamento.ItemIndex := StrToInt(TVendaCabecalhoVO(ObjetoVO).FormaPagamento);
    MemoObservacao.Text := TVendaCabecalhoVO(ObjetoVO).Observacao;

    // Itens da venda
    VendaDetEnumerator := TVendaCabecalhoVO(ObjetoVO).ListaVendaDetalheVO.GetEnumerator;
    try
      with VendaDetEnumerator do
      begin
        while MoveNext do
        begin
          CDSVendaDetalhe.Append;

          CDSVendaDetalheID.AsInteger := Current.Id;
          CDSVendaDetalheID_VENDA_CABECALHO.AsInteger := Current.IdVendaCabecalho;
          CDSVendaDetalheID_PRODUTO.AsInteger := Current.IdProduto;
          CDSVendaDetalheQUANTIDADE.AsExtended := Current.Quantidade;
          CDSVendaDetalheVALOR_UNITARIO.AsExtended := Current.ValorUnitario;
          CDSVendaDetalheVALOR_SUBTOTAL.AsExtended := Current.ValorSubtotal;
          CDSVendaDetalheTAXA_DESCONTO.AsExtended := Current.TaxaDesconto;
          CDSVendaDetalheVALOR_DESCONTO.AsExtended := Current.ValorDesconto;
          CDSVendaDetalheVALOR_TOTAL.AsExtended := Current.ValorTotal;
          CDSVendaDetalheTAXA_COMISSAO.AsExtended := Current.TaxaComissao;
          CDSVendaDetalheVALOR_COMISSAO.AsExtended := Current.ValorComissao;

          CDSVendaDetalhe.Post;
        end;
      end;
    finally
      VendaDetEnumerator.Free;
    end;
    TVendaCabecalhoVO(ObjetoVO).ListaVendaDetalheVO := Nil;
    if Assigned(TVendaCabecalhoVO(ObjetoOldVO)) then
      TVendaCabecalhoVO(ObjetoOldVO).ListaVendaDetalheVO := Nil;
  end;
end;

procedure TFVenda.GridParcelasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Filtro: String;
begin
  if Key = VK_F1 then
  begin
    ActionAdicionarProduto.Execute;
  end;
  If Key = VK_RETURN then
    EditIdVendedor.SetFocus;
end;

procedure TFVenda.CDSVendaDetalheAfterEdit(DataSet: TDataSet);
begin
  CDSVendaDetalhePERSISTE.AsString := 'S';
end;

procedure TFVenda.CDSVendaDetalheBeforePost(DataSet: TDataSet);
begin
  CDSVendaDetalheVALOR_SUBTOTAL.AsExtended := CDSVendaDetalheQUANTIDADE.AsExtended * CDSVendaDetalheVALOR_UNITARIO.AsExtended;
  CDSVendaDetalheVALOR_DESCONTO.AsExtended := CDSVendaDetalheVALOR_SUBTOTAL.AsExtended * (CDSVendaDetalheTAXA_DESCONTO.AsExtended / 100);
  CDSVendaDetalheVALOR_TOTAL.AsExtended := CDSVendaDetalheVALOR_SUBTOTAL.AsExtended - CDSVendaDetalheVALOR_DESCONTO.AsExtended;
end;
{$ENDREGION}

{$REGION 'Actions'}
procedure TFVenda.HabilitarEditVendaOrcamento;
begin
  if ComboBoxTipoVenda.ItemIndex = 0 then
  // Se or�amento desabilita edits
  begin
    EditIdOrcamentoVendaCabecalho.ReadOnly := False;
    EditIdVendedor.ReadOnly := True;
    EditIdCliente.ReadOnly := True;
    EditIdCondicoesPagamento.ReadOnly := True;
    EditIdTransportadora.ReadOnly := True;
  end
  else
  // Se venda direta habilita Edits.
  begin
    EditIdOrcamentoVendaCabecalho.Clear;
    EditIdVendedor.Clear;
    EditIdCliente.Clear;
    EditIdCondicoesPagamento.Clear;
    EditIdTransportadora.Clear;
    EditOrcamentoVendaCabecalho.Clear;
    EditVendedor.Clear;
    EditCliente.Clear;
    EditCondicoesPagamento.Clear;
    EditTransportadora.Clear;
    EditIdOrcamentoVendaCabecalho.ReadOnly := True;
    EditIdVendedor.ReadOnly := False;
    EditIdCliente.ReadOnly := False;
    EditIdCondicoesPagamento.ReadOnly := False;
    EditIdTransportadora.ReadOnly := False;
  end;
end;

procedure TFVenda.ActionAdicionarProdutoExecute(Sender: TObject);
begin
  try
    PopulaCamposTransientesLookup(TProdutoVO, TProdutoController);
    if CDSTransiente.RecordCount > 0 then
    begin
      CDSVendaDetalhe.Append;
      CDSVendaDetalheID_PRODUTO.AsInteger := CDSTransiente.FieldByName('ID').AsInteger;
      CDSVendaDetalheProdutoNome.AsString := CDSTransiente.FieldByName('NOME').AsString;
      CDSVendaDetalheVALOR_UNITARIO.AsExtended := CDSTransiente.FieldByName('VALOR_VENDA').AsExtended;
    end;
  finally
    CDSTransiente.Close;
  end;
end;

procedure TFVenda.ActionAtualizarTotaisExecute(Sender: TObject);
var
  SubTotal, TotalDesconto: Extended;
begin
  SubTotal := 0;
  TotalDesconto := 0;
  //
  CDSVendaDetalhe.DisableControls;
  CDSVendaDetalhe.First;
  while not CDSVendaDetalhe.Eof do
  begin
    SubTotal := SubTotal + CDSVendaDetalheVALOR_SUBTOTAL.AsExtended;
    TotalDesconto := TotalDesconto + CDSVendaDetalheVALOR_DESCONTO.AsExtended;

    CDSVendaDetalhe.Next;
  end;
  CDSVendaDetalhe.First;
  CDSVendaDetalhe.EnableControls;
  //
  EditValorSubtotal.Value := SubTotal;
  if TotalDesconto > 0 then
  begin
    EditValorDesconto.Value := TotalDesconto;
    EditTaxaDesconto.Value := TotalDesconto / SubTotal * 100;
  end;
  if ComboBoxTipoFrete.ItemIndex = 0 then
    EditValorTotal.Value := SubTotal - EditValorDesconto.Value //CIF
  else
    EditValorTotal.Value := SubTotal + EditValorFrete.Value + EditValorSeguro.Value - EditValorDesconto.Value; //FOB
  EditValorComissao.Value := SubTotal - EditValorDesconto.Value * EditTaxaComissao.Value / 100;
end;

procedure TFVenda.ActionExcluirItemExecute(Sender: TObject);
begin
  if Application.MessageBox('Tem certeza que deseja remover o item da venda?', 'Pergunta do Sistema', MB_YesNo + MB_IconQuestion) = IdYes then
  begin
    if StatusTela = stInserindo then
      CDSVendaDetalhe.Delete
    else if StatusTela = stEditando then
    begin
      if TVendaDetalheController(ObjetoController).Exclui(CDSVendaDetalhe.FieldByName('ID').AsInteger) then
        CDSVendaDetalhe.Delete;
    end;
  end;
end;
{$ENDREGION}

end.
