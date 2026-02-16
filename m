Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4579DE81A26
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC2F710E46A;
	Tue, 17 Feb 2026 08:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="FpBVMtkJ";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3D7410E35F;
 Mon, 16 Feb 2026 13:02:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1771246923; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eZVJThR2gA+t6hkkAUI5SiueBkenMCTQGNboTDOT65PQZMu3+zq00/VhZBiglKzBsk1jA2N07djIqRDFnII5j26Eu8F9DhZmFII2ZesM8ylBZJQFSb1iaYzRXJ9JnSUXARypRiFxyyc05s4RH8+nJYSuDOxeuaiNR+x0MZxyxcs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1771246923;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=E6/IL9T9r6JCufl0RYsNc7jJmCuMbPJaKhaRNoo53fQ=; 
 b=KRAM4C9X2fTMr9MLZ2xbdRCP7NvnMxvBcYwYIrRrMnO1tuVg+DRiwOsRO1nUZ/z9d7GIFTl5aTm/ZMlA6caww4W/QcW6DK/JGiGJlN8bP7qjNM4MsMJXW4DbdcOoNjfpqLJqx7qLBjMFrVLNR61kz57mPiieoLytaA4mRXUtrK4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771246923; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=E6/IL9T9r6JCufl0RYsNc7jJmCuMbPJaKhaRNoo53fQ=;
 b=FpBVMtkJwvPluuKs/sxzKjDlt1CbhDZFt4WkGb9BSe4LMlPQW1yoSMu69gTAt74y
 HpVAFcu5AdSRH1ubBHV+nepgFnJpdvIBDjRHU5DX4mp8uaN9D1PdaLLIxQ3qdSCjuJe
 7weY5+F2NQaz25CVMfZb17kXtAL7ShwL1ChjauVc=
Received: by mx.zohomail.com with SMTPS id 1771246921436134.4296104447676;
 Mon, 16 Feb 2026 05:02:01 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 16 Feb 2026 14:01:17 +0100
Subject: [PATCH v8 03/20] drm: Add enum conversions for drm_color_format_enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-color-format-v8-3-5722ce175dd5@collabora.com>
References: <20260216-color-format-v8-0-5722ce175dd5@collabora.com>
In-Reply-To: <20260216-color-format-v8-0-5722ce175dd5@collabora.com>
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
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Marius Vlad <marius.vlad@collabora.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Tue, 17 Feb 2026 08:05:08 +0000
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

While the drm_color_format_enum enum and the hdmi_colorspace enum have
similar values, they're not identical, and HDMI's enum is defined as per
the HDMI standard.

Meanwhile, each DRM_COLOR_FORMAT_* define has a corresponding
drm_color_format_enum, which allows conversion from the bitshifted
defines to the enum values.

Implement conversion functions from DRM_COLOR_FORMAT bitshifted defines
to drm_color_format_enum, and from hdmi_colorspace enum values to
drm_color_format_enum enum values.

In both conversions, an unexpected input results in a
DRM_COLOR_FORMAT_ENUM_INVALID result. The functions are kept inline
__pure to give the compiler maximum freedom to do as it pleases.

Co-developed-by: Marius Vlad <marius.vlad@collabora.com>
Signed-off-by: Marius Vlad <marius.vlad@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 include/drm/drm_connector.h | 53 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 18bd875b6918..886defdd069b 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2694,6 +2694,59 @@ int drm_connector_attach_color_format_property(struct drm_connector *connector);
 
 const char *drm_get_color_format_name(enum drm_color_format_enum color_fmt);
 
+/**
+ * drm_color_format_to_enum - convert a single DRM_COLOR_FORMAT\_ to enum
+ * @fmt: One of the possible DRM_COLOR_FORMAT\_ values
+ *
+ * Converts a single DRM_COLOR_FORMAT\_ value to a corresponding
+ * &enum drm_color_format_enum value. Bitmasks of multiple DRM_COLOR_FORMAT\_
+ * values are not supported, as they would not map to a single enum value.
+ *
+ * Returns converted enum value on success, or %DRM_COLOR_FORMAT_ENUM_INVALID on
+ * failure.
+ */
+static inline enum drm_color_format_enum __pure
+drm_color_format_to_enum(u32 fmt)
+{
+	switch (fmt) {
+	case DRM_COLOR_FORMAT_RGB444:
+		return DRM_COLOR_FORMAT_ENUM_RGB444;
+	case DRM_COLOR_FORMAT_YCBCR444:
+		return DRM_COLOR_FORMAT_ENUM_YCBCR444;
+	case DRM_COLOR_FORMAT_YCBCR422:
+		return DRM_COLOR_FORMAT_ENUM_YCBCR422;
+	case DRM_COLOR_FORMAT_YCBCR420:
+		return DRM_COLOR_FORMAT_ENUM_YCBCR420;
+	default:
+		return DRM_COLOR_FORMAT_ENUM_INVALID;
+	}
+}
+
+/**
+ * drm_color_format_enum_from_hdmi_colorspace - convert hdmi_colorspace enum to
+ *                                              drm_color_format_enum
+ * @fmt: The &enum hdmi_colorspace to convert
+ *
+ * Returns the converted result on success, or %DRM_COLOR_FORMAT_ENUM_INVALID on
+ * failure.
+ */
+static inline enum drm_color_format_enum __pure
+drm_color_format_enum_from_hdmi_colorspace(enum hdmi_colorspace fmt)
+{
+	switch (fmt) {
+	case HDMI_COLORSPACE_RGB:
+		return DRM_COLOR_FORMAT_ENUM_RGB444;
+	case HDMI_COLORSPACE_YUV444:
+		return DRM_COLOR_FORMAT_ENUM_YCBCR444;
+	case HDMI_COLORSPACE_YUV422:
+		return DRM_COLOR_FORMAT_ENUM_YCBCR422;
+	case HDMI_COLORSPACE_YUV420:
+		return DRM_COLOR_FORMAT_ENUM_YCBCR420;
+	default:
+		return DRM_COLOR_FORMAT_ENUM_INVALID;
+	}
+}
+
 /**
  * drm_for_each_connector_iter - connector_list iterator macro
  * @connector: &struct drm_connector pointer used as cursor

-- 
2.53.0

