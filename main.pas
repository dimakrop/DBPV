uses
   DoS, Crt;

const
   KeyUp = #72;
   KeyDown = #80;
   KeyPress = #13;
   KeyBack = #27;
   ColorThFr = 7;
   ColorThFrText = 8;
   ColorThBck = 8;
   ColorThBckText = 7;

procedure
   DrawTh;

begin
   TextBackground(ColorThBck);
   ClrScr;
   TextBackground(ColorThFr);
   ClrEol;
   gotoXY (1, 25);
   ClrEol
end;

procedure
   SetBckText;

begin
   TextColor(ColorThBckText);
   TextBackGround(ColorThBck);
end;

procedure
   SetFrText;

begin
   TextColor(ColorThFrText);
   TextBackground(ColorThFr);
end;

procedure
   ExitFrPrg;

begin
   ClrScr;
   TextBackground(8);
   TextColor(7);
   Halt;
end;

procedure
   About;

var
   key : char;
   h, m, s ,sl, ms : word;

begin
   DrawTh;
   gotoXY (38, 1);
   write ('About');
   gotoXY (55, 25);
   write ('Dmitry Kropenko (C) 2014');
   SetBckText;
   gotoXY(1, 3);
   writeln('          DBP Viewer');
   writeln;
   writeln('   DBP Viewer - calculator (calc) for search average of cube of two numbers');
   writeln('   and geometric average of this.');
   writeln;
   writeln('          NAVIGATION');
   writeln;
   writeln('   Press Up and Down for navigation in main menu.');
   writeln('   Press Enter to choose your choice.');
   writeln('   Press Esc to exit to main menu and to exit from DBP Viewer.');
   writeln;
   writeln('          AUTHOR');
   writeln;
   writeln('   This program was created by Dmitry Kropenko, student of NTUU KPI PMF KM-43');
   writeln('   in 2014 as lab work for programing and for practice.');
   writeln;
   writeln('   e-mail: k.dmitriu@gmail.com');
   gotoXY (80, 25);
   repeat
      Delay (4);
      if keypressed then
         key := readkey;
      GetTime (h, m, s, ms);
      if s <> sl then
      begin
         SetFrText;
         gotoXY (2, 25);
         write (h:2, ':', m:2, ':', s:2);
         sl := s;
      end;
      gotoXY (80, 25);
   until (key = KeyBack) or (key = KeyPress);
end;

procedure
   WAdd (fname : string);

var
   i : integer;
   f : text;
   s : string;

begin
   ClrScr;
   writeln (s, ' ');
   DrawTh;
   SetFrText;
   gotoXY (35, 1);
   write ('DBP Viewer');
   gotoXY (55, 25);
   write ('Dmitry Kropenko (C) 2014');
   SetBckText;
   TextColor(7);
   for i := 2 to 24 do
      begin
         gotoXY (1, i);
         ClrEol;
      end;
   assign (f, fname);
   Append (f);
   gotoXY (2, 3);
   write ('Enter name: ');
   gotoXY (14, 3);
   read(s);
   writeln(f, s);
   readln;
   gotoXY (2, 3);
   ClrEol;
   write ('Enter profession: ');
   read(s);
   writeln(f, s);
   readln;
   gotoXY (2, 3);
   ClrEol;
   write ('Enter work from: ');
   read(s);
   writeln(f, s);
   readln;
   gotoXY(2, 3);
   ClrEol;
   write ('Enter payment; ');
   read(s);
   writeln(f, s);
   readln;
   gotoXY (2, 3);
   ClrEol;
   write ('Note added sucessfully!');
   readln;
   Close (f);
   Exit;
end;

procedure
   WTask (fname : string);

var
   i, k, pos, iminp, mino, nof, chs, h, m, s, ms, sl: word;
   f : text;
   MP : array [1..1000, 1..3] of string;
   MO, MINPO : array [1..1000] of word;
   key : char;

