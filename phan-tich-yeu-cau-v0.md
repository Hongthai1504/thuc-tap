1. Mục tiêu và phạm vi dự án 
- Mục tiêu: Xây dựng một website thương mại điện tử cơ bản cho phép người dùng tham khảo, tìm kiếm sản phẩm và đặt hàng trực tuyến. Đồng thời cung cấp một trang quản trị (Admin Dashboard) để chủ cửa hàng quản lý dữ liệu sản phẩm và theo dõi tiến độ đơn hàng.
- Phạm vi dự án:
-> Tập trung hoàn thiện luồng mua hàng cơ bản (Thêm vào giỏ -> Điền thông tin -> Đặt hàng).
-> Phương thức thanh toán: Chỉ áp dụng Thanh toán khi nhận hàng (COD) để đảm bảo luồng dữ liệu ổn định trước khi mở rộng.
- Chưa tích hợp các hệ thống phức tạp.
2. Phân tích yêu cầu chức năng

2.1. Nhóm khách (chưa đăng ký/đăng nhập -> Guest) và khách hàng (Customer)
Nhóm chức năng            Chi tiết chức năng            Yêu cầu đầu ra
Quản lý Tài khoản         Đăng ký & Đăng nhập           -> Cho phép tạo tài khoản mới bằng
                                                        Email/Password. Đăng nhập để lưu
                                                        lịch sử mua hàng.
Duyệt sản phẩm            Xem và tìm kiếm               -> Hiển thị danh sách sản phầm theo 
                                                        danh mục. Tìm kiếm sản phẩm theo tền.
                                                        Xem chi tiết hành ảnh, giá cả, mô tả
                                                        của một sản phầm.
Giỏ hàng                  Thêm/ Sửa/ Xóa                -> Thêm sản phẩm vào giỏ. thay đổi số
                                                        lượng mua. Xóa sản phẩm khỏi giỏi. Dữ
                                                        liệu giỏ hàng không bị mất khi tải 
                                                        lại trang.
Theo dỏi                  Lịch sử đơn hàng              Khách hàng đã đăng nhập có thể xem lại
                                                        các đơn đã đặt và trạng thái hiện tại
                                                        của đơn hàng.

2.2. Nhóm Quản trị viên (Admin)
