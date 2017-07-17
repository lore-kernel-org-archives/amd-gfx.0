From: Junwei Zhang <Jerry.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: enable sos status checking for vega10
Date: Mon, 17 Jul 2017 17:01:50 +0800
Message-ID: <1500282110-6372-2-git-send-email-Jerry.Zhang@amd.com>
References: <1500282110-6372-1-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1500282110-6372-1-git-send-email-Jerry.Zhang@amd.com>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, ray.huang@amd.com, stable@vger.kernel.org, Junwei Zhang <Jerry.Zhang@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

Signed-off-by: Junwei Zhang <Jerry.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c | 2 --
 1 file changed, 2 deletions(-)

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
