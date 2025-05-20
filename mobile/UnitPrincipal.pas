unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.TabControl, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, FMX.Ani,
  FMX.Layouts, FMX.ListBox, uLoading, uFunctions, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView;

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
    TabDesejos: TTabItem;
    TabCart: TTabItem;
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
    ListBoxProdutos: TListBox;
    ListViewDesejos: TListView;
    ImageIconFoto: TImage;
    ImageIconAdicionarCarrinho: TImage;
    ImageIconLixeira: TImage;
    ListViewCart: TListView;
    BtnAddQtd: TImage;
    procedure FormCreate(Sender: TObject);
    procedure HomerClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListBoxCategoriaItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure FormResize(Sender: TObject);
    procedure ListBoxProdutosItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
  private
    procedure TrocarAba(img: TImage);
    procedure AddCategoria(id_categoria: integer; categoria: string);
    procedure ListarCategorias;
    procedure TerminateCategoria(Sender: TObject);
    procedure SelecionarCategoria(item: TListBoxItem);
    procedure ListarProdutos(id_categoria: integer);
    procedure TerminateProdutos(Sender: TObject);
    procedure AddProduto(id_produto: integer; nome, descricao,
      url_foto: string; preco: double);
    procedure DownloadFoto(lb: TListBox);
    procedure AddListViewDesejo(id_favorito, id_produto: integer;
                                nome, descricao, url_foto :string;
                                preco: double);
    procedure ListarDesejos;
    procedure TerminateDesejos(Sender: TObject);
    procedure AddListViewCart(id_item, id_produto, qtd: integer; nome,
      descricao, url_foto: string; preco: double);
    procedure ListarCart;
    procedure TerminateCart(Sender: TObject);

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.fmx}

uses Frame.Categoria, Frame.Produto;

        procedure TFormPrincipal.DownloadFoto(lb: TListBox);
var
        t : TThread;
        foto : TBitmap;
        frame : TFrameProduto;

begin
        //Carregar imagens...
        T := TThread.CreateAnonymousThread(procedure
        var
                i : integer;
        begin
          for i := 0 to lb.Items.Count -1 do

          begin
            //sleep(10);
            frame := TFrameProduto(lb.ItemByIndex(i).Components[0]);

            if frame.ImageProduto.TagString <> '' then
            begin
              foto := TBitmap.Create;
              LoadImageFromURL(foto, frame.ImageProduto.TagString);

              frame.ImageProduto.TagString := '';
              frame.ImageProduto.Bitmap := foto;

              foto.Free;
            end;

          end;


        end);
        t.Start;
end;

procedure TFormPrincipal.AddCategoria(id_categoria: integer;
                                      categoria: string);

var
  item : TListBoxItem;
  frame : TFrameCategoria;

begin
  item:= TListBoxItem.Create(ListBoxCategoria);
  item.Selectable := false;
  item.Text := '';
  item.Width := 100;
  item.Tag := id_categoria;

  //Frame
  frame := TFrameCategoria.Create(item);
  frame.LabelCategoria.Text := categoria;

  item.AddObject(frame);
  ListBoxCategoria.AddObject(item);
end;

procedure TFormPrincipal.AddProduto(id_produto: integer;
                                      nome, descricao, url_foto: string;
                                      preco: double);
var
  item : TListBoxItem;
  frame : TFrameProduto;

begin
  item:= TListBoxItem.Create(ListBoxProdutos);
  item.Selectable := false;
  item.Text := '';
  item.Height := 230;
  item.Tag := id_produto;

  frame := TFrameProduto.Create(item);
  frame.LabelNomeProduto.Text := nome;
  frame.LabelBreveDescricao.Text := descricao;
  frame.LabelPreco.Text := FormatFloat('R$ #,##0.00', preco);
  frame.ImageProduto.TagString := url_foto;

  item.AddObject(frame);
  ListBoxProdutos.AddObject(item);
end;

procedure TFormPrincipal.AddListViewDesejo(id_favorito, id_produto: integer;
                                nome, descricao, url_foto: string;
                                preco: double);
var
        item : TListViewItem;

begin
        item := ListViewDesejos.items.Add;
        item.Height := 115;

        TListItemImage(item.objects.FindDrawable('ImageProduto')).Bitmap := ImageIconFoto.Bitmap;
        TListItemImage(item.objects.FindDrawable('ImageProduto')).TagString := url_foto;
        TListItemImage(item.objects.FindDrawable('ImageAdicionarCarrinho')).Bitmap := ImageIconAdicionarCarrinho.Bitmap;
        TListItemImage(item.objects.FindDrawable('ImageLixeira')).Bitmap := ImageIconLixeira.Bitmap;
        TListItemText(item.objects.FindDrawable('TextNome')).Text := nome;
        TListItemText(item.objects.FindDrawable('TextPreco')).Text := FormatFloat('R$ #,##0.00', preco);
