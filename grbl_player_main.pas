unit grbl_player_main;
// CNC-Steuerung f�r GRBL-JOG-Platine mit GRBL 0.8c/jog.2 Firmware

interface

uses
  Math, StdCtrls, ComCtrls, ToolWin, Buttons, ExtCtrls, ImgList,
  Controls, StdActns, Classes, ActnList, Menus, GraphUtil,
  SysUtils, StrUtils, Windows, Graphics, Forms, Messages,
  Dialogs, Spin, FileCtrl, Grids, Registry, ShellApi,
  VFrames, ExtDlgs, grbl_com, FTDItypes, deviceselect, XPMan, CheckLst, drawing_window,
  glscene_view, ValEdit;

const
  c_ProgNameStr: String = 'GRBLize ';
  c_VerStr: String = '0.97a';

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    FileExitItem: TMenuItem;
    Edit0: TMenuItem;
    CutItem: TMenuItem;
    CopyItem: TMenuItem;                                                               
    PasteItem: TMenuItem;
    Help1: TMenuItem;
    HelpAboutItem: TMenuItem;
    ActionList1: TActionList;
    FileNew1: TAction;
    FileOpen1: TAction;
    FileSave1: TAction;
    FileSaveAs1: TAction;
    FileExit1: TAction;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    HelpAbout1: TAction;
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    ToolButton9: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    BtnRescan: TButton;
    DeviceView: TEdit;
    OpenFileDialog: TOpenDialog;
    Timer1: TTimer;
    BtnClose: TButton;
    XPManifest1: TXPManifest;
    N7: TMenuItem;
    OpenJobDialog: TOpenDialog;
    SaveJobDialog: TSaveDialog;
    PageControl1: TPageControl;
    TabSheetPens: TTabSheet;
    Label7: TLabel;
    StringGridPens: TStringGrid;
    TabSheetGroups: TTabSheet;
    TabSheetDefaults: TTabSheet;
    TabSheetRun: TTabSheet;
    Memo1: TMemo;
    StringgridGrblSettings: TStringGrid;
    StatusBar1: TStatusBar;
    Bevel3: TBevel;
    PosX: TLabel;
    BtnZeroX: TSpeedButton;
    PosY: TLabel;
    BtnZeroY: TSpeedButton;
    PosZ: TLabel;
    BtnZeroZ: TSpeedButton;
    Label11: TLabel;
    BtnSendGrblSettings: TBitBtn;
    ColorDialog1: TColorDialog;
    Bevel4: TBevel;
    BtnRun: TSpeedButton;
    BtnStop: TSpeedButton;
    BtnMoveWorkZero: TSpeedButton;
    BtnMovePark: TSpeedButton;
    BtnMoveToolChange: TSpeedButton;
    Label13: TLabel;
    Bevel2: TBevel;
    Label14: TLabel;
    BtnRefreshGrblSettings: TBitBtn;
    CheckPenChangePause: TCheckBox;
    CheckEndPark: TCheckBox;
    MposX: TLabel;
    MposY: TLabel;
    MposZ: TLabel;
    BtnHomeCycle: TSpeedButton;
    ComboBox1: TComboBox;
    TabSheet1: TTabSheet;
    StringGridFiles: TStringGrid;
    Label1: TLabel;
    Label5: TLabel;
    StringGridBlocks: TStringGrid;
    Label12: TLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    WindowMenu1: TMenuItem;
    ShowDrawing1: TMenuItem;
    Show3DPreview1: TMenuItem;
    ShowSpindleCam1: TMenuItem;
    AppDefaults: TStringGrid;
    MemoComment: TMemo;
    Label3: TLabel;
    Timer2: TTimer;
    BtnEmergStop: TBitBtn;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label6: TLabel;
    PanelLED: TPanel;
    Label4: TLabel;
    Panel4: TPanel;
    PlayGcodeBtn: TSpeedButton;
    CheckUseATC: TCheckBox;
    procedure PlayGcodeBtnClick(Sender: TObject);
    procedure ResetGRBLClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure StringGridPensMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PageControl1Change(Sender: TObject);
    procedure StringGridBlocksClick(Sender: TObject);
    procedure StringGridBlocksMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGridFilesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AppDefaultsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AppDefaultsClick(Sender: TObject);
    procedure ShowSpindleCam1Click(Sender: TObject);
    procedure Show3DPreview1Click(Sender: TObject);
    procedure ShowDrawing1Click(Sender: TObject);
    procedure AppDefaultsExit(Sender: TObject);
    procedure StringGridPensKeyPress(Sender: TObject; var Key: Char);
    procedure AppDefaultsKeyPress(Sender: TObject; var Key: Char);
    procedure StringGridFilesKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox1Exit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StringGridBlocksDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure BtnMoveToolChangeClick(Sender: TObject);
    procedure BtnMoveParkClick(Sender: TObject);
    procedure BtnMoveWorkZeroClick(Sender: TObject);
    procedure StringgridGrblSettingsDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure BtnRefreshGrblSettingsClick(Sender: TObject);
    procedure AppDefaultsDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure BtnHomeCycleClick(Sender: TObject);
    procedure BtnZeroZClick(Sender: TObject);
    procedure BtnZeroYClick(Sender: TObject);
    procedure BtnZeroXClick(Sender: TObject);
    procedure BtnSendGrblSettingsClick(Sender: TObject);
    procedure HelpAbout1Execute(Sender: TObject);
    procedure StringGridFilesDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGridFilesClick(Sender: TObject);
    procedure StringGridPensMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure StringGridPensMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure BtnStopClick(Sender: TObject);
    procedure BtnRunClick(Sender: TObject);
    procedure BitBtnClearFilesClick(Sender: TObject);
    procedure FileNew1Execute(Sender: TObject);
    procedure StringGridPensDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure JobSaveExecute(Sender: TObject);
    procedure JobSaveAsExecute(Sender: TObject);
    procedure BtnRescanClick(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure FileExitItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure JobOpenExecute(Sender: TObject);
    procedure Timer1Elapsed(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TLed = class
    private
      IsOn: Boolean;
      procedure SetLED(led_on: Boolean);
    public
      property Checked: Boolean read IsOn write SetLED;
    end;


  procedure EnableTestButtons;
  procedure SendlistWaitIdle;
  procedure CheckResponse;
  procedure WaitTimerFinished;

  
type

    T3dFloat = record
      X: Double;
      Y: Double;
      Z: Double;
    end;
var
  Form1: TForm1;
  LEDbusy: TLed;
  DeviceList: TStringList;
  TimeOutValue,LEDtimer: Integer;  // Timer-Tick-Z�hler
  TimeOut: Boolean;
  TimerCount1:Integer;
  StatusTimerFlag, GetStatusEnabled, TimerFinished, MachineRunning,
  CancelWait, CancelProc: Boolean;

  ComPortAvailableList: Array[0..31] of Integer;
  ComPortUsed: Integer;
  NeedsRedraw, NeedsRelist, NeedsRefresh3D: boolean;
  Scale: Double;
  JobSettingsPath: String;
  EmergencyStop, HomingPerformed: Boolean;
  grbl_mpos, grbl_wpos, old_grbl_wpos: T3dFloat;


implementation

uses import_files, Clipper, About, bsearchtree, cam_view;

{$R *.dfm}


// #############################################################################
// #############################################################################


procedure TLed.SetLED(led_on: boolean);
// liefert vorherigen Zustand zur�ck
begin
  if led_on then begin
    Form1.PanelLED.Color:= clred;
    Form1.PanelLED.Font.Color:= clWhite;
  end else begin
    Form1.PanelLED.Color:= clmaroon;
    Form1.PanelLED.Font.Color:= clgray;
  end;
  IsOn:= led_on;
  Application.ProcessMessages;
end;


procedure list_Blocks;
var i, my_len, my_row, my_pathcount: Integer;
  my_entry: Tfinal;
  x1, y1, x2, y2: Double;
begin
  with Form1.StringgridBlocks do begin
    Rowcount:= 2;
    Rows[1].clear;
    my_len:= length(final_array);
    if my_len < 1 then
      exit;
    for i:= 0 to my_len-1 do begin
      my_entry:= final_array[i];
      my_pathcount:= length(my_entry.millings);
      if my_pathcount = 0 then
        continue;
      // '#,Pen,Ena,Dia,Shape,Bounds,Center';
      my_row:= Rowcount - 1;
      Cells[0,my_row]:= IntToStr(my_row);
      Cells[1,my_row]:= IntToStr(my_entry.pen);
      if my_entry.enable then
        Cells[2,my_row]:= 'ON'
      else
        Cells[2,my_row]:= 'OFF';
      x1:= my_entry.bounds.min.x / c_hpgl_scale;
      y1:= my_entry.bounds.min.y / c_hpgl_scale;
      x2:= my_entry.bounds.max.x / c_hpgl_scale;
      y2:= my_entry.bounds.max.y / c_hpgl_scale;
      Cells[3,my_row]:= FormatFloat('0.0', job.pens[my_entry.pen].diameter);
      Cells[4,my_row]:= ShapeArray[ord(my_entry.shape)];
      Cells[5,my_row]:= FormatFloat('0.00', x1) + '/' + FormatFloat('0.00', y1)
          + ' - ' + FormatFloat('0.00', x2) + '/' + FormatFloat('0.00', y2);
      x1:= my_entry.bounds.mid.x / c_hpgl_scale;
      y1:= my_entry.bounds.mid.y / c_hpgl_scale;
      Cells[6,my_row]:= FormatFloat('0.00', x1) + '/' + FormatFloat('0.00', y1);
      Cells[7,my_row]:= IntToStr(length(my_entry.millings[0]));
      Rowcount:= Rowcount + 1;
    end;
    Rowcount:= Rowcount - 1;
    Col:= 1;
    if (HiliteBlock >= 0) and (HiliteBlock < RowCount) then
      Row:= HiliteBlock + 1
    else
      Row:= 1;
  end;
end;

// #############################################################################
// ############################### FILES AND JOBS ##############################
// #############################################################################




procedure PenGridListToJob;
var i, j: Integer;
begin
  for i:= 0 to c_numOfFiles do
    job.fileDelimStrings[i]:= Form1.StringGridFiles.Rows[i+1].DelimitedText;
  for i := 1 to 32 do with Form1.StringgridPens do begin
    // Color und Enable in DrawCell erledigt!
    j:= i-1;
    job.pens[j].color:= StrToIntDef(Cells[1,i],0);
    job.pens[j].enable:= (Cells[2,i]) = 'ON';
    job.pens[j].diameter:= StrToFloatDef(Cells[3,i],0.3);
    job.pens[j].z_end:= StrToFloatDef(Cells[4,i],0);
    job.pens[j].speed:= StrToIntDef(Cells[5,i],250);
    job.pens[j].offset.x:= round(StrToFloatDef(Cells[6,i],0) * c_hpgl_scale);
    job.pens[j].offset.y:= round(StrToFloatDef(Cells[7,i],0) * c_hpgl_scale);
    job.pens[j].scale:= StrToFloatDef(Cells[8,i],100);
    job.pens[j].shape:= Tshape(StrToIntDef(Cells[9,i],0));
    job.pens[j].z_inc:= StrToFloatDef(Cells[10,i],1);
    job.pens[j].atc:= StrToIntDef(Cells[11,i],0);
  end;
  NeedsRedraw:= true;
  NeedsRelist:= true;
  NeedsRefresh3D:= true;
end;

procedure JobToPenGridList;
var i: Integer;
begin
  for i := 0 to 31 do with Form1.StringgridPens do begin
    if i < 10 then
      Cells[0,i+1]:= 'P' + IntToStr(i)
    else
      Cells[0,i+1]:= 'D' + IntToStr(i-10);
    Cells[1,i+1]:= IntToStr(job.pens[i].color);
    if job.pens[i].enable then
      Cells[2,i+1]:= 'ON'
    else
      Cells[2,i+1]:= 'OFF';
    // Color und Enable in DrawCell erledigt!
    Cells[3,i+1]:=  FormatFloat('0.0',job.pens[i].diameter);
    Cells[4,i+1]:=  FormatFloat('0.0',job.pens[i].z_end);
    Cells[5,i+1]:=  IntToStr(job.pens[i].speed);
    Cells[6,i+1]:=  FormatFloat('00.0',job.pens[i].offset.x / c_hpgl_scale);
    Cells[7,i+1]:=  FormatFloat('00.0',job.pens[i].offset.y / c_hpgl_scale);
    Cells[8,i+1]:=  FormatFloat('00.0',job.pens[i].scale);
    // Shape in DrawCell erledigt!
    Cells[9,i+1]:=  IntToStr(ord(job.pens[i].shape));
    Cells[10,i+1]:= FormatFloat('0.0',job.pens[i].z_inc);
    Cells[11,i+1]:= IntToStr(job.pens[i].atc);
  end;
  Form1.StringgridPens.Repaint;
  for i:= 0 to c_numOfFiles do
    Form1.StringgridFiles.Rows[i+1].DelimitedText:= job.fileDelimStrings[i];
end;

procedure ClearFiles;
var i: Integer;
begin
  init_blockarrays;
  for i := 0 to c_numOfFiles do with Form1.StringGridFiles do begin
    Cells[0,i+1]:= '';
    Cells[1,i+1]:= 'OFF';
    Cells[2,i+1]:= '0�';
    Cells[3,i+1]:= 'OFF';
    Cells[4,i+1]:= '0';
    Cells[5,i+1]:= '0';
    Cells[6,i+1]:= '100';
    Cells[6,i+1]:= 'YES';
    job.fileDelimStrings[i]:= '"",-1,0�,OFF,0,0,100';
    with FileParamArray[i] do begin
      bounds.min.x := high(Integer);
      bounds.min.y := high(Integer);
      bounds.max.x := low(Integer);
      bounds.max.y := low(Integer);
      valid := false;
      isdrillfile:= false;
    end;
  end;

  with job do begin
    for i := 0 to 31 do begin
      pens[i].used:= false;
    end;
  end;
  JobToPenGridList;
  UnHilite;
  setlength(final_array,0);
  NeedsRedraw:= true;
  NeedsRelist:= true;
  NeedsRefresh3D:= true;
end;

procedure InitJob;
var i: Integer;
begin
  Form1.StringgridPens.Rows[0].DelimitedText:=
    'P/D,Clr,Ena,Dia,Z,F,Xofs,Yofs,"XY %",Shape,"Z-/Cyc",ATC';
  Form1.StringGridFiles.Rows[0].DelimitedText:=
    '"File (click to open)",Replce,Rotate,Mirror,Xofs,Yofs,"XY %"';
  Form1.StringGridBlocks.Rows[0].DelimitedText:=
    '#,P/D,Ena,Dia,Shape,Bounds,Center,Points';
  Form1.Appdefaults.Rows[0].DelimitedText:= 'Parameter,Value';

  with job do begin

    for i := 0 to 31 do begin
      pens[i]:= PenInit;
      pens[i].offset.x:= 0;
      pens[i].offset.y:= 0;
      pens[i].atc:= 0;
    end;
    pens[0].color:=clblack;
    pens[1].color:=$00004080;
    pens[2].color:=clred;
    pens[3].color:=$000080FF;
    pens[4].color:=clyellow;
    pens[5].color:=cllime;
    pens[6].color:=$00FF8000;
    pens[7].color:=clfuchsia;
    pens[8].color:=clgray;
    pens[9].color:=clsilver;
    pens[10].color:=clmaroon;
    pens[11].color:=clolive;
    pens[12].color:=clnavy;
    pens[13].color:=clpurple;
    pens[14].color:=clteal;
    pens[15].color:=clskyblue;
    pens[16].color:=clmoneygreen;
    pens[17].color:=clblue;
    pens[18].color:=clmedgray;
    pens[19].color:=clwhite;
    for i := 20 to 31 do begin
      pens[i].color:=clgray;
    end;
    for i := 10 to 31 do begin
      pens[i].shape:= drillhole;
      pens[i].z_end:= 2.0;
      pens[i].z_inc:= 3.0;
      pens[i].speed:= 500;
    end;
  end;
  with Form1.AppDefaults do begin
    RowCount:= 34;
    Rows[1].DelimitedText:='"Part Size X",250';
    Rows[2].DelimitedText:='"Part Size Y",150';
    Rows[3].DelimitedText:='"Part Size Z",5';
    Rows[4].DelimitedText:='"Z Feed",200';
    Rows[5].DelimitedText:='"Z Lift above Part",10';
    Rows[6].DelimitedText:='"Z Up above Part",5';
    Rows[7].DelimitedText:='"Z Gauge",10';
    Rows[8].DelimitedText:='"Optimize Drill Path",ON';
    Rows[9].DelimitedText:= '"Use Excellon Drill Diameters",ON';
    Rows[10].DelimitedText:= '"Tool Change Pause",OFF';
    Rows[11].DelimitedText:='"Tool Change X absolute",10';
    Rows[12].DelimitedText:='"Tool Change Y absolute",100';
    Rows[13].DelimitedText:='"Tool Change Z absolute",-5';
    Rows[14].DelimitedText:='"Park Position on End",ON';
    Rows[15].DelimitedText:='"Park X absolute",200';
    Rows[16].DelimitedText:='"Park Y absolute",100';
    Rows[17].DelimitedText:='"Park Z absolute",-5';
    Rows[18].DelimitedText:='"Cam X Offset","-20"';
    Rows[19].DelimitedText:='"Cam Y Offset","40"';
    Rows[20].DelimitedText:='"Cam Z Height above Part",20';
    Rows[21].DelimitedText:='"Use Tool Z Probe",OFF';
    Rows[22].DelimitedText:='"Probe X absolute",30';
    Rows[23].DelimitedText:='"Probe Y absolute",30';
    Rows[24].DelimitedText:='"Probe Z absolute",-5';
    Rows[25].DelimitedText:='"Invert Z in G-Code",OFF';
    Rows[26].DelimitedText:='"Scale Z Feed",1';
    Rows[27].DelimitedText:='"Spindle Accel Time (s)",4';
    Rows[28].DelimitedText:='"ATC enable",OFF';
    Rows[29].DelimitedText:='"ATC zero X absolute",50';
    Rows[30].DelimitedText:='"ATC zero Y absolute",20';
    Rows[31].DelimitedText:='"ATC pickup height Z abs",-20';
    Rows[32].DelimitedText:='"ATC row X distance",20';
    Rows[33].DelimitedText:='"ATC row Y distance",0';
  end;

  ClearFiles;
end;

procedure DefaultsGridListToJob;
begin
  with Form1.AppDefaults do begin
    if RowCount < 34 then begin
      showMessage('Job File invalid. Check number of #Default entries!' +
        #13 + 'Job will be reset to default values.');
      InitJob;
      exit;
    end;
    job.partsize_x:= StrToFloatDef(Cells[1,1], 0);
    job.partsize_y:= StrToFloatDef(Cells[1,2], 0);
    job.partsize_z:= StrToFloatDef(Cells[1,3], 0);

    job.z_feed:= StrToIntDef(Cells[1,4], 200);
    job.z_penlift:= StrToFloatDef(Cells[1,5], 10.0);
    job.z_penup:= StrToFloatDef(Cells[1,6], 5.0);
    job.z_gauge:= StrToFloatDef(Cells[1,7], 10);

    job.optimize_drills:= Cells[1,8] = 'ON';
    job.use_excellon_dia:= Cells[1,9] = 'ON';

    job.toolchange_pause:= Cells[1,10] = 'ON';
    Form1.CheckPenChangePause.Checked:= job.toolchange_pause;

    job.toolchange_x:= StrToFloatDef(Cells[1,11], 0);
    job.toolchange_y:= StrToFloatDef(Cells[1,12], 0);
    job.toolchange_z:= StrToFloatDef(Cells[1,13], 0);

    job.parkposition_on_end:= Cells[1,14] = 'ON';
    Form1.CheckEndPark.Checked:= job.parkposition_on_end;

    job.park_x:= StrToFloatDef(Cells[1,15], 0);
    job.park_y:= StrToFloatDef(Cells[1,16], 0);
    job.park_z:= StrToFloatDef(Cells[1,17], 0);

    job.cam_x:= StrToFloatDef(Cells[1,18], 0);
    job.cam_y:= StrToFloatDef(Cells[1,19], 0);
    job.cam_z:= StrToFloatDef(Cells[1,20], 0);

    job.use_probe:= Cells[1,21] = 'ON';
    job.probe_x:= StrToFloatDef(Cells[1,22], 0);
    job.probe_y:= StrToFloatDef(Cells[1,23], 0);
    job.probe_z:= StrToFloatDef(Cells[1,24], 0);

    job.invert_z:= Cells[1,25] = 'ON';
    job.z_feedmult:= StrToFloatDef(Cells[1,26], 1);
    if job.z_feedmult < 0.1 then
      job.z_feedmult:= 0.1;
    job.spindle_wait:= StrToIntDef(Cells[1,27], 3);
    job.atc_enabled:= Cells[1,28] = 'ON';
    Form1.CheckUseATC.Checked:= job.atc_enabled;
    job.atc_zero_x:= StrToFloatDef(Cells[1,29], 50);
    job.atc_zero_y:= StrToFloatDef(Cells[1,30], 20);
    job.atc_pickup_z:= StrToFloatDef(Cells[1,31], -20);
    job.atc_delta_x:= StrToFloatDef(Cells[1,32], 20);
    job.atc_delta_y:= StrToFloatDef(Cells[1,33], 0);
  end;
end;

// #############################################################################
// ################################## FILES ####################################
// #############################################################################

Procedure OpenFilesInGrid;
var
  i: Integer; my_path, my_ext: String;
begin
  PenGridListToJob;
  init_blockArrays;
  with Form1.StringGridFiles do
    for i:= 1 to c_numOfFiles +1 do begin
      if Cells[2, i] = '90�' then
        FileParamArray[i-1].rotate:= deg90
      else if Cells[2, i] = '270�' then
        FileParamArray[i-1].rotate:= deg270
      else if Cells[2, i] = '180�' then
        FileParamArray[i-1].rotate:= deg180
      else
        FileParamArray[i-1].rotate:= deg0;
      FileParamArray[i-1].penoverride:= StrToIntDef(Cells[1, i], -1);
      FileParamArray[i-1].mirror:= Cells[3, i] = 'ON';
      FileParamArray[i-1].offset.X:= round(StrToFloatDef(Cells[4, i], 0) * c_hpgl_scale);
      FileParamArray[i-1].offset.Y:= round(StrToFloatDef(Cells[5, i], 0) * c_hpgl_scale);
      FileParamArray[i-1].scale:= StrToFloatDef(Cells[6, i], 100.0);
      my_path:= Cells[0,i];
      my_ext:= AnsiUpperCase(ExtractFileExt(my_path));
      if my_ext = '' then
        continue;
      FileParamArray[i-1].isdrillfile := (my_ext = '.DRL');
      FileParamArray[i-1].enable:= true;
      if FileParamArray[i-1].isdrillfile then begin
        drill_fileload(my_path, i-1, StrToIntDef(Cells[1, i], -1), job.use_excellon_dia);
      end else if (my_ext = '.HPGL') or (my_ext = '.PLT') then
        hpgl_fileload(my_path, i-1, StrToIntDef(Cells[1, i], -1))
      else
        ShowMessage('Unknown File Extension:' + ExtractFileName(my_path));
    end;
  JobToPenGridList;
  param_change;
  NeedsRelist:= true;
  NeedsRedraw:= true;
  NeedsRefresh3D:= true;
  Form1.StringgridPens.Repaint;
end;

Procedure OpenJobFile(my_job_name: String);
var
// mySaveFile: File of Tjob;
 sl: TstringList;
 i, j, s, my_len, my_row: Integer;

begin
  JobSettingsPath:= my_job_name;
  sl:= Tstringlist.Create;
  if FileExists(my_job_name) then begin
    sl.LoadfromFile(my_job_name);
    if sl.strings[0]='#Files' then begin
      s:= 1;
      my_row:= 0;
      for i := s to sl.Count-1 do begin
        inc(my_row);
        if sl.strings[i]='#End' then
          break;
        if sl.strings[i]='#Pens' then
          break;
        Form1.StringGridFiles.Rows[my_row].DelimitedText:= sl.Strings[i];
      end;
      s:=i+1;
      my_row:= 0;
      for i := s to sl.Count-1 do begin
        inc(my_row);
        if sl.strings[i]='#End' then
          break;
        if sl.strings[i]='#Defaults' then
          break;
        Form1.StringGridPens.Rows[my_row].DelimitedText:= sl.Strings[i];
      end;
      s:=i+1;
      my_row:= 0;
      for i := s to sl.Count-1 do begin
        inc(my_row);
        if sl.strings[i]='#End' then
          break;
        if sl.strings[i]='#Blocks' then
          break;
        Form1.Appdefaults.Rowcount:= my_row+1;
        Form1.Appdefaults.Rows[my_row].DelimitedText:= sl.Strings[i];
      end;

      Form1.Caption:= c_ProgNameStr + '[' + JobSettingsPath + ']';
      PenGridListToJob;
      DefaultsGridListToJob;
      OpenFilesInGrid;
      s:=i+1;
      my_row:= 1;
      my_len:= length(final_array);
      for i := s to sl.Count-1 do begin
        if sl.strings[i]='#End' then
          break;
        if sl.strings[i]='#Comment' then
          break;
        if my_row <= my_len then begin
          Form1.StringGridBlocks.Rowcount:= my_row+1;
          Form1.StringGridBlocks.Rows[my_row].DelimitedText:= sl.Strings[i];
          for j:= 0 to length(ShapeArray)-1 do
            if Form1.StringGridBlocks.Cells[4,my_row] = ShapeArray[ord(j)] then
              final_array[my_row-1].shape:= Tshape(j);
          final_array[my_row-1].enable:= Form1.StringGridBlocks.Cells[2,my_row] = 'ON';
        end;
        inc(my_row);
      end;
      s:=i+1;
      Form1.MemoComment.Clear;
      for i := s to sl.Count-1 do begin
        if sl.strings[i]='#End' then
          break;
        Form1.MemoComment.Lines.Add(sl.Strings[i]);
      end;
    end;
  end else
    InitJob;
  sl.Free;
end;

function setting_val_extr(my_Str: String):String;
// Holt Wert aus "$x=1234.56 (blabla)"-Antwort
var
  my_pos1, my_pos2: Integer;
begin
  my_pos1:= Pos('=', my_str);
  my_pos2:= Pos(' ', my_str);
  if my_pos2 = 0 then my_pos2:= length(my_Str)-1 else dec(my_pos2);
  setting_val_extr:= copy(my_str, my_pos1+1, my_pos2-my_pos1);
end;


procedure SaveJob;
var
// mySaveFile: File of Tjob;
 sl: TstringList;
 i: Integer;
begin
  JobToPenGridList;
  sl:= Tstringlist.Create;
  sl.Add('#Files');
  for i:= 1 to Form1.StringgridFiles.Rowcount - 1 do
    sl.Add(Form1.StringgridFiles.Rows[i].CommaText);
  sl.Add('#Pens');
  for i:= 1 to Form1.StringgridPens.Rowcount - 1 do
    sl.Add(Form1.StringgridPens.Rows[i].CommaText);
  sl.Add('#Defaults');
  for i:= 1 to Form1.Appdefaults.Rowcount - 1 do
    sl.Add(Form1.Appdefaults.Rows[i].CommaText);
  sl.Add('#Blocks');
  list_blocks;
  if Form1.StringGridBlocks.Rowcount > 1 then
    for i:= 1 to Form1.StringGridBlocks.Rowcount - 1 do
      if Form1.StringGridBlocks.Cells[0,i] <> '' then
        sl.Add(Form1.StringGridBlocks.Rows[i].CommaText);
  sl.Add('#Comment');
  if Form1.MemoComment.Lines.Count > 0 then
    for i:= 0 to Form1.MemoComment.Lines.Count - 1 do
      sl.Add(Form1.MemoComment.Lines.Strings[i]);
  sl.Add('#End');
  sl.SaveToFile(JobSettingsPath);
  sl.Free;
end;


procedure TForm1.JobOpenExecute(Sender: TObject);
begin
  if OpenJobDialog.Execute then begin
    InitJob;
    DefaultsGridListToJob;
    OpenJobFile(OpenJobDialog.Filename);
  end;
end;

procedure TForm1.JobSaveAsExecute(Sender: TObject);
var
  my_ext: String;
begin
  if SaveJobDialog.Execute then begin
    JobSettingsPath := SaveJobDialog.Filename;
    my_ext:= AnsiUpperCase(ExtractFileExt(JobSettingsPath));
    if my_ext <> '.JOB' then
        JobSettingsPath:= JobSettingsPath + '.job';
    Form1.Caption:= c_ProgNameStr + '[' + JobSettingsPath + ']';
    SaveJob;
  end;
end;

procedure TForm1.JobSaveExecute(Sender: TObject);
begin
  if FileExists(JobSettingsPath) then
    SaveJob
  else
    JobSaveAsExecute(Sender);
end;



procedure TForm1.FileNew1Execute(Sender: TObject);
begin
  InitJob;
  DefaultsGridListToJob;
  if FileExists('default.job') then
    OpenJobFile('default.job');
  JobSettingsPath:= 'new.job';
  draw_cnc_all;
end;


// #############################################################################
// #############################################################################


procedure TForm1.BitBtnClearFilesClick(Sender: TObject);
begin
  if fActivated then
    exit;
  ClearFiles;
  draw_cnc_all;
end;

procedure DisableButtons;
begin
  with Form1 do begin
    BtnRun.Enabled:= false;
    BtnRun.Caption:= 'Run';
    BtnStop.Enabled:= false;
    BtnEmergStop.Enabled:= true;
    BtnZeroX.Enabled:= false;
    BtnZeroY.Enabled:= false;
    BtnZeroZ.Enabled:= false;
    BtnHomeCycle.Enabled:= false;
    BtnRefreshGrblSettings.Enabled:= false;
    BtnSendGrblSettings.Enabled:= false;
    BtnMoveWorkZero.Enabled:= false;
    BtnMoveToolChange.Enabled:= false;
    BtnMovePark.Enabled:= false;
  end;
end;

procedure EnableRunButtons;
begin
  with Form1 do begin
    BtnRun.Enabled:= true;
    BtnRun.Caption:= 'Run';
    BtnStop.Enabled:= true;
    // BtnEmergStop.Enabled:= true;
    BtnZeroX.Enabled:= true;
    BtnZeroY.Enabled:= true;
    BtnZeroZ.Enabled:= true;
    BtnMoveWorkZero.Enabled:= true;
    BtnMoveToolChange.Enabled:= true;
    BtnMovePark.Enabled:= true;
    BtnHomeCycle.Enabled:= true;
    BtnRefreshGrblSettings.Enabled:= true;
    BtnSendGrblSettings.Enabled:= true;
  end;
end;

procedure EnableTestButtons;
begin
  DisableButtons;
  with Form1 do begin
    BtnRun.Caption:= 'Test Run';
    BtnRun.Enabled:= true;
    BtnStop.Enabled:= true;
    BtnHomeCycle.Enabled:= false;
  end;
end;

procedure EnableNotHomedButtons;
begin
  with Form1 do begin
    if ftdi_isopen then
      BtnRun.Caption:= 'Run'
    else
      BtnRun.Caption:= 'Test Run';
    BtnRun.Enabled:= true;
    BtnStop.Enabled:= true;
    BtnZeroX.Enabled:= false;
    BtnZeroY.Enabled:= false;
    BtnZeroZ.Enabled:= false;
    BtnMoveWorkZero.Enabled:= true;
    BtnMoveToolChange.Enabled:= false;
    BtnMovePark.Enabled:= false;
    BtnHomeCycle.Enabled:= true;
    BtnRefreshGrblSettings.Enabled:= true;
    BtnSendGrblSettings.Enabled:= true;
  end;
end;

// #############################################################################
// ############################ M A I N  F O R M ###############################
// #############################################################################

function IsFormOpen(const FormName : string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := Screen.FormCount - 1 DownTo 0 do
    if (Screen.Forms[i].Name = FormName) then
    begin
      Result := True;
      Break;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  grbl_ini: TRegistryIniFile;
  my_ftdi_was_open: Boolean;
  i: Integer;
  vid, pid: word;
  my_device: fDevice;
  my_description: String;

begin
  TimerFinished:= false;
  MachineRunning:= false;
  EmergencyStop:= false;
  GetStatusEnabled:= false;
  grbl_receveivelist:= TStringList.create;
  grbl_receveivelist.clear;
  grbl_sendlist:= TStringList.create;
  grbl_sendlist.clear;
  LEDbusy:= Tled.Create;
  TimerCount1:= 0;
  InitJob;
  UnHilite;
  Caption := 'GRBLize';
  BtnRescan.Visible:= true;
  BtnClose.Visible:= false;
  JobSettingsPath:=ExtractFilePath(Application.ExeName)+'default.job';
  Form1.Show;
  grbl_ini:= TRegistryIniFile.Create('GRBLize');
  try
    Top:= grbl_ini.ReadInteger('MainForm','Top',150);
    Left:= grbl_ini.ReadInteger('MainForm','Left',200);
    JobSettingsPath:= grbl_ini.ReadString('Settings','Path',JobSettingsPath);
    //ftdi_selected_device:= grbl_ini.ReadInteger('Settings','Device',-1);
    ftdi_serial:= grbl_ini.ReadString('Settings','DeviceSerial','NONE');
    my_ftdi_was_open:= grbl_ini.ReadBool('Settings','DeviceOpen',false);
    WindowMenu1.Items[0].Checked:= grbl_ini.ReadBool('DrawingForm','Visible',true);
    WindowMenu1.Items[1].Checked:= grbl_ini.ReadBool('CamForm','Visible',false);
    WindowMenu1.Items[2].Checked:= grbl_ini.ReadBool('SceneForm','Visible',false);
  finally
    grbl_ini.Free;
  end;

  Form1.Memo1.lines.add('// ' + SetUpFTDI);
  if (ftdi_device_count > 0) and my_ftdi_was_open then
    if ftdi.isPresentBySerial(ftdi_serial) then begin
      // �ffnet Device nach Seriennummer
      // Stellt sicher, dass das beim letzten Form1.Close
      // ge�ffnete Device auch weiterhin verf�gbar ist.
      Memo1.lines.add('// ' + InitFTDIbySerial(ftdi_serial));
      if ftdi_isopen then begin
        ftdi.getDeviceInfo(my_device, pid, vid, ftdi_serial, my_description);
        BtnRescan.Visible:= false;
        BtnClose.Visible:= true;
        DeviceView.Text:= ftdi_serial + ' - ' + my_description;
      end;
    end;

  if not IsFormOpen('Form4') then
    Form4 := TForm4.Create(Self);
  if WindowMenu1.Items[2].Checked then
    Form4.show
  else
    Form4.hide;

  if not IsFormOpen('Form3') then
    Form3 := TForm3.Create(Self);
  if WindowMenu1.Items[1].Checked then
    Form3.show
  else
    Form3.hide;

  if not IsFormOpen('Form2') then
    Form2 := TForm2.Create(Self);
  if WindowMenu1.Items[0].Checked then
    Form2.show
  else
    Form2.hide;

  if not IsFormOpen('deviceselectbox') then
    deviceselectbox := Tdeviceselectbox.Create(Self);
  deviceselectbox.hide;

  Form1.BringToFront;

  HomingPerformed:= false;
  Combobox1.Parent := StringgridFiles;
  ComboBox1.Visible := False;
  StringgridFiles.Row:=1;
  StringgridFiles.Col:=4;
  if FileExists(JobSettingsPath) then
    OpenJobFile(JobSettingsPath)
  else
    Form1.FileNew1Execute(sender);
  Timer1.Enabled:= true;
  Timer2.Enabled:= true;
  CheckResponse;
end;


procedure TForm1.FileExitItemClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  grbl_ini:TRegistryIniFile;
begin
  CancelProc:= true;
  CancelWait:= true;
  WaitTimerFinished;
  Timer1.Enabled:= false;
  Timer2.Enabled:= false;

  grbl_ini:=TRegistryIniFile.Create('GRBLize');
  try
    grbl_ini.WriteInteger('MainForm','Top',Top);
    grbl_ini.WriteInteger('MainForm','Left',Left);
    grbl_ini.WriteString('Settings','Path',JobSettingsPath);
    grbl_ini.WriteBool('DrawingForm','Visible',Form1.WindowMenu1.Items[0].Checked);
    grbl_ini.WriteBool('CamForm','Visible',Form1.WindowMenu1.Items[1].Checked);
    grbl_ini.WriteBool('SceneForm','Visible',Form1.WindowMenu1.Items[2].Checked);
    if ftdi_isopen then
      grbl_ini.WriteString('Settings','DeviceSerial', ftdi_serial);
    grbl_ini.WriteBool('Settings','DeviceOpen',ftdi_isopen);
  finally
    grbl_ini.Free;
  end;
  if ftdi_isopen then begin
    ftdi_isopen:= false;
    ftdi.closeDevice;
  end;
  Form2.Close;
  Form3.Close;
  Form4.Close;
  grbl_receveivelist.Clear;
  grbl_receveivelist.free;
  grbl_sendlist.Clear;
  grbl_sendlist.free;
  LEDbusy.free;
  freeandnil(ftdi);
end;



// #############################################################################
// ########################### Stringgrid Handler ##############################
// #############################################################################


procedure TForm1.StringGridFilesDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  aRect: TRect;
  aStr: String;
begin
  if aRow = 0 then with StringGridFiles,Canvas do begin
    Font.Style := [fsBold];
    TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Cells[ACol, ARow]);
  end else with StringGridFiles,Canvas do begin
{    if (ACol = Col) and (ARow= Row) and (aCol <> 0) then begin
      Brush.Color := clHighlight;
      Font.Color:=clwhite;
      TextRect(Rect, Rect.Left + 2, Rect.Top + 2, cells[acol, arow]);
      Font.Color:=clblack;
    end;
}
    Font.Color:=clblack;
    Pen.Color := cl3Dlight;
    aStr:= Cells[ACol, ARow];
    case aCol of
      0:
        begin
          aStr:= extractFilename(Cells[0,aRow]);
          FrameRect(Rect);
          inc(Rect.Left);
          inc(Rect.Top);
          Brush.Color := clgray;
          FrameRect(Rect);
          Brush.Color := cl3Dlight;
          InflateRect(Rect, -1, -1);
          TextRect(Rect, Rect.Left + 2, Rect.Top + 1, aStr);
        end;
      1,2,3:
        begin
          FrameRect(Rect);
          inc(Rect.Left);
          inc(Rect.Top);
          Brush.Color := clgray;
          FrameRect(Rect);
          Brush.Color := cl3Dlight;
          InflateRect(Rect, -1, -1);
          Font.Style := [];
          if aCol = 1 then begin
            if aStr = '-1' then
              aStr:= 'OFF'
            else
              if astr = '10' then
                aStr:= 'Drill 10'
              else
                aStr:= 'Pen '+ aStr;
          end;
          if aStr <> 'OFF' then
            Font.Style := [fsBold];
          if aStr = '0�' then
            Font.Style := [];
          FillRect(Rect);
          aRect := Rect;
          aRect.Top := aRect.Top + 1; // adjust top to center
          DrawText(Canvas.Handle, PChar(aStr), Length(aStr), aRect, DT_CENTER);
        end;
      7:  // Clear-"Button"
        begin
          FrameRect(Rect);
          inc(Rect.Left);
          inc(Rect.Top);
          Brush.Color := clgray;
          FrameRect(Rect);
          Brush.Color := cl3Dlight;
          InflateRect(Rect, -1, -1);
          Font.Style := [];
          aStr:= 'CLR';
          Font.Style := [];
          FillRect(Rect);
          aRect := Rect;
          aRect.Top := aRect.Top + 1; // adjust top to center
          DrawText(Canvas.Handle, PChar(aStr), Length(aStr), aRect, DT_CENTER);
        end;
    end;
  end;
end;


procedure TForm1.ComboBox1Exit(Sender: TObject);
begin
  with sender as TComboBox do begin
    hide;
    StringGridFiles.Options:= StringGridFiles.Options - [goEditing, goAlwaysShowEditor];
    if ItemIndex >= 0 then
      with StringGridFiles do
        if (Row > 0) and (Col= 1) then begin
          Cells[col, row] := IntToStr(ItemIndex-1); //  := Items[ItemIndex];
          job.fileDelimStrings[Row-1]:= Rows[Row].DelimitedText;
          UnHilite;
          OpenFilesInGrid;
          Repaint;
        end;
  end;
  StringGridFiles.Options:= StringGridFiles.Options - [goEditing];
end;

procedure TForm1.StringGridFilesMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var R: TRect;
  org: TPoint;
    i: Integer;
begin
  with StringGridFiles do begin
    Options:= Options - [goEditing, goAlwaysShowEditor];
    if (Row > 0) and (Col > 0)then begin
      case Col of
        1:
          begin
            R := StringGridFiles.CellRect(Col, Row);
            org := self.ScreenToClient(self.ClientToScreen(R.TopLeft));
            perform( WM_CANCELMODE, 0, 0 ); // verhindert Mausaktion in Stringgrid
            with ComboBox1 do begin
              SetBounds(org.X, org.Y-18, R.Right-R.Left, Form1.Height);
              ItemIndex := Items.IndexOf('Pen '+StringGridFiles.Cells[Col, Row]);
              if ItemIndex < 0 then
                ItemIndex:= 0;
              Show;
              BringToFront;
              SetFocus;
              DroppedDown := true;
            end;
            exit;
          end;
        2:
          begin
            if Cells[2, Row] = '0�' then
              Cells[2, Row]:= '90�'
            else if Cells[2, Row] = '90�' then
              Cells[2, Row]:= '180�'
            else if Cells[2, Row] = '180�' then
              Cells[2, Row]:= '270�'
            else
              Cells[2, Row]:= '0�';
          end;
        3:
          begin
            if Cells[3, Row] = 'ON' then
              Cells[3, Row]:= 'OFF'
            else
              Cells[3, Row]:= 'ON';
          end;
        4,5,6:
          begin
            Options:= Options + [goEditing, goAlwaysShowEditor];
          end;
        7:
          begin
            Cells[0, Row]:= '';
            Cells[1, Row]:= '-1';
            Cells[2, Row]:= '0�';
            Cells[3, Row]:= 'OFF';
            for i:= 0 to c_numOfPens do
              job.pens[i].used:= false;
          end;
        end;
      job.fileDelimStrings[Row-1]:= Rows[Row].DelimitedText;
      UnHilite;
      OpenFilesInGrid;
    end;
  end;
end;

procedure TForm1.StringGridFilesKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) or (Key = #10) then
    with StringGridFiles do begin
      job.fileDelimStrings[Row-1]:= Rows[Row].DelimitedText;
      Options:= Options - [goEditing, goAlwaysShowEditor];
      Repaint;
      UnHilite;
      PenGridListToJob;
      OpenFilesInGrid;
    end;
end;


procedure TForm1.StringGridFilesClick(Sender: TObject);
// wird nach Loslassen der Maustaste ausgef�hrt!
begin
  with StringGridFiles do begin
    Options:= Options - [goEditing, goAlwaysShowEditor];
    if (Row > 0) and (Col = 0) then begin
      OpenFileDialog.FilterIndex:= 0;
      if OpenFileDialog.Execute then
        Cells[0, Row]:= OpenFileDialog.Filename
      else
        Cells[0, Row]:= '';
      job.fileDelimStrings[Row-1]:= Rows[Row].DelimitedText;
      UnHilite;
      OpenFilesInGrid;
    end;
  end;
end;

// #############################################################################

procedure TForm1.StringGridPensDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  my_shape: Tshape;
  aRect: TRect;
  aStr: String;
begin
  if aRow = 0 then with StringgridPens,Canvas do begin
    Font.Style := [fsBold];
    TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Cells[ACol, ARow]);
  end else with StringgridPens,Canvas do begin
      // Draw the Band
    if (ACol > 2) then begin
      if not job.pens[aRow-1].enable then begin
        Brush.Color := clBtnFace;
        Font.Color:=clgrayText;
      end;
      TextRect(Rect, Rect.Left + 2, Rect.Top + 2, cells[acol, arow]);
    end;
    if (ACol = Col) and (ARow= Row) then begin
      Brush.Color := clHighlight;
      Font.Color:=clwhite;
      TextRect(Rect, Rect.Left + 2, Rect.Top + 1, cells[acol, arow]);
      Font.Color:=clblack;
    end;
    case aCol of
    0: // Pen
      begin
        Font.Style := [fsBold];
        Font.Color:=clblack;
        TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Cells[ACol, ARow]);
      end;
    1: // Color
      begin
        Brush.Color := clgray;
        FrameRect(Rect);
        Brush.Color := job.pens[aRow-1].color;
        InflateRect(Rect, -1, -1);
        FillRect(Rect);
      end;
    2: // Enable
      begin
        Brush.Color := clgray;
        Pen.Color := cl3Dlight;
        inc(Rect.Left);
        inc(Rect.Top);
        FrameRect(Rect);
        Brush.Color := cl3Dlight;
        InflateRect(Rect, -1, -1);
        if job.pens[aRow-1].used then begin
          if job.pens[aRow-1].enable then
            Font.Color:= clred
          else
            Font.Color:=clblack;
        end else
            Font.Color:=clwhite;
        if job.pens[aRow-1].enable then
          Font.Style := [fsBold];
        FillRect(Rect);
        aRect := Rect;
        aStr:= Cells[ACol, ARow];
        aRect.Top := aRect.Top + 1; // adjust top to center vertical
        DrawText(Canvas.Handle, PChar(aStr), Length(aStr), aRect, DT_CENTER);
      end;
    9:  // Shape
      begin
        Brush.Color := clgray;
        Pen.Color := cl3Dlight;
        inc(Rect.Left);
        inc(Rect.Top);
        FrameRect(Rect);
        Brush.Color := cl3Dlight;
        InflateRect(Rect, -1, -1);
        FillRect(Rect);
        aRect := Rect;
        my_shape:= job.pens[aRow-1].shape;
        Font.Color:= ShapeColorArray[ord(my_shape)];
        aStr:= ShapeArray[ord(my_shape)];
        aRect.Top := aRect.Top + 1; // adjust top to center vertical
        DrawText(Canvas.Handle, PChar(aStr), Length(aStr), aRect, DT_CENTER);
      end;
    end; //case
  end;
end;

procedure TForm1.StringGridPensKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) or (Key = #10) then begin
    PenGridListToJob;
    param_change;
  end;
end;


procedure TForm1.StringGridPensMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  my_shape, max_shape: Tshape;
begin
  UnHilite;
  with (Sender as TStringGrid) do begin
    case Col of
    1:  // Color
      begin
        Options:= Options - [goEditing];
        ColorDialog1.Color:= job.pens[Row-1].color;
        if not ColorDialog1.Execute then Exit;
        Cells[1,Row]:= IntToStr(ColorDialog1.Color);
        PenGridListToJob;
      end;
    2:  // Enable
      begin
        Options:= Options - [goEditing];
        job.pens[Row-1].enable:= not job.pens[Row-1].enable;
        if job.pens[Row-1].enable then
          Cells[2,Row]:= 'ON'
        else
          Cells[2,Row]:= 'OFF';
        PenGridListToJob;
        param_change;
      end;
    3: // Diameter
      begin
        Options:= Options + [goEditing];
        PenGridListToJob;
        param_change;
      end;
    4,5,6,7,10,11:  // Z, F, Xofs, Yofs, Z+
      begin
        Options:= Options + [goEditing];
        PenGridListToJob;
      end;
    8:  // Scale
      begin
        Options:= Options + [goEditing];
        job.pens[Row-1].Scale:= StrToFloatDef(Cells[8,Row],100);
        PenGridListToJob;
        param_change;
      end;
    9:  // Shapes
      begin
        Options:= Options - [goEditing];
        my_shape:= job.pens[Row-1].shape;
        if Row < 11 then
          max_shape:= pocket
        else
          max_shape:= drillhole;
        if my_shape >= max_shape then
          job.pens[Row-1].shape:= online
        else
          inc(job.pens[Row-1].shape);
        Cells[9,Row]:= IntToStr(ord(job.pens[Row-1].shape));
        PenGridListToJob;
        param_change;
      end;
    end; //case
    Repaint;
  end;
end;

procedure TForm1.StringGridPensMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var my_str: String;
  my_int: Integer;
  my_float: Double;
begin
  Handled := True;
  my_str:= StringgridPens.Cells[StringgridPens.Col, StringgridPens.Row];
  my_int:= StrToIntDef(my_str, 0);
  my_float:= StrToFloatDef(my_str, 0);

  case StringgridPens.Col of   // Dia, Z, Speed, X Offset, Y Offset, Z+/Cycle
    3:  // Dia
      begin
        my_float:= my_float - 0.5;
        if my_float < 0 then
          my_float:= 0;
        StringgridPens.Cells[StringgridPens.Col, StringgridPens.Row]:= FloatToStr(my_float);
        PenGridListToJob;
        param_change;
      end;
    4: // Z
      begin
        my_float:= my_float - 0.1;
        StringgridPens.Cells[StringgridPens.Col, StringgridPens.Row]:= FloatToStr(my_float);
        PenGridListToJob;
      end;
    5:  // Speed
      begin
        my_int:= my_Int - 50;
        if my_Int < 0 then
          my_int:= 0;
        StringgridPens.Cells[StringgridPens.Col, StringgridPens.Row]:= IntToStr(my_int);
        PenGridListToJob;
      end;
    6, 7, 8:
      begin
        my_float:= int(my_float) - 1;
        StringgridPens.Cells[StringgridPens.Col, StringgridPens.Row]:= FloatToStr(my_float);
        PenGridListToJob;
        if StringgridPens.Col = 8 then
          param_change;
      end;
    10:  // Z+
      begin
        my_float:= my_float - 0.5;
        StringgridPens.Cells[StringgridPens.Col, StringgridPens.Row]:= FloatToStr(my_float);
        PenGridListToJob;
      end;
    else
      param_change;
  end;
end;

procedure TForm1.StringGridPensMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var my_str: String;
  my_int: Integer;
  my_float: Double;
begin
  Handled := True;
  my_str:= StringgridPens.Cells[StringgridPens.Col, StringgridPens.Row];
  my_int:= StrToIntDef(my_str, 0);
  my_float:= StrToFloatDef(my_str, 0);

  case StringgridPens.Col of   // Dia, Z, Speed, X Offset, Y Offset, Scale,  Z+/Cycle
    3: // Dia
      begin
        my_float:= my_float + 0.5;
        StringgridPens.Cells[StringgridPens.Col, StringgridPens.Row]:= FloatToStr(my_float);
        PenGridListToJob;
        param_change;
      end;
    4:  // Z
      begin
        my_float:= my_float + 0.1;
        StringgridPens.Cells[StringgridPens.Col, StringgridPens.Row]:= FloatToStr(my_float);
        PenGridListToJob;
      end;
    5:  // Speed
      begin
        my_int:= my_Int + 50;
        StringgridPens.Cells[StringgridPens.Col, StringgridPens.Row]:= IntToStr(my_int);
        PenGridListToJob;
      end;
    6, 7, 8:
      begin
        my_float:= int(my_float) + 1;
        StringgridPens.Cells[StringgridPens.Col, StringgridPens.Row]:= FloatToStr(my_float);
        PenGridListToJob;
        if StringgridPens.Col = 8 then
          param_change;
      end;
    10: // Z+/Cycle
      begin
        my_float:= my_float + 0.5;
        if my_float > -0.5 then
          my_float:= -0.5;
        StringgridPens.Cells[StringgridPens.Col, StringgridPens.Row]:= FloatToStr(my_float);
        PenGridListToJob;
      end;
    else
      param_change;
  end;
end;

procedure TForm1.PageControl1Change(Sender: TObject);
begin
  StringgridPens.Col:= 3;
  StringgridPens.Row:= 1;
end;

// #############################################################################

procedure TForm1.StringGridBlocksDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  i: Integer;
  aRect: TRect;
  aStr: String;
begin
  with StringGridBlocks,Canvas do begin
    aStr:= Cells[ACol, ARow];
    if (aRow = 0) or (aCol = 0) then begin
      Font.Style := [fsBold];
      TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Cells[ACol, ARow]);
    end else if aRow <= length(final_array) then begin
      Font.Color := clblack;
      case aCol of
        2,4:
          begin  // ON, OFF
            FrameRect(Rect);
            inc(Rect.Left);
            inc(Rect.Top);
            Brush.Color := clgray;
            FrameRect(Rect);
            Brush.Color := cl3Dlight;
            InflateRect(Rect, -1, -1);
            if aStr = 'ON' then
              Font.Style := [fsBold]
            else
              Font.Style := [];
            FillRect(Rect);
            aRect := Rect;
            if aCol = 4 then begin
              i:= ord(final_array[aRow-1].shape);
              Font.Color:= ShapeColorArray[i];
              aStr:= ShapeArray[i];
            end;
            aRect.Top := aRect.Top + 1; // adjust top to center vertical
            DrawText(Canvas.Handle, PChar(aStr), Length(aStr), aRect, DT_CENTER);
          end;
        else begin
          if not final_array[aRow-1].enable then begin
            Brush.Color := clBtnFace;
            Font.Color:=clgrayText;
          end;
          if (HiliteBlock = aRow-1) then
            Font.Color := clred;
        end;
        TextRect(Rect, Rect.Left + 2, Rect.Top + 2, aStr);
      end;
    end;
  end;
