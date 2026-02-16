Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF1DE68157
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50E0D10E498;
	Tue, 17 Feb 2026 08:05:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SCZ6Mgv5";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38DF310E3D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 16:45:54 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-b8fb8f14538so61302966b.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 08:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771260353; x=1771865153; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OELXgTEKNOln1QbMyB2O7aWm6BMQADWB4ffEkfUoOx4=;
 b=SCZ6Mgv5ZWfb6914fZqHHGLu0b9ZWDaCJJqxvEvg7YVseUQM+1ciV5wK71ZOp/4YKM
 MG3rBTv/XfWeAvcWbpANe2DG9SrlRSG6y6xPGR4kq4ebFllY2aZ3IG9myMo+UVtzaaqu
 gF1t3QXanU21JdlHPbkT9uiMw68xEu0v5YNqIfLm//mzEWgz+1QhVQ6+nb9UPf559H4G
 4buwpp1LJ+d+WHZdqHVPCguGPkwPkq9BERKVJljmnO97ORmATNqMfKWmz6A8ZhRX1yUv
 7k572qFyGptDQ1FsWFnaBJTGBBGH1sAwiRlY7yADwA81OvCTuFIhdr94akqEVSbWpv28
 M9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260353; x=1771865153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OELXgTEKNOln1QbMyB2O7aWm6BMQADWB4ffEkfUoOx4=;
 b=OhQge48xbH2ezwgbita1utmPdc0PsLWlHC369v2UzuHixzcuqLiEPM0xx3LML8bKwN
 BPKZUixEmnKPQVpLAPw7fzGgUAsuoFGHqtLJlzy0FM+3raSjr7MNn0c2UJfDt3R3wwYx
 IuRRQq8D6Q2yDNFFLiXu6K2Ms5oKdwSfxBpoMaSiF37ylVjaZpUkEc9FsnPwn1B3DgnH
 lEiQ1rZP+m8veVPZ4h09sFua1ctGi9iqon+uBTemSbghwtoepN+gNzqXV/kVHXaqz4kN
 dXeHHCL+46HfAR/szr7RZ0k2/UC2hxYRChWqrywhucjp0ezgJU9Ogh8uh9AHnXRsbKo7
 zVrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVACNjoCqPFwdbRAWytPPnp+5M2scRqbggIUuMsLqzLQ5+pMu5iiaY5A9LUAXLUDtrl8G78ElvE@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywp4rMoBM7BJ4aBsy5vKhoKPi9CdSqr+oNRmjVOeCJzf/TLFE7n
 VxW6QzY2rr3vsNcpwolkF7MBpSXrRnTr+fV3rsmpk78nnQSTA6kz2VQ3
X-Gm-Gg: AZuq6aI7gLtKbrJnBvXLvqbM25q5sayeoY+nMipxwfRzNfLnl1Hg+MHLSnKrTuI7iDE
 7DATs0R2MtXTiK1l0EkMqlzewQmwRr78rLysBTnRkn2NnHpb4bTvbH62Ju34S7w+tRLQgLn8zPO
 XlYqwmEpcQHZo6BfDXIinD5Kx2aeayRtNG6RHoLd4zHYxF5m/0b/oV5G07TBIZzD+hq02VXE0nN
 3+E7FffkHkXYtO2ec05FXmq9JgKCOlbTiEiv9WLby26whMGFPqFUvz8RnVxyY58GMZsCnwwi4IB
 Dbr8z/2GUuObmDRsPxEH/uUar0tAnpzGhJpg3Z02aOfb5RIHm7iqwNO1skHHRbKFSxaXl1eDOcp
 Z45/FitO7yrfXfOSy3iiqU1uYe+LT10NRHai1M91txofTEJX1Yq9YPCh6KLGt8eFxMiWdjKQTPJ
 NqjDL7UHZd7OudjG2dkrtqgbK1iJO2Apm1UaRYpSECBhHU+YYDVnso2/kUivvWQUqyPI7CMi06W
 gni
X-Received: by 2002:a17:907:2686:b0:b8e:fd74:f6b7 with SMTP id
 a640c23a62f3a-b8facdf05a6mr322216666b.5.1771260352482; 
 Mon, 16 Feb 2026 08:45:52 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d185sm264683866b.14.2026.02.16.08.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:45:52 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v4 25/27] drm: Add ALLM properties to connector
Date: Mon, 16 Feb 2026 17:45:14 +0100
Message-ID: <20260216164516.36803-26-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216164516.36803-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260216164516.36803-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Adds HDMI Auto Low Latency Mode optional connector properties allm_mode
and allm_mode_capable.

ALLM automatically puts TVs into low latency modes (gaming modes) and
it's part of the HDMI Gaming Features introduced in HDMI 2.1.

allm_mode_capable indicates whether connector (sink) supports ALLM
allm_mode tells the driver which triggering mode to use. Off, dynamic
and always on. Dynamic mode should consider the content type and the
state of the crtc to discern whether ALLM should be activated.

