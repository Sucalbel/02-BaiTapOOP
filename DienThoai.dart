import 'dart:math';

class DienThoai {
  // Thuộc tính
  String _maDienThoai;
  String _tenDienThoai;
  String _hangSanXuat;
  double _giaNhap;
  double _giaBan;
  int _soLuongTonKho;
  bool _trangThai;

  // Constructor
  DienThoai(this._maDienThoai, this._tenDienThoai, this._hangSanXuat,
      this._giaNhap, this._giaBan, this._soLuongTonKho, this._trangThai) {
    if (_giaNhap <= 0 || _giaBan <= 0 || _giaBan <= _giaNhap) {
      throw ArgumentError('Giá bán phải lớn hơn giá nhập và > 0.');
    }
    if (_soLuongTonKho < 0) {
      throw ArgumentError('Số lượng tồn kho phải >= 0.');
    }
    if (!_maDienThoai.startsWith("DT-")) {
      throw ArgumentError('Mã điện thoại phải có định dạng "DT-XXX".');
    }
  }

  // Getter và Setter với validation
  String get maDienThoai => _maDienThoai;
  set maDienThoai(String value) {
    if (value.isEmpty || !value.startsWith("DT-")) {
      throw ArgumentError('Mã điện thoại phải có định dạng "DT-XXX".');
    }
    _maDienThoai = value;
  }

  // Phương thức tính lợi nhuận
  double tinhLoiNhuan() => _giaBan - _giaNhap;

  // Phương thức hiển thị thông tin
  void hienThiThongTin() {
    print(
        'Mã: $_maDienThoai, Tên: $_tenDienThoai, Hãng: $_hangSanXuat, Giá nhập: $_giaNhap, Giá bán: $_giaBan, Số lượng: $_soLuongTonKho, Trạng thái: ${_trangThai ? "Còn kinh doanh" : "Ngừng kinh doanh"}');
  }

  // Kiểm tra có thể bán
  bool coTheBan() => _soLuongTonKho > 0 && _trangThai;
}

class HoaDon {
  String _maHoaDon;
  DateTime _ngayBan;
  DienThoai _dienThoai;
  int _soLuongMua;
  double _giaBanThucTe;
  String _tenKhachHang;
  String _soDienThoaiKhach;

  // Constructor
  HoaDon(this._maHoaDon, this._ngayBan, this._dienThoai, this._soLuongMua,
      this._giaBanThucTe, this._tenKhachHang, this._soDienThoaiKhach) {
    if (!_maHoaDon.startsWith("HD-")) {
      throw ArgumentError('Mã hóa đơn phải có định dạng "HD-XXX".');
    }
    if (_ngayBan.isAfter(DateTime.now())) {
      throw ArgumentError('Ngày bán không được sau ngày hiện tại.');
    }
    if (_soLuongMua <= 0 || _soLuongMua > _dienThoai._soLuongTonKho) {
      throw ArgumentError('Số lượng mua không hợp lệ.');
    }
    if (_giaBanThucTe <= 0) {
      throw ArgumentError('Giá bán thực tế phải > 0.');
    }
  }

  // Tính tổng tiền
  double tinhTongTien() => _soLuongMua * _giaBanThucTe;

  // Tính lợi nhuận thực tế
  double tinhLoiNhuanThucTe() =>
      _soLuongMua * (_giaBanThucTe - _dienThoai._giaNhap);

  // Hiển thị thông tin hóa đơn
  void hienThiThongTin() {
    print(
        'Mã HD: $_maHoaDon, Ngày bán: $_ngayBan, Tên KH: $_tenKhachHang, SĐT: $_soDienThoaiKhach, Tổng tiền: ${tinhTongTien()}');
  }
}

class CuaHang {
  String _tenCuaHang;
  String _diaChi;
  List<DienThoai> _danhSachDienThoai = [];
  List<HoaDon> _danhSachHoaDon = [];

  CuaHang(this._tenCuaHang, this._diaChi);

  // Getter và Setter với validation
  String get tenCuaHang => _tenCuaHang;
  set tenCuaHang(String value) {
    if (value.isEmpty) {
      throw ArgumentError('Tên cửa hàng khóa bộ.');
    }
    _tenCuaHang = value;
  }

  // Thêm điện thoại mới
  void themDienThoai(DienThoai dt) => _danhSachDienThoai.add(dt);

  // Hiển thị danh sách điện thoại
  void hienThiDanhSachDienThoai() {
    for (var dt in _danhSachDienThoai) {
      dt.hienThiThongTin();
    }
  }

  // Thêm hóa đơn mới
  void taoHoaDon(HoaDon hd) {
    if (hd._dienThoai.coTheBan()) {
      _danhSachHoaDon.add(hd);
      hd._dienThoai._soLuongTonKho -= hd._soLuongMua;
    } else {
      throw ArgumentError('Điện thoại không khả dụng để bán.');
    }
  }

  // Hiển thị danh sách hóa đơn
  void hienThiDanhSachHoaDon() {
    for (var hd in _danhSachHoaDon) {
      hd.hienThiThongTin();
    }
  }
}

void main() {
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
}
