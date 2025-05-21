unit UnitCheckout;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects;

type
  TFormCheckout = class(TForm)
    LayoutFinalizarPedido: TLayout;
    ImageRetornar: TImage;
    LabelFinalizarPedido: TLabel;
    RectangleFinalizar: TRectangle;
    SpeedButtonFinalizarPedido: TSpeedButton;
    LayoutDetalheDoPedido: TLayout;
    LabelEnderecoEntrega: TLabel;
    RectangleEndereco: TRectangle;
    Label2: TLabel;
    Image1: TImage;
    LabelFormaDePagamento: TLabel;
    RectangleFormaPagamento: TRectangle;
    LabelFormaPagamento: TLabel;
    Image2: TImage;
    RectangleDetalheDoPedido: TRectangle;
    LabelTotlaDosItens: TLabel;
    LabelDetalhesDoPedido: TLabel;
    Layout2: TLayout;
    Label3: TLabel;
    Layout3: TLayout;
    LabelTotalPedido: TLabel;
    Label5: TLabel;
    Layout4: TLayout;
    LabelFrete: TLabel;
    LabelVlorFrete: TLabel;
    procedure ImageRetornarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCheckout: TFormCheckout;

implementation

{$R *.fmx}

procedure TFormCheckout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
        Action := TCloseAction.caFree;
        FormCheckout := nil;
end;

procedure TFormCheckout.ImageRetornarClick(Sender: TObject);
begin
        Close;
end;

end.
