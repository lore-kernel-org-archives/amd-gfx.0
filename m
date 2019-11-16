From: Chen Wandun <chenwandun@huawei.com>
Subject: [PATCH] drm/amd/powerplay: remove variable 'result' set but not used
Date: Sat, 16 Nov 2019 11:43:19 +0800
Message-ID: <1573875799-83572-1-git-send-email-chenwandun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, evan.quan@amd.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: chenwandun@huawei.com
List-Id: amd-gfx.lists.freedesktop.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c: In function vegam_populate_smc_boot_level:
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c:1364:6: warning: variable result set but not used [-Wunused-but-set-variable]

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index 2068eb0..fad78bf 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -1361,20 +1361,19 @@ static int vegam_populate_smc_uvd_level(struct pp_hwmgr *hwmgr,
 static int vegam_populate_smc_boot_level(struct pp_hwmgr *hwmgr,
 		struct SMU75_Discrete_DpmTable *table)
 {
-	int result = 0;
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 
 	table->GraphicsBootLevel = 0;
 	table->MemoryBootLevel = 0;
 
 	/* find boot level from dpm table */
-	result = phm_find_boot_level(&(data->dpm_table.sclk_table),
-			data->vbios_boot_state.sclk_bootup_value,
-			(uint32_t *)&(table->GraphicsBootLevel));
+	phm_find_boot_level(&(data->dpm_table.sclk_table),
+			    data->vbios_boot_state.sclk_bootup_value,
+			    (uint32_t *)&(table->GraphicsBootLevel));
 
-	result = phm_find_boot_level(&(data->dpm_table.mclk_table),
-			data->vbios_boot_state.mclk_bootup_value,
-			(uint32_t *)&(table->MemoryBootLevel));
+	phm_find_boot_level(&(data->dpm_table.mclk_table),
+			    data->vbios_boot_state.mclk_bootup_value,
+			    (uint32_t *)&(table->MemoryBootLevel));
 
 	table->BootVddc  = data->vbios_boot_state.vddc_bootup_value *
 			VOLTAGE_SCALE;
-- 
2.7.4
