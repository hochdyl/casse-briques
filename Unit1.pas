unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Button1: TButton;
    Button2: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
 //   procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}


//==============================================================================
//                               Menu Navigation
//==============================================================================
//Variables/Param�tres

//Procedures
// -- BILLE
// -- BRIQUE
// -- RAQUETTE
// -- EFFACER
// -- REBOND
// -- FIN DE PARTIE

//Programme Principal
//==============================================================================




//=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!
//=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!
//=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!
//=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!
//=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!
//=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!



//==============================================================================
//                             Variables/Param�tres
//==============================================================================
Type TBille = RECORD
     px,py,vx,vy,Rayon: Integer;
     actif: Boolean;
End;
Type TBriques = RECORD
     x1,y1,x2,y2: Integer;
     actif: Boolean;
     CptHits : Integer ;
End;

// =========================PARAMETRES ELEMENTS=================================
Const NbrBilles = 3;
      NbrBriques = 15;
//==============================================================================

Var TabBilles: Array[1..NbrBilles] Of TBille;
Var TabBriques: Array[1..NbrBriques] Of TBriques;

Type TRaquette = RECORD
     px,py , Hauteur , Largeur : Integer ;
     End;
Var Raquette1 : TRaquette ;

Var DroiteOn: Boolean = False;
    GaucheOn: Boolean = False;






//=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!
//=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!
//=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!
//=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!
//=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!
//=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!






//==============================================================================
//                                  Procedures
//==============================================================================






//==================================BILLE=======================================

Procedure InitBille( Var B :TBille);
Begin
     B.px:= Form1.ClientWidth div 2;    //Position x de la bille
     B.py:= Form1.ClientHeight - 200;   //Position y de la bille
     B.vx:= 5+Random(15);               //Vitesse  x de la bille
     B.vy:= -5+Random(15);              //Vitesse  y de la bille
     B.Rayon:= 5+Random(20);            //Taille     de la bille
     B.actif := True ;                  //Si l'�l�ment existe
End;
//==============================================================================

Procedure GererBille( Var B:TBille);
Begin
  If B.actif                                         //Tant que la bille existe
  Then Begin

     B.px:= B.px+B.vx;                               //Mise � jour position
     B.py:= B.py+B.vy;

     if B.px <= 0 then begin                         //Rebond bord gauche
        B.vx := -B.vx
     End
     else if B.py <= 0 then begin                    //Rebond bord haut
        B.vy := -B.vy
     End
     else if B.px >= Form1.Clientwidth then begin    //Rebond bord droit
        B.vx := -B.vx
     End
     else if B.py >= Form1.Clientheight then begin   //Rebond bord bas
        B.actif := false ;
     End;
  End;
End;
//==============================================================================

Procedure TracerBille( Var B:TBille);                //Graphismes de la bille
Begin
  Form1.Canvas.Pen.color := clBlack;
  Form1.Canvas.Brush.color := clGray;
  Form1.Canvas.ellipse(B.px-B.rayon,B.py-B.rayon,B.px+B.rayon,B.py+B.rayon);
End;
//==============================================================================















//================================BRIQUE========================================

Procedure InitBriques( Var Br :TBriques ; indice : Integer);
Var nX, nY : Integer ;
Begin
     indice := indice -1 ;                  //Affichage en grille
     nX := indice mod 5 ;                   //Affichage en grille
     nY := indice div 5 ;                   //Affichage en grille
     Br.x1 := 50 + nX *150;                 //Position x de la brique + grille
     Br.y1 := 50 + nY *100;                 //Position y de la brique + grille
     Br.x2 := Br.x1 + 100 ;                 //Largeur    de la brique
     Br.y2 := Br.y1 + 50 ;                  //Hauteur    de la brique
     Br.CptHits := 3 ;                      //Durabilit� de la brique
     Br.actif := True;                      //Si l'�l�ment existe
End;
//==============================================================================

Procedure TracerBrique( Var Br : TBriques);
Begin
  If Br.actif = True                        //Tant que la brique existe
  Then Begin
     Form1.Canvas.Pen.color := clBlack;     //Graphismes de la brique

  if      Br.CptHits = 3 Then Form1.Canvas.Brush.color := clGreen   //Vert
  else if Br.CptHits = 2 Then Form1.Canvas.Brush.color := clYellow  //Jaune
  else if Br.CptHits = 1 Then Form1.Canvas.Brush.color := clRed;    //Rouge

  Form1.Canvas.Rectangle(Br.x1,Br.y1,Br.x2,Br.y2);

  End
End;
//==============================================================================













//================================RAQUETTE======================================

Procedure InitRaquette( Var R :TRaquette);
Begin
     R.px:= Form1.ClientWidth div 2;                //Position x de la raquette
     R.py:= Form1.ClientHeight - 50 ;               //Position y de la raquette
     R.Hauteur:= 25;                                //Hauteur    de la raquette
     R.Largeur:= 100;                               //Largeur    de la raquette
