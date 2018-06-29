program Teste;

uses
  Vcl.Forms,
  uPrincipal in 'Fontes\uPrincipal.pas' {fPrincipal},
  uCad_Clientes in 'Fontes\uCad_Clientes.pas' {frCad_Clientes: TFrame},
  uDM in 'Fontes\uDM.pas' {dm: TDataModule},
  uCad_Produtos in 'Fontes\uCad_Produtos.pas' {frCad_Produtos: TFrame},
  uVendas in 'Fontes\uVendas.pas' {frVendas: TFrame},
  uRelatorios in 'Fontes\uRelatorios.pas' {frRelatorios: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfPrincipal, fPrincipal);
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
