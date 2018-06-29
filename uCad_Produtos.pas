unit uCad_Produtos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.ToolWin;

type
  TfrCad_Produtos = class(TFrame)
    tbAcoes: TToolBar;
    btNovo: TToolButton;
    btSalvar: TToolButton;
    btExcluir: TToolButton;
    btFechar: TToolButton;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cbUnidade: TComboBox;
    edPreco: TEdit;
    edNome: TEdit;
    Panel2: TPanel;
    Label13: TLabel;
    Label20: TLabel;
    cbPesquisa: TComboBox;
    edPesquisa: TEdit;
    Panel3: TPanel;
    gridProdutos: TDBGrid;
    procedure btNovoClick(Sender: TObject);
    procedure LimpaCampos;
    procedure btSalvarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure edPesquisaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure gridProdutosCellClick(Column: TColumn);
    procedure MostraDados;
    procedure gridProdutosKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edPrecoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses uDM, uPrincipal;

procedure TfrCad_Produtos.btExcluirClick(Sender: TObject);
begin
  if not (dm.qGeral.RecordCount>0)
  then MessageDlg('Não há nada selecionado para exclusão!', mtWarning, [mbOK], 0, mbOk)
  else
  begin
    dm.ExcluiProduto(dm.qGeral.FieldByName('CODIGO').AsInteger);
  end;
end;

procedure TfrCad_Produtos.btFecharClick(Sender: TObject);
begin
  fPrincipal.FechaAbaAtiva;
end;

procedure TfrCad_Produtos.btNovoClick(Sender: TObject);
begin
  btNovo.Tag := 1;
  LimpaCampos;
  edNome.SetFocus;
end;

procedure TfrCad_Produtos.btSalvarClick(Sender: TObject);
var cd: Integer;
    atv:String;
begin
  if (Trim(edNome.Text)<>'') then
  begin
    if (dm.qGeral.RecordCount>0)
    then cd := dm.qGeral.FieldByName('CODIGO').AsInteger
    else cd := -1;

    if (dm.SalvarProduto(quotedStr(edNome.Text),
                     quotedStr(cbUnidade.Text),
                     StringReplace(edPreco.Text,',','.',[]),
                     btNovo.Tag,
                     cd))
    then btNovo.Tag := 0;
  end
  else MessageDlg('Não é possível salvar as informações!'+#13+'Dados insuficientes!', mtWarning, [mbOK], 0, mbOk);
end;

procedure TfrCad_Produtos.edPesquisaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
  begin
    if not (dm.PesquisaProduto(quotedStr('%'+edPesquisa.Text+'%'), cbPesquisa.ItemIndex))
    then MessageDlg('Não há informações com estes parâmetros!', mtWarning, [mbOK], 0, mbOk);
  end;
end;

procedure TfrCad_Produtos.edPrecoKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', FormatSettings.DecimalSeparator, #8])
  then Key := #0
  else if (Key = FormatSettings.DecimalSeparator) and (Pos(Key, edPreco.Text) > 0)
  then Key := #0;
end;

procedure TfrCad_Produtos.gridProdutosCellClick(Column: TColumn);
begin
  MostraDados;
end;

procedure TfrCad_Produtos.gridProdutosKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_UP) or (Key = VK_DOWN)
  then MostraDados;
end;

procedure TfrCad_Produtos.LimpaCampos;
var
  I: Integer;
begin
  for I := 0 to Self.ComponentCount-1 do
  begin
    if Self.Components[I] is TEdit then (Self.Components[I] as TEdit).Clear;
    if Self.Components[I] is TComboBox then (Self.Components[I] as TComboBox).ItemIndex := 0;
    if Self.Components[I] is TCheckBox then (Self.Components[I] as TCheckBox).Checked := True;
  end;
end;

procedure TfrCad_Produtos.MostraDados;
begin
  edNome.Text         := dm.qGeral.FieldByName('NOME').AsString;
  cbUnidade.ItemIndex := cbUnidade.Items.IndexOf(dm.qGeral.FieldByName('UNIDADE').AsString);
  edPreco.Text        := FormatFloat('###,##0.00', dm.qGeral.FieldByName('PRECO').AsFloat);
end;

end.
