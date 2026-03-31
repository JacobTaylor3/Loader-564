# ─────────────────────────────────────────────
#  Loader Makefile
#  Cross-compiles from Linux → Windows
#
#  Targets:
#    make         — build loader.exe
#    make clean   — remove bin/
# ─────────────────────────────────────────────

# --- Sources ---
SRCS = loader.c

# --- Output ---
WIN_OUT = bin/windows

# --- Compiler (MinGW cross-compiler) ---
CC = x86_64-w64-mingw32-gcc

# --- Flags ---
CFLAGS  = -std=c11 -Wall -Wextra -O2
# -mwindows  : suppress console window (pairs with SW_HIDE)
# -lwininet  : WinINet (InternetOpen, InternetOpenUrl, etc.)
LDFLAGS = -mwindows -lwininet

# ─────────────────────────────────────────────
#  Targets
# ─────────────────────────────────────────────

.PHONY: all clean

all: $(WIN_OUT)/loader.exe

$(WIN_OUT)/loader.exe: $(SRCS)
	mkdir -p $(WIN_OUT)
	$(CC) $(CFLAGS) $(SRCS) -o $@ $(LDFLAGS)
	@echo "[+] Built: $@"

clean:
	rm -rf bin/
	@echo "[+] Cleaned."