From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/2] amdgpu/dc/dml: Consolidate redundant CFLAGS
Date: Wed,  7 Feb 2018 17:21:55 -0800
Message-ID: <20180208012156.165934-1-mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Harry Wentland <harry.wentland@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, Justin TerAvest <teravest@chromium.org>, Craig Bergstrom <craigb@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: amd-gfx.lists.freedesktop.org

Use subdir-ccflags instead of specifying the same flags for every source
file.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/gpu/drm/amd/display/dc/dml/Makefile | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 3488af2b5786..b8cadf833e71 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -24,15 +24,7 @@
 # It provides the general basic services required by other DAL
 # subcomponents.
 
-CFLAGS_display_mode_vba.o := -mhard-float -msse -mpreferred-stack-boundary=4
-CFLAGS_display_mode_lib.o := -mhard-float -msse -mpreferred-stack-boundary=4
-CFLAGS_display_pipe_clocks.o := -mhard-float -msse -mpreferred-stack-boundary=4
-CFLAGS_display_rq_dlg_calc.o := -mhard-float -msse -mpreferred-stack-boundary=4
-CFLAGS_dml1_display_rq_dlg_calc.o := -mhard-float -msse -mpreferred-stack-boundary=4
-CFLAGS_display_rq_dlg_helpers.o := -mhard-float -msse -mpreferred-stack-boundary=4
-CFLAGS_soc_bounding_box.o := -mhard-float -msse -mpreferred-stack-boundary=4
-CFLAGS_dml_common_defs.o := -mhard-float -msse -mpreferred-stack-boundary=4
-
+subdir-ccflags-y += -mhard-float -msse -mpreferred-stack-boundary=4
 
 DML = display_mode_lib.o display_rq_dlg_calc.o \
 	  display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o \
-- 
2.16.0.rc1.238.g530d649a79-goog
