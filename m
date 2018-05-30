From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] drm/amdgpu/df: fix potential array out-of-bounds read
Date: Wed, 30 May 2018 17:41:44 +0100
Message-ID: <20180530164144.21526-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Hawking Zhang <Hawking.Zhang@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

The comparison with the number of elements in array df_v3_7_channel_number
is off-by-one and can produce an array out-of-bounds read if
fb_channel_number is equal to the number of elements of the array. Fix
this by changing the comparison to >= instead of >.

Detected by CoverityScan, CID#1469489 ("Out-of-bounds read")

Fixes: 13b581502d51 ("drm/amdgpu/df: implement df v3_6 callback functions (v2)")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 60608b3df881..d5ebe566809b 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -64,7 +64,7 @@ static u32 df_v3_6_get_hbm_channel_number(struct amdgpu_device *adev)
 	int fb_channel_number;
 
 	fb_channel_number = adev->df_funcs->get_fb_channel_number(adev);
-	if (fb_channel_number > ARRAY_SIZE(df_v3_6_channel_number))
+	if (fb_channel_number >= ARRAY_SIZE(df_v3_6_channel_number))
 		fb_channel_number = 0;
 
 	return df_v3_6_channel_number[fb_channel_number];
-- 
2.17.0
