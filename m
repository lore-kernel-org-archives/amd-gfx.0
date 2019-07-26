From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] drm/amd/display: remove duplicated include from dc_link.c
Date: Fri, 26 Jul 2019 15:51:31 +0800
Message-ID: <20190726075131.14688-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Bhawanpreet.Lakha@amd.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, YueHaibing <yuehaibing@huawei.com>
List-Id: amd-gfx.lists.freedesktop.org

Remove duplicated include.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 193d6f1..a14785d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -45,10 +45,6 @@
 #include "dpcd_defs.h"
 #include "dmcu.h"
 #include "hw/clk_mgr.h"
-#if defined(CONFIG_DRM_AMD_DC_DCN2_0)
-#include "resource.h"
-#endif
-#include "hw/clk_mgr.h"
 
 #define DC_LOGGER_INIT(logger)
 
-- 
2.7.4
