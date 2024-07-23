// The Swift Programming Language
// https://docs.swift.org/swift-book

import Adwaita

@main
struct AdwaitaTemplate: App {


    let id = "io.github.AparokshaUI.AdwaitaTemplate"
    var app: GTUIApp!

    var scene: Scene {
        Window(id: "main") { window in
            Content(app: app, window: window)
        }
        .defaultSize(width: 450, height: 300)
    }


}


struct Content: View {

    @State private var password = ""
    @State private var copied: Signal = .init()


    var app: GTUIApp
    var window: GTUIApplicationWindow


    var view: Body {
         VStack {
              Form {
                PasswordEntryRow(Loc.password, text: $password)
                            .suffix {
                                Button(icon: .default(icon: .editCopy)) {
                                    State<Any>.copy(password)
                                    copied.signal()
                                }
                                .flat()
                                .verticalCenter()
                                .tooltip(Loc.copy)
                                Button(icon: .default(icon: .editClear)) {
                                    password = ""
                                }
                                .flat()
                                .verticalCenter()
                                .tooltip(Loc.clear)
                            }
                        }
                      .padding()
                      Button(Loc.generate) {
                           password = createPassword(size: 12)
                      }
                      .pill()
                      .suggested()
                      .padding()
             }
            .valign(.center)
            .toast(Loc.clipboard, signal: copied)
            .topToolbar {
                ToolbarView(app: app, window: window)
            }
       }

func createPassword(size: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    let numbers = "0123456789"
    let specialChars = "!@$%#^(&)*_-+~=`|[{]}/:;<>,.?/"

    let chars = letters + numbers + specialChars
    var password = ""

    for _ in 0..<size {
        let randomIndex = Int.random(in: 0..<chars.count)
        let character = Array(chars)[randomIndex]
        password.append(character)
    }
    return password
   }
}
