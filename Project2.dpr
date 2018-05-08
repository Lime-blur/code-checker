library Project2;

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

const
  c: array[0..63] of byte = ($7A, $FD, $24, $34, $12, $6B, $1E, $F0, $4C, $13, $EC, $CC, $63, $5A, $59, $E3, $13, $87, $A7, $62, $B8, $96, $84, $3C, $4A, $5D, $B0, $E6, $86, $78, $9A, $3C, $C9, $C6, $BD, $E3, $6A, $6B, $91, $C7, $AB, $94, $4D, $94, $76, $76, $E3, $3D, $88, $4B, $DA, $FF, $CD, $48, $F9, $60, $F4, $BB, $EB, $28, $93, $E1, $53, $4E);

{$R *.res}

function incryptStr(s: string): string; stdcall;
var
  n: integer;
begin
  for n := 1 to Length(s) do
    s[n] := char(Ord(s[n]) XOR c[n MOD SizeOf(c)]);
  IncryptStr := s;
end;

procedure decryptStr(var Pw; Leng: integer); stdcall;
var
  n: integer;
  P: ^byte;
begin
  P := @Pw;
  for n := 0 to Leng-1 do begin
    P^ := P^ XOR c[n MOD SizeOf(c)];
    inc(P);
  end;
end;

function convertFileSize(inputSize: Real) : String; stdcall;
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

exports incryptStr, decryptStr, convertFileSize;

begin
end.
 