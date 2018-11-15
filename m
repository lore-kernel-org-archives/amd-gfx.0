From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amdgpu: remove set but not used variable 'ring'
Date: Thu, 15 Nov 2018 10:52:13 +0000
Message-ID: <1542279133-103893-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, Shaoyun.Liu@amd.com, David.Francis@amd.com, ray.huang@amd.com, Feifei.Xu@amd.com, Likun.Gao@amd.com
Cc: YueHaibing <yuehaibing@huawei.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/psp_v10_0.c: In function 'psp_v10_0_ring_stop':
drivers/gpu/drm/amd/amdgpu/psp_v10_0.c:230:19: warning:
 variable 'ring' set but not used [-Wunused-but-set-variable]

It not used since commit
4ef72453311a ("drm/amdgpu: added api for stopping psp ring (v2)")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
index 295c220..d78b430 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -240,12 +240,9 @@ static int psp_v10_0_ring_stop(struct psp_context *psp,
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
