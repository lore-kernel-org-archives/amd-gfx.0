Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E491C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 16:46:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9FEA113FD3;
	Thu, 14 Jul 2022 16:46:25 +0000 (UTC)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E685E11A15E
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 16:46:23 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx0.riseup.net (Postfix) with ESMTPS id 4LkL3g1zPyz9sNS;
 Thu, 14 Jul 2022 16:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1657817183; bh=iweKthUHdKlhOTcSMGGX6+Rf4qEc/hjtzzY/EYgwALA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jGAeLotWQekZpFF+LbxQYUzIMqdQINkhmKldNMn7yYrMRc78FI7PVuPLldmwEtUmX
 W5QBN/QTlr0uA9zapsceqTt3hA5uZ+g0ZTOcQshb0vaOhTjsR4OGpONXeI93Y42kuN
 V6lw16FwlteENZ/OccDOYIJDeanKTKi/N6LSXoLU=
X-Riseup-User-ID: 875C06D15C65357653ED97A82AE3A3350BDEC14D7CDD0112E796DA457EB5C193
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4LkL3X53Hsz5vW1;
 Thu, 14 Jul 2022 16:46:16 +0000 (UTC)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH 08/12] drm/amd/display: Remove unused variables from
 dcn10_stream_encoder
Date: Thu, 14 Jul 2022 13:45:03 -0300
Message-Id: <20220714164507.561751-8-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-1-mairacanal@riseup.net>
References: <20220714164507.561751-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: magalilemes00@gmail.com, tales.aparecida@gmail.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, mwen@igalia.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The variable regval from the function enc1_update_generic_info_packet
and the variables dynamic_range_rgb and dynamic_range_ycbcr from the
function enc1_stream_encoder_dp_set_stream_attribute are not currently
used.

This was pointed by clang with the following warnings:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_stream_encoder.c:62:11:
warning: variable 'regval' set but not used [-Wunused-but-set-variable]
        uint32_t regval;
                 ^
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_stream_encoder.c:262:10:
warning: variable 'dynamic_range_rgb' set but not used [-Wunused-but-set-variable]
        uint8_t dynamic_range_rgb = 0; /*full range*/
                ^
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_stream_encoder.c:263:10:
warning: variable 'dynamic_range_ycbcr' set but not used [-Wunused-but-set-variable]
        uint8_t dynamic_range_ycbcr = 1; /*bt709*/
                ^
3 warnings generated.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 .../drm/amd/display/dc/dcn10/dcn10_stream_encoder.c    | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index c99c6fababa9..484e7cdf00b8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -59,7 +59,6 @@ void enc1_update_generic_info_packet(
 	uint32_t packet_index,
 	const struct dc_info_packet *info_packet)
 {
-	uint32_t regval;
 	/* TODOFPGA Figure out a proper number for max_retries polling for lock
 	 * use 50 for now.
 	 */
@@ -88,7 +87,6 @@ void enc1_update_generic_info_packet(
 	REG_UPDATE(AFMT_VBI_PACKET_CONTROL, AFMT_GENERIC_CONFLICT_CLR, 1);
 
 	/* choose which generic packet to use */
-	regval = REG_READ(AFMT_VBI_PACKET_CONTROL);
 	REG_UPDATE(AFMT_VBI_PACKET_CONTROL,
 			AFMT_GENERIC_INDEX, packet_index);
 
@@ -259,8 +257,6 @@ void enc1_stream_encoder_dp_set_stream_attribute(
 	uint32_t h_back_porch;
 	uint8_t synchronous_clock = 0; /* asynchronous mode */
 	uint8_t colorimetry_bpc;
-	uint8_t dynamic_range_rgb = 0; /*full range*/
-	uint8_t dynamic_range_ycbcr = 1; /*bt709*/
 	uint8_t dp_pixel_encoding = 0;
 	uint8_t dp_component_depth = 0;
 
@@ -372,18 +368,15 @@ void enc1_stream_encoder_dp_set_stream_attribute(
 	switch (output_color_space) {
 	case COLOR_SPACE_SRGB:
 		misc1 = misc1 & ~0x80; /* bit7 = 0*/
-		dynamic_range_rgb = 0; /*full range*/
 		break;
 	case COLOR_SPACE_SRGB_LIMITED:
 		misc0 = misc0 | 0x8; /* bit3=1 */
 		misc1 = misc1 & ~0x80; /* bit7 = 0*/
-		dynamic_range_rgb = 1; /*limited range*/
 		break;
 	case COLOR_SPACE_YCBCR601:
 	case COLOR_SPACE_YCBCR601_LIMITED:
 		misc0 = misc0 | 0x8; /* bit3=1, bit4=0 */
 		misc1 = misc1 & ~0x80; /* bit7 = 0*/
-		dynamic_range_ycbcr = 0; /*bt601*/
 		if (hw_crtc_timing.pixel_encoding == PIXEL_ENCODING_YCBCR422)
 			misc0 = misc0 | 0x2; /* bit2=0, bit1=1 */
 		else if (hw_crtc_timing.pixel_encoding == PIXEL_ENCODING_YCBCR444)
@@ -393,15 +386,12 @@ void enc1_stream_encoder_dp_set_stream_attribute(
 	case COLOR_SPACE_YCBCR709_LIMITED:
 		misc0 = misc0 | 0x18; /* bit3=1, bit4=1 */
 		misc1 = misc1 & ~0x80; /* bit7 = 0*/
-		dynamic_range_ycbcr = 1; /*bt709*/
 		if (hw_crtc_timing.pixel_encoding == PIXEL_ENCODING_YCBCR422)
 			misc0 = misc0 | 0x2; /* bit2=0, bit1=1 */
 		else if (hw_crtc_timing.pixel_encoding == PIXEL_ENCODING_YCBCR444)
 			misc0 = misc0 | 0x4; /* bit2=1, bit1=0 */
 		break;
 	case COLOR_SPACE_2020_RGB_LIMITEDRANGE:
-		dynamic_range_rgb = 1; /*limited range*/
-		break;
 	case COLOR_SPACE_2020_RGB_FULLRANGE:
 	case COLOR_SPACE_2020_YCBCR:
 	case COLOR_SPACE_XR_RGB:
-- 
2.36.1

