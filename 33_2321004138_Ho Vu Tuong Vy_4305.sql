/* 1. KhachHang */
CREATE TABLE KhachHang (
    MaKH VARCHAR(20) PRIMARY KEY NOT NULL,
    TenKH NVARCHAR(150) NOT NULL,
    SDT VARCHAR(20) NOT NULL,
    CCCD VARCHAR(20) UNIQUE NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    NgaySinh DATE NOT NULL,
    GioiTinh NVARCHAR(10) NOT NULL CHECK (GioiTinh IN (N'Nam', N'Nữ'))
);

/* 2. TaiKhoanNganHang */
CREATE TABLE TaiKhoanNganHang (
    MaTKNH VARCHAR(20) PRIMARY KEY NOT NULL,
    TenChuTK NVARCHAR(150) NOT NULL,
    SoTK VARCHAR(50) NOT NULL,
    TenNH NVARCHAR(100) NOT NULL,
    ChiNhanh NVARCHAR(150) NOT NULL
);

/* 3. HoSoDonViToChuc */
CREATE TABLE HoSoDonViToChuc (
    MaHS VARCHAR(20) PRIMARY KEY NOT NULL,
    TenDonVi NVARCHAR(150) NOT NULL,
    MaSoDK VARCHAR(20) NOT NULL,
    SDTDVTC VARCHAR(20) NOT NULL,
    Email_DVTC NVARCHAR(100) NOT NULL,
    DiaChi_DVTC NVARCHAR(150) NOT NULL,
    MaTKNH VARCHAR(20) NOT NULL,
    FOREIGN KEY (MaTKNH) REFERENCES TaiKhoanNganHang(MaTKNH)
);

/* 4. NhaToChucSuKien */
CREATE TABLE NhaToChucSuKien (
    MaNTC VARCHAR(20) PRIMARY KEY NOT NULL,
    TenNTC NVARCHAR(150) NOT NULL,
    SDTNTC VARCHAR(20) NOT NULL,
    EmailNTC NVARCHAR(100) NOT NULL,
    MaHS VARCHAR(20) NOT NULL,
    FOREIGN KEY (MaHS) REFERENCES HoSoDonViToChuc(MaHS)
);

/* 5. LoaiSuKien */
CREATE TABLE LoaiSuKien (
    MaLoaiSK VARCHAR(20) PRIMARY KEY NOT NULL,
    TenLoaiSK NVARCHAR(150) NOT NULL,
    MoTa NVARCHAR(200) NOT NULL
);

/* 6. DSLoaiSuKien */
CREATE TABLE DSLoaiSuKien (
    MaDS VARCHAR(20) PRIMARY KEY NOT NULL,
    TenDS NVARCHAR(200) NOT NULL,
    MaLoaiSK VARCHAR(20) NOT NULL,
    FOREIGN KEY (MaLoaiSK) REFERENCES LoaiSuKien(MaLoaiSK)
);

/* 7. SuKien */
CREATE TABLE SuKien (
    MaSK VARCHAR(20) PRIMARY KEY NOT NULL,
    TenSK NVARCHAR(150) NOT NULL,
    TenDiaDiem NVARCHAR(150) NOT NULL,
    DiaChi NVARCHAR(150) NOT NULL,
    NgayBD DATE NOT NULL,
    NgayKT DATE NOT NULL,
    TrangThaiDuyet NVARCHAR(100) NOT NULL,
    MaLoaiSK VARCHAR(20) NOT NULL,
    MaNTC VARCHAR(20) NOT NULL,
    MaDS VARCHAR(20) NOT NULL,
    FOREIGN KEY (MaLoaiSK) REFERENCES LoaiSuKien(MaLoaiSK),
    FOREIGN KEY (MaNTC) REFERENCES NhaToChucSuKien(MaNTC),
    FOREIGN KEY (MaDS) REFERENCES DSLoaiSuKien(MaDS),
    CHECK (NgayKT >= NgayBD)
);