Recommendation is Content Type Hint == Game || VRR_ENABLED based on
testing behaviors on other operating systems and multiple GPU vendors +
how TVs behave.

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c |   4 ++
 drivers/gpu/drm/drm_connector.c   | 115 ++++++++++++++++++++++++++++++
 include/drm/drm_connector.h       |  37 ++++++++++
 3 files changed, 156 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index a3ad2fe3306b..cfb50a3d617d 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -758,6 +758,8 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
 		state->content_type = val;
 	} else if (property == connector->scaling_mode_property) {
 		state->scaling_mode = val;
+	} else if (property == connector->allm_mode_property) {
+		state->allm_mode = val;
 	} else if (property == config->content_protection_property) {
 		if (val == DRM_MODE_CONTENT_PROTECTION_ENABLED) {
 			drm_dbg_kms(dev, "only drivers can set CP Enabled\n");
@@ -855,6 +857,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
 		*val = state->colorspace;
 	} else if (property == connector->scaling_mode_property) {
 		*val = state->scaling_mode;
+	} else if (property == connector->allm_mode_property) {
+		*val = state->allm_mode;
 	} else if (property == config->hdr_output_metadata_property) {
 		*val = state->hdr_output_metadata ?
 			state->hdr_output_metadata->base.id : 0;
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 5bb38b80e214..14d504ca73f4 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1226,6 +1226,12 @@ static const struct drm_prop_enum_list drm_content_type_enum_list[] = {
 	{ DRM_MODE_CONTENT_TYPE_GAME, "Game" },
 };
 
+static const struct drm_prop_enum_list drm_allm_mode_enum_list[] = {
+	{ DRM_ALLM_MODE_DISABLED, "Disabled" },
+	{ DRM_ALLM_MODE_ENABLED_DYNAMIC, "Dynamic" },
+	{ DRM_ALLM_MODE_ENABLED_FORCED, "Always On" },
+};
+
 static const struct drm_prop_enum_list drm_panel_orientation_enum_list[] = {
 	{ DRM_MODE_PANEL_ORIENTATION_NORMAL,	"Normal"	},
 	{ DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP,	"Upside Down"	},
@@ -2449,6 +2455,94 @@ int drm_connector_attach_passive_vrr_capable_property(
 }
 EXPORT_SYMBOL(drm_connector_attach_passive_vrr_capable_property);
 
+/**
+ * DOC: Auto Low Latency Mode properties
+ *
+ * Auto Low Latency capable HDMI displays (be it PC monitors or TVs)
+ * can automatically enter a "low latency" mode, usually named "Game Mode" by
+ * receiving specific data in HDMI Forum vendor-specific info frame.
+ *
+ * This usually is the best mode for PC usage but disables as much processing as
+ * possible which might not be desireable on lower end devices casing them to
+ * produce an image that's unsatisfactory to some users.
+ *
+ * "allm_capable":
+ *	Optional &drm_connector boolean property that drivers should attach
+ *	with drm_connector_attach_allm_capable_property() on connectors that
+ *	could support Auto Low Latency Mode. Drivers should update the
+ *	property value by calling drm_connector_set_allm_capable_property().
+ *
+ *	Absence of the property should indicate absence of support.
+ *
+ * "ALLM_MODE":
+ *	Optional &drm_connector enum property enables compositors to control and
+ *	expose ALLM triggering behavior modes to the end user where:
+ *
+ *	- ALLM_MODE_DISABLED: completely disabled ALLM signalling.
+ *	- ALLM_MODE_ENABLED_DYNAMIC: triggers ALLM based on current needs.
+ *	  preferrably display content type hint being set to Game by compositor
+ *	  or VRR being enabled and active.
+ *	- ALLM_MODE_ENABLED_FORCED: always-on ALLM triggering.
+ *
+ *	ALLM_MODE_ENABLED_DYNAMIC should behave like gaming devices such as
+ *	consoles where ALLM is only triggered when needed. It's main purpose is
+ *	gaming (part of so-called HDMI gaming features).
+ *
+ *	If compositors wish to control ALLM completely on their own, they can
+ *	switch between disabled and enabled_forced modes.
+ */
+
+/**
+ * drm_connector_attach_allm_capable_property - creates the
+ * allm_capable property
+ * @connector: connector to create the allm_capable property on.
+ *
+ * This is used by atomic drivers to add support for querying
+ * Auto Low Latency Mode capability for a connector.
+ *
+ * Returns:
+ * Zero on success, negative errno on failure.
+ */
+int drm_connector_attach_allm_capable_property(struct drm_connector *connector)
+{
+	struct drm_device *dev = connector->dev;
+	struct drm_property *prop;
+
+	if (!connector->allm_capable_property) {
+		prop = drm_property_create_bool(dev, DRM_MODE_PROP_IMMUTABLE,
+			"allm_capable");
+		if (!prop)
+			return -ENOMEM;
+
+		connector->allm_capable_property = prop;
+		drm_object_attach_property(&connector->base, prop, 0);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_attach_allm_capable_property);
+
+int drm_connector_attach_allm_mode_property(struct drm_connector *connector)
+{
+	struct drm_property *prop;
+
+	if (connector->allm_mode_property)
+		return 0;
+
+	prop = drm_property_create_enum(connector->dev, 0, "allm_mode",
+					drm_allm_mode_enum_list,
+					ARRAY_SIZE(drm_allm_mode_enum_list));
+	if (!prop)
+		return -ENOMEM;
+
+	connector->allm_mode_property = prop;
+	drm_object_attach_property(&connector->base, prop,
+				   DRM_ALLM_MODE_DISABLED);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_attach_allm_mode_property);
+
 /**
  * drm_connector_attach_scaling_mode_property - attach atomic scaling mode property
  * @connector: connector to attach scaling mode property on.
@@ -3041,6 +3135,27 @@ void drm_connector_set_passive_vrr_capable_property(
 }
 EXPORT_SYMBOL(drm_connector_set_passive_vrr_capable_property);
 
+/**
+ * drm_connector_set_allm_capable_property - sets Auto Low Latency Mode
+ * capable property for a connector
+ * @connector: drm connector
+ * @capable: True if the connector is ALLM capable
+ *
+ * Should be used by atomic drivers to update the indicated support for
+ * Auto Low Latency Mode over a connector.
+ */
+void drm_connector_set_allm_capable_property(
+		struct drm_connector *connector, bool capable)
+{
+	if (!connector->allm_capable_property)
+		return;
+
+	drm_object_property_set_value(&connector->base,
+				      connector->allm_capable_property,
+				      capable);
+}
+EXPORT_SYMBOL(drm_connector_set_allm_capable_property);
+
 /**
  * drm_connector_set_panel_orientation - sets the connector's panel_orientation
  * @connector: connector for which to set the panel-orientation property.
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 30dd9737bfe0..fa4abfe8971e 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -58,6 +58,12 @@ enum drm_connector_force {
 	DRM_FORCE_ON_DIGITAL, /* for DVI-I use digital connector */
 };
 
+enum drm_allm_mode {
+	DRM_ALLM_MODE_DISABLED,
+	DRM_ALLM_MODE_ENABLED_DYNAMIC,
+	DRM_ALLM_MODE_ENABLED_FORCED,
+};
+
 /**
  * enum drm_connector_status - status for a &drm_connector
  *
@@ -1147,6 +1153,13 @@ struct drm_connector_state {
 	 */
 	unsigned int content_protection;
 
+	/**
+	 * @allm_mode: Connector property to control the
+	 * HDMI Auto Low Latency Mode trigger setting.
+	 * The %DRM_ALLM_MODE_\* values must match the values.
+	 */
+	enum drm_allm_mode allm_mode;
+
 	/**
 	 * @colorspace: State variable for Connector property to request
 	 * colorspace change on Sink. This is most commonly used to switch
@@ -2112,6 +2125,26 @@ struct drm_connector {
 	 */
 	struct drm_property *passive_vrr_capable_property;
 
+	/**
+	 * @allm_capable_property: Optional property to help userspace
+	 * query hardware support for HDMI Auto Low Latency Mode on a connector.
+	 * Drivers can add the property to a connector by calling
+	 * drm_connector_attach_allm_capable_property().
+	 *
+	 * This should be updated only by calling
+	 * drm_connector_set_allm_capable_property().
+	 */
+	struct drm_property *allm_capable_property;
+
+	/**
+	 * @allm_mode_property:
+	 *
+	 * Indicates HDMI Auto Low Latency Mode triggering mode for connector.
+	 * Support for the requested state will depend on driver and hardware
+	 * capabiltiy - lacking support is not treated as failure.
+	 */
+	struct drm_property *allm_mode_property;
+
 	/**
 	 * @colorspace_property: Connector property to set the suitable
 	 * colorspace supported by the sink.
@@ -2508,6 +2541,8 @@ int drm_connector_attach_vrr_capable_property(
 		struct drm_connector *connector);
 int drm_connector_attach_passive_vrr_capable_property(
 		struct drm_connector *connector);
+int drm_connector_attach_allm_capable_property(struct drm_connector *connector);
+int drm_connector_attach_allm_mode_property(struct drm_connector *connector);
 int drm_connector_attach_broadcast_rgb_property(struct drm_connector *connector);
 int drm_connector_attach_colorspace_property(struct drm_connector *connector);
 int drm_connector_attach_hdr_output_metadata_property(struct drm_connector *connector);
@@ -2532,6 +2567,8 @@ void drm_connector_set_vrr_capable_property(
 		struct drm_connector *connector, bool capable);
 void drm_connector_set_passive_vrr_capable_property(
 		struct drm_connector *connector, bool capable);
+void drm_connector_set_allm_capable_property(
+		struct drm_connector *connector, bool capable);
 int drm_connector_set_panel_orientation(
 	struct drm_connector *connector,
 	enum drm_panel_orientation panel_orientation);
-- 
2.53.0