end;

procedure TForm1.StringGridBlocksMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  my_bool: Boolean;
begin
  UnHilite;
  with StringGridBlocks do begin
    HiliteBlock:= Row - 1;
    my_bool:= false;
    if Col = 2 then begin
      if Cells[2, Row] = 'ON' then
        Cells[2, Row]:= 'OFF'
      else if Cells[2, Row] = 'OFF' then begin
        Cells[2, Row]:= 'ON';
        my_bool:= true;
      end;
      final_array[HiliteBlock].enable:= my_bool;
    end else if Col = 4 then begin
      if final_array[Row-1].shape = drillhole then
        final_array[Row-1].shape:= online
      else
        inc(final_array[Row-1].shape);
      Cells[4,Row]:= ShapeArray[ord(final_array[Row-1].shape)];
    end else begin
    end;
    NeedsRefresh3D:= true;
  end;
end;

procedure TForm1.StringGridBlocksClick(Sender: TObject);
// wird nach Loslassen der Maustaste ausgef�hrt!
begin
  StringGridBlocks.Repaint;
  NeedsRedraw:= true;
  NeedsRefresh3D:= true;
end;

// #############################################################################
// ############################## DEFAULTS #####################################
// #############################################################################

procedure TForm1.AppDefaultsDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  aRect: TRect;
  aStr: String;

