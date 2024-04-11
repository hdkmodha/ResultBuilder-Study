//
//  ContentView.swift
//  SampleResultBuilder
//
//  Created by Hardik Modha on 11/04/24.
//

import SwiftUI

struct ContentView: View {
    let books = Book.defaultCollection(shouldIncludeVisionOS: false)
    var body: some View {
        List {
            SwiftUI.ForEach(books, id: \.id) {
                Text($0.title)
            }
        }
    }
}

#Preview {
    ContentView()
}
