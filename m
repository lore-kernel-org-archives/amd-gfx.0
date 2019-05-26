From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [PATCH] drm/amdgpu/powerplay: remove duplicate entry of
 nbio_6_1_offset.h
Date: Sun, 26 May 2019 13:15:12 +0530
Message-ID: <20190526074512.GA8744@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Hawking Zhang <Hawking.Zhang@amd.com>, Hariprasad Kelam <hariprasad.kelam@gmail.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

asic_reg/nbio/nbio_6_1_offset.h is included twice.

Issue identified by includecheck

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_inc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_inc.h b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_inc.h
index e6d9e84..0d08c57 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_inc.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_inc.h
@@ -35,7 +35,6 @@
 #include "asic_reg/gc/gc_9_2_1_sh_mask.h"
 
 #include "asic_reg/nbio/nbio_6_1_offset.h"
-#include "asic_reg/nbio/nbio_6_1_offset.h"
 #include "asic_reg/nbio/nbio_6_1_sh_mask.h"
 
 #endif
-- 
2.7.4
