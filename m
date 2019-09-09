From: Austin Kim <austindh.kim@gmail.com>
Subject: [PATCH] drm/amd/powerplay: Remove unnecessary comparison statement
Date: Mon, 9 Sep 2019 13:31:48 +0900
Message-ID: <20190909043148.GA112744@LGEARND20B15>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, David1.Zhou@amd.com
List-Id: amd-gfx.lists.freedesktop.org

size contain non-negative value since it is declared as uint32_t.
So below statement is always false.
	if (size < 0)

Remove unnecessary comparison.

Signed-off-by: Austin Kim <austindh.kim@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 12c0e46..3c7c68e 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1134,9 +1134,6 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
 	}
 
 	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size < 0)
-			return -EINVAL;
-
 		ret = smu_update_table(smu,
 				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
 				       (void *)(&activity_monitor), false);
-- 
2.6.2