begin
  aStr:= AppDefaults.Cells[ACol, ARow];
  if aRow = 0 then with AppDefaults,Canvas do begin
    Font.Style := [fsBold];
    TextRect(Rect, Rect.Left + 2, Rect.Top + 2, aStr);
  end else if (aRow < 8) and (aCol = 0) then with AppDefaults,Canvas do begin
    Font.Color := clred;
    TextRect(Rect, Rect.Left + 2, Rect.Top + 2, aStr);
  end else if (aCol = 1) and ((aStr= 'ON') or (aStr= 'OFF')) then // ON, OFF
    with AppDefaults,Canvas do begin
      FrameRect(Rect);
      inc(Rect.Left);
      inc(Rect.Top);
      Brush.Color := clgray;
      FrameRect(Rect);
      Brush.Color := cl3Dlight;
      InflateRect(Rect, -1, -1);
      Font.Color := clblack;
      if aStr = 'ON' then
        Font.Style := [fsBold]
      else
        Font.Style := [];
      aRect := Rect;
      FillRect(Rect);
      aStr:= Cells[ACol, ARow];
      aRect.Top := aRect.Top + 1; // adjust top to center vertical
      DrawText(Canvas.Handle, PChar(aStr), Length(aStr), aRect, DT_CENTER);
    end;
