From: Mao Wenan <maowenan@huawei.com>
Subject: [PATCH -next v4] drm/amdgpu: return 'ret' immediately if failed in amdgpu_pmu_init
Date: Mon, 24 Jun 2019 19:23:18 +0800
Message-ID: <20190624112318.149299-1-maowenan@huawei.com>
References: <20190624094850.GQ18776@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190624094850.GQ18776@kadam>
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

Fixes: 9c7c85f7ea1f ("drm/amdgpu: add pmu counters")

Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 v1->v2: change the subject for this patch; change the indenting when it calls init_pmu_by_type; use the value 'ret' in
 amdgpu_pmu_init().
 v2->v3: change the subject for this patch; return 'ret' immediately if failed to call init_pmu_by_type(). 
 v3->v4: delete the indenting for init_pmu_by_type() arguments. The original indenting is correct.

 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index 0e6dba9f60f0..c98cf77a37f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -254,6 +254,8 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
 		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
 				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
 				       DF_V3_6_MAX_COUNTERS);
+		if (ret)
+			return ret;
 
 		/* other pmu types go here*/
 		break;
-- 
2.20.1
