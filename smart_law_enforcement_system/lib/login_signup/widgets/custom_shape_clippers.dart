import 'package:flutter/material.dart';

//************************ for login design 3 *********************************
class CustomLoginShapeClipper4 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height * 0.325);

//    path.lineTo(0.0, size.height * 0.3);

    var firstEndpoint = Offset(size.width * 0.22, size.height * 0.2);
    var firstControlPoint = Offset(size.width * 0.125, size.height * 0.30);

//    var firstEndpoint = Offset(size.width * 0.17, size.height * 0.2);
//    var firstControlPoint = Offset(size.width * 0.075, size.height * 0.30);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);

    var secondEndpoint = Offset(size.width * 0.6, size.height * 0.0725);
    var secondControlPoint = Offset(size.width * 0.3, size.height * 0.0825);

//    var secondEndpoint = Offset(size.width * 0.6, size.height * 0.05);
//    var secondControlPoint = Offset(size.width * 0.3, size.height * 0.06);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndpoint.dx, secondEndpoint.dy);

    var thirdEndpoint = Offset(size.width, size.height * 0.0);
    var thirdControlPoint = Offset(size.width * 0.99, size.height * 0.05);

//    var thirdEndpoint = Offset(size.width * 0.95, size.height * 0.0);
//    var thirdControlPoint = Offset(size.width * 0.9, size.height * 0.05);

    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndpoint.dx, thirdEndpoint.dy);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class CustomLoginShapeClipper5 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height * 0.3);

    var firstEndpoint = Offset(size.width * 0.17, size.height * 0.2);
    var firstControlPoint = Offset(size.width * 0.075, size.height * 0.30);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);

    var secondEndpoint = Offset(size.width * 0.6, size.height * 0.05);
    var secondControlPoint = Offset(size.width * 0.3, size.height * 0.06);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndpoint.dx, secondEndpoint.dy);

    var thirdEndpoint = Offset(size.width * 0.95, size.height * 0.0);
    var thirdControlPoint = Offset(size.width * 0.9, size.height * 0.05);

    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndpoint.dx, thirdEndpoint.dy);

//    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class CustomLoginShapeClipper3 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.moveTo(size.width * 0.05, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.7);

    var firstEndpoint = Offset(size.width * 0.83, size.height * 0.8);
    var firstControlPoint = Offset(size.width * 0.925, size.height * 0.70);
//
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);
//
    var secondEndpoint = Offset(size.width * 0.30, size.height * 0.95);
    var secondControlPoint =
        Offset(size.width * 0.70, size.height * 0.92); //height
//
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndpoint.dx, secondEndpoint.dy);
//
    var thirdEndpoint = Offset(size.width * 0.05, size.height);
    var thirdControlPoint =
        Offset(size.width * 0.1, size.height * 0.95); //width

    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndpoint.dx, thirdEndpoint.dy);
//
//
//    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class CustomLoginShapeClipper6 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.moveTo(size.width * 0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.675);

    var firstEndpoint = Offset(size.width * 0.78, size.height * 0.8);
    var firstControlPoint = Offset(size.width * 0.875, size.height * 0.70);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);

    var secondEndpoint = Offset(size.width * 0.30, size.height * 0.9275);
    var secondControlPoint = Offset(size.width * 0.70, size.height * 0.8975);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndpoint.dx, secondEndpoint.dy);

    var thirdEndpoint = Offset(size.width * 0.0, size.height);
    var thirdControlPoint = Offset(size.width * 0.04, size.height * 0.95);

    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndpoint.dx, thirdEndpoint.dy);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

