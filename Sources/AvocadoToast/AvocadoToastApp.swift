import SwiftBlocksUI

struct AvocadoToast: App {
  
  var body: some Endpoints {
    Group { // only necessary w/ Swift <5.3
      Use(logger("dev"),
          bodyParser.urlencoded(),
          sslCheck(verifyToken(allowUnsetInDebug: true)))

      Shortcut("order-toast") {
        OrderForm()
      }
    }
  }
}
