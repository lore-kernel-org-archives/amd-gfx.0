From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] Revert "drm/amd/display: add -msse2 to prevent Clang from emitting libcalls to undefined SW FP routines"
Date: Tue, 29 Jan 2019 11:57:25 -0500
Message-ID: <20190129165725.31062-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

This reverts commit 10117450735c7a7c0858095fb46a860e7037cb9a.

Causes a crash.

Bug: https://bugs.freedesktop.org/show_bug.cgi?id=109487
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 4.19
---
 drivers/gpu/drm/amd/display/dc/calcs/Makefile | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
index dc85a3c088af..95f332ee3e7e 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
@@ -30,7 +30,7 @@ else ifneq ($(call cc-option, -mstack-alignment=16),)
 	cc_stack_align := -mstack-alignment=16
 endif
 
-calcs_ccflags := -mhard-float -msse -msse2 $(cc_stack_align)
+calcs_ccflags := -mhard-float -msse $(cc_stack_align)
 
 CFLAGS_dcn_calcs.o := $(calcs_ccflags)
 CFLAGS_dcn_calc_auto.o := $(calcs_ccflags)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 33c7d7588712..d97ca6528f9d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -30,7 +30,7 @@ else ifneq ($(call cc-option, -mstack-alignment=16),)
 	cc_stack_align := -mstack-alignment=16
 endif
 
-dml_ccflags := -mhard-float -msse -msse2 $(cc_stack_align)
+dml_ccflags := -mhard-float -msse $(cc_stack_align)
 
 CFLAGS_display_mode_lib.o := $(dml_ccflags)
 CFLAGS_display_pipe_clocks.o := $(dml_ccflags)
-- 
2.20.1
