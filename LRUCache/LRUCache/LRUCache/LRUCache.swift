//
//  LRUCache.swift
//  LRUCache
//
//  Created by Rahul on 31/10/26.
//

import Foundation

final class LRUCache<Key: Hashable, Value> {
    
    //MARK: - Properties
    
    private let capacity: Int
    private var cache: [Key: CacheNode<Key, Value>] = [:]
    private var head: CacheNode<Key, Value>?
    private var tail: CacheNode<Key, Value>?
    
    //MARK: - Initializer
    
    init(capacity: Int) {
        precondition(capacity >= 0,"Capacity cannot be negative")
        self.capacity = capacity
    }
    
    var count: Int {
        cache.count
    }
    
    func get(_ key: Key) -> Value? {
        
        //Check whether key exists
        guard let node = cache[key] else {
            return nil
        }
        
        //Mark node as recently used
        moveToHead(node)
        
        //return its value
        return node.value
    }
    
    func put(_ key: Key, value: Value) {
        
        //Scenario 1: Capacity is zero
        guard capacity > 0 else { return }
        
        //Scenario 2: Update existing item
        if let existingNode = cache[key] {
            existingNode.value = value
            moveToHead(existingNode)
            return
        }
        
        //Scenario 3: Create new item
        let newNode = CacheNode(key: key, value: value)
        
        //Store node in dictionary
        cache[key] = newNode
        
        //Insert node at beginning
        addToHead(newNode)
        
        //Scenario 4: Check capacity
        if cache.count > capacity {
            removeLRU()
        }
    }
    
    //MARK: - Move To Head
    
    private func moveToHead(_ node: CacheNode<Key, Value>) {
        removeNode(node)
        addToHead(node)
    }
    
    //MARK: - Add To Head
    
    private func addToHead(_ node: CacheNode<Key, Value>) {
        
        //New node has no previous node
        node.previous = nil
        
        //Connect new node to current head
        node.next = head
        
        //Current head point back to new node
        head?.previous = node
        
        //Update node
        head = node
        
        //if list was empty, this is also the tail
        if tail == nil {
            tail = node
        }
    }
    
    //MARK: - Remove Node
    
    private func removeNode(_ node: CacheNode<Key, Value>) {
        
        let previous = node.previous
        let next = node.next
        
        //Connect previous node to next node
        if let previous {
            previous.next = next
        } else {
            head = next
        }
        
        //Connect next to previous node
        if let next {
            next.previous = previous
        } else {
            tail = previous
        }
        
        //Disconnect removed node
        node.previous = nil
        node.next = nil
    }
    
    //MARK: - Remove LRU
    
    private func removeLRU() {
        
        guard let lastNode = tail else { return }
        removeNode(lastNode)
        cache.removeValue(forKey: lastNode.key)
    }
    
    //MARK: - Remove All
    
    func removeAll() {
        cache.removeAll()
        head = nil
        tail = nil
    }
}
