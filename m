From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] drm/amd/powerplay: fix out of memory check on od8_settings
Date: Fri, 28 Jun 2019 16:13:54 +0100
Message-ID: <20190628151354.14107-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Wang <kevin1.wang@amd.com>, Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

The null pointer check on od8_settings is currently the opposite of what
it is intended to do. Fix this by adding in the missing ! operator.

Addressed-Coverity: ("Resource leak")
Fixes: 0c83d32c565c ("drm/amd/powerplay: simplified od_settings for each asic")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index 0f14fe14ecd8..eb9e6b3a5265 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -1501,8 +1501,7 @@ static int vega20_set_default_od8_setttings(struct smu_context *smu)
 		return -EINVAL;
 
 	od8_settings = kzalloc(sizeof(struct vega20_od8_settings), GFP_KERNEL);
-
-	if (od8_settings)
+	if (!od8_settings)
 		return -ENOMEM;
 
 	smu->od_settings = (void *)od8_settings;
-- 
2.20.1