begin
   TextColor(7);
   for i := 2 to 24 do
      begin
         gotoXY (1, i);
         ClrEol;
      end;
   assign (f, fname);
   reset (f);
   i := 0;
   mino := 65535;
   repeat
      Inc(i);
      readln (f, MP[i, 1]);
      readln (f, MP[i, 2]);
      readln (f, MP[i, 3]);
      readln (f, MO[i]);
      if (MO[i] < mino) and (MO[i] <> 0) then
         begin
            mino := MO[i];
            iminp := 1;
            MINPO[iminp] := i;
         end
      else
      if (MO[i] = mino) then
         begin
            Inc (iminp);
            MINPO[iminp] := i;
         end;
   until MP[i, 1] = '';
   close(f);
   Dec (i);
   for k := 2 to 8 do
      begin
         gotoXY (1, k);
         ClrEol;
      end;
   GotoXY (1, 3);
   write (' Found ', iminp, ' entries:');
   gotoXY(1, 22);
   writeln(' Press Enter or Esc to back to menu');
   pos := 1;
   for k := pos to (pos + 1) do
      begin
         if k <= iminp then
            begin
               gotoXY (1, 6 + 7 * ((k + 1) mod 2));
               writeln ('________________________________________________________');
               writeln ('   |');
               writeln ('   |       Name : ', MP[MINPO[k], 1]);
               writeln (k : 3,'| Profession : ', MP[MINPO[k], 2]);
               writeln ('   |  Work from : ', MP[MINPO[k], 3]);
               writeln ('   |    Payment : ', MO[MINPO[k]]);
               writeln ('________________________________________________________');
               gotoXY (80, 25);
            end;
      end;
   repeat
      if keypressed then
         begin
            key := readkey;
            if key = KeyDown then
               if (pos + 1) < iminp then
                  Inc (pos);
            if key = KeyUp then
               if pos > 1 then
                  Dec (pos);
            for k := 6 to 21 do
               begin
                  gotoXY (1, k);
                  ClrEol;
               end;
            for k := pos to (pos + 1) do
               begin
                  if k <= iminp then
                     begin
                        gotoXY (1, 6 + 7 * (k - pos));
                        writeln ('________________________________________________________');
                        writeln ('   |');
                        writeln ('   |       Name : ', MP[MINPO[k], 1]);
                        writeln (k : 3,'| Profession : ', MP[MINPO[k], 2]);
                        writeln ('   |  Work from : ', MP[MINPO[k], 3]);
                        writeln ('   |    Payment : ', MO[MINPO[k]]);
                        writeln ('________________________________________________________');
                        gotoXY (80, 25);
                     end;
               end;
         end;
   GetTime (h, m, s, ms);
   if s <> sl then
   begin
      SetFrText;
      gotoXY (2, 25);
      write (h:2, ':', m:2, ':', s:2);
      sl := s;
      gotoXY (80, 25);
      SetBckText;
   end;
   until (key = KeyBack) or (key = KeyPress);
   Exit;
end;

procedure
   WAll (fname : string);

var
   i, k, pos, nof, chs, iminp, h, m, s, ms, sl: word;
   f : text;
   MP : array [1..1000, 1..3] of string;
   MO : array [1..1000] of word;
   FLIST : array [1..100] of string;
   key : char;
   DirInfo : SearchRec;

begin
   for i := 2 to 24 do
      begin
         gotoXY (1, i);
         ClrEol;
      end;
   assign (f, fname);
   reset (f);
   i := 0;
   repeat
      Inc(i);
      readln (f, MP[i, 1]);
      readln (f, MP[i, 2]);
      readln (f, MP[i, 3]);
      readln (f, MO[i]);
   until MP[i, 1] = '';
   close(f);
   Dec (i);
   for k := 2 to 24 do
      begin
         gotoXY (1, k);
         ClrEol;
      end;
   GotoXY (1, 3);
   TextColor (7);
   write (' There are ', i, ' notes:');
   gotoXY(1, 22);
   writeln(' Press Esc or Enter to back to DBP Viewer');
   pos := 1;
   for k := pos to (pos + 1) do
      begin
         if k <= i then
            begin
               gotoXY (1, 6 + 7 * ((k + 1) mod 2));
               writeln ('________________________________________________________');
               writeln ('   |');
               writeln ('   |       Name : ', MP[k, 1]);
               writeln (k : 3,'| Profession : ', MP[k, 2]);
               writeln ('   |  Work from : ', MP[k, 3]);
               writeln ('   |    Payment : ', MO[k]);
               writeln ('________________________________________________________');
               gotoXY (80, 25);
            end;
      end;
   repeat
      if keypressed then
         begin
            key := readkey;
            if key = KeyDown then
               if (pos + 1) < i then
                  Inc (pos);
            if key = KeyUp then
               if pos > 1 then
                  Dec (pos);
            for k := 6 to 21 do
               begin
                  gotoXY (1, k);
                  ClrEol;
               end;
            for k := pos to (pos + 1) do
               begin
                  if k <= i then
                     begin
                        gotoXY (1, 6 + 7 * (k - pos));
                        writeln ('________________________________________________________');
                        writeln ('   |');
                        writeln ('   |       Name : ', MP[k, 1]);
                        writeln (k : 3,'| Profession : ', MP[k, 2]);
                        writeln ('   |  Work from : ', MP[k, 3]);
                        writeln ('   |    Payment : ', MO[k]);
                        writeln ('________________________________________________________');
                        gotoXY (80, 25);
                     end;
               end;
         end;
      GetTime (h, m, s, ms);
      if s <> sl then
      begin
         SetFrText;
         gotoXY (2, 25);
         write (h:2, ':', m:2, ':', s:2);
         sl := s;
         gotoXY (80, 25);
         SetBckText;
      end;
   until (key = KeyBack) or (key = KeyPress);
   Exit;
