unit uDM;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Dialogs;

type
  Tdm = class(TDataModule)
    ILImagens: TImageList;
    Con: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    qGeral: TFDQuery;
    qAux: TFDQuery;
    dsGeral: TDataSource;
    mtVendas: TFDMemTable;
    mtVendasCLIENTE: TIntegerField;
    mtVendasPRODUTO: TIntegerField;
    mtVendasQUANTIDADE: TFloatField;
    mtVendasPRECOVENDA: TFloatField;
    mtVendasDATAVENDA: TDateField;
    dsVendas: TDataSource;
    mtVendasPRODUTONOME: TStringField;
    mtVendasUNIDADE: TStringField;
    mtVendasTOTALITEM: TFloatField;
    il16: TImageList;
    dsAux: TDataSource;
    qRelat: TFDQuery;
    dsRelat: TDataSource;

    function SalvarCliente(a,b,c,d,eh,f,g,h,i,j,k,l,m,n,o,p,q,r,s: String; t, cc: integer): Boolean;
    function PesquisaCliente(p: String; campo: Integer): Boolean;
    function ExcluiCliente(c: Integer): Boolean;
    function SalvarProduto(a,b,c: String; ehNovo, CodProduto: Integer): Boolean;
    function ExcluiProduto(c: Integer): Boolean;
    function PesquisaProduto(p: String; campo: Integer): Boolean;
    function ExcluirItemDoPedido(item: Integer): Boolean;
    function CancelarPedido: Boolean;
    function FinalizarPEdido: Boolean;
    function PesquisaClienteRelatorio(cli: String): Boolean;
    function PesquisaProdutoRelatorio(pro: String): Boolean;
    function FiltrarRelatorio(cli, pro, di, df: String): Boolean;

    procedure mtVendasCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ Tdm }

