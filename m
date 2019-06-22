From: Mao Wenan <maowenan@huawei.com>
Subject: [PATCH -next] drm/amdgpu: remove set but not used variables 'ret'
Date: Sat, 22 Jun 2019 11:03:14 +0800
Message-ID: <20190622030314.169640-1-maowenan@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: airlied@linux.ie, daniel@ffwll.ch, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com
Cc: kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, Mao Wenan <maowenan@huawei.com>
List-Id: amd-gfx.lists.freedesktop.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c: In function ‘amdgpu_pmu_init’:
drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:249:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
  int ret = 0;
      ^

It is never used since introduction in 9c7c85f7ea1f ("drm/amdgpu: add pmu counters")

Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index 0e6dba9..0bf4dd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -246,12 +246,10 @@ static int init_pmu_by_type(struct amdgpu_device *adev,
 /* init amdgpu_pmu */
 int amdgpu_pmu_init(struct amdgpu_device *adev)
 {
-	int ret = 0;
-
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
 		/* init df */
-		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
+		init_pmu_by_type(adev, df_v3_6_attr_groups,
 				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
 				       DF_V3_6_MAX_COUNTERS);
 
-- 
2.7.4
