Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749BDC4453A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 13:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2A5A10E7A2;
	Wed, 21 Jan 2026 13:47:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="EXDLm7Pl";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C8F210E22D;
 Wed, 21 Jan 2026 13:46:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1769003178; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SyAMyDaKKo4o8sMbqVNu9U1VYcy6ru7q/Sa6d6S+xV6PCoP2D7ivYsSfKuAsWwR78jINhE1QHCOlBrNyYNQsDl5Baq6904fgC6rX+q2vVKyMQRXN4ZCVPeKchrmoiioa2PnjO6n2rjPer9OZpGyvaeP3RD0qZO90VNOTumIy9eY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1769003178;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=8tbnRLxC7YN9OmZ6Ssd8CDhleEgMPvrSDskSel3YjYw=; 
 b=oBH0DP9UsaQ5coKQJE3hc/8IS14W1xqqa1b0JVNdz26oVOk+LoGFVFutJxlqXVb3tpvnfOWk/vlp2+aj9Hqi2hPNW7v/Z5Z88+kT0+ZCS+LDZVSxFyQndMKymvT+fO1rHnkKmX5EVbe3mz4Qz5JA3hV7XEYbHAL15in0iOOmGs4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769003178; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=8tbnRLxC7YN9OmZ6Ssd8CDhleEgMPvrSDskSel3YjYw=;
 b=EXDLm7PlBylZ09uoyc7VtUczgxLe8v4VUF/RlL0G6gkcy0DIwysXoug9F04WjlAu
 jAcKbhuh+DSpxEnf6TbKNYH7NhLXYBvKk8d6qfuN/I7mgFDy/NXi0v0cyFdA3SLsLTv
 HSGBIbHWZ5NC8YtwWzmo8ALBrv42lUa4vb3GV93s=
Received: by mx.zohomail.com with SMTPS id 1769003176579352.97627818605895;
 Wed, 21 Jan 2026 05:46:16 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 21 Jan 2026 14:45:29 +0100
Subject: [PATCH v6 03/21] drm: Add enum conversions between
 DRM_COLOR_FORMAT and HDMI_COLORSPACE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-color-format-v6-3-7b81a771cd0b@collabora.com>
References: <20260121-color-format-v6-0-7b81a771cd0b@collabora.com>
In-Reply-To: <20260121-color-format-v6-0-7b81a771cd0b@collabora.com>
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
X-Mailman-Approved-At: Wed, 21 Jan 2026 13:47:28 +0000
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

While the two enums have similar values, they're not identical, and
HDMI's enum is defined as per the HDMI standard.

Add a simple conversion function from DRM to HDMI. Unexpected inputs
aren't handled in any clever way, DRM_COLOR_FORMAT_AUTO and any other
value that doesn't cleanly map to HDMI just gets returned as
HDMI_COLORSPACE_RGB.

Add a second conversion function that gets a DRM_COLOR_FORMAT from an
HDMI_COLORSPACE as well. In this case, reserved HDMI values that can't
be converted will result in an -EINVAL return value.

Co-developed-by: Marius Vlad <marius.vlad@collabora.com>
Signed-off-by: Marius Vlad <marius.vlad@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 include/drm/drm_connector.h | 54 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index b5604dca728a..ffeb42f3b4a3 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2612,6 +2612,60 @@ int drm_connector_attach_color_format_property(struct drm_connector *connector);
 
 const char *drm_get_color_format_name(enum drm_color_format color_fmt);
 
+/**
+ * drm_color_format_to_hdmi_colorspace - convert DRM color format to HDMI
+ * @fmt: the &enum drm_color_format to convert
+ *
+ * Convert a given &enum drm_color_format to an equivalent
+ * &enum hdmi_colorspace. For non-representable values and
+ * %DRM_COLOR_FORMAT_AUTO, the value %HDMI_COLORSPACE_RGB is returned.
+ *
+ * Returns: the corresponding &enum hdmi_colorspace value
+ */
+static inline enum hdmi_colorspace __pure
+drm_color_format_to_hdmi_colorspace(enum drm_color_format fmt)
+{
+	switch (fmt) {
+	default:
+	case DRM_COLOR_FORMAT_AUTO:
+	case DRM_COLOR_FORMAT_RGB444:
+		return HDMI_COLORSPACE_RGB;
+	case DRM_COLOR_FORMAT_YCBCR444:
+		return HDMI_COLORSPACE_YUV444;
+	case DRM_COLOR_FORMAT_YCBCR422:
+		return HDMI_COLORSPACE_YUV422;
+	case DRM_COLOR_FORMAT_YCBCR420:
+		return HDMI_COLORSPACE_YUV420;
+	}
+}
+
+/**
+ * drm_color_format_from_hdmi_colorspace - convert HDMI color format to DRM
+ * @fmt: the &enum hdmi_colorspace to convert
+ *
+ * Convert a given &enum hdmi_colorspace to an equivalent
+ * &enum drm_color_format. For non-representable values,
+ * %-EINVAL is returned.
+ *
+ * Returns: the corresponding &enum drm_color_format value, or %-EINVAL
+ */
+static inline enum drm_color_format __pure
+drm_color_format_from_hdmi_colorspace(enum hdmi_colorspace fmt)
+{
+	switch (fmt) {
+	default:
+		return -EINVAL;
+	case HDMI_COLORSPACE_RGB:
+		return DRM_COLOR_FORMAT_RGB444;
+	case HDMI_COLORSPACE_YUV444:
+		return DRM_COLOR_FORMAT_YCBCR444;
+	case HDMI_COLORSPACE_YUV422:
+		return DRM_COLOR_FORMAT_YCBCR422;
+	case HDMI_COLORSPACE_YUV420:
+		return DRM_COLOR_FORMAT_YCBCR420;
+	}
+}
+
 /**
  * drm_for_each_connector_iter - connector_list iterator macro
  * @connector: &struct drm_connector pointer used as cursor

-- 
2.52.0