end;

procedure TFormPrincipal.AddListViewCart(id_item, id_produto, qtd: integer;
                                nome, descricao, url_foto: string;
                                preco: double);
var
        item : TListViewItem;

begin
        item := ListViewCart.items.Add;
        item.Height := 115;

        TListItemImage(item.objects.FindDrawable('ImageProduto')).Bitmap := ImageIconFoto.Bitmap;
        TListItemImage(item.objects.FindDrawable('ImageProduto')).TagString := url_foto;
        TListItemImage(item.objects.FindDrawable('ImageQtd')).Bitmap := BtnAddQtd.Bitmap;
        TListItemImage(item.objects.FindDrawable('ImageLixeira')).Bitmap := ImageIconLixeira.Bitmap;
        TListItemText(item.objects.FindDrawable('TextNome')).Text := nome;
        TListItemText(item.objects.FindDrawable('TextUnidade')).Text := qtd.ToString +
                                                                      FormatFloat('x R$ #,##0.00', preco);
        TListItemText(item.objects.FindDrawable('TextTotal')).Text := FormatFloat('R$ #,##0.00', qtd * preco);
        TListItemText(item.objects.FindDrawable('TextQtd')).Text := qtd.ToString;
        TListItemText(item.objects.FindDrawable('TextMenus')).Text := '-';
        TListItemText(item.objects.FindDrawable('TextMais')).Text := '+';
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

  //Listar produtos dessa cattegoria
  ListarProdutos(item.Tag);

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

procedure TFormPrincipal.TerminateProdutos(Sender: TObject);
begin
  TLoading.Hide;

  //Se deu erro na thread....
  if Assigned(TThread(Sender).FatalException) then
  begin
    showmessage(Exception(TThread(sender).FatalException).Message);
    Exit;
  end;

  AddProduto(1, 'Apple Airpods', '3ª Geração de fones com som especial',
              'https://live-produtos.s3.us-east-1.amazonaws.com/fones.png', 999);
  AddProduto(2, 'JBL Tune 510BT', '5ª Geração com graves potentes e bateria de 40h',
              'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcT8oKof8mgZO5B1JZIGVm_IVWNT5NoO-IyhHsxBqjqRHYKNIxerBRrqLXsy6iG4obFV9T4iwsceHrcZjOeOxAGkHDhiDHMx2c1XFJR_Gat9bogrkiy0-AnHiRVafx7JhECaFn1QTm_Z1w&usqp=CAc', 299);
  AddProduto(3, 'Sony WH-1000XM5', 'Cancelamento de ruído inteligente e som Hi-Res',
              'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcTEXoJ_EwYpseny-DJQcm3Hsj3D7hlodKiSZY9aUXpH0nOj4s_ulRXU0g4od5HHtu_ooEwjqaolsMKzViEghyq126mYySoO7i7VDuOw684UNkOUPO3P5xGqe1B0tqiVVWNTrQDmRpw&usqp=CAc', 1499);
  AddProduto(4, 'Samsung Galaxy Buds 2', '2ª geração de fones sem fio com ajuste automático',
              'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcTLr175HyO4Pm5VJn45TrgrhE_t3gSDJGhi0YpLZbhWRF3kK-0gaPvuacZimwDPIPlVFNHx7rc6aZIH-KAWgtEzfSf6gzqn3_V7JcyWRf1EUNXWZGLMNKoDVpeIFj3NgAVQROgGUxM&usqp=CAc', 599);
  AddProduto(5, 'Logitech G435', 'Headset gamer leve com som estéreo e microfone embutido',
              'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcRtIWgku4bxOncCnDkobu8HKAcsMzG7bwlfP4ACLTLScxEzXjIp3PZ51Z3k_tsp338EhXZBqmAyl1zPJOhaA_DT6-Ck7pwWVfGMDrc814rjD_a2IJ8jty_yEXI8ommGvKKxi9Y_5Q&usqp=CAc', 449);
  AddProduto(6, 'Bose QuietComfort 45', 'Áudio imersivo com cancelamento ativo de ruído',
              'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcRACuFkTn-euU6nx5MQ-SGSzaLQRjIhfcZsaHCxN2Y5LgvaY6IlopUxiGY4tYxvMrp1u0wjP7GzNInxqOK0wnj3Hm411CL2l_b-5ODEF3SPrGuzG3lWXU5VrOlB8d641A&usqp=CAc', 1799);
  AddProduto(7, 'Philips SHP9600', 'Som aberto de estúdio com drivers de 50mm',
              'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcTCPJEnp9j-waC780tnlRnGQySZnIXT1OeCTJX7BlthvrARKAU4MD9NFS06Xv9l4rupSQdqULNd2JbMRM250FgUbPnAlJ2Ig-ehfqdxlkpdwQHDtUOqXO_pfIgAd4aQv21lVA5QWw&usqp=CAc', 599);
  AddProduto(8, 'Edifier R1700BT', 'Caixas de som Bluetooth com áudio balanceado e controle remoto',
              'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcSZ_mOVhVDmj59Wt9ks7H7uhQetqTUbAsGflyb3VM8XvgH_T9jvyTjqODIsGoHXSljPZUwcRmH2Fs5Kn4ekdWrVL77Ydyn0QxuoucJQKz_F2aocK86yAFhGKTlIoqUdSD3sO6hnMdA&usqp=CAc', 749);
  AddProduto(9, 'Xiaomi Redmi Buds 4', 'Conforto com som dinâmico e estojo com carregamento rápido',
              'https://http2.mlstatic.com/D_747259-MLA84199264912_052025-C.jpg', 279);
  AddProduto(10, 'HyperX Cloud Alpha', 'Headset com estrutura durável e drivers duplos para melhor separação sonora',
              'https://http2.mlstatic.com/D_618368-MLU77443691234_072024-C.jpg', 699);


  DownloadFoto(ListBoxProdutos);

