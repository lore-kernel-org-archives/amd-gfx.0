From: ndesaulniers@google.com
Subject: [PATCH] drm/amd/display: add -msse2 to prevent Clang from emitting
 libcalls to undefined SW FP routines
Date: Thu, 24 Jan 2019 16:52:59 -0800
Message-ID: <20190125005304.183322-1-ndesaulniers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: airlied@linux.ie, daniel@ffwll.ch
Cc: Nick Desaulniers <ndesaulniers@google.com>, stable@vger.kernel.org, S@google.com, Shirish <Shirish.S@amd.com>, Matthias Kaehlcke <mka@google.com>, James Y Knight <jyknight@google.com>, Nathan Chancellor <natechancellor@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Matthias Kaehlcke <mka@chromium.org>, =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

arch/x86/Makefile disables SSE and SSE2 for the whole kernel.  The
AMDGPU drivers modified in this patch re-enable SSE but not SSE2.  Turn
on SSE2 to support emitting double precision floating point instructions
rather than calls to non-existent (usually available from gcc_s or
compiler_rt) floating point helper routines.

Link: https://gcc.gnu.org/onlinedocs/gccint/Soft-float-library-routines.html
Link: https://github.com/ClangBuiltLinux/linux/issues/327
Cc: stable@vger.kernel.org # 4.19
Reported-by: S, Shirish <Shirish.S@amd.com>
Reported-by: Matthias Kaehlcke <mka@google.com>
Suggested-by: James Y Knight <jyknight@google.com>
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/gpu/drm/amd/display/dc/calcs/Makefile | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
index 95f332ee3e7e..dc85a3c088af 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
@@ -30,7 +30,7 @@ else ifneq ($(call cc-option, -mstack-alignment=16),)
 	cc_stack_align := -mstack-alignment=16
 endif
 
-calcs_ccflags := -mhard-float -msse $(cc_stack_align)
+calcs_ccflags := -mhard-float -msse -msse2 $(cc_stack_align)
 
 CFLAGS_dcn_calcs.o := $(calcs_ccflags)
 CFLAGS_dcn_calc_auto.o := $(calcs_ccflags)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index d97ca6528f9d..33c7d7588712 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -30,7 +30,7 @@ else ifneq ($(call cc-option, -mstack-alignment=16),)
 	cc_stack_align := -mstack-alignment=16
 endif
 
-dml_ccflags := -mhard-float -msse $(cc_stack_align)
+dml_ccflags := -mhard-float -msse -msse2 $(cc_stack_align)
 
 CFLAGS_display_mode_lib.o := $(dml_ccflags)
 CFLAGS_display_pipe_clocks.o := $(dml_ccflags)
-- 
2.20.1.321.g9e740568ce-goog
