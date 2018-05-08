unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, Mask, XPMan, Grids, ValEdit, ComCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Shape1: TShape;
    Shape2: TShape;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    Edit2: TEdit;
    XPManifest1: TXPManifest;
    Button3: TButton;
    Button4: TButton;
    ListBox1: TListBox;
    Label4: TLabel;
    Button5: TButton;
    Label5: TLabel;
    Shape3: TShape;
    Timer1: TTimer;
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

function incryptStr(s: string): string; stdcall; external 'CCML.dll';
function decryptStr(var Pw; Leng: integer); stdcall; external 'CCML.dll';
function convertFileSize(inputSize: Real) : String; stdcall; external 'CCML.dll';

implementation

uses Unit2;

{$R *.dfm}

procedure TForm1.Button4Click(Sender: TObject);
begin
 Close;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  fs: TFileStream;
  s: AnsiString;
begin
  if (Edit1.Text <> '') and (Edit2.Text <> '') then begin
    Button1.Enabled := false;
    Button2.Enabled := false;
    Button3.Enabled := true;
    Button5.Enabled := true;
    if not FileExists('C:\CCchecker\Users.dat') then begin
      fs := TFileStream.Create('C:\CCchecker\Users.dat', fmCreate);
      try
        s := '';
        fs.WriteBuffer(s[1], Length(s));
      finally
        fs.Free;
      end;
    end;
    ListBox1.Items.LoadFromFile('C:\CCchecker\Users.dat');
    ListBox1.Items.Add(Edit1.Text);
    ListBox1.Items.SaveToFile('C:\CCchecker\Users.dat');
    Label5.Caption := '�� ����� ���: '+Edit1.Text;
    Edit1.Enabled := false;
    Edit2.Enabled := false;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  fs: TFileStream;
  s: AnsiString;
begin
  if (Edit1.Text <> '') and (Edit2.Text <> '') then begin
    Button1.Enabled := false;
    Button2.Enabled := false;
    Button3.Enabled := true;
    Button5.Enabled := true;    // Fix to formCreate
    if not FileExists('C:\CCchecker\Users.dat') then begin
      fs := TFileStream.Create('C:\CCchecker\Users.dat', fmCreate);
      try
        s := '';
        fs.WriteBuffer(s[1], Length(s));
      finally
        fs.Free;
      end;
    end;
    ListBox1.Items.LoadFromFile('C:\CCchecker\Users.dat');
    ListBox1.Items.Add(Edit1.Text);
    ListBox1.Items.SaveToFile('C:\CCchecker\Users.dat');
    Label5.Caption := '�� ����� ���: '+Edit1.Text;
    Edit1.Enabled := false;
    Edit2.Enabled := false;
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  List: TStringList;
  i: integer;
begin
    Button1.Enabled := true;
    Button2.Enabled := true;
    Button3.Enabled := false;
    Button5.Enabled := false;
    Label5.Caption := '�� �� ����� � �������';
    try
      List := TStringList.Create;
      List.LoadFromFile('C:\CCchecker\Users.dat');
    except
      MessageDlg('������ �����!', mtError, [mbOk], 0);
    end;
    for i := List.Count-1 downto 0 do begin
      if Pos(Edit1.Text, List.Strings[i]) <> 0 then List.Delete(i);
    end;
    List.SaveToFile('C:\CCchecker\Users.dat');
    List.Free;
    Edit1.Text := '';
    Edit2.Text := '';
    Edit1.Enabled := true;
    Edit2.Enabled := true;
    ListBox1.Clear;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  fs: TFileStream;
  s: AnsiString;
begin
  if (ListBox1.ItemIndex >= 0) then begin
    if (ListBox1.Items[ListBox1.ItemIndex] <> Edit1.Text) then begin
      Form2.Caption := '��� - '+ListBox1.Items[ListBox1.ItemIndex];
      Form2.Show;
      Timer1.Enabled := false;
      if not FileExists('C:\CCchecker\'+ListBox1.Items[ListBox1.ItemIndex]+'_sended.dat') then begin
        fs := TFileStream.Create('C:\CCchecker\'+ListBox1.Items[ListBox1.ItemIndex]+'_sended.dat', fmCreate);
        try
          s := '';
          fs.WriteBuffer(s[1], Length(s));
        finally
          fs.Free;
        end;
      end;
    end
    else
      MessageDlg('�� �� ������ �������� � ����� �����!', mtWarning, [mbOk], 0);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  if not DirectoryExists('C:\CChecker') then
    CreateDirectory('C:\CCchecker', 0);
  Timer1.Enabled := true;
  MessageDlg(IncryptStr('�������� ����������.'), mtWarning, [mbOk], 0);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  List: TStringList;
  i: integer;
begin
  try
    List := TStringList.Create;
    List.LoadFromFile('C:\CCchecker\Users.dat');
  except
    MessageDlg('������ �����!', mtError, [mbOk], 0);
  end;
  for i := List.Count-1 downto 0 do begin
    if Pos(Edit1.Text, List.Strings[i]) <> 0 then List.Delete(i);
  end;
  List.SaveToFile('C:\CCchecker\Users.dat');
  List.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if Edit2.Enabled = false then
  ListBox1.Items.LoadFromFile('C:\CCchecker\Users.dat');
end;

end.
