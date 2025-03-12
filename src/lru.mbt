// Copyright (c) 2025 ShellWen Chen <me@shellwen.com>
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
//     http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

///| LRU (Least Recently Used) Cache implementation.
///
/// LruCache objects are mutable, with fixed capacity. When capacity is reached,
/// the least recently used items are automatically removed to make space for new entries.
/// The cache guarantees O(1) complexity for common operations due to the underlying Map
/// preserving insertion order.
///
/// # Usage
///
/// ```moonbit
/// let cache : LruCache[String, Int] = LruCache::new(2)
/// cache.put("key1", 100)
/// cache.put("key2", 200)
/// // Accessing key1 marks it as recently used
/// let val = cache.get("key1") // Some(100)
/// // Adding a new key when at capacity evicts the least recently used key (key2)
/// cache.put("key3", 300)
/// let val2 = cache.get("key2") // None, key2 was evicted
/// ```
///
/// The cache can be used with any key type that implements Eq + Hash:
///
/// ```moonbit
/// struct CustomKey { id: Int } derive(Eq, Hash)
/// 
/// let cache : LruCache[CustomKey, Int] = LruCache::new(10)
/// ```
pub struct LruCache[K, V] {
  // `capacity` means the max size of the cache. After the cache is full, the least recently used item will be removed.
  capacity : UInt
  // `cache` is a map that stores the key-value pairs.
  cache : Map[K, V]
}

///| Create a new LruCache with the given capacity.
/// The cache will be empty at the beginning.
pub fn LruCache::new[K : Eq + Hash, V](capacity : UInt) -> LruCache[K, V] {
  { capacity, cache: Map::new() }
}

///| Create a new LruCache with the given capacity.
/// The cache will be empty at the beginning.
pub fn new_lru_cache[K : Eq + Hash, V](capacity : UInt) -> LruCache[K, V] {
  LruCache::new(capacity)
}

///| Get the value associated with the given key.
/// If the key is not found, return None.
pub fn LruCache::get[K : Eq + Hash, V](self : LruCache[K, V], key : K) -> V? {
  if self.cache.contains(key) {
    let value = self.cache.get(key).unwrap()
    // Move the key to the end of the cache to mark it as recently used.
    self.cache.remove(key)
    self.cache.set(key, value)
    return Some(value)
  }
  None
}

///| Put a key-value pair into the cache.
/// If the cache is full, remove the least recently used item.
/// If the key already exists, update the value and mark it as recently used.
pub fn LruCache::put[K : Eq + Hash, V](
  self : LruCache[K, V],
  key : K,
  value : V
) -> Unit {
  if self.cache.contains(key) {
    // Update the value and mark it as recently used.
    self.cache.remove(key)
    self.cache.set(key, value)
  } else {
    if self.cache.size().reinterpret_as_uint() >= self.capacity {
      // Remove the least recently used item.
      let first_key = self.cache.keys().find_first(fn(_k) { true }).unwrap()
      self.cache.remove(first_key)
    }
    self.cache.set(key, value)
  }
}

///| Get the size of the cache.
/// The size is the number of key-value pairs in the cache.
pub fn LruCache::size[K : Eq + Hash, V](self : LruCache[K, V]) -> UInt {
  self.cache.size().reinterpret_as_uint()
}

///| Get the capacity of the cache.
/// The capacity is the maximum number of key-value pairs that can be stored in the cache.
/// The capacity is set when the cache is created.
/// The capacity is not changed after the cache is created.
pub fn LruCache::capacity[K : Eq + Hash, V](self : LruCache[K, V]) -> UInt {
  self.capacity
}

///| Clear the cache.
/// This will remove all key-value pairs from the cache.
pub fn LruCache::clear[K : Eq + Hash, V](self : LruCache[K, V]) -> Unit {
  self.cache.clear()
}

///| Check if the cache contains the given key.
/// If the key is found, return true.
/// If the key is not found, return false.
pub fn LruCache::has[K : Eq + Hash, V](self : LruCache[K, V], key : K) -> Bool {
  self.cache.contains(key)
}
