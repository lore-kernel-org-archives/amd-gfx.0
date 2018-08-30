From: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 03/17] drm/amd/display: Add DP YCbCr 4:2:0 support
Date: Thu, 30 Aug 2018 17:33:09 -0400
Message-ID: <20180830213323.31745-4-Bhawanpreet.Lakha@amd.com>
References: <20180830213323.31745-1-Bhawanpreet.Lakha@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1699163567=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180830213323.31745-1-Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Eric Bernstein <eric.bernstein-5C7GfCeVMHo@public.gmane.org>

--===============1699163567==
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit

From: Eric Bernstein <eric.bernstein-5C7GfCeVMHo@public.gmane.org>

[Why]
For supporting DP YCbCr 4:2:0 output.

[How]
Update mod_build_vsc_infopacket to support Pixel
Encoding/Colorimetry Format indication for VSC SDP rev5.

Change-Id: Id6035c6a954bc698e379fe43cc8079e29d7dd765
Signed-off-by: Eric Bernstein <eric.bernstein-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin-5C7GfCeVMHo@public.gmane.org>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
---
 .../amd/display/modules/info_packet/info_packet.c  | 189 ++++++++++++++++++++-
 1 file changed, 188 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 24b6cc1dfc64..52378fc69079 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -26,20 +26,38 @@
 #include "mod_info_packet.h"
 #include "core_types.h"
 
