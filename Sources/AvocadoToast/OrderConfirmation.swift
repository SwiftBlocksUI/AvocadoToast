import Foundation
import SwiftBlocksUI

struct OrderConfirmation: Blocks {
  
  let user  : String
  let order : Order
  
  struct TitledField<C: Blocks>: Blocks {
    let title : String
    let content : C
    
    init(_ title: String, @BlocksBuilder content: () -> C) {
      self.title   = title
      self.content = content()
    }
    
    var body: some Blocks {
      Group {
        Field { Text("\(title):").bold() }
        Field { content }
      }
    }
  }
  
  private let logo =
    Image("ZeeYou",
          url: URL(string: "https://zeezide.com/img/zz2-256x256.png")!)

  var body: some Blocks {
    Section {
      Accessory { logo }
      
      "\(user), thanks for your 🥑🍞 order!"
      
      Group {
        TitledField("Quantity") { "\(order.quantity)"     }
        TitledField("Bread")    { order.breadType.name    }
        TitledField("Style")    { order.avocadoStyle.name }
      
        if order.spread != .none {
          TitledField("Spread") { order.spread.name }
        }

        if order.includeRedPepperFlakes || order.includeSalt {
          TitledField("Extras") {
            if order.includeRedPepperFlakes { "🌶" }
            if order.includeSalt            { "🧂" }
          }
        }
      }
    }
  }
}