End;
//==============================================================================

Procedure TracerRaquette( Var R:TRaquette);
Var x1,y1 , x2,y2 : Integer ;
Begin
  x1 := R.px - R.Largeur div 2 ;                    //Position x de la raquette
  y1 := R.py - R.Hauteur div 2 ;                    //Position y de la raquette
  x2 := x1   + R.Largeur       ;                    //Largeur    de la raquette
  y2 := y1   + R.Hauteur       ;                    //Hauteur    de la raquette
  Form1.Canvas.Pen.color := clBlack ;
  Form1.Canvas.Brush.color := clGray ;              //Graphismes de la raquette
  Form1.Canvas.Rectangle (x1,y1 , x2,y2 );
End;
//==============================================================================














//=================================EFFACER======================================

procedure Effacer();    // CORRIGE BUG AFFICHAGE BILLE + COULEUR FENETRE
Begin
     Form1.Canvas.Pen.color := clWhite;
     Form1.Canvas.Brush.color := clWhite;
     Form1.Canvas.rectangle(0,0,Form1.Clientwidth,Form1.Clientheight);
End;
//==============================================================================












//==================================REBOND======================================

Procedure GererRebond( Var B:TBille ; Br:TBriques);
var save : integer ;
Begin
     save:= B.px-B.vx;                            //Verification position -1

     if (Br.x1 <= B.px ) AND (Br.x1 >= save) then begin
        B.vx := -B.vx                             //Rebond brique gauche
     End

     else if (Br.x2 >= B.px ) AND (Br.x2 <= save) then begin
        B.vx := -B.vx                             //Rebond brique droit
     End

     else if B.py <= Br.y2 then begin
          B.vy := -B.vy                           //Rebond brique bas
     End

     else if B.py >= Br.y1 then begin
          B.vy := -B.vy                           //Rebond brique haut
     End;
End;
//==============================================================================

Function BilleDansBrique( B : TBille ; Var Br: TBriques): Boolean;

//Renvoyer VRAI si le point <x1,y1> est dans le rectangle de la brique

Begin
  Result := False ;                               //Initalement faux

  if Br.actif                                     //Si l'�l�ment existe
  Then Begin
    If  (Br.x1 <= B.px) and (B.px <= Br.x2)
    And (Br.y1 <= B.py) and (B.py <= BR.y2)
    Then Begin
      Result := True ;                            //Alors vrai
      Br.CptHits := Br.CptHits -1 ;               //PV -1
      If Br.CptHits = 0                           //Si PV = 0
      Then Br.actif := False ;                    //Alors brique supprim�e
    End;
  End;
End;
//==============================================================================


Function BilleDansRaquette( B : TBille ; Var R : TRaquette): Boolean;

//Renvoyer VRAI si le point <x1,y1> est dans le rectangle de la raquette

Var x1,y1 , x2,y2 : Integer ;
Begin
  x1 := R.px - R.Largeur div 2 ;
  y1 := R.py - R.Hauteur div 2 ;
  x2 := x1   + R.Largeur       ;
  y2 := y1   + R.Hauteur       ;
  Form1.Canvas.Pen.color := clBlack ;
  Form1.Canvas.Brush.color := clRed ;
  Form1.Canvas.Rectangle (x1,y1 , x2,y2 );

  If (x1<= B.px) And (B.px <= x2)
  And(y1<= B.py) And (B.py <= y2)
  Then Result := True
  Else Result := False ;
End;
//==============================================================================











//===============================FIN DE PARTIE==================================

Function Gagner () : Boolean ;
Var i : Integer ;
Begin
  Result := True ;                           //La partie est gagner

  For i := 1 To NbrBriques Do
    If TabBriques[i].actif                   //Tant que des briques existent
    Then Result := False;                    //La partie n'est pas gagner
End;
//==============================================================================

Function Perdu () : Boolean ;
Var i : Integer ;
Begin
  Result := True ;                           //La partie est perdue

  For i := 1 To NbrBilles Do
    If TabBilles[i].actif                    //Tant que des billes existent
    Then Result := False;                    //La partie n'est pas perdue
End;
//==============================================================================














//=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!
//=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!
//=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!
//=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!
//=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!
//=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!







//==============================================================================
//                           Programme Principal
//==============================================================================






//==============================INITIALISATION==================================

procedure TForm1.FormCreate(Sender: TObject);
Var i : Integer;
begin
     for i :=1 to length(TabBilles) Do               //Genere les billes
       InitBille(TabBilles[i]);
     for i :=1 to length(TabBriques) Do              //Genere les briques
       InitBriques(TabBriques[i], i);

  InitRaquette ( Raquette1 );                        //Genere la raquette
end;
//==============================================================================