end;

procedure
   Menu (fname : string);

var
  f : text;
  key : char;
  chs : integer;
  i, k : byte;
  h, m, s, sl, ms : word;
  MNAME : array [0..5] of string;
  MX : array [0..5] of byte;

begin
   MNAME[0] := 'Choose file';
   MNAME[1] := 'Add note';
   MNAME[2] := 'View file';
   MNAME[3] := 'Find min payment';
   MNAME[4] := 'About';
   MNAME[5] := 'Exit';
   MX[0] := 35;
   MX[1] := 37;
   MX[2] := 36;
   MX[3] := 33;
   MX[4] := 38;
   MX[5] := 39;
   TextBackground (ColorThBck);
   ClrScr;
   TextBackground (ColorThFr);
   for i := 1 to 7 do
      begin
         gotoXY (1, i);
         ClrEol;
      end;
   gotoXY (1, 25);
   ClrEol;
   SetFrText;
   gotoXY (55, 25);
   write ('Dmitry Kropenko (C) 2014');

   begin
   chs := 9996;
      assign (f, 'menu.txt');
      Reset (f);
      for k := 1 to 5 do
         for i := 1 to 44 do
            begin
               TextBackground (8);
               read (f, key);
               if key = '1' then
                  begin
                     gotoXY (19 + i, 1 + k);
                     write (' ');
                  end;
            end;
      close (f);
   end;

   SetBckText;
   for i := 0 to 5 do
      begin
         if (abs(chs mod 6)) = i then
            TextColor (7)
         else
            TextColor (8);
         gotoXY (MX[i], 12 + i);
         write (MNAME[i]);
      end;
   gotoXY (2, 23);
   write ('File : ', fname);
   repeat
   if keypressed then
      begin
         key := readkey;
         case key of
            KeyUp : Dec(chs);
            KeyDown : Inc(chs);
            KeyBack : ExitFrPrg;
         end;

      TextBackground (8);
      for i := 0 to 5 do
      begin
         if (abs(chs mod 6)) = i then
            TextColor (7)
         else
            TextColor (8);
         gotoXY (MX[i], 12 + i);
         write (MNAME[i]);
      end;
   end;
   GetTime (h, m, s, ms);
   if s <>sl then
   begin
      SetFrText;
      gotoXY (2, 25);
      write (h:2, ':', m:2, ':', s:2);
      sl := s;
   end;
   gotoXY (80, 25);
   until key = KeyPress;
   case (abs(chs mod 6)) of
      0 : Exit;
      1 : WAdd (fname);
      2 : WAll (fname);
      3 : WTask (fname);
      4 : About;
      5 : ExitFrPrg;
   end;
   Menu (fname);
end;

procedure
   WChs (fname : string);

var
   i, k, pos, iminp, mino, nof, chs, h, m, s, ms, sl: word;
   f : text;
   MP : array [1..1000, 1..3] of string;
   MO, MINPO : array [1..1000] of word;
   FLIST : array [1..100] of string;
   key : char;
   DirInfo : SearchRec;

