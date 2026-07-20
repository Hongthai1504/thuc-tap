### 1. Mục tiêu và phạm vi dự án 
- Mục tiêu: Xây dựng một website thương mại điện tử cơ bản cho phép người dùng tham khảo, tìm kiếm sản phẩm và đặt hàng trực tuyến. Đồng thời cung cấp một trang quản trị (Admin Dashboard) để chủ cửa hàng quản lý dữ liệu sản phẩm và theo dõi tiến độ đơn hàng.
- Phạm vi dự án:
-> Tập trung hoàn thiện luồng mua hàng cơ bản (Thêm vào giỏ -> Điền thông tin -> Đặt hàng).
-> Phương thức thanh toán: Chỉ áp dụng Thanh toán khi nhận hàng (COD) để đảm bảo luồng dữ liệu ổn định trước khi mở rộng.
- Chưa tích hợp các hệ thống phức tạp.
### 2. Phân tích yêu cầu chức năng
### 2.1. Nhóm khách (chưa đăng ký/đăng nhập -> Guest) và khách hàng (Customer)

| Nhóm chức năng | Chi tiết chức năng | Yêu cầu đầu ra |
| :--- | :--- | :--- |
| **Quản lý Tài khoản** | Đăng ký & Đăng nhập | -> Cho phép tạo tài khoản mới bằng Email/Password. Đăng nhập để lưu lịch sử mua hàng. |
| **Duyệt sản phẩm** | Xem và tìm kiếm | -> Hiển thị danh sách sản phẩm theo danh mục. Tìm kiếm sản phẩm theo tên. Xem chi tiết hình ảnh, giá cả, mô tả của một sản phẩm. |
| **Giỏ hàng** | Thêm/ Sửa/ Xóa | -> Thêm sản phẩm vào giỏ, thay đổi số lượng mua. Xóa sản phẩm khỏi giỏ. Dữ liệu giỏ hàng không bị mất khi tải lại trang. |
| **Theo dõi** | Lịch sử đơn hàng | Khách hàng đã đăng nhập có thể xem lại các đơn đã đặt và trạng thái hiện tại của đơn hàng. |

### 2.2. Nhóm Quản trị viên (Admin)

| Nhóm chức năng | Chi tiết chức năng | Yêu cầu đầu ra |
| :--- | :--- | :--- |
| **Bảo mật** | Đăng nhập Admin | Có trang đăng nhập riêng biệt. Tài khoản thường không thể truy cập vào được. |
| **Quản lý sản phẩm** | Thêm/ Sửa/ Xóa (CRUD) | Admin có thể đăng sản phẩm mới (Kèm tải ảnh), cập nhật giá, chỉnh sửa mô tả hoặc ẩn/xóa sản phẩm. |
| **Quản lý danh mục** | Phân loại sản phẩm | Tạo và chỉnh sửa các danh mục. |
| **Quản lý đơn hàng** | Xử lý trạng thái | Xem danh sách toàn bộ đơn hàng khách đã đặt. Đổi trạng thái đơn (Chờ xử lý -> Đang giao -> Hoàn thành / Đã hủy). |

### 3. Phân tích yêu cầu phi chức năng (Non-Functional)
- Tính tương thích (Responsive Design): Website phải hiển thị tốt và không bị vỡ bố cục trên màn hình laptop và điện thoại.
- Hiệu suất (Performance):
    + Hình ảnh tải lên phải được tối ưu hoặc giới hạn dung lượng để không làm chậm tốc độ tải trang.
    + Các thao tác thêm vào giỏ hàng cần phải phản hồi ngay lập tức trên giao diện mà không cần tải lại toàn bộ trang.
- Bảo mật cơ bản (Security):
    + Mật khẩu của người dùng phải được băm (hash) trước khi lưu xuống cơ sở dữ liệu, tuyệt đối không lưu dạng plaintext.
    + Các API dành cho Admin phải có cơ chế xác thực mới được phép thực thi.