//                    TRAVAIL SUR LES PHASE (NON REUSSI)
//==============================================================================
(*
procedure TracerTout(B : TBille ; Br : TBriques) ;
Var i : Integer ;
Begin
  TracerRaquette( Raquette1 );
  For i := 1 To NbrBriques Do TracerBrique (TabBriques[i]);
  For i := 1 To NbrBilles Do TracerBille (TabBriques[i]);
End;
*)
//==============================================================================












//=================================TIMER========================================

procedure TForm1.Timer1Timer(Sender: TObject);
Var i , j : Integer;
begin

  Button1.Visible := False ;                            //Bouton Rejouer
  Button2.Visible := False ;                            //Bouton Quitter






//                    TRAVAIL SUR LES PHASE (NON REUSSI)
(*
Begin
  If Phase = 1
  Then Begin
  TracerTout() ; Tracer les briques, bille raquette //Tracer les briques/billes/raquette
  TracerMessage() ; // Afficher le texte "appuer sur Entr�e"
    Raquette immobiles

  If Phase = 2
  Then
  TracerTout() ;
                  // rAQUETTE BILLE MOBILE
    JeuxNormal(); // JEU NORMAL

  If Phase = 3
  Then
  TracerTout() ;
  TracerMessage() ; // TEXTE GAGNER PERDU
                    // RAQUETTE BILLES IMMOBILE
*)



//============================VITESSE RAQUETTE==================================

  If DroiteOn Then Begin                                //Si fl�che droite
  If Raquette1.px+50 >= Form1.ClientWidth               //Si d�passe la fen�tre
     Then Raquette1.px := Raquette1.px                  //Alors immobile
     Else Raquette1.px := Raquette1.px + 20             //Sinon d�place � droite
  End;

  If GaucheOn Then Begin                                //Si fl�che gauche
  if Raquette1.px-50<= 0                                //Si d�passe la fen�tre
     then Raquette1.px := Raquette1.px                  //Alors immobile
     Else Raquette1.px := Raquette1.px - 20;            //Sinon d�place � gauche
  End;
//==============================================================================


     Effacer(); // CORRIGE BUG AFFICHAGE BILLE


//==============================FIN DE PARTIE===================================

     If Gagner() Then Begin                            //Si victoire
        Button1.Visible := True ;
        Button2.Visible := True ;                      //Affichage victoire
        Form1.Canvas.Brush.Style := bsClear;
        Form1.Canvas.Font.Color  := clGreen;
        Form1.Canvas.Font.Size  := 100    ;
        Form1.Canvas.Font.Name  := 'Arial';
        Form1.Canvas.TextOut (150, 300, 'VICTOIRE');
        Timer1.Enabled := False;
     End;

     If Perdu () Then Begin                            //Si d�faite
        Button1.Visible := True ;
        Button2.Visible := True ;                      //Affichage d�faite
        Form1.Canvas.Brush.Style := bsClear;
        Form1.Canvas.Font.Color  := clRed;
        Form1.Canvas.Font.Size  := 100    ;
        Form1.Canvas.Font.Name  := 'Arial';
        Form1.Canvas.TextOut (150, 300, 'DEFAITE');
        Timer1.Enabled := False;
     End;
//==============================================================================









//============================AFFICHAGE ELEMENTS================================
     For i :=1 to NbrBriques Do                          //Afficher briques
       TracerBrique(TabBriques[i]);

     for i :=1 to NbrBilles Do                           //Afficher billes
     Begin
       TracerBille(TabBilles[i]);
       GererBille(TabBilles[i]);

       if BilleDansRaquette (TabBilles[i], Raquette1)   //Si bille dans raquette
       Then TabBilles[i].vy := -TabBilles[i].vy ;       //Alors rebond

       For j := 1 To NbrBriques Do
       Begin
         If BilleDansBrique(TabBilles[i],TabBriques[j]) //Si bille dans brique
         Then GererRebond(TabBilles[i],TabBriques[j])   //Alors rebond
       End;

       TracerRaquette ( Raquette1 ) ;                   //Afficher raquette
     End;

End;
//==============================================================================











//=============================GESTION RAQUETTE=================================



(*
// SE DPLACER A LA SOURIS
procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  // Raquette1.px := x ;
  // Raquette1.py := Form1.ClientHeight - 50 ;
end;
*)




// SE DPLACER AUX FLECHES
procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Raquette1.py := Form1.ClientHeight - 50 ;
  If Key = VK_RIGHT Then DroiteOn := True ;
  If Key = VK_LEFT  Then GaucheOn := True ;
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RIGHT Then DroiteOn := False ;
  If Key = VK_LEFT Then GaucheOn := False ;
end;
//==============================================================================










//==========================BOUTONS FIN DE PARTIE===============================
procedure TForm1.Button1Click(Sender: TObject);    //Rejouer  ( VA AVEC LE TRAVAIL SUR LES PHASE (NON REUSSI) )
begin
     Timer1.Enabled := True;
end;

procedure TForm1.Button2Click(Sender: TObject);    //Quitter
begin
     Application.Terminate();
end;

end.
