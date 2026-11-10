//
//  LRUCacheTests.swift
//  LRUCacheTests
//
//  Created by Rahul on 31/10/26.
//

import XCTest
@testable import LRUCache

final class LRUCacheTests: XCTestCase {
    
    // MARK: - Basic Operations
    
    func testInsetAndGetValue() {
        
        //Arrange
        let cache = LRUCache<String, Int>(capacity: 3)
        
        //Act
        cache.put("A", value: 100)
        let result = cache.get("A")
        
        //Assert
        XCTAssertEqual(result, 100)
    }

    func testGetMissingKeyReturnsNil() {
        let cache = LRUCache<String, Int>(capacity: 3)
        
        let result = cache.get("X")
        
        XCTAssertNil(result)
    }
    
    // MARK: - LRU Eviction
    
    func testEvictsLeastRecentlyUsedItem() {
        let cache = LRUCache<String, Int>(capacity: 3)
        
        // Insert three items
        cache.put("A", value: 100)
        cache.put("B", value: 200)
        cache.put("C", value: 300)
        
        // Access A, making it most recently used
        let v = cache.get("A")
        
        // Insert D, exceeding capacity
        cache.put("D", value: 400)
        
        // Verify eviction
        XCTAssertNil(cache.get("B"))
        
        // Verify remaining items
        XCTAssertEqual(cache.get("A"), 100)
        XCTAssertEqual(cache.get("C"), 300)
        XCTAssertEqual(cache.get("D"), 400)
        
        XCTAssertEqual(cache.count, 3)
    }
    
    // MARK: - Update Existing Key
    
    func testUpdateExitingKey() {
        let cache = LRUCache<String, Int>(capacity: 2)
        
        cache.put("A", value: 100)
        cache.put("B", value: 200)
        
        cache.put("A", value: 999)
        
        XCTAssertEqual(cache.get("A"), 999)
        XCTAssertEqual(cache.count, 2)
        
        // B should be evicted when C is inserted
        cache.put("C", value: 300)
        
        XCTAssertNil(cache.get("B"))
        XCTAssertEqual(cache.get("A"), 999)
    }
    
    // MARK: - Edge Cases
    
    func testZeroCapacity() {
        let cache = LRUCache<String, Int>(capacity: 0)
        
        cache.put("A", value: 100)
        
        XCTAssertNil(cache.get("A"))
        XCTAssertEqual(cache.count, 0)
    }
    
    func testOneCapacity() {
        let cache = LRUCache<String, Int>(capacity: 1)
        
        cache.put("A", value: 100)
        
        XCTAssertEqual(cache.get("A"), 100)
        
        cache.put("B", value: 200)
        
        XCTAssertNil(cache.get("A"))
        XCTAssertEqual(cache.get("B"), 200)
        
        XCTAssertEqual(cache.count, 1)
    }
    
    func testRemoveAll() {
        let cache = LRUCache<String, Int>(capacity: 3)
        
        cache.put("A", value: 100)
        cache.put("B", value: 200)
        cache.put("C", value: 300)
        
        cache.removeAll()
        
        XCTAssertEqual(cache.count, 0)
        
        XCTAssertNil(cache.get("A"))
        XCTAssertNil(cache.get("B"))
        XCTAssertNil(cache.get("C"))
    }
}
