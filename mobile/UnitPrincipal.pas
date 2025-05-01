unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.TabControl, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls;

type
  TFormPrincipal = class(TForm)
    RectTabs: TRectangle;
    Homer: TImage;
    ImagePerfil: TImage;
    ImageCarrinho: TImage;
    ImageMenu: TImage;
    CircleSelecao: TCircle;
    TabControl1: TTabControl;
    TabHomer: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    RectangleFundoAba1: TRectangle;
    EditPesquizarAba1: TEdit;
    RectangleEdit1: TRectangle;
    Rectangle1: TRectangle;
    Label1: TLabel;
    Rectangle2: TRectangle;
    Label2: TLabel;
    Label3: TLabel;
    LabelCarrinho: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure HomerClick(Sender: TObject);
  private
    procedure TrocarAba(img: TImage);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.fmx}

procedure TFormPrincipal.TrocarAba(img: TImage);
begin
  TabControl1.GotoVisibleTab(img.tag);
  CircleSelecao.Position.X := img.Position.X + (img.Width / 2) -5;
end;

procedure TFormPrincipal.HomerClick(Sender: TObject);
begin
  TrocarAba(TImage(Sender));
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  TabControl1.TabPosition := TTabPosition.None
end;

end.
