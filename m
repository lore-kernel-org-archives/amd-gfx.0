From: Austin Kim <austindh.kim@gmail.com>
Subject: [PATCH] drm/amdgpu: Move null pointer dereference check
Date: Fri, 30 Aug 2019 17:07:04 +0900
Message-ID: <20190830080704.GA29599@LGEARND20B15>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: rex.zhu@amd.com, evan.quan@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Null pointer dereference check should have been checked,
ahead of below routine.
	struct amdgpu_device *adev = hwmgr->adev;

With this commit, it could avoid potential NULL dereference.

Signed-off-by: Austin Kim <austindh.kim@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
index 8189fe4..4728aa2 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
@@ -722,16 +722,17 @@ static int smu8_request_smu_load_fw(struct pp_hwmgr *hwmgr)
 
 static int smu8_start_smu(struct pp_hwmgr *hwmgr)
 {
-	struct amdgpu_device *adev = hwmgr->adev;
+	struct amdgpu_device *adev;
 
 	uint32_t index = SMN_MP1_SRAM_START_ADDR +
 			 SMU8_FIRMWARE_HEADER_LOCATION +
 			 offsetof(struct SMU8_Firmware_Header, Version);
 
-
 	if (hwmgr == NULL || hwmgr->device == NULL)
 		return -EINVAL;
 
+	adev = hwmgr->adev;
+
 	cgs_write_register(hwmgr->device, mmMP0PUB_IND_INDEX, index);
 	hwmgr->smu_version = cgs_read_register(hwmgr->device, mmMP0PUB_IND_DATA);
 	pr_info("smu version %02d.%02d.%02d\n",
-- 
2.6.2