+enum ColorimetryRGBDP {
+	ColorimetryRGB_DP_sRGB               = 0,
+	ColorimetryRGB_DP_AdobeRGB           = 3,
+	ColorimetryRGB_DP_P3                 = 4,
+	ColorimetryRGB_DP_CustomColorProfile = 5,
+	ColorimetryRGB_DP_ITU_R_BT2020RGB    = 6,
+};
+enum ColorimetryYCCDP {
+	ColorimetryYCC_DP_ITU601        = 0,
+	ColorimetryYCC_DP_ITU709        = 1,
+	ColorimetryYCC_DP_AdobeYCC      = 5,
+	ColorimetryYCC_DP_ITU2020YCC    = 6,
+	ColorimetryYCC_DP_ITU2020YCbCr  = 7,
+};
+
 static void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 		struct dc_info_packet *info_packet)
 {
 	unsigned int vscPacketRevision = 0;
 	unsigned int i;
+	unsigned int pixelEncoding = 0;
+	unsigned int colorimetryFormat = 0;
 
 	if (stream->timing.timing_3d_format != TIMING_3D_FORMAT_NONE && stream->view_format != VIEW_3D_FORMAT_NONE)
 		vscPacketRevision = 1;
 
-
 	/*VSC packet set to 2 when DP revision >= 1.2*/
 	if (stream->psr_version != 0)
 		vscPacketRevision = 2;
 
+	if (stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420)
+		vscPacketRevision = 5;
 
 	/* VSC packet not needed based on the features
 	 * supported by this DP display
@@ -81,6 +99,175 @@ static void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 
 		info_packet->valid = true;
 	}
+
+	/* 05h = VSC SDP supporting 3D stereo, PSR2, and Pixel Encoding/Colorimetry Format indication.
+	 *   Added in DP1.3, a DP Source device is allowed to indicate the pixel encoding/colorimetry
+	 *   format to the DP Sink device with VSC SDP only when the DP Sink device supports it
+	 *   (i.e., VSC_SDP_EXTENSION_FOR_COLORIMETRY_SUPPORTED bit in the DPRX_FEATURE_ENUMERATION_LIST
+	 *   register (DPCD Address 02210h, bit 3) is set to 1).
+	 *   (Requires VSC_SDP_EXTENSION_FOR_COLORIMETRY_SUPPORTED bit set to 1 in DPCD 02210h. This
+	 *   DPCD register is exposed in the new Extended Receiver Capability field for DPCD Rev. 1.4
+	 *   (and higher). When MISC1. bit 6. is Set to 1, a Source device uses a VSC SDP to indicate
+	 *   the Pixel Encoding/Colorimetry Format and that a Sink device must ignore MISC1, bit 7, and
+	 *   MISC0, bits 7:1 (MISC1, bit 7. and MISC0, bits 7:1 become “don’t care”).)
+	 */
+	if (vscPacketRevision == 0x5) {
+		/* Secondary-data Packet ID = 0 */
+		info_packet->hb0 = 0x00;
+		/* 07h - Packet Type Value indicating Video Stream Configuration packet */
+		info_packet->hb1 = 0x07;
+		/* 05h = VSC SDP supporting 3D stereo, PSR2, and Pixel Encoding/Colorimetry Format indication. */
+		info_packet->hb2 = 0x05;
+		/* 13h = VSC SDP supporting 3D stereo, + PSR2, + Pixel Encoding/Colorimetry Format indication (HB2 = 05h). */
+		info_packet->hb3 = 0x13;
+
+		info_packet->valid = true;
+
+		/* Set VSC SDP fields for pixel encoding and colorimetry format from DP 1.3 specs
+		 * Data Bytes DB 18~16
+		 * Bits 3:0 (Colorimetry Format)        |  Bits 7:4 (Pixel Encoding)
+		 * ----------------------------------------------------------------------------------------------------
+		 * 0x0 = sRGB                           |  0 = RGB
+		 * 0x1 = RGB Wide Gamut Fixed Point
+		 * 0x2 = RGB Wide Gamut Floating Point
+		 * 0x3 = AdobeRGB
+		 * 0x4 = DCI-P3
+		 * 0x5 = CustomColorProfile
+		 * (others reserved)
+		 * ----------------------------------------------------------------------------------------------------
+		 * 0x0 = ITU-R BT.601                   |  1 = YCbCr444
+		 * 0x1 = ITU-R BT.709
+		 * 0x2 = xvYCC601
+		 * 0x3 = xvYCC709
+		 * 0x4 = sYCC601
+		 * 0x5 = AdobeYCC601
+		 * 0x6 = ITU-R BT.2020 Y'cC'bcC'rc
+		 * 0x7 = ITU-R BT.2020 Y'C'bC'r
+		 * (others reserved)
+		 * ----------------------------------------------------------------------------------------------------
+		 * 0x0 = ITU-R BT.601                   |  2 = YCbCr422
+		 * 0x1 = ITU-R BT.709
+		 * 0x2 = xvYCC601
+		 * 0x3 = xvYCC709
+		 * 0x4 = sYCC601
+		 * 0x5 = AdobeYCC601
+		 * 0x6 = ITU-R BT.2020 Y'cC'bcC'rc
+		 * 0x7 = ITU-R BT.2020 Y'C'bC'r
+		 * (others reserved)
+		 * ----------------------------------------------------------------------------------------------------
+		 * 0x0 = ITU-R BT.601                   |  3 = YCbCr420
+		 * 0x1 = ITU-R BT.709
+		 * 0x2 = xvYCC601
+		 * 0x3 = xvYCC709
+		 * 0x4 = sYCC601
+		 * 0x5 = AdobeYCC601
+		 * 0x6 = ITU-R BT.2020 Y'cC'bcC'rc
+		 * 0x7 = ITU-R BT.2020 Y'C'bC'r
+		 * (others reserved)
+		 * ----------------------------------------------------------------------------------------------------
+		 * 0x0 =DICOM Part14 Grayscale          |  4 = Yonly
+		 * Display Function
+		 * (others reserved)
+		 */
+
+		/* Set Pixel Encoding */
+		switch (stream->timing.pixel_encoding) {
+		case PIXEL_ENCODING_RGB:
+			pixelEncoding = 0x0;  /* RGB = 0h */
+			break;
+		case PIXEL_ENCODING_YCBCR444:
+			pixelEncoding = 0x1;  /* YCbCr444 = 1h */
+			break;
+		case PIXEL_ENCODING_YCBCR422:
+			pixelEncoding = 0x2;  /* YCbCr422 = 2h */
+			break;
+		case PIXEL_ENCODING_YCBCR420:
+			pixelEncoding = 0x3;  /* YCbCr420 = 3h */
+			break;
+		default:
+			pixelEncoding = 0x0;  /* default RGB = 0h */
+			break;
+		}
+
+		/* Set Colorimetry format based on pixel encoding */
+		switch (stream->timing.pixel_encoding) {
+		case PIXEL_ENCODING_RGB:
+			if ((stream->output_color_space == COLOR_SPACE_SRGB) ||
+					(stream->output_color_space == COLOR_SPACE_SRGB_LIMITED))
+				colorimetryFormat = ColorimetryRGB_DP_sRGB;
+			else if (stream->output_color_space == COLOR_SPACE_ADOBERGB)
+				colorimetryFormat = ColorimetryRGB_DP_AdobeRGB;
+			else if ((stream->output_color_space == COLOR_SPACE_2020_RGB_FULLRANGE) ||
+					(stream->output_color_space == COLOR_SPACE_2020_RGB_LIMITEDRANGE))
+				colorimetryFormat = ColorimetryRGB_DP_ITU_R_BT2020RGB;
+			break;
+
+		case PIXEL_ENCODING_YCBCR444:
+		case PIXEL_ENCODING_YCBCR422:
+		case PIXEL_ENCODING_YCBCR420:
+			/* Note: xvYCC probably not supported correctly here on DP since colorspace translation
+			 * loses distinction between BT601 vs xvYCC601 in translation
+			 */
+			if (stream->output_color_space == COLOR_SPACE_YCBCR601)
+				colorimetryFormat = ColorimetryYCC_DP_ITU601;
+			else if (stream->output_color_space == COLOR_SPACE_YCBCR709)
+				colorimetryFormat = ColorimetryYCC_DP_ITU709;
+			else if (stream->output_color_space == COLOR_SPACE_ADOBERGB)
+				colorimetryFormat = ColorimetryYCC_DP_AdobeYCC;
+			else if (stream->output_color_space == COLOR_SPACE_2020_YCBCR)
+				colorimetryFormat = ColorimetryYCC_DP_ITU2020YCbCr;
+			break;
+
+		default:
+			colorimetryFormat = ColorimetryRGB_DP_sRGB;
+			break;
+		}
+
+		info_packet->sb[16] = (pixelEncoding << 4) | colorimetryFormat;
+
+		/* Set color depth */
+		switch (stream->timing.display_color_depth) {
+		case COLOR_DEPTH_666:
+			/* NOTE: This is actually not valid for YCbCr pixel encoding to have 6 bpc
+			 *       as of DP1.4 spec, but value of 0 probably reserved here for potential future use.
+			 */
+			info_packet->sb[17] = 0;
+			break;
+		case COLOR_DEPTH_888:
+			info_packet->sb[17] = 1;
+			break;
+		case COLOR_DEPTH_101010:
+			info_packet->sb[17] = 2;
+			break;
+		case COLOR_DEPTH_121212:
+			info_packet->sb[17] = 3;
+			break;
+		/*case COLOR_DEPTH_141414: -- NO SUCH FORMAT IN DP SPEC */
+		case COLOR_DEPTH_161616:
+			info_packet->sb[17] = 4;
+			break;
+		default:
+			info_packet->sb[17] = 0;
+			break;
+		}
+
+		/* all YCbCr are always limited range */
+		if ((stream->output_color_space == COLOR_SPACE_SRGB_LIMITED) ||
+				(stream->output_color_space == COLOR_SPACE_2020_RGB_LIMITEDRANGE) ||
+				(pixelEncoding != 0x0)) {
+			info_packet->sb[17] |= 0x80; /* DB17 bit 7 set to 1 for CEA timing. */
+		}
+
+		/* Content Type (Bits 2:0)
+		 *  0 = Not defined.
+		 *  1 = Graphics.
+		 *  2 = Photo.
+		 *  3 = Video.
+		 *  4 = Game.
+		 */
+		info_packet->sb[18] = 0;
+	}
+
 }
 
 void mod_build_infopackets(struct info_packet_inputs *inputs,
-- 
2.14.1


--===============1699163567==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1699163567==--
