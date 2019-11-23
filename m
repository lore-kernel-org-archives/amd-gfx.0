From: Thomas Anderson <thomasanderson@google.com>
Subject: [PATCH] drm/amd/display: Reduce HDMI pixel encoding if max clock is exceeded
Date: Fri, 22 Nov 2019 21:29:00 -0800
Message-ID: <20191123052900.77205-1-thomasanderson@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, David Francis <David.Francis@amd.com>, Mario Kleiner <mario.kleiner.de@gmail.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Thomas Anderson <thomasanderson@google.com>
List-Id: amd-gfx.lists.freedesktop.org

For high-res (8K) or HFR (4K120) displays, using uncompressed pixel
formats like YCbCr444 would exceed the bandwidth of HDMI 2.0, so the
"interesting" modes would be disabled, leaving only low-res or low
framerate modes.

This change lowers the pixel encoding to 4:2:2 or 4:2:0 if the max TMDS
clock is exceeded. Verified that 8K30 and 4K120 are now available and
working with a Samsung Q900R over an HDMI 2.0b link from a Radeon 5700.

Signed-off-by: Thomas Anderson <thomasanderson@google.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 30 ++++++++++++++-----
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4139f129eafb..a507a6f04c82 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3269,13 +3269,15 @@ static void reduce_mode_colour_depth(struct dc_crtc_timing *timing_out)
 	timing_out->display_color_depth--;
 }
 
-static void adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_out,
-						const struct drm_display_info *info)
+static void adjust_timing_from_display_info(
+	struct dc_crtc_timing *timing_out,
+	const struct drm_display_info *info,
+	const struct drm_display_mode *mode_in)
 {
 	int normalized_clk;
-	if (timing_out->display_color_depth <= COLOR_DEPTH_888)
+	if (timing_out->display_color_depth < COLOR_DEPTH_888)
 		return;
-	do {
+	while (timing_out->display_color_depth > COLOR_DEPTH_888) {
 		normalized_clk = timing_out->pix_clk_100hz / 10;
 		/* YCbCr 4:2:0 requires additional adjustment of 1/2 */
 		if (timing_out->pixel_encoding == PIXEL_ENCODING_YCBCR420)
@@ -3297,9 +3299,23 @@ static void adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_
 		if (normalized_clk <= info->max_tmds_clock)
 			return;
 		reduce_mode_colour_depth(timing_out);
+	}
 
-	} while (timing_out->display_color_depth > COLOR_DEPTH_888);
-
+	/* The color depth is 888 and cannot be reduced any further, but the
+	 * clock would still exceed the max tmds clock. Try reducing the pixel
+	 * encoding next.
+	 */
+	if (timing_out->pixel_encoding == PIXEL_ENCODING_RGB ||
+	    timing_out->pixel_encoding == PIXEL_ENCODING_YCBCR444) {
+		/* YCBCR422 is always supported. */
+		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR422;
+		normalized_clk = (timing_out->pix_clk_100hz * 3) / 40;
+		if (normalized_clk <= info->max_tmds_clock)
+			return;
+	}
+	/* YCBCR420 may only be supported on specific modes. */
+	if (drm_mode_is_420_also(info, mode_in))
+		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
 }
 
 static void fill_stream_properties_from_drm_display_mode(
@@ -3366,7 +3382,7 @@ static void fill_stream_properties_from_drm_display_mode(
 	stream->out_transfer_func->type = TF_TYPE_PREDEFINED;
 	stream->out_transfer_func->tf = TRANSFER_FUNCTION_SRGB;
 	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
-		adjust_colour_depth_from_display_info(timing_out, info);
+		adjust_timing_from_display_info(timing_out, info, mode_in);
 }
 
 static void fill_audio_info(struct audio_info *audio_info,
-- 
2.24.0.432.g9d3f5f5b63-goog
