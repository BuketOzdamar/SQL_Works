----- DDL KOMUTLARI ------

--create database dbSatisVT
--use dbSatisVT

--create table TBLKATEGORÝ
--	(KATEGORÝID tinyint identity(1,1) primary key,
--	 KATEGORÝAD varchar(50)
--	)

--create table TBLURUNLER
--	(
--	 URUNLERID tinyint identity(1,1) primary key,
--	 URUNLERÝAD varchar(50),
--	 URUNMARKA varchar(50),
--	 URUNKATEGORÝ tinyint,
--	 URUNALISF decimal(18,2),
--	 URUNSATISF decimal(18,2),
--	 URUNSTOK smallint check(URUNSTOK>0),
--	 URUNDURUM bit default '1'
--	)

--create table TBLPERSONEL
--(	
--	PERSONELID smallint identity(1,1) primary key,
--	PERSONELADSOYAD varchar(50)
--)

--create table TBLMUSTERÝ
--(	
--	MUSTERÝID int primary key identity(1,1),
--	MUSTERÝAD varchar(50),
--	MUSTERÝSOYAD varchar(50),
--	MUSTERÝSEHÝR varchar(13),
--	MUSTERÝBAKÝYE decimal(18,2)
--)

--create table TBLHAREKET
--(	
--	HAREKETID int primary key identity(1,1),
--	URUN int,
--	MUSTERÝ int,
--	PERSONEL smallint,
--	ADET int,
--	TUTAR decimal(18,2),
--	TARÝH smalldatetime
--)

--TRUNCATE table TBLURUNLER -- tablo sýfýrlandý.

----- DML KOMUTLARI ------

--i
--insert into TBLURUNLER(URUNLERÝAD, URUNMARKA,URUNKATEGORÝ,URUNALISF, URUNSATISF,URUNSTOK) values ('buzdolabý','siemens',2,4356,4588,10)

--update TBLURUNLER set URUNAD='kettle' where URUNAD='su ýsýtýcýsý'

-------------------------------------------------------------------
--select KATEGORÝAD, count(*) as 'toplam ürün' from TBLURUNLER
--inner join 
--TBLKATEGORÝ
--on
--TBLURUNLER.URUNKATEGORÝ=TBLKATEGORÝ.KATEGORÝID
--group by KATEGORÝAD 
--order by count(*)
--------------------------------------------------------------------

-- kategori adý bilgisayar olan ürünlerin satýþ fiyatýna 500 tl zam
--update TBLURUNLER set URUNSATISF+=500 where URUNKATEGORÝ=(select KATEGORÝID from TBLKATEGORÝ where KATEGORÝAD='bilgisayar')

-- tv kategorisindeki ürünlere %10 indirim. --
--select URUNAD, URUNALISF, URUNSATISF, URUNDURUM from TBLURUNLER 
--update TBLURUNLER set URUNSATISF=(URUNSATISF*10)/100+URUNSATISF
--where URUNKATEGORÝ = (select KATEGORÝID from TBLKATEGORÝ where KATEGORÝAD = 'TV')

--select count(*) as'kaç farklý ürün', sum(urunstok) as 'stok sayýsý' from TBLURUNLER 

--stoktaki bütün ürünleri satarsak kaç para kazanýrýz?
--select URUNID, URUNAD, URUNMARKA, KATEGORÝID, URUNALISF, URUNSATISF,
--(URUNSATISF-URUNALISF)as'kar',
--(URUNSATISF-URUNALISF)*URUNSTOK as 'toplam kar' from TBLURUNLER
--inner join
--TBLKATEGORÝ
--on TBLURUNLER.URUNKATEGORÝ=TBLKATEGORÝ.KATEGORÝID

-- Toplam karý 1000 tlnin altýnda kalana 500 tl zam.
--select URUNID, URUNAD, URUNMARKA, URUNALISF, URUNSATISF, (URUNSATISF - URUNALISF) * URUNSTOK as 'toplam kar' 
--update TBLURUNLER set URUNSATISF+=500
--from TBLURUNLER
--inner join TBLKATEGORÝ
--on TBLURUNLER.URUNKATEGORÝ = TBLKATEGORÝ.KATEGORÝID
--where (URUNSATISF - URUNALISF) * URUNSTOK < 1000;

---------------------------------------------- PROSEDÜR KULLANIMI ------------------------------

--create procedure HAREKETLER 
--as
--select HAREKETID, URUNAD, MUSTERÝAD + ' ' + MUSTERÝSOYAD as 'AD SOYAD', PERSONELADSOYAD, ADET, TUTAR, TARÝH
--from TBLHAREKET 
--inner join TBLURUNLER
--on TBLHAREKET.URUN=TBLURUNLER.URUNID
--inner join TBLMUSTERÝ
--on TBLHAREKET.MUSTERÝ=TBLMUSTERÝ.MUSTERÝID
--inner join TBLPERSONEL
--on TBLHAREKET.PERSONEL=TBLPERSONEL.PERSONELID

--execute HAREKETLER -- kaydettiðiiz prosedürü kullanýyoruz. 

--------------------------------------------- prosedür silme --------------------------------------
--create procedure DENEME
--as
--select * from TBLURUNLER where URUNSTOK>10
--exec DENEME

--drop procedure DENEME

------------------------------------------- PROSEDÜR GÜNCELLEME ----------------------------------
--alter procedure HAREKETLER 
--as
--select HAREKETID, URUNAD, left(MUSTERÝAD,1) + '.' + MUSTERÝSOYAD as 'AD SOYAD', PERSONELADSOYAD, ADET, TUTAR, TARÝH
--from TBLHAREKET 
--inner join TBLURUNLER
--on TBLHAREKET.URUN=TBLURUNLER.URUNID
--inner join TBLMUSTERÝ
--on TBLHAREKET.MUSTERÝ=TBLMUSTERÝ.MUSTERÝID
--inner join TBLPERSONEL
--on TBLHAREKET.PERSONEL=TBLPERSONEL.PERSONELID

