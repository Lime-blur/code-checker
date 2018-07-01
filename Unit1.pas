unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, ComCtrls,
  Buttons, sSkinManager, sLabel, sMaskEdit, sEdit, sListBox, sButton, Mask,
  sDialogs, sCalculator, sSpeedButton, sColorSelect;

type
  TWordTriple = Array[0..2] of Word;
  TEaseTypes = (
    easeLinear,
    easeInBack,
    easeOutBack
  );
  TForm1 = class(TForm)
    Timer1: TTimer;
    sSkinManager1: TsSkinManager;
    sLabelFX1: TsLabelFX;
    sLabelFX2: TsLabelFX;
    sLabelFX3: TsLabelFX;
    sLabel1: TsLabel;
    sEdit1: TsEdit;
    sMaskEdit1: TsMaskEdit;
    sListBox1: TsListBox;
    sButton1: TsButton;
    sButton2: TsButton;
    sButton3: TsButton;
    sButton4: TsButton;
    Timer2: TTimer;
    procedure sButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure sButton4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
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

procedure TForm1.sButton1Click(Sender: TObject);
begin
  if (sEdit1.Text <> '') and (sMaskEdit1.Text <> '') then begin
    sButton1.Enabled := false;
    sButton2.Enabled := false;
    sButton4.Enabled := true;
    sButton3.Enabled := true;
    createEmptyFile('C:\CCchecker\Users.dat');
    sListBox1.Items.LoadFromFile('C:\CCchecker\Users.dat');
    sListBox1.Items.Add(sEdit1.Text);
    sListBox1.Items.SaveToFile('C:\CCchecker\Users.dat');
    sLabel1.Caption := 'Вы вошли как: '+sEdit1.Text;
    sEdit1.Enabled := false;
    sMaskEdit1.Enabled := false;
  end;
end;

procedure TForm1.sButton2Click(Sender: TObject);
begin
  if (sEdit1.Text <> '') and (sMaskEdit1.Text <> '') then begin
    sButton1.Enabled := false;
    sButton2.Enabled := false;
    sButton4.Enabled := true;
    sButton3.Enabled := true;
    createEmptyFile('C:\CCchecker\Users.dat');
    sListBox1.Items.LoadFromFile('C:\CCchecker\Users.dat');
    sListBox1.Items.Add(sEdit1.Text);
    sListBox1.Items.SaveToFile('C:\CCchecker\Users.dat');
    sLabel1.Caption := 'Вы вошли как: '+sEdit1.Text;
    sEdit1.Enabled := false;
    sMaskEdit1.Enabled := false;
  end;
end;

procedure TForm1.sButton3Click(Sender: TObject);
begin
  sButton1.Enabled := true;
  sButton2.Enabled := true;
  sButton4.Enabled := false;
  sButton3.Enabled := false;
  sLabel1.Caption := 'Вы не вошли в аккаунт.';
  updateUsersFile(sEdit1.Text);
  sEdit1.Text := '';
  sMaskEdit1.Text := '';
  sEdit1.Enabled := true;
  sMaskEdit1.Enabled := true;
  sListBox1.Clear;
end;

procedure TForm1.sButton4Click(Sender: TObject);
begin
  if (sListBox1.ItemIndex >= 0) then begin
    if (sListBox1.Items[sListBox1.ItemIndex] <> sEdit1.Text) then begin
      Form2.Caption := 'Чат - '+sListBox1.Items[sListBox1.ItemIndex];
      Form2.Show;
      Timer1.Enabled := false;
      createEmptyFile('C:\CCchecker\'+sListBox1.Items[sListBox1.ItemIndex]+'_sended.dat');
    end
    else
      MessageDlg('Вы не можете общаться с самим собой!', mtWarning, [mbOk], 0);
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  updateUsersFile(sEdit1.Text);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if sMaskEdit1.Enabled = false then
  sListBox1.Items.LoadFromFile('C:\CCchecker\Users.dat');
end;

// Easing

function easingFunctions(t, a, b, easingType: Real): Real;
  var additionalVar, FirstResult: Real;
begin
  additionalVar := t - (2.625 / 2.75);
  if (easingType = 0) then // EaseOut
    Result := a + (b - a) * (t * (2 - t));
  if (easingType = 1) then // EaseIn
    Result := a + (b - a) * t * t;
  if (easingType = 2) then // EaseOutBack
  begin
    t := t / 1;
    Result := a + (b - a) * (1 * ((t - 1) * t * ((1.70158 + 1) * t + 1.70158) + 1));
  end;
  if (easingType = 3) then // EaseInBack
    Result := a + (b - a) * (1 * t * t * ((1.70158 + 1) * t - 1.70158));
  if (easingType = 4) then // EaseOutBounce
  begin
    FirstResult := (7.5625 * (additionalVar) * t + 0.984375);
    if (t < (1 / 2.75)) then
      FirstResult := (7.5625 * t * t);
    if (t < (2 / 2.75)) then
    begin
      additionalVar := t - (1.5 / 2.75);
      FirstResult := (7.5625 * (additionalVar) * t + 0.75);
    end;
    if (t < (2.5 / 2.75)) then
    begin
      additionalVar := t - (2.25 / 2.75);
      FirstResult := (7.5625 * (additionalVar) * t + 0.9375);
    end;
    Result := a + (b - a) * FirstResult;
  end;
  if (easingType = 5) then // Linear
    Result := a + (b - a) * t;
end;

var
  EasingTime: Real;

procedure TForm1.FormCreate(Sender: TObject);
begin
  if not DirectoryExists('C:\CChecker') then
    CreateDir('C:\CCchecker');
  Timer1.Enabled := true;
  Timer2.Enabled := true;
  EasingTime := 0;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  EasingTime := EasingTime + Timer2.Interval / 1000;
  sButton1.Top := Round(easingFunctions(EasingTime, 150, 160, 0));
  sButton2.Top := Round(easingFunctions(EasingTime, 150, 160, 0));
  sButton3.Top := Round(easingFunctions(EasingTime, 150, 160, 0));
  sButton4.Top := Round(easingFunctions(EasingTime, 210, 200, 0));
  sEdit1.Top := Round(easingFunctions(EasingTime, 40, 48, 0));
  sListBox1.Top := Round(easingFunctions(EasingTime, 40, 48, 0));
  sMaskEdit1.Top := Round(easingFunctions(EasingTime, 120, 128, 0));
  sLabelFX1.Top := Round(easingFunctions(EasingTime, -8, 0, 0));
  sLabelFX2.Top := Round(easingFunctions(EasingTime, 72, 80, 0));
  sLabelFX3.Top := Round(easingFunctions(EasingTime, 0, 8, 0));
  sLabel1.Top := Round(easingFunctions(EasingTime, 248, 240, 0));
  if (EasingTime >= 1) then
    Timer2.Enabled := false;
end;

end.
