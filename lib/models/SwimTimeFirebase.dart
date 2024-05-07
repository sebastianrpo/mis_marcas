class SwimTimeFirebase{

  var _id;
  var _dateTournament;
  var _poolSize;
  var _time;
  var _toSwim;
  var _tournamentName;

  get id => _id;

  set id(value) {
    _id = value;
  }

  get dateTournament => _dateTournament;

  get tournamentName => _tournamentName;

  set tournamentName(value) {
    _tournamentName = value;
  }

  get toSwim => _toSwim;

  set toSwim(value) {
    _toSwim = value;
  }

  get time => _time;

  set time(value) {
    _time = value;
  }

  get poolSize => _poolSize;

  set poolSize(value) {
    _poolSize = value;
  }

  set dateTournament(value) {
    _dateTournament = value;
  }

  Map<String, dynamic> toJson() => {
    'id': _id,
    'dateTournament': _dateTournament,
    'poolSize': _poolSize,
    'time': _time,
    'toSwim': _toSwim,
    'tournamentName': _tournamentName
  };

  SwimTimeFirebase.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _dateTournament = json['dateTournament'],
        _poolSize = json['poolSize'],
        _time = json['time'],
        _toSwim = json['toSwim'],
        _tournamentName = json['tournamentName'];

  SwimTimeFirebase(this._id, this._dateTournament, this._poolSize, this._time,
      this._toSwim, this._tournamentName);
}