/* 8. HangVe */
CREATE TABLE HangVe (
    MaHV VARCHAR(20) PRIMARY KEY NOT NULL,
    TenHV NVARCHAR(50) NOT NULL,
    GiaHV DECIMAL(10,2) NOT NULL CHECK (GiaHV > 0),
    SoLuongVe INT NOT NULL CHECK (SoLuongVe >= 0),
    MaSK VARCHAR(20) NOT NULL,
    FOREIGN KEY (MaSK) REFERENCES SuKien(MaSK)
);

/* 9. ThanhVien */
CREATE TABLE ThanhVien (
    MaTV VARCHAR(20) PRIMARY KEY NOT NULL,
    EmailTV NVARCHAR(100) NOT NULL,
    SDTTV VARCHAR(20) NOT NULL,
    Password VARCHAR(50) NOT NULL,
    TrangThai NVARCHAR(50) NOT NULL,
    MaKH VARCHAR(20) NOT NULL,
    FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH)
);

/* 10. PhieuDatVe */
CREATE TABLE PhieuDatVe (
    MaPDV VARCHAR(50) PRIMARY KEY NOT NULL,
    NgayDat DATE NOT NULL,
    TrangThaiDon NVARCHAR(20) NOT NULL CHECK (TrangThaiDon IN (N'Chờ xử lý', N'Đã xác nhận', N'Đã hủy')),
    PhuongThucThanhToan NVARCHAR(20) NOT NULL,
    MaTV VARCHAR(20) NOT NULL,
    FOREIGN KEY (MaTV) REFERENCES ThanhVien(MaTV)
);

/* 11. HoaDon */
CREATE TABLE HoaDon (
    MaHD VARCHAR(20) PRIMARY KEY NOT NULL,
    NgayLapHD DATE NOT NULL,
    ThanhTien DECIMAL(10,2) NOT NULL,
    MaPDV VARCHAR(50) NOT NULL,
    FOREIGN KEY (MaPDV) REFERENCES PhieuDatVe(MaPDV)
);

/* 12. Ve */
CREATE TABLE Ve (
    MaVe VARCHAR(20) PRIMARY KEY NOT NULL,
    GiaVe DECIMAL(10,2) NOT NULL,
    TrangThaiVe NVARCHAR(50) NOT NULL CHECK (TrangThaiVe IN (N'Còn', N'Đã bán')),
    MaQRVe VARCHAR(50) NOT NULL,
    MaHV VARCHAR(20) NOT NULL,
    MaHD VARCHAR(20) NOT NULL,
    FOREIGN KEY (MaHV) REFERENCES HangVe(MaHV),
    FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD)
);

/* 13. YeuCauHuyVe */
CREATE TABLE YeuCauHuyVe (
    MaYC VARCHAR(20) PRIMARY KEY NOT NULL,
    NgayYC DATE NOT NULL,
    LyDo NVARCHAR(200) NOT NULL,
    TrangThaiYC NVARCHAR(20) NOT NULL,
    MaVe VARCHAR(20) NOT NULL,
    MaTV VARCHAR(20) NOT NULL,
    FOREIGN KEY (MaVe) REFERENCES Ve(MaVe),
    FOREIGN KEY (MaTV) REFERENCES ThanhVien(MaTV)
);

