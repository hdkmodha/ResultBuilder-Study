# ResultBuilder-Study
A sample code for understanding Swift's result-builder.

```swift
struct Book {
    let id: UUID
    var title: String
    
    init(id: UUID = .init(), title: String) {
        self.id = id
        self.title = title
    }
    
    init?(optional title: String) {
        if title.lowercased().contains("backing") {
            return nil
        }
        self = .init(id: UUID(), title: title)
    }
}

struct ForEach {
    var books: [Book]
    
    init(count: Int, book: (Int) -> Book) {
        self.books = []
        for i in 0..<count {
            books.append(book(i))
        }
    }
}

extension Book {
    static func defaultCollection(shouldIncludeVisionOS: Bool) -> [Book] {
        .init {
            Book(title: "Hacking with iOS")
            Book(title: "Hacking with macOS")
            
            if shouldIncludeVisionOS {
                Book(title: "Hacking with VisionOS")
            }
            
            Book(optional: "Shaking with VisionOS")
            
            #if canImport(SwiftUI)
            Book(title: "Hacking with SwiftUI")
            #endif
            
            #if canImport(AppKit)
            Book(title: "Hacking With AppKit")
            #endif
            
            #if canImport(AVFoundation)
            Book(title: "Hacking With AVFoundation")
            #endif
            
            //#if canImport(AppExtension)
            Book(title: "Hacking with AppExtesnsion")
            //#endif
            
            "Hacking with Strings"
            
            ("Hacking With Hardik", repeating: 5)
            
            ForEach(count: Int.random(in: 2...5)) { index in
                Book(title: "Hacking with index\(index + 1)")
            }
        }
    }
}
```
