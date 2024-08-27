lua ?=

all: check-script load run

check-script:
ifndef lua
	$(error 未指定脚本。请使用 'make lua=name_of_script.lua' 来指定一个脚本文件)
endif

load:
	$(eval SHA1 := $(shell redis-cli SCRIPT LOAD `cat $(lua)`))
	@if [ -z "$(SHA1)" ]; then echo "错误：加载脚本失败。请确保 redis-cli 可用并且 Redis 服务器正在运行。"; exit 1; fi
	@echo "脚本 $(lua) 已加载，SHA1: $(SHA1)"

run:
	@echo "正在运行脚本 $(lua)..."
	@redis-cli EVALSHA $(SHA1) 0 || echo "执行脚本失败。请检查 SHA1 和 Redis 服务器状态。"

.PHONY: all load run check-script
