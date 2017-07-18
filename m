From: Junwei Zhang <Jerry.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: read reg in each iterate of psp_wait_for loop
Date: Tue, 18 Jul 2017 10:54:24 +0800
Message-ID: <1500346464-8132-1-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, ray.huang@amd.com, gregkh@linuxfoundation.org, "Zhang, Jerry" <Jerry.Zhang@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: "Zhang, Jerry" <Jerry.Zhang@amd.com>

v2: fixes the SOS loading failure for PSP v3.1

Signed-off-by: Junwei Zhang <Jerry.Zhang@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Deucher <alexander.deucher@amd.com> (v1)
Acked-by: Huang Rui <ray.huang@amd.com> (v1)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c   | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c919579..644941d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -98,9 +98,8 @@ int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
 	int i;
 	struct amdgpu_device *adev = psp->adev;
 
-	val = RREG32(reg_index);
-
 	for (i = 0; i < adev->usec_timeout; i++) {
+		val = RREG32(reg_index);
 		if (check_changed) {
 			if (val != reg_val)
 				return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
index 2718e86..23106e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -237,11 +237,9 @@ int psp_v3_1_bootloader_load_sos(struct psp_context *psp)
 
 	/* there might be handshake issue with hardware which needs delay */
 	mdelay(20);
-#if 0
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_81),
 			   RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81),
 			   0, true);
-#endif
 
 	return ret;
 }
-- 
1.9.1
