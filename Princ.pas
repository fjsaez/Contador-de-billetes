unit Princ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, AdvSpin, JvExStdCtrls, JvEdit, JvValidateEdit,
  JvExControls, JvAnimatedImage, JvGIFCtrl, Vcl.Buttons, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors,
  Data.Bind.Components, Vcl.ExtCtrls;

type
  TFPrinc = class(TForm)
    GroupBox1: TGroupBox;
    SE200: TAdvSpinEdit;
    Label1: TLabel;
    SE10000: TAdvSpinEdit;
    Label2: TLabel;
    SE5000: TAdvSpinEdit;
    Label3: TLabel;
    Label4: TLabel;
    SE2000: TAdvSpinEdit;
    SE1000: TAdvSpinEdit;
    Label5: TLabel;
    SE500: TAdvSpinEdit;
    Label6: TLabel;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    VEMon: TJvValidateEdit;
    VEChq: TJvValidateEdit;
    Label8: TLabel;
    GroupBox3: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    VETotBsF: TJvValidateEdit;
    VETotBill: TJvValidateEdit;
    BSalir: TButton;
    BLimpiar: TButton;
    LAcerca: TLabel;
    GIFAnim: TJvGIFAnimator;
    VETot200: TJvValidateEdit;
    VETot10000: TJvValidateEdit;
    VETot5000: TJvValidateEdit;
    VETot2000: TJvValidateEdit;
    VETot1000: TJvValidateEdit;
    VETot500: TJvValidateEdit;
    VETot10: TJvValidateEdit;
    VETot20: TJvValidateEdit;
    VETot50: TJvValidateEdit;
    VETot100: TJvValidateEdit;
    SE10: TAdvSpinEdit;
    SE20: TAdvSpinEdit;
    SE50: TAdvSpinEdit;
    SE100: TAdvSpinEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    VETransf: TJvValidateEdit;
    Label15: TLabel;
    Panel1: TPanel;
    SB3: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SB0: TSpeedButton;
    SB7: TSpeedButton;
    SB8: TSpeedButton;
    SB9: TSpeedButton;
    SB4: TSpeedButton;
    SB5: TSpeedButton;
    SB6: TSpeedButton;
    SB2: TSpeedButton;
    SB1: TSpeedButton;
    CheckBox: TCheckBox;
    BindingsList1: TBindingsList;
    LinkControlToPropertyVisible: TLinkControlToProperty;
    procedure BSalirClick(Sender: TObject);
    procedure BLimpiarClick(Sender: TObject);
    procedure SE200Change(Sender: TObject);
    procedure LAcercaMouseEnter(Sender: TObject);
    procedure LAcercaMouseLeave(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SB1Click(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
    procedure SE200Enter(Sender: TObject);
  private
    { Private declarations }
    procedure CalcTotal;
    procedure Tecla(SECant: TAdvSpinEdit; Sender: TObject);
  public
    { Public declarations }
  end;

var
  FPrinc: TFPrinc;
  NomCompFoco: string;

implementation

{$R *.dfm}

procedure TFPrinc.CalcTotal;
begin
  //se calcula el total de cada denominación:
  VETot10000.Value:=SE10000.Value*10000;
  VETot5000.Value:=SE5000.Value*5000;
  VETot2000.Value:=SE2000.Value*2000;
  VETot1000.Value:=SE1000.Value*1000;
  VETot500.Value:=SE500.Value*500;
  VETot200.Value:=SE200.Value*200;
  VETot100.Value:=SE100.Value*100;
  VETot50.Value:=SE50.Value*50;
  VETot20.Value:=SE20.Value*20;
  VETot10.Value:=SE10.Value*10;
  //se calcula el total de billetes:
  VETotBill.Value:=SE10000.Value+SE5000.Value+SE2000.Value+SE1000.Value+
    SE500.Value+SE200.Value+SE100.Value+SE50.Value+SE20.Value+SE10.Value;
  //se calcula el total de bsf:
  VETotBsF.Value:=VETot10000.Value+VETot5000.Value+VETot2000.Value+
    VETot1000.Value+VETot500.Value+VETot200.Value+VETot100.Value+VETot50.Value+
    VETot20.Value+VETot10.Value+VEMon.Value+VEChq.Value+VETransf.Value;
end;

{Coloca el dígito pulsado desde el teclado virtual en el spinedit}
procedure TFPrinc.Tecla(SECant: TAdvSpinEdit; Sender: TObject);
var
  Numero: string;
begin
  if SECant.Focused then
  begin
    if TSpeedButton(Sender).Caption='<-' then
      Numero:=Copy(IntToStr(SECant.Value),1,Length(IntToStr(SECant.Value))-1)
    else Numero:=IntToStr(SECant.Value)+TSpeedButton(Sender).Caption;
    if Numero='' then Numero:='0';
    SECant.Value:=StrToInt(Numero);
  end;
end;

procedure TFPrinc.CheckBoxClick(Sender: TObject);
var
  Comp: TComponent;
begin
  Comp:=FindComponent(NomCompFoco);
  TAdvSpinEdit(Comp).SetFocus;
end;

procedure TFPrinc.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  begin
    SelectNext(ActiveControl,true,true);
    Key:=#0
  end
end;

procedure TFPrinc.FormShow(Sender: TObject);
begin
  FormatSettings.CurrencyString:='';
  VETotBsF.Alignment:=taCenter;
  BLimpiar.Click;
end;

procedure TFPrinc.LAcercaMouseEnter(Sender: TObject);
begin
  LAcerca.Font.Style:=[fsBold];
  LAcerca.Font.Color:=clRed;
  GIFAnim.Visible:=true;
  GIFAnim.Animate:=true;
end;

procedure TFPrinc.LAcercaMouseLeave(Sender: TObject);
begin
  LAcerca.Font.Style:=[];
  LAcerca.Font.Color:=clWindowText;
  GIFAnim.Visible:=false;
  GIFAnim.Animate:=false;
end;

procedure TFPrinc.SB1Click(Sender: TObject);
begin
  Tecla(SE10000,Sender);
  Tecla(SE5000,Sender);
  Tecla(SE2000,Sender);
  Tecla(SE1000,Sender);
  Tecla(SE500,Sender);
  Tecla(SE200,Sender);
  Tecla(SE100,Sender);
  Tecla(SE50,Sender);
  Tecla(SE20,Sender);
  Tecla(SE10,Sender);
end;

procedure TFPrinc.SE200Change(Sender: TObject);
begin
  CalcTotal;
end;

procedure TFPrinc.SE200Enter(Sender: TObject);
begin
  NomCompFoco:=TAdvSpinEdit(Sender).Name;
end;

procedure TFPrinc.BLimpiarClick(Sender: TObject);
begin              
  SE10000.Value:=0;
  SE5000.Value:=0;
  SE2000.Value:=0;
  SE1000.Value:=0;
  SE500.Value:=0;
  SE200.Value:=0;
  SE100.Value:=0;
  SE50.Value:=0;
  SE20.Value:=0;
  SE10.Value:=0;
  VEMon.Value:=0;
  VEChq.Value:=0;
  VETransf.Value:=0;
  CalcTotal;
  SE10000.SetFocus;
end;

procedure TFPrinc.BSalirClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.             //135