begin
   chs := 15000;
   DrawTh;
   SetFrText;
   gotoXY (35, 1);
   write ('DBP Viewer');
   gotoXY (55, 25);
   write ('Dmitry Kropenko (C) 2014');
   SetBckText;
   gotoXY (2, 3);
   write ('Choose file: ');
   nof := 0;
   FindFirst('*.dbp', AnyFile, DirInfo);
   while DosError = 0 do
      begin
         Inc (nof);
         FLIST[nof] := DirInfo.Name;
         FindNext(DirInfo);
      end;
   for i := 0 to (nof - 1) do
      begin
         if (abs(chs mod nof)) = i then
            TextColor (7)
         else
            TextColor (8);
         gotoXY (2 + 25 * (i div 19), 5 + (i mod 19));
         write (FLIST[i+1]);
      end;
   repeat
   if keypressed then
      begin
         key := readkey;
         case key of
            KeyUp : Dec(chs);
            KeyDown : Inc(chs);
            KeyBack : exit;
            KeyPress : begin
                          fname := FLIST [(abs(chs mod nof)) + 1];
                          Menu(fname);
   DrawTh;
   SetFrText;
   gotoXY (35, 1);
   write ('DBP Viewer');
   gotoXY (55, 25);
   write ('Dmitry Kropenko (C) 2014');
   SetBckText;
   gotoXY (2, 3);
   write ('Choose file: ');
   for i := 0 to (nof - 1) do
      begin
         if (abs(chs mod nof)) = i then
            TextColor (7)
         else
            TextColor (8);
         gotoXY (2 + 25 * (i div 19), 5 + (i mod 19));
         write (FLIST[i+1]);
      end;
                       end;
         end;
      TextBackground (8);
      for i := 0 to (nof - 1) do
      begin
         if (abs(chs mod nof)) = i then
            TextColor (7)
         else
            TextColor (8);
         gotoXY (2 + 25 * (i div 19), 5 + (i mod 19));
         if ((abs(chs mod nof)) >= (i - 1)) and((abs(chs mod nof)) <= (i + 1)) or (i = 0) or (i = (nof - 1)) then
            write (FLIST[i+1]);
      end;
   end;
   GetTime (h, m, s, ms);
   if s <>sl then
   begin
      SetFrText;
      gotoXY (2, 25);
      write (h:2, ':', m:2, ':', s:2);
      sl := s;
   end;
   gotoXY (80, 25);
   until key = KeyBack;
   Exit;
end;

procedure
   MainMenu;

var
  f : text;
  key : char;
  chs : integer;
  i, k : byte;
  h, m, s, sl, ms : word;
  MNAME : array [0..2] of string;
  MX : array [0..2] of byte;

begin
   MNAME[0] := 'Choose File';
   MNAME[1] := 'About';
   MNAME[2] := 'Exit';
   MX[0] := 35;
   MX[1] := 38;
   MX[2] := 39;

   TextBackground (ColorThBck);
   ClrScr;
   TextBackground (ColorThFr);
   for i := 1 to 7 do
      begin
         gotoXY (1, i);
         ClrEol;
      end;
   gotoXY (1, 25);
   ClrEol;
   SetFrText;
   gotoXY (55, 25);
   write ('Dmitry Kropenko (C) 2014');

   begin
   chs := 9999;
      assign (f, 'menu.txt');
      Reset (f);
      for k := 1 to 5 do
         for i := 1 to 44 do
            begin
               TextBackground (8);
               read (f, key);
               if key = '1' then
                  begin
                     gotoXY (19 + i, 1 + k);
                     write (' ');
                  end;
            end;
      close (f);
   end;

   SetBckText;
   for i := 0 to 2 do
      begin
         if (abs(chs mod 3)) = i then
            TextColor (7)
         else
            TextColor (8);
         gotoXY (MX[i], 12 + i);
         write (MNAME[i]);
      end;
   repeat
   if keypressed then
      begin
         key := readkey;
         case key of
            KeyUp : Dec(chs);
            KeyDown : Inc(chs);
            KeyBack : ExitFrPrg;
         end;

      TextBackground (8);
      for i := 0 to 2 do
      begin
         if (abs(chs mod 3)) = i then
            TextColor (7)
         else
            TextColor (8);
         gotoXY (MX[i], 12 + i);
         write (MNAME[i]);
      end;
   end;
   GetTime (h, m, s, ms);
   if s <>sl then
   begin
      SetFrText;
      gotoXY (2, 25);
      write (h:2, ':', m:2, ':', s:2);
      sl := s;
   end;
   gotoXY (80, 25);
   until key = KeyPress;
   case (abs(chs mod 3)) of
      0 : WChs ('0');
      1 : About;
      2 : ExitFrPrg;
   end;
   MainMenu;
end;


begin
   MainMenu;
end.
