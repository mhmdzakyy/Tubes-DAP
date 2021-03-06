Program TugasBesar;
uses crt;

const nMax = 5;
// DATABASE
type kapster = record
        id : string;
        nama : string;
        spesialis : string;
        end;

type paketcukur = record
         id : string;
         paket : string;
         biaya : string;
         end;

type jadwal = record
        id_jadwal : integer;
        hari : string;
        tanggal : string;
        jam : string;
        sudah_dipesan : boolean;
        end;

type customer = record
        id : integer;
        nama : string;
        alamat : string;
        end;

type tabkapster = array [1..nMax] of kapster;
type tabjadwal = array of jadwal;
type tabpaketcukur = array [1..3] of paketcukur;
type tabcustomer = array [1..100] of customer;

// END DATABASE

// VAR GLOBAL
var
    kap : tabkapster;
    jdw : tabjadwal;
    cuk : tabpaketcukur;
    cus : tabcustomer;
    allId : array [1..3] of integer;
    Ncustomer, list, idk, id, sp : string;
    option, kapster_length, jumlah, n, banyakjadwal, x : integer;

// PROCEDURE FORWARD
procedure home; forward;
procedure home_admin; forward;
procedure home_customer; forward;
procedure insert_kapster(var kp : tabkapster; var jumlah : integer); forward;
procedure cari_spesialis(sp : string; var kp : tabkapster); forward;
procedure show_kapster(var kp : tabkapster; var jumlah : integer); forward;
procedure insert_jadwal(var jd : tabjadwal); forward;
procedure show_jadwal(var jd : tabjadwal); forward;
procedure edit_kaps(id : string; var kp : tabkapster);forward;
procedure insert_customer(var cs : tabcustomer; var x : integer); forward;
procedure show_customer(var cs : tabcustomer; var x : integer); forward;
procedure pemesanan(var kp : tabkapster; var pc : tabpaketcukur; var jd : tabjadwal; var cs : tabcustomer); forward;
procedure checkout(var cs : tabcustomer; var pc : tabpaketcukur; var jd : tabjadwal; var kp : tabkapster);forward;
procedure paket_cukur(var pc : tabpaketcukur); forward;
procedure sort_paket(pc : tabpaketcukur);forward;
procedure header; forward;

// BEGIN FUNCTION
function cariID(kp : tabkapster; id : string):integer;
    var
        i : integer;
        found : integer;
    begin
        found := -1;
        i := 1;
        while (i<=jumlah) do
        begin
            if (kp[i].id = id) then
                found := i;
            i := i+1;
        end;
        cariID := found;
    end;

function cariSP(sp : string; kp : tabkapster):integer;
    var
        i, found : integer;
    begin
        found := -1;
        i := 1;
        while ((i<=nMax) and (found = -1)) do
        begin
            if (kp[i].spesialis = sp) then
                found := i;
            i := i+1;
        end;
        cariSP := found;
    end;

function cariJD(jd : tabjadwal; id_jadwal : integer):integer;
    var
        x, i: integer;
        found : boolean;
    begin
        found := false;
        for i:=0 to high(jd) do
        begin
            if (jd[i].id_jadwal = id_jadwal) then
            begin
                found := true;
                x := i;
                break;
            end;
        end;
        if found then
            cariJD := x
        else
            cariJD := -1;

    end;

function cariCS(cs : tabcustomer; nama_cus : string):integer;
    var
        i, found : integer;
    begin
        found := -1;
        i := 1;
        while ((i<=100) and (found = -1)) do
        begin
            if (cs[i].nama = nama_cus) then
                found := i;
            i := i+1;
        end;
        cariCS := found;
    end;

function cariPC(pc : tabpaketcukur; id : string):integer;
    var
        i : integer;
        found : integer;
    begin
        found := -1;
        i := 1;
        while (i<=3) do
        begin
            if (pc[i].id = id) then
                found := i;
            i := i+1;
        end;
        cariPC := found;
    end;
//END FUNCTION

