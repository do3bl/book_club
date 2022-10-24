class TimeLeft {
  static timeLeft(DateTime due) {
    // List<String> retVal = [];
    String? testtt;
    Duration _timeUntilDus = due.difference(DateTime.now());
    int _daysUntil = _timeUntilDus.inDays;
    int _hoursUntil = _timeUntilDus.inHours - (_daysUntil * 24);
    int _minUntil =
        _timeUntilDus.inMinutes - (_daysUntil * 24 * 60) - (_hoursUntil * 60);
    int _setUntil = _timeUntilDus.inSeconds -
        (_daysUntil * 24 * 60 * 60) -
        (_hoursUntil * 60 * 60) -
        (_minUntil * 60);
    if (_daysUntil > 0) {
      // retVal.add(_daysUntil.toString() +
      //     " days\n" +
      //     _hoursUntil.toString() +
      //     " hours\n" +
      //     _minUntil.toString() +
      //     " mins\n" +
      //     _setUntil.toString() +
      //     " secs");
      testtt = _daysUntil.toString() +
          " days\n" +
          _hoursUntil.toString() +
          " hours\n" +
          _minUntil.toString() +
          " mins\n" +
          _setUntil.toString() +
          " secs";
    } else if (_hoursUntil > 0) {
      // retVal.add(_hoursUntil.toString() +
      //     " hours\n" +
      //     _minUntil.toString() +
      //     " mins\n" +
      //     _setUntil.toString() +
      //     " secs");
      testtt = _hoursUntil.toString() +
          " hours\n" +
          _minUntil.toString() +
          " mins\n" +
          _setUntil.toString() +
          " secs";
    } else if (_minUntil > 0) {
      // retVal.add(
      //     _minUntil.toString() + " mins\n" + _setUntil.toString() + " secs");
      testtt =
          _minUntil.toString() + " mins\n" + _setUntil.toString() + " secs";
    } else if (_setUntil > 0) {
      // retVal.add(_setUntil.toString() + " secs");
      testtt = _setUntil.toString() + " secs";
    } else {
      // retVal.add("time end");
      testtt = "time end";
    }
    return testtt;
    //   Duration _timeUntilreveal =
    //       due.subtract(Duration(days: 7)).difference(DateTime.now());
    //   int _daysUntilReveal = _timeUntilreveal.inDays;
    //   int _hoursUntilReveal = _timeUntilreveal.inHours - (_daysUntilReveal * 24);
    //   int _minUntilReveal = _timeUntilreveal.inMinutes -
    //       (_daysUntilReveal * 24 * 60) -
    //       (_hoursUntilReveal * 60);
    //   int _setUntilReveal = _timeUntilreveal.inSeconds -
    //       (_daysUntilReveal * 24 * 60 * 60) -
    //       (_hoursUntilReveal * 60 * 60) -
    //       (_minUntilReveal * 60);
    //   if (_daysUntil > 0) {
    //     retVal.add(_daysUntilReveal.toString() +
    //         " days\n" +
    //         _hoursUntilReveal.toString() +
    //         " hours\n" +
    //         _minUntilReveal.toString() +
    //         " mins\n" +
    //         _setUntilReveal.toString() +
    //         " secs");
    //   } else if (_hoursUntilReveal > 0) {
    //     retVal.add(_hoursUntilReveal.toString() +
    //         " hours\n" +
    //         _minUntilReveal.toString() +
    //         " mins\n" +
    //         _setUntilReveal.toString() +
    //         " secs");
    //   } else if (_minUntilReveal > 0) {
    //     retVal.add(_minUntilReveal.toString() +
    //         " mins\n" +
    //         _setUntilReveal.toString() +
    //         " secs");
    //   } else if (_setUntilReveal > 0) {
    //     retVal.add(_setUntilReveal.toString() + " secs");
    //   } else {
    //     retVal.add("time end");
    //   }
    //   return retVal;
  }
}
