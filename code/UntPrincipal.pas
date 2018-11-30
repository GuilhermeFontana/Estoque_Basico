unit UntPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.Mask;

type
  TFrmPrincipal = class(TForm)
    Inicio: TPageControl;
    TabSheet1: TTabSheet;
    PnlBtns: TPanel;
    BtnCad: TButton;
    BtnExc: TButton;
    BtnEdi: TButton;
    StGridPrincipal: TStringGrid;
    Panel2: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    Label2: TLabel;
    Preço: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    TrackBar1: TTrackBar;
    TrBarNP: TTrackBar;
    BBtnBus: TBitBtn;
    ComboBox1: TComboBox;
    LEdtNC: TLabeledEdit;
    LEdtNome: TLabeledEdit;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox1: TCheckBox;
    TrackBar2: TTrackBar;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    Label1: TLabel;
    ListBox1: TListBox;
    BtnAd: TButton;
    BtnDel: TButton;
    EdtAIt: TEdit;
    BtnIOk: TButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    BtnSC: TButton;
    ComboBox2: TComboBox;
    BtnACat: TButton;
    Label8: TLabel;
    Button1: TButton;
    BitBtn1: TBitBtn;
    Panel3: TPanel;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    Shape3: TShape;
    LabeledEdit6: TLabeledEdit;
    Label9: TLabel;
    Button2: TButton;
    Label10: TLabel;
    Label11: TLabel;
    procedure BtnSCClick(Sender: TObject);
    procedure BtnCadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnExcClick(Sender: TObject);
    procedure BtnEdiClick(Sender: TObject);
    procedure StGridPrincipalClick(Sender: TObject);
    procedure TabSheet2Exit(Sender: TObject);
    procedure BtnACatClick(Sender: TObject);
    procedure BtnAdClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure BtnIOkClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Label7MouseEnter(Sender: TObject);
    procedure Label7MouseLeave(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure BBtnBusClick(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TrBarNPChange(Sender: TObject);
    procedure Label10MouseEnter(Sender: TObject);
    procedure Label10MouseLeave(Sender: TObject);
    procedure Label10Click(Sender: TObject);

    procedure V_NumRegistro (NumReg, cont: Integer);
    procedure V_Nome (Nome: String);
    procedure V_NumItens (Posicao: Integer);
    procedure V_QtItens (Min, Max: Integer);
    procedure V_Categoria (Categoria: String);

    procedure Filtros (NumFiltros: Integer);
    procedure FiltrosPlus ();

    procedure Salvar_NovoItem ();
    procedure Editar_Item();
    procedure Label11MouseEnter(Sender: TObject);
    procedure Label11MouseLeave(Sender: TObject);
    procedure Label11Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;
  A, Aux, Cont, NF: Integer;
  Busc: string;
  Teste: Boolean;

  Mat,MatAux: array [0..4,0..1000000] of string;


implementation

{$R *.dfm}

procedure TFrmPrincipal.BBtnBusClick(Sender: TObject);
begin
  Filtros(NF);
end;

procedure TFrmPrincipal.BitBtn1Click(Sender: TObject);                          //inicio das configurações
begin
  LabeledEdit6.Text:= IntToStr(TrBarNP.Max);                                    //apresentação dos valores a serem alterados [n° de itens máximo]
  LabeledEdit5.Text:= IntToStr(TrackBar1.Max);                                  //apresentação dos valores a serem alterados [preço máximo]
  LabeledEdit4.Text:= IntToStr(TrackBar2.Min);                                  //apresentação dos valores a serem alterados [preço mínimo]

  Panel3.Visible:= True;                                                        //dasabilita restante do programa
  Panel1.Enabled:= False;
  StGridPrincipal.Enabled:= False;
  LEdtNC.Enabled:= False;
  LEdtNome.Enabled:= False;
  TrBarNP.Enabled:= False;
  TrackBar1.Enabled:= False;
  TrackBar2.Enabled:= False;
  ComboBox1.Enabled:= False;
  BBtnBus.Enabled:= False;
  Label7.Enabled:= False;
  CheckBox1.Enabled:= False;
  CheckBox2.Enabled:= False;
  CheckBox3.Enabled:= False;
  CheckBox4.Enabled:= False;
  CheckBox5.Enabled:= False;
  BitBtn1.Enabled:= False;
  TabSheet2.Enabled:= False;
  BtnCad.Enabled:= False;
end;

procedure TFrmPrincipal.BtnACatClick(Sender: TObject);
Var
  I: Integer;
begin
  Panel1.BringToFront;                                                          //apresenta Panel de edição de categorias
  Panel1.Visible:=True;
  Panel1.Enabled:=True;
  for I := 0 to ComboBox2.Items.Count-1 do
    begin
      ListBox1.Items.Add(ComboBox2.Items.Strings[I])                            //saida para categorias já cadastradas
    end;
end;

procedure TFrmPrincipal.BtnAdClick(Sender: TObject);
var
  I: Integer;
  Erro: Boolean;
begin
  Erro:=false;                                                                  //variavel para condiciomal
  for I := 0 to ListBox1.Items.Count-1 do
    begin
      if ListBox1.Items.Strings[I] =EdtAIt.Text then                            //verifica exietência de uma categoria com mesmo nome já cadastrada
        begin
          Erro:= true                                                           //saida afirmando exietência
        end;
    end;

  if (not(EdtAIt.Text='') and (Erro=False)) then                                //analisa pedido de adição (exietência e nome)
    begin
      ListBox1.Items.Add(EdtAIt.Text)                                           //adiciona categoria [se True]
    end
  else
    begin
      ShowMessage('esta categoria já existe ou esta sem nome, por favor verifique');   //não adiciona categoria [se False]
    end;
  EdtAIt.Clear;
end;

procedure TFrmPrincipal.BtnCadClick(Sender: TObject);
begin
  TabSheet2.Show                                                                //mostra tela de cadatro
end;

procedure TFrmPrincipal.BtnEdiClick(Sender: TObject);                           //-EDITAR ITEM-
var
  I: Integer;
begin
  A:= StGridPrincipal.Row;                                                      //salva número do item (A-1) a ser editado
  BtnSC.Caption:= 'OK';                                                         //muda 'caption' do botão de salvamento
  BtnACat.Enabled:= False;                                                      //bloqueia botão de edição/adicição de categoria
  TabSheet2.Show;                                                               //apresneta tela de edição (= catastro)
  LabeledEdit1.Text:= StGridPrincipal.Cells[1,A];                               //trancreve nome
  LabeledEdit2.Text:= StGridPrincipal.Cells[2,A];                               //trancreve n° itens
  LabeledEdit3.Text:= StGridPrincipal.Cells[3,A];                               //trancreve preço

  for I := 0 to ComboBox1.ItemHeight do
    begin
      if StGridPrincipal.Cells[4,A] = ComboBox1.Items[I] then
        begin
          ComboBox2.Text:= StGridPrincipal.Cells[4,A];                          //trancreve categoria
        end;

    end;



  {for I := 1 to 4 do
    begin
      StGridPrincipal.Cells[I,StGridPrincipal.Row]:=Mat[I-1,StGridPrincipal.Row];     //?
    end; }
end;

procedure TFrmPrincipal.BtnExcClick(Sender: TObject);
Var
  S: Integer;
  I: Integer;
begin
  if MessageDlg('deseja mesmo excluir este item?',mtConfirmation,[mbYes,mbNo],0) //verifica se o usuário realmente quer excluir o item
  =mrYes then
    begin                                                                       //[se True]
      for I := StGridPrincipal.Row to StGridPrincipal.RowCount-1 do
        begin                                                                   //apaga da tela
          StGridPrincipal.Cells[0,I] := StGridPrincipal.Cells[0,I+1];
          StGridPrincipal.Cells[1,I] := StGridPrincipal.Cells[1,I+1];
          StGridPrincipal.Cells[2,I] := StGridPrincipal.Cells[2,I+1];
          StGridPrincipal.Cells[3,I] := StGridPrincipal.Cells[3,I+1];
          StGridPrincipal.Cells[4,I] := StGridPrincipal.Cells[4,I+1];
                                                                                //apaga da memória
          Mat[StGridPrincipal.Col-1,StGridPrincipal.Row-1]:='';
          Mat[StGridPrincipal.Col,StGridPrincipal.Row-1]:='';
          Mat[StGridPrincipal.Col+1,StGridPrincipal.Row-1]:='';
          Mat[StGridPrincipal.Col+2,StGridPrincipal.Row-1]:='';
          Mat[StGridPrincipal.Col+3,StGridPrincipal.Row-1]:='';
        end;
      Aux:= Aux-1;
      Dec(Cont);
    end;
end;

procedure TFrmPrincipal.BtnSCClick(Sender: TObject);
Var
  I,X,S: Integer;
  Flag1: Boolean;                                                               //nome
  Flag2: Boolean;                                                               //categoria
begin
  Flag2:=True;
  for I := 0 to ComboBox1.ItemHeight do                                         //verifica se a categoria existe
    begin
      if (ComboBox2.Text=ComboBox2.Items[I]) then
        begin
          Flag2:=False;
        end;
    end;

      if BtnSC.Caption='Salvar' then                                            //CADASTRAR
        begin
          Salvar_NovoItem();
        end
      else
        begin
          Editar_Item();
          Flag2:= False;                                                        //EDITAR
        end;

  LabeledEdit1.Clear;
  LabeledEdit2.Clear;
  LabeledEdit3.Clear;
  ComboBox2.ItemIndex:=-1;
  ComboBox2.Text:= 'Categoria';
  BtnACat.Enabled:= True;

  if ((Flag2=True) and not(Flag1=True)) then                                    //verifica se a categotia esta preenchida
    begin
      ShowMessage('esta categoria não existe ou esta vazia, o item sera salvo'+
      ' sem categoria');
    end;
end;


procedure TFrmPrincipal.Button1Click(Sender: TObject);
begin
  LabeledEdit1.Clear;                                                           //limpa os campos da tela de cadastro
  LabeledEdit2.Clear;
  LabeledEdit3.Clear;
  ComboBox2.ItemIndex:=-1;
  ComboBox2.Text:= 'Categoria';
  TabSheet1.Show;
  BtnACat.Enabled:= True;                                                               //mostra tela inicial
end;

procedure TFrmPrincipal.Button2Click(Sender: TObject);                          //salva configurações
begin
  if 0<StrToInt(LabeledEdit4.Text) then                                         //verifica se o mínimo informado é um valor positivo
    begin
      TrackBar1.Min:= StrToInt(LabeledEdit4.Text);                              //preço mínimo
      TrackBar2.Min:= StrToInt(LabeledEdit4.Text);
    end
  else
    begin
      ShowMessage('preço mínimo não configurado.'+#13+#13+ 'valor negativo');
    end;

  TrackBar1.Max:= StrToInt(LabeledEdit5.Text);                                  //preço máximo
  TrackBar2.Max:= StrToInt(LabeledEdit5.Text);

  TrBarNP.Max:= StrToInt(LabeledEdit6.Text);                                    //máximo de itens

  Panel3.Visible:= False;                                                       //abilita o restante do programa
  Panel1.Enabled:= True;
  StGridPrincipal.Enabled:= True;
  LEdtNC.Enabled:= True;
  LEdtNome.Enabled:= True;
  TrBarNP.Enabled:= True;
  TrackBar1.Enabled:= True;
  TrackBar2.Enabled:= True;
  ComboBox1.Enabled:= True;
  BBtnBus.Enabled:= True;
  Label7.Enabled:= True;
  CheckBox1.Enabled:= True;
  CheckBox2.Enabled:= True;
  CheckBox3.Enabled:= True;
  CheckBox4.Enabled:= True;
  CheckBox5.Enabled:= True;
  BitBtn1.Enabled:= True;
  BtnCad.Enabled:= True;
  TabSheet2.Enabled:= True;
end;

procedure TFrmPrincipal.BtnDelClick(Sender: TObject);
begin
  ListBox1.DeleteSelected                                                       //apaga categoria selecionada
end;

procedure TFrmPrincipal.BtnIOkClick(Sender: TObject);
var
  I: Integer;
begin
  ComboBox2.Clear;
  for I := 0 to ListBox1.Items.Count-1 do
    begin
      ComboBox2.Items.Add(ListBox1.Items.Strings[I])                            //adiciona categoria a lista de categorias
    end;
  Panel1.Visible:=False;                                                        //esconde tela de adição
  Panel1.Enabled:=False;
  ListBox1.Clear;
end;

procedure TFrmPrincipal.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked=True then
    begin
      CheckBox2.Checked:=False;                                                 //desabilita demais filtros
      CheckBox3.Checked:=False;
      CheckBox4.Checked:=False;
      CheckBox5.Checked:=False;

      NF:=1;
    end                                                                         //numero de filtros seleconados = 1
  else
    NF:=0;                                                                      //zera numero de filtros
end;

procedure TFrmPrincipal.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked=True then
    begin
      CheckBox1.Checked:=False;                                                 //desabilita demais filtros
      CheckBox3.Checked:=False;
      CheckBox4.Checked:=False;
      CheckBox5.Checked:=False;

      NF:=1;                                                                    //numero de filtros seleconados = 1
    end
  else                                                                          //zera numero de filtros
    NF:=0;
end;

procedure TFrmPrincipal.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Checked=True then
    begin
      CheckBox1.Checked:=False;                                                 //desabilita filtro por numero de cadastro
      CheckBox2.Checked:=False;                                                 //desabilita filtro por nome

      Inc(NF)                                                                   //numero de filtros recebe +1
    end
  else
    Dec(NF)                                                                     //numero de filtros recebe -
end;

procedure TFrmPrincipal.CheckBox4Click(Sender: TObject);
begin
  if CheckBox4.Checked=True then
    begin
      CheckBox1.Checked:=False;                                                 //desabilita filtro por numero de cadastro
      CheckBox2.Checked:=False;                                                 //desabilita filtro por nome

      Inc(NF);                                                                  //numero de filtros recebe +1
    end
  else                                                                          //numero de filtros recebe -
    Dec(NF);
end;

procedure TFrmPrincipal.CheckBox5Click(Sender: TObject);
begin
  if CheckBox5.Checked=True then
    begin
      CheckBox1.Checked:=False;                                                 //desabilita filtro por numero de cadastro
      CheckBox2.Checked:=False;                                                 //desabilita filtro por nome

      Inc(NF);                                                                  //numero de filtros recebe +1
    end
  else
    Dec(NF);                                                                    //numero de filtros recebe -
end;

procedure TFrmPrincipal.Editar_Item;
begin
  Mat[0,A-1]:=LabeledEdit1.Text;                                                //passagem de novas informações para a matriz de salvamento
  Mat[1,A-1]:= LabeledEdit2.Text;
  Mat[2,A-1]:=LabeledEdit3.Text;

  if not(ComboBox2.ItemIndex=-1) then
  begin
    Mat[3,A-1]:= ComboBox2.Items[ComboBox2.ItemIndex];
  end;

  StGridPrincipal.Cells[1,A]:= Mat[0,A-1];                                      //passagem das movas informações para a tela principal
  StGridPrincipal.Cells[2,A]:= Mat[1,A-1];
  StGridPrincipal.Cells[3,A]:= Mat[2,A-1];
  StGridPrincipal.Cells[4,A]:= Mat[3,A-1];

  TabSheet1.Show;                                                               //apresentação da tela principal
  BtnSC.Caption:='Salvar';                                                      //mudança do 'Caption' do botão de salvamento
end;

procedure TFrmPrincipal.Filtros(NumFiltros: Integer);
begin
  if NumFiltros=1 then                                                          //1
    begin
      if CheckBox1.Checked=True then                                            //N° DE REGISTRO
        begin
          V_NumRegistro(StrToInt(LEdtNC.Text),cont);
        end;
                                                                                {---------------------------------------------------------}
      if CheckBox2.Checked=True then                                            //NOME
        begin
          V_Nome(LEdtNome.Text);
        end;
                                                                                {---------------------------------------------------------}
      if CheckBox3.Checked=True then                                            //NUMERO DE ITENS
        begin
          V_NumItens(TrBarNP.Position);
        end;                                                                    {---------------------------------------------------------}
                                                                                //INTERVALO DE PREÇO
      if CheckBox4.Checked=True then
        begin
          V_QtItens(TrackBar2.Position,TrackBar1.Position);
        end;
                                                                                {---------------------------------------------------------}                                                                         //CATEGORIA
      if CheckBox5.Checked=True then                                            //CATEGORIA
        begin
          V_Categoria(ComboBox1.Items[ComboBox1.ItemIndex]);
        end;
    end                                                                         //2+
  else
    begin
      FiltrosPlus();
    end;

end;

procedure TFrmPrincipal.FiltrosPlus;
var
  I: Integer;
  X: Integer;
  L: Integer;
begin
  for I := 0 to Cont do                                                         //Preenche a MatAux com a matriz principal
    begin
      for X := 0 to 4 do
        begin
          MatAux[X,I]:= Mat[X,I];                                               //matriz auxiliar recebe registros da matriz principal
        end;
    end;

  if CheckBox3.Checked=True then     //OK                                       //NUMERO DE ITENS
    begin
      for I := 0 to Cont-1 do
      begin
        if not(TrBarNP.Position<=StrToInt(Mat[1,I])) then                       //verificar se o n° de itens registrado é maior que o solicitado
        begin
          for X := 0 to 4 do
          begin
            MatAux[X,I]:= '';                                                   //matriz auxiliar perde o registros da matriz principal
          end;
        end;
      end;
    end;

                                                                                {---------------------------------------------------------}
  if CheckBox4.Checked=True then  //OK                                          //INTERVALO DE PREÇO
    begin                                                                                                                                                        //TrackBar2 = Mínimo
      for I := 0 to Cont-1 do                                                   //TrackBar1 = Máximo  e TrackBar2 = Minimo
        begin
          if not((StrToInt(Mat[2,I])>=TrackBar2.Position) and (StrToInt(Mat[2,I])<= TrackBar1.Position)) then          //verificar se registro esta dentro o intervalo
            begin
              for X := 0 to 4 do
              begin
                MatAux[X,I]:=''                                                 //apagando dados dos itens verificados falsos
              end;
            end;
        end;
    end;

                                                                                {---------------------------------------------------------}
    if CheckBox5.Checked=True then            //OK                              //CATEGORIA
      begin

        for I := 0 to Aux do
          begin
            if not(ComboBox1.Items[ComboBox1.ItemIndex]=Mat[3,I]) then          //verifica se o item esta em na categoria desejada
              begin

                for X := 0 to 4 do
                  begin
                    MatAux[X,I]:='';                                            //apaga dados do item verificado como falsos
                  end;
              end;
          end;
      end;

     L:=0;
    for I := 0 to Cont-1 do
      begin
        if MatAux[0,I]='' then                                                  //verifica quantos itens não estão nos parametros
          begin
            Inc(L);
          end;
      end;

    if L=Cont then                                                              //verifica se todos os itens estão fora dos parametros
      begin
        ShowMessage('registro não encontrado');                                 //saida da vertificação [se True]
        exit;                                                                   // fecha o procedimento
      end
    else
      begin
        for I := 1 to StGridPrincipal.RowCount do
          begin
            for X := 0 to 4 do
            begin
              StGridPrincipal.Cells[X,I]:= '';                                  //limpando StringGrid
            end;
          end;

        L:=0;
        for I := 1 to Cont do
          begin
            if not(MatAux[X-1,I-1]='') then
              begin
                Inc(L);
                for X := 1 to 4 do
                 begin
                  StGridPrincipal.Cells[X,L]:= MatAux[X-1,I-1];                 //saida da verificação [se False]
                  StGridPrincipal.Cells[0,L]:= MatAux[4,I-1]+'.';               //saida do número do item
                end;
              end;
          end;
      end;
end;


procedure TFrmPrincipal.FormCreate(Sender: TObject);                            //inicio padrão do programa
Var
  I: Integer;
begin
  BtnExc.Enabled:= False;
  StGridPrincipal.Cells[0,0]:= 'Nº do Cadastro';
  StGridPrincipal.Cells[1,0]:= 'Nome do Produto';
  StGridPrincipal.Cells[2,0]:= 'Unidades em Estoque';
  StGridPrincipal.Cells[3,0]:= 'Preço Unitário';
  StGridPrincipal.Cells[4,0]:= 'Categoria';
end;

procedure TFrmPrincipal.Label10Click(Sender: TObject);                          //retorna os valores (dos item abaixo) ao padrão original
begin
  LabeledEdit4.Text:= '1';                                                      //preço unitário mínimo
  LabeledEdit5.Text:= '100';                                                    //preço unitário máximo
  LabeledEdit6.Text:= '100';                                                    //n° máximo de itens em estoque
end;

procedure TFrmPrincipal.Label10MouseEnter(Sender: TObject);                     //perfumário do label 'Padrão de Fábrica'
begin
  Label10.Font.Style:= Label10.Font.Style+[fsUnderline];                        //sublinado
  Label10.Font.Color:= clBlue;                                                  //cor
end;

procedure TFrmPrincipal.Label10MouseLeave(Sender: TObject);                     //perfumário do label 'Padrão de Fábrica'
begin
  Label10.Font.Style:= Label10.Font.Style-[fsUnderline];                        //sublinhado
  Label10.Font.Color:= clBlack;                                                 //cor
end;

procedure TFrmPrincipal.Label11Click(Sender: TObject);
begin
  Panel3.Visible:= False;                                                       //abilita o restante do programa
  Panel1.Enabled:= True;
  StGridPrincipal.Enabled:= True;
  LEdtNC.Enabled:= True;
  LEdtNome.Enabled:= True;
  TrBarNP.Enabled:= True;
  TrackBar1.Enabled:= True;
  TrackBar2.Enabled:= True;
  ComboBox1.Enabled:= True;
  BBtnBus.Enabled:= True;
  Label7.Enabled:= True;
  CheckBox1.Enabled:= True;
  CheckBox2.Enabled:= True;
  CheckBox3.Enabled:= True;
  CheckBox4.Enabled:= True;
  CheckBox5.Enabled:= True;
  BitBtn1.Enabled:= True;
  BtnCad.Enabled:= True;
  TabSheet2.Enabled:= True;

  LabeledEdit4.Text:='';
  LabeledEdit5.Text:='';
  LabeledEdit6.Text:='';
end;

procedure TFrmPrincipal.Label11MouseEnter(Sender: TObject);
begin
  Label11.Font.Style:= Label10.Font.Style+[fsUnderline];                        //sublinado
  Label11.Font.Color:= clBlue;                                                  //cor
end;

procedure TFrmPrincipal.Label11MouseLeave(Sender: TObject);
begin
  Label11.Font.Style:= Label11.Font.Style-[fsUnderline];                        //sublinado
  Label11.Font.Color:= clBlack;                                                 //cor
end;

procedure TFrmPrincipal.Label7Click(Sender: TObject);                           //-LIMPAR FILTROS APLICADOS NA GRID-
var
  I: Integer;
  X: Integer;
begin
  for I := 1 to Aux-1 do
    begin
      if not(Mat[0,I-1]='') then
        begin
          for X := 1 to 4 do
            begin
              StGridPrincipal.Cells[0,I]:=IntToStr(I)+'.';                      //passa para grid as informações salvas na matriz
              StGridPrincipal.Cells[X,I]:=Mat[X-1,I-1];
            end;
        end;
    end;

  CheckBox1.Checked:=False;                                                     //limpa os campos dos filtros
  CheckBox2.Checked:=False;
  CheckBox3.Checked:=False;
  CheckBox4.Checked:=False;
  CheckBox5.Checked:=False;
  LEdtNC.Text:='';
  LEdtNome.Text:='';
  TrBarNP.Position:=1;
  TrackBar1.Position:= TrackBar1.Max;
  TrackBar2.Position:= TrackBar2.Min;
  ComboBox1.ItemIndex:=-1;

end;

procedure TFrmPrincipal.Label7MouseEnter(Sender: TObject);                      //perfumário do label 'Limpar'
begin
  Label7.Font.Style:= Label7.Font.Style+[fsUnderline];                          //sublinhado
  Label7.Font.Color:= clBlue;                                                   //cor
end;

procedure TFrmPrincipal.Label7MouseLeave(Sender: TObject);                      //perfumário do label 'Limpar'
begin
  Label7.Font.Style:= Label7.Font.Style-[fsUnderline];                          //sublinhado
  Label7.Font.Color:= clBlack;                                                  //cor
end;

procedure TFrmPrincipal.StGridPrincipalClick(Sender: TObject);
begin
  BtnExc.Enabled:= True;                                                        //abilita botão de exclusão de item
  BtnEdi.Enabled:= True;                                                        //abilita botão de edição de item
end;

procedure TFrmPrincipal.Salvar_NovoItem;                                        //-SALVAR NOVO ITEM-
var
  Flag1: Boolean;
  I: Integer;
  X: Integer;
  S: Integer;
begin
  Flag1:= False;

  for I := 1 to StGridPrincipal.RowCount do                                     //verifica se o item tem nome e se o nome já foi cadastrado antes
  begin
    if ((LabeledEdit1.Text='') or (StGridPrincipal.Cells[1,I]=LabeledEdit1.Text))  then
    begin
      Flag1:=True;
    end
  end;

  if (Flag1=True) then                                                          //se as verificações forem aprovadas
  begin
    ShowMessage('item já cadastrado ou sem nome');
  end
  else
  begin
    for X := 1 to Aux do
    begin
      for S := 1 to 4 do
      begin
        Mat[0,Cont]:=LabeledEdit1.Text;                                         //nome
        Mat[1,Cont]:= LabeledEdit2.Text;                                        //estoque
        Mat[2,Cont]:=LabeledEdit3.Text;                                         //preço

        if not(ComboBox2.ItemIndex=-1) then
        begin
          Mat[3,Cont]:= ComboBox2.Items[ComboBox2.ItemIndex];                   //categoria
        end;

        Mat[4,Cont]:= IntToStr(Aux);                                            //numero

        StGridPrincipal.Cells[0,Aux]:= IntToStr(Aux)+'.';                       //passagem das informações do produto para Grid
        StGridPrincipal.Cells[1,Aux]:= Mat[0,Cont];
        StGridPrincipal.Cells[2,Aux]:= Mat[1,Cont];
        StGridPrincipal.Cells[3,Aux]:= Mat[2,Cont];
        StGridPrincipal.Cells[4,Aux]:= Mat[3,Cont];
      end;
    end;

    if Aux>99 then                                                               //limite padrão de itens
    begin
      if MessageDlg('você atingiu o limite de itens para cadastro, deseja aumenta-lo?',
        mtError,[mbYes,mbNo],0)= mrYes then

      begin
        StGridPrincipal.RowCount:= StGridPrincipal.RowCount+100;
      end;
    end;

    Aux:= Aux+1;
    Inc(Cont);
  end
end;

procedure TFrmPrincipal.TabSheet1Show(Sender: TObject);
var
  I: Integer;
begin
  ComboBox1.Clear;
  for I := 0 to (ComboBox2.Items.Count)-1 do
    begin
      ComboBox1.Items.Add(ComboBox2.Items[I])                                   //repassagem das categorias
    end;
end;

procedure TFrmPrincipal.TabSheet2Exit(Sender: TObject);
begin                                                                           //limpa campos da pagina 'Cadastrar'
  LabeledEdit1.Clear;
  LabeledEdit2.Clear;
  LabeledEdit3.Clear;
  ComboBox2.ItemIndex:=-1;
  ComboBox2.Text:= 'Categoria';
end;

procedure TFrmPrincipal.TrackBar1Change(Sender: TObject);
begin
  Label6.Caption:= IntToStr(TrackBar1.Position)                                 //apresentação da posição da barra de 'Preço' maximo
end;

procedure TFrmPrincipal.TrackBar2Change(Sender: TObject);
begin
  Label5.Caption:= IntToStr(TrackBar2.Position);                                //apresentação da posição da barra de 'Preço' mínimo
end;

procedure TFrmPrincipal.TrBarNPChange(Sender: TObject);
begin
  Label4.Caption:= IntToStr(TrBarNP.Position)                                   //apresentação da posição da barra de 'N° de Itens'
end;

procedure TFrmPrincipal.V_Categoria(Categoria: String);
var
  Flag: Boolean;
  L: Integer;
  X: Integer;
  I: Integer;
begin
  Flag:=False;
  L:=0;                                                                         //CATEGORIA

  for I := 0 to Aux do
  begin
    if Categoria=Mat[3,I] then                                                  //verifica se o item esta em na categoria desejada
    begin
      for X := 0 to 4 do
      begin
        MatAux[X,L]:= Mat[X,I];                                                 //salva dados do item verificado como verdadeiro
      end;

      Inc(L);
      Flag:=True;
    end;
  end;

  if Flag=True then
  begin
    for I := 1 to StGridPrincipal.RowCount do
    begin
      for X := 0 to 4 do
      begin
        StGridPrincipal.Cells[X,I]:='';                                         //limpa StringGrid
      end;
    end;

    for I := 1 to L do
    begin
      for X := 1 to 4 do
      begin
        StGridPrincipal.Cells[X,I]:=MatAux[X-1,I-1];                            //saida da verificação [se true]
        StGridPrincipal.Cells[0,I]:=MatAux[4,I-1];                              //saida do número do item verificado como verdadeiro
      end;
    end;
  end
  else
  begin
    ShowMessage('registro não encontrado');                                     //saida da vertificação [se false]
  end;
end;


procedure TFrmPrincipal.V_Nome(Nome: String);
var
  Flag: Boolean;
  X: Integer;
  I: Integer;
begin                                                                           //NOME
  Flag:= False;

  for I := 0 to Cont-1 do                                                       //percorrer laço (linhas)
  begin
    if Nome=Mat[0,I] then                                                       //verificar existencia de nome na matriz
    begin
      Flag:= True;                                                              //comprovação da existencia do registro
      for X := 1 to 5 do
      begin
        StGridPrincipal.Cells[X,1]:= Mat[X-1,I];                                //saida da verificação [se true]
        StGridPrincipal.Cells[0,1]:= IntToStr(I+1)+'.';                         //saida para o número de registro do item
      end;
    end
  end;

  if Flag=False then
  begin
    ShowMessage('registro não encontrado');                                     //saida da vertificação [se false]
  end
  else
  begin
    for I := 2 to StGridPrincipal.RowCount do                                   //limpra restante da StringGrid [se true]
    begin
      for X := 0 to 4 do
      begin
        StGridPrincipal.Cells[X,I]:='';
      end;
    end;
  end;
end;

procedure TFrmPrincipal.V_NumItens(Posicao: Integer);
var
  I: Integer;
  X: Integer;
  Flag: Boolean;
  L: Integer;
begin
  for I := 1 to StGridPrincipal.RowCount do
    begin                                                                       //N° DE ITENS
      for X := 0 to 4 do
        begin
          MatAux[X,I-1]:='';                                                    //limpar matriz auxiliar
        end;
    end;
  Flag:= False;
  L:=0;

  for I := 0 to Cont-1 do
  begin
    if Posicao<=StrToInt(Mat[1,I]) then                                         //verificar se o n° de itens registrado é maior que o solicitado
    begin
      Flag:=True;
      for X := 0 to 4 do
      begin
        MatAux[X,L]:= Mat[X,I];                                                 //matriz auxiliar recebe registros da matriz principal
      end;
      Inc(L);
    end;
  end;

  if Flag=False then
  begin
    ShowMessage('registro não encontrado');                                     //saida da vertificação [se false]
  end
  else
  begin                                                                         //saida da verificação [se true]
    for I := 1 to StGridPrincipal.RowCount do
    begin
      for X := 0 to 4 do
      begin
        StGridPrincipal.Cells[X,I]:='';                                         //limpar StringGrid
      end;
    end;

   for I := 1 to L do
    begin
     for X := 1 to 4 do
      begin
        StGridPrincipal.Cells[X,I]:= MatAux[X-1,I-1];                           //apresentar a saída {item}
        StGridPrincipal.Cells[0,I]:= MatAux[4,I-1]+'.'                          //apresentar o número do item
      end;
    end;
  end;
end;

procedure TFrmPrincipal.V_NumRegistro(NumReg, cont: Integer);
var
  I: Integer;
  X: Integer;
begin
  if (NumReg<=cont) then                                                        //se valor fornecido é monor que n° de registros
  begin
      for I := 1 to StGridPrincipal.RowCount do
      begin
        if I = NumReg then                                                      //encontrar valor na matriz = fornecido
        begin
          for X := 0 to 4 do
          begin
            StGridPrincipal.Cells[X+1,1]:= Mat[X,I-1];                          //mostrar registro encontrdado
            StGridPrincipal.Cells[0,1]:= IntToStr(I)+'.';                       //mostrar número do registro
          end;
        end;
      end;

    for I := 2 to StGridPrincipal.RowCount do                                   //limpra restante da StringGrid
    begin
      for X := 0 to 4 do
      begin
        StGridPrincipal.Cells[X,I]:='';
      end;
    end;
  end
  else
  begin
    ShowMessage('registro não encontrado');                                     //saida da verificação [se False]
  end;
end;

procedure TFrmPrincipal.V_QtItens(Min, Max: Integer);
var
  Flag: Boolean;
  L: Integer;
  I: Integer;
  X: Integer;
begin
  Flag:= False;
  L:=0;                                                                         //INTERVALO DE PREÇO
                                                                                //TrackBar2 = Mínimo
  for I := 0 to Cont-1 do                                                       //TrackBar1 = Máximo
  begin
    if ((StrToInt(Mat[2,I])>=Min) and (StrToInt(Mat[2,I])<= Max)) then          //verificar se registro esta dentro o intervalo
    begin
      for X := 0 to 4 do
      begin
        MatAux[X,L]:= Mat[X,I];                                                 //salvando dados dos itens verificados verdadeiros
      end;

      Inc(L);
      Flag:= True;                                                              //atesta que há item encontrado
    end;
  end;

  if Flag=True then                                                             //verifica se há item encontrado
  begin
    for I := 1 to StGridPrincipal.RowCount do
    begin
      for X := 0 to 4 do
      begin
        StGridPrincipal.Cells[X,I]:= '';                                        //limpando StringGrid
      end;
    end;

    for I := 1 to L do
    begin
      for X := 1 to 4 do
      begin
        StGridPrincipal.Cells[X,I]:= MatAux[X-1,I-1];                           //saida da verificação [se true]
        StGridPrincipal.Cells[0,I]:= MatAux[4,I-1]+'.';                         //saida do número do item
      end;
    end;
  end
  else
  begin
    ShowMessage('registro não encontrado');                                     //saida da vertificação [se false]
  end;
end;

Initialization
Aux:=1;
Cont:=0;
Teste:= False;
NF:=0;
end.
