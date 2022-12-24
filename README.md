# ptudpt
ĐỀ TÀI MÔN  PTPM TRÊN HỆ THỐNG PHÂN TÁN
Ñeà 3 . QUAÛN LYÙ NHAÄP/XUAÁT VAÄT TÖ
Mục tiêu: Viết chương trình quản lý việc nhập/xuất vật tư của công ty theo từng chi nhánh.
-	Công ty  có 2 chi nhánh (CN1 và CN2) . Trong mỗi chi nhánh có nhiều nhân viên, nhưng mỗi nhân viên chỉ thuộc 1 chi nhánh. Mỗi nhân viên có mã để phân biệt các nhân viên với nhau, họ, tên, phái, ngày sinh, dịa chỉ, số điện thoại liên lạc. Các nhân viên về sau này có khả năng sẽ được điều chuyển qua chi nhánh khác.
-	Mỗi hàng hóa có mã mặt hàng để phân biệt các mặt hàng với nhau, tên mặt hàng, đơn vị tính. Mỗi hàng hóa thuộc 1 loại hàng, 1 loại hàng có thể có nhiều hàng hóa.
-	Mỗi chi nhánh nhập hàng bằng hình thức đặt hàng cho nhà cung cấp. Mỗi nhà cung cấp có mã để phân biệt các nhà cung cấp với nhau, tên nhà cung cấp,  dịa chỉ, số điện thoại liên lạc. 1 nhà cung cấp có thể cung cấp hàng cho cả 2 chi nhánh.
-	Chi nhánh khi nhập hàng thì lập đơn đặt hàng cho nhà cung cấp, mỗi đơn đặt hàng có thể có nhiều mặt hàng kèm theo số lượng đặt, đơn giá đặt; mỗi mặt hàng có thể được  đặt nhiều lần. Các đơn đặt hàng phải ghi nhận nhân viên lập. 
-	Chi nhánh chỉ nhập hàng khi đă có đơn đặt hàng; khi nhập sẽ có phiếu nhập. Mỗi phiếu nhập sẽ có SoPN, Ngày lập và các mặt hàng thuộc đơn đặt hàng tương ứng; mỗi phiếu nhập sẽ do  1 nhân viên lập, và toàn bộ mặt hàng trên phiếu nhập sẽ chuyển hết về 1 kho. 
-	Mỗi chi nhánh có nhiều kho, nhưng 1 kho chỉ thuộc 1 chi nhánh.
-	Khi khách hàng mua hàng thì bao giờ chi nhánh cũng phải lập hóa đơn cho khách. Mỗi hóa đơn sẽ có số hóa đơn, Ngày lập và các mặt hàng, số lượng , đơn giá; Một hàng hóa có thể được xuất nhiều lần. Mỗi hóa đơn sẽ do  1 nhân viên lập, và toàn bộ mặt hàng trên hóa đơn đều được xuất từ 1 kho.
-	Các khách hàng có mã để phân biệt các khách hàng với nhau, tên khách hàng,  dịa chỉ, số điện thoại liên lạc. Nếu 1 khách hàng mua hàng từ cả 2 chi nhánh thì xem như là 2 khách hàng độc lập. 

Yêu cầu: 
Giả sử  công ty có  2 chi  nhánh: chi nhánh 1  (CN1), chi nhánh 2  (CN2) .
Phân tán cơ sở dữ liệu QLVT  ra làm 2 mảnh với điều kiện sau: 
-	QLVT được đặt trên server1: chứa thông tin nhập/xuất của chi nhánh 1.
-	QLVT được đặt trên server2: chứa thông tin nhập/xuất của chi nhánh 2.
 
Viết chương trình tạo các Form và Report sau:

1. Lập các Form sau:
1.1. Nhập danh sách nhân viên : có các chức năng: Thêm, Xóa, Ghi, Undo, Tìm kiếm(theo mã) , Thoát. Nhân viên thuộc chi nhánh nào thì chi nhánh đó nhập. Trên từng chi nhánh ta chỉ thấy được danh sách nhân viên thuộc chi nhánh đó.
1.2. Nhập danh mục vật tư: Thêm, Xóa, Ghi, Undo, Tìm kiếm( theo tên) , Thoát. 
1.3. Nhập danh mục kho: Thêm, Xóa, Ghi, Undo, Tìm kiếm( theo tên) , Thoát. Kho thuộc chi nhánh nào thì chi nhánh đó nhập. Trên từng chi nhánh ta chỉ thấy được danh sách Kho thuộc chi nhánh đó.
1.4. Lập đơn đặt hàng: trình bày form dưới dạng SubForm. Nhân viên thuộc chi nhánh nào thì lập đơn đặt hàng của chi nhánh đó. Trên từng chi nhánh ta chỉ thấy được danh sách các  đơn  đặt hàng của chi nhánh đó.
1.5. Phiếu nhập/xuất vật tư: trình bày form dưới dạng SubForm. Nhân viên thuộc chi nhánh nào thì nhập dữ liệu nhập/xuất của chi nhánh đó. Trên từng chi nhánh ta chỉ thấy được danh sách các phiếu nhập/xuất của chi nhánh đó.
 

