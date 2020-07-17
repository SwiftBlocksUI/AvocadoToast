<h2>SwiftBlocksUI: AvocadoToast
  <img src="https://zeezide.com/img/blocksui/SwiftBlocksUIIcon256.png"
       align="right" width="100" height="100" />
</h2>

SwiftBlocksUI is a way to write interactive Slack messages and modal dialogs
(also known as Slack "applications")
using a SwiftUI like declarative style.

Explained in blog article/tutorial: 
[Instant “SwiftUI” Flavoured Slack Apps](http://www.alwaysrightinstitute.com/swiftblocksui/).

This repository contains the AvocadoToast demo.

![](http://www.alwaysrightinstitute.com/images/blocksui/client-order-form-2.png)

## How to Run

This demo requires a Slack bot authentication token, which can be found
on the 
<a href="https://api.slack.com/apps" target="Slack">Admin Panel</a>,
"OAuth & Permissions" section in the sidebar,
"Bot User OAuth Access Token".

```bash
Zini18:AvocadoToast helge$ export SLACK_ACCESS_TOKEN=xoxb-YOUR-TOKEN
Zini18:AvocadoToast helge$ swift run
2020-07-17T17:13:12+0200 notice μ.console : App started on port: 1337
```

## How to Build

```bash
cd AvocadoToast
swift build
```

Or open the `Package.swift` in Xcode and build it there.


## Sample View

```swift
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
```


## Environment Variables

- `SLACK_ACCESS_TOKEN` (the token required to send requests to Slack)
- `SLACK_VERIFICATION_TOKEN` (shared secret with Slack to verify requests)
- `PORT` (the port the app is going to start on, defaults to 1337)

## Requirements

On Linux this currently requires a Swift 5.3 environment
(swiftc crash, might be [SR-12543](https://bugs.swift.org/browse/SR-12543)).

On macOS it should work with Swift 5.2 (aka Xcode 11) and up,
though 5.3 has some additional conveniences.

### Who

**SwiftBlocksUI** is brought to you by
the
[Always Right Institute](http://www.alwaysrightinstitute.com)
and
[ZeeZide](http://zeezide.de).
We like 
[feedback](https://twitter.com/ar_institute), 
GitHub stars, 
cool [contract work](http://zeezide.com/en/services/services.html),
presumably any form of praise you can think of.
