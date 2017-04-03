From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 2/2] drm/amd/powerplay: fix a couple locking issues
Date: Mon, 3 Apr 2017 21:42:42 +0300
Message-ID: <20170403184242.GB22462@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Rex Zhu <Rex.Zhu@amd.com>, Eric Huang <JinHuiEric.Huang@amd.com>, Tom St Denis <tom.stdenis@amd.com>, Huang Rui <ray.huang@amd.com>, Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

We should return unlock on the error path in pp_dpm_dispatch_tasks()
and there is a double lock bug in pp_dpm_set_sclk_od().

Fixes: 2a5071056e6a ("drm/amd/powerplay: add global PowerPlay mutex.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index 260b732be7c3..e59b5627d543 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -493,8 +493,10 @@ static int pp_dpm_dispatch_tasks(void *handle, enum amd_pp_event event_id,
 	{
 		enum amd_pm_state_type  ps;
 
-		if (input == NULL)
-			return -EINVAL;
+		if (input == NULL) {
+			ret = -EINVAL;
+			break;
+		}
 		ps = *(unsigned long *)input;
 
 		data.requested_ui_label = power_state_convert(ps);
@@ -897,7 +899,7 @@ static int pp_dpm_set_sclk_od(void *handle, uint32_t value)
 
 	mutex_lock(&pp_handle->pp_lock);
 	ret = hwmgr->hwmgr_func->set_sclk_od(hwmgr, value);
-	mutex_lock(&pp_handle->pp_lock);
+	mutex_unlock(&pp_handle->pp_lock);
 	return ret;
 }
 
