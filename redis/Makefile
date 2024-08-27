# 默认情况下，lua 变量为空
lua ?=

# 验证是否已提供脚本名，如果没有则终止执行
check-script:
ifndef lua
	$(error No script specified. Use 'make run lua=name_of_script.lua' to specify a script)
endif

# 加载脚本到 Redis 并获取 SHA1
load: check-script
	$(eval SHA1 := $(shell cat $(lua) | redis-cli SCRIPT LOAD))
	@if [ -z "$(SHA1)" ]; then echo "Error loading script. Make sure redis-cli is available and Redis is running."; exit 1; fi
	@echo "Script $(lua) loaded with SHA1: $(SHA1)"

# 执行脚本，需要确保 load 被首先调用或已经加载过脚本
run: load
	@echo "Running script $(lua)..."
	@redis-cli EVALSHA $(SHA1) 0 || echo "Failed to execute script. Check SHA1 and Redis server status."

.PHONY: load run check-script
