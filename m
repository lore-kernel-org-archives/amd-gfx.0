From: rajan.vaja@gmail.com
Subject: [PATCH] drm/amd/pp: Fix uninitialized variable
Date: Mon, 18 Jun 2018 13:01:02 +0530
Message-ID: <1529307062-21787-1-git-send-email-rajan.vaja@softnautics.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, Rex.Zhu@amd.com, tom.stdenis@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

From: Rajan Vaja <rajan.vaja@gmail.com>

Initialize variable to 0 before performing logical OR operation.

Signed-off-by: Rajan Vaja <rajan.vaja@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
index a9efd855..bde01d4 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
@@ -1090,7 +1090,7 @@ static int vega10_disable_se_edc_config(struct pp_hwmgr *hwmgr)
 static int vega10_enable_psm_gc_edc_config(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
-	int result;
+	int result = 0;
 	uint32_t num_se = 0;
 	uint32_t count, data;
 
-- 
2.7.4
