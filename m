From: Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH] drm: radeon: replace 0 with NULL
Date: Tue, 26 Nov 2019 00:35:14 +0000
Message-ID: <20191126003514.133692-1-jbi.octave@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com
Cc: christian.koenig@amd.com, David1.Zhou@amd.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, daniel@ffwll.ch, airlied@linux.ie, amd-gfx@lists.freedesktop.org, Jules Irenge <jbi.octave@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

Replace 0 with NULL to fix sparse tool  warning
 warning: Using plain integer as NULL pointer

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/radeon/radeon_audio.c
index b9aea5776d3d..2269cfced788 100644
--- a/drivers/gpu/drm/radeon/radeon_audio.c
+++ b/drivers/gpu/drm/radeon/radeon_audio.c
@@ -288,7 +288,7 @@ static void radeon_audio_interface_init(struct radeon_device *rdev)
 	} else {
 		rdev->audio.funcs = &r600_funcs;
 		rdev->audio.hdmi_funcs = &r600_hdmi_funcs;
-		rdev->audio.dp_funcs = 0;
+		rdev->audio.dp_funcs = NULL;
 	}
 }
 
-- 
2.23.0