2. Phân quyền: Chương trình có 3 nhóm : Công ty , ChiNhanh, User
-  Nếu login thuộc nhóm CongTy thì login đó có thể đăng nhập vào bất kỳ chi nhánh nào để xem bằng cách chọn tên chi nhánh, và chỉ có các chức năng sau:
 + Chỉ có thể xem dữ liệu của phân mảnh tương ứng.
 	 + Xem được các báo cáo.
	 + Tạo login thuộc nhóm Congty
-  Nếu login thuộc nhóm ChiNhanh thì ta chỉ cho phép toàn quyền làm việc trên chi nhánh đó , không được log vào chi nhánh khác  , Tạo login thuộc nhóm ChiNhanh
- Nếu login thuộc nhóm User thì chỉ được quyền cập nhật dữ liệu, không được tạo tài khoản mới cho hệ thống.
Chương trình cho phép ta tạo các login, password và cho login này làm việc với quyền hạn gì. Căn cứ vào quyền này khi user login vào hệ thống, ta sẽ biết người đó được quyền làm việc với mảnh phân tán nào hay trên tất cả các phân mảnh. 
3. Lập các báo biểu:
3.1. In danh sách nhân viên: Tùy thuộc vào quyền hạn của login mà ta cho phép chọn công ty – chi nhánh để in theo thứ tự tăng dần tên + họ
 Nếu login thuộc nhóm Công ty thì ta cho chọn tên chi nhánh và tìm dữ liệu trên phân mảnh tương ứng để in. 
 Nếu login thuộc nhóm ChiNhánhX thì ta cho lấy dữ liệu trên phân mảnh tương ứng để in.
3.2. In danh mục vật tư: theo thứ tự tên vật tư tăng dần của cả công ty
3.3. In Bảng kê chi tiết số lượng – trị giá hàng nhập hoặc xuất theo từng tháng trong 1 khoảng thời gian do người sử dụng chọn. 
Dữ liệu in ra sẽ thuộc chi nhánh tương ứng với nhân viên khi login vào. Nếu login vào thuộc nhóm Công ty thì dữ liệu sẽ là dữ liệu tổng hợp của cả 2 chi nhánh. Kết xuất: 
Tháng/năm       Tên vật tư        Tổng số lượng            Tổng trị giá
3.4. In Danh sách các đơn đặt hàng chưa có phiếu nhập. Kết xuất:
     	 Mã số ĐĐH  Ngày lập     Nhà cung cấp  Họ tên nhân viên  lập phiếu
           Tên vật tư     Số lượng đặt     Đơn giá
3.5. Báo cáo tình hình hoạt động của 1 nhân viên: báo cáo được nhóm theo từng tháng
 
 

3.6. Lập Report tên ‘TONG HOP NHAP XUAT’ để:
- Tổng hợp số tiền Nhập và Xuất trong từng ngày
- Mỗi ngày chỉ thể hiện một dòng
- Tổng hợp trong khoảng thời gian nào
- Mỗi ngày phải cho biết tỷ lệ % so với tổng số.
- Cuối cùng phải cho biết tổng số tiền trong khoảng thời gian mà ta chỉ ra.
Mẫu in có dạng:
BẢNG TỔNG HỢP NHẬP XUẤT
TỪ dd/mm/yy ĐẾN dd/mm/yy
NGÀY	NHẬP	TỶ LỆ	XUẤT	TỶ LỆ
dd/mm/yyyy	#,##0.0	0.00%	#,##0.0	0.00%
dd/mm/yyyy	#,##0.0	0.00%	#,##0.0	0.00%
….				
CỘNG	#,##0.0		#,##0.0	
 Ghi chú: 
- Sinh viên tự kiểm tra các ràng buộc có thể có khi viết chương trình.
 - Thực hiện các lệnh truy vấn dưới dạng Stored Procedure.

HẾT

