From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] drm/amdgpu: fix spelling mistake "retrived" -> "retrieved"
Date: Fri, 10 May 2019 08:07:34 +0100
Message-ID: <20190510070734.20625-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a DRM_ERROR error message. Fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 7d375f8dcce6..a5c3558869fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -194,7 +194,7 @@ static void df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
 		return;
 
 	if ((*lo_base_addr == 0) || (*hi_base_addr == 0)) {
-		DRM_ERROR("DF PMC addressing not retrived! Lo: %x, Hi: %x",
+		DRM_ERROR("DF PMC addressing not retrieved! Lo: %x, Hi: %x",
 				*lo_base_addr, *hi_base_addr);
 		return;
 	}
-- 
2.20.1
