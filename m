From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] drm/amdgpu: remove set but not used variable 'ring'
Date: Thu, 15 Nov 2018 20:00:35 +0800
Message-ID: <20181115120035.4328-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, Shaoyun.Liu@amd.com, David.Francis@amd.com, ray.huang@amd.com, Feifei.Xu@amd.com, Likun.Gao@amd.com
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: amd-gfx.lists.freedesktop.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/psp_v10_0.c: In function 'psp_v10_0_ring_stop':
drivers/gpu/drm/amd/amdgpu/psp_v10_0.c:230:19: warning:
 variable 'ring' set but not used [-Wunused-but-set-variable]

drivers/gpu/drm/amd/amdgpu/psp_v3_1.c: In function 'psp_v3_1_ring_stop':
drivers/gpu/drm/amd/amdgpu/psp_v3_1.c:359:19: warning:
 variable ‘ring’ set but not used [-Wunused-but-set-variable]

It not used since commit
4ef72453311a ("drm/amdgpu: added api for stopping psp ring (v2)")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
---
v2:also remove it in psp_v3_1_ring_stop
---
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c | 3 ---
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c  | 3 ---
 2 files changed, 6 deletions(-)

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
-- 
2.7.0
