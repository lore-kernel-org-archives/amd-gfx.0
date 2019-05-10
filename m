From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] drm/amdgpu: fix return of an uninitialized value in variable ret
Date: Fri, 10 May 2019 11:08:42 +0100
Message-ID: <20190510100842.30458-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

In the case where is_enable is false and lo_base_addr is non-zero the
variable ret has not been initialized and is being checked for non-zero
and potentially garbage is being returned. Fix this by not returning
ret but instead returning -EINVAL on the zero lo_base_addr case.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: a6ac0b44bab9 ("drm/amdgpu: add df perfmon regs and funcs for xgmi")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index a5c3558869fb..8c09bf994acd 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -398,10 +398,7 @@ static int df_v3_6_start_xgmi_link_cntr(struct amdgpu_device *adev,
 				NULL);
 
 		if (lo_base_addr == 0)
-			ret = -EINVAL;
-
-		if (ret)
-			return ret;
+			return -EINVAL;
 
 		lo_val = RREG32_PCIE(lo_base_addr);
 
-- 
2.20.1
