Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79049EEF334
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 09:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEEF710EBA9;
	Thu,  5 Mar 2026 09:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kOccXVVp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DEE610EBA6;
 Thu,  5 Mar 2026 09:05:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0B10A6183B;
 Thu,  5 Mar 2026 09:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303BAC116C6;
 Thu,  5 Mar 2026 09:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772701506;
 bh=pALwRFzWIQKTpcLw9NIyZWrgGnwzLJRpPmwmiwUCRco=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=kOccXVVpzQJcoK4ZH1qTKM3+cnAQeelrqtoUyy1JqsNlr1R8sMgpP0+IUjaLut8LB
 STkK8FUuw4Joye8r5/jx8Xc87nLEzLulTTEVhwqKQ5Eae4xnZ4KUDH5DKkcFxPZwAx
 tWME1d/v7hz/JPYdfurBhneA/DX/y4xz2wGTB9GifjSTu9hyT16AE8cd1lstlyZr5h
 gwVga/FXeCeBhElapZ3OC8O5/ODOk+DPZbSr7z8ErgVEr3Q83GxhUd0FE9UgrR44c7
 ukmVy0Kr30393ldmezE1vAZuvdnwer/hIO0bxScSIb/ethb3odHJuN/tkv7ebqyBsA
 OYlH+Pbu5glHw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Mar 2026 10:04:53 +0100
Subject: [PATCH v3 01/14] drm/connector: Introduce drm_output_color_format enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-drm-rework-color-formats-v3-1-f3935f6db579@kernel.org>
References: <20260305-drm-rework-color-formats-v3-0-f3935f6db579@kernel.org>
In-Reply-To: <20260305-drm-rework-color-formats-v3-0-f3935f6db579@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Andy Yan <andy.yan@rock-chips.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Liu Ying <victor.liu@nxp.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, Jani Nikula <jani.nikula@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4252; i=mripard@kernel.org;
 h=from:subject:message-id; bh=pALwRFzWIQKTpcLw9NIyZWrgGnwzLJRpPmwmiwUCRco=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkr3c0uiehK3JxY4pAnEdi8pPXmK+NPb/WuJ7M5hL3m0
 BN7f+5Mx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhI0j/GhvdXVjaW/XFoMX7H
 edi2M87TwFpK/uwdt8uRi/pMeV47s2zJn7hs/seMzfVs/o65SpdSGWv4VlkkuLtYvVsT6KLmknY
 +s3dFYZVrXV3S8QzZs8ZmGbJbXNudVq3IT8iturXAIf09AwA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The EDID parsing code initially introduced the DRM_COLOR_FORMAT_*
defines to represent the sink capabilities. Since a given sink could
support multiple formats, it was first defined as a bitmask.

However, the core and drivers have since leveraged those defines to
represent both the supported formats but also the current format being
used.

Considering the latter case, the more natural, and consistent, thing to
do would be to create an enum of all the possible formats, and then list
the supported formats using a bitmask of the individual enum values.

Let's create a new enum following that pattern, drm_output_color_format,
while maintaining the DRM_COLOR_FORMAT_* compatibility to make the
transition easier.

Acked-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/drm/drm_connector.h | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index c18be8c19de0ab1e02e7d7b1fcd9f2ab5ef1dd15..227f6190438679104f5336be088a73f4529c15fa 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -554,10 +554,35 @@ enum drm_colorspace {
 	DRM_MODE_COLORIMETRY_RGB_WIDE_FLOAT	= 14,
 	DRM_MODE_COLORIMETRY_BT601_YCC		= 15,
 	DRM_MODE_COLORIMETRY_COUNT
 };
 
+/**
+ * enum drm_output_color_format - Output Color Format
+ *
+ * This enum is a consolidated color format list supported by
+ * connectors. It's only ever really been used for HDMI and DP so far,
+ * so it's not exhaustive and can be extended to represent other formats
+ * in the future.
+ *
+ *
+ * @DRM_OUTPUT_COLOR_FORMAT_RGB444:
+ *   RGB output format
+ * @DRM_OUTPUT_COLOR_FORMAT_YCBCR444:
+ *   YCbCr 4:4:4 output format (ie. not subsampled)
+ * @DRM_OUTPUT_COLOR_FORMAT_YCBCR422:
+ *   YCbCr 4:2:2 output format (ie. with horizontal subsampling)
+ * @DRM_OUTPUT_COLOR_FORMAT_YCBCR420:
+ *   YCbCr 4:2:0 output format (ie. with horizontal and vertical subsampling)
+ */
+enum drm_output_color_format {
+	DRM_OUTPUT_COLOR_FORMAT_RGB444 = 0,
+	DRM_OUTPUT_COLOR_FORMAT_YCBCR444,
+	DRM_OUTPUT_COLOR_FORMAT_YCBCR422,
+	DRM_OUTPUT_COLOR_FORMAT_YCBCR420,
+};
+
 /**
  * enum drm_bus_flags - bus_flags info for &drm_display_info
  *
  * This enum defines signal polarities and clock edge information for signals on
  * a bus as bitmask flags.
@@ -697,14 +722,14 @@ struct drm_display_info {
 	/**
 	 * @subpixel_order: Subpixel order of LCD panels.
 	 */
 	enum subpixel_order subpixel_order;
 
-#define DRM_COLOR_FORMAT_RGB444		(1<<0)
-#define DRM_COLOR_FORMAT_YCBCR444	(1<<1)
-#define DRM_COLOR_FORMAT_YCBCR422	(1<<2)
-#define DRM_COLOR_FORMAT_YCBCR420	(1<<3)
+#define DRM_COLOR_FORMAT_RGB444		(1 << DRM_OUTPUT_COLOR_FORMAT_RGB444)
+#define DRM_COLOR_FORMAT_YCBCR444	(1 << DRM_OUTPUT_COLOR_FORMAT_YCBCR444)
+#define DRM_COLOR_FORMAT_YCBCR422	(1 << DRM_OUTPUT_COLOR_FORMAT_YCBCR422)
+#define DRM_COLOR_FORMAT_YCBCR420	(1 << DRM_OUTPUT_COLOR_FORMAT_YCBCR420)
 
 	/**
 	 * @panel_orientation: Read only connector property for built-in panels,
 	 * indicating the orientation of the panel vs the device's casing.
 	 * drm_connector_init() sets this to DRM_MODE_PANEL_ORIENTATION_UNKNOWN.
@@ -712,14 +737,15 @@ struct drm_display_info {
 	 * fb to compensate and gets exported as prop to userspace.
 	 */
 	int panel_orientation;
 
 	/**
-	 * @color_formats: HDMI Color formats, selects between RGB and YCrCb
-	 * modes. Used DRM_COLOR_FORMAT\_ defines, which are _not_ the same ones
-	 * as used to describe the pixel format in framebuffers, and also don't
-	 * match the formats in @bus_formats which are shared with v4l.
+	 * @color_formats: HDMI Color formats, selects between RGB and
+	 * YCbCr modes. Uses a bitmask of DRM_OUTPUT_COLOR_FORMAT\_
+	 * defines, which are _not_ the same ones as used to describe
+	 * the pixel format in framebuffers, and also don't match the
+	 * formats in @bus_formats which are shared with v4l.
 	 */
 	u32 color_formats;
 
 	/**
 	 * @bus_formats: Pixel data format on the wire, somewhat redundant with

-- 
2.53.0

