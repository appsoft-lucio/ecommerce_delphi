unit uFunctions;

interface

uses FMX.Graphics, System.Net.HttpClientComponent, System.Classes,
     System.SysUtils, System.Net.HttpClient, FMX.ListView,
     FMX.ListView.Appearances, FMX.ListView.Types;

procedure LoadImageFromURL(img: TBitmap; url: string);
procedure DownloadFotoLv(lv: TListview; obj_foto: string);

implementation

procedure LoadImageFromURL(img: TBitmap; url: string);
var
    http : TNetHTTPClient;
    vStream : TMemoryStream;
begin
    try
        try
            http := TNetHTTPClient.Create(nil);
            vStream :=  TMemoryStream.Create;

            if (Pos('https', LowerCase(url)) > 0) then
                  HTTP.SecureProtocols  := [THTTPSecureProtocol.TLS1,
                                            THTTPSecureProtocol.TLS11,
                                            THTTPSecureProtocol.TLS12];

            http.Get(url, vStream);
            vStream.Position  :=  0;


            img.LoadFromStream(vStream);
        except
        end;

    finally
        vStream.DisposeOf;
        http.DisposeOf;
    end;
end;

procedure DownloadFotoLv(lv: TListview; obj_foto: string);
var
    t: TThread;
    foto: TBitmap;
    img_lv: TListItemImage;
begin
    // Carregar imagens...
    t := TThread.CreateAnonymousThread(procedure
    var
        i : integer;
    begin

        for i := 0 to lv.Items.Count - 1 do
        begin
            img_lv := TListItemImage(lv.Items[i].Objects.FindDrawable(obj_foto));

            if img_lv.TagString <> '' then
            begin
                foto := TBitmap.Create;
                LoadImageFromURL(foto, img_lv.TagString);

                img_lv.TagString := '';
                img_lv.Bitmap := foto;
                img_lv.OwnsBitmap := true;
            end;
        end;

    end);

    t.Start;
end;

end.
