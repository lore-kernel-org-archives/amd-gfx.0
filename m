From: Raul E Rangel <rrangel@chromium.org>
Subject: [PATCH] drm/amd/powerplay: fix struct init in renoir_print_clk_levels
Date: Tue,  5 Nov 2019 15:58:02 -0700
Message-ID: <20191105155734.1.If8740b4a5095031f2c00746fbc3224be9849d76b@changeid>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com
Cc: Raul E Rangel <rrangel@chromium.org>, David Airlie <airlied@linux.ie>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Rex Zhu <rex.zhu@amd.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Evan Quan <evan.quan@amd.com>, Daniel Vetter <daniel@ffwll.ch>
List-Id: amd-gfx.lists.freedesktop.org

drivers/gpu/drm/amd/powerplay/renoir_ppt.c:186:2: error: missing braces
around initializer [-Werror=missing-braces]
  SmuMetrics_t metrics = {0};
    ^

Fixes: 8b8031703bd7 ("drm/amd/powerplay: implement sysfs for getting dpm clock")

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index e62bfba51562..e5283dafc414 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -183,11 +183,13 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 	int i, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0, min = 0, max = 0;
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
-	SmuMetrics_t metrics = {0};
+	SmuMetrics_t metrics;
 
 	if (!clk_table || clk_type >= SMU_CLK_COUNT)
 		return -EINVAL;
 
+	memset(&metrics, 0, sizeof(metrics));
+
 	ret = smu_update_table(smu, SMU_TABLE_SMU_METRICS, 0,
 			       (void *)&metrics, false);
 	if (ret)
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog
