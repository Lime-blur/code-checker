program CChecker;

uses
  ShareMem,
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2};

var
  Key: TWordTriple;

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Code Checker';
  Key[0] := 123;
  Key[1] := 321;
  Key[2] := 213;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