end;

procedure TFormPrincipal.TerminateDesejos(Sender: TObject);
begin
  TLoading.Hide;

  //Se deu erro na thread....
  if Assigned(TThread(Sender).FatalException) then
  begin
    showmessage(Exception(TThread(sender).FatalException).Message);
    Exit;
  end;

  AddListViewDesejo(1, 1, 'Apple Airpods', '3ª Geração de fones com som especial',
              'https://live-produtos.s3.us-east-1.amazonaws.com/fones.png', 999);
  AddListViewDesejo(2, 2, 'JBL Tune 510BT', '5ª Geração com graves potentes e bateria de 40h',
              'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcT8oKof8mgZO5B1JZIGVm_IVWNT5NoO-IyhHsxBqjqRHYKNIxerBRrqLXsy6iG4obFV9T4iwsceHrcZjOeOxAGkHDhiDHMx2c1XFJR_Gat9bogrkiy0-AnHiRVafx7JhECaFn1QTm_Z1w&usqp=CAc', 299);
  AddListViewDesejo(3, 3, 'Sony WH-1000XM5', 'Cancelamento de ruído inteligente e som Hi-Res',
              'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcTEXoJ_EwYpseny-DJQcm3Hsj3D7hlodKiSZY9aUXpH0nOj4s_ulRXU0g4od5HHtu_ooEwjqaolsMKzViEghyq126mYySoO7i7VDuOw684UNkOUPO3P5xGqe1B0tqiVVWNTrQDmRpw&usqp=CAc', 1499);
  AddListViewDesejo(4, 4, 'Samsung Galaxy Buds 2', '2ª geração de fones sem fio com ajuste automático',
              'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcTLr175HyO4Pm5VJn45TrgrhE_t3gSDJGhi0YpLZbhWRF3kK-0gaPvuacZimwDPIPlVFNHx7rc6aZIH-KAWgtEzfSf6gzqn3_V7JcyWRf1EUNXWZGLMNKoDVpeIFj3NgAVQROgGUxM&usqp=CAc', 599);
  AddListViewDesejo(5, 5, 'Logitech G435', 'Headset gamer leve com som estéreo e microfone embutido',
              'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcRtIWgku4bxOncCnDkobu8HKAcsMzG7bwlfP4ACLTLScxEzXjIp3PZ51Z3k_tsp338EhXZBqmAyl1zPJOhaA_DT6-Ck7pwWVfGMDrc814rjD_a2IJ8jty_yEXI8ommGvKKxi9Y_5Q&usqp=CAc', 449);



  DownloadFotoLv(ListViewDesejos, 'ImageProduto');

end;

