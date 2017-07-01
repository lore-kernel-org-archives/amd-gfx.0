From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] drm: radeon: constify drm_prop_enum_list structures.
Date: Sat,  1 Jul 2017 15:17:01 +0530
Message-ID: <beb616668c94829ec6992e7f62b6eca00e481a01.1498902119.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: daniel.vetter@intel.com, alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

drm_prop_enum_lists are not supposed to change at runtime. All functions
working with drm_prop_enum_list provided by <drm/drm_property.h> work with
const drm_prop_enum_list. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
  18276	    384	      0	  18660	   48e4	drivers/gpu/drm/radeon/radeon_display.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  18660	      0	      0	  18660	   48e4	drivers/gpu/drm/radeon/radeon_display.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_display.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 17d3daf..f339c1c 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -1388,12 +1388,12 @@ static const struct drm_mode_config_funcs radeon_mode_funcs = {
 	.output_poll_changed = radeon_output_poll_changed
 };
 
-static struct drm_prop_enum_list radeon_tmds_pll_enum_list[] =
+static const struct drm_prop_enum_list radeon_tmds_pll_enum_list[] =
 {	{ 0, "driver" },
 	{ 1, "bios" },
 };
 
-static struct drm_prop_enum_list radeon_tv_std_enum_list[] =
+static const struct drm_prop_enum_list radeon_tv_std_enum_list[] =
 {	{ TV_STD_NTSC, "ntsc" },
 	{ TV_STD_PAL, "pal" },
 	{ TV_STD_PAL_M, "pal-m" },
@@ -1404,25 +1404,25 @@ static struct drm_prop_enum_list radeon_tv_std_enum_list[] =
 	{ TV_STD_SECAM, "secam" },
 };
 
-static struct drm_prop_enum_list radeon_underscan_enum_list[] =
+static const struct drm_prop_enum_list radeon_underscan_enum_list[] =
 {	{ UNDERSCAN_OFF, "off" },
 	{ UNDERSCAN_ON, "on" },
 	{ UNDERSCAN_AUTO, "auto" },
 };
 
-static struct drm_prop_enum_list radeon_audio_enum_list[] =
+static const struct drm_prop_enum_list radeon_audio_enum_list[] =
 {	{ RADEON_AUDIO_DISABLE, "off" },
 	{ RADEON_AUDIO_ENABLE, "on" },
 	{ RADEON_AUDIO_AUTO, "auto" },
 };
 
 /* XXX support different dither options? spatial, temporal, both, etc. */
-static struct drm_prop_enum_list radeon_dither_enum_list[] =
+static const struct drm_prop_enum_list radeon_dither_enum_list[] =
 {	{ RADEON_FMT_DITHER_DISABLE, "off" },
 	{ RADEON_FMT_DITHER_ENABLE, "on" },
 };
 
-static struct drm_prop_enum_list radeon_output_csc_enum_list[] =
+static const struct drm_prop_enum_list radeon_output_csc_enum_list[] =
 {	{ RADEON_OUTPUT_CSC_BYPASS, "bypass" },
 	{ RADEON_OUTPUT_CSC_TVRGB, "tvrgb" },
 	{ RADEON_OUTPUT_CSC_YCBCR601, "ycbcr601" },
-- 
2.7.4
