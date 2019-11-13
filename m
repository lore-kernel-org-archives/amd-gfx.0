From: yu kuai <yukuai3@huawei.com>
Subject: [PATCH 7/7] drm/amd/powerplay: remove set but not used variable 'us_mvdd'
Date: Wed, 13 Nov 2019 20:44:34 +0800
Message-ID: <1573649074-72589-8-git-send-email-yukuai3@huawei.com>
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

drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c: In
function ‘vegam_populate_smc_acpi_level’:
drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c:1117:11:
warning: variable 'us_mvdd' set but not used [-Wunused-but-set-variable]

It is never used, so can be removed.

Fixes: ac7822b0026f ("drm/amd/powerplay: add smumgr support for VEGAM (v2)")
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index ae18fbc..2068eb0 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -1114,7 +1114,6 @@ static int vegam_populate_smc_acpi_level(struct pp_hwmgr *hwmgr,
 			(struct phm_ppt_v1_information *)(hwmgr->pptable);
 	SMIO_Pattern vol_level;
 	uint32_t mvdd;
-	uint16_t us_mvdd;
 
 	table->ACPILevel.Flags &= ~PPSMC_SWSTATE_FLAG_DC;
 
@@ -1168,17 +1167,6 @@ static int vegam_populate_smc_acpi_level(struct pp_hwmgr *hwmgr,
 			"in Clock Dependency Table",
 			);
 
-	us_mvdd = 0;
-	if ((SMU7_VOLTAGE_CONTROL_NONE == data->mvdd_control) ||
-			(data->mclk_dpm_key_disabled))
-		us_mvdd = data->vbios_boot_state.mvdd_bootup_value;
-	else {
-		if (!vegam_populate_mvdd_value(hwmgr,
-				data->dpm_table.mclk_table.dpm_levels[0].value,
-				&vol_level))
-			us_mvdd = vol_level.Voltage;
-	}
-
 	if (!vegam_populate_mvdd_value(hwmgr, 0, &vol_level))
 		table->MemoryACPILevel.MinMvdd = PP_HOST_TO_SMC_UL(vol_level.Voltage);
 	else
-- 
2.7.4