//BEGIN PROCEDURE
procedure algoritma_option;
    begin
        repeat
            write('Masukkan Pilihan : ');
            readln(option);
            if (option=1) then
                begin
                    home_admin
                end
            else if (option=2) then
                begin
                    home_customer
                end
            else
                begin
                    writeln();
                    writeln('Input Salah, Silahkan Coba Lagi');
                end;
        until ((option=1) or (option=2));
    end;

procedure algoritma_admin;
    begin
        repeat
            write('Masukkan Pilihan : ');
            readln(option);
            if (option=1) then
                begin
                        insert_kapster(kap,jumlah)
                end
            else if (option=2) then
                begin
                        insert_jadwal(jdw)
                end
            else if (option=3) then
                begin
                        show_kapster(kap,jumlah)
                end
            else if (option=4) then
                begin
                        show_jadwal(jdw)
                end
            else if (option=5) then
                begin
                        edit_kaps(id,kap)
                end
            else if (option=0) then
                begin
                        home
                end
            else
                begin
                    writeln();
                    writeln('Input Salah, Silahkan Coba lagi');
                end;
        until ((option=1) or (option=2) or (option=3) or (option=4) or (option=5) or (option=0));
    end;

procedure algoritma_cutomer;
    begin
        repeat
            write('Masukkan Pilihan : ');
            readln(option);
            if (option=1) then
                begin
                        cari_spesialis(sp,kap);
                end
            else if (option = 2) then
                begin
                        paket_cukur(cuk);
                end
            else if (option=3) then
                begin
                        sort_paket(cuk);
                end
            else if (option=4) then
                begin
                        show_jadwal(jdw);
                end
            else if (option=5) then
                begin
                        insert_customer(cus,x);
                end
            else if (option=6) then
                begin
                        pemesanan(kap,cuk,jdw,cus);
                end
            else if (option=7) then
                begin
                        checkout(cus,cuk,jdw,kap);
                end
            else if (option=0) then
                begin
                        home;
                end
            else
                begin
                    writeln();
                    writeln('Input Salah, Silahkan Coba lagi');
                end;
        until ((option=1) or (option=2) or (option=3) or (option=4) or (option=5) or (option=6));
    end;

procedure home_admin;
    begin
        header;
        writeln('=== MENU ADMIN ===');
        writeln();
        writeln('1. Tambah Kapster');
        writeln('2. Tambah Jadwal');
        writeln('3. Lihat Kapster');
        writeln('4. Lihat Jadwal');
        writeln('5. Edit Kapster');
        writeln('0. Kembali');
        writeln();
        algoritma_admin;

    end;

procedure home_customer;
    begin
        header;
        writeln('=== MENU CUSTOMER ===');
        writeln();
        writeln('1. Cari Kapster');
        writeln('2. Lihat Daftar Paket Cukur');
        writeln('3. Sorting harga Paket');
        writeln('4. Lihat Jadwal');
        writeln('5. Tambah Data Customer');
        writeln('6. Pemesanan Cukur');
        writeln('7. Lihat Data Transaksi');
        writeln('0. Kembali');
        algoritma_cutomer;
    end;

procedure home;
    begin
        header;
        writeln('Silahkan Pilih Untuk Masuk ke Menu Utama : ');
        writeln('1. Menu Admin');
        writeln('2. Menu Customer');
        algoritma_option;
        writeln();
    end;

procedure insert_kapster(var kp : tabkapster; var jumlah : integer);
    var
            i : integer;
    begin
            clrscr;
            i := jumlah + 1;
            writeln('>==============================<');
            writeln('>>>    INPUT DATA KAPSTER    <<<');
            writeln('>==============================<');
            writeln();
            if (jumlah<nMax) then
                begin
                    write('Masukkan ID Kapster : ');
                    readln(kp[i].id);
                    write('Masukkan Nama Kapster : ');
                    readln(kp[i].nama);
                    write('Masukkan Spesialis Cukur Kaspter : ');
                    readln(kp[i].spesialis);
                    jumlah := jumlah + 1;
                    writeln();
                    write('Data Kapster Berhasil Ditambah . . .');
                end
            else
                writeln('Anda Melebihi Batas Maksimal Input Kapster, Silahkan Pilih Menu Lain . . .');
            Readkey;
            clrscr;
            home_admin;
    end;

