# PHÂN TÍCH YÊU CẦU

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

# ĐẶC TẢ & THIẾT KẾ HỆ THỐNG

### 1. Thiết kế hệ thống (System Architecture)
Trình bày cách mảnh ghép giúp cho website hoạt động đồng bộ. Sử dụng mô hình **Client - Server** làm chuẩn
- **Client (Frontend)**: Trình duyệt của người dùng (Chrome). Giao diện web chịu trách nhiệm thu thập thao tác của người dùng gửi các yêu cầu (Request) thông qua các giao thức HTTP/HTTPS.
- **Server (Backend)**: Máy chủ nhận yêu cầu, xử lý logic (tính toán giỏ hàng, xác thực đăng nhập) và trả về kết quả (Response).
- **Databse (Cơ sở dữ liệu)**: Nơi lưu giữ thông tin thực tế. Để bảo mật, chỉ có Server mới được quyền nói chuyện trực tiếp với Database, Client tuyệt đối không được truy cập.

### 2. Đặc tả Cơ sở dữ liệu (Database Schema)

#### Bảng 1: Users
*Lưu trữ tài khoản và phân quyền quản trị.*
- id (PK): Mã định danh duy nhất.
- email, password: Thông tin đăng nhập (Mật khẩu phải được băm/mã hóa).
- full_name, phone: Thông tin giao hàng mặc định (thông tin cá nhân).
- role: xác định là admin hay customer.

#### Bảng 2: Categories
- id (PK): Mã danh mục
- name: Tên

#### Bảng 3: Products
- id (PK): Mã sản phẩm.
- category_id (FK): Liên kết tới bảng Categories.
- name, description: Tên và mô tả chi tiết.
- price: Giá bán hiện tại.
- stock: Số lượng tồn kho.

#### Bảng 4: Orders
*Bảng này đóng vai trò như một "Hóa đơn tổng" của khách hàng.*
- id (PK): Mã đơn hàng.
- user_id (FK): Trỏ về bảng Users.
- total_amount: Tổng tiền của cả đơn.
- status: Trạng thái (Pending (Đang chờ), Shipping (Đang giao), Completed (Hoàn thành)).

#### Bảng 5: Order_Details 
*Vì một đơn hàng có thể mua cùng lúc nhiều sản phẩm khác nhau, ta cần bảng này để gỡ rối mối quan hệ nhiều - nhiều giữa bảng Orders và Products.*
- order_id (FK): Thuộc đơn hàng nào.
- product_id (FK): Mua sẩn phẩm nào.
- quantity: Số lượng mua.
- price_at_purchase: Giá tại thời điểm mua.
