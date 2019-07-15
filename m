From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH] drm/amd/powerplay: remove redundant memset
Date: Mon, 15 Jul 2019 19:43:32 +0800
Message-ID: <20190715114332.24634-1-huangfq.daxian@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Fuqian Huang <huangfq.daxian@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

kzalloc has already zeroed the memory.
So the memset is unneeded.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index 8fafcbdb1dfd..0fb6066997b2 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -1295,7 +1295,6 @@ static int vega20_set_default_od8_setttings(struct smu_context *smu)
 	if (!table_context->od8_settings)
 		return -ENOMEM;
 
-	memset(table_context->od8_settings, 0, sizeof(struct vega20_od8_settings));
 	od8_settings = (struct vega20_od8_settings *)table_context->od8_settings;
 
 	if (smu_feature_is_enabled(smu, FEATURE_DPM_SOCCLK_BIT)) {
-- 
2.11.0