procedure TFormPrincipal.TerminateCart(Sender: TObject);
begin
  TLoading.Hide;

  //Se deu erro na thread....
  if Assigned(TThread(Sender).FatalException) then
  begin
    showmessage(Exception(TThread(sender).FatalException).Message);
    Exit;
  end;

  AddListViewCart(1, 1, 1, 'Apple Airpods', '3ª Geração de fones com som especial',
              'https://live-produtos.s3.us-east-1.amazonaws.com/fones.png', 999);
  AddListViewCart(2, 2, 2, 'JBL Tune 510BT', '5ª Geração com graves potentes e bateria de 40h',
              'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcT8oKof8mgZO5B1JZIGVm_IVWNT5NoO-IyhHsxBqjqRHYKNIxerBRrqLXsy6iG4obFV9T4iwsceHrcZjOeOxAGkHDhiDHMx2c1XFJR_Gat9bogrkiy0-AnHiRVafx7JhECaFn1QTm_Z1w&usqp=CAc', 299);
  AddListViewCart(3, 3, 3, 'Sony WH-1000XM5', 'Cancelamento de ruído inteligente e som Hi-Res',
              'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcTEXoJ_EwYpseny-DJQcm3Hsj3D7hlodKiSZY9aUXpH0nOj4s_ulRXU0g4od5HHtu_ooEwjqaolsMKzViEghyq126mYySoO7i7VDuOw684UNkOUPO3P5xGqe1B0tqiVVWNTrQDmRpw&usqp=CAc', 1499);
  AddListViewCart(4, 4, 4, 'Samsung Galaxy Buds 2', '2ª geração de fones sem fio com ajuste automático',
              'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcTLr175HyO4Pm5VJn45TrgrhE_t3gSDJGhi0YpLZbhWRF3kK-0gaPvuacZimwDPIPlVFNHx7rc6aZIH-KAWgtEzfSf6gzqn3_V7JcyWRf1EUNXWZGLMNKoDVpeIFj3NgAVQROgGUxM&usqp=CAc', 599);
  AddListViewCart(5, 5, 5, 'Logitech G435', 'Headset gamer leve com som estéreo e microfone embutido',
              'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcRtIWgku4bxOncCnDkobu8HKAcsMzG7bwlfP4ACLTLScxEzXjIp3PZ51Z3k_tsp338EhXZBqmAyl1zPJOhaA_DT6-Ck7pwWVfGMDrc814rjD_a2IJ8jty_yEXI8ommGvKKxi9Y_5Q&usqp=CAc', 449);



  DownloadFotoLv(ListViewCart, 'ImageProduto');

end;

procedure TFormPrincipal.ListarCategorias;
begin
  TLoading.Show(FormPrincipal, 'Carregando');
  ListBoxCategoria.Items.Clear;

  TLoading.ExecuteThread(Procedure
  begin
    //Acesso ao servido
    //sleep(500);
  end,
  TerminateCategoria);

end;

procedure TFormPrincipal.ListarProdutos(id_categoria: integer);
begin
  TLoading.Show(FormPrincipal, 'Carregando');
  ListBoxProdutos.Items.Clear;

  TLoading.ExecuteThread(Procedure
  begin
    //Acesso ao servido
    //sleep(300);
  end,
  TerminateProdutos);

end;

procedure TFormPrincipal.ListarDesejos;
begin
  TLoading.Show(FormPrincipal, 'Carregando');
  ListViewDesejos.Items.Clear;

  TLoading.ExecuteThread(Procedure
  begin
    //Acesso ao servido
    //sleep(500);
  end,
  TerminateDesejos);

end;

procedure TFormPrincipal.ListarCart;
begin
  TLoading.Show(FormPrincipal, 'Carregando');
  ListViewCart.Items.Clear;

  TLoading.ExecuteThread(Procedure
  begin
    //Acesso ao servido
    //sleep(10);
  end,
  TerminateCart);

end;

procedure TFormPrincipal.ListBoxCategoriaItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  SelecionarCategoria(item);
end;

procedure TFormPrincipal.ListBoxProdutosItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
        showmessage('Eu sou o produto:' + Item.Tag.ToString);
end;

procedure TFormPrincipal.TrocarAba(img: TImage);
begin
  //CircleSelecao.Position.X := img.Position.X;
  TAnimator.AnimateFloat(CircleSelecao, 'Position.X', img.position.X,
                    1, TAnimationType.Out, TInterpolationType.Elastic);

  TabControl1.GotoVisibleTab(img.tag);

  if img.Tag = 1 then
    ListarDesejos
  else if img.Tag = 2 then
    ListarCart;

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

procedure TFormPrincipal.FormResize(Sender: TObject);
begin
  ListBoxProdutos.Columns := Trunc(ListBoxProdutos.Width / 150);
end;

procedure TFormPrincipal.FormShow(Sender: TObject);
begin
  ListarCategorias;
end;

end.
