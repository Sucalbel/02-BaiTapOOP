import "DienThoai.dart";

void main() {
  // Test lớp DienThoai
  testDienThoai();

  // Test lớp HoaDon
  testHoaDon();

  // Test lớp CuaHang
  testCuaHang();
}

void testDienThoai() {
  print('--- Test DienThoai ---');

  try {
    // Tạo đối tượng DienThoai hợp lệ
    var dienThoai = DienThoai("DT-001", "Samsung Galaxy S23", "Samsung",
        15000000, 20000000, 20, true);
    print('Tạo điện thoại thành công:');
    dienThoai.hienThiThongTin();

    // Kiểm tra tính lợi nhuận
    print('Lợi nhuận dự kiến: ${dienThoai.tinhLoiNhuan()}');

    // Kiểm tra trạng thái có thể bán
    print('Có thể bán không? ${dienThoai.coTheBan() ? "Có" : "Không"}');

    // Thử validation (sai định dạng mã)
    try {
      var dienThoaiSaiMa =
          DienThoai("001", "Xiaomi 13", "Xiaomi", 10000000, 15000000, 10, true);
    } catch (e) {
      print('Lỗi (đúng mong đợi): $e');
    }
  } catch (e) {
    print('Lỗi không mong đợi: $e');
  }
}

void testHoaDon() {
  print('--- Test HoaDon ---');

  try {
    // Tạo một điện thoại hợp lệ
    var dienThoai =
        DienThoai("DT-002", "iPhone 15", "Apple", 30000000, 35000000, 15, true);

    // Tạo hóa đơn hợp lệ
    var hoaDon = HoaDon("HD-001", DateTime.now(), dienThoai, 2, 34000000,
        "Nguyen Van B", "0987654321");
    print('Tạo hóa đơn thành công:');
    hoaDon.hienThiThongTin();

    // Kiểm tra tính tổng tiền và lợi nhuận
    print('Tổng tiền: ${hoaDon.tinhTongTien()}');
    print('Lợi nhuận thực tế: ${hoaDon.tinhLoiNhuanThucTe()}');

    // Test validation (mua vượt số lượng tồn kho)
    try {
      var hoaDonSaiSoLuong = HoaDon("HD-002", DateTime.now(), dienThoai, 20,
          34000000, "Nguyen Van C", "0123456789");
    } catch (e) {
      print('Lỗi (đúng mong đợi): $e');
    }
  } catch (e) {
    print('Lỗi không mong đợi: $e');
  }
}

void testCuaHang() {
  print('--- Test CuaHang ---');

  try {
    // Tạo cửa hàng
    var cuaHang = CuaHang("Cửa hàng ABC", "123 Đường XYZ");

    // Thêm điện thoại
    var dienThoai1 =
        DienThoai("DT-001", "iPhone 14", "Apple", 20000000, 25000000, 10, true);
    cuaHang.themDienThoai(dienThoai1);

    // Tạo hóa đơn
    var hoaDon1 = HoaDon("HD-001", DateTime.now(), dienThoai1, 2, 24500000,
        "Nguyen Van A", "0123456789");
    cuaHang.taoHoaDon(hoaDon1);

    // Hiển thị
    cuaHang.hienThiDanhSachDienThoai();
    cuaHang.hienThiDanhSachHoaDon();
  } catch (e) {
    print('Lỗi không mong đợi: $e');
  }
}