/* 14. QuanTriVien */
CREATE TABLE QuanTriVien (
    MaQTV VARCHAR(20) PRIMARY KEY NOT NULL,
    TenQTV NVARCHAR(50) NOT NULL,
    EmailQTV NVARCHAR(100) NOT NULL,
    MatKhauQTV VARCHAR(50) NOT NULL
);
/* ==================== 1. KhachHang ==================== */
INSERT INTO KhachHang(MaKH, TenKH, SDT, CCCD, Email, NgaySinh, GioiTinh)
VALUES
('KH01', N'Lê Minh Khôi', '0901111111', '123456789001', 'a@gmail.com', '1990-01-01', N'Nam'),
('KH02', N'Nguyễn Thị Lan', '0902222222', '123456789002', 'b@gmail.com', '1991-02-02', N'Nữ'),
('KH03', N'Trần Quốc Huy', '0903333333', '123456789003', 'c@gmail.com', '1992-03-03', N'Nam'),
('KH04', N'Phạm Ngọc Anh', '0904444444', '123456789004', 'd@gmail.com', '1993-04-04', N'Nữ'),
('KH05', N'Huỳnh Văn Tài', '0905555555', '123456789005', 'e@gmail.com', '1994-05-05', N'Nam'),
('KH06', N'Lý Thu Hà', '0906666666', '123456789006', 'f@gmail.com', '1995-06-06', N'Nữ'),
('KH07', N'Bùi Quang Vinh', '0907777777', '123456789007', 'g@gmail.com', '1996-07-07', N'Nam'),
('KH08', N'Đỗ Thị Mai', '0908888888', '123456789008', 'h@gmail.com', '1997-08-08', N'Nữ'),
('KH09', N'Vũ Hồng Phúc', '0909999999', '123456789009', 'i@gmail.com', '1998-09-09', N'Nam'),
('KH10', N'Ngô Thị Yến', '0910000000', '123456789010', 'j@gmail.com', '1999-10-10', N'Nữ'),
('KH11', N'Nguyễn Thành Đạt', '0911111111', '123456789011', 'k@gmail.com', '2000-11-11', N'Nam'),
('KH12', N'Trần Bích Ngọc', '0912222222', '123456789012', 'l@gmail.com', '2001-12-12', N'Nữ'),
('KH13', N'Lê Hoàng Nam', '0913333333', '123456789013', 'm@gmail.com', '2002-01-13', N'Nam'),
('KH14', N'Phạm Thị Minh', '0914444444', '123456789014', 'n@gmail.com', '2003-02-14', N'Nữ'),
('KH15', N'Hồ Văn Lâm', '0915555555', '123456789015', 'o@gmail.com', '2004-03-15', N'Nam'),
('KH16', N'Ngô Thị Phương', '0916666666', '123456789016', 'p@gmail.com', '2005-04-16', N'Nữ'),
('KH17', N'Bùi Văn Quân', '0917777777', '123456789017', 'q@gmail.com', '2006-05-17', N'Nam'),
('KH18', N'Đỗ Thị Thu', '0918888888', '123456789018', 'r@gmail.com', '2007-06-18', N'Nữ'),
('KH19', N'Vũ Văn Sơn', '0919999999', '123456789019', 's@gmail.com', '2008-07-19', N'Nam'),
('KH20', N'Phạm Thị Trang', '0920000000', '123456789020', 't@gmail.com', '2009-08-20', N'Nữ');
SELECT * FROM dbo.KhachHang;
/* ==================== 2. TaiKhoanNganHang (5 dòng) ==================== */
INSERT INTO TaiKhoanNganHang (MaTKNH, TenChuTK, SoTK, TenNH, ChiNhanh)
VALUES
('TKNH01', N'Nguyễn Văn A', '001', N'Vietcombank', N'CN1'),
('TKNH02', N'Trần Thị B', '002', N'Vietinbank', N'CN2'),
('TKNH03', N'Lê Văn C', '003', N'BIDV', N'CN3'),
('TKNH04', N'Phạm Thị D', '004', N'ACB', N'CN4'),
('TKNH05', N'Hoàng Văn E', '005', N'Techcombank', N'CN5');
SELECT * FROM dbo.TaiKhoanNganHang;
/* ==================== Bảng 3: HoSoDonViToChuc (5 dòng) ==================== */
INSERT INTO HoSoDonViToChuc (MaHS, TenDonVi, MaSoDK, SDTDVTC, Email_DVTC, DiaChi_DVTC, MaTKNH)
VALUES
('HS01', N'Công Ty Tổ Chức Sự Kiện Hoa Sen', 'DK01', '0911111111', 'lienhe@hoasen.com', N'123 Lý Thường Kiệt, Hà Nội', 'TKNH01'),
('HS02', N'Trung Tâm Văn Hóa Quang Minh', 'DK02', '0912222222', 'contact@quangminh.vn', N'45 Nguyễn Huệ, TP. Hồ Chí Minh', 'TKNH02'),
('HS03', N'Công Ty TNHH Giải Trí Ánh Dương', 'DK03', '0913333333', 'info@anhduong.vn', N'78 Trần Phú, Đà Nẵng', 'TKNH03'),
('HS04', N'Trung Tâm Hội Nghị Sài Gòn', 'DK04', '0914444444', 'support@hnsghcm.com', N'12 Cách Mạng Tháng 8, TP. Hồ Chí Minh', 'TKNH04'),
('HS05', N'Công Ty Tổ Chức Sự Kiện Việt Star', 'DK05', '0915555555', 'event@vietstar.com', N'56 Hai Bà Trưng, Hà Nội', 'TKNH05');
SELECT * FROM dbo.HoSoDonViToChuc;
/* ==================== Bảng 4: NhaToChucSuKien (5 dòng) ==================== */
INSERT INTO NhaToChucSuKien (MaNTC, TenNTC, SDTNTC, EmailNTC, MaHS)
VALUES
('NTC01', N'Công Ty Tổ Chức Sự Kiện Hoa Sen', '0901111111', 'lienhe@hoasen.com', 'HS01'),
('NTC02', N'Trung Tâm Văn Hóa Quang Minh', '0902222222', 'contact@quangminh.vn', 'HS02'),
('NTC03', N'Công Ty TNHH Giải Trí Ánh Dương', '0903333333', 'info@anhduong.vn', 'HS03'),
('NTC04', N'Trung Tâm Hội Nghị Sài Gòn', '0904444444', 'support@hnsghcm.com', 'HS04'),
('NTC05', N'Công Ty Tổ Chức Sự Kiện Việt Star', '0905555555', 'event@vietstar.com', 'HS05');
SELECT * FROM dbo.NhaToChucSuKien;
/* ==================== Bảng 5: LoaiSuKien (5 dòng) ==================== */
INSERT INTO LoaiSuKien (MaLoaiSK, TenLoaiSK, MoTa)
VALUES
('LSK01', N'Thể Thao', N'Sự kiện liên quan đến các môn thể thao, giải đấu và hoạt động vận động.'),
('LSK02', N'Âm Nhạc', N'Sự kiện ca nhạc, hòa nhạc, biểu diễn nghệ thuật âm nhạc.'),
('LSK03', N'Hội Chợ', N'Sự kiện triển lãm, hội chợ thương mại hoặc giới thiệu sản phẩm.'),
('LSK04', N'Hội Thảo', N'Sự kiện trao đổi kiến thức, thảo luận chuyên môn hoặc đào tạo.'),
('LSK05', N'Lễ Hội', N'Sự kiện văn hóa, lễ hội truyền thống hoặc lễ kỷ niệm đặc biệt.');
SELECT * FROM dbo.LoaiSuKien;
/* ==================== Bảng 6: DSLoaiSuKien (5 dòng) ==================== */
INSERT INTO DSLoaiSuKien (MaDS, TenDS, MaLoaiSK)
VALUES
('DS01', N'Danh Sách Thể Thao', 'LSK01'),
('DS02', N'Danh Sách Âm Nhạc', 'LSK02'),
('DS03', N'Danh Sách Hội Chợ', 'LSK03'),
('DS04', N'Danh Sách Hội Thảo', 'LSK04'),
('DS05', N'Danh Sách Lễ Hội', 'LSK05');
SELECT * FROM dbo.DSLoaiSuKien;
/* ==================== Bảng 7: SuKien (10 dòng) ==================== */
INSERT INTO SuKien (MaSK, TenSK, TenDiaDiem, DiaChi, NgayBD, NgayKT, TrangThaiDuyet, MaLoaiSK, MaNTC, MaDS)
VALUES
('SK01', N'Giải Bóng Đá Mùa Hè 2025', N'Sân Vận Động Quốc Gia', N'1 Đường Láng, Hà Nội', '2025-08-01', '2025-08-05', N'Đã duyệt', 'LSK01', 'NTC01', 'DS01'),
('SK02', N'Đêm Nhạc Trịnh Công Sơn', N'Nhà Hát Lớn Hà Nội', N'1 Tràng Tiền, Hà Nội', '2025-08-03', '2025-08-07', N'Đã duyệt', 'LSK02', 'NTC02', 'DS02'),
('SK03', N'Hội Chợ Triển Lãm Công Nghệ', N'Trung Tâm Hội Chợ Triển Lãm Sài Gòn', N'799 Nguyễn Văn Linh, TP.HCM', '2025-08-05', '2025-08-09', N'Đã duyệt', 'LSK03', 'NTC03', 'DS03'),
('SK04', N'Hội Thảo Kinh Doanh Quốc Tế', N'Khách Sạn Rex', N'141 Nguyễn Huệ, TP.HCM', '2025-08-07', '2025-08-11', N'Đã duyệt', 'LSK04', 'NTC04', 'DS04'),
('SK05', N'Lễ Hội Văn Hóa Truyền Thống', N'Quảng Trường Ba Đình', N'Ba Đình, Hà Nội', '2025-08-09', '2025-08-13', N'Đã duyệt', 'LSK05', 'NTC05', 'DS05'),
('SK06', N'Giải Tennis Mùa Hè', N'Sân Tennis Hồ Tây', N'Ngõ 264 Lạc Long Quân, Hà Nội', '2025-08-10', '2025-08-14', N'Đã duyệt', 'LSK01', 'NTC01', 'DS01'),
('SK07', N'Đêm Nhạc Jazz Quốc Tế', N'Nhà Hát Thành Phố', N'7 Công Trường Lam Sơn, TP.HCM', '2025-08-11', '2025-08-15', N'Đã duyệt', 'LSK02', 'NTC02', 'DS02'),
('SK08', N'Hội Chợ Thời Trang Mùa Hè', N'Trung Tâm Thương Mại Vincom', N'50 Lê Thánh Tôn, TP.HCM', '2025-08-12', '2025-08-16', N'Đã duyệt', 'LSK03', 'NTC03', 'DS03'),
('SK09', N'Hội Thảo Công Nghệ Số', N'Khách Sạn Sheraton', N'88 Đồng Khởi, TP.HCM', '2025-08-13', '2025-08-17', N'Đã duyệt', 'LSK04', 'NTC04', 'DS04'),
('SK10', N'Lễ Hội Ẩm Thực Quốc Tế', N'Phố đi bộ Nguyễn Huệ', N'Nguyễn Huệ, TP.HCM', '2025-08-14', '2025-08-18', N'Đã duyệt', 'LSK05', 'NTC05', 'DS05');
SELECT * FROM dbo.SuKien;
/* ==================== Bảng 8: HangVe (10 dòng) ==================== */
INSERT INTO HangVe (MaHV, TenHV, GiaHV, SoLuongVe, MaSK)
VALUES
('HV01', N'Vé Thường', 100000, 50, 'SK01'),
('HV02', N'Vé VIP', 150000, 30, 'SK02'),
('HV03', N'Vé Thường', 200000, 20, 'SK03'),
('HV04', N'Vé VIP', 120000, 40, 'SK04'),
('HV05', N'Vé Thường', 180000, 25, 'SK05'),
('HV06', N'Vé VIP', 160000, 35, 'SK06'),
('HV07', N'Vé Thường', 220000, 15, 'SK07'),
('HV08', N'Vé VIP', 140000, 45, 'SK08'),
('HV09', N'Vé Thường', 130000, 50, 'SK09'),
('HV10', N'Vé VIP', 170000, 30, 'SK10');
SELECT * FROM dbo.HangVe;
/* ==================== Bảng 9: ThanhVien (10 dòng) ==================== */
INSERT INTO ThanhVien (MaTV, EmailTV, SDTTV, Password, TrangThai, MaKH)
VALUES
('TV01', 'nguyenvana@gmail.com', '0901000001', 'pass01', N'Hoạt Động', 'KH01'),
('TV02', 'tranthib@gmail.com', '0901000002', 'pass02', N'Hoạt Động', 'KH02'),
('TV03', 'levanc@gmail.com', '0901000003', 'pass03', N'Hoạt Động', 'KH03'),
('TV04', 'phamthid@gmail.com', '0901000004', 'pass04', N'Hoạt Động', 'KH04'),
('TV05', 'hoangvane@gmail.com', '0901000005', 'pass05', N'Hoạt Động', 'KH05'),
('TV06', 'nguyenvand@gmail.com', '0901000006', 'pass06', N'Hoạt Động', 'KH06'),
('TV07', 'tranthie@gmail.com', '0901000007', 'pass07', N'Hoạt Động', 'KH07'),
('TV08', 'levanf@gmail.com', '0901000008', 'pass08', N'Hoạt Động', 'KH08'),
('TV09', 'phamvang@gmail.com', '0901000009', 'pass09', N'Hoạt Động', 'KH09'),
('TV10', 'hoangvh@gmail.com', '0901000010', 'pass10', N'Hoạt Động', 'KH10');
SELECT * FROM dbo.ThanhVien;
/* ==================== Bảng 10: PhieuDatVe (10 dòng) ==================== */
INSERT INTO PhieuDatVe (MaPDV, NgayDat, TrangThaiDon, PhuongThucThanhToan, MaTV)
VALUES
('PDV01', '2025-08-01', N'Chờ xử lý', N'Tiền mặt', 'TV01'),
('PDV02', '2025-08-02', N'Đã xác nhận', N'Chuyển khoản', 'TV02'),
('PDV03', '2025-08-03', N'Đã hủy', N'Tiền mặt', 'TV03'),
('PDV04', '2025-08-04', N'Đã xác nhận', N'Chuyển khoản', 'TV04'),
('PDV05', '2025-08-05', N'Chờ xử lý', N'Tiền mặt', 'TV05'),
('PDV06', '2025-08-06', N'Đã xác nhận', N'Chuyển khoản', 'TV06'),
('PDV07', '2025-08-07', N'Đã hủy', N'Tiền mặt', 'TV07'),
('PDV08', '2025-08-08', N'Đã xác nhận', N'Chuyển khoản', 'TV08'),
('PDV09', '2025-08-09', N'Chờ xử lý', N'Tiền mặt', 'TV09'),
('PDV10', '2025-08-10', N'Đã xác nhận', N'Chuyển khoản', 'TV10');
SELECT * FROM dbo.PhieuDatVe;
/* ==================== Bảng 11: HoaDon (10 dòng) ==================== */
INSERT INTO HoaDon (MaHD, NgayLapHD, ThanhTien, MaPDV)
VALUES
('HD01', '2025-08-01', 500000, 'PDV01'),
('HD02', '2025-08-02', 450000, 'PDV02'),
('HD03', '2025-08-03', 600000, 'PDV03'),
('HD04', '2025-08-04', 700000, 'PDV04'),
('HD05', '2025-08-05', 550000, 'PDV05'),
('HD06', '2025-08-06', 480000, 'PDV06'),
('HD07', '2025-08-07', 620000, 'PDV07'),
('HD08', '2025-08-08', 530000, 'PDV08'),
('HD09', '2025-08-09', 510000, 'PDV09'),
('HD10', '2025-08-10', 470000, 'PDV10');

