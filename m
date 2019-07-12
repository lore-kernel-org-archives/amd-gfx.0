From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] drm/amd/display: Support clang option for stack alignment
Date: Fri, 12 Jul 2019 11:37:00 +0200
Message-ID: <20190712093720.1461418-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: Arnd Bergmann <arnd@arndb.de>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Duke Du <Duke.Du@amd.com>, Charlene Liu <charlene.liu@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
List-Id: amd-gfx.lists.freedesktop.org

As previously fixed for dml in commit 4769278e5c7f ("amdgpu/dc/dml:
Support clang option for stack alignment") and calcs in commit
cc32ad8f559c ("amdgpu/dc/calcs: Support clang option for stack
alignment"), dcn20 uses an option that is not available with clang:

clang: error: unknown argument: '-mpreferred-stack-boundary=4'
scripts/Makefile.build:281: recipe for target 'drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.o' failed

Use the same trick that we have in the other two files.

Fixes: 7ed4e6352c16 ("drm/amd/display: Add DCN2 HW Sequencer and Resource")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |  8 +++++++-
 drivers/gpu/drm/amd/display/dc/dsc/Makefile   | 16 ++++++++++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index 1b68de27ba74..e9721a906592 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -10,7 +10,13 @@ ifdef CONFIG_DRM_AMD_DC_DSC_SUPPORT
 DCN20 += dcn20_dsc.o
 endif
 
-CFLAGS_dcn20_resource.o := -mhard-float -msse -mpreferred-stack-boundary=4
+ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
+	cc_stack_align := -mpreferred-stack-boundary=4
+else ifneq ($(call cc-option, -mstack-alignment=16),)
+	cc_stack_align := -mstack-alignment=16
+endif
+
+CFLAGS_dcn20_resource.o := -mhard-float -msse $(cc_stack_align)
 
 AMD_DAL_DCN20 = $(addprefix $(AMDDALPATH)/dc/dcn20/,$(DCN20))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
index c5d5b94e2604..e019cd9447e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
@@ -1,10 +1,18 @@
 #
 # Makefile for the 'dsc' sub-component of DAL.
 
-CFLAGS_rc_calc.o := -mhard-float -msse -mpreferred-stack-boundary=4
-CFLAGS_rc_calc_dpi.o := -mhard-float -msse -mpreferred-stack-boundary=4
-CFLAGS_codec_main_amd.o := -mhard-float -msse -mpreferred-stack-boundary=4
-CFLAGS_dc_dsc.o := -mhard-float -msse -mpreferred-stack-boundary=4
+ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
+	cc_stack_align := -mpreferred-stack-boundary=4
+else ifneq ($(call cc-option, -mstack-alignment=16),)
+	cc_stack_align := -mstack-alignment=16
+endif
+
+dsc_ccflags := -mhard-float -msse $(cc_stack_align)
+
+CFLAGS_rc_calc.o := $(dsc_ccflags)
+CFLAGS_rc_calc_dpi.o := $(dsc_ccflags)
+CFLAGS_codec_main_amd.o := $(dsc_ccflags)
+CFLAGS_dc_dsc.o := $(dsc_ccflags)
 
 DSC = dc_dsc.o rc_calc.o rc_calc_dpi.o
 
-- 
2.20.0
