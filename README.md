# 🧠 LRU Cache for MoonBit

[English](https://github.com/ShellWen/lru-cache-mbt/blob/main/README.md) | [简体中文](https://github.com/ShellWen/lru-cache-mbt/blob/main/README_zh_CN.md)

[![License](https://img.shields.io/github/license/ShellWen/lru-cache-mbt)](LICENSE)

**LRU Cache** is a high-performance Least Recently Used (LRU) cache implementation in MoonBit. It provides constant-time complexity for common operations and automatically manages capacity with an efficient eviction policy.

🚀 **Key Features**

- ⚡ **Fast Operations** – All operations run in O(1) time complexity
- 🔄 **Automatic Eviction** – Automatically removes least recently used items when capacity is reached
- 🛠 **Easy to Use** – Simple API for quick integration
- ✅ **Well-Tested** – Comes with comprehensive unit tests
- 🔧 **Type Safe** – Fully type-safe implementation for any key-value pair types

---

## 📥 Installation

```
moon add ShellWen/lru_cache
```

## 🚀 Usage Guide

### Basic Usage

The simplest way to use the LRU cache is to create a new instance with a specified capacity:

```moonbit
// Create a cache with capacity 100
let cache : LruCache[String, Int] = LruCache::new(100)

// Add items to cache
cache.put("key1", 100)
cache.put("key2", 200)

// Get items from cache
let value1 = cache.get("key1") // Returns Some(100)
let value2 = cache.get("nonexistent") // Returns None
```

### Key Features Explained

#### 1. Automatic Eviction

When the cache reaches its capacity, the least recently used item is automatically removed:

```moonbit
let cache : LruCache[String, Int] = LruCache::new(2) // Cache with capacity 2
cache.put("key1", 100)
cache.put("key2", 200)
cache.put("key3", 300) // This will evict "key1" as it's the least recently used

let val1 = cache.get("key1") // Returns None, as "key1" was evicted
let val2 = cache.get("key2") // Returns Some(200)
let val3 = cache.get("key3") // Returns Some(300)
```

#### 2. LRU Order Update

Items are reordered when accessed, keeping the most recently used items in the cache:

```moonbit
let cache : LruCache[String, Int] = LruCache::new(2)
cache.put("key1", 100)
cache.put("key2", 200)

// Accessing "key1" makes it the most recently used
let _ = cache.get("key1")

// Adding a new item will now evict "key2" instead of "key1"
cache.put("key3", 300)

let val1 = cache.get("key1") // Returns Some(100)
let val2 = cache.get("key2") // Returns None, as "key2" was evicted
let val3 = cache.get("key3") // Returns Some(300)
```

#### 3. Custom Key Types

You can use any key type that implements `Eq + Hash`:

```moonbit
struct CustomKey { id: Int } derive(Eq, Hash)

let cache : LruCache[CustomKey, String] = LruCache::new(10)
cache.put({id: 1}, "Value for key 1")
cache.put({id: 2}, "Value for key 2")

let value = cache.get({id: 1}) // Returns Some("Value for key 1")
```

## 📖 API Reference

Run `moon doc --serve` to view the API documentation.

## 📜 License

This project is licensed under the Apache License 2.0. See [LICENSE](https://github.com/ShellWen/lru-cache-mbt/blob/main/LICENSE) for details.

## 📢 Contact & Support

- Author: ShellWen Chen <me@shellwen.com>
- GitHub Issues: [Report an issue](https://github.com/ShellWen/lru-cache-mbt/issues)

👋 If you like this project, give it a ⭐! Happy coding! 🚀
