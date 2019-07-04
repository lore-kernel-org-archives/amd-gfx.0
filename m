From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 7/7] drm/amd/powerplay: Zero initialize current_rpm in vega20_get_fan_speed_percent
Date: Wed,  3 Jul 2019 22:52:18 -0700
Message-ID: <20190704055217.45860-8-natechancellor@gmail.com>
References: <20190704055217.45860-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190704055217.45860-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

clang warns (trimmed for brevity):

drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:3023:8: warning:
variable 'current_rpm' is used uninitialized whenever '?:' condition is
false [-Wsometimes-uninitialized]
        ret = smu_get_current_rpm(smu, &current_rpm);
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

smu_get_current_rpm expands to a ternary operator conditional on
smu->funcs->get_current_rpm being not NULL. When this is false,
current_rpm will be uninitialized. Zero initialize current_rpm to
avoid using random stack values if that ever happens.

Fixes: ee0db82027ee ("drm/amd/powerplay: move PPTable_t uses into asic level")
Link: https://github.com/ClangBuiltLinux/linux/issues/588
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index e62dd6919b24..e37b39987587 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -3016,8 +3016,7 @@ static int vega20_get_fan_speed_percent(struct smu_context *smu,
 					uint32_t *speed)
 {
 	int ret = 0;
-	uint32_t percent = 0;
-	uint32_t current_rpm;
+	uint32_t current_rpm = 0, percent = 0;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 
 	ret = smu_get_current_rpm(smu, &current_rpm);
-- 
2.22.0
