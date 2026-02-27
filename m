Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39770FEFB53
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 14:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D256810EB72;
	Fri, 27 Feb 2026 14:00:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c0ZbGZ9m";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEF4610EB7D;
 Fri, 27 Feb 2026 14:00:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0F3F660131;
 Fri, 27 Feb 2026 14:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23747C2BCB9;
 Fri, 27 Feb 2026 14:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772200810;
 bh=mcyTpts1idXA1vu80zdOnmLrCaVShS7ucVh8Fhvdnfw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=c0ZbGZ9m99SIaXsBhhpP75b7OIKQ5akIbEhjYGH/ociDImdSOjZs7mjWJRvyxUMEX
 R+1MgYCVnhR0mhqxo04Sr8+BMqNcqvxhmFFbkVxh0LLMTVcP+aXm527UHxv64iq30/
 L4To7B5Gt3nsFdwkhwf8ZV+xFEcmzHD0Nkk3iqjBDi06iCdh+S9eaXk8EwJPfs+7jk
 ywKWySZkgx3thXh+x62WaJ2DC9+/O++WnaguUTndWmvJRAOtkcAEXuyoxT4U8reKUD
 v8WiH766yhGb6CmJKojxUgzGokM5CgZ//9M0k6J+UrOdKvZ6+l469p35joKCcuP/40
 D1cxQ6yqF/98A==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Feb 2026 14:59:49 +0100
Subject: [PATCH v2 05/14] drm/bridge: adv7511: Convert to
 drm_output_color_format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-drm-rework-color-formats-v2-5-8bd278e2af9d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622; i=mripard@kernel.org;
 h=from:subject:message-id; bh=mcyTpts1idXA1vu80zdOnmLrCaVShS7ucVh8Fhvdnfw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkLF4eWOi48nB5rr1u0oFLc4LbNvRXzYtgqQtruNFvcL
 NnBVH61YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExE3ZGx4WbILfMrJ/+FzXZm
 D3ZSuCJyr5Sr1FrmPWfC10ZnZ4YnNyovtjg/0Dd4s/zgz7ylUw5tYGzo7vto2CitbXWjxo1r4rm
 8Nw8jiiMXzwp4pLeqY+OVN2+2bPuxdWnoDUF3Sf8JUR9CZ3MAAA==
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

Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 1050bb62280bb4794f0b0ae01597269652c063d0..6bd76c1fb0071c8c9cd9c293b3a48a2b4487768e 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -226,11 +226,11 @@ static void adv7511_set_config_csc(struct adv7511 *adv7511,
 	} else {
 		config.csc_scaling_factor = ADV7511_CSC_SCALING_4;
 		config.csc_coefficents = adv7511_csc_ycbcr_to_rgb;
 
 		if ((connector->display_info.color_formats &
-		     DRM_COLOR_FORMAT_YCBCR422) &&
+		     BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422)) &&
 		    connector->display_info.is_hdmi) {
 			config.csc_enable = false;
 			output_format_422 = true;
 			output_format_ycbcr = true;
 		} else {

-- 
2.53.0

