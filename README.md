# Project-System-Analysis-and-Design
# Hệ Thống Đặt Vé Sự Kiện Trực Tuyến: Ticketbox
### Giới thiệu dự án
- Đồ án phân tích và thiết kế hệ thống thông tin mô phỏng theo nền tảng đặt vé sự kiện trực tuyến Ticketbox.
- Đóng vai trò cầu nối trung gian giữa ban tổ chức sự kiện và người tham gia, giúp số hóa toàn bộ quy trình phân phối vé.
- Cung cấp giải pháp mua vé tiện lợi, quản lý sự kiện chuyên nghiệp và thống kê doanh thu minh bạch.
### Mục tiêu hệ thống
- Khắc phục hoàn toàn các hạn chế của phương thức mua vé truyền thống: giảm xếp hàng, tránh rủi ro mất vé giấy.
- Tối ưu hóa quy trình đặt vé trực tuyến: cho phép chọn chỗ ngồi, thanh toán linh hoạt và nhận vé điện tử (mã QR) qua email.
- Hỗ trợ ban tổ chức dễ dàng tạo mới, chỉnh sửa thông tin sự kiện, theo dõi doanh thu và số lượng vé bán ra.
- Hỗ trợ ban quản trị kiểm duyệt hồ sơ chặt chẽ, quản lý người dùng và xuất báo cáo thống kê.
### Các đối tượng sử dụng (Tác nhân)
- Khách hàng: Tra cứu, lọc sự kiện (theo thời gian, địa điểm, thể loại) và đăng ký tài khoản.
- Thành viên: Đặt vé, thanh toán trực tuyến, quản lý lịch sử đặt vé và gửi yêu cầu hủy/hoàn vé.
- Ban tổ chức: Gửi hồ sơ đăng ký tổ chức, tạo sự kiện, theo dõi doanh thu và quản lý danh sách khách hàng tham dự.
- Quản trị viên: Duyệt hồ sơ ban tổ chức, kiểm duyệt nội dung sự kiện, xử lý hoàn tiền và quản trị toàn bộ hệ thống.
- Hệ thống thanh toán: Tích hợp với ví MoMo và ngân hàng để xử lý giao dịch.
### Kiến trúc cơ sở dữ liệu
- Cơ sở dữ liệu được thiết kế đạt Dạng chuẩn 3 (3NF), đảm bảo tối ưu hóa không gian lưu trữ và tránh dư thừa dữ liệu.
- Quản lý 14 thực thể chính: Khách hàng, Thành viên, Sự kiện, Phiếu đặt vé, Hóa đơn, Hạng vé, Yêu cầu hủy vé...
- Thiết lập đầy đủ các Ràng buộc toàn vẹn (miền giá trị, liên thuộc tính, liên bộ) thông qua hệ thống Trigger trong SQL Server.
- Xây dựng sơ đồ phân rã chức năng (BFD) và sơ đồ luồng dữ liệu (DFD) từ mức ngữ cảnh đến mức 1.
### Hướng phát triển trong tương lai
- Triển khai ứng dụng thực tế trên nền tảng Web và Mobile (Android/iOS).
- Xây dựng sơ đồ chỗ ngồi trực quan để khách hàng chọn vị trí ghế chính xác.
- Tích hợp thêm các cổng thanh toán đa dạng như ZaloPay, PayPal, thẻ tín dụng.
- Tăng cường bảo mật bằng xác thực 2 lớp (2FA) và ứng dụng công nghệ AI/ML để tự động gợi ý sự kiện theo sở thích người dùng.
### Tác giả 
**Hồ Vũ Tường Vy**
