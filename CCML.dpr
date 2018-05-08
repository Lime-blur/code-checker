library CCML;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  ShareMem,
  SysUtils,
  Classes,
  Windows;

type
  TWordTriple = Array[0..2] of Word;

{$R *.res}    

function MemoryEncrypt(Src: Pointer; SrcSize: Cardinal; Target: Pointer; TargetSize: Cardinal; Key: TWordTriple): boolean; stdcall;
var
  pIn, pOut: ^byte;
  i : Cardinal;
begin
  if SrcSize = TargetSize then
  begin
    pIn := Src;
    pOut := Target;
    for i := 1 to SrcSize do
    begin
      pOut^ := pIn^ xor (Key[2] shr 8);
      Key[2] := Byte(pIn^ + Key[2]) * Key[0] + Key[1];
      inc(pIn);
      inc(pOut);
    end;
    Result := True;
  end else
    Result := False;
end;

function MemoryDecrypt(Src: Pointer; SrcSize: Cardinal; Target: Pointer; TargetSize: Cardinal; Key: TWordTriple): boolean; stdcall;
var
  pIn, pOut: ^byte;
  i : Cardinal;
begin
  if SrcSize = TargetSize then
  begin
    pIn := Src;
    pOut := Target;
    for i := 1 to SrcSize do
    begin
      pOut^ := pIn^ xor (Key[2] shr 8);
      Key[2] := byte(pOut^ + Key[2]) * Key[0] + Key[1];
      inc(pIn);
      inc(pOut);
    end;
    Result := True;
  end else
    Result := False;
end;

function TextCrypt(const s: string; Key: TWordTriple; Encrypt: Boolean): string; stdcall;
var
  bOK: Boolean;
begin
  SetLength(Result, Length(s));
  if Encrypt then
    bOK := MemoryEncrypt(PChar(s), Length(s), PChar(Result), Length(Result), Key)
  else
    bOK := MemoryDecrypt(PChar(s), Length(s), PChar(Result), Length(Result), Key);
  if not bOK then Result := '';
end;

function FileCrypt(InFile, OutFile: String; Key: TWordTriple; Encrypt: Boolean): boolean; stdcall;
var
  MIn, MOut: TMemoryStream;
begin
  MIn := TMemoryStream.Create;
  MOut := TMemoryStream.Create;
  Try
    MIn.LoadFromFile(InFile);
    MOut.SetSize(MIn.Size);
    if Encrypt then
      Result := MemoryEncrypt(MIn.Memory, MIn.Size, MOut.Memory, MOut.Size, Key)
    else
      Result := MemoryDecrypt(MIn.Memory, MIn.Size, MOut.Memory, MOut.Size, Key);
    MOut.SaveToFile(OutFile);
  finally
    MOut.Free;
    MIn.Free;
  end;
end;

function TextEncrypt(const s: string; Key: TWordTriple): string; stdcall;
begin
  Result := TextCrypt(s, Key, True);
end;

function TextDecrypt(const s: string; Key: TWordTriple): string; stdcall;
begin
  Result := TextCrypt(s, Key, False);
end;

function FileEncrypt(InFile, OutFile: String; Key: TWordTriple): boolean; stdcall;
begin
  Result := FileCrypt(InFile, OutFile, Key, True);
end;

function FileDecrypt(InFile, OutFile: String; Key: TWordTriple): boolean; stdcall;
begin
  Result := FileCrypt(InFile, OutFile, Key, False);
end;

function ConvertFileSize(inputSize: Real) : String; stdcall;
 var filesSize: Real;
begin
   if inputSize < 1024 then Result := floatToStr(Round(inputSize))+'B';
   if inputSize > 1024 then
   begin
    filesSize := inputSize/1024;
    Result := floatToStr(Round(filesSize))+'KB';
   end;
   if filesSize > 1024 then
   begin
    filesSize := filesSize/1024;
    Result := floatToStr(Round(filesSize))+'MB';
   end;
   if filesSize > 1024 then
   begin
    filesSize := filesSize/1024;
    Result := floatToStr(Round(filesSize))+'GB';
   end;
end;

exports MemoryEncrypt, MemoryDecrypt, TextEncrypt, TextDecrypt, FileEncrypt, FileDecrypt, ConvertFileSize;

begin
end.
