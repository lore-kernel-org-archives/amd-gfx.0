From: Luis de Bethencourt <luisbg@kernel.org>
Subject: [PATCH] drm: amd: Fix trailing semicolons
Date: Wed, 17 Jan 2018 18:50:20 +0000
Message-ID: <20180117185020.25169-1-luisbg@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Joe Perches <joe@perches.com>, Alex Deucher <alexander.deucher@amd.com>, Christian Konig <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Harry Wentland <harry.wentland@amd.com>, Tony Cheng <tony.cheng@amd.com>, Wenjing Liu <Wenjing.Liu@amd.com>, Ding Wang <Ding.Wang@amd.com>, Sylvia Tsai <sylvia.tsai@amd.com>, Hersen Wu <hersenxs.wu@amd.com>, Rex Zhu <Rex.Zhu@amd.com>, Eric Huang <JinHuiEric.Huang@amd.com>, Huang Rui <ray.huang@amd.com>, Dan Carpenter <dan.carpenter@oracle.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Luis de Bethencourt <luisbg@kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

The trailing semicolon is an empty statement that does no operation.
Removing the two instances of them since they don't do anything.

Signed-off-by: Luis de Bethencourt <luisbg@kernel.org>
---

Hi,

After fixing the same thing in drivers/staging/rtl8723bs/, Joe Perches
suggested I fix it treewide [0].

Best regards 
Luis


[0] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115410.html
[1] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115390.html

 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 61e8c3e02d16..33d91e4474ea 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -718,7 +718,7 @@ static enum link_training_result perform_channel_equalization_sequence(
 	uint32_t retries_ch_eq;
 	enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
 	union lane_align_status_updated dpcd_lane_status_updated = {{0}};
-	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {{{0}}};;
+	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {{{0}}};
 
 	hw_tr_pattern = get_supported_tp(link);
 
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index fa9d1615a2cc..b98a7a8a22b5 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -162,7 +162,7 @@ static int pp_hw_init(void *handle)
 		if(hwmgr->smumgr_funcs->start_smu(pp_handle->hwmgr)) {
 			pr_err("smc start failed\n");
 			hwmgr->smumgr_funcs->smu_fini(pp_handle->hwmgr);
-			return -EINVAL;;
+			return -EINVAL;
 		}
 		if (ret == PP_DPM_DISABLED)
 			goto exit;
-- 
2.15.1
