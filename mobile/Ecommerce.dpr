program Ecommerce;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {FormPrincipal},
  uLoading in 'Utils\uLoading.pas',
  Frame.Categoria in 'Frames\Frame.Categoria.pas' {FrameCategoria: TFrame},
  Frame.Produto in 'Frames\Frame.Produto.pas' {FrameProduto: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
