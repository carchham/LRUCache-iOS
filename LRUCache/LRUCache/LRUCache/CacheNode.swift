//
//  CacheNode.swift
//  LRUCache
//
//  Created by Rahul on 31/10/26.
//

//CacheNode: Represents one linked-list node.

import Foundation

final class CacheNode<Key: Hashable, Value> {
    
    // MARK: - Properties
    
    let key: Key
    var value: Value
    
    weak var previous: CacheNode?
    var next: CacheNode?
    
    // MARK: - Initializer
    
    init(key: Key, value: Value) {
        self.key = key
        self.value = value
    }
}
