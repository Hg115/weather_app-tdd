import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

//General failures
class ServerFailure extends Failure {
  @override
  List<Object> get props => [];
}

class ServerMaintenance extends Failure {
  @override
  List<Object> get props => [];
}
