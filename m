From: Colin King <colin.king@canonical.com>
Subject: [PATCH] drm/amdgpu/display: make various arrays static, makes object smaller
Date: Mon,  7 Oct 2019 22:58:57 +0100
Message-ID: <20191007215857.14720-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the arrays on the stack but instead make them
static. Makes the object code smaller by 158 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  32468	   2072	      0	  34540	   86ec	display/dc/bios/bios_parser.o
  22198	   1088	      0	  23286	   5af6	display/dc/bios/bios_parser2.o
  22278	   1076	      0	  23354	   5b3a	display/dc/dce/dce_mem_input.o

81180
After:
   text	   data	    bss	    dec	    hex	filename
  32341	   2136	      0	  34477	   86ad	display/dc/bios/bios_parser.o
  22070	   1184	      0	  23254	   5ad6	display/dc/bios/bios_parser2.o
  22119	   1172	      0	  23291	   5afb	display/dc/dce/dce_mem_input.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  | 2 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 221e0f56389f..65ab225cf542 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -2745,7 +2745,7 @@ static enum bp_result bios_get_board_layout_info(
 	struct bios_parser *bp;
 	enum bp_result record_result;
 
-	const unsigned int slot_index_to_vbios_id[MAX_BOARD_SLOTS] = {
+	static const unsigned int slot_index_to_vbios_id[MAX_BOARD_SLOTS] = {
 		GENERICOBJECT_BRACKET_LAYOUT_ENUM_ID1,
 		GENERICOBJECT_BRACKET_LAYOUT_ENUM_ID2,
 		0, 0
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index dff65c0fe82f..809c4a89b899 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1832,7 +1832,7 @@ static enum bp_result bios_get_board_layout_info(
 	struct bios_parser *bp;
 	enum bp_result record_result;
 
-	const unsigned int slot_index_to_vbios_id[MAX_BOARD_SLOTS] = {
+	static const unsigned int slot_index_to_vbios_id[MAX_BOARD_SLOTS] = {
 		GENERICOBJECT_BRACKET_LAYOUT_ENUM_ID1,
 		GENERICOBJECT_BRACKET_LAYOUT_ENUM_ID2,
 		0, 0
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
index 8aa937f496c4..ed0031d5e021 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
@@ -395,7 +395,7 @@ static void program_size_and_rotation(
 {
 	const struct rect *in_rect = &plane_size->surface_size;
 	struct rect hw_rect = plane_size->surface_size;
-	const uint32_t rotation_angles[ROTATION_ANGLE_COUNT] = {
+	static const uint32_t rotation_angles[ROTATION_ANGLE_COUNT] = {
 			[ROTATION_ANGLE_0] = 0,
 			[ROTATION_ANGLE_90] = 1,
 			[ROTATION_ANGLE_180] = 2,
-- 
2.20.1