procedure data_kapster(var kp : tabkapster);
    begin
        kp[1].id := 'UJG';
        kp[1].nama := 'Ujang';
        kp[1].spesialis := 'Pompadour';

        kp[2].id := 'DNY';
        kp[2].nama := 'Danny';
        kp[2].spesialis := 'Undercut';

        kp[3].id := 'BLY';
        kp[3].nama := 'Billy';
        kp[3].spesialis := 'Cepak';
    end;

procedure show_kapster (var kp : tabkapster; var jumlah : integer);
    var
            i : integer;
    begin
            clrscr;
            i := 1;
            writeln('>==============================<');
            writeln('>>>      DAFTAR KAPSTER      <<<');
            writeln('>==============================<');
            writeln();
            while (i <= jumlah) do
            begin
                writeln;
                writeln('KAPSTER ',i);
                writeln('ID Kapster : ',kp[i].id);
                writeln('Nama       : ',kp[i].nama);
                writeln('Spesialis  : ',kp[i].spesialis);
                i := i+1;
            end;
            writeln();
            write('Hit Any Key To Continue . . .');
            Readkey;
            home_admin;
    end;

procedure cari_spesialis(sp : string; var kp : tabkapster);
    var
        x : integer;
    begin
        clrscr;
        writeln('>==============================<');
        writeln('>>>       CARI KAPSTER       <<<');
        writeln('>==============================<');
        writeln();
        write('Cari Menurut Spesialis Kapster : ');
        readln(sp);
        writeln;
        x := cariSP(sp,kp);
        if (x<>-1) then
            begin
                writeln;
                writeln('KAPSTER ',x);
                writeln('ID Kapster : ',kp[x].id);
                writeln('Nama       : ',kp[x].nama);
                writeln('Spesialis  : ',kp[x].spesialis);
            end
        else
            writeln('Kapster Tidak Ditemukan . . .');
        writeln;
        write('Hit Any Key To Continue . . .');
        readkey;
        home_customer;
    end;

procedure edit_kaps(id : string; var kp : tabkapster);
    var
        i : integer;
    begin
        clrscr;
        writeln('>==============================<');
        writeln('>>>      DAFTAR KAPSTER      <<<');
        writeln('>==============================<');
        writeln();
        i := 1;
        while (i <= jumlah) do
        begin
                writeln;
                writeln('KAPSTER ',i);
                writeln('ID Kapster : ',kp[i].id);
                writeln('Nama       : ',kp[i].nama);
                writeln('Spesialis  : ',kp[i].spesialis);
                i := i+1;
        end;
        writeln();
        write('Masukkan ID Kapster yang mau di Edit : ');
        readln(id);
        i := cariID(kp,id);
        writeln;
        if (i<>-1) then
            begin
                write ('Masukkan Nama Kapster yang baru : ');
                readln(kp[i].nama);
                write('Masukkan Spesialis Kapster yang Baru : ');
                readln(kp[i].spesialis);
            end
        else
            write('ID Kapster tidak ditemukan, Silahkan ulangi');
        writeln;
        write('Hit Any Key To Continue . . . ');
        readkey;
        home_admin;
    end;

procedure insert_jadwal(var jd : tabjadwal);
    var
        id_jd, x : integer;
    begin
        banyakjadwal := length(jd)+1;
        setlength(jd,banyakjadwal);
        repeat
            clrscr;
            writeln('>==============================<');
            writeln('>>>        INSERT JADWAL     <<<');
            writeln('>==============================<');
            write('Masukkan ID Jadwal : ');
            readln(id_jd);
            x := cariJD(jd,id_jd);
            if x<>-1 then
                begin
                        write('ID Jadwal Sudah Terdaftar');
                        readkey;
                end;
        until (x=-1);
        jd[banyakjadwal-1].id_jadwal := id_jd;
        write('Masukkan Hari Pemesanan : ');
        readln(jd[banyakjadwal-1].hari);
        write('Masukkan Tanggal dan Bulan Pemesanan : ');
        readln(jd[banyakjadwal-1].tanggal);
        write('Masukkan Jam Pemesanan : ');
        readln(jd[banyakjadwal-1].jam);
        writeln();
        jd[banyakjadwal-1].sudah_dipesan := false;
        write('Data Berhasil Ditambah . . .');
        readkey;
        home_admin;
    end;

