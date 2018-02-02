From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] drm/amd/display: fix incompatible structure layouts
Date: Fri,  2 Feb 2018 13:31:26 +0100
Message-ID: <20180202123232.477388-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

Building the amd display driver with link-time optimizations revealed a bug
that caused dal_cmd_tbl_helper_dce80_get_table() and
dal_cmd_tbl_helper_dce110_get_table() get called with an incompatible
return type between the two callers in command_table_helper.c and
command_table_helper2.c:

drivers/gpu/drm/amd/amdgpu/../display/dc/bios/dce80/command_table_helper_dce80.h:31: error: type of 'dal_cmd_tbl_helper_dce80_get_table' does not match original declaration [-Werror=lto-type-mismatch]
 const struct command_table_helper *dal_cmd_tbl_helper_dce80_get_table(void);

drivers/gpu/drm/amd/amdgpu/../display/dc/bios/dce80/command_table_helper_dce80.c:351: note: 'dal_cmd_tbl_helper_dce80_get_table' was previously declared here
 const struct command_table_helper *dal_cmd_tbl_helper_dce80_get_table(void)

drivers/gpu/drm/amd/amdgpu/../display/dc/bios/dce110/command_table_helper_dce110.h:32: error: type of 'dal_cmd_tbl_helper_dce110_get_table' does not match original declaration [-Werror=lto-type-mismatch]
 const struct command_table_helper *dal_cmd_tbl_helper_dce110_get_table(void);

drivers/gpu/drm/amd/amdgpu/../display/dc/bios/dce110/command_table_helper_dce110.c:361: note: 'dal_cmd_tbl_helper_dce110_get_table' was previously declared here
 const struct command_table_helper *dal_cmd_tbl_helper_dce110_get_table(void)

The two versions of the structure are obviously derived from the same
one, but have diverged over time, before they got added to the kernel.

This moves the structure to a new shared header file and uses the superset
of the members, to ensure the interfaces are all compatible.

