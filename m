From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] drm/amd/display: dcn20: include linux/delay.h
Date: Mon,  8 Jul 2019 15:53:18 +0200
Message-ID: <20190708135329.694852-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: Arnd Bergmann <arnd@arndb.de>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, Joshua Aberback <joshua.aberback@amd.com>, Wenjing Liu <Wenjing.Liu@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Without this header, we get a compiler error in some configurations:

.../dc/dcn20/dcn20_hwseq.c: In function 'dcn20_hwss_wait_for_blank_complete':
.../dc/dcn20/dcn20_hwseq.c:1493:3: error: implicit declaration of function 'udelay' [-Werror=implicit-function-declaration]

Note: the use of udelay itself may be problematic, as can occupy
the CPU for 200ms in a busy-loop here.

Fixes: 7ed4e6352c16 ("drm/amd/display: Add DCN2 HW Sequencer and Resource")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 4b0d8b9f61da..6925d25d2457 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -22,6 +22,7 @@
  * Authors: AMD
  *
  */
+#include <linux/delay.h>
 
 #include "dm_services.h"
 #include "dm_helpers.h"
-- 
2.20.0