end;

procedure TForm1.AppDefaultsExit(Sender: TObject);
begin
  with AppDefaults do
    Options:= Options - [goEditing, goAlwaysShowEditor];
  DefaultsGridListToJob;
  PenGridListToJob;
  OpenFilesInGrid;
  NeedsRefresh3D:= true;
end;

procedure TForm1.AppDefaultsKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) or (Key = #10) then begin
    AppDefaultsExit(Sender);;
  end;
end;


procedure TForm1.AppDefaultsMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
// wird vor AppDefaultsClick aufgerufen!
begin
  with AppDefaults do begin
    Options:= Options - [goEditing, goAlwaysShowEditor];
    if Col = 1 then begin
      if Cells[1, Row] = 'ON' then begin
        Cells[1, Row]:= 'OFF';
        DefaultsGridListToJob;
        OpenFilesInGrid;
      end else if Cells[1, Row] = 'OFF' then begin
        Cells[1, Row]:= 'ON';
        DefaultsGridListToJob;
        OpenFilesInGrid;
      end else
        Options:= Options + [goEditing, goAlwaysShowEditor];
    end;
  end;
end;

procedure TForm1.AppDefaultsClick(Sender: TObject);
var i: Integer;
begin
  with AppDefaults do
    Options:= Options - [goEditing, goAlwaysShowEditor];
  NeedsRedraw:= true;
  NeedsRelist:= true;
  NeedsRefresh3D:= true;
end;

// #############################################################################
// ############################## T I M E R ####################################
// #############################################################################


procedure TForm1.Timer1Elapsed(Sender: TObject);
begin
  inc(TimerCount1);
  if (TimerCount1 = 10) and (not HomingPerformed) and ftdi_isopen then
    Form1.BtnHomeCycle.Font.Color:= clPurple;
  if (TimerCount1 = 20) and (not HomingPerformed) and ftdi_isopen then
    Form1.BtnHomeCycle.Font.Color:= clfuchsia;
  if (TimerCount1 >= 20) then begin
    TimerCount1:= 0;
    if not MachineRunning then
      LEDbusy.Checked:= false;
  end;
  if NeedsRedraw and Form1.WindowMenu1.Items[0].Checked then begin
    draw_cnc_all;
    NeedsRedraw:= false;
  end;
  if NeedsRelist and (Form1.PageControl1.TabIndex = 2) then begin
    list_blocks;
    NeedsRelist:= false;
  end;
  if NeedsRefresh3D and Form1.WindowMenu1.Items[2].Checked then begin
    Form4.FormRefresh(nil);
    NeedsRefresh3D:= false;
  end;

end;

procedure DecodeResponse(the_response: String);
var
  my_start_idx: Integer;
  is_valid: Boolean;
  my_str: String;
begin
  // Idle,MPos,100.00,0.00,0.00,WPos,100.00,0.00,0.00
  is_valid:= false;
  with Form1 do begin
    StatusBar1.Hint:= the_response;
    grbl_receveivelist.clear;
    grbl_receveivelist.CommaText:= the_response;

    if grbl_receveivelist.Count < 2 then
      exit;

    my_Str:= grbl_receveivelist[0];

    if my_Str = 'Idle' then begin
      Panel1.Color:= clLime;
      is_valid:= true;
    end else
      Panel1.Color:= $00004000;

    if (my_Str = 'Queue') or (my_Str =  'Hold') then begin
      is_valid:= true;
      Panel2.Color:= clAqua;
    end else
      Panel2.Color:= $00400000;

    if (my_Str = 'Run') or AnsiContainsStr(my_Str,'Jog') then begin
      is_valid:= true;
      Panel3.Color:= clFuchsia;
    end else
      Panel3.Color:= $00400040;

    if my_Str = 'Alarm' then begin
      is_valid:= true;
      Panel4.Color:= clRed;
    end else
      Panel4.Color:= $00000040;

    // keine g�ltige Statusmeldung?
    if not is_valid then
      exit;

    my_start_idx:= grbl_receveivelist.IndexOf('MPos');
    if my_start_idx >= 0 then begin
      grbl_mpos.x:= StrDotToFloat(grbl_receveivelist[my_start_idx+1]);
      MPosX.Caption:= grbl_receveivelist[my_start_idx+1];
      grbl_mpos.y:= StrDotToFloat(grbl_receveivelist[my_start_idx+2]);
      MPosY.Caption:= grbl_receveivelist[my_start_idx+2];
      grbl_mpos.z:= StrDotToFloat(grbl_receveivelist[my_start_idx+3]);
      MPosZ.Caption:= grbl_receveivelist[my_start_idx+3];
    end;
    my_start_idx:= grbl_receveivelist.IndexOf('WPos');
    if my_start_idx >= 0 then begin
       grbl_wpos.x:= StrDotToFloat(grbl_receveivelist[my_start_idx+1]);
      PosX.Caption:= FormatFloat('000.00', grbl_wpos.x);
      grbl_wpos.y:= StrDotToFloat(grbl_receveivelist[my_start_idx+2]);
      PosY.Caption:= FormatFloat('000.00', grbl_wpos.y);
      grbl_wpos.z:= StrDotToFloat(grbl_receveivelist[my_start_idx+3]);
      PosZ.Caption:= FormatFloat('000.00', grbl_wpos.z);
    end;
    my_start_idx:= grbl_receveivelist.IndexOf('JogX');
    if my_start_idx >= 0 then begin
      grbl_wpos.x:= StrDotToFloat(grbl_receveivelist[my_start_idx+1]);
      PosX.Caption:= FormatFloat('000.00', grbl_wpos.x);
    end;
    my_start_idx:= grbl_receveivelist.IndexOf('JogY');
    if my_start_idx >= 0 then begin
      grbl_wpos.y:= StrDotToFloat(grbl_receveivelist[my_start_idx+1]);
      PosY.Caption:= FormatFloat('000.00', grbl_wpos.y);
    end;
    my_start_idx:= grbl_receveivelist.IndexOf('JogZ');
    if my_start_idx >= 0 then begin
      grbl_wpos.z:= StrDotToFloat(grbl_receveivelist[my_start_idx+1]);
      PosZ.Caption:= FormatFloat('000.00', grbl_wpos.z);
    end;
  end;
  if (old_grbl_wpos.X <> grbl_wpos.X) or (old_grbl_wpos.Y <> grbl_wpos.Y) then begin
    ToolCursor.X:= round(grbl_wpos.X * 40);
    ToolCursor.Y:= round(grbl_wpos.Y * 40);
    NeedsRedraw:= true;
    old_grbl_wpos:= grbl_wpos;
  end;
end;

procedure WaitTimerFinished;
// Warte, bis Timer2-Routine mit GetStatus beendet
begin
  if not Form1.Timer2.enabled then
    exit;
  TimerFinished:= false;
  repeat
    Application.ProcessMessages;
  until TimerFinished;
  if grbl_receiveCount <> 0 then
    DecodeResponse(grbl_receiveStr(80, true)); // noch im Buffer
end;

function WaitTimerFinishedResync: Boolean;
// Warte, bis Timer2-Routine mit GetStatus beendet
begin
  WaitTimerFinished;
  GetStatusEnabled:= false; // nicht st�ren
  WaitTimerFinishedResync:= grbl_resync;
end;

procedure CheckResponse;
var
  my_str: String;
  i: Integer;
begin
  CancelProc:= false;
  EmergencyStop:= false;
  grbl_sendlist.Clear;
  if ftdi_isopen then begin
    if WaitTimerFinishedResync then begin
      GetStatusEnabled:= true;
      EnableNotHomedButtons;
      Form1.BtnRefreshGrblSettingsClick(nil);
      Form1.BtnZeroXClick(nil);
      Form1.BtnZeroYClick(nil);
      Form1.BtnZeroZClick(nil);
    end else begin
      EnableTestButtons;
      showmessage('GRBL not responding or busy!');
      Form1.BtnCloseClick(nil);
    end;
  end else
    EnableTestButtons;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
// alle 100 ms aufgerufen. Zeit reicht zum Empfang der Statusmeldung
var
  my_str: String;
begin
  if ftdi_isopen and GetStatusEnabled and (not CancelProc) then begin
  // wenn Sendeliste leer, neue Koordinaten anfordern
    while (grbl_receiveCount <> 0) and (not CancelProc) do begin
      my_str:= grbl_receiveStr(80, true); // noch im Buffer
      DecodeResponse(my_str);
    end;
    if not CancelProc then
      grbl_sendStr('?', false, false);     // neuen Status anfordern
  end;
  TimerFinished:= true;
  StatusTimerFlag:= true;
end;

// #############################################################################
// ######################## GRBL OPEN/CLOSE BUTTONS ############################
// #############################################################################


procedure TForm1.BtnRescanClick(Sender: TObject);
// Auswahl des Frosches unter FTDI-Devices
var i : Integer; LV : TListItem;
begin
// Alle verf�gbaren COM-Ports pr�fen, Ergebnisse in Array speichern
  deviceselectbox.ListView1.Items.clear;
  SetUpFTDI;
  if ftdi_device_count > 0 then
    for i := 0 to ftdi_device_count - 1 do begin
      LV := deviceselectbox.ListView1.Items.Add;
      LV.Caption := 'Device '+IntToStr(i);
      LV.SubItems.Add(ftdi_sernum_arr[i]);
      LV.SubItems.Add(ftdi_desc_arr[i]);
    end
  else
    exit;
  deviceselectbox.ListView1.Items[0].Selected := true;
  deviceselectbox.ShowModal;
  if (deviceselectbox.ModalResult=MrOK) and (ftdi_device_count > 0) then begin
    ftdi_selected_device:= deviceselectbox.ListView1.itemindex;
    Memo1.lines.add('// ' + InitFTDI(ftdi_selected_device));
    if ftdi_isopen then begin
      BtnRescan.Visible:= false;
      BtnClose.Visible:= true;
      ftdi_serial:= ftdi_sernum_arr[ftdi_selected_device];
      DeviceView.Text:= ftdi_serial + ' - ' + ftdi_desc_arr[ftdi_selected_device];
    end;
  end;
  CheckResponse;
end;

procedure TForm1.BtnCloseClick(Sender: TObject);
begin
  WaitTimerFinished;
  if ftdi_isopen then
    ftdi.closeDevice;
  ftdi_isopen:= false;
  BtnRescan.Visible:= true;
  BtnClose.Visible:= false;
  DeviceView.Text:= '(not selected)';
  EnableTestButtons;
  HomingPerformed:= false;
end;

// #############################################################################
// ########################## GRBL DEFAULT BUTTONS #############################
// #############################################################################

procedure TForm1.StringgridGrblSettingsDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if aRow = 0 then with (Sender as TStringGrid),Canvas do begin
    Font.Style := [fsBold];
    TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Cells[ACol, ARow]);
  end;
