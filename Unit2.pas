unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, SynEdit, SynMemo, XPMan, Menus,
  SynEditHighlighter, SynHighlighterCpp, sSkinManager;

type
  TForm2 = class(TForm)
    XPManifest1: TXPManifest;
    SynCppSyn1: TSynCppSyn;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    Edit1: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Splitter2: TSplitter;
    SynMemo1: TSynMemo;
    SynMemo2: TSynMemo;
    Memo1: TMemo;
    Splitter1: TSplitter;
    Button1: TButton;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    OpenDialog1: TOpenDialog;
    Timer1: TTimer;
    SaveDialog1: TSaveDialog;
    sSkinManager1: TsSkinManager;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  userName, opponentName: string;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
  fs: TFileStream;
  s: AnsiString;
begin
  if not FileExists('C:\CCchecker\chat_.dat') then begin
    fs := TFileStream.Create('C:\CCchecker\chat_.dat', fmCreate);
    try
      s := '';
      fs.WriteBuffer(s[1], Length(s));
    finally
      fs.Free;
    end;
  end
  else
    Memo1.Lines.LoadFromFile('C:\CCchecker\chat_.dat');
  Memo1.Lines.Add(userName+': '+Edit1.Text);
  Memo1.Lines.SaveToFile('C:\CCchecker\chat_.dat');
  Edit1.Clear;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  userName := Form1.Edit1.Text;
  opponentName := Form1.ListBox1.Items[Form1.ListBox1.ItemIndex];
  SynMemo1.Clear;
  SynMemo2.Clear;
  Memo1.Clear;
  Timer1.Enabled := true;
end;

procedure TForm2.N2Click(Sender: TObject);
begin
 if OpenDialog1.Execute then
 SynMemo1.Lines.LoadFromFile(OpenDialog1.FileName);
end;

procedure TForm2.N4Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    SynMemo1.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TForm2.N5Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    SynMemo2.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TForm2.Timer1Timer(Sender: TObject);
var
  fs: TFileStream;
  s: AnsiString;
begin
  if not FileExists('C:\CCchecker\'+userName+'_sended.dat') then begin
    fs := TFileStream.Create('C:\CCchecker\'+userName+'_sended.dat', fmCreate);
    try
      s := '';
      fs.WriteBuffer(s[1], Length(s));
    finally
      fs.Free;
    end;
  end;
  if not FileExists('C:\CCchecker\'+opponentName+'_sended.dat') then begin
    fs := TFileStream.Create('C:\CCchecker\'+opponentName+'_sended.dat', fmCreate);
    try
      s := '';
      fs.WriteBuffer(s[1], Length(s));
    finally
      fs.Free;
    end;
  end;
  if FileExists('C:\CCchecker\chat_.dat') then
    Memo1.Lines.LoadFromFile('C:\CCchecker\chat_.dat');
  SynMemo1.Lines.SaveToFile('C:\CCchecker\'+userName+'_sended.dat');
  SynMemo2.Lines.LoadFromFile('C:\CCchecker\'+opponentName+'_sended.dat');
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Timer1.Enabled := false;
end;

end.
