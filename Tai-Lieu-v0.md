# PHÂN TÍCH YÊU CẦU

### 1. Mục tiêu và phạm vi dự án 
- Mục tiêu: Xây dựng một nền tảng thương mại điện tử hoàn chỉnh (B2C), cung cấp trải nghiệm mua sắm mượt mà cho khách hàng và công cụ quản lý toàn diện cho chủ cửa hàng. Hệ thống được thiết kế theo kiến trúc chuẩn để đảm bảo tính mở rộng trong tương lai.
- Phạm vi dự án:
    - Quản lý luồng mua hàng (Shopping Cart -> Checkout -> Order Tracking).
    - Quản lý danh mục, sản phẩm và biến thể (size, màu sắc).
    - Tích hợp thanh toán COD (Cash on Delivery) làm nền tảng.
### 2. Phân tích yêu cầu chức năng
### 2.1. Nhóm khách (chưa đăng ký/đăng nhập -> Guest) và khách hàng (Customer)

| Nhóm chức năng | Chi tiết chức năng | Yêu cầu đầu ra |
| :--- | :--- | :--- |
| **Quản lý Tài khoản** | Đăng ký & Đăng nhập <br> Quên mật khẩu (Khôi phục qua Email OTP)| Quản lý thông tin cá nhân & Địa chỉ giao hàng mặc định. |
| **Danh mục và khám phá** | Xem, tìm kiếm, filter, sort | Hiển thị sản phẩm theo danh mục đa cấp (Category tree). <br> Bộ lọc (Filter) theo giá, thuộc tính (màu, size). <br> Tìm kiếm toàn văn bản (Full-text-search) theo tên/mô tả. <br> Sắp xếp (Mới nhất, Giá tăng/giảm, Bán chạy)|
| **Giỏ hàng** | Thêm/ Sửa/ Xóa | Thêm sản phẩm vào giỏ, thay đổi số lượng mua. <br> Xóa sản phẩm khỏi giỏ. <br> Dữ liệu giỏ hàng không bị mất khi tải lại trang. |
| **Theo dõi** | Lịch sử đơn hàng |Theo dõi trang thái của các đơn đã đặt và trạng thái hiện tại của đơn hàng. |

### 2.2. Nhóm Quản trị viên (Admin)

| **Quản lý Sản phẩm (PIM)** | **Xử lý Đơn hàng (OMS)** |
| :--- | :--- |
| Quản lý danh mục (Tạo cây thư mục). <br> CRUD sản phẩm: Tên, giá gốc, giá khuyến mãi, số lượng kho. <br> Quản lý hình ảnh (Upload nhiều ảnh/sản phẩm). <br> Quản lý thuộc tính biến thể.| Xem danh sách toàn bộ đơn hàng, lọc theo ngày/trạng thái. <br> Cập nhật trạng thái luồng đơn hàng: Chờ xác nhận -> Đang giao -> Hoàn thành. <br> Xem chi tiết thông tin người nhận và danh sách mặt hàng đã mua. |

### 3. Phân tích yêu cầu phi chức năng (Non-Functional)
- Tính tương thích (Responsive Design):
    - Giao diện Responsive Design, đảm bảo tương tác vuốt/chạm (touch-friendly) trên thiết bị di động (Mobile First) và tương thích các trình duyệt chuẩn.
- Hiệu suất (Performance):
    - Thời gian phản hồi (TTFB) cho các API liệt kê sản phẩm dưới 500ms. Hình ảnh sản phẩm phải được tối ưu dung lượng trước khi lưu trữ.
- Bảo mật cơ bản (Security):
    - Áp dụng JWT (JSON Web Token) hoặc Session để duy trì đăng nhập. Không lưu mật khẩu dạng plaintext (Sử dụng bcrypt). Validate chặt chẽ dữ liệu đầu vào chống SQL Injection/XSS.

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
