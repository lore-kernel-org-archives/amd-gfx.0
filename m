From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] drm/amd/display: Add missing newline at end of file
Date: Mon, 17 Jun 2019 16:37:28 +0200
Message-ID: <20190617143728.4949-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: amd-gfx.lists.freedesktop.org

"git diff" says:

    \ No newline at end of file

after modifying the file.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/amd/display/modules/power/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/Makefile b/drivers/gpu/drm/amd/display/modules/power/Makefile
index 87851f892a52d372..9d1b22d35ece9136 100644
--- a/drivers/gpu/drm/amd/display/modules/power/Makefile
+++ b/drivers/gpu/drm/amd/display/modules/power/Makefile
@@ -28,4 +28,4 @@ MOD_POWER = power_helpers.o
 AMD_DAL_MOD_POWER = $(addprefix $(AMDDALPATH)/modules/power/,$(MOD_POWER))
 #$(info ************  DAL POWER MODULE MAKEFILE ************)
 
-AMD_DISPLAY_FILES += $(AMD_DAL_MOD_POWER)
\ No newline at end of file
+AMD_DISPLAY_FILES += $(AMD_DAL_MOD_POWER)
-- 
2.17.1
