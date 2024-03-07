import 'package:meta/meta.dart';

abstract interface class IRub{
  (int rub, int kop) get rubWithKop;
}

class Rub implements IRub {
  final int kopek;
  Rub(this.kopek);

  @override
  (int rub, int kop) get rubWithKop {
    return (kopek ~/ 100, kopek % 100);
  }

  // перегрузка сложения
  Rub operator +(Rub other) {
    return Rub(kopek + other.kopek);
  }

  // перегрузка вычитания
  Rub operator -(Rub other) {
    var temp = 0;
    if (kopek - other.kopek >= 0) {
      temp = kopek - other.kopek;
    } else {
      print("(╯'□')╯︵ ┻━┻ Банкрот!!!");
    }
    return Rub(temp);
  }

  // перегрузка умножения
  Rub operator *(int value) {
    return Rub(kopek * value);
  }

  // перегрузка деления
  Rub operator /(int value) {
    // осуществляем целочисленное деление
    return Rub(kopek ~/ value);
  }

  // переопределение
  @override
  String toString() {
    var (rub, kop) = rubWithKop;
    return 'Rub($rub), kopek($kop)';
  }
}


extension type DigitalRub(Rub value) implements IRub {
  DigitalRub operator +(DigitalRub other) {
    return DigitalRub(value + other.value);
  }

  DigitalRub operator *(int multiplier) {
    if (multiplier < 0) {
      throw ArgumentError('Multiplier cannot be negative');
    }
    return DigitalRub(value * multiplier);
  }

  @redeclare
  (int rub, int kop) get rubWithKop {
    return (0, value.kopek);
  }
}

void main() {
  var digitalRub = DigitalRub(Rub(10496));
  print(digitalRub.rubWithKop);
  var rub = digitalRub as Rub;
  print(rub.rubWithKop);
}