SELECT * FROM dbo.HoaDon;
 /* ==================== Bảng 12: Ve (20 dòng) ==================== */
INSERT INTO Ve (MaVe, GiaVe, TrangThaiVe, MaQRVe, MaHV, MaHD)
VALUES
('V01', 100000, N'Còn', 'QR01', 'HV01', 'HD01'),
('V02', 100000, N'Đã bán', 'QR02', 'HV01', 'HD01'),
('V03', 150000, N'Còn', 'QR03', 'HV02', 'HD02'),
('V04', 150000, N'Đã bán', 'QR04', 'HV02', 'HD02'),
('V05', 200000, N'Còn', 'QR05', 'HV03', 'HD03'),
('V06', 200000, N'Đã bán', 'QR06', 'HV03', 'HD03'),
('V07', 120000, N'Còn', 'QR07', 'HV04', 'HD04'),
('V08', 120000, N'Đã bán', 'QR08', 'HV04', 'HD04'),
('V09', 180000, N'Còn', 'QR09', 'HV05', 'HD05'),
('V10', 180000, N'Đã bán', 'QR10', 'HV05', 'HD05'),
('V11', 160000, N'Còn', 'QR11', 'HV06', 'HD06'),
('V12', 160000, N'Đã bán', 'QR12', 'HV06', 'HD06'),
('V13', 220000, N'Còn', 'QR13', 'HV07', 'HD07'),
('V14', 220000, N'Đã bán', 'QR14', 'HV07', 'HD07'),
('V15', 140000, N'Còn', 'QR15', 'HV08', 'HD08'),
('V16', 140000, N'Đã bán', 'QR16', 'HV08', 'HD08'),
('V17', 130000, N'Còn', 'QR17', 'HV09', 'HD09'),
('V18', 130000, N'Đã bán', 'QR18', 'HV09', 'HD09'),
('V19', 170000, N'Còn', 'QR19', 'HV10', 'HD10'),
('V20', 170000, N'Đã bán', 'QR20', 'HV10', 'HD10');

