unit Frame.Produto;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects;

type
  TFrameProduto = class(TFrame)
    RectangleProduto: TRectangle;
    ImageProduto: TImage;
    LabelNomeProduto: TLabel;
    LabelBreveDescricao: TLabel;
    LabelPreco: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
