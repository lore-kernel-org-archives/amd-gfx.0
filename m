Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE14D625E0
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 08:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D36510E90E;
	Thu, 22 Jan 2026 08:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="f+EqDH3a";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B66DF10E22B;
 Wed, 21 Jan 2026 14:47:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1769006814; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Vb+9LKr511zHX6eegVlSx/OjtQgelcyAgVtzFhNwE8/bcmWUw6KUGmBdzIud+XZ89Gd/83TdFSwPwnw7L3USvJa5fCKcG+pFB/4c0+pogPTQA6D96OVAArtc2aPiChXW+JkrIypmkB+lPVcgyGYwQWu3/3miq3s4Lyew71rzSWE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1769006814;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=wtYUwdUZsrNFIDbbFkRufRXGPspOM1ME+M4e+AuGxio=; 
 b=BpH9UtnU2dHSDXy0Tx1B8VW7763hqZoaAf6z6lCJyfrOBSKVPuhX+N2+0xdXbuv7Y+HUHTGvPoptDE7DinIF6tcc/V4FrHNJko1GUbkaAE4Mkqu7Lt3HWmvqTZoByBTH7nvsjS0z1EzL9Z48Vp61h8OR4/p+JQ+c+htuFqs/BN0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769006814; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=wtYUwdUZsrNFIDbbFkRufRXGPspOM1ME+M4e+AuGxio=;
 b=f+EqDH3aVu2kl64X+UsHbR2CJv4ynXZNNLP8fYYtsOWVTtPOjQs7ykZ6FwmKKQbG
 Ub0ox7iljk9Va0y1ysFvwnSKJx61L1BqboTAxBNJlem5I08MlUD3K4wnhYW7NfO8MT2
 ypVLQGD8rI0P9wFqnSahk1bjYvhi/3qM9285LmQ8=
Received: by mx.zohomail.com with SMTPS id 1769006811743442.0611183045577;
 Wed, 21 Jan 2026 06:46:51 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 21 Jan 2026 15:45:17 +0100
Subject: [PATCH v7 10/22] drm/rockchip: vop2: Fix YUV444 output
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-color-format-v7-10-ef790dae780c@collabora.com>
References: <20260121-color-format-v7-0-ef790dae780c@collabora.com>
In-Reply-To: <20260121-color-format-v7-0-ef790dae780c@collabora.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Dmitry Baryshkov <lumag@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: kernel@collabora.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Thu, 22 Jan 2026 08:36:26 +0000
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

YUV444 (aka YCbCr444) output isn't working quite right on RK3588. The
resulting image on the display, while identifying itself as YUV444, has
some components swapped, even after adding the necessary DRM formats to
the conversion functions.

Judging by downstream, this is because YUV444 also needs an rb swap
performed in the AFBC case.

Add the DRM formats to the appropriate switch statements, and add a
function for checking whether an rb swap needs to be performed in the
AFBC case.

Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index ec3b4fde10db..469c63dd97d5 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -176,6 +176,7 @@ static enum vop2_data_format vop2_convert_format(u32 format)
 	case DRM_FORMAT_ARGB2101010:
 	case DRM_FORMAT_XBGR2101010:
 	case DRM_FORMAT_ABGR2101010:
+	case DRM_FORMAT_VUY101010:
 		return VOP2_FMT_XRGB101010;
 	case DRM_FORMAT_XRGB8888:
 	case DRM_FORMAT_ARGB8888:
@@ -184,6 +185,7 @@ static enum vop2_data_format vop2_convert_format(u32 format)
 		return VOP2_FMT_ARGB8888;
 	case DRM_FORMAT_RGB888:
 	case DRM_FORMAT_BGR888:
+	case DRM_FORMAT_VUY888:
 		return VOP2_FMT_RGB888;
 	case DRM_FORMAT_RGB565:
 	case DRM_FORMAT_BGR565:
@@ -225,6 +227,7 @@ static enum vop2_afbc_format vop2_convert_afbc_format(u32 format)
 	case DRM_FORMAT_ARGB2101010:
 	case DRM_FORMAT_XBGR2101010:
 	case DRM_FORMAT_ABGR2101010:
+	case DRM_FORMAT_VUY101010:
 		return VOP2_AFBC_FMT_ARGB2101010;
 	case DRM_FORMAT_XRGB8888:
 	case DRM_FORMAT_ARGB8888:
@@ -233,6 +236,7 @@ static enum vop2_afbc_format vop2_convert_afbc_format(u32 format)
 		return VOP2_AFBC_FMT_ARGB8888;
 	case DRM_FORMAT_RGB888:
 	case DRM_FORMAT_BGR888:
+	case DRM_FORMAT_VUY888:
 		return VOP2_AFBC_FMT_RGB888;
 	case DRM_FORMAT_RGB565:
 	case DRM_FORMAT_BGR565:
@@ -270,6 +274,19 @@ static bool vop2_win_rb_swap(u32 format)
 	}
 }
 
+static bool vop2_afbc_rb_swap(u32 format)
+{
+	switch (format) {
+	case DRM_FORMAT_NV24:
+	case DRM_FORMAT_NV30:
+	case DRM_FORMAT_VUY888:
+	case DRM_FORMAT_VUY101010:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static bool vop2_afbc_uv_swap(u32 format)
 {
 	switch (format) {
@@ -1291,6 +1308,7 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 		 /* It's for head stride, each head size is 16 byte */
 		stride = ALIGN(stride, block_w) / block_w * 16;
 
+		rb_swap = vop2_afbc_rb_swap(fb->format->format);
 		uv_swap = vop2_afbc_uv_swap(fb->format->format);
 		/*
 		 * This is a workaround for crazy IC design, Cluster
@@ -1308,6 +1326,7 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 			vop2_win_write(win, VOP2_WIN_AFBC_ENABLE, 1);
 		vop2_win_write(win, VOP2_WIN_AFBC_FORMAT, afbc_format);
 		vop2_win_write(win, VOP2_WIN_AFBC_UV_SWAP, uv_swap);
+		vop2_win_write(win, VOP2_WIN_AFBC_RB_SWAP, rb_swap);
 		/*
 		 * On rk3566/8, this bit is auto gating enable,
 		 * but this function is not work well so we need

-- 
2.52.0

