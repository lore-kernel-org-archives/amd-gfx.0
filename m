From: Colin King <colin.king@canonical.com>
Subject: [PATCH][drm-next] drm/amd/powerplay: remove redundant duplicated return check
Date: Mon,  5 Aug 2019 11:29:40 +0100
Message-ID: <20190805102940.26024-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

The check on ret is duplicated in two places, it is redundant code.
Remove it.

Addresses-Coverity: ("Logically dead code")
Fixes: b94afb61cdae ("drm/amd/powerplay: honor hw limit on fetching metrics data for navi10")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index d62c2784b102..b272c8dc8f79 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -941,8 +941,6 @@ static int navi10_get_gpu_power(struct smu_context *smu, uint32_t *value)
 	ret = navi10_get_metrics_table(smu, &metrics);
 	if (ret)
 		return ret;
-	if (ret)
-		return ret;
 
 	*value = metrics.AverageSocketPower << 8;
 
@@ -1001,8 +999,6 @@ static int navi10_get_fan_speed_rpm(struct smu_context *smu,
 	ret = navi10_get_metrics_table(smu, &metrics);
 	if (ret)
 		return ret;
-	if (ret)
-		return ret;
 
 	*speed = metrics.CurrFanSpeed;
 
-- 
2.20.1
