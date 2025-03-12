# 🧠 MoonBit LRU 缓存

[English](https://github.com/ShellWen/lru-cache-mbt/blob/master/README.md) | [简体中文](https://github.com/ShellWen/lru-cache-mbt/blob/master/README_zh_CN.md)

[![License](https://img.shields.io/github/license/ShellWen/lru-cache-mbt)](LICENSE)

**LRU Cache** 是一个用 MoonBit 实现的高性能最近最少使用（LRU）缓存。它为常见操作提供常数时间复杂度，并通过高效的淘汰策略自动管理容量。

🚀 **主要特性**

- ⚡ **快速操作** – 所有操作都具有 O(1) 时间复杂度
- 🔄 **自动淘汰** – 当达到容量上限时，自动移除最近最少使用的项目
- 🛠 **易于使用** – 简单的 API 便于快速集成
- ✅ **经过充分测试** – 拥有全面的单元测试
- 🔧 **类型安全** – 对任何键值对类型的完全类型安全实现

---

## 📥 安装

```
moon add ShellWen/lru_cache
```

## 🚀 使用指南

### 基本用法

使用 LRU 缓存的最简单方法是创建一个具有指定容量的新实例：

```moonbit
// 创建一个容量为 100 的缓存
let cache : LruCache[String, Int] = LruCache::new(100)

// 向缓存添加项目
cache.put("key1", 100)
cache.put("key2", 200)

// 从缓存获取项目
let value1 = cache.get("key1") // 返回 Some(100)
let value2 = cache.get("nonexistent") // 返回 None
```

### 主要特性说明

#### 1. 自动淘汰

当缓存达到其容量时，最近最少使用的项目会被自动移除：

```moonbit
let cache : LruCache[String, Int] = LruCache::new(2) // 容量为 2 的缓存
cache.put("key1", 100)
cache.put("key2", 200)
cache.put("key3", 300) // 这将淘汰 "key1"，因为它是最近最少使用的

let val1 = cache.get("key1") // 返回 None，因为 "key1" 已被淘汰
let val2 = cache.get("key2") // 返回 Some(200)
let val3 = cache.get("key3") // 返回 Some(300)
```

#### 2. LRU 顺序更新

访问项目时会重新排序，将最近使用的项目保留在缓存中：

```moonbit
let cache : LruCache[String, Int] = LruCache::new(2)
cache.put("key1", 100)
cache.put("key2", 200)

// 访问 "key1" 使其成为最近使用的项目
let _ = cache.get("key1")

// 添加新项目现在将淘汰 "key2" 而不是 "key1"
cache.put("key3", 300)

let val1 = cache.get("key1") // 返回 Some(100)
let val2 = cache.get("key2") // 返回 None，因为 "key2" 已被淘汰
let val3 = cache.get("key3") // 返回 Some(300)
```

#### 3. 自定义键类型

你可以使用任何实现了 `Eq + Hash` 的键类型：

```moonbit
struct CustomKey { id: Int } derive(Eq, Hash)

let cache : LruCache[CustomKey, String] = LruCache::new(10)
cache.put({id: 1}, "键 1 的值")
cache.put({id: 2}, "键 2 的值")

let value = cache.get({id: 1}) // 返回 Some("键 1 的值")
```

## 📖 API 参考

运行 `moon doc --serve` 以查看 API 文档。

## 📜 许可证

本项目遵循 Apache 许可证 2.0 版。详情请参阅 [LICENSE](https://github.com/ShellWen/lru-cache-mbt/blob/master/LICENSE)。

## 📢 联系与支持

- 作者：ShellWen Chen <me@shellwen.com>
- GitHub 问题：[报告问题](https://github.com/ShellWen/lru-cache-mbt/issues)

👋 如果你喜欢这个项目，请给它一个 ⭐！祝编码愉快！ 🚀