function Tdm.CancelarPedido: Boolean;
begin
  try
    if not(mtVendas.Active)
    then mtVendas.Active := True;

    mtVendas.EmptyDataSet;
    mtVendas.CommitUpdates;
  except
    on E: Exception
    do MessageDlg('Erro ao Cancelar o Pedido!'+#13+E.Message, mtWarning, [mbOk], 0, mbOk);
  end;
  Result := (mtVendas.RecordCount = 0);
end;

function Tdm.ExcluiCliente(c: Integer): Boolean;
begin
  qAux.Close;
  qAux.SQL.Text := 'delete from CAD_CLIENTE where CODIGO='+IntToStr(c);

  if (MessageDlg('Excluir este registro?', mtConfirmation, [mbYes,mbNo], 0, mbNo) = mrYes) then
  begin
    try
      qAux.ExecSQL;
      Con.Commit;
      qGeral.Refresh;
      MessageDlg('Registro Excluído!', mtInformation, [mbOk], 0, mbOk);
    except
      on E: Exception
      do MessageDlg('Erro ao excluir Registro!'+#13+E.Message, mtWarning, [mbOk], 0, mbOk);
    end;
  end;
end;

function Tdm.ExcluiProduto(c: Integer): Boolean;
begin
  qAux.Close;
  qAux.SQL.Text := 'delete from CAD_PRODUTO where CODIGO='+IntToStr(c);

  if (MessageDlg('Excluir este registro?', mtConfirmation, [mbYes,mbNo], 0, mbNo) = mrYes) then
  begin
    try
      qAux.ExecSQL;
      Con.Commit;
      qGeral.Refresh;
      MessageDlg('Registro Excluído!', mtInformation, [mbOk], 0, mbOk);
    except
      on E: Exception
      do MessageDlg('Erro ao excluir Registro!'+#13+E.Message, mtWarning, [mbOk], 0, mbOk);
    end;
  end;
end;

function Tdm.ExcluirItemDoPedido(item: Integer): Boolean;
begin
  try
    mtVendas.Delete;
  except
    on E: Exception
    do MessageDlg('Erro ao excluir oItem do Pedido!'+#13+E.Message, mtWarning, [mbOk], 0, mbOk);
  end;
  mtVendas.CommitUpdates;
  Result := True;
end;

function Tdm.FiltrarRelatorio(cli, pro, di, df: String): Boolean;
var c,p,e: String;
begin
  if (trim(cli)<>'') then c := 'c.CODIGO in ('+cli+')';
  if (trim(pro)<>'') then p := 'p.CODIGO in ('+pro+')';

  if      (c <>'') and (p <>'') then e := c + ' and ' + p + ' and '
  else if (c = '') and (p <>'') then e := p + ' and '
  else if (c <>'') and (p = '') then e := c + ' and '
  else if (c = '') and (p = '') then e := ''
  else e := '';

  qRelat.Close;
  qRelat.SQL.Text := 'select c.NOME, p.NOME as NOMEPRODUTO, p.UNIDADE, p.PRECO, v.DATAVENDA,'+
                     'v.QUANTIDADE, (v.QUANTIDADE * p.PRECO) as TOTALITEM '+
                     'from VENDAS v '+
                     'inner join CAD_CLIENTE c on (v.cliente = c.CODIGO) '+
                     'inner join CAD_PRODUTO p on (v.produto = p.CODIGO) '+
                     'where '+e+
                     'v.DATAVENDA between '+DI+' and '+DF;
  qRelat.Active := True;
  Result := (qRelat.RecordCount>0);
end;

function Tdm.FinalizarPEdido: Boolean;
var I:integer;
    erro: boolean;
begin
  qGeral.Close;
  mtVendas.First;
  for I := 0 to mtVendas.RecordCount-1 do
  begin
    qGeral.SQL.Text := 'insert into VENDAS (CLIENTE, DATAVENDA, PRODUTO, QUANTIDADE) '+
                       'values ('+
                       mtVendasCLIENTE.AsString+','+
                       quotedStr(DateToStr(mtVendasDATAVENDA.Value))+','+
                       mtVendasPRODUTO.AsString+','+
                       FloatToStr(mtVendasQUANTIDADE.Value)+')';
    try
      qGeral.ExecSQL;
      erro := False;
    except
      on E: Exception do
      begin
        erro := True;
        MessageDlg('Erro ao Finalizar a Venda!'+#13+E.Message, mtWarning, [mbOk], 0, mbOk);
      end;
    end;
    mtVendas.Next;
  end;

  CancelarPedido;

  if (erro)
  then MessageDlg('Ocorreram Erros ao Finalizar a Venda!', mtWarning, [mbOk], 0, mbOk)
  else MessageDlg('Venda Finalizada!', mtInformation, [mbOk], 0, mbOk);

  Result := erro;
end;

procedure Tdm.mtVendasCalcFields(DataSet: TDataSet);
begin
  mtVendasTOTALITEM.Value := mtVendasQUANTIDADE.Value * mtVendasPRECOVENDA.Value;
end;

function Tdm.PesquisaCliente(p: String; campo: Integer): Boolean;
var cp: String;
begin
  case campo of
    0: cp:= 'NOME';
    1: cp:= 'NOMEFANTASIA';
    2: cp:= 'ENDERECO_RUA';
    3: cp:= 'ENDERECO_BAIRROS';
    4: cp:= 'CNPJ';
    5: cp:= 'CPF';
    6: cp:= 'RG';
    7: cp:= 'STATUS';
  end;

  qGeral.Close;

  if campo < 7
  then qGeral.SQL.Text := 'select * from CAD_CLIENTE where '+cp+' like '+p
  else qGeral.SQL.Text := 'select * from CAD_CLIENTE where STATUS = TRUE';

  qGeral.Active := True;

  Result := qGeral.RecordCount>0;
end;

function Tdm.PesquisaClienteRelatorio(cli: String): Boolean;
begin
  qGeral.Close;
  qGeral.SQL.Text := 'select CODIGO, NOME from CAD_CLIENTE where NOME like '+cli;
  qGeral.Active := True;

  Result := qGeral.RecordCount>0;
end;

function Tdm.PesquisaProduto(p: String; campo: Integer): Boolean;
var cp: String;
begin
  case campo of
    0: cp:= 'NOME';
    1: cp:= 'UNIDADE';
  end;

  qGeral.Close;
  qGeral.SQL.Text := 'select * from CAD_PRODUTO where '+cp+' like '+p;
  qGeral.Active := True;

  Result := qGeral.RecordCount>0;
end;

function Tdm.PesquisaProdutoRelatorio(pro: String): Boolean;
begin
  qAux.Close;
  qAux.SQL.Text := 'select CODIGO, NOME from CAD_PRODUTO where NOME like '+pro;
  qAux.Active := True;

  Result := qAux.RecordCount>0;
end;

function Tdm.SalvarCliente(a, b, c, d, eh, f, g, h, i, j, k, l, m, n, o, p, q, r, s: String;
  t,cc: integer): Boolean;
begin
  qGeral.Close;
  if (t = 1)
  then qGeral.SQL.Text := 'insert into CAD_CLIENTE (TIPO,NOME,NOMEFANTASIA,ENDERECO_RUA,ENDERECO_BAIRROS,'+
                          'ENDERECO_CIDADE,ENDERECO_UF,ENDERECO_CEP,TELEFONE1,TELEFONE2,TELEFONE3,'+
                          'TELEFONE4,EMAIL1,CONTATO1,CNPJ,IE,CPF,RG,STATUS) '+
                          'values ('+
                          a+','+b+','+c+','+d+','+eh+','+f+','+g+','+h+','+i+','+j+','+k+','+l+','+
                          m+','+n+','+o+','+p+','+q+','+r+','+s+')'
  else qGeral.SQL.Text := 'update CAD_CLIENTE set '+
                          'TIPO='+a+',NOME='+b+',NOMEFANTASIA='+c+',ENDERECO_RUA='+d+','+
                          'ENDERECO_BAIRROS='+eh+',ENDERECO_CIDADE='+f+',ENDERECO_UF='+g+','+
                          'ENDERECO_CEP='+h+',TELEFONE1='+i+',TELEFONE2='+j+',TELEFONE3='+k+','+
                          'TELEFONE4='+l+',EMAIL1='+m+',CONTATO1='+n+',CNPJ='+o+',IE='+p+','+
                          'CPF='+q+',RG='+r+',STATUS='+s+
                          ' where CODIGO='+IntToStr(cc);
  try
    qGeral.ExecSQL;
    if (t = 1)
    then MessageDlg('Cadastro Realizado com Sucesso!', mtInformation, [mbOK], 0, mbOk)
    else MessageDlg('Cadastro Alterado com Sucesso!', mtInformation, [mbOK], 0, mbOk);

    Result := True;
  except
    on E: Exception do
    begin
      MessageDlg('Erro ao Cadastrar!'+#13+E.Message, mtError, [mbOK], 0, mbOk);
      Result := False;
    end;
  end;
end;

function Tdm.SalvarProduto(a, b, c: String; ehNovo, CodProduto: Integer): Boolean;
begin
  qGeral.Close;
  if (ehNovo = 1)
  then qGeral.SQL.Text := 'insert into CAD_PRODUTO (NOME,UNIDADE,PRECO) '+
                          'values ('+
                          a+','+b+','+c+')'
  else qGeral.SQL.Text := 'update CAD_PRODUTO set '+
                          'NOME='+a+',UNIDADE='+b+',PRECO='+c+
                          ' where CODIGO='+IntToStr(CodProduto);
  try
    qGeral.ExecSQL;
    if (ehNovo = 1)
    then MessageDlg('Cadastro Realizado com Sucesso!', mtInformation, [mbOK], 0, mbOk)
    else MessageDlg('Cadastro Alterado com Sucesso!', mtInformation, [mbOK], 0, mbOk);

    Result := True;
  except
    on E: Exception do
    begin
      MessageDlg('Erro ao Cadastrar!'+#13+E.Message, mtError, [mbOK], 0, mbOk);
      Result := False;
    end;
  end;
end;

end.
