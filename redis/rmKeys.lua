-- 从外部传入的键列表，存储在变量 keys 中
local keys = KEYS

-- 遍历 keys 数组中的每一个键
for i = 1, #keys do
    -- 使用 Redis 的 DEL 命令删除当前遍历到的键
    redis.call('DEL', keys[i])
end

-- 返回删除的键的数量
return #keys
