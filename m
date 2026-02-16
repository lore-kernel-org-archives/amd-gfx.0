Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464C1E68141
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C236810E48D;
	Tue, 17 Feb 2026 08:05:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EDWawg1X";
	dkim-atps=neutral
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EE6110E3D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 16:45:51 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id
 a640c23a62f3a-b8de2b5a122so59444866b.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 08:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771260350; x=1771865150; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8GHywGhoa9nMFX4SKcKZGp9++GBGqwr6bmHnyfGvrOs=;
 b=EDWawg1X3Ug5z1kKxLc+n+JFkpnv+Qgw9mCzoDanpw9F+ufRMw+Fs5revMplq5v0Be
 hrRjviyDTB+5+XYIs5h23CA1vSgE6DujppUzUCUDLg+uLH/qBpAYMtPGJclpNzlqnmLY
 daQ1hklIJ0smZAaHYRGRhUGDKpP1/D44Rq3pmomnT8wgXwtf0V0J8TeVB9M6J/p/De5M
 YSOJPip1Pf02ba/vwo2/rhzlv/mzBZIjPShEjMli9eGTgG4X5bx35Dx7gfNFMRn6e61h
 L//ZsIFE+J+M0UeX0ZogX8YXezsk5drmOvzW+Eh7AomYPXSSxkJPriTWIs6fw5IN0jkl
 wvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260350; x=1771865150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8GHywGhoa9nMFX4SKcKZGp9++GBGqwr6bmHnyfGvrOs=;
 b=lsgX7c3ekItsYFC7lTSoZl08KCTcsw3c+1YpspMuD3lxAT7Z0pDhUDLP3TZSEmWHVi
 fOwVkkm0OqKcdRqVtFajB8BicFBaRcVlBXAKIkJBg+K6+dspArr5d+7jTQgZ8GyBJmkf
 akRcUXPAc05WcY/Pv4nkowD4j3HIpPVV2vEJpC+rXCROsmabmCa55ryk02ovXOAKrZWg
 KWUtYbqW89iGeBl2ijmd3bMZDdZYpburOG2cN48ILrtRvXnOAudww1RwDj3bB9faxnNp
 pcEuyLzz7atK7bunIGzhl7rW5CR1cp7o0iSD9l5LSmAyZ6JPs692bNjrG7WhuhFlI9YZ
 4uIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHhtbq/9CJc8qZ3B0KzK3k/Z+1Bxu5keMbdEumv9o2/YBKMaMsFAEllGDHdmGSc0x1FLTAJK2s@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZUHQVKSmMPDm6iy+kSk+5PpLeYCbrqSOv+b1HEOWf7Wv2zX6W
 TLIbb/DvJYF9OxwKLxjiv592w1NxaUv4vs9W47Tj8TzOQC2LkNaXaN56t/PXt/Bs
X-Gm-Gg: AZuq6aKih7af/jxPGxd/99SJFt4s9+KV1pOg0fS3g7fVvyIVWrlhU6BlMcVQtdBMSL3
 IEmfh78LZJH7I2i98naAXxOxNYx3cM9vVxRTgpow6NLsPZwOY9ZfcEewMpw3W9H/8NmAt0F3Sgh
 FBQc3OOucNktQJHc4aNkJsScQUhZyAa40KXAoJ912eC3jcTugYmZMjOTgsqh/d4QLurqq2zgDZR
 AHqhReyvu8v5KuqoVm/D+btOnHfeX93DwBFUjTwyXhRDHUJMS2eZ838E3E8uqQMfkuQjM3D98vd
 i+bDdu3C15x0OFatkodx170LqlrSfm5UVXTyja4z1/jqBYxbGeccyXAAtxFuRd/uB8w3BaLtxZa
 8Q7DHaQi3DzHVs21WSm2UvcrH8BSvOwFs+wCKRrtJcXZFEYXFLWKvHeUaMW+HkPqpMo1noDGoyr
 rAozTTylSKPfihzLes0HpnwCBy0dv912UgwK5fiMYtRQwCvN804bgSTrZUSpfC4Qv7JwYQt1FvR
 qR//BMtWauloTU=
X-Received: by 2002:a17:906:6a0f:b0:b8e:7dcb:7f23 with SMTP id
 a640c23a62f3a-b8facc9d34dmr363796266b.2.1771260349806; 
 Mon, 16 Feb 2026 08:45:49 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d185sm264683866b.14.2026.02.16.08.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:45:49 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v4 23/27] drm: Add passive_vrr_disabled property to crtc
