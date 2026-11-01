//
//  ContentView.swift
//  LRUCache
//
//  Created by Rahul on 31/10/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            let cache = LRUCache<String, Int>(capacity: 3)
            cache.put("A", value: 100)
            cache.put("B", value: 200)
            cache.put("C", value: 300)
            
            print(cache.get("A") ?? -1)
            cache.put("D", value: 400)
            
            print(cache.get("B") ?? -1)
            print(cache.get("C") ?? -1)
            print(cache.get("D") ?? -1)

            print("Count:", cache.count)
        }
    }
}

#Preview {
    ContentView()
}
