From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH] drm/amdgpu: Don't skip display settings in hwmgr_resume()
Date: Thu, 20 Jun 2019 19:21:26 -0400
Message-ID: <20190620232127.25436-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>, Rex Zhu <Rex.Zhu@amd.com>, Likun Gao <Likun.Gao@amd.com>, stable@vger.kernel.org, Rex Zhu <rex.zhu@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

I'm not entirely sure why this is, but for some reason:

921935dc6404 ("drm/amd/powerplay: enforce display related settings only on needed")

Breaks runtime PM resume on the Radeon PRO WX 3100 (Lexa) in one the
pre-production laptops I have. The issue manifests as the following
messages in dmesg:

[drm] UVD and UVD ENC initialized successfully.
amdgpu 0000:3b:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring vce1 test failed (-110)
[drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block <vce_v3_0> failed -110
[drm:amdgpu_device_resume [amdgpu]] *ERROR* amdgpu_device_ip_resume failed (-110).

And happens after about 6-10 runtime PM suspend/resume cycles (sometimes
sooner, if you're lucky!). Unfortunately I can't seem to pin down
precisely which part in psm_adjust_power_state_dynamic that is causing
the issue, but not skipping the display setting setup seems to fix it.
Hopefully if there is a better fix for this, this patch will spark
discussion around it.

Fixes: 921935dc6404 ("drm/amd/powerplay: enforce display related settings only on needed")
Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Rex Zhu <Rex.Zhu@amd.com>
Cc: Likun Gao <Likun.Gao@amd.com>
Cc: <stable@vger.kernel.org> # v5.1+
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
index 6cd6497c6fc2..0e1b2d930816 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
@@ -325,7 +325,7 @@ int hwmgr_resume(struct pp_hwmgr *hwmgr)
 	if (ret)
 		return ret;
 
-	ret = psm_adjust_power_state_dynamic(hwmgr, true, NULL);
+	ret = psm_adjust_power_state_dynamic(hwmgr, false, NULL);
 
 	return ret;
 }
-- 
2.21.0
