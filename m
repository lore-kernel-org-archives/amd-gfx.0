From: yu kuai <yukuai3@huawei.com>
Subject: [PATCH 2/7] drm/amdgpu: remove set but not used variable 'amdgpu_connector'
Date: Wed, 13 Nov 2019 20:44:29 +0800
Message-ID: <1573649074-72589-3-git-send-email-yukuai3@huawei.com>
References: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, Felix.Kuehling@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Rex.Zhu@amd.com, evan.quan@amd.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, yukuai3@huawei.com, zhengbin13@huawei.com, yi.zhang@huawei.com
List-Id: amd-gfx.lists.freedesktop.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_display.c: In function
‘amdgpu_display_crtc_scaling_mode_fixup’:
drivers/gpu/drm/amd/amdgpu/amdgpu_display.c:693:27: warning: variable
‘amdgpu_connector’ set but not used [-Wunused-but-set-variable]

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index d2dd59a..6a27027 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -690,7 +690,6 @@ bool amdgpu_display_crtc_scaling_mode_fixup(struct drm_crtc *crtc,
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct amdgpu_encoder *amdgpu_encoder;
 	struct drm_connector *connector;
-	struct amdgpu_connector *amdgpu_connector;
 	u32 src_v = 1, dst_v = 1;
 	u32 src_h = 1, dst_h = 1;
 
@@ -702,7 +701,6 @@ bool amdgpu_display_crtc_scaling_mode_fixup(struct drm_crtc *crtc,
 			continue;
 		amdgpu_encoder = to_amdgpu_encoder(encoder);
 		connector = amdgpu_get_connector_for_encoder(encoder);
-		amdgpu_connector = to_amdgpu_connector(connector);
 
 		/* set scaling */
 		if (amdgpu_encoder->rmx_type == RMX_OFF)
-- 
2.7.4
