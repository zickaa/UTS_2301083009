import '../models/pdam.dart';

class PdamService {
  static double calculateTotalPayment(Pdam pdam) {
    return pdam.calculateTotalBayar();
  }
}
