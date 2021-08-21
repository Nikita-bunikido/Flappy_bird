uses GraphWPF;

const n = 800;

var
  x, y, w, mbb,
  TX1, TY1, TX2, TY2, vert, shet, prosh, best, xsun, ysun, p, pass: integer;
  NUM_RAYS,MAX_DEPTH, FOV:integer;
  DELTA_ANGLE:real;
  gameover: boolean;
  bstring:string;
  xray: array [1..n] of real;
  yray: array [1..n] of real;
  tangle: array [1..n] of real;
  tradians: array [1..n] of real;
  
procedure MouseDown(x, y, mb: integer);//Процедура зажатия мыши
begin
  mbb := mb;
end;

procedure MouseUp(x, y, mb: integer);//Процедура отжатия мыши
begin
  mbb := mb;
end;

procedure RESTART;
begin
  prosh := 0;
  gameover := false;
  shet := 0;
  TY1 := random(400, 800);
  TX1 := 850;
  TY2 := random(400, 800);
  TX2 := TX1 + 500;
  bstring := 'bird1';
  w := 1;
  y := 0;
  mbb:=0;
end;

procedure FRAME;
begin
DrawImage(0,-200,'data\background.png');
    y := y + w;
    
    if (mbb = 1) and (gameover = false) then begin w := -20; mbb := 0; end;
    if w in [-20..-5] then begin bstring := 'bird2'; vert := 102; end;
    if w in [-5..10] then begin bstring := 'bird1'; vert := 84; end;
    if w in [10..15] then begin bstring := 'bird3'; vert := 102; end;
    
    w := w + 1;
    DrawImage(TX1,TY1,'data\TRUBA1.png');
    DrawImage(TX1,TY1-1100,'data\TRUBA2.png');
    
    DrawImage(TX2,TY2,'data\TRUBA1.png');
    DrawImage(TX2,TY2-1100,'data\TRUBA2.png');
    
    if gameover = false then begin
      TX1 := TX1 - 8;
      TX2 := TX2 - 8;
    end;
    
    if TX1 <= -170 then begin
      TY1 := random(400, 800);
      TX1 := TX2 + 500;
      shet := shet + 1;
    end;
    
    if TX2 <= -170 then begin
      TY2 := random(400, 800);
      TX2 := TX1 + 500;
      shet := shet + 1;
    end;
    

    DrawImage(x+100,y,'data\'+ bstring +'.png');

    
    OnkeyDown := K ->
begin
    if K=Key.Up then mbb:=1;
    end;
    
        OnkeyUp := L ->
begin
    if L=Key.Up then mbb:=0;
    end;
    
  

  
    if (x in [TX1 - 161..TX1]) and (y + vert > TY1) then begin gameover := true; end;
    if (x in [TX2 - 161..TX2]) and (y + vert > TY2) then begin gameover := true; end;
    if (x in [TX1 - 161..TX1]) and (y < TY1 - 1100 + 800) then begin gameover := true; end;
    if (x in [TX2 - 161..TX2]) and (y < TY2 - 1100 + 800) then begin gameover := true; end;
    
    if Y + vert > 800 then gameover := true;
    if Y < 0 then gameover := true;
    if gameover = true then begin
      prosh := prosh + 1;
      if prosh > 80 then RESTART;
      if shet>best then best:=shet;
    end;
    
      TextOut(10,70,best,colors.WHITE);
      
end;

begin
  Window.SetSize(800,800);
  Window.Title:='FLAPPY_PASCAL_RUNNER_TEST_V 2.0';
  
  pass:=100;
  FOV := 362;
  NUM_RAYS := 100;
  DELTA_ANGLE := FOV / NUM_RAYS;
  MAX_DEPTH := 10;
  
  shet := 0;
  TY1 := random(400, 800);
  TX1 := 850;
  TY2 := random(400, 800);
  TX2 := TX1 + 500;
  bstring := 'bird1';

  w := 1;

  xsun:=700;
  ysun:=100;
  
  BeginFrameBasedAnimation(frame,100);
end.