--exec HAREKETLER

--alter procedure URUNGETÝR
--@DEGER varchar(50)='buzdolabý' --þartlý prosedür. 
--as
--select URUNAD, URUNSTOK, URUNMARKA from TBLURUNLER
--where URUNAD=@DEGER

--execute URUNGETÝR @DEGER='çamaþýr makinesi' 

--------------------------------------------- DATEPART KULLANMI -------------------------------
--select * from TBLHAREKET where DATEPART (day,TARÝH) between 3 and 5 and MUSTERÝ=1

--select * from TBLHAREKET where DATEPART(day, TARÝH) between 1 and 3 and
--MUSTERÝ=(select MUSTERÝID FROM TBLMUSTERÝ where MUSTERÝSEHÝR='ankara'

--select DATENAME (month, getdate()), datename(month, '2019.01.15')
--select DATENAME(WEEKDAY, getdate())

---------------------------------------------- DateDiff ---------------------------------------
--select DATEDIFF(year, '2010.10.25',getdate()) -- verilen tarihle bulunduðumuz tarih arasýnda geçen yýlý bize verir.
--select DATEDIFF(month,'2010.06.01', getdate()) -- verilen tarihle günümüz tarihinin ay olarak farkýný verir
--select DATEDIFF(day, TARÝH, getdate()) from TBLHAREKET where HAREKETID=1

---------------------------------------------- DATEADD ---------------------------------------

--select DATEADD(year,3,'2009.10.25') --verilen tarihin üstine istenen yýlý ekler.
--select DATEADD(day,3,'2009.10.25') --verilen tarihin üstine istenen günü ekler.
--select DATEADD(month,3,'2009.10.25') --verilen tarihin üstine istenen ayý ekler.

----------------------------------------------- ALT SORGU ÇALIÞMASI ----------------------------------
--select URUNAD, count(*) as 'ürün ad' from TBLHAREKET
--inner join TBLURUNLER on TBLHAREKET.URUN=TBLURUNLER.URUNID
--group by URUNAD 

----- ürünler tablosunda sadece bilgisayar satýlan ürünleri hareket tablosundan getir.
--select * from TBLHAREKET where URUN in(select URUNID from TBLURUNLER where URUNKATEGORÝ=1)

--select * from TBLHAREKET where MUSTERÝ in(select MUSTERÝID from TBLMUSTERÝ where MUSTERÝSEHÝR='adana')

--select * from TBLHAREKET where URUN in(select URUNID from TBLURUNLER 
--where URUNKATEGORÝ=(select KATEGORÝID from TBLKATEGORÝ where KATEGORÝAD='beyaz eþya'))

--select SUM(TUTAR) from TBLHAREKET 
--where MUSTERÝ in(select musteriýd from TBLMUSTERÝ where MUSTERÝSEHÝR='adana'or MUSTERÝSEHÝR='ankara')

----- satýlan bir ürünün stoðu nasýl azaltýlýr?
--select * from TBLHAREKET where URUN=1
--update TBLURUNLER set URUNSTOK=URUNSTOK-(select SUM(ADET) from TBLHAREKET where URUN=10) where URUNID=10

------------------------------------------------- kasa tablosu ------------------------------------------------------
--create table TBLKASA(
--	toplam decimal(18,2))

--insert into TBLKASA values (0)
--select * from TBLKASA

--update TBLKASA set TOPLAM=(select SUM(TUTAR) from TBLHAREKET) -- hareket tablosunda harcanan para kasa tablosunda kullanýlýr.
--select * from TBLKASA

-------------------------------------------------- TRIGGER OLUÞTURMA ---------------------------------------------
-- örneðin hareket tablosunda bir ürün satýldýðý anda urunler tablosundan otomatik olarak stoktan düþülmesini saðlar.

--create table TBLSAYAC(
--	ISLEM int)

--insert into TBLSAYAC values(0)

--update TBLSAYAC set ISLEM=(select COUNT(*) from TBLHAREKET)

----- hareket tablosuna veri giriþi yaptýðýmýz anda sayaç tablsounda artýþ olmalý. bunun için tetikleyici oluþturacaðýz.
--create trigger ISLEMARTIS
--on TBLHAREKET -- hareket tablsounda
--after insert -- insert yapýldýktan sonra yani veri girildikten sonra
--as 
--update TBLSAYAC set ISLEM=ISLEM+1 -- ne yapýlacak? iþlem 1 arttýrýlacak.

--create table TBLTOPLAMKATEGORI(
--	ADET tinyint)
	 
--update TBLTOPLAMKATEGORI set adet=(select count(*) from TBLKATEGORÝ)

--create trigger KATEGORIARTIS1
--on TBLKATEGORÝ
--after insert
--as 
--update TBLTOPLAMKATEGORI set ADET+=1

--create trigger KATEGORIAZALIS1
--on TBLKATEGORÝ
--after delete
--as
--update TBLTOPLAMKATEGORI set ADET-=1

---------------------------------------------------------- VÝEV OLUÞTURMA ----------------------------------------------------------
--create view TEST1
--as
--select * from TBLKATEGORÝ

--select * from TEST1

--alter view TEST1
--as 
--select * from TBLKATEGORÝ where KATEGORÝID<4

--select * from TEST1

---------------------------------------------------------- VIEW SÝHÝRBAZ ----------------------------------------------------------
--select * from TEST1

--select * from TEST3