Date: Mon, 16 Feb 2026 17:45:12 +0100
Message-ID: <20260216164516.36803-24-tomasz.pakula.oficjalny@gmail.com>
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

Many TVs and other HDMI sinks suffer from blanking and possibly other
glitches when VRR is toggled. With VRR present on such sinks and
vrr_on_desktop enabled, they behave like the signal is always variable,
even in fixed refresh rate situations. DisplayPort and eDP enforce
seamless VRR transitions but HDMI unfortunately doesn't.

Keep VRR toggled if it's supported and not explicitly disabled. It can
be used for any VRR sinks, but this is mainly targeted for HDMI.

Functionally, for an end user, this is the same as normal, fixed refresh
rate mode. The only difference is that sink is kept in VRR state which
enables seamless transitions into/out of variable refresh rate.

Basically, the driver shouldn't change it's behavior around VRR_ENABLED
set to false, jut keep sending info packets/frames with VRR/FreeSync/
G-Sync/HDMI VRR active.

Enabled by default for sinks that claim it's support

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 4 ++++
 drivers/gpu/drm/drm_crtc.c        | 2 ++
 drivers/gpu/drm/drm_mode_config.c | 6 ++++++
 include/drm/drm_crtc.h            | 9 +++++++++
 include/drm/drm_mode_config.h     | 6 ++++++
 5 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index b2cb5ae5a139..a3ad2fe3306b 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -383,6 +383,8 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
 		return ret;
 	} else if (property == config->prop_vrr_enabled) {
 		state->vrr_enabled = val;
+	} else if (property == config->prop_passive_vrr_disabled) {
+		state->passive_vrr_disabled = val;
 	} else if (property == config->degamma_lut_property) {
 		ret = drm_property_replace_blob_from_id(dev,
 					&state->degamma_lut,
@@ -448,6 +450,8 @@ drm_atomic_crtc_get_property(struct drm_crtc *crtc,
 		*val = (state->mode_blob) ? state->mode_blob->base.id : 0;
 	else if (property == config->prop_vrr_enabled)
 		*val = state->vrr_enabled;
+	else if (property == config->prop_passive_vrr_disabled)
+		*val = state->passive_vrr_disabled;
 	else if (property == config->degamma_lut_property)
 		*val = (state->degamma_lut) ? state->degamma_lut->base.id : 0;
 	else if (property == config->ctm_property)
diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index a7797d260f1e..4f2c871552e5 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -322,6 +322,8 @@ static int __drm_crtc_init_with_planes(struct drm_device *dev, struct drm_crtc *
 					   config->prop_out_fence_ptr, 0);
 		drm_object_attach_property(&crtc->base,
 					   config->prop_vrr_enabled, 0);
+		drm_object_attach_property(&crtc->base,
+					   config->prop_passive_vrr_disabled, 0);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 25f376869b3a..542d21d7ca36 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -340,6 +340,12 @@ static int drm_mode_create_standard_properties(struct drm_device *dev)
 		return -ENOMEM;
 	dev->mode_config.prop_vrr_enabled = prop;
 
+	prop = drm_property_create_bool(dev, 0,
+			"PASSIVE_VRR_DISABLED");
+	if (!prop)
+		return -ENOMEM;
+	dev->mode_config.prop_passive_vrr_disabled = prop;
+
 	prop = drm_property_create(dev,
 			DRM_MODE_PROP_BLOB,
 			"DEGAMMA_LUT", 0);
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 66278ffeebd6..59dbb7ce1358 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -299,6 +299,15 @@ struct drm_crtc_state {
 	 */
 	bool vrr_enabled;
 
+	/**
+	 * @passive_vrr_disabled:
+	 *
+	 * Indicates if variable refresh rate on desktop should be enabled for
+	 * the CRTC. Support for the requested state will depend on driver and
+	 * hardware capabiltiy - lacking support is not treated as failure.
+	 */
+	bool passive_vrr_disabled;
+
 	/**
 	 * @self_refresh_active:
 	 *
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 2e848b816218..541cfaba67a2 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -679,6 +679,12 @@ struct drm_mode_config {
 	 * whether variable refresh rate should be enabled on the CRTC.
 	 */
 	struct drm_property *prop_vrr_enabled;
+	/**
+	 * @prop_passive_vrr_disabled: Default atomic CRTC property to indicate
+	 * whether passive variable refresh rate should be disabled
+	 * on the CRTC.
+	 */
+	struct drm_property *prop_passive_vrr_disabled;
 
 	/**
 	 * @dvi_i_subconnector_property: Optional DVI-I property to
-- 
2.53.0

