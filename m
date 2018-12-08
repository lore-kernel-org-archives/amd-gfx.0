From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amdgpu: remove set but not used variable 'grbm_soft_reset'
Date: Sat, 8 Dec 2018 15:01:13 +0000
Message-ID: <1544281273-73940-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, leo.liu@amd.com, Likun.Gao@amd.com, David.Panariti@amd.com, shirish.s@amd.com, Rex.Zhu@amd.com, andrey.grodzovsky@amd.com
Cc: YueHaibing <yuehaibing@huawei.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c: In function 'gfx_v8_0_pre_soft_reset':
drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:4950:27: warning:
 variable 'srbm_soft_reset' set but not used [-Wunused-but-set-variable]

drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c: In function 'gfx_v8_0_post_soft_reset':
drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:5054:27: warning:
 variable 'srbm_soft_reset' set but not used [-Wunused-but-set-variable]

It never used since introduction in commit d31a501ead7f ("drm/amdgpu: add
pre_soft_reset ip func") and e4ae0fc33631 ("drm/amdgpu: implement
gfx8 post_soft_reset")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 1454fc3..8c1ba79 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4947,14 +4947,13 @@ static bool gfx_v8_0_check_soft_reset(void *handle)
 static int gfx_v8_0_pre_soft_reset(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	u32 grbm_soft_reset = 0, srbm_soft_reset = 0;
+	u32 grbm_soft_reset = 0;
 
 	if ((!adev->gfx.grbm_soft_reset) &&
 	    (!adev->gfx.srbm_soft_reset))
 		return 0;
 
 	grbm_soft_reset = adev->gfx.grbm_soft_reset;
-	srbm_soft_reset = adev->gfx.srbm_soft_reset;
 
 	/* stop the rlc */
 	adev->gfx.rlc.funcs->stop(adev);
@@ -5051,14 +5050,13 @@ static int gfx_v8_0_soft_reset(void *handle)
 static int gfx_v8_0_post_soft_reset(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	u32 grbm_soft_reset = 0, srbm_soft_reset = 0;
+	u32 grbm_soft_reset = 0;
 
 	if ((!adev->gfx.grbm_soft_reset) &&
 	    (!adev->gfx.srbm_soft_reset))
 		return 0;
 
 	grbm_soft_reset = adev->gfx.grbm_soft_reset;
-	srbm_soft_reset = adev->gfx.srbm_soft_reset;
 
 	if (REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_CP) ||
 	    REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_CPF) ||