SELECT * FROM dbo.Ve;

/* ==================== Bảng 13: YeuCauHuyVe (10 dòng) ==================== */
INSERT INTO YeuCauHuyVe (MaYC, NgayYC, LyDo, TrangThaiYC, MaVe, MaTV)
VALUES
('YC01', '2025-08-02', N'Khách bận', N'Chưa xử lý', 'V02', 'TV01'),
('YC02', '2025-08-03', N'Trùng lịch', N'Đang xử lý', 'V04', 'TV02'),
('YC03', '2025-08-04', N'Thay đổi kế hoạch', N'Chưa xử lý', 'V06', 'TV03'),
('YC04', '2025-08-05', N'Bệnh', N'Đang xử lý', 'V08', 'TV04'),
('YC05', '2025-08-06', N'Gia đình', N'Chưa xử lý', 'V10', 'TV05'),
('YC06', '2025-08-07', N'Công việc', N'Đang xử lý', 'V12', 'TV06'),
('YC07', '2025-08-08', N'Bận việc', N'Chưa xử lý', 'V14', 'TV07'),
('YC08', '2025-08-09', N'Khác', N'Đang xử lý', 'V16', 'TV08'),
('YC09', '2025-08-10', N'Bận', N'Chưa xử lý', 'V18', 'TV09'),
('YC10', '2025-08-11', N'Hủy gấp', N'Đang xử lý', 'V20', 'TV10');

