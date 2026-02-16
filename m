Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D01BE68155
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCCDF10E48E;
	Tue, 17 Feb 2026 08:05:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tc3dAaiq";
	dkim-atps=neutral
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C45B110E3D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 16:45:52 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id
 a640c23a62f3a-b8f8d9b2c50so27325466b.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 08:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771260351; x=1771865151; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=il27DEcymwLna7hK1ELrrYkujYqTcKdi5syqhicz4KY=;
 b=Tc3dAaiqWgeKvv8pCgS46fZaR4wfdqo1XGla/h/GxPMPmUJqknncrGstljWsZBuHri
 DIvgKCkCeyErHWn0VL5/cJRu5Re+B9Fj8SN0Uh16U9qYcabcgCyFfNa5y56pwu3amy0E
 m6sdQ8oBIUIZSE62uDeT2KCVOX25SFrAvELwI46Lvc4Bc16+WOi7mYWKrcuGC8XI85Ie
 dX6yDwlAMJJ/D2TxKA4/RFw8uJumDu4sy9KO1VPOGFKtd3S1Pr/QGObzXp/Brke5PZbg
 SUOmC9r/xF/XFMRvDqi0i+TK2nSK/aSvr9P/IPU5uSdW4wQuY98RX9BjiXg2IVTiUEL5
 aq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260351; x=1771865151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=il27DEcymwLna7hK1ELrrYkujYqTcKdi5syqhicz4KY=;
 b=cyigqaAYQnexeuhF33bTpB1P1MIuXIBkjib8rPtNUASdwoLN3nZzhpzuhzkYPvVi16
 TWYv3VMmyiHWE7MQrfn4Zl1oRm/+3Qo6ccmRl4ZdCEybwfIYqXSNxXJfe6KYw+bPN3yU
 BQ+F47P0TEoyhunJPidXvlL45JfpzM9jc4c6hjzc7cCM4Mx2GN/cAqGyioO4WJvyr80T
 8+AkgenVaE68fSqJCkvRD0gzfEpADn7W4W3RCoWhu/0wdjp2ejW/XRfCBm2nB5kNhfEY
 xOTOz1gwz7nfdARNxP6ViyjjoGwhCy7sLn55lPVNRypmjDOI2f+lNtGEMfHdx+kRlJ3L
 Zc0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCceXvlXRmsdcXas42wB6XOu+3x9S3EUZRLFONU5Z9p73mxydd/67SaBCAVIvD/OPA365FT06E@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJsOM2mg5lINCShx1RsO8Dd3lp+/OfbVAwJaRPdSuY6Aj76EjU
 nJyiCeqXtT+iS2zT+J+PNM9BfQelJqlYTDud8hikTtFnMUfLzyljyN3a
X-Gm-Gg: AZuq6aKCrEXZWVvffjfAeilpvgqor3kZT+jl+G9uore7gr6jCA/jZqZyIkyvyS6xyt4
 cZL5g6ZDqg3p5YBD2Jk/andQIv8Oi73NtPPdMHv/CxPcQd9vRzvdr3o838nYd7M1PwW8kKCvcIq
 28u2hch9Grw8w3ZCJ5Gpz7w1tIhQuuuQMuvzIqcNb7dxqotZqxgPPOJi6pk6ykMUpqqEa0JtXch
 U7UhWyg7bLXiXcbnbmbBnjk/8ACuN4UiQknZ9WkWrpJQIakxNG3fudDjCs87jwJywGPrOXBwgyI
 km+doEB2oUTtFMZizWbRX8KqNEIVNBnOPMGlBgpX4c+F1NVSrN+hwlZT5zLL7q5RI5a2U1l8Ac7
 eOBQWQ1vO4ZiJ/qqzJrbeBnutUACaA6RKKHpgjJbzUfb6nitV2GYIK3N4crBgJpHJo7o+JVKh0f
 G5cttnkT/Yoen0LlANk+JJ+qLwxfDWdZdnFqv4Mp3tV4DiksmPIaKoO5TW7DYSMG/iBoCGp6I89
 YH1
X-Received: by 2002:a17:906:6a24:b0:b87:3c3a:cb7e with SMTP id
 a640c23a62f3a-b8face00ea5mr368595266b.6.1771260351124; 
 Mon, 16 Feb 2026 08:45:51 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d185sm264683866b.14.2026.02.16.08.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:45:50 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v4 24/27] drm: Add passive_vrr_capable property to connector
Date: Mon, 16 Feb 2026 17:45:13 +0100
Message-ID: <20260216164516.36803-25-tomasz.pakula.oficjalny@gmail.com>
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

Supplement to the passive_vrr_disabled crtc property

Drivers can add the property to a connector with
drm_connector_attach_passive_vrr_capable_property().
The value should be updated based on driver and hardware capability
by using drm_connector_set_passive_vrr_capable_property().

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/gpu/drm/drm_connector.c | 73 +++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h     | 15 +++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 272d6254ea47..5bb38b80e214 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2346,6 +2346,16 @@ EXPORT_SYMBOL(drm_mode_create_scaling_mode_property);
  *
  *	Absence of the property should indicate absence of support.
  *
