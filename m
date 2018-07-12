From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH 1/4] drm/amdgpu/pp/smu7: use a local variable for toc indexing
Date: Thu, 12 Jul 2018 09:39:38 -0500
Message-ID: <20180712143941.28977-1-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Rather than using the index variable stored in vram.  If
the device fails to come back online after a resume cycle,
reads from vram will return all 1s which will cause a
segfault. Based on a patch from Thomas Martitz <kugel@rockbox.org>.
This avoids the segfault, but we still need to sort out
why the GPU does not come back online after a resume.

Bug: https://bugs.freedesktop.org/show_bug.cgi?id=105760
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c | 23 +++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
index d644a9bb9078..9f407c48d4f0 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
@@ -381,6 +381,7 @@ int smu7_request_smu_load_fw(struct pp_hwmgr *hwmgr)
 	uint32_t fw_to_load;
 	int result = 0;
 	struct SMU_DRAMData_TOC *toc;
+	uint32_t num_entries = 0;
 
 	if (!hwmgr->reload_fw) {
 		pr_info("skip reloading...\n");
@@ -422,41 +423,41 @@ int smu7_request_smu_load_fw(struct pp_hwmgr *hwmgr)
 	}
 
 	toc = (struct SMU_DRAMData_TOC *)smu_data->header;
-	toc->num_entries = 0;
 	toc->structure_version = 1;
 
 	PP_ASSERT_WITH_CODE(0 == smu7_populate_single_firmware_entry(hwmgr,
-				UCODE_ID_RLC_G, &toc->entry[toc->num_entries++]),
+				UCODE_ID_RLC_G, &toc->entry[num_entries++]),
 				"Failed to Get Firmware Entry.", return -EINVAL);
 	PP_ASSERT_WITH_CODE(0 == smu7_populate_single_firmware_entry(hwmgr,
-				UCODE_ID_CP_CE, &toc->entry[toc->num_entries++]),
+				UCODE_ID_CP_CE, &toc->entry[num_entries++]),
 				"Failed to Get Firmware Entry.", return -EINVAL);
 	PP_ASSERT_WITH_CODE(0 == smu7_populate_single_firmware_entry(hwmgr,
-				UCODE_ID_CP_PFP, &toc->entry[toc->num_entries++]),
+				UCODE_ID_CP_PFP, &toc->entry[num_entries++]),
 				"Failed to Get Firmware Entry.", return -EINVAL);
 	PP_ASSERT_WITH_CODE(0 == smu7_populate_single_firmware_entry(hwmgr,
-				UCODE_ID_CP_ME, &toc->entry[toc->num_entries++]),
+				UCODE_ID_CP_ME, &toc->entry[num_entries++]),
 				"Failed to Get Firmware Entry.", return -EINVAL);
 	PP_ASSERT_WITH_CODE(0 == smu7_populate_single_firmware_entry(hwmgr,
-				UCODE_ID_CP_MEC, &toc->entry[toc->num_entries++]),
+				UCODE_ID_CP_MEC, &toc->entry[num_entries++]),
 				"Failed to Get Firmware Entry.", return -EINVAL);
 	PP_ASSERT_WITH_CODE(0 == smu7_populate_single_firmware_entry(hwmgr,
-				UCODE_ID_CP_MEC_JT1, &toc->entry[toc->num_entries++]),
+				UCODE_ID_CP_MEC_JT1, &toc->entry[num_entries++]),
 				"Failed to Get Firmware Entry.", return -EINVAL);
 	PP_ASSERT_WITH_CODE(0 == smu7_populate_single_firmware_entry(hwmgr,
-				UCODE_ID_CP_MEC_JT2, &toc->entry[toc->num_entries++]),
+				UCODE_ID_CP_MEC_JT2, &toc->entry[num_entries++]),
 				"Failed to Get Firmware Entry.", return -EINVAL);
 	PP_ASSERT_WITH_CODE(0 == smu7_populate_single_firmware_entry(hwmgr,
-				UCODE_ID_SDMA0, &toc->entry[toc->num_entries++]),
+				UCODE_ID_SDMA0, &toc->entry[num_entries++]),
 				"Failed to Get Firmware Entry.", return -EINVAL);
 	PP_ASSERT_WITH_CODE(0 == smu7_populate_single_firmware_entry(hwmgr,
-				UCODE_ID_SDMA1, &toc->entry[toc->num_entries++]),
+				UCODE_ID_SDMA1, &toc->entry[num_entries++]),
 				"Failed to Get Firmware Entry.", return -EINVAL);
 	if (!hwmgr->not_vf)
 		PP_ASSERT_WITH_CODE(0 == smu7_populate_single_firmware_entry(hwmgr,
-				UCODE_ID_MEC_STORAGE, &toc->entry[toc->num_entries++]),
+				UCODE_ID_MEC_STORAGE, &toc->entry[num_entries++]),
 				"Failed to Get Firmware Entry.", return -EINVAL);
 
+	toc->num_entries = num_entries;
 	smu7_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_DRV_DRAM_ADDR_HI, upper_32_bits(smu_data->header_buffer.mc_addr));
 	smu7_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_DRV_DRAM_ADDR_LO, lower_32_bits(smu_data->header_buffer.mc_addr));
 
-- 
2.13.6
