# thuc-tap
Quá trình của dự án thực tập tại trường với Đề tài: Hệ thống website bán hàng Online.

## I. Khởi tạo Cơ sở dữ liệu (Database)
*Nền tảng lưu trữ.*
- Cài đặt MySQL, tạo 5 bẳng cốt lõi:
  - Users
  - Categories
  - Products
  - Orders
  - Order_Details
 => Trong file **init_database.sql**
=> Database là nơi lưu giữ thông tin thực tế và chỉ có Server mới được quyền truy cập trực tiếp
<img width="1365" height="686" alt="init_database sql" src="https://github.com/user-attachments/assets/825d68f8-7a08-405b-8d1e-c00ee01f30c0" />

## II. Xây dựng Backend (Server)
*Node.js & Express.*
- Viết các API chính để Server nhận các yêu cầu từ Client, xử lý các logic và trả về kết quả:
  - Hiển thị: GET /api/products để trả về danh sách sản phẩm bằng JSON, cần tối ưu để thời gian phản hồi dưới 500ms.
    - Bước đầu khởi dộng server và tạo API Hiển thị thông qua fil **server.js**
<img width="1366" height="689" alt="server js" src="https://github.com/user-attachments/assets/0e85d7b4-7971-42ee-83d9-548135d9cddd" />

  - Thanh toán: POST /api/orders để nhận thông tin về User và Cart, tính tổng tiền, lưu vào bảng Orders/Order_Details, và trừ đi số lượng tồn kho (Stock) trong Products.
  - Bảo mật: Validate dữ liệu đẻ chống SQL Injection/XSS. Áp dụng thư viện bcrypt để băm mật khẩu (không lưu plaintext) và sử dụng JWT (JSON Web Token) để duy trì đăng nhập.
