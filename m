From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] drm/amd/powerplay: remove a less than zero uint32_t check
Date: Fri, 28 Jun 2019 16:28:04 +0100
Message-ID: <20190628152804.16954-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

The check to see if the uint32_t variable 'size' is less than zero
is redundant as it is unsigned and can never be less than zero.
Remove this redundant check.

Addresses-Coverity: ("Unsigned compared to zero")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index ac151da..6ea48d6 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1043,9 +1043,6 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
 	}
 
 	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size < 0)
-			return -EINVAL;
-
 		ret = smu_update_table(smu,
 				       SMU_TABLE_ACTIVITY_MONITOR_COEFF | WORKLOAD_PPLIB_CUSTOM_BIT << 16,
 				       (void *)(&activity_monitor), false);
-- 
2.7.4
