From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] drm/amd/display: include missing linux/delay.h
Date: Mon, 17 Jun 2019 14:38:55 +0200
Message-ID: <20190617123915.926526-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Lim <Thomas.Lim@amd.com>, Eric Yang <eric.yang2@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Tony Cheng <tony.cheng@amd.com>, Anthony Koo <Anthony.Koo@amd.com>, Charlene Liu <charlene.liu@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Some randconfig builds fail to compile the dcn10 code because of
a missing declaration:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: In function 'dcn10_apply_ctx_for_surface':
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2378:3: error: implicit declaration of function 'udelay' [-Werror=implicit-function-declaration]

Include the appropriate kernel header.

Fixes: 9ed43ef84d9d ("drm/amd/display: Add Underflow Asserts to dc")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 1ac9a4f03990..d87ddc7de9c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -22,6 +22,7 @@
  * Authors: AMD
  *
  */
+#include <linux/delay.h>
 
 #include <linux/delay.h>
 #include "dm_services.h"
-- 
2.20.0
