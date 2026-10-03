Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841E1CA5FDD
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Oct 2026 16:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C98B10E2B8;
	Sat,  3 Oct 2026 16:15:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dm0BSHuJ";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1824610E2B1
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Oct 2026 16:15:55 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a11603310fso6544515e9.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 03 Oct 2026 09:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791044153; x=1791648953; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ya85XkpyrpMe6Lfgalo1nGODKz5TM2XHUGeehhaYQEs=;
 b=dm0BSHuJe2NDpCZ7h3uZ90YR/YwAnxmUosWLlfcbSriJn3xMF5ZX1nDpjhEXxURk0L
 XrMIPzEEwXrsin/FD+yMt1VkLhy0YaiDUQC+pueyOAwcG6HuKfvY8Wpr4GZDv6VJ1dhg
 vTgNqQlGreD3jfdSJdrFOrK7LZt43roqGJukDu5iSaroC2hV+tkRjDmVTFnvTtba5jf9
 uIxEqO/6hMIahDB49LRa6qvo/UAO22BY9X7AayyUNtKXhOw462fBBYA6mrYOTureQeTu
 E+gpBbU6bkETRbf91HhE7FJ6W0+z8yEeq0kyEajak18GepXUiYtQ9wga+O3SgYDXNXEu
 X4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791044153; x=1791648953;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ya85XkpyrpMe6Lfgalo1nGODKz5TM2XHUGeehhaYQEs=;
 b=MlAahfQtGphjNMecNChdBg8WuSYXwPD9hNv0/TNTcL+/yMeCnHwCFfSZf6hw8QcLaz
 IO3lzWbE8odnDreEbUQEpgtpQQn+cAenC0YcI/Q42eampE2UckV38297nz0eJyaWIKBG
 rQo7PMdHDN60y9bCgmbrxcScEhOGnLh0LfpPlNfswCBxzHUWe17jn681STGmzVDy5J8e
 UO5cLmPH/vbZHvGgXEj4f9jQIjFql4e1IIUNr7RZOeaj0cBW4tRn3PD1e+6sqwmuIySb
 DqG0ps0bk28mt6ptwINvnYTbfr1YBMhKFmide3ahbGmOCVy9NLs7ttqlO2gHTRPlWH/H
 3oRg==
X-Forwarded-Encrypted: i=1;
 AKwUvByVMRpQMMktT+A0dxUgfy13jDdXZElFe3nDPuFJmK2k26zkGU1sakYZzAAKSrTdwqG4eiqpSyqL@lists.freedesktop.org
X-Gm-Message-State: AFuF++mkhJrlxcGIpiOsdYwZCoD7kw76hns63T5u2PeqmO0IjBN88d/P
 uReA66AZeCNuNfP3kO8KUC8ZMVWS+cZoP32mVjcH9Wc8xAlGFExYEAG1
X-Gm-Gg: AYBFou3l19XR2pDR30aHTWc+ngNUO5RneM9CeYbDPsKu1GQ7SEJBCRmZ1Wbf7h8bgKb
 8JzgG3lNjgGYpt8i6A+7u3Zu0hyODPcDYforEVM9ldM/bADaYpP1dxYWgxkpskobw9bgwTk7trg
 3sxRfUoRh2ks/yRqLolt1ehin/QlNss2P3ZeWEdEeIBaqRS69ImattRvdVoaEIcOuwpsYe/slMd
 JvVU5IyZ/3qjPG5TvoQ2KiLLIL+Rpux6q2xI5MWpDKXT6F+FvC93ua+NnDx4P4S8586GAeJF14w
 dQjZkHElOGgy1SOylqmgS/mNNRdyELzMDkBc46A7+yxikphCH4+gMmUZ/bcXtxZjbDP879vv6kM
 6kStVvzh+JypRFXBkQbpZHjBefNc2Niv4N4HNJfvst/sjTiJZrSM/CuqE5S2ex8DBFpfdR4QNqU
 a76/cdgdlJLH18gTmkQLEinRZiO8Q8HExSq53ND9GJPV4Yc071I9yZVO+BUqShLZZiMCtsTE5mM
 1GPnrDYIhnzIdh+P2H41PiVQ5dsJeqOR/4O7qPxBCjHPznIYtL2tAZe5VVex3sj2uy/
X-Received: by 2002:a05:600c:4e13:b0:49c:cee0:e7c1 with SMTP id
 5b1f17b1804b1-4a02757999cmr98416455e9.16.1791044153155; 
 Sat, 03 Oct 2026 09:15:53 -0700 (PDT)
Received: from localhost
 (p200300eba703ae00ca7f54fffe019321.dip0.t-ipconnect.de.
 [2003:eb:a703:ae00:ca7f:54ff:fe01:9321])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a02854073csm167309945e9.3.2026.10.03.09.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 09:15:52 -0700 (PDT)
From: =?UTF-8?q?Johannes=20W=C3=BCller?= <johanneswueller@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: =?UTF-8?q?Johannes=20W=C3=BCller?= <johanneswueller@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@intel.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 2/2] drm/amd: fix HDMI signal type for EDID overrides
Date: Sat,  3 Oct 2026 18:15:08 +0200
Message-ID: <20261003161525.23600-3-johanneswueller@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261003161525.23600-1-johanneswueller@gmail.com>
References: <20261003161525.23600-1-johanneswueller@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

If an EDID override is in effect (e.g. via debugfs edid_override or
drm.edid_firmware kernel parameter), the overriding EDID may not
advertise capabilities matching the physical connector being used.
In that case, trust the physical connector type over the EDID in
create_eml_sink() and dm_helpers_parse_edid_caps().

Signed-off-by: Johannes Wüller <johanneswueller@gmail.com>
---
v2: rebased; create_eml_sink() now lives in amdgpu_dm_connector.c.

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c  | 9 ++++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c    | 9 ++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index ad3383169d83..2bce57b06037 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -2134,7 +2134,14 @@ VISIBLE_IF_KUNIT void create_eml_sink(struct amdgpu_dm_connector *aconnector)
 		return;
 	}
 
-	if (connector->display_info.is_hdmi)
+	/*
+	 * If an EDID override is active, it may not advertise HDMI capability
+	 * even though the physical connector is HDMI. Trust the connector type.
+	 */
+	if (connector->display_info.is_hdmi ||
+	    (connector->edid_overridden &&
+	     (connector->connector_type == DRM_MODE_CONNECTOR_HDMIA ||
+	      connector->connector_type == DRM_MODE_CONNECTOR_HDMIB)))
 		init_params.sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
 
 	aconnector->drm_edid = drm_edid;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 5c74f19fc33a..9f4465682088 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -223,7 +223,14 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 				  edid_caps->display_name,
 				  AUDIO_INFO_DISPLAY_NAME_SIZE_IN_CHARS);
 
-	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
+	/*
+	 * If an EDID override is active, it may not advertise HDMI capability
+	 * even though the physical connector is HDMI. Trust the connector type.
+	 */
+	edid_caps->edid_hdmi = connector->display_info.is_hdmi ||
+		(connector->edid_overridden &&
+		 (connector->connector_type == DRM_MODE_CONNECTOR_HDMIA ||
+		  connector->connector_type == DRM_MODE_CONNECTOR_HDMIB));
 
 	if (edid_caps->edid_hdmi) {
 		edid_caps->qs_bit = connector->display_info.rgb_quant_range_selectable;
-- 
2.56.0

