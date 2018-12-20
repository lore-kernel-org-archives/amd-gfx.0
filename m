From: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Subject: [PATCH] drm/amd/display/i2c_hw_engine_dce110: Remove duplicate header
Date: Thu, 20 Dec 2018 18:04:55 +0530
Message-ID: <20181220123455.GA24952@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, Tony.Cheng@amd.com, Bhawanpreet.Lakha@amd.com, Dmytro.Laktyushkin@amd.com, charlene.liu@amd.com
Cc: jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
List-Id: amd-gfx.lists.freedesktop.org

Remove reg_helper.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 .../gpu/drm/amd/display/dc/i2caux/dce110/i2c_hw_engine_dce110.c  | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/dce110/i2c_hw_engine_dce110.c b/drivers/gpu/drm/amd/display/dc/i2caux/dce110/i2c_hw_engine_dce110.c
index 9cbe1a7a6bcb..137350142fb2 100644
--- a/drivers/gpu/drm/amd/display/dc/i2caux/dce110/i2c_hw_engine_dce110.c
+++ b/drivers/gpu/drm/amd/display/dc/i2caux/dce110/i2c_hw_engine_dce110.c
@@ -97,7 +97,6 @@ enum dc_i2c_arbitration {
 #define FN(reg_name, field_name) \
 	hw_engine->i2c_shift->field_name, hw_engine->i2c_mask->field_name
 
-#include "reg_helper.h"
 
 static void disable_i2c_hw_engine(
 	struct i2c_hw_engine_dce110 *hw_engine)
-- 
2.17.1
