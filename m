From: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Subject: [PATCH] drm/amd/display: Remove duplicate header
Date: Wed, 19 Dec 2018 13:27:13 +0530
Message-ID: <20181219075713.GA2259@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, Tony.Cheng@amd.com, Dmytro.Laktyushkin@amd.com, yongqiang.sun@amd.com, eric.bernstein@amd.com, Eric.Yang2@amd.com, Anthony.Koo@amd.com, nikola.cornij@amd.com
Cc: jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
List-Id: amd-gfx.lists.freedesktop.org

Remove custom_float.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 193184affefb..3e21c2d26998 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -40,7 +40,6 @@
 #include "ipp.h"
 #include "mpc.h"
 #include "reg_helper.h"
-#include "custom_float.h"
 #include "dcn10_hubp.h"
 #include "dcn10_hubbub.h"
 #include "dcn10_cm_common.h"
-- 
2.17.1
