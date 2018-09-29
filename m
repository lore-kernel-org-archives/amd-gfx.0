From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amdgpu: remove set but not used variable 'ring' in psp_v3_1_ring_stop
Date: Sat, 29 Sep 2018 11:16:09 +0000
Message-ID: <1538219769-37710-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, Shaoyun.Liu@amd.com, Ken.Wang@amd.com, Feifei.Xu@amd.com, ray.huang@amd.com, evan.quan@amd.com
Cc: YueHaibing <yuehaibing@huawei.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/psp_v3_1.c: In function 'psp_v3_1_ring_stop':
drivers/gpu/drm/amd/amdgpu/psp_v3_1.c:359:19: warning:
 variable 'ring' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
index e1ebf77..cc5e3ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -356,12 +356,9 @@ static int psp_v3_1_ring_stop(struct psp_context *psp,
 			      enum psp_ring_type ring_type)
 {
 	int ret = 0;
-	struct psp_ring *ring;
 	unsigned int psp_ring_reg = 0;
 	struct amdgpu_device *adev = psp->adev;
 
-	ring = &psp->km_ring;
-
 	/* Write the ring destroy command to C2PMSG_64 */
 	psp_ring_reg = 3 << 16;
 	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, psp_ring_reg);