procedure show_jadwal(var  jd : tabjadwal);
    var
        i : integer;
    begin
        clrscr;
        writeln('>==============================<');
        writeln('>>>        DAFTAR JADWAL     <<<');
        writeln('>==============================<');
        for i:=0 to length(jd)-1 do
        begin

            writeln('ID Jadwal         : ',jd[i].id_jadwal);
            writeln('Hari Pemesanan    : ',jd[i].hari);
            writeln('Tanggal Pemesanan : ',jd[i].tanggal);
            writeln('Jam Pemesanan     : ',jd[i].jam);
            writeln();
        end;
        write('Hit Any Key To Continue . . .');
        readkey;
        home;
    end;

procedure insert_customer(var cs : tabcustomer; var x : integer);
    var
        i : integer;
    begin
        clrscr;
        i := x + 1;
        writeln('>==============================<');
        writeln('>>>    INPUT DATA CUSTOMER    <<<');
        writeln('>==============================<');
        writeln();
        if (x < 100) then
            begin
                cs[i].id := i;
                write('Masukkan Nama : ');
                readln(cs[i].nama);
                write('Masukkan Alamat : ');
                readln(cs[i].alamat);
                x := x + 1;
                writeln();
                write('Data Berhasil Ditambah . . .');
            end
        else
            begin
                writeln('Maaf SYMMETRY BARBERSHOP Sudah Tutup . . .');
            end;
        Readkey;
        clrscr;
        home_customer;
    end;

procedure show_customer(var cs : tabcustomer; var x : integer);
    var
        i : integer;
    begin
        clrscr;
        i := 1;
        writeln();
        while (i <= x) do
        begin
            writeln;
            writeln('ID Kapster : ',cs[i].id);
            writeln('Nama       : ',cs[i].nama);
            writeln('Alamat     : ',cs[i].alamat);
            i := i+1;
        end;
        writeln();
        write('Hit Any Key To Continue . . .');
        Readkey;
        clrscr;
        home_customer;
    end;

procedure pemesanan(var kp : tabkapster; var pc : tabpaketcukur; var jd : tabjadwal; var cs : tabcustomer);
    var
        paket, nama_cus: string;
        id_jd, x : integer;
    begin
        clrscr;
        header;
        write('Masukkan Nama Customer : ');
        readln(nama_cus);
        x := cariCS(cs,nama_cus);
        if (x=-1) then
            begin
                writeln('Nama Customer Tidak Ditemukan, Silahkan Isi data Customer Terlebih Dahulu . . .');
                readkey;
                clrscr;
                home_customer;
            end
        else
            begin
                repeat
                    write('Masukkan ID Jadwal : ');
                    readln(id_jd);
                    x := cariJD(jd,id_jd);
                    if jd[x].sudah_dipesan then 
                        begin
                            writeln('Jadwal Sudah Di Booking, Silahkan Pilih Jadwal Lain . . .');
                        end
                    else if x=-1 then
                        begin
                            writeln('Jadwal Tidak tersedia');
                        end
                    else
                        begin
                            jd[x].sudah_dipesan := true;
                            allId[1] := x;
                            write('Masukkan ID Kapster Yang Dipilih : ');
                            readln(idk);
                            x := cariID(kp,idk);
                            if (x=-1) then
                                writeln('Kapster Tidak Ditemukan . . .')
                            else
                                allId[2] := x;
                                write('Masukkan ID Paket Cukur Yang Dipilih : ');
                                readln(paket);
                                x := cariPC(pc,paket);
                                if (x=-1) then
                                    writeln('Paket Cukur Tidak Tersedia . . .')
                                else
                                    allId[3] := x;
                        end;
                until ((not jd[x].sudah_dipesan) or (x<>-1));

            end;
            writeln();
            write('Pemesanan Berhasil . . .');
            Readkey;
            clrscr;
            home_customer;
    end;