+ * "passive_vrr_capable":
+ *	Optional &drm_connector boolean property that drivers should attach
+ *	with drm_connector_attach_passive_vrr_capable_property() on
+ *	connectors that could support keeping variable refresh rate signalling
+ *	in fixed-refresh rate scenarios like desktop work. Drivers should update
+ *	the property value by calling
+ *	drm_connector_set_passive_vrr_capable_property().
+ *
+ *	Absence of the property should indicate absence of support.
+ *
  * "VRR_ENABLED":
  *	Default &drm_crtc boolean property that notifies the driver that the
  *	content on the CRTC is suitable for variable refresh rate presentation.
@@ -2364,6 +2374,17 @@ EXPORT_SYMBOL(drm_mode_create_scaling_mode_property);
  *
  *	The driver may place further restrictions within these minimum
  *	and maximum bounds.
+ *
+ * "PASSIVE_VRR_DISABLED":
+ *	Default &drm_crtc boolean property that notifies the driver that the
+ *	VRR singalling should be disabled in fixed refresh rate scenarios.
+ *	Functionally, psssive vrr works the same as VRR_ENABLED == false
+ *	but works around displays blanking (mainly HDMI) that do not support
+ *	seamless VRR transitions. Also helps with brightness flickering during
+ *	VRR transitions.
+ *
+ *	Passive VRR mode is not that useful for DP/eDP sinks where seamless VRR
+ *	transitions are enforced by the standard.
  */
 
 /**
@@ -2397,6 +2418,37 @@ int drm_connector_attach_vrr_capable_property(
 }
 EXPORT_SYMBOL(drm_connector_attach_vrr_capable_property);
 
+/**
+ * drm_connector_attach_passive_vrr_capable_property - creates the
+ * passive_vrr_capable property
+ * @connector: connector to create the passive_vrr_capable property on.
+ *
+ * This is used by atomic drivers to add support for querying
+ * variable refresh rate on desktop capability for a connector.
+ *
+ * Returns:
+ * Zero on success, negative errno on failure.
+ */
+int drm_connector_attach_passive_vrr_capable_property(
+	struct drm_connector *connector)
+{
+	struct drm_device *dev = connector->dev;
+	struct drm_property *prop;
+
+	if (!connector->passive_vrr_capable_property) {
+		prop = drm_property_create_bool(dev, DRM_MODE_PROP_IMMUTABLE,
+			"passive_vrr_capable");
+		if (!prop)
+			return -ENOMEM;
+
+		connector->passive_vrr_capable_property = prop;
+		drm_object_attach_property(&connector->base, prop, 0);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_attach_passive_vrr_capable_property);
+
 /**
  * drm_connector_attach_scaling_mode_property - attach atomic scaling mode property
  * @connector: connector to attach scaling mode property on.
@@ -2968,6 +3020,27 @@ void drm_connector_set_vrr_capable_property(
 }
 EXPORT_SYMBOL(drm_connector_set_vrr_capable_property);
 
+/**
+ * drm_connector_set_passive_vrr_disabled_capable_property - sets the variable refresh
+ * rate on desktop capable property for a connector
+ * @connector: drm connector
+ * @capable: True if the connector is variable refresh rate on desktop capable
+ *
+ * Should be used by atomic drivers to update the indicated support for
+ * variable refresh rate on desktop over a connector.
+ */
+void drm_connector_set_passive_vrr_capable_property(
+		struct drm_connector *connector, bool capable)
+{
+	if (!connector->passive_vrr_capable_property)
+		return;
+
+	drm_object_property_set_value(&connector->base,
+				      connector->passive_vrr_capable_property,
+				      capable);
+}
+EXPORT_SYMBOL(drm_connector_set_passive_vrr_capable_property);
+
 /**
  * drm_connector_set_panel_orientation - sets the connector's panel_orientation
  * @connector: connector for which to set the panel-orientation property.
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index dab9d5521f41..30dd9737bfe0 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2101,6 +2101,17 @@ struct drm_connector {
 	 */
 	struct drm_property *vrr_capable_property;
 
+	/**
+	 * @passive_vrr_capable_property: Optional property to help userspace
+	 * query hardware support for passive variable refresh rate on a
+	 * connector. Drivers can add the property to a connector by
+	 * calling drm_connector_attach_passive_vrr_capable_property().
+	 *
+	 * This should be updated only by calling
+	 * drm_connector_set_passive_vrr_capable_property().
+	 */
+	struct drm_property *passive_vrr_capable_property;
+
 	/**
 	 * @colorspace_property: Connector property to set the suitable
 	 * colorspace supported by the sink.
@@ -2495,6 +2506,8 @@ int drm_connector_attach_scaling_mode_property(struct drm_connector *connector,
 					       u32 scaling_mode_mask);
 int drm_connector_attach_vrr_capable_property(
 		struct drm_connector *connector);
+int drm_connector_attach_passive_vrr_capable_property(
+		struct drm_connector *connector);
 int drm_connector_attach_broadcast_rgb_property(struct drm_connector *connector);
 int drm_connector_attach_colorspace_property(struct drm_connector *connector);
 int drm_connector_attach_hdr_output_metadata_property(struct drm_connector *connector);
@@ -2517,6 +2530,8 @@ void drm_connector_set_link_status_property(struct drm_connector *connector,
 					    uint64_t link_status);
 void drm_connector_set_vrr_capable_property(
 		struct drm_connector *connector, bool capable);
+void drm_connector_set_passive_vrr_capable_property(
+		struct drm_connector *connector, bool capable);
 int drm_connector_set_panel_orientation(
 	struct drm_connector *connector,
 	enum drm_panel_orientation panel_orientation);
-- 
2.53.0

