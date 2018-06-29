unit uCad_Clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.ExtCtrls;

type
  TfrCad_Clientes = class(TFrame)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    edRazaoSocial: TEdit;
    edFantasia: TEdit;
    edLogradouro: TEdit;
    edBairro: TEdit;
    edCidade: TEdit;
    edEmail: TEdit;
    edContato: TEdit;
    edIe: TEdit;
    edRg: TEdit;
    cbTipo: TComboBox;
    cbUf: TComboBox;
    edCep: TMaskEdit;
    edFone1: TMaskEdit;
    edFone2: TMaskEdit;
    edCelular: TMaskEdit;
    edCnpj: TMaskEdit;
    edCpf: TMaskEdit;
    edFax: TMaskEdit;
    chkStatus: TCheckBox;
    tbAcoes: TToolBar;
    btNovo: TToolButton;
    btSalvar: TToolButton;
    btExcluir: TToolButton;
    gridClientes: TDBGrid;
    Label13: TLabel;
    edPesquisa: TEdit;
    Label20: TLabel;
    cbPesquisa: TComboBox;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    btFechar: TToolButton;
    procedure btNovoClick(Sender: TObject);
    procedure LimpaCampos;
    procedure btSalvarClick(Sender: TObject);
    procedure edPesquisaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btExcluirClick(Sender: TObject);
    procedure gridClientesCellClick(Column: TColumn);
    procedure gridClientesKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MostraDados;
    procedure btFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses uDM, uPrincipal;

procedure TfrCad_Clientes.btExcluirClick(Sender: TObject);
begin
  if not (dm.qGeral.RecordCount>0)
  then MessageDlg('Não há nada selecionado para exclusão!', mtWarning, [mbOK], 0, mbOk)
  else
  begin
    dm.ExcluiCliente(dm.qGeral.FieldByName('CODIGO').AsInteger);
  end;
end;

procedure TfrCad_Clientes.btFecharClick(Sender: TObject);
begin
  fPrincipal.FechaAbaAtiva;
end;

procedure TfrCad_Clientes.btNovoClick(Sender: TObject);
begin
  btNovo.Tag := 1;
  LimpaCampos;
  cbTipo.SetFocus;
end;

procedure TfrCad_Clientes.btSalvarClick(Sender: TObject);
var cd: Integer;
    atv:String;
begin
  if (Trim(edRazaoSocial.Text)<>'') and (Trim(edCnpj.Text)<>'') then
  begin
    if (dm.qGeral.RecordCount>0)
    then cd := dm.qGeral.FieldByName('CODIGO').AsInteger
    else cd := -1;

    if (chkStatus.Checked) then atv := 'TRUE' else atv := 'FALSE';

    if (dm.SalvarCliente(IntToStr(cbTipo.ItemIndex),
                     quotedStr(edRazaoSocial.Text),
                     quotedStr(edFantasia.Text),
                     quotedStr(edLogradouro.Text),
                     quotedStr(edBairro.Text),
                     quotedStr(edCidade.Text),
                     quotedStr(cbUF.Text),
                     quotedStr(edCep.Text),
                     quotedStr(edFone1.Text),
                     quotedStr(edFone2.Text),
                     quotedStr(edCelular.Text),
                     quotedStr(edFax.Text),
                     quotedStr(edEmail.Text),
                     quotedStr(edContato.Text),
                     quotedStr(edCnpj.Text),
                     quotedStr(edIe.Text),
                     quotedStr(edCpf.Text),
                     quotedStr(edRG.Text),
                     atv,
                     btNovo.Tag,
                     cd))
    then btNovo.Tag := 0;
  end
  else MessageDlg('Não é possível salvar as informações!'+#13+'Dados insuficientes!', mtWarning, [mbOK], 0, mbOk);
end;

procedure TfrCad_Clientes.edPesquisaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
  begin
    if not (dm.PesquisaCliente(quotedStr('%'+edPesquisa.Text+'%'), cbPesquisa.ItemIndex))
    then MessageDlg('Não há informações com estes parâmetros!', mtWarning, [mbOK], 0, mbOk);
  end;
end;

procedure TfrCad_Clientes.gridClientesCellClick(Column: TColumn);
begin
  MostraDados;
end;

procedure TfrCad_Clientes.gridClientesKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_UP) or (Key = VK_DOWN)
  then MostraDados;
end;

procedure TfrCad_Clientes.LimpaCampos;
var
  I: Integer;
begin
  for I := 0 to Self.ComponentCount-1 do
  begin
    if Self.Components[I] is TEdit then (Self.Components[I] as TEdit).Clear;
    if Self.Components[I] is TComboBox then (Self.Components[I] as TComboBox).ItemIndex := 0;
    if Self.Components[I] is TMaskEdit then (Self.Components[I] as TMaskEdit).Clear;
    if Self.Components[I] is TCheckBox then (Self.Components[I] as TCheckBox).Checked := True;
  end;
end;

procedure TfrCad_Clientes.MostraDados;
begin
  cbTipo.ItemIndex   := dm.qGeral.FieldByName('TIPO').AsInteger;
  edRazaoSocial.Text := dm.qGeral.FieldByName('NOME').AsString;
  edFantasia.Text    := dm.qGeral.FieldByName('NOMEFANTASIA').AsString;
  edLogradouro.Text  := dm.qGeral.FieldByName('ENDERECO_RUA').AsString;
  edBairro.Text      := dm.qGeral.FieldByName('ENDERECO_BAIRROS').AsString;
  edCidade.Text      := dm.qGeral.FieldByName('ENDERECO_CIDADE').AsString;
  cbUF.Text          := dm.qGeral.FieldByName('ENDERECO_UF').AsString;
  edCep.Text         := dm.qGeral.FieldByName('ENDERECO_CEP').AsString;
  edFone1.Text       := dm.qGeral.FieldByName('TELEFONE1').AsString;
  edFone2.Text       := dm.qGeral.FieldByName('TELEFONE2').AsString;
  edCelular.Text     := dm.qGeral.FieldByName('TELEFONE3').AsString;
  edFax.Text         := dm.qGeral.FieldByName('TELEFONE4').AsString;
  edEmail.Text       := dm.qGeral.FieldByName('EMAIL1').AsString;
  edContato.Text     := dm.qGeral.FieldByName('CONTATO1').AsString;
  edCnpj.Text        := dm.qGeral.FieldByName('CNPJ').AsString;
  edIe.Text          := dm.qGeral.FieldByName('IE').AsString;
  edCpf.Text         := dm.qGeral.FieldByName('CPF').AsString;
  edRG.Text          := dm.qGeral.FieldByName('RG').AsString;
  chkStatus.Checked  := dm.qGeral.FieldByName('STATUS').AsBoolean;
end;

end.