procedure data_paket(var pc : tabpaketcukur);
    begin
        pc[1].id := '01';
        pc[1].paket := 'Potong Rambut';
        pc[1].biaya := 'Rp. 35.000';

        pc[2].id := '02';
        pc[2].paket := 'Potong Rambut + Cuci Rambut';
        pc[2].biaya := 'Rp. 40.000';

        pc[3].id := '03';
        pc[3].paket := 'Potong Rambut + Cuci Rambut + Pijat Kepala';
        pc[3].biaya := 'Rp. 45.000';
    end;

procedure paket_cukur(var pc : tabpaketcukur);
    var
            i : integer;
    begin
            clrscr;
            writeln('>===============================<');
            writeln('>>>        PAKET CUKUR        <<<');
            writeln('>===============================<');
            writeln();
            for i:=1 to 3 do
            begin
                writeln;
                writeln('PAKET ',i);
                writeln('ID Paket   : ',pc[i].id);
                writeln('Service    : ',pc[i].paket);
                writeln('Biaya      : ',pc[i].biaya);
            end;
            writeln();
            write('Hit Any Key To Continue . . .');
            Readkey;
            home_customer;
    end;

procedure sort_paket(pc : tabpaketcukur);
        var
                i, j, iMax: integer;
                temp: paketcukur;
        begin
                clrscr;
                for i:= 1 to 3-1 do
                begin
                        iMax := i;
                        for j:= i+1 to jumlah do
                        begin
                                if (pc[j].biaya > pc[iMax].biaya) then
                                        iMax:= j;
                        end;
                        temp:= pc[iMax];
                        pc[iMax]:= pc[i];
                        pc[i]:= temp;
                end;
                paket_cukur(pc);
        end;

procedure checkout(var cs : tabcustomer; var pc : tabpaketcukur; var jd : tabjadwal; var kp : tabkapster);
    var
        x : integer;
        nama_cus : string;
    begin
            clrscr;
            writeln('>===============================<');
            writeln('>>>        CHECKOUT        <<<');
            writeln('>===============================<');
            writeln();
            write('Masukkan Nama Customer : ');
            readln(nama_cus);
            writeln();
            x := cariCS(cs,nama_cus);
            if (x<>-1) then
                begin
                    writeln('===         Customer        ===');
                    writeln('ID Customer    : ',cs[x].id);
                    writeln('Nama           : ',cs[x].nama);
                    writeln('Alamat         : ',cs[x].alamat);
                    writeln();
                    writeln('===        Paket Cukur       ===');
                    writeln('PAKET ',allId[3]);
                    writeln('ID Paket       : ',pc[allId[3]].id);
                    writeln('Service        : ',pc[allId[3]].paket);
                    writeln('Biaya          : ',pc[allId[3]].biaya);
                    writeln();
                    writeln('===         Kapster          ===');
                    writeln('KAPSTER ',allId[2]);
                    writeln('ID Kapster : ',kp[allId[2]].id);
                    writeln('Nama       : ',kp[allId[2]].nama);
                    writeln('Spesialis  : ',kp[allId[2]].spesialis);
                    writeln();
                    writeln('===     Jadwal Pemesanan     ===');
                    writeln('ID Jadwal         : ',jd[allId[1]].id_jadwal);
                    writeln('Hari Pemesanan    : ',jd[allId[1]].hari);
                    writeln('Tanggal Pemesanan : ',jd[allId[1]].tanggal);
                    writeln('Jam Pemesanan     : ',jd[allId[1]].jam);
                    writeln();
                end
            else
                writeln('Data Customer Tidak Ditemukan . . .');
            write('Hit Any Key to Continue . . .');
            Readkey;
            home_customer;

    end;

procedure header;
    begin
        clrscr;
        writeln('=============================================');
        writeln('========== ^^SYMMETRY BARBERSHOP^^ ==========');
        writeln('=============================================');
        writeln();
    end;
// END PROCEDURE

// MAIN PROGRAM
begin
        clrscr;
        header;
        x := 0;
        writeln;
        writeln;
        data_paket(cuk);
        data_kapster(kap);
        jumlah := 3;
        home;
        readln;

end.
