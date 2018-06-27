unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, Mask, XPMan, Grids, ValEdit, ComCtrls,
  Buttons, sSkinManager;

type
  TWordTriple = Array[0..2] of Word;
  TForm1 = class(TForm)
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
    Timer1: TTimer;
    Image1: TImage;
    Shape1: TShape;
    Label1: TLabel;
    Label6: TLabel;
    sSkinManager1: TsSkinManager;
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

function FileEncrypt(InFile, OutFile: String; Key: TWordTriple): boolean; stdcall; external 'CCML.dll';
function FileDecrypt(InFile, OutFile: String; Key: TWordTriple): boolean; stdcall; external 'CCML.dll';
function TextEncrypt(const s: string; Key: TWordTriple): string; stdcall; external 'CCML.dll';
function TextDecrypt(const s: string; Key: TWordTriple): string; stdcall; external 'CCML.dll';
function MemoryEncrypt(Src: Pointer; SrcSize: Cardinal; Target: Pointer; TargetSize: Cardinal; Key: TWordTriple): boolean; stdcall; external 'CCML.dll';
function MemoryDecrypt(Src: Pointer; SrcSize: Cardinal; Target: Pointer; TargetSize: Cardinal; Key: TWordTriple): boolean; stdcall; external 'CCML.dll';
function ConvertFileSize(inputSize: Real) : String; stdcall; external 'CCML.dll';

implementation

uses Unit2;

{$R *.dfm}

procedure updateUsersFile(userNameString: string);
var
  List: TStringList;
  i: integer;
begin
  if FileExists('C:\CCchecker\Users.dat') then begin
    List := TStringList.Create;
    List.LoadFromFile('C:\CCchecker\Users.dat');
    for i := List.Count-1 downto 0 do begin
      if Pos(userNameString, List.Strings[i]) <> 0 then List.Delete(i);
    end;
    List.SaveToFile('C:\CCchecker\Users.dat');
    List.Free;
  end;
end;

procedure createEmptyFile(filePath: string);
var
  fs: TFileStream;
  s: AnsiString;
begin
  if not FileExists(filePath) then begin
    fs := TFileStream.Create(filePath, fmCreate);
    try
      s := '';
      fs.WriteBuffer(s[1], Length(s));
    finally
      fs.Free;
    end;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
 Close;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if (Edit1.Text <> '') and (Edit2.Text <> '') then begin
    Button1.Enabled := false;
    Button2.Enabled := false;
    Button3.Enabled := true;
    Button5.Enabled := true;
    createEmptyFile('C:\CCchecker\Users.dat');
    ListBox1.Items.LoadFromFile('C:\CCchecker\Users.dat');
    ListBox1.Items.Add(Edit1.Text);
    ListBox1.Items.SaveToFile('C:\CCchecker\Users.dat');
    Label5.Caption := '�� ����� ���: '+Edit1.Text;
    Edit1.Enabled := false;
    Edit2.Enabled := false;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if (Edit1.Text <> '') and (Edit2.Text <> '') then begin
    Button1.Enabled := false;
    Button2.Enabled := false;
    Button3.Enabled := true;
    Button5.Enabled := true;
    createEmptyFile('C:\CCchecker\Users.dat');
    ListBox1.Items.LoadFromFile('C:\CCchecker\Users.dat');
    ListBox1.Items.Add(Edit1.Text);
    ListBox1.Items.SaveToFile('C:\CCchecker\Users.dat');
    Label5.Caption := '�� ����� ���: '+Edit1.Text;
    Edit1.Enabled := false;
    Edit2.Enabled := false;
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
    Button1.Enabled := true;
    Button2.Enabled := true;
    Button3.Enabled := false;
    Button5.Enabled := false;
    Label5.Caption := '�� �� ����� � �������';
    updateUsersFile(Edit1.Text);
    Edit1.Text := '';
    Edit2.Text := '';
    Edit1.Enabled := true;
    Edit2.Enabled := true;
    ListBox1.Clear;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if (ListBox1.ItemIndex >= 0) then begin
    if (ListBox1.Items[ListBox1.ItemIndex] <> Edit1.Text) then begin
      Form2.Caption := '��� - '+ListBox1.Items[ListBox1.ItemIndex];
      Form2.Show;
      Timer1.Enabled := false;
      createEmptyFile('C:\CCchecker\'+ListBox1.Items[ListBox1.ItemIndex]+'_sended.dat');
    end
    else
      MessageDlg('�� �� ������ �������� � ����� �����!', mtWarning, [mbOk], 0);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  if not DirectoryExists('C:\CChecker') then
    CreateDir('C:\CCchecker');
  Timer1.Enabled := true;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  updateUsersFile(Edit1.Text);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if Edit2.Enabled = false then
  ListBox1.Items.LoadFromFile('C:\CCchecker\Users.dat');
end;

end.
