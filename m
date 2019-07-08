From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] drm/amd/powerplay: smu_v11_0: fix uninitialized variable use
Date: Mon,  8 Jul 2019 16:07:58 +0200
Message-ID: <20190708140816.1334640-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Wang <kevin1.wang@amd.com>, Huang Rui <ray.huang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>, Chengming Gui <Jack.Gui@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

A mistake in the error handling caused an uninitialized
variable to be used:

drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:1102:10: error: variable 'freq' is used uninitialized whenever '?:' condition is false [-Werror,-Wsometimes-uninitialized]
                ret =  smu_get_current_clk_freq_by_table(smu, clk_id, &freq);
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:880:3: note: expanded from macro 'smu_get_current_clk_freq_by_table'
        ((smu)->ppt_funcs->get_current_clk_freq_by_table ? (smu)->ppt_funcs->get_current_clk_freq_by_table((smu), (clk_type), (value)) : 0)
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:1114:2: note: uninitialized use occurs here
        freq *= 100;
        ^~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:1102:10: note: remove the '?:' if its condition is always true
                ret =  smu_get_current_clk_freq_by_table(smu, clk_id, &freq);
                       ^
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:880:3: note: expanded from macro 'smu_get_current_clk_freq_by_table'
        ((smu)->ppt_funcs->get_current_clk_freq_by_table ? (smu)->ppt_funcs->get_current_clk_freq_by_table((smu), (clk_type), (value)) : 0)
         ^
drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:1095:15: note: initialize the variable 'freq' to silence this warning
        uint32_t freq;
                     ^
                      = 0

Bail out of smu_v11_0_get_current_clk_freq() before we get there.

Fixes: e36182490dec ("drm/amd/powerplay: fix dpm freq unit error (10KHz -> Mhz)")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index c3f9714e9047..bd89a13b6679 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1099,9 +1099,11 @@ static int smu_v11_0_get_current_clk_freq(struct smu_context *smu,
 		return -EINVAL;
 
 	/* if don't has GetDpmClockFreq Message, try get current clock by SmuMetrics_t */
-	if (smu_msg_get_index(smu, SMU_MSG_GetDpmClockFreq) == 0)
+	if (smu_msg_get_index(smu, SMU_MSG_GetDpmClockFreq) == 0) {
 		ret =  smu_get_current_clk_freq_by_table(smu, clk_id, &freq);
-	else {
+		if (ret)
+			return ret;
+	} else {
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetDpmClockFreq,
 						  (smu_clk_get_index(smu, clk_id) << 16));
 		if (ret)
-- 
2.20.0