Fixes: ae79c310b1a6 ("drm/amd/display: Add DCE12 bios parser support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../drm/amd/display/dc/bios/command_table_helper.h | 33 +----------
 .../amd/display/dc/bios/command_table_helper2.h    | 30 +---------
 .../display/dc/bios/command_table_helper_struct.h  | 66 ++++++++++++++++++++++
 3 files changed, 68 insertions(+), 61 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/bios/command_table_helper_struct.h

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.h b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.h
index 1fab634b66be..4c3789df253d 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.h
@@ -29,38 +29,7 @@
 #include "dce80/command_table_helper_dce80.h"
 #include "dce110/command_table_helper_dce110.h"
 #include "dce112/command_table_helper_dce112.h"
-
-struct command_table_helper {
-	bool (*controller_id_to_atom)(enum controller_id id, uint8_t *atom_id);
-	uint8_t (*encoder_action_to_atom)(
-			enum bp_encoder_control_action action);
-	uint32_t (*encoder_mode_bp_to_atom)(enum signal_type s,
-			bool enable_dp_audio);
-	bool (*engine_bp_to_atom)(enum engine_id engine_id,
-			uint32_t *atom_engine_id);
-	void (*assign_control_parameter)(
-			const struct command_table_helper *h,
-			struct bp_encoder_control *control,
-			DIG_ENCODER_CONTROL_PARAMETERS_V2 *ctrl_param);
-	bool (*clock_source_id_to_atom)(enum clock_source_id id,
-			uint32_t *atom_pll_id);
-	bool (*clock_source_id_to_ref_clk_src)(
-			enum clock_source_id id,
-			uint32_t *ref_clk_src_id);
-	uint8_t (*transmitter_bp_to_atom)(enum transmitter t);
-	uint8_t (*encoder_id_to_atom)(enum encoder_id id);
-	uint8_t (*clock_source_id_to_atom_phy_clk_src_id)(
-			enum clock_source_id id);
-	uint8_t (*signal_type_to_atom_dig_mode)(enum signal_type s);
-	uint8_t (*hpd_sel_to_atom)(enum hpd_source_id id);
-	uint8_t (*dig_encoder_sel_to_atom)(enum engine_id engine_id);
-	uint8_t (*phy_id_to_atom)(enum transmitter t);
-	uint8_t (*disp_power_gating_action_to_atom)(
-			enum bp_pipe_control_action action);
-	bool (*dc_clock_type_to_atom)(enum bp_dce_clock_type id,
-			uint32_t *atom_clock_type);
-    uint8_t (*transmitter_color_depth_to_atom)(enum transmitter_color_depth id);
-};
+#include "command_table_helper_struct.h"
 
 bool dal_bios_parser_init_cmd_tbl_helper(const struct command_table_helper **h,
 	enum dce_version dce);
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.h b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.h
index 9f587c91d843..785fcb20a1b9 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.h
@@ -29,35 +29,7 @@
 #include "dce80/command_table_helper_dce80.h"
 #include "dce110/command_table_helper_dce110.h"
 #include "dce112/command_table_helper2_dce112.h"
-
-struct command_table_helper {
-	bool (*controller_id_to_atom)(enum controller_id id, uint8_t *atom_id);
-	uint8_t (*encoder_action_to_atom)(
-			enum bp_encoder_control_action action);
-	uint32_t (*encoder_mode_bp_to_atom)(enum signal_type s,
-			bool enable_dp_audio);
-	bool (*engine_bp_to_atom)(enum engine_id engine_id,
-			uint32_t *atom_engine_id);
-	bool (*clock_source_id_to_atom)(enum clock_source_id id,
-			uint32_t *atom_pll_id);
-	bool (*clock_source_id_to_ref_clk_src)(
-			enum clock_source_id id,
-			uint32_t *ref_clk_src_id);
-	uint8_t (*transmitter_bp_to_atom)(enum transmitter t);
-	uint8_t (*encoder_id_to_atom)(enum encoder_id id);
-	uint8_t (*clock_source_id_to_atom_phy_clk_src_id)(
-			enum clock_source_id id);
-	uint8_t (*signal_type_to_atom_dig_mode)(enum signal_type s);
-	uint8_t (*hpd_sel_to_atom)(enum hpd_source_id id);
-	uint8_t (*dig_encoder_sel_to_atom)(enum engine_id engine_id);
-	uint8_t (*phy_id_to_atom)(enum transmitter t);
-	uint8_t (*disp_power_gating_action_to_atom)(
-			enum bp_pipe_control_action action);
-	bool (*dc_clock_type_to_atom)(enum bp_dce_clock_type id,
-			uint32_t *atom_clock_type);
-	uint8_t (*transmitter_color_depth_to_atom)(
-			enum transmitter_color_depth id);
-};
+#include "command_table_helper_struct.h"
 
 bool dal_bios_parser_init_cmd_tbl_helper2(const struct command_table_helper **h,
 	enum dce_version dce);
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper_struct.h b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper_struct.h
new file mode 100644
index 000000000000..1f2c0a3f06f9
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper_struct.h
@@ -0,0 +1,66 @@
+/*
+ * Copyright 2012-15 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DAL_COMMAND_TABLE_HELPER_STRUCT_H__
+#define __DAL_COMMAND_TABLE_HELPER_STRUCT_H__
+
+#include "dce80/command_table_helper_dce80.h"
+#include "dce110/command_table_helper_dce110.h"
+#include "dce112/command_table_helper_dce112.h"
+
+struct _DIG_ENCODER_CONTROL_PARAMETERS_V2;
+struct command_table_helper {
+	bool (*controller_id_to_atom)(enum controller_id id, uint8_t *atom_id);
+	uint8_t (*encoder_action_to_atom)(
+			enum bp_encoder_control_action action);
+	uint32_t (*encoder_mode_bp_to_atom)(enum signal_type s,
+			bool enable_dp_audio);
+	bool (*engine_bp_to_atom)(enum engine_id engine_id,
+			uint32_t *atom_engine_id);
+	void (*assign_control_parameter)(
+			const struct command_table_helper *h,
+			struct bp_encoder_control *control,
+			struct _DIG_ENCODER_CONTROL_PARAMETERS_V2 *ctrl_param);
+	bool (*clock_source_id_to_atom)(enum clock_source_id id,
+			uint32_t *atom_pll_id);
+	bool (*clock_source_id_to_ref_clk_src)(
+			enum clock_source_id id,
+			uint32_t *ref_clk_src_id);
+	uint8_t (*transmitter_bp_to_atom)(enum transmitter t);
+	uint8_t (*encoder_id_to_atom)(enum encoder_id id);
+	uint8_t (*clock_source_id_to_atom_phy_clk_src_id)(
+			enum clock_source_id id);
+	uint8_t (*signal_type_to_atom_dig_mode)(enum signal_type s);
+	uint8_t (*hpd_sel_to_atom)(enum hpd_source_id id);
+	uint8_t (*dig_encoder_sel_to_atom)(enum engine_id engine_id);
+	uint8_t (*phy_id_to_atom)(enum transmitter t);
+	uint8_t (*disp_power_gating_action_to_atom)(
+			enum bp_pipe_control_action action);
+	bool (*dc_clock_type_to_atom)(enum bp_dce_clock_type id,
+			uint32_t *atom_clock_type);
+	uint8_t (*transmitter_color_depth_to_atom)(enum transmitter_color_depth id);
+};
+
+#endif
-- 
2.9.0
