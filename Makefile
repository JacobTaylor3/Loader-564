# ─────────────────────────────────────────────
#  Loader Makefile
#  Cross-compiles from Linux → Windows
#
#  Targets:
#    make           — production build (no console window)
#    make debug     — debug build (console window + printf output)
#    make clean     — remove bin/
# ─────────────────────────────────────────────

SRCS    = loader.c
WIN_OUT = bin/windows
CC      = x86_64-w64-mingw32-gcc
CFLAGS  = -std=c11 -Wall -Wextra -O2
LDFLAGS = -static -lwininet

.PHONY: all debug clean

# Production: no console window
all: $(WIN_OUT)/loader.exe

$(WIN_OUT)/loader.exe: $(SRCS)
	mkdir -p $(WIN_OUT)
	$(CC) $(CFLAGS) $(SRCS) -o $@ $(LDFLAGS) -mwindows
	@echo "[+] Production build: $@"

# Debug: keep console window so printf is visible
debug: $(WIN_OUT)/loader_debug.exe

$(WIN_OUT)/loader_debug.exe: $(SRCS)
	mkdir -p $(WIN_OUT)
	$(CC) $(CFLAGS) -DDEBUG $(SRCS) -o $@ $(LDFLAGS)
	@echo "[+] Debug build: $@"

clean:
	rm -rf bin/
	@echo "[+] Cleaned."