const _symbolRegExp = r'Symbol\("(.*)"\)';

extension SymbolName on Symbol {
  String? get name => RegExp(_symbolRegExp).firstMatch(toString())?.group(1);
}