SELECT * FROM dbo.YeuCauHuyVe;

/* ==================== Bảng 14: QuanTriVien (5 dòng) ==================== */
INSERT INTO QuanTriVien (MaQTV, TenQTV, EmailQTV, MatKhauQTV)
VALUES
('QTV01', N'Nguyễn Văn A', 'admina@gmail.com', 'admin01'),
('QTV02', N'Trần Thị B', 'adminb@gmail.com', 'admin02'),
('QTV03', N'Lê Văn C', 'adminc@gmail.com', 'admin03'),
('QTV04', N'Phạm Thị D', 'admind@gmail.com', 'admin04'),
('QTV05', N'Hoàng Văn E', 'admine@gmail.com', 'admin05');

SELECT * FROM dbo.QuanTriVien;
-- RBTV1 – thuộc ràng buộc toàn vẹn miền giá trị
ALTER TABLE KhachHang
ADD CONSTRAINT CHK_KhachHang_GioiTinh
CHECK (GioiTinh IN (N'Nam', N'Nữ'));
-- RBTV2 – thuộc ràng buộc toàn vẹn miền giá trị
ALTER TABLE PhieuDatVe
ADD CONSTRAINT CHK_PhieuDatVe_TrangThaiDon
CHECK (TrangThaiDon IN (N'Chờ xử lý', N'Đã xác nhận', N'Đã hủy'));
-- RBTV3 – thuộc ràng buộc toàn vẹn liên thuộc tính
ALTER TABLE SuKien
ADD CONSTRAINT CHK_SuKien_NgayKT
CHECK (NgayKT > NgayBD);
GO
-- RBTV4 – số lượng vé phải ≥ số vé đã bán
CREATE TRIGGER TR_RBTV4
ON Ve
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT hv.MaHV
        FROM HangVe hv
        JOIN Ve v ON v.MaHV = hv.MaHV
        GROUP BY hv.MaHV, hv.SoLuongVe
        HAVING COUNT(CASE WHEN v.TrangThaiVe = N'Đã bán' THEN 1 END) > hv.SoLuongVe
    )
    BEGIN
        RAISERROR('Số lượng vé đã bán vượt quá tổng số lượng vé của HangVe.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO
-- RBTV5 – thuộc ràng buộc toàn vẹn liên bộ
CREATE TRIGGER TR_RBTV5
ON KhachHang
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra trùng số điện thoại
    IF EXISTS (
        SELECT SDT
        FROM KhachHang
        GROUP BY SDT
        HAVING COUNT(*) > 1
    )
    BEGIN
        RAISERROR('Số điện thoại khách hàng phải là duy nhất.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO
-- RBTV6 – thuộc ràng buộc toàn vẹn liên bộ
CREATE TRIGGER TR_RBTV6
ON HangVe
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra trùng giá vé trong cùng 1 sự kiện
    IF EXISTS (
        SELECT MaSK, GiaHV
        FROM HangVe
        GROUP BY MaSK, GiaHV
        HAVING COUNT(*) > 1
    )
    BEGIN
        RAISERROR('Trong cùng một sự kiện, các hạng vé phải có giá khác nhau.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO
-- RBTV7 – Email ở ThanhVien và KhachHang phải trùng khi MaKH giống nhau
CREATE TRIGGER TR_RBTV7
ON ThanhVien
AFTER INSERT, UPDATE
AS
IF EXISTS (
    SELECT 1
    FROM ThanhVien tv
    JOIN KhachHang kh ON tv.MaKH = kh.MaKH
    WHERE tv.EmailTV <> kh.Email
)
BEGIN
    ROLLBACK;
    RAISERROR(N'Email trong ThanhVien và KhachHang phải trùng nhau.', 16, 1);
END
GO
-- RBTV8 – thuộc ràng buộc toàn vẹn liên bộ - liên quan hệ
CREATE TRIGGER TR_RBTV8
ON NhaToChucSuKien
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM NhaToChucSuKien ntc
        JOIN HoSoDonViToChuc hs ON ntc.MaHS = hs.MaHS
        WHERE ntc.SDTNTC <> hs.SDTDVTC
    )
    BEGIN
        RAISERROR(N'Số điện thoại NhaToChucSuKien và HoSoDonViToChuc phải trùng nhau.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO
-- RBTV9 – thuộc ràng buộc toàn vẹn liên thuộc tính - liên quan hệ
CREATE TRIGGER trg_KhongDatNhieuPhieuCungSuKienTrongNgay
ON PhieuDatVe
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted pdv1
        JOIN HoaDon hd1 ON pdv1.MaPDV = hd1.MaPDV
        JOIN Ve v1 ON hd1.MaHD = v1.MaHD
        JOIN HangVe hv1 ON v1.MaHV = hv1.MaHV

        JOIN PhieuDatVe pdv2
            ON pdv1.MaTV = pdv2.MaTV
            AND pdv1.NgayDat = pdv2.NgayDat
            AND pdv1.MaPDV <> pdv2.MaPDV
        JOIN HoaDon hd2 ON pdv2.MaPDV = hd2.MaPDV
        JOIN Ve v2 ON hd2.MaHD = v2.MaHD
        JOIN HangVe hv2 ON v2.MaHV = hv2.MaHV

        WHERE hv1.MaSK = hv2.MaSK
    )
    BEGIN
        RAISERROR(N'Khách hàng không thể đặt nhiều phiếu cho cùng sự kiện trong cùng ngày.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- RBTV10 – thuộc ràng buộc toàn vẹn liên thuộc tính - liên quan hệ
CREATE TRIGGER TR_RBTV10
ON HoaDon
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM HoaDon hd
        JOIN PhieuDatVe pdv ON hd.MaPDV = pdv.MaPDV
        WHERE hd.NgayLapHD < pdv.NgayDat
    )
    BEGIN
        RAISERROR(N'Ngày lập hóa đơn không được nhỏ hơn ngày đặt vé.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO
