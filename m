From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amdgpu: remove set but not used variable 'psp_enabled'
Date: Thu, 27 Jun 2019 07:53:50 +0000
Message-ID: <20190627075350.86800-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, harry.wentland@amd.com, tianci.yin@amd.com, tao.zhou1@amd.com, leo.liu@amd.com, ray.huang@amd.com, Jack.Xiao@amd.com, Hawking.Zhang@amd.com, kenneth.feng@amd.com
Cc: YueHaibing <yuehaibing@huawei.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/nv.c: In function 'nv_common_early_init':
drivers/gpu/drm/amd/amdgpu/nv.c:471:7: warning:
 variable 'psp_enabled' set but not used [-Wunused-but-set-variable]

It's not used since inroduction in
commit c6b6a42175f5 ("drm/amdgpu: add navi10 common ip block (v3)")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index af20ffb55c54..8b9fa3db8daa 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -468,7 +468,6 @@ static const struct amdgpu_asic_funcs nv_asic_funcs =
 
 static int nv_common_early_init(void *handle)
 {
-	bool psp_enabled = false;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	adev->smc_rreg = NULL;
@@ -485,10 +484,6 @@ static int nv_common_early_init(void *handle)
 
 	adev->asic_funcs = &nv_asic_funcs;
 
-	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP) &&
-	    (amdgpu_ip_block_mask & (1 << AMD_IP_BLOCK_TYPE_PSP)))
-		psp_enabled = true;
-
 	adev->rev_id = nv_get_rev_id(adev);
 	adev->external_rev_id = 0xff;
 	switch (adev->asic_type) {
