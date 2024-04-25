class User {
  var _uid;
  var _name;
  var _email;
  var _genre;
  var _isRunningFavorite;
  var _isCyclingFavorite;
  var _isSwimmingFavorite;
  var _bornDate;

  User.Empty();

  get uid => _uid;

  set uid(value) {
    _uid = value;
  }

  get name => _name;

  set name(value) {
    _name = value;
  }

  get email => _email;

  get bornDate => _bornDate;

  set bornDate(value) {
    _bornDate = value;
  }

  get isSwimmingFavorite => _isSwimmingFavorite;

  set isSwimmingFavorite(value) {
    _isSwimmingFavorite = value;
  }

  get isCyclingFavorite => _isCyclingFavorite;

  set isCyclingFavorite(value) {
    _isCyclingFavorite = value;
  }

  get isRunningFavorite => _isRunningFavorite;

  set isRunningFavorite(value) {
    _isRunningFavorite = value;
  }

  get genre => _genre;

  set genre(value) {
    _genre = value;
  }

  set email(value) {
    _email = value;
  }

  User(
      this._uid,
      this._name,
      this._email,
      this._genre,
      this._isRunningFavorite,
      this._isCyclingFavorite,
      this._isSwimmingFavorite,
      this._bornDate);

  Map<String, dynamic> toJson() => {
        'uid': _uid,
        'name': _name,
        'email': _email,
        'genre': _genre,
        'isRunningFavorite': _isRunningFavorite,
        'isCyclingFavorite': _isCyclingFavorite,
        'isSwimmingFavorite': _isSwimmingFavorite,
        'bornDate': _bornDate,
      };

  User.fromJson(Map<String, dynamic> json)
      : _uid = json['uid'],
        _name = json['name'],
        _email = json['email'],
        _genre = json['genre'],
        _isRunningFavorite = json['isRunningFavorite'],
        _isCyclingFavorite = json['isCyclingFavorite'],
        _isSwimmingFavorite = json['isSwimmingFavorite'],
        _bornDate = json['bornDate'];
}
