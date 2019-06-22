From: Mao Wenan <maowenan@huawei.com>
Subject: [PATCH -next v2] drm/amdgpu: return 'ret' in amdgpu_pmu_init
Date: Sat, 22 Jun 2019 21:05:27 +0800
Message-ID: <20190622130527.182022-1-maowenan@huawei.com>
References: <20190622104318.GT28859@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190622104318.GT28859@kadam>
Sender: linux-kernel-owner@vger.kernel.org
To: airlied@linux.ie, daniel@ffwll.ch, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, dan.carpenter@oracle.com, julia.lawall@lip6.fr
Cc: kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, Mao Wenan <maowenan@huawei.com>
List-Id: amd-gfx.lists.freedesktop.org

There is one warning:
drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c: In function ‘amdgpu_pmu_init’:
drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:249:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
  int ret = 0;
      ^
amdgpu_pmu_init() is called by amdgpu_device_init() in drivers/gpu/drm/amd/amdgpu/amdgpu_device.c,
which will use the return value. So it returns 'ret' for caller.
amdgpu_device_init()
	r = amdgpu_pmu_init(adev);

Fixes: 9c7c85f7ea1f ("drm/amdgpu: add pmu counters")

Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 v1->v2: change the subject for this patch; change the indenting when it calls init_pmu_by_type; use the value 'ret' in
 amdgpu_pmu_init().
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index 0e6dba9..145e720 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -252,8 +252,8 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
 	case CHIP_VEGA20:
 		/* init df */
 		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
-				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
-				       DF_V3_6_MAX_COUNTERS);
+							   "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
+							   DF_V3_6_MAX_COUNTERS);
 
 		/* other pmu types go here*/
 		break;
@@ -261,7 +261,7 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	return 0;
+	return ret;
 }
 
 
-- 
2.7.4
