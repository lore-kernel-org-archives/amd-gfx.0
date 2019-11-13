From: yu kuai <yukuai3@huawei.com>
Subject: [PATCH 5/7] drm/amd/powerplay: remove set but not used variable 'threshold'
Date: Wed, 13 Nov 2019 20:44:32 +0800
Message-ID: <1573649074-72589-6-git-send-email-yukuai3@huawei.com>
References: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, Felix.Kuehling@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Rex.Zhu@amd.com, evan.quan@amd.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, yukuai3@huawei.com, zhengbin13@huawei.com, yi.zhang@huawei.com
List-Id: amd-gfx.lists.freedesktop.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c: In
function ‘fiji_populate_single_graphic_level’:
drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c:943:11:
warning: variable ‘threshold’ set but not used
[-Wunused-but-set-variable]

It is never used, so can be removed.

Fixes: 2e112b4ae3ba ("drm/amd/pp: remove fiji_smc/smumgr split.")
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
index da025b1..c3df3a3 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
@@ -940,7 +940,7 @@ static int fiji_populate_single_graphic_level(struct pp_hwmgr *hwmgr,
 {
 	int result;
 	/* PP_Clocks minClocks; */
-	uint32_t threshold, mvdd;
+	uint32_t mvdd;
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 	struct phm_ppt_v1_information *table_info =
 			(struct phm_ppt_v1_information *)(hwmgr->pptable);
@@ -973,8 +973,6 @@ static int fiji_populate_single_graphic_level(struct pp_hwmgr *hwmgr,
 	level->VoltageDownHyst = 0;
 	level->PowerThrottle = 0;
 
-	threshold = clock * data->fast_watermark_threshold / 100;
-
 	data->display_timing.min_clock_in_sr = hwmgr->display_config->min_core_set_clock_in_sr;
 
 	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_PlatformCaps_SclkDeepSleep))
-- 
2.7.4
