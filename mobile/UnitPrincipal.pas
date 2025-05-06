unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.TabControl, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, FMX.Ani,
  FMX.Layouts, FMX.ListBox, uLoading;

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
    LabelConfiguracoes: TLabel;
    LabelCarrinho: TLabel;
    LabelCatao: TLabel;
    ImageCartao: TImage;
    RectangleCartoes: TRectangle;
    ImageAcessarCartao: TImage;
    RectangleDesconct: TRectangle;
    LabelDesconect: TLabel;
    ImageDesconect: TImage;
    ImageDesconectar: TImage;
    RectangleEndereco: TRectangle;
    LabelEndereco: TLabel;
    ImageEndereco: TImage;
    ImageAcessarEndereco: TImage;
    RectangleCart: TRectangle;
    LabelMeuCarrinho: TLabel;
    ImageCart: TImage;
    ImageAcessarCart: TImage;
    RectanglePerfil: TRectangle;
    LabelDadosPerfil: TLabel;
    ImageDadosDoPerfil: TImage;
    ImageAcessarPerfil: TImage;
    RectangleConfiguracoes: TRectangle;
    ListBoxCategoria: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure HomerClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListBoxCategoriaItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
  private
    procedure TrocarAba(img: TImage);
    procedure AddCategoria(id_categoria: integer; categoria: string);
    procedure ListarCategorias;
    procedure TerminateCategoria(Sender: TObject);
    procedure SelecionarCategoria(item: TListBoxItem);

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.fmx}

uses Frame.Categoria;

procedure TFormPrincipal.AddCategoria(id_categoria: integer;
                                      categoria: string);

var
  item : TListBoxItem;
  frame : TFrameCategoria;

begin
  item:= TListBoxItem.Create(ListBoxCategoria);
  item.Selectable := false;
  item.Text := '';
  item.Width := 105;
  item.Tag := id_categoria;

  //Frame
  frame := TFrameCategoria.Create(item);
  frame.LabelCategoria.Text := categoria;

  item.AddObject(frame);
  ListBoxCategoria.AddObject(item);
end;

procedure TFormPrincipal.SelecionarCategoria(item: TListBoxItem);
var
  i : integer;
  item_loop : TListBoxItem;
  frame : TFrameCategoria;

begin
  //Deixar todos itens não selecionados
  for I := 0 to ListBoxCategoria.Items.Count - 1 do
  begin
    item_Loop := ListBoxCategoria.ItemByIndex(i);

    frame := TFrameCategoria(item_Loop.Components[0]);
    frame.RectangleCategoria.Fill.Color := $FFFFFFFF;//Fundo branco
    frame.RectangleCategoria.Stroke.Color := $FFB9B9B9; //Borda cinza;
    frame.LabelCategoria.FontColor := $FF000000//Texto branco

  end;

  //Destacar item selecionado
  frame := TFrameCategoria(item.Components[0]);
  frame.RectangleCategoria.Fill.Color := $FF000000;//Fundo preto
  frame.RectangleCategoria.Stroke.Color := $FFF57C00; //Borda laranja;
  frame.LabelCategoria.FontColor := $FFFFFFFF; //Texto branco
  frame.LabelCategoria.Font.Size := 16; //Aumentar fontSize

end;

procedure TFormPrincipal.TerminateCategoria(Sender: TObject);
begin
  TLoading.Hide;

  //Se deu erro na thread....
  if Assigned(TThread(Sender).FatalException) then
  begin
    showmessage(Exception(TThread(sender).FatalException).Message);
    Exit;
  end;

  AddCategoria(1, 'Audio');
  AddCategoria(1, 'Informática');
  AddCategoria(1, 'Roupas');
  AddCategoria(1, 'Limpeza');
  AddCategoria(1, 'Escolar');
  AddCategoria(1, 'Livros');

  // Seleciona a primeira categoria
  if ListBoxCategoria.Items.Count > 0 then
  SelecionarCategoria(ListBoxCategoria.ItemByIndex(0));


end;

procedure TFormPrincipal.ListarCategorias;
begin
  TLoading.Show(FormPrincipal, 'Carregando');
  ListBoxCategoria.Items.Clear;

  TLoading.ExecuteThread(Procedure
  begin
    //Acesso ao servido
    sleep(500);
  end,
  TerminateCategoria);

end;

procedure TFormPrincipal.ListBoxCategoriaItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  SelecionarCategoria(item);
end;

procedure TFormPrincipal.TrocarAba(img: TImage);
begin
  //CircleSelecao.Position.X := img.Position.X;
  TAnimator.AnimateFloat(CircleSelecao, 'Position.X', img.position.X,
                    1, TAnimationType.Out, TInterpolationType.Elastic);

  TabControl1.GotoVisibleTab(img.tag);

end;

procedure TFormPrincipal.HomerClick(Sender: TObject);
begin
  TrocarAba(TImage(Sender));
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  TabControl1.TabPosition := TTabPosition.None;
  TrocarAba(Homer);
end;

procedure TFormPrincipal.FormShow(Sender: TObject);
begin
  ListarCategorias;
end;

end.







