Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56B3E9B250
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 10:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E95C10E546;
	Tue, 24 Feb 2026 10:59:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TYDIyXPc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F46410E545;
 Tue, 24 Feb 2026 10:58:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3D7B7433D3;
 Tue, 24 Feb 2026 10:58:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C782C19422;
 Tue, 24 Feb 2026 10:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771930738;
 bh=T5Bs9g3X6Xx/+k3pkJWiRgtJy/T9n9Pwc14/Z+cSoPg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=TYDIyXPcx64KXds6VHI8H3P8F20pQ1i64utAEoz1W7wBTG0Za5MDe+RQDH8oNjwB6
 /X1/1oYVcP6hMiZB60yAT+SJTg/Bdri3ByqCWxP23ZKTZ8E94+JRDefv12gSl6hHdE
 0m7Vvsq6AtOI07N6Is/3Nj06cgt4nv+cqkDo5RGq09hQsrOAKHheydjFj6qpeQa0QK
 1Ms/MxUdGTqRfIFeIET1FJB/W5nkBIqMv4fdy7M36CY7L2jk06YNjNr0f/E/1sgvx5
 9aT+Fe6t7JUGOaaA4Itg+ijiaAmQXF23rEEOrvn5/CMWljEndNKTpH7n7uhSVX/VMQ
 n0APsLr52jf4g==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 24 Feb 2026 11:58:41 +0100
Subject: [PATCH 02/14] drm/edid: Convert to drm_output_color_format enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-drm-rework-color-formats-v1-2-bebc76604ada@kernel.org>
References: <20260224-drm-rework-color-formats-v1-0-bebc76604ada@kernel.org>
In-Reply-To: <20260224-drm-rework-color-formats-v1-0-bebc76604ada@kernel.org>
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
 linux-sunxi@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4262; i=mripard@kernel.org;
 h=from:subject:message-id; bh=T5Bs9g3X6Xx/+k3pkJWiRgtJy/T9n9Pwc14/Z+cSoPg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJlzW5L/1f5fd1eO0ejd8/Kjh40PuH0MP1zFkVp9bLPJx
 gnV606HdExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJPNvHWGfDeHdS9LuF1y3j
 lEyWxa2Zu+3934kqTIwnpurfFxKvkLpyxrbdSs/1i3XwAnHGX1quJowNvfrbV1zt+PD75IwHi49
 6c1Q6sU+qPBs/mU1bsWerUItj7R/9rmgp2c3BDvKFvns1/v4GAA==
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

The main different is that while DRM_COLOR_FORMAT_ was a bitmask,
drm_output_color_format is a proper enum. However, the enum was done is
such a way than DRM_COLOR_FORMAT_X = BIT(DRM_OUTPUT_COLOR_FORMAT_X) so
the transitition is easier.

The only thing we need to consider is if the original code meant to use
that value as a bitmask, in which case we do need to keep the bit shift,
or as a discriminant in which case we don't.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_edid.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 26bb7710a46204548c150a25d390dac512ec7f0e..316bbdcdbbd3a9bb447e1a4127be9da039e306b5 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -5314,11 +5314,11 @@ static void parse_cta_y420cmdb(struct drm_connector *connector,
 	for (i = 0; i < map_len; i++)
 		map |= (u64)data[i] << (8 * i);
 
 out:
 	if (map)
-		info->color_formats |= DRM_COLOR_FORMAT_YCBCR420;
+		info->color_formats |= BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420);
 
 	*y420cmdb_map = map;
 }
 
 static int add_cea_modes(struct drm_connector *connector,
@@ -6090,11 +6090,11 @@ static void parse_cta_y420vdb(struct drm_connector *connector,
 
 		if (!drm_valid_cea_vic(vic))
 			continue;
 
 		bitmap_set(hdmi->y420_vdb_modes, vic, 1);
-		info->color_formats |= DRM_COLOR_FORMAT_YCBCR420;
+		info->color_formats |= BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420);
 	}
 }
 
 static void drm_parse_vcdb(struct drm_connector *connector, const u8 *db)
 {
@@ -6424,15 +6424,15 @@ static void drm_parse_cea_ext(struct drm_connector *connector,
 				    "[CONNECTOR:%d:%s] CEA extension version mismatch %u != %u\n",
 				    connector->base.id, connector->name,
 				    info->cea_rev, edid_ext[1]);
 
 		/* The existence of a CTA extension should imply RGB support */
-		info->color_formats = DRM_COLOR_FORMAT_RGB444;
+		info->color_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444);
 		if (edid_ext[3] & EDID_CEA_YCRCB444)
-			info->color_formats |= DRM_COLOR_FORMAT_YCBCR444;
+			info->color_formats |= BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444);
 		if (edid_ext[3] & EDID_CEA_YCRCB422)
-			info->color_formats |= DRM_COLOR_FORMAT_YCBCR422;
+			info->color_formats |= BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422);
 		if (edid_ext[3] & EDID_BASIC_AUDIO)
 			info->has_audio = true;
 
 	}
 	drm_edid_iter_end(&edid_iter);
@@ -6696,11 +6696,11 @@ static void update_display_info(struct drm_connector *connector,
 		goto out;
 
 	if (!drm_edid_is_digital(drm_edid))
 		goto out;
 
-	info->color_formats |= DRM_COLOR_FORMAT_RGB444;
+	info->color_formats |= BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444);
 	drm_parse_cea_ext(connector, drm_edid);
 
 	update_displayid_info(connector, drm_edid);
 
 	/*
@@ -6750,13 +6750,13 @@ static void update_display_info(struct drm_connector *connector,
 	drm_dbg_kms(connector->dev,
 		    "[CONNECTOR:%d:%s] Assigning EDID-1.4 digital sink color depth as %d bpc.\n",
 		    connector->base.id, connector->name, info->bpc);
 
 	if (edid->features & DRM_EDID_FEATURE_RGB_YCRCB444)
-		info->color_formats |= DRM_COLOR_FORMAT_YCBCR444;
+		info->color_formats |= BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444);
 	if (edid->features & DRM_EDID_FEATURE_RGB_YCRCB422)
-		info->color_formats |= DRM_COLOR_FORMAT_YCBCR422;
+		info->color_formats |= BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422);
 
 	drm_update_mso(connector, drm_edid);
 
 out:
 	if (drm_edid_has_internal_quirk(connector, EDID_QUIRK_NON_DESKTOP)) {
@@ -7227,11 +7227,11 @@ static bool is_hdmi2_sink(const struct drm_connector *connector)
 	 */
 	if (!connector)
 		return true;
 
 	return connector->display_info.hdmi.scdc.supported ||
-		connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR420;
+		connector->display_info.color_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420);
 }
 
 static u8 drm_mode_hdmi_vic(const struct drm_connector *connector,
 			    const struct drm_display_mode *mode)
 {

-- 
2.52.0

