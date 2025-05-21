unit UnitCheckout;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects;

type
  TFormCheckout = class(TForm)
    Layout1: TLayout;
    ImageRetornar: TImage;
    Label1: TLabel;
    RectangleFinalizarPedido: TRectangle;
    SpeedButtonFinalizarPedido: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCheckout: TFormCheckout;

implementation

{$R *.fmx}

end.
