program Ecommerce;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {FormPrincipal},
  Frame.Categoria in 'Frames\Frame.Categoria.pas' {FrameCategoria: TFrame},
  Frame.Produto in 'Frames\Frame.Produto.pas' {FrameProduto: TFrame},
  uLoading in 'Utils\uLoading.pas',
  uFanctions in 'Utils\uFanctions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
