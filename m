From: Chen Wandun <chenwandun@huawei.com>
Subject: [PATCH v2] drm/amd/powerplay: return errno code to caller when error occur
Date: Mon, 18 Nov 2019 16:03:34 +0800
Message-ID: <1574064214-109525-1-git-send-email-chenwandun@huawei.com>
References: <1573875799-83572-1-git-send-email-chenwandun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1573875799-83572-1-git-send-email-chenwandun@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: evan.quan@amd.com, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: chenwandun@huawei.com
List-Id: amd-gfx.lists.freedesktop.org

return errno code to caller when error occur, and meanwhile
remove gcc '-Wunused-but-set-variable' warning.

drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c: In function vegam_populate_smc_boot_level:
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c:1364:6: warning: variable result set but not used [-Wunused-but-set-variable]

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index 2068eb0..50896e9 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -1371,11 +1371,16 @@ static int vegam_populate_smc_boot_level(struct pp_hwmgr *hwmgr,
 	result = phm_find_boot_level(&(data->dpm_table.sclk_table),
 			data->vbios_boot_state.sclk_bootup_value,
 			(uint32_t *)&(table->GraphicsBootLevel));
+	if (result)
+		return result;
 
 	result = phm_find_boot_level(&(data->dpm_table.mclk_table),
 			data->vbios_boot_state.mclk_bootup_value,
 			(uint32_t *)&(table->MemoryBootLevel));
 
+	if (result)
+		return result;
+
 	table->BootVddc  = data->vbios_boot_state.vddc_bootup_value *
 			VOLTAGE_SCALE;
 	table->BootVddci = data->vbios_boot_state.vddci_bootup_value *
-- 
2.7.4
