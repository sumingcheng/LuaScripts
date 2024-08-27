# 默认情况下，FILE 变量为空
FILE ?=

# 验证是否已提供脚本名，如果没有则终止执行
check-script:
ifndef FILE
	$(error No FILE specified. Use 'make run FILE=name_of_script.lua' to specify a script)
endif

# 加载脚本到 Redis 并获取 SHA1
load: check-script
	$(eval SHA1 := $(shell cat $(FILE) | redis-cli SCRIPT LOAD))
	@echo "Script $(FILE) loaded with SHA1: $(SHA1)"

# 执行脚本，需要确保 load 被首先调用或已经加载过脚本
run: load
	@echo "Running script $(FILE)..."
	@redis-cli EVALSHA $(SHA1) 0

.PHONY: load run check-script
