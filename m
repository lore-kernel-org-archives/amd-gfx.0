From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Subject: [PATCH 1/1] drm/amd/powerplay: fix misspelling in header guard
Date: Sun, 22 Jan 2017 14:47:39 +0100
Message-ID: <20170122134739.12187-1-nicolas.iooss_linux@m4x.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Nicolas Iooss <nicolas.iooss_linux@m4x.org>
List-Id: amd-gfx.lists.freedesktop.org

In smu7_clockpowergating.h, the #ifndef statement which prevents
multiple inclusions of the header file uses _SMU7_CLOCK_POWER_GATING_H_
but the following #define statement uses _SMU7_CLOCK__POWER_GATING_H_.

Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.h b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.h
index d52a28c343e3..c96ed9ed7eaf 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.h
@@ -22,7 +22,7 @@
  */
 
 #ifndef _SMU7_CLOCK_POWER_GATING_H_
-#define _SMU7_CLOCK__POWER_GATING_H_
+#define _SMU7_CLOCK_POWER_GATING_H_
 
 #include "smu7_hwmgr.h"
 #include "pp_asicblocks.h"
-- 
2.11.0
