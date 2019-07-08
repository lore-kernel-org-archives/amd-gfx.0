From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] amdgpu: fix warning about misplaced initializers
Date: Mon,  8 Jul 2019 16:11:06 +0200
Message-ID: <20190708141117.1466888-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Wang <kevin1.wang@amd.com>, Huang Rui <ray.huang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

The navi10_ppt code contains two instances of an incorrect struct initializer:

drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:601:33: error: suggest braces around initialization of subobject
      [-Werror,-Wmissing-braces]
        static SmuMetrics_t metrics = {0};
                                       ^
                                       {}
drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:905:26: error: suggest braces around initialization of subobject
      [-Werror,-Wmissing-braces]
        SmuMetrics_t metrics = {0};
                                ^

Setting it to {} instead of {0} is correct and more portable here.

Fixes: ab43c4bf1cc8 ("drm/amd/powerplay: fix fan speed show error (for hwmon pwm)")
Fixes: 98e1a543c7b1 ("drm/amd/powerplay: add function get current clock freq interface for navi10")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index fdcea2b944ab..ce1da9e6e1bf 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -606,7 +606,7 @@ static int navi10_get_current_clk_freq_by_table(struct smu_context *smu,
 				       enum smu_clk_type clk_type,
 				       uint32_t *value)
 {
-	static SmuMetrics_t metrics = {0};
+	static SmuMetrics_t metrics = {};
 	int ret = 0, clk_id = 0;
 
 	if (!value)
@@ -957,7 +957,7 @@ static bool navi10_is_dpm_running(struct smu_context *smu)
 
 static int navi10_get_fan_speed(struct smu_context *smu, uint16_t *value)
 {
-	SmuMetrics_t metrics = {0};
+	SmuMetrics_t metrics = {};
 	int ret = 0;
 
 	if (!value)
-- 
2.20.0
