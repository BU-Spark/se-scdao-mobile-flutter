class Token {
  final String token;

  const Token({
    required this.token
  });

factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      token: json['access_token'] as String
    );
  }
}