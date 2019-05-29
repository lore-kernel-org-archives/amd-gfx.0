From: Young Xiao <92siuyang@gmail.com>
Subject: [PATCH] drm/amd/powerplay: avoid possible buffer overflow
Date: Wed, 29 May 2019 12:34:07 +0800
Message-ID: <1559104447-26810-1-git-send-email-92siuyang@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rex.zhu@amd.com, evan.quan@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, kenneth.feng@amd.com, Hawking.Zhang@amd.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Young Xiao <92siuyang@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

Make sure the clock level enforced is within the allowed
ranges in case PP_SCLK and PP_MCLK.

Signed-off-by: Young Xiao <92siuyang@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
index 707cd4b..ae6cbe8 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
@@ -1836,6 +1836,12 @@ static int vega12_force_clock_level(struct pp_hwmgr *hwmgr,
 	case PP_SCLK:
 		soft_min_level = mask ? (ffs(mask) - 1) : 0;
 		soft_max_level = mask ? (fls(mask) - 1) : 0;
+		if (soft_max_level >= data->dpm_table.gfx_table.count) {
+			pr_err("Clock level specified %d is over max allowed %d\n",
+					soft_max_level,
+					data->dpm_table.gfx_table.count - 1);
+			return -EINVAL;
+		}
 
 		data->dpm_table.gfx_table.dpm_state.soft_min_level =
 			data->dpm_table.gfx_table.dpm_levels[soft_min_level].value;
@@ -1856,6 +1862,12 @@ static int vega12_force_clock_level(struct pp_hwmgr *hwmgr,
 	case PP_MCLK:
 		soft_min_level = mask ? (ffs(mask) - 1) : 0;
 		soft_max_level = mask ? (fls(mask) - 1) : 0;
+		if (soft_max_level >= data->dpm_table.gfx_table.count) {
+			pr_err("Clock level specified %d is over max allowed %d\n",
+					soft_max_level,
+					data->dpm_table.gfx_table.count - 1);
+			return -EINVAL;
+		}
 
 		data->dpm_table.mem_table.dpm_state.soft_min_level =
 			data->dpm_table.mem_table.dpm_levels[soft_min_level].value;
-- 
2.7.4
