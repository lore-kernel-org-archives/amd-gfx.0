From: Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amd/powerplay: Remove useless set memory to zero use memset()
Date: Sat, 23 Mar 2019 21:32:16 +0800
Message-ID: <20190323133216.16900-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rex.zhu@amd.com, evan.quan@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, YueHaibing <yuehaibing@huawei.com>
List-Id: amd-gfx.lists.freedesktop.org

From: YueHaibing <yuehaibing@huawei.com>

The memory return by kzalloc() has already be set to zero, so
remove useless memset(0).

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index 8fafcbd..0fb6066 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -1295,7 +1295,6 @@ static int vega20_set_default_od8_setttings(struct smu_context *smu)
 	if (!table_context->od8_settings)
 		return -ENOMEM;
 
-	memset(table_context->od8_settings, 0, sizeof(struct vega20_od8_settings));
 	od8_settings = (struct vega20_od8_settings *)table_context->od8_settings;
 
 	if (smu_feature_is_enabled(smu, FEATURE_DPM_SOCCLK_BIT)) {
-- 
2.7.0
