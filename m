From: Mao Wenan <maowenan@huawei.com>
Subject: [PATCH -next v3] drm/amdgpu: return 'ret' immediately if failed in amdgpu_pmu_init
Date: Mon, 24 Jun 2019 11:45:32 +0800
Message-ID: <20190624034532.135201-1-maowenan@huawei.com>
References: <alpine.DEB.2.21.1906230809400.4961@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1906230809400.4961@hadrien>
Sender: linux-kernel-owner@vger.kernel.org
To: airlied@linux.ie, daniel@ffwll.ch, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, dan.carpenter@oracle.com, julia.lawall@lip6.fr
Cc: kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, jonathan.kim@amd.com, Mao Wenan <maowenan@huawei.com>
List-Id: amd-gfx.lists.freedesktop.org

There is one warning:
drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c: In function ‘amdgpu_pmu_init’:
drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:249:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
  int ret = 0;
      ^
amdgpu_pmu_init() is called by amdgpu_device_init() in drivers/gpu/drm/amd/amdgpu/amdgpu_device.c,
which will use the return value. So it should return 'ret' immediately if init_pmu_by_type() failed.
amdgpu_device_init()
	r = amdgpu_pmu_init(adev);

This patch is also to update the indenting on the arguments so they line up with the '('.

Fixes: 9c7c85f7ea1f ("drm/amdgpu: add pmu counters")

Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 v1->v2: change the subject for this patch; change the indenting when it calls init_pmu_by_type; use the value 'ret' in
 amdgpu_pmu_init().
 v2->v3: change the subject for this patch; return 'ret' immediately if failed to call init_pmu_by_type(). 

 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index 0e6dba9..b702322 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -252,8 +252,11 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
 	case CHIP_VEGA20:
 		/* init df */
 		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
-				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
-				       DF_V3_6_MAX_COUNTERS);
+							   "DF", "amdgpu_df",
+							   PERF_TYPE_AMDGPU_DF,
+							   DF_V3_6_MAX_COUNTERS);
+		if (ret)
+			return ret;
 
 		/* other pmu types go here*/
 		break;
-- 
2.7.4
