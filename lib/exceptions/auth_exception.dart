class AuthException implements Exception {

  static const Map<String,String> errors = {
    'EMAIL_EXISTS' : 'O endereço de e-mail já está sendo usado por outra conta.',
    'OPERATION_NOT_ALLOWED' : 'O login por senha está desabilitado para este projeto.',
    'TOO_MANY_ATTEMPTS_TRY_LATER' : 'Bloqueamos todas as solicitações deste dispositivo devido a atividades incomuns. Tente mais tarde.',
    'EMAIL_NOT_FOUND' : 'Não há registro de usuário correspondente a este identificador. O usuário pode ter sido excluído.',
    'INVALID_PASSWORD' : 'A senha é inválida ou o usuário não possui senha.',
    'USER_DISABLED' : 'A conta de usuário foi desabilitada por um administrador.',
    'INVALID_LOGIN_CREDENTIALS' : 'Dados de Login Inválidos.',
  };

  final String msg;
  
  AuthException(this.msg);

  @override
  String toString() {
    return errors[msg] ?? 'Ocorreu um erro inesperado';
  }
}