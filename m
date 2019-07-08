From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] drm/amd/powerplay: vega20: fix uninitialized variable use
Date: Mon,  8 Jul 2019 16:07:59 +0200
Message-ID: <20190708140816.1334640-2-arnd@arndb.de>
References: <20190708140816.1334640-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190708140816.1334640-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: Arnd Bergmann <arnd@arndb.de>, Huang Rui <ray.huang@amd.com>, Kevin Wang <kevin1.wang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>, Chengming Gui <Jack.Gui@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

If smu_get_current_rpm() fails, we can't use the output,
as that may be uninitialized:

drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:3023:8: error: variable 'current_rpm' is used uninitialized whenever '?:' condition is false [-Werror,-Wsometimes-uninitialized]
        ret = smu_get_current_rpm(smu, &current_rpm);
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:735:3: note: expanded from macro 'smu_get_current_rpm'
        ((smu)->funcs->get_current_rpm ? (smu)->funcs->get_current_rpm((smu), (speed)) : 0)
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:3024:12: note: uninitialized use occurs here
        percent = current_rpm * 100 / pptable->FanMaximumRpm;
                  ^~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:3023:8: note: remove the '?:' if its condition is always true
        ret = smu_get_current_rpm(smu, &current_rpm);
              ^
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:735:3: note: expanded from macro 'smu_get_current_rpm'
        ((smu)->funcs->get_current_rpm ? (smu)->funcs->get_current_rpm((smu), (speed)) : 0)
         ^
drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:3020:22: note: initialize the variable 'current_rpm' to silence this warning
        uint32_t current_rpm;

Propagate the error code in that case.

Fixes: ee0db82027ee ("drm/amd/powerplay: move PPTable_t uses into asic level")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index 9ce3f1c8ae0f..20d477f8dc84 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -3021,10 +3021,13 @@ static int vega20_get_fan_speed_percent(struct smu_context *smu,
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 
 	ret = smu_get_current_rpm(smu, &current_rpm);
+	if (ret)
+		return ret;
+
 	percent = current_rpm * 100 / pptable->FanMaximumRpm;
 	*speed = percent > 100 ? 100 : percent;
 
-	return ret;
+	return 0;
 }
 
 static int vega20_get_gpu_power(struct smu_context *smu, uint32_t *value)
-- 
2.20.0