end;

procedure TForm1.BtnRefreshGrblSettingsClick(Sender: TObject);
var
  my_str: String;
begin
  CancelProc:= false;
  if ftdi_isopen then
    with Form1.StringgridGrblSettings do begin
      grbl_sendlist.clear;
      WaitTimerFinishedResync;
      if not grbl_resync then
        showmessage('GRBL Resync failed on Retreive Settings!');
      Rowcount:= 2;
      grbl_sendStr(#24, true, false);   // Reset CTRL-X
      my_str:= grbl_receiveStr(500, true);
      my_str:= grbl_receiveStr(100, true);
      Rows[0].text:= my_str;

      grbl_sendStr('$$' + #13, false, false);
      while not CancelProc do begin
        my_str:= grbl_receiveStr(100, true);
        if my_str='ok' then
          break;
        Cells[0,RowCount-1]:= my_str;
        Cells[1,RowCount-1]:= setting_val_extr(my_str);
        Rowcount:= RowCount+1;
      end;

      if Cells[0,Rowcount-1] = '' then
        Rowcount:= RowCount-1;
      Cells[1,0]:= 'Value';
      FixedCols:= 1;
      FixedRows:= 1;
      WaitTimerFinishedResync;
      GetStatusEnabled:= true;
    end;
end;

procedure TForm1.BtnSendGrblSettingsClick(Sender: TObject);
var i : Integer;
  my_str: String;

begin
  CancelProc:= false;
  if ftdi_isopen then
    with Form1.StringgridGrblSettings do begin
      if RowCount < 3 then
        exit;
      grbl_sendlist.clear;
      WaitTimerFinishedResync;
      if not grbl_resync then
        showmessage('GRBL Resync failed on Send Settings!')
      else for i:= 1 to Rowcount-1 do begin
        if CancelProc then
          break;
        if Cells[0,i] = '' then
          continue;
        my_str:= Cells[1,i];
        if my_str <> setting_val_extr(Cells[0,i]) then begin
          grbl_sendStr('$'+IntToStr(i-1)+'='+my_str+#13, false, true);
        end;
      end;
    BtnRefreshGrblSettingsClick(Sender);
    WaitTimerFinishedResync;
    GetStatusEnabled:= true;
  end;
end;

// #############################################################################
// ############################ R U N  TAB BUTTONS #############################
// #############################################################################

procedure CancelExitProc;
var
  my_response: String;
begin
  Form1.Memo1.lines.add('');
  if ftdi_isopen then begin
    WaitTimerFinished; // bitte nicht unterbrechen
    GetStatusEnabled:= false;
    grbl_sendlist.clear; // alles abgearbeitet
    CancelWait:= false;
    my_response:= grbl_sendStr('M5' + #13, false, true); // Spindle Off sofort senden
    Form1.Memo1.lines.add('M5' + ' // ' + my_response);
  end else
    Form1.Memo1.lines.add('M5 // #Device not open');
  MachineRunning:= false;
end;

procedure EmergencyExitProc;
var
  my_response: String;
begin
  Form1.Memo1.lines.add('');
  if ftdi_isopen then begin
    GetStatusEnabled:= false;
    grbl_sendlist.clear;  // alles l�schen
    my_response:= grbl_sendStr(#24, false, true); // Ctrl-X Reset sofort senden
    CancelWait:= false;
    grbl_receiveStr(100, true);
    Form1.Memo1.lines.add('// CTRL-X RESET: ' + my_response);
    grbl_receiveStr(100, true);
    Form1.Memo1.lines.add(' // ' + my_response);
    showmessage('EMERGENCY STOP. Steps missed - please run'
      + #13 + 'Home Cycle to release ALARM LOCK.');
    EnableNotHomedButtons;
  end else
    Form1.Memo1.lines.add('// CTRL-X RESET: #Device not open');
  HomingPerformed:= false;
  MachineRunning:= false;
end;

procedure SendList(wait_for_idle: Boolean);
// Steht etwas in der Sendeliste? Dann abschicken und auf Antwort warten
var
  i, my_count: Integer;
  my_str, my_response: String;
  my_finished: Boolean;
begin
  MachineRunning:= true;
  if ftdi_isopen then begin
    if EmergencyStop then
      EmergencyExitProc;
    my_count:= grbl_sendlist.count;
    if my_count > 0 then begin
      GetStatusEnabled:= false;
      WaitTimerFinished; // bitte nicht unterbrechen
      LEDbusy.Checked:= true;
      for i:= 0 to my_count-1 do begin
        if StatusTimerFlag and (not CancelProc) then begin
          grbl_sendStr('?', false, false);     // selbst Status anfordern
          my_str:= grbl_receiveStr(100, false);
          DecodeResponse(my_str);
          Application.ProcessMessages;
          StatusTimerFlag:= false;
        end;
        if EmergencyStop then begin
          EmergencyExitProc;
          break;
        end;
        if CancelProc then begin
          CancelExitProc;
          break;
        end;
        my_str:= grbl_sendlist.Strings[i];
        if length(my_str) > 1 then
          if my_str[1] <> '/' then begin
            // Befehl ist kein Kommentar, also abschicken
            my_response:= grbl_sendStr(my_str + #13, true, true);
            Form1.Memo1.lines.add(my_str + ' // ' + my_response);
          end;
      end;
      if wait_for_idle and (not CancelProc) then
      // ggf. auf Idle-Zustand warten bis Maschine in Ruhe
        my_finished:= false;
        repeat
          if StatusTimerFlag then begin  // kommt alle 100 ms
            grbl_sendStr('?', false, false);     // Status anfordern
            my_str:= grbl_receiveStr(80, false);
            my_finished:= not AnsiContainsStr(my_str,'Run');
            if not my_finished then
              DecodeResponse(my_str);
            StatusTimerFlag:= false;
          end;
          Application.ProcessMessages;
          if EmergencyStop then
            EmergencyExitProc;
          if CancelProc then
            CancelExitProc;
        until my_finished or CancelProc;
    end;
  end else begin
    my_count:= grbl_sendlist.count;
    if my_count > 0 then begin
      LEDbusy.Checked:= true;
      for i:= 0 to my_count-1 do begin
        if EmergencyStop then begin
          EmergencyExitProc;
          break;
        end;
        if CancelProc then begin
          CancelExitProc;
          break;
        end;
        my_str:= grbl_sendlist.Strings[i];
        Form1.Memo1.lines.add(my_str + ' // #Device not open');
        mdelay(25);
      end;
    end;
  end;
  grbl_sendlist.clear; // alles abgearbeitet
  GetStatusEnabled:= true;
  MachineRunning:= false;
end;

procedure SendlistWaitIdle;
// wie SendList, aber mit Resync und warten auf Idle
begin
  CancelProc:= false;
  EmergencyStop:= false;
  GetStatusEnabled:= false;
  WaitTimerFinished; // bitte nicht unterbrechen
  if grbl_resync then begin
    SendList(true);  // wait for Idle TRUE
  end else begin
    Form1.Memo1.lines.add('');
    Form1.Memo1.lines.add('// GRBL RESYNC FAILED');
    showmessage('GRBL Resync/Response Test failed on Execute!'+ #13
      + 'Close and reconnect device if problem persists.');
    grbl_sendlist.clear; // alles abgearbeitet
    MachineRunning:= false;
  end;
  CancelProc:= false;
  GetStatusEnabled:= true;
end;

procedure TForm1.ResetGRBLClick(Sender: TObject);
var
  my_response: String;
begin
  CancelProc:= true;
  CancelWait:= true;
  EmergencyStop:= true;
  Form1.Memo1.lines.add('');
  Form1.Memo1.lines.add('// EMERGENCY STOP');
  if not MachineRunning then begin
    grbl_sendlist.clear; // alles l�schen
    SendlistWaitIdle;     // E-Stop ausf�hren
    EmergencyStop:= false;
  end;
end;

procedure TForm1.BtnStopClick(Sender: TObject);
begin
  Form1.Memo1.lines.add('');
  Form1.Memo1.lines.add('// CANCEL PROCESS');
  CancelProc:= true;
  CancelWait:= true;
  EmergencyStop:= false;
end;

procedure TForm1.BtnZeroXClick(Sender: TObject);
begin
  Form1.Memo1.lines.add('');
  Form1.Memo1.lines.add('// SET X ZERO');
  grbl_addStr('G92 X0');
  SendlistWaitIdle;
end;

procedure TForm1.BtnZeroYClick(Sender: TObject);
begin
  Form1.Memo1.lines.add('');
  Form1.Memo1.lines.add('// SET Y ZERO');
  grbl_addStr('G92 Y0');
  SendlistWaitIdle;
end;

procedure TForm1.BtnZeroZClick(Sender: TObject);
begin
  Form1.Memo1.lines.add('');
  Form1.Memo1.lines.add('// SET Z ZERO');
  grbl_addStr('G92 Z'+FloatToStrDot(job.z_gauge));
  SendlistWaitIdle;
end;

procedure TForm1.BtnHomeCycleClick(Sender: TObject);
begin
  DisableButtons;
  Form1.Memo1.lines.add('');
  Form1.Memo1.lines.add('// HOME CYCLE');
  grbl_addStr('$h');
  grbl_offsXY(0,0);
  grbl_offsZ(0);
  grbl_addStr('G92 Z'+FloatToStrDot(job.z_gauge));
  SendlistWaitIdle;
  HomingPerformed:= true;
  EnableRunButtons;
end;


procedure TForm1.BtnMoveWorkZeroClick(Sender: TObject);
begin
  Form1.Memo1.lines.add('');
  Form1.Memo1.lines.add('// MOVE TOOL TO PART ZERO');
  grbl_addStr('M5');
  grbl_moveZ(0, true);  // move Z up
  grbl_moveXY(0,0, false);
  grbl_moveZ(job.z_penlift, false);
  SendlistWaitIdle;
end;

procedure TForm1.BtnMoveParkClick(Sender: TObject);
begin
  Form1.Memo1.lines.add('');
  Form1.Memo1.lines.add('// MOVE TO PARK POSITION');
  grbl_addStr('M5');
  grbl_moveZ(0, true);  // move Z up
  grbl_moveXY(job.park_x, job.park_y, true);
  grbl_moveZ(job.park_z, true);
  SendlistWaitIdle;
end;

procedure TForm1.BtnMoveToolChangeClick(Sender: TObject);
begin
  Form1.Memo1.lines.add('');
  Form1.Memo1.lines.add('// MOVE TO TOOL CHANGE POSITION');
  grbl_addStr('M5');
  grbl_moveZ(0, true);  // move Z up
  grbl_moveXY(job.toolchange_x, job.toolchange_y, true);
  grbl_moveZ(job.toolchange_z, true);
  SendlistWaitIdle;
end;


procedure TForm1.BtnRunClick(Sender: TObject);
// Pfade an GRBL senden
var i, my_len, p, last_pen, my_old_atc_tool, my_new_atc_tool, my_btn: Integer;
  my_entry: Tfinal;
  my_atc_x, my_atc_y: Double;
  my_str, my_list: String;
  my_has_atc: Boolean;

begin
  Memo1.lines.Clear;
  Memo1.lines.add('// RUN STARTED');
  my_len:= length(final_array);
  if my_len < 1 then
    exit;
  last_pen:= -1;
  Form1.Memo1.lines.add('');
  grbl_moveZ(0, true);
  SendlistWaitIdle;
  my_list:= '';
  my_str:= ', Mill';
  my_has_atc:= false;
  for i := 0 to StringGridPens.RowCount-1 do begin
    if i = 10 then
      my_str:= ', Drill';
    if job.pens[i].enable and (job.pens[i].atc <> 0) then begin
      my_list:= my_list + #13 + ('Pen/Tool #' + IntToStr(i)
        + my_str + ' Dia. '  + FloatToStr(job.pens[i].diameter)
        + 'mm at ATC #' + IntToStr(job.pens[i].atc));
      my_has_atc:= true;
    end;
  end;
  if CheckUseATC.Checked and not my_has_atc then begin
    my_btn := MessageDlg('No ATC tools found. Will disable <Use ATC> Chekbox.' +
      #13 + 'Continue?', mtError, mbOKCancel, 0);
    if my_btn = mrCancel then
      exit;
    CheckUseATC.Checked:= false;
  end else if CheckUseATC.Checked then begin
    my_btn := MessageDlg('Make sure spindle is loaded with probe/dummy tool 0, ATC slot 0 is empty' +
      #13 + 'and ATC tray is loaded with these tools:' +
      #13 + my_list, mtError, mbOKCancel, 0);
    if my_btn = mrCancel then
      exit;
  end else begin
    Memo1.lines.add('// SPINDLE ON');
    grbl_addStr('M3');
    Sendlist(true);
    Memo1.lines.add('// SPINDLE ACCEL WAIT '+ IntToStr(job.spindle_wait) + ' SEC');
    if ftdi_isopen then
      mdelay(job.spindle_wait * 1000);  // Spindel-Hochlaufzeit
  end;

  for i:= 0 to my_len-1 do begin
    if CancelProc then
      break;
    my_entry:= final_array[i];
    if not my_entry.enable then
      continue;
    if length(my_entry.millings) = 0 then
      continue;
    if CheckUseATC.Checked and (my_entry.pen <> last_pen) then begin
      Memo1.lines.add('');
      grbl_moveZ(0, true); // move Z up
      if last_pen = -1 then begin
        last_pen:= 0;
        Memo1.lines.add('// SPINDLE STOPPED');
      end else begin                    // bei erstem Werkzeug nicht warten
        grbl_addStr('M5');
        SendlistWaitIdle;
        Memo1.lines.add('// SPINDLE BRAKE WAIT '+ IntToStr(job.spindle_wait) + ' SEC');
        if ftdi_isopen then
          mdelay(job.spindle_wait * 1000);  // wie Spindel-Hochlaufzeit
      end;

      my_old_atc_tool:= job.pens[last_pen].atc;
      my_new_atc_tool:= job.pens[my_entry.pen].atc;

// Zuletzt benutztes Werkzeug (oder Probe/Dummy nach Start) wieder ablegen
      Form1.Memo1.lines.add('');
      my_atc_x:= job.atc_zero_x + (my_old_atc_tool * job.atc_delta_x);
      my_atc_y:= job.atc_zero_y + (my_old_atc_tool * job.atc_delta_y);
      Memo1.lines.add('// UNLOAD TOOL #'+ IntToStr(last_pen));
      Memo1.lines.add('// ATC POSITION '+ IntToStr(my_old_atc_tool)
        + ' AT ' + FloatToStr(my_atc_x) + ',' + FloatToStr(my_atc_y));
      grbl_moveZ(0, true);  // move Z up
      grbl_moveXY(my_atc_x, my_atc_y, true);
      SendlistWaitIdle;
      grbl_moveZ(job.atc_pickup_z + 10, true);  // move Z down near pickup-H�he
      grbl_addStr('M8');                // Ausblasen
      SendlistWaitIdle;
      mdelay(500);
      grbl_moveZ(0, true);     // move Z up
      SendlistWaitIdle;
      mdelay(500);

// Neues Werkzeug aufnehmen
      Form1.Memo1.lines.add('');
      my_atc_x:= job.atc_zero_x + (my_new_atc_tool * job.atc_delta_x);
      my_atc_y:= job.atc_zero_y + (my_new_atc_tool * job.atc_delta_y);
      Memo1.lines.add('// LOAD TOOL #'+ IntToStr(my_entry.pen));
      Memo1.lines.add('// ATC POSITION '+ IntToStr(my_new_atc_tool)
        + ' AT ' + FloatToStr(my_atc_x) + ',' + FloatToStr(my_atc_y));
      grbl_moveZ(0, true);  // move Z up
      grbl_moveXY(my_atc_x, my_atc_y, true);
      Sendlist(true);
      grbl_moveZ(job.atc_pickup_z + 20, true);  // move Z down
      Sendlist(true);
      grbl_moveSlowZ(job.atc_pickup_z, true);  // move Z down
      grbl_addStr('M9');                // pick up tool
      SendlistWaitIdle;
      mdelay(500);
      grbl_moveZ(0, true);  // move Z up
      SendlistWaitIdle;

      Form1.Memo1.lines.add('');
      grbl_addStr('M3');
      SendlistWaitIdle;
      Memo1.lines.add('// SPINDLE ACCEL WAIT '+ IntToStr(job.spindle_wait) + ' SEC');
      if ftdi_isopen then
        mdelay(job.spindle_wait * 1000);  // Spindel-Hochlaufzeit

    end else if CheckPenChangePause.Checked and (my_entry.pen <> last_pen) then begin
      Memo1.lines.add('');
      // move to tool change position
      // TO DO: Neuen Z-Wert erm�glichen
      Memo1.lines.add('// SPINDLE BRAKE WAIT '+ IntToStr(job.spindle_wait) + ' SEC');
      grbl_addStr('M5');
      SendlistWaitIdle;
      if ftdi_isopen then
        mdelay(job.spindle_wait * 1000);  // Spindel-Hochlaufzeit
      grbl_moveZ(0, true);
      grbl_moveXY(job.toolchange_x, job.toolchange_y, true);
      grbl_moveZ(job.toolchange_z, true);
      SendList(true);
      Memo1.lines.add('// PEN/TOOL CHANGE');
      ShowMessage('Milling paused - Change pen/tool to '
        + #13+ FloatToStr(job.pens[my_entry.pen].diameter)+' mm when path finished'
        + #13+ 'and click OK when done. Will keep Z Zero Value.');
      Form1.Memo1.lines.add('');
      Memo1.lines.add('// SPINDLE ACCEL WAIT '+ IntToStr(job.spindle_wait) + ' SEC');
      grbl_addStr('M3');
      SendlistWaitIdle;
      if ftdi_isopen then
        mdelay(job.spindle_wait * 1000);  // Spindel-Hochlaufzeit
      grbl_moveZ(0, true);
      SendlistWaitIdle;  // warte auf Idle wenn beendet
    end;

    last_pen:= my_entry.pen;

    // kompletten Milling- oder Drill-Pfad abfahren
    for p:= 0  to length(my_entry.millings)-1 do begin
      if CancelProc then
        break;
      Memo1.lines.add('');
      Memo1.lines.add('// RUN BLOCK '+ IntToStr(i) + ' PATH '+ IntToStr(p));
      if my_entry.shape = drillhole then
        grbl_drillpath(my_entry.millings[p], my_entry.pen, job.pens[my_entry.pen].offset)
      else
        grbl_millpath(my_entry.millings[p], my_entry.pen, job.pens[my_entry.pen].offset, my_entry.closed);
    end;
    SendList(false);
  end; // Ende der Block-Schleife

  // grbl_millpath und grbl_drillpath enden mit job.z_penup, deshalb:
  grbl_moveZ(0, true); // move Z up
  SendlistWaitIdle;

  // Immer abschlie�ende Aktion wenn ATC enabled
  if CheckUseATC.Checked then begin
    Memo1.lines.add('');
    Memo1.lines.add('// SPINDLE BRAKE WAIT '+ IntToStr(job.spindle_wait) + ' SEC');
    if ftdi_isopen then
      mdelay(job.spindle_wait * 1000);  // wie Spindel-Hochlaufzeit

    // Zuletzt benutztes Werkzeug wieder ablegen
    my_old_atc_tool:= job.pens[last_pen].atc;
    Form1.Memo1.lines.add('');
    my_atc_x:= job.atc_zero_x + (my_old_atc_tool * job.atc_delta_x);
    my_atc_y:= job.atc_zero_y + (my_old_atc_tool * job.atc_delta_y);
    Memo1.lines.add('// UNLOAD TOOL #'+ IntToStr(last_pen));
    Memo1.lines.add('// ATC POSITION '+ IntToStr(my_old_atc_tool)
      + ' AT ' + FloatToStr(my_atc_x) + ',' + FloatToStr(my_atc_y));
    grbl_moveZ(0, true);  // move Z up
    grbl_moveXY(my_atc_x, my_atc_y, true);
    SendlistWaitIdle;
    grbl_moveZ(job.atc_pickup_z + 10, true);  // move Z down
    grbl_addStr('M8');                // Ausblasen
    SendlistWaitIdle;
    mdelay(500);
    grbl_moveZ(0, true);  // move Z up
    SendlistWaitIdle;
    mdelay(500);

    // Probe/Dummy-Werkzeug aufnehmen
    Form1.Memo1.lines.add('');
    my_atc_x:= job.atc_zero_x;
    my_atc_y:= job.atc_zero_y;
    Memo1.lines.add('// LOAD PROBE TOOL #0');
    Memo1.lines.add('// ATC POSITION 0 AT ' + FloatToStr(my_atc_x) + ',' + FloatToStr(my_atc_y));
    grbl_moveZ(0, true);  // move Z up
    grbl_moveXY(my_atc_x, my_atc_y, true);
    SendlistWaitIdle;
    grbl_moveZ(job.atc_pickup_z + 20, true);  // move Z down
    SendlistWaitIdle;
    grbl_moveSlowZ(job.atc_pickup_z, true);  // move Z down
    grbl_addStr('M9');                // pick up tool
    SendlistWaitIdle;
    mdelay(500);
    grbl_moveZ(0, true);  // move Z up
    SendlistWaitIdle;
  end;

  if not CancelProc then begin
    if CheckEndPark.Checked and HomingPerformed then
      BtnMoveParkClick(Sender)
    else begin
      Memo1.lines.add('');
      Memo1.lines.add('// SPINDLE OFF');
      grbl_addStr('M5');
      grbl_moveXY(0,0, false);
      SendList(true);
    end;
  end;
  Memo1.lines.add('');
  Memo1.lines.add('// FINISHED');
end;


procedure TForm1.PlayGcodeBtnClick(Sender: TObject);
// G-Code-Datei abspielen
var
  my_ReadFile: TextFile;
  my_line: String;
  my_count: integer;

begin
  OpenFileDialog.FilterIndex:= 2;
  if not OpenFileDialog.Execute then
    exit;
  my_line:='';
  FileMode := fmOpenRead;
  AssignFile(my_ReadFile, OpenFileDialog.FileName);
  CurrentPen:= 10;
  PendingAction:= lift;

  Reset(my_ReadFile);
  my_count:= 0;
  while not Eof(my_ReadFile) do begin
    if CancelProc then
      break;
    Readln(my_ReadFile,my_line);
    grbl_addStr(my_line);
    inc(my_count);
    if my_count > 100 then begin
      SendList(false);
      my_count:= 0;
    end;
  end;
  CloseFile(my_ReadFile);
  if not CancelProc then
    if CheckEndPark.Checked and HomingPerformed then
      BtnMoveParkClick(Sender)
    else begin
      Memo1.lines.add('');
      Memo1.lines.add('// SPINDLE OFF');
      grbl_addStr('M5');
      grbl_moveXY(0,0, false);
      SendList(true);
    end;
  Memo1.lines.add('');
  Memo1.lines.add('// FINISHED');
  CancelProc:= false;
end;

// #############################################################################

procedure TForm1.ShowDrawing1Click(Sender: TObject);
begin
  WindowMenu1.Items[0].Checked:= not WindowMenu1.Items[0].Checked;
  if WindowMenu1.Items[0].Checked then begin
    Form2.Show;
    NeedsRedraw:= true;
  end else
    Form2.Hide;
end;

procedure TForm1.ShowSpindleCam1Click(Sender: TObject);
begin
  WindowMenu1.Items[1].Checked:= not WindowMenu1.Items[1].Checked;
  if WindowMenu1.Items[1].Checked then
    Form3.Show
  else
    Form3.Hide;
end;

procedure TForm1.Show3DPreview1Click(Sender: TObject);
begin
  WindowMenu1.Items[2].Checked:= not WindowMenu1.Items[2].Checked;
  if WindowMenu1.Items[2].Checked then begin
    Form4.Show;
    NeedsRefresh3D:= true;
  end else
    Form4.Hide;
end;

procedure TForm1.HelpAbout1Execute(Sender: TObject);
begin
  AboutBox.ProgName.Caption:= c_ProgNameStr;
  AboutBox.VersionInfo.Caption:= c_VerStr;
  Aboutbox.ShowModal;
end;




end.

