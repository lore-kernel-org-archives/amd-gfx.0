From: Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 3/3] drm/amdgpu: enable -msse2 for GCC 7.1+ users
Date: Wed, 16 Oct 2019 16:02:09 -0700
Message-ID: <20191016230209.39663-4-ndesaulniers@google.com>
References: <20191016230209.39663-1-ndesaulniers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191016230209.39663-1-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: harry.wentland@amd.com, alexander.deucher@amd.com
Cc: yshuiv7@gmail.com, andrew.cooper3@citrix.com, arnd@arndb.de, clang-built-linux@googlegroups.com, mka@google.com, shirish.s@amd.com, David1.Zhou@amd.com, christian.koenig@amd.com, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>
List-Id: amd-gfx.lists.freedesktop.org

A final attempt at enabling sse2 for GCC users.

Orininally attempted in:
commit 10117450735c ("drm/amd/display: add -msse2 to prevent Clang from emitting libcalls to undefined SW FP routines")

Reverted due to "reported instability" in:
commit 193392ed9f69 ("Revert "drm/amd/display: add -msse2 to prevent Clang from emitting libcalls to undefined SW FP routines"")

Re-added just for Clang in:
commit 0f0727d971f6 ("drm/amd/display: readd -msse2 to prevent Clang from emitting libcalls to undefined SW FP routines")

The original report didn't have enough information to know if the GPF
was due to misalignment, but I suspect that it was. (The missing
information was the disassembly of the function at the bottom of the
trace, to see if the instruction pointer pointed to an instruction with
16B alignment memory operand requirements.  The stack trace does show
the stack was only 8B but not 16B aligned though, which makes this a
strong possibility).

Now that the stack misalignment issue has been fixed for users of GCC
7.1+, reattempt adding -msse2. This matches Clang.

It will likely never be safe to enable this for pre-GCC 7.1 AND use a
16B aligned stack in these translation units.

This is only a functional change for GCC 7.1+ users, and should be boot
tested.

Link: https://bugs.freedesktop.org/show_bug.cgi?id=109487
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 drivers/gpu/drm/amd/display/dc/calcs/Makefile | 4 +---
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile | 4 +---
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile | 4 +---
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 4 +---
 drivers/gpu/drm/amd/display/dc/dsc/Makefile   | 4 +---
 5 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
index a1af55a86508..26c6d735cdc7 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
@@ -37,9 +37,7 @@ ifdef IS_OLD_GCC
 # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
 # (8B stack alignment).
 calcs_ccflags += -mpreferred-stack-boundary=4
-endif
-
-ifdef CONFIG_CC_IS_CLANG
+else
 calcs_ccflags += -msse2
 endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index cb0ac131f74a..63f3bddba7da 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -23,9 +23,7 @@ ifdef IS_OLD_GCC
 # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
 # (8B stack alignment).
 CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o += -mpreferred-stack-boundary=4
-endif
-
-ifdef CONFIG_CC_IS_CLANG
+else
 CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o += -msse2
 endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
index f92320ddd27f..ff50ae71fe27 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
@@ -16,9 +16,7 @@ ifdef IS_OLD_GCC
 # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
 # (8B stack alignment).
 CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o += -mpreferred-stack-boundary=4
-endif
-
-ifdef CONFIG_CC_IS_CLANG
+else
 CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o += -msse2
 endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index ef1bdd20b425..8df251626e22 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -37,9 +37,7 @@ ifdef IS_OLD_GCC
 # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
 # (8B stack alignment).
 dml_ccflags += -mpreferred-stack-boundary=4
-endif
-
-ifdef CONFIG_CC_IS_CLANG
+else
 dml_ccflags += -msse2
 endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
index 3f7840828a9f..970737217e53 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
@@ -14,9 +14,7 @@ ifdef IS_OLD_GCC
 # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
 # (8B stack alignment).
 dsc_ccflags += -mpreferred-stack-boundary=4
-endif
-
-ifdef CONFIG_CC_IS_CLANG
+else
 dsc_ccflags += -msse2
 endif
 
-- 
2.23.0.700.g56cf767bdb-goog
