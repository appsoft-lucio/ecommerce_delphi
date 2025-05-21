program Ecommerce;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {FormPrincipal},
  Frame.Categoria in 'Frames\Frame.Categoria.pas' {FrameCategoria: TFrame},
  Frame.Produto in 'Frames\Frame.Produto.pas' {FrameProduto: TFrame},
  uLoading in 'Utils\uLoading.pas',
  uFunctions in 'Utils\uFunctions.pas',
  UnitCheckout in 'UnitCheckout.pas' {FormCheckout};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TFormCheckout, FormCheckout);
  Application.Run;
end.
