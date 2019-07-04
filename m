From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 2/7] drm/amd/powerplay: Use memset to initialize metrics structs
Date: Wed,  3 Jul 2019 22:52:13 -0700
Message-ID: <20190704055217.45860-3-natechancellor@gmail.com>
References: <20190704055217.45860-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190704055217.45860-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

clang warns:

drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:601:33: warning:
suggest braces around initialization of subobject [-Wmissing-braces]
        static SmuMetrics_t metrics = {0};
                                       ^
                                       {}
drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:905:26: warning:
suggest braces around initialization of subobject [-Wmissing-braces]
        SmuMetrics_t metrics = {0};
                                ^
                                {}
2 warnings generated.

One way to fix these warnings is to add additional braces like clang
suggests; however, there has been a bit of push back from some
maintainers[1][2], who just prefer memset as it is unambiguous, doesn't
depend on a particular compiler version[3], and properly initializes all
subobjects. Do that here so there are no more warnings.

[1]: https://lore.kernel.org/lkml/022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com/
[2]: https://lore.kernel.org/lkml/20181128.215241.702406654469517539.davem@davemloft.net/
[3]: https://lore.kernel.org/lkml/20181116150432.2408a075@redhat.com/

Fixes: 98e1a543c7b1 ("drm/amd/powerplay: add function get current clock freq interface for navi10")
Fixes: ab43c4bf1cc8 ("drm/amd/powerplay: fix fan speed show error (for hwmon pwm)")
Link: https://github.com/ClangBuiltLinux/linux/issues/583
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index e00397f84b2f..f5d2ada05bc6 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -598,12 +598,14 @@ static int navi10_get_current_clk_freq_by_table(struct smu_context *smu,
 				       enum smu_clk_type clk_type,
 				       uint32_t *value)
 {
-	static SmuMetrics_t metrics = {0};
+	static SmuMetrics_t metrics;
 	int ret = 0, clk_id = 0;
 
 	if (!value)
 		return -EINVAL;
 
+	memset(&metrics, 0, sizeof(metrics));
+
 	ret = smu_update_table(smu, SMU_TABLE_SMU_METRICS, (void *)&metrics, false);
 	if (ret)
 		return ret;
@@ -902,12 +904,14 @@ static bool navi10_is_dpm_running(struct smu_context *smu)
 
 static int navi10_get_fan_speed(struct smu_context *smu, uint16_t *value)
 {
-	SmuMetrics_t metrics = {0};
+	SmuMetrics_t metrics;
 	int ret = 0;
 
 	if (!value)
 		return -EINVAL;
 
+	memset(&metrics, 0, sizeof(metrics));
+
 	ret = smu_update_table(smu, SMU_TABLE_SMU_METRICS,
 			       (void *)&metrics, false);
 	if (ret)
-- 
2.22.0
