From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [PATCH] drm/amd/amdgpu: Remove duplicate including duplicate header
Date: Sun, 26 May 2019 13:02:54 +0530
Message-ID: <20190526073254.GA8567@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>, Huang Rui <ray.huang@amd.com>, Rex Zhu <Rex.Zhu@amd.com>, Feifei Xu <Feifei.Xu@amd.com>, Likun Gao <Likun.Gao@amd.com>, James Zhu <James.Zhu@amd.com>, Shirish S <shirish.s@amd.com>, Trigger Huang <Trigger.Huang@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

remove duplicate entry of soc15.h. Issue identified by includecheck

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index c763733..d723332 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -34,7 +34,6 @@
 #include "vega10_enum.h"
 #include "hdp/hdp_4_0_offset.h"
 
-#include "soc15.h"
 #include "soc15_common.h"
 #include "clearstate_gfx9.h"
 #include "v9_structs.h"
-- 
2.7.4
