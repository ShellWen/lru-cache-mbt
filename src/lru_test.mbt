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
///|
///|
test "LruCache::new" {
  // Test creating a LruCache with a small capacity
  let cache : LruCache[String, Int] = LruCache::new(2)
  inspect!(cache.capacity(), content="2")
  inspect!(cache.size(), content="0")
}

///|
test "LruCache::put/get" {
  // Test putting and getting values in the cache
  let cache : LruCache[String, Int] = LruCache::new(2)
  cache.put("key1", 100)
  cache.put("key2", 200)
  // Access the value of "key1"
  inspect!(cache.get("key1"), content="Some(100)")
  // Adding a new key when at capacity, should evict the least recently used key ("key2")
  cache.put("key3", 300)
  inspect!(cache.get("key2"), content="None")
  inspect!(cache.get("key3"), content="Some(300)")
  inspect!(cache.size(), content="2")
}

///|
test "LruCache::get/nonexistent" {
  // Test getting a value that doesn't exist in the cache
  let cache : LruCache[String, Int] = LruCache::new(1)
  inspect!(cache.get("nonexistent_key"), content="None")
}

///|
test "LruCache::new/zero_capacity" {
  let cache : LruCache[String, Int] = LruCache::new(0)
  inspect!(cache.capacity(), content="0")
  inspect!(cache.size(), content="0")
}

///|
test "LruCache::put/eviction" {
  let cache : LruCache[String, Int] = LruCache::new(2)
  cache.put("a", 1)
  cache.put("b", 2)
  cache.put("c", 3)
  // "a" should be evicted as it's the least recently used
  inspect!(cache.has("a"), content="false")
  inspect!(cache.has("b"), content="true")
  inspect!(cache.has("c"), content="true")
  inspect!(cache.size(), content="2")
}

///|
test "LruCache::get/update_lru" {
  let cache : LruCache[String, Int] = LruCache::new(2)
  cache.put("a", 1)
  cache.put("b", 2)
  // Access "a" to make it recently used
  let _ = cache.get("a")
  cache.put("c", 3)
  // "b" should be evicted instead of "a"
  inspect!(cache.has("a"), content="true")
  inspect!(cache.has("b"), content="false")
  inspect!(cache.has("c"), content="true")
}
