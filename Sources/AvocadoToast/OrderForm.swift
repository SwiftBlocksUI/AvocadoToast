import Foundation
import SwiftBlocksUI

struct Order {
  var includeSalt            = false
  var includeRedPepperFlakes = false
  var quantity               = 1

  var avocadoStyle           = AvocadoStyle.sliced
  var spread                 = Spread.none
  var breadType              = BreadType.wheat
}

struct OrderForm: Blocks {
  
  @Environment(\.client) private var client
  @Environment(\.user)   private var user

  @State private var order = Order()
  
  private func submitOrder() {
    console.log("User:", user, "did order:", order)
    
    let confirmationMessage =
      OrderConfirmation(user: user.username, order: order)
    
    client.chat.sendMessage(confirmationMessage, to: user.id) { error in
      error.flatMap { console.error("order confirmation failed!", $0) }
    }
  }
  
  var body: some Blocks {
    View("Order Avocado Toast") {
      
      Picker("Bread", selection: $order.breadType) {
        ForEach(BreadType.allCases) { breadType in
          Text(breadType.name).tag(breadType)
        }
      }
      
      Picker("Avocado", selection: $order.avocadoStyle) {
        "Sliced".tag(AvocadoStyle.sliced)
        "Mashed".tag(AvocadoStyle.mashed)
      }
      
      Picker("Spread", Spread.allCases, selection: $order.spread) { spread in
        spread.name
      }
      
      Checkboxes("Extras") {
        Toggle("Include Salt 🧂",
               isOn: $order.includeSalt)
        Toggle("Include Red Pepper Flakes 🌶",
               isOn: $order.includeRedPepperFlakes)
      }
      TextField("Quantity",
                value: $order.quantity, formatter: NumberFormatter())
      
      Submit("Order", action: submitOrder)
    }
  }
}
