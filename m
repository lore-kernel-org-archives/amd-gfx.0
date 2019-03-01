From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/amdgpu/gfx_v8_0: Mark expected switch fall-through
Date: Fri, 1 Mar 2019 14:58:32 -0600
Message-ID: <20190301205832.GA21783@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Kees Cook <keescook@chromium.org>
List-Id: amd-gfx.lists.freedesktop.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c: In function ‘gfx_v8_0_tiling_mode_table_init’:
./include/linux/device.h:1487:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  _dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:3236:3: note: in expansion of macro ‘dev_warn’
   dev_warn(adev->dev,
   ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:3240:2: note: here
  case CHIP_CARRIZO:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index b8e50a34bdb3..02955e6e9dd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -3236,6 +3236,7 @@ static void gfx_v8_0_tiling_mode_table_init(struct amdgpu_device *adev)
 		dev_warn(adev->dev,
 			 "Unknown chip type (%d) in function gfx_v8_0_tiling_mode_table_init() falling through to CHIP_CARRIZO\n",
 			 adev->asic_type);
+		/* fall through */
 
 	case CHIP_CARRIZO:
 		modearray[0] = (ARRAY_MODE(ARRAY_2D_TILED_THIN1) |
-- 
2.21.0
