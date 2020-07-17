enum AvocadoStyle {
  case sliced, mashed
  var name: String { return "\(self)".capitalized }
}

enum BreadType: CaseIterable, Hashable, Identifiable {
  case wheat, white, rhy
  
  var name: String { return "\(self)".capitalized }
}

enum Spread: CaseIterable, Hashable, Identifiable {
  case none, almondButter, peanutButter, honey
  case almou, tapenade, hummus, mayonnaise
  case kyopolou, adjvar, pindjur
  case vegemite, chutney, cannedCheese, feroce
  case kartoffelkase, tartarSauce

  var name: String {
    return "\(self)".map { $0.isUppercase ? " \($0)" : "\($0)" }
           .joined().capitalized
  }
}
