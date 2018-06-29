unit uRelatorios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Buttons, Vcl.DBCtrls,
  Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, ppDB, ppDBPipe, ppParameter, ppDesignLayer, ppBands, ppClass, ppCtrls,
  ppPrnabl, ppCache, ppComm, ppRelatv, ppProd, ppReport;

type
  TfrRelatorios = class(TFrame)
    tbAcoes: TToolBar;
    btNovo: TToolButton;
    btSalvar: TToolButton;
    btExcluir: TToolButton;
    btFechar: TToolButton;
    Panel1: TPanel;
    Panel2: TPanel;
    dtpDI: TDateTimePicker;
    dtpDF: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btFiltrar: TBitBtn;
    btImprimir: TBitBtn;
    chkClientes: TCheckBox;
    chkProdutos: TCheckBox;
    gridDados: TDBGrid;
    edClientes: TEdit;
    edProdutos: TEdit;
    gridClientes: TDBGrid;
    gridProdutos: TDBGrid;
    Rel1: TppReport;
    Pip1: TppDBPipeline;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppDBText6: TppDBText;
    procedure btFecharClick(Sender: TObject);
    procedure cbClientesKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbProdutosKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edClientesKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure chkClientesClick(Sender: TObject);
    procedure chkProdutosClick(Sender: TObject);
    procedure edProdutosKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btFiltrarClick(Sender: TObject);
    procedure btImprimirClick(Sender: TObject);
  private
    { Private declarations }
    cliente, produto: Integer;
    function PegaSelecionados(grid: TDBGrid): String;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses uDM, uPrincipal;

function TfrRelatorios.PegaSelecionados(grid: TDBGrid): String;
var
  I:       Integer;
  codigos: String;
begin
  codigos := '';
  if (grid.SelectedRows.Count>0) then
  begin
    for I := 0 to grid.SelectedRows.Count-1 do
    begin
      grid.DataSource.DataSet.GotoBookmark(Pointer(grid.SelectedRows.Items[I]));
      if (I >= grid.SelectedRows.Count-1)
      then codigos := codigos + grid.DataSource.DataSet.FieldByName('CODIGO').AsString
      else codigos := codigos + grid.DataSource.DataSet.FieldByName('CODIGO').AsString+',';
    end;
  end;
  Result := codigos;
end;

procedure TfrRelatorios.btFecharClick(Sender: TObject);
begin
  fPrincipal.FechaAbaAtiva;
end;

procedure TfrRelatorios.btFiltrarClick(Sender: TObject);
var
  osClientes, osProdutos: String;
begin
  if not (chkClientes.Checked)
  then osClientes := PegaSelecionados(gridClientes);

  if not (chkProdutos.Checked)
  then osProdutos := PegaSelecionados(gridProdutos);

  if not (dm.FiltrarRelatorio(osClientes,
                              osProdutos,
                              quotedStr(DateToStr(dtpDI.Date)),
                              quotedStr(DateToStr(dtpDF.Date))))
  then MessageDlg('Não existem dados com estes parâmetros!', mtWarning, [mbOK], 0, mbOk);
end;

procedure TfrRelatorios.btImprimirClick(Sender: TObject);
begin
  if (dm.qRelat.RecordCount>0) then Rel1.Print;
end;

procedure TfrRelatorios.cbClientesKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_UP) or (Key = VK_DOWN)
  then cliente := dm.qGeral.FieldByName('CODIGO').AsInteger;
end;

procedure TfrRelatorios.cbProdutosKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_UP) or (Key = VK_DOWN)
  then produto := dm.qGeral.FieldByName('CODIGO').AsInteger;
end;

procedure TfrRelatorios.chkClientesClick(Sender: TObject);
begin
  edClientes.Enabled := not (chkClientes.Checked);
  if (dm.qGeral.RecordCount>0)
  then gridClientes.SelectedRows.Clear;
end;

procedure TfrRelatorios.chkProdutosClick(Sender: TObject);
begin
  edProdutos.Enabled := not (chkProdutos.Checked);
  if (dm.qAux.RecordCount>0)
  then gridProdutos.SelectedRows.Clear;
end;

procedure TfrRelatorios.edClientesKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
  dm.PesquisaClienteRelatorio(quotedStr('%'+edClientes.Text+'%'));
end;

procedure TfrRelatorios.edProdutosKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
  dm.PesquisaProdutoRelatorio(quotedStr('%'+edProdutos.Text+'%'));
end;

end.
