unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Menus, Vcl.Imaging.pngimage;

type
  TfPrincipal = class(TForm)
    NavPage: TPageControl;
    pnTitulo: TPanel;
    pnPrincipal: TPanel;
    Panel1: TPanel;
    pnSair: TPanel;
    Image2: TImage;
    pnRelatorios: TPanel;
    Image3: TImage;
    pnVendas: TPanel;
    Image4: TImage;
    pnCadastrosGeral: TPanel;
    Image5: TImage;
    pnCadastros: TPanel;
    Panel3: TPanel;
    pnVoltar: TPanel;
    Image1: TImage;
    pnProdutos: TPanel;
    Image7: TImage;
    pnClientes: TPanel;
    Image8: TImage;

    procedure InsertFrameTab(Nome, Titulo: String; idx: Integer);
    procedure FechaAbaAtiva;
    procedure pnClientesClick(Sender: TObject);
    procedure pnProdutosClick(Sender: TObject);
    procedure pnVendasClick(Sender: TObject);
    procedure pnRelatoriosClick(Sender: TObject);
    procedure pnSairClick(Sender: TObject);
    procedure pnCadastrosGeralMouseEnter(Sender: TObject);
    procedure pnCadastrosGeralMouseLeave(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnCadastrosGeralClick(Sender: TObject);
    procedure pnVoltarClick(Sender: TObject);
    procedure SelecionaMenu(menu: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fPrincipal: TfPrincipal;

implementation

{$R *.dfm}

{ TForm1 }

uses uCad_Clientes, uCad_Produtos, uVendas, uRelatorios;

procedure TfPrincipal.FechaAbaAtiva;
var p: integer;
begin
  if (NavPage.Pages[NavPage.ActivePageIndex].TabVisible) then
  begin
    p := NavPage.ActivePageIndex;
    NavPage.Pages[p].TabVisible := False;
    NavPage.Pages[p].Visible := False;
  end;
end;

procedure TfPrincipal.FormShow(Sender: TObject);
begin
  SelecionaMenu(0);
end;

procedure TfPrincipal.InsertFrameTab(Nome, Titulo: string; idx: integer);
var FCurrentFrameTab: TFrame;
    TabSheetNew: TTabSheet;
    I: Integer;
    PanelTabSheetNew: TPanel;
    ClassName: string;
begin
  NavPage.Visible:= True;

  {Checa se existe, ativa a tab se existir e, sai}
  for I := 0 to NavPage.PageCount - 1 do
    if NavPage.Pages[I].Name = Nome  then
    begin
      NavPage.ActivePageIndex := I;
      NavPage.ActivePage.TabVisible := True;
      Exit;
    end;

  //se não encontrou,então cria...
  TabSheetNew             := TTabSheet.Create(NavPage);
  TabSheetNew.PageControl := NavPage;
  TabSheetNew.Caption     := Titulo;
  TabSheetNew.Name        := Nome;

  PanelTabSheetNew := TPanel.Create(TabSheetNew);
  PanelTabSheetNew.Align := alClient;
  PanelTabSheetNew.Parent := TabSheetNew;

  if idx = 1 then FCurrentFrameTab := TfrCad_Clientes.Create(Self) else
  if idx = 2 then FCurrentFrameTab := TfrCad_Produtos.Create(Self) else
  if idx = 3 then FCurrentFrameTab := TfrVendas.Create(Self) else
  if idx = 4 then FCurrentFrameTab := TfrRelatorios.Create(Self);

  FCurrentFrameTab.Parent := PanelTabSheetNew;
  FCurrentFrameTab.Align := alClient;

  //vai pra última página...
  NavPage.ActivePageIndex := NavPage.PageCount - 1;
end;

procedure TfPrincipal.pnCadastrosGeralClick(Sender: TObject);
begin
  SelecionaMenu(1);
end;

procedure TfPrincipal.pnCadastrosGeralMouseEnter(Sender: TObject);
begin
  if not (Sender is TPanel)
  then Exit;

  (Sender as TPanel).Color := clBlack;
end;

procedure TfPrincipal.pnCadastrosGeralMouseLeave(Sender: TObject);
begin
  if not (Sender is TPanel)
  then Exit;

  (Sender as TPanel).ParentColor := True;
end;

procedure TfPrincipal.pnClientesClick(Sender: TObject);
begin
  InsertFrameTab('TfrCad_Clientes', 'Cadastro de Clientes', 1);
end;

procedure TfPrincipal.pnProdutosClick(Sender: TObject);
begin
  InsertFrameTab('TfrCad_Produtos', 'Cadastro de Produtos', 2);
end;

procedure TfPrincipal.pnRelatoriosClick(Sender: TObject);
begin
  InsertFrameTab('TfrRelatorios', 'Relatórios', 4);
end;

procedure TfPrincipal.pnSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfPrincipal.pnVendasClick(Sender: TObject);
begin
  InsertFrameTab('TfrVendas', 'Vendas de Produtos', 3);
end;

procedure TfPrincipal.pnVoltarClick(Sender: TObject);
begin
  SelecionaMenu(0);
end;

procedure TfPrincipal.SelecionaMenu(menu: Integer);
begin
  if (menu = 0) then
  begin
    pnPrincipal.Visible := True;
    pnCadastros.Visible := False;
  end
  else if (menu = 1) then
  begin
    pnPrincipal.Visible := False;
    pnCadastros.Visible := True;
  end;
end;

end.
