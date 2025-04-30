unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.TabControl, FMX.Controls.Presentation, FMX.Edit;

type
  TForm1 = class(TForm)
    RectTabs: TRectangle;
    Homer: TImage;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    CircleSelecao: TCircle;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    RectangleFundoAba1: TRectangle;
    EditAba1: TEdit;
    RectangleEdit1: TRectangle;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

end.
