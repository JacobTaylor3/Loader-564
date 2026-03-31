# ─────────────────────────────────────────────
#  Loader Makefile
#  Cross-compiles from Linux → Windows (static)
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
# -static    : statically links MinGW runtime (libgcc, libmingwex)
#              so the .exe doesn't need MinGW DLLs on the target machine.
#              Note: wininet.dll is a Windows system DLL and will always
#              be dynamically linked — this is unavoidable on any Windows build.
# -mwindows  : suppress console window (pairs with SW_HIDE)
# -lwininet  : WinINet (InternetOpen, InternetOpenUrl, etc.)
LDFLAGS = -static -mwindows -lwininet

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