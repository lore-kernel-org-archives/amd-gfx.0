Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC8FFEFB52
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 14:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D943710EB77;
	Fri, 27 Feb 2026 14:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QU0F0kJ5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1449A10EB77;
 Fri, 27 Feb 2026 14:00:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E15C540B1F;
 Fri, 27 Feb 2026 14:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429D1C19423;
 Fri, 27 Feb 2026 14:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772200821;
 bh=pmuV9XT5xz4TIGCX33nAahI5S0bV94XYGEmoM0J00kE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=QU0F0kJ5NBlgWFhg738XGBv5DVWfKxPpFdsmRUjAYRflkwtxpQ5Gei814H2aTjtQP
 cm4zFGisMDOTjsgdrhSkJvgzhLlUYpd9VWazCXFEZ/UHHPFxJHSV82S7swMwxUwvVO
 fgu6HxZceVtp7b+sk9Vqs1CeB5XSmy3dkqF8XMlWPC1X7KBgBbvL6QDvfrZxfatjwH
 zfyljkcwr4VFZwYLK0N92JL8/LAqbxYJWJWyOj53vCJ1UTJPwfVmx5N1F5sZ3QD5ra
 o6iAtf8pWpmZ2d/wh45BBc0IA49nFp3nJrQkofK+ypA/5FLvKkZV8+ZHGQJHYvVGOd
 zcVQ0Rw3l5cTQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Feb 2026 14:59:53 +0100
Subject: [PATCH v2 09/14] drm/bridge: synopsys: dw-hdmi: Convert to
 drm_output_color_format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-drm-rework-color-formats-v2-9-8bd278e2af9d@kernel.org>
References: <20260227-drm-rework-color-formats-v2-0-8bd278e2af9d@kernel.org>
In-Reply-To: <20260227-drm-rework-color-formats-v2-0-8bd278e2af9d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3565; i=mripard@kernel.org;
 h=from:subject:message-id; bh=pmuV9XT5xz4TIGCX33nAahI5S0bV94XYGEmoM0J00kE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkLF4d12J2ec9SgUd/+lbB1K6Oz7krdD6zXeANUI1O+S
 t09u3tjx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhI+QvGOrX6Y1dleQX5VHl+
 XJk0SSKOO/Fw+ETn5DVKWlbZc90etBd8dJSdtHXisXv6K5Mfml61YqzTeC2kaeNweFLACqZS8W9
 p6llsDiZst4TsT704sfyswKU9dWtVbzz+aZWhuD1ZqSLQSAEA
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

Now that we introduced a new drm_output_color_format enum to represent
what DRM_COLOR_FORMAT_* bits were representing, we can switch to the new
enum.

The main difference is that while DRM_COLOR_FORMAT_ was a bitmask,
drm_output_color_format is a proper enum. However, the enum was done is
such a way than DRM_COLOR_FORMAT_X = BIT(DRM_OUTPUT_COLOR_FORMAT_X) so
the transitition is easier.

The only thing we need to consider is if the original code meant to use
that value as a bitmask, in which case we do need to keep the bit shift,
or as a discriminant in which case we don't.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index ee88c0e793b0416d20105a43448cb4037402e64b..0296e110ce65ffc284e120f4e3f92052474e83e5 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2662,11 +2662,11 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
 	struct drm_connector *conn = conn_state->connector;
 	struct drm_display_info *info = &conn->display_info;
 	struct drm_display_mode *mode = &crtc_state->mode;
 	u8 max_bpc = conn_state->max_requested_bpc;
 	bool is_hdmi2_sink = info->hdmi.scdc.supported ||
-			     (info->color_formats & DRM_COLOR_FORMAT_YCBCR420);
+			     (info->color_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420));
 	u32 *output_fmts;
 	unsigned int i = 0;
 
 	*num_output_fmts = 0;
 
@@ -2721,40 +2721,40 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
 
 	/* Default 8bit RGB fallback */
 	output_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
 
 	if (max_bpc >= 16 && info->bpc == 16) {
-		if (info->color_formats & DRM_COLOR_FORMAT_YCBCR444)
+		if (info->color_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444))
 			output_fmts[i++] = MEDIA_BUS_FMT_YUV16_1X48;
 
 		output_fmts[i++] = MEDIA_BUS_FMT_RGB161616_1X48;
 	}
 
 	if (max_bpc >= 12 && info->bpc >= 12) {
-		if (info->color_formats & DRM_COLOR_FORMAT_YCBCR422)
+		if (info->color_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422))
 			output_fmts[i++] = MEDIA_BUS_FMT_UYVY12_1X24;
 
-		if (info->color_formats & DRM_COLOR_FORMAT_YCBCR444)
+		if (info->color_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444))
 			output_fmts[i++] = MEDIA_BUS_FMT_YUV12_1X36;
 
 		output_fmts[i++] = MEDIA_BUS_FMT_RGB121212_1X36;
 	}
 
 	if (max_bpc >= 10 && info->bpc >= 10) {
-		if (info->color_formats & DRM_COLOR_FORMAT_YCBCR422)
+		if (info->color_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422))
 			output_fmts[i++] = MEDIA_BUS_FMT_UYVY10_1X20;
 
-		if (info->color_formats & DRM_COLOR_FORMAT_YCBCR444)
+		if (info->color_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444))
 			output_fmts[i++] = MEDIA_BUS_FMT_YUV10_1X30;
 
 		output_fmts[i++] = MEDIA_BUS_FMT_RGB101010_1X30;
 	}
 
-	if (info->color_formats & DRM_COLOR_FORMAT_YCBCR422)
+	if (info->color_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422))
 		output_fmts[i++] = MEDIA_BUS_FMT_UYVY8_1X16;
 
-	if (info->color_formats & DRM_COLOR_FORMAT_YCBCR444)
+	if (info->color_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444))
 		output_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
 
 	*num_output_fmts = i;
 
 	return output_fmts;

-- 
2.53.0

