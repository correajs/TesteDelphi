unit uVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.Buttons;

type
  TfrVendas = class(TFrame)
    tbAcoes: TToolBar;
    btNovo: TToolButton;
    btSalvar: TToolButton;
    btExcluir: TToolButton;
    btFechar: TToolButton;
    Panel1: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    edPreco: TEdit;
    edProduto: TEdit;
    Panel2: TPanel;
    Label20: TLabel;
    Panel3: TPanel;
    gridProdutos: TDBGrid;
    edQuantidade: TEdit;
    Label2: TLabel;
    Label4: TLabel;
    edCliente: TEdit;
    gridPesquisa: TDBGrid;
    btItem: TBitBtn;
    lbTotal: TLabel;
    procedure edClienteKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure gridPesquisaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edProdutoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edClienteEnter(Sender: TObject);
    procedure edProdutoEnter(Sender: TObject);
    procedure btItemClick(Sender: TObject);
    procedure edQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure btFecharClick(Sender: TObject);
    procedure CalculaTotal(item: Real);
    procedure btNovoClick(Sender: TObject);
    procedure gridProdutosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure gridProdutosMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure gridProdutosCellClick(Column: TColumn);
    procedure btExcluirClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure LimpaCampos;
  private
    { Private declarations }
    var cliente, produto: integer;
    var precovd, ttl: Real;
    var und: String;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses uDM, uPrincipal;

procedure TfrVendas.btExcluirClick(Sender: TObject);
begin
  if MessageDlg('Cancelar a Venda?', mtConfirmation, mbYesNo, 0, mbYes) = mrYes then
  begin
    dm.CancelarPedido;
  end;
end;

procedure TfrVendas.btFecharClick(Sender: TObject);
begin
  fPrincipal.FechaAbaAtiva;
end;

procedure TfrVendas.btItemClick(Sender: TObject);
begin
  if (trim(edCliente.Text)<>'') and (trim(edProduto.Text)<>'') and (trim(edQuantidade.Text)<>'') then
  begin
    if not (dm.mtVendas.Active) then dm.mtVendas.Active := True;
    dm.mtVendas.Append;
    dm.mtVendasCLIENTE.Value    := cliente;
    dm.mtVendasPRODUTO.Value    := produto;
    dm.mtVendasUNIDADE.Value    := und;
    dm.mtVendasPRODUTONOME.Value:= edProduto.Text;
    dm.mtVendasQUANTIDADE.Value := StrToFloat(edQuantidade.Text);
    dm.mtVendasPRECOVENDA.Value := precovd;
    dm.mtVendasDATAVENDA.Value  := Date;

    try
      dm.mtVendas.Post;
      CalculaTotal(dm.mtVendasTOTALITEM.Value);
      edProduto.Clear;
      edQuantidade.Clear;
      edPreco.Clear;
      edProduto.SetFocus;
    except
      on E: EdataBaseError
      do MessageDlg('Erro ao salvar item!'+#13+E.Message, mtWarning, [mbOK], 0, mbOk);
    end;
  end;
end;

procedure TfrVendas.btNovoClick(Sender: TObject);
begin
  ttl := 0.0;
  LimpaCampos;
  edCliente.SetFocus;
end;

procedure TfrVendas.btSalvarClick(Sender: TObject);
begin
  if MessageDlg('Finalizar a Venda?', mtConfirmation, mbYesNo, 0, mbYes) = mrYes then
  begin
    dm.FinalizarPedido;
    LimpaCampos;
    edCliente.SetFocus;
  end;
end;

procedure TfrVendas.CalculaTotal(item: Real);
begin
  ttl := (ttl + item);
  lbTotal.Caption := FormatFloat('###,##0.00', ttl);
end;

procedure TfrVendas.edClienteEnter(Sender: TObject);
begin
  edCliente.Tag := 1;
end;

procedure TfrVendas.edClienteKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
  begin
    if not (dm.PesquisaCliente(quotedStr('%'+edCliente.Text+'%'), 0))
    then MessageDlg('Não há informações com estes parâmetros!', mtWarning, [mbOK], 0, mbOk)
    else
    begin
      gridPesquisa.Columns.Items[2].Visible := False;
      gridPesquisa.Visible := True;
      gridPesquisa.SetFocus;
    end;
  end;
end;

procedure TfrVendas.edProdutoEnter(Sender: TObject);
begin
  edProduto.Tag := 1;
end;

procedure TfrVendas.edProdutoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
  begin
    if not (dm.PesquisaProduto(quotedStr('%'+edProduto.Text+'%'), 0))
    then MessageDlg('Não há informações com estes parâmetros!', mtWarning, [mbOK], 0, mbOk)
    else
    begin
      gridPesquisa.Visible := True;
      gridPesquisa.SetFocus;
    end;
  end;
end;

procedure TfrVendas.edQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', FormatSettings.DecimalSeparator, #8])
  then Key := #0
  else if (Key = FormatSettings.DecimalSeparator) and (Pos(Key, edQuantidade.Text) > 0)
  then Key := #0;
end;

procedure TfrVendas.gridPesquisaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
  begin
    if (edCliente.Tag = 1) then
    begin
      edCliente.Tag  := 0;
      cliente        := dm.qGeral.FieldByName('CODIGO').AsInteger;
      edCliente.Text := dm.qGeral.FieldByName('NOME').AsString;
      gridPesquisa.Columns.Items[2].Visible := True;
      edProduto.SetFocus;
    end
    else
    begin
      edProduto.Tag   := 0;
      produto         := dm.qGeral.FieldByName('CODIGO').AsInteger;
      precovd         := dm.qGeral.FieldByName('PRECO').AsFloat;
      und             := dm.qGeral.FieldByName('UNIDADE').AsString;
      edProduto.Text  := dm.qGeral.FieldByName('NOME').AsString;
      edPreco.Text    := dm.qGeral.FieldByName('PRECO').AsString;
      edQuantidade.SetFocus;
    end;
    gridPesquisa.Visible := False;
  end;
end;

procedure TfrVendas.gridProdutosCellClick(Column: TColumn);
begin
  if (Column.Index = 5) and (DM.mtVendas.RecordCount>0) then
  begin
    if MessageDlg('Excluir este item: ['+dm.mtVendasPRODUTONOME.AsString+']',
       mtConfirmation, mbYesNo, 0, mbYes) = mrYes then
    begin
      dm.ExcluirItemDoPedido(dm.mtVendas.RecNo);
    end;
  end;
end;

procedure TfrVendas.gridProdutosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if (DataCol = 5) then
  begin
    gridProdutos.Canvas.FillRect(Rect);
    DM.il16.Draw(gridProdutos.Canvas, Rect.Left + 3, Rect.Top + 4, 2);
  end;
end;

procedure TfrVendas.gridProdutosMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if (gridProdutos.MouseCoord(X, Y).X in [5])
  then gridProdutos.Hint := 'Excluir o item selecionado';
end;

procedure TfrVendas.LimpaCampos;
var I: Integer;
begin
  for I := 0 to Panel1.ComponentCount-1 do
  begin
    if Panel1.Components[I] is TEdit
    then (Panel1.Components[I] as TEdit).Clear;
  end;
end;

end.
