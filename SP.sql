USE [QLVT]
GO
/****** Object:  StoredProcedure [dbo].[deleteDdh]    Script Date: 12/13/2022 12:09:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[deleteDdh]
@id int 
AS
begin

IF EXISTS ( SELECT * FROM dbo.CT_DDH WHERE MADDH = @id)
	begin
		return -1
	end
else
	begin
		DELETE FROM DONDH WHERE DONDH.MADDH=@id
		return 1
	end
end
GO
/****** Object:  StoredProcedure [dbo].[deleteHoaDon]    Script Date: 12/13/2022 12:09:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[deleteHoaDon]
@id int 
AS
begin

IF EXISTS ( SELECT * FROM dbo.CT_HOA_DON WHERE CT_HOA_DON.MAHD = @id)
	begin
		return -1
	end
else
	begin
		DELETE FROM HOA_DON WHERE HOA_DON.MAHD=@id
		return 1
	end
end
GO
/****** Object:  StoredProcedure [dbo].[deleteKH]    Script Date: 12/13/2022 12:09:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[deleteKH]
@id int 
AS
begin

IF EXISTS ( SELECT * FROM dbo.HOA_DON WHERE HOA_DON.MANV =@id )
	begin
		return -1
	end
else
	begin
		DELETE FROM KHACH_HANG WHERE KHACH_HANG.MAKH=@id
		return 1
	end
end
GO
/****** Object:  StoredProcedure [dbo].[deleteKho]    Script Date: 12/13/2022 12:09:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[deleteKho]
@id int 
AS
begin

IF EXISTS ( SELECT * FROM dbo.HOA_DON, PHIEU_NHAP WHERE HOA_DON.MAKHO = @id or PHIEU_NHAP.MAKHO = @id)
	begin
		return -1
	end
else
	begin
		DELETE FROM KHO WHERE KHO.MAKHO=@id
		return 1
	end
end
GO
/****** Object:  StoredProcedure [dbo].[deleteNV]    Script Date: 12/13/2022 12:09:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[deleteNV]
@id int 
AS
begin
DECLARE @USERNAME VARCHAR(10)
	DECLARE @LOGINNAME VARCHAR(30)
	DECLARE @RET INT

IF EXISTS ( SELECT * FROM dbo.HOA_DON, PHIEU_NHAP WHERE HOA_DON.MANV =@id or PHIEU_NHAP.MANV = @id)
	begin
		UPDATE NHAN_VIEN
		SET DA_XOA= 1
		WHERE NHAN_VIEN.MANV=@id
	end
else
	begin
		DELETE FROM NHAN_VIEN WHERE NHAN_VIEN.MANV=@id
	end
--delete acc login---
IF EXISTS(
	SELECT users.name, logins.name 
	FROM sys.database_principals AS users
	INNER JOIN sys.server_principals AS logins
	ON logins.sid = users.sid
	WHERE users.name = CONVERT(NVARCHAR(10), @id))
	BEGIN
		SELECT @USERNAME = users.name, @LOGINNAME = logins.name 
		FROM sys.database_principals AS users
		INNER JOIN sys.server_principals AS logins
		ON logins.sid = users.sid
		WHERE users.name = CONVERT(NVARCHAR(10), @id)
		IF(@@ROWCOUNT <> 0)
		
				EXEC @RET = SP_DROPLOGIN @LOGINNAME	
				IF(@RET = 1) RETURN 1

				EXEC @RET = SP_DROPUSER  @USERNAME
				IF(@RET = 1) RETURN 2
			
			RETURN 0 --Thành công
	END
end
GO
/****** Object:  StoredProcedure [dbo].[deletePhieuNhap]    Script Date: 12/13/2022 12:09:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[deletePhieuNhap]
@id int 
AS
begin

IF EXISTS ( SELECT * FROM dbo.CT_PHIEU_NHAP where SOPN=@id)
	begin
		return -1
	end
else
	begin
		DELETE FROM KHO WHERE KHO.MAKHO=@id
		return 1
	end
end
GO
/****** Object:  StoredProcedure [dbo].[deleteVatTu]    Script Date: 12/13/2022 12:09:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[deleteVatTu]
@id int 
AS
begin

IF EXISTS ( SELECT * FROM dbo.CT_HOA_DON, CT_DDH, CT_PHIEU_NHAP WHERE CT_HOA_DON.MAHH = @id or CT_DDH.MAHH = @id or CT_PHIEU_NHAP.MAHH = @id)
	begin
		return -1
	end
else
	begin
		DELETE FROM HANG_HOA WHERE HANG_HOA.MAHH=@id
		return 1
	end
end
GO
/****** Object:  StoredProcedure [dbo].[SaveCTHoaDon]    Script Date: 12/13/2022 12:09:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SaveCTHoaDon]
@mahd int,@mahh int , @sl int, @dongia int
AS
begin
	IF EXISTS ( SELECT * FROM dbo.CT_HOA_DON k WHERE k.mahd=@mahd and k.MAHH=@mahh)
	begin
		UPDATE CT_HOA_DON
		SET  SO_LUONG=SO_LUONG+@sl, DON_GIA=@dongia
		WHERE MAHD=@mahd and mahh=@mahh
	end
	else
	begin
	INSERT INTO CT_HOA_DON(mahd, mahh, SO_LUONG, DON_GIA)
	VALUES (@mahd, @mahh, @sl, @dongia  )
	end
end
GO
/****** Object:  StoredProcedure [dbo].[SaveHoaDon]    Script Date: 12/13/2022 12:09:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[SaveHoaDon]
@manv int,@makh int , @makho int
AS
begin
	INSERT INTO HOA_DON(manv,makh, makho)
	VALUES (@manv, @makh, @makho  )
end
GO
/****** Object:  StoredProcedure [dbo].[SaveKH]    Script Date: 12/13/2022 12:09:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SaveKH]
 @tenkh nvarchar(50), @diachi nvarchar(50), @sdt nchar(15), @macn nchar(10) 
AS
begin
	IF EXISTS ( SELECT * FROM dbo.KHACH_HANG k WHERE k.SDT=@sdt)
		return -1
	else 
	begin
		INSERT INTO KHACH_HANG(TENKH, DIACHI, SDT, MACN)
		VALUES (@tenkh , @diachi, @sdt , @macn  )
		return 1
	end
end
GO
/****** Object:  StoredProcedure [dbo].[SaveKho]    Script Date: 12/13/2022 12:09:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[SaveKho]
 @tenKho nvarchar(50), @macn nchar(10) 
AS
begin
	IF EXISTS ( SELECT * FROM dbo.KHO k WHERE k.tenkho=@tenKho)
		return -1
	else 
	begin
		INSERT INTO KHO(TENKHO, MACN)
		VALUES (@tenKho , @macn  )
		return 1
	end
end
GO
/****** Object:  StoredProcedure [dbo].[SaveVatTu]    Script Date: 12/13/2022 12:09:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[SaveVatTu]
 @ten nvarchar(50),@dvt nvarchar(10),@malhh nchar(10), @sl int
AS
begin
	IF EXISTS ( SELECT * FROM dbo.HANG_HOA k WHERE k.TENHH=@ten)
		return -1
	else 
	begin
		INSERT INTO HANG_HOA(TENHH, DVT, SO_LUONG_TON, MALHH)
		VALUES (@ten , @Dvt, @sl, @malhh)
		return 1
	end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_DANGNHAP]    Script Date: 12/13/2022 12:09:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_DANGNHAP]
@TENLOGIN NVARCHAR (50)
AS
DECLARE @TENUSER NVARCHAR(50)
SELECT @TENUSER=NAME FROM sys.sysusers WHERE sid = SUSER_SID(@TENLOGIN)
 
 SELECT USERNAME = @TENUSER, 
  HOTEN = (SELECT HO+ ' '+ TEN FROM NHAN_VIEN  WHERE MANV = @TENUSER ),
   TENNHOM= NAME
   FROM sys.sysusers 
   WHERE UID = (SELECT GROUPUID 
                 FROM SYS.SYSMEMBERS 
                   WHERE MEMBERUID= (SELECT UID FROM sys.sysusers 
                                      WHERE NAME=@TENUSER))
GO
/****** Object:  StoredProcedure [dbo].[SP_DS_DDH_PN]    Script Date: 12/13/2022 12:09:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_DS_DDH_PN]
AS
 SELECT DH.MADDH, DH.NGAY_LAP,DH.MANCC,
	HOTENNV = (SELECT HO + ' ' + TEN FROM NHAN_VIEN WHERE MANV = DH.MANV), 
	TENVT = (SELECT VT.TENHH FROM HANG_HOA AS VT WHERE VT.MAHH = CT_DDH.MAHH), 
	CT_DDH.SO_LUONG, CT_DDH.DON_GIA
	FROM CT_DDH
		INNER JOIN
		(SELECT MADDH, NGAY_LAP,MANCC, MANV FROM DONDH WHERE MADDH NOT IN( SELECT MADDH FROM PHIEU_NHAP)) AS DH
	ON DH.MADDH = CT_DDH.MADDH

GO
/****** Object:  StoredProcedure [dbo].[SP_SaveNV]    Script Date: 12/13/2022 12:09:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_SaveNV]
@ho NVARCHAR (50), @ten NVARCHAR (50), @phai NVARCHAR (50),@NGAY_SINH NVARCHAR (50),
@SDT NVARCHAR (50),@DIA_CHI NVARCHAR (50), @MACN NVARCHAR (50)
AS

INSERT INTO NHAN_VIEN(HO, TEN, PHAI,NGAY_SINH, SDT, DIA_CHI,MACN)
VALUES (@HO, @TEN, @PHAI, @NGAY_SINH, @SDT,@DIA_CHI, @MACN)
GO
/****** Object:  StoredProcedure [dbo].[UpdateCTHoaDon]    Script Date: 12/13/2022 12:09:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[UpdateCTHoaDon]
@mahd int,@mahh int , @sl int, @dongia int
AS
begin
	IF EXISTS ( SELECT * FROM dbo.CT_HOA_DON k WHERE k.mahd=@mahd and k.MAHH=@mahh)
	begin
		UPDATE CT_HOA_DON
		SET  SO_LUONG=@sl, DON_GIA=@dongia
		WHERE MAHD=@mahd and mahh=@mahh
		return 1
	end
	else
	return -1
end
GO
/****** Object:  StoredProcedure [dbo].[UpdateHoaDon]    Script Date: 12/13/2022 12:09:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[UpdateHoaDon]
@id int, @manv int,@makh int , @makho int
 AS
begin
	IF EXISTS ( SELECT * FROM dbo.HOA_DON k WHERE k.MAHD=@id)
		return -1
	else 
	begin
		UPDATE HOA_DON
		SET MAKH=@makh, @makho=@makho, manv=@manv
		WHERE MAHD=@id
		return 1
	end
end
GO
/****** Object:  StoredProcedure [dbo].[UpdateKH]    Script Date: 12/13/2022 12:09:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[UpdateKH]
 @id int, @tenkh nvarchar(50), @diachi nvarchar(50), @sdt nchar(15), @macn nchar(10) 
AS
begin
	IF EXISTS ( SELECT * FROM dbo.KHACH_HANG k WHERE k.MAKH=@id)
		return 0
	IF EXISTS ( SELECT * FROM dbo.KHACH_HANG k WHERE k.SDT=@sdt)
		return -1
	else 
	begin
		UPDATE KHACH_HANG
		SET tenkh=@tenkh, diachi=@diachi, sdt=@sdt
		WHERE MAKH=@id
		return 1
	end
end
GO
/****** Object:  StoredProcedure [dbo].[UpdateKHO]    Script Date: 12/13/2022 12:09:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[UpdateKHO]
 @id int, @ten nvarchar(50) 
AS
begin
	IF EXISTS ( SELECT * FROM dbo.KHACH_HANG k WHERE k.MAKH=@id)
		return 0 
	begin
		UPDATE KHO
		SET tenkho=@ten
		WHERE MAKHO=@id
		return 1
	end
end
GO
/****** Object:  StoredProcedure [dbo].[UpdateNV]    Script Date: 12/13/2022 12:09:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[UpdateNV]
@id NVARCHAR (50), @ho NVARCHAR (50), @ten NVARCHAR (50), @phai NVARCHAR (50),@NGAY_SINH NVARCHAR (50),
@SDT NVARCHAR (50),@DIA_CHI NVARCHAR (50), @MACN NVARCHAR (50)
AS

UPDATE NHAN_VIEN
SET ho=ho, ten=@ten, phai=@phai, NGAY_SINH=NGAY_SINH, SDT=@SDT,DIA_CHI=@DIA_CHI, MACN=@MACN
WHERE MANV=@id
GO
/****** Object:  StoredProcedure [dbo].[UpdateVatTu]    Script Date: 12/13/2022 12:09:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[UpdateVatTu]
 @id int, @ten nvarchar(50),@dvt nvarchar(10), @sl int, @maloai nchar(10)
AS
begin
	IF EXISTS ( SELECT * FROM dbo.HANG_HOA k WHERE k.MAHH= @id )
		return 0
	IF EXISTS ( SELECT * FROM dbo.HANG_HOA k WHERE k.TENHH = @ten)
		return -1
	else 
	begin
		UPDATE HANG_HOA
		SET TENHH = @ten, DVT = @dvt, SO_LUONG_TON = @sl, MALHH = @maloai
		WHERE MAHH = @id
		return 1
	end
end
GO
