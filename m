From: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Subject: [PATCH] drm/amd/display: Remove duplicate header
Date: Thu, 22 Nov 2018 19:31:26 +0530
Message-ID: <20181122140126.GA3124@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, Tony.Cheng@amd.com, Bhawanpreet.Lakha@amd.com, David.Francis@amd.com, hersenxs.wu@amd.com
Cc: jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
List-Id: amd-gfx.lists.freedesktop.org

Remove dce/dce_mem_input.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
index d68f951f9869..c41408c3eaf1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
@@ -40,7 +40,6 @@
 #include "dce/dce_mem_input.h"
 #include "dce/dce_link_encoder.h"
 #include "dce/dce_stream_encoder.h"
-#include "dce/dce_mem_input.h"
 #include "dce/dce_ipp.h"
 #include "dce/dce_transform.h"
 #include "dce/dce_opp.h"
-- 
2.17.1
