Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A646E83EE8
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 08:10:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8C8510E4D7;
	Wed,  4 Feb 2026 08:10:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X6ktJBvG";
	dkim-atps=neutral
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AA1310E75A
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 18:56:47 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id
 a640c23a62f3a-b8e0e812c27so59079766b.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Feb 2026 10:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770145006; x=1770749806; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YveXWB9fxJPi3CW0nlq6uRwljjhlFuvcOGXx+tNrYfY=;
 b=X6ktJBvGDQm1PdBVjoP6DOyv8V9ESNjGxBqR0Cpw1y+wGN+GWuFkyfVTKjV2I3G5oL
 VTG+z1yzM4/ZwtZDuTudoP2/SfQejZVjCUA8LcctSReP/i5pVGKHZEVarHa2t9/erWBv
 JRf+tFGshdTvrcBMB3D5RM0F35ewVLTzFNWukRKBalMHU7Ai5D4K0qths0IsxxHsBeEE
 pJbJk0ZvjFOnGMjJ78/7NUy0oGNkgR6I4y5g84AwvqsOJ4hYyYI1OzPbLUQFJ/zy6syl
 hMGY6ggCgt3ZzxeTbC0xGdT7XZJQwukYa3VycepoBmlgf5vAVcbM//xRtlUlVEeWp1iQ
 cn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770145006; x=1770749806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YveXWB9fxJPi3CW0nlq6uRwljjhlFuvcOGXx+tNrYfY=;
 b=wutXhhMROljU+YUJfzxIfQM3RkRXPGf2aJlLo9gcIz93VF1bOHnDOcJoO8LyLOvJsz
 7ilO/NdF8SmEMCCIxH4djxBORehvsmWDXtPKcMKvE0xg+hwZOKO/6rz1dKxTzmYjIUda
 8kUDGa0XR2XE1hIFTg3yJv4miYiRr0pIpT5dywApbKwyKFscaEX3ZgZiCofQQD/yBkuu
 IHGqbyCTyk13RJ1sZS9FZt8NxKQNLOaPiyK8HbBoeM+5Pgqe6fvjGGjrIKY0UDR7H4bv
 lXi1BiHxasFkhIZ/rcXlSpnIxRHQTxPA1ICP4g54Go+/ha2oqeKcR2X5tVyhio0VbBAj
 3SCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZr1/7Q9sloYx6x9ScRJMtte6Vs6nWoqSD4jLI2jhxtGSCpKM8GXF5WkrJ4PWFuQIcxHwBZ81E@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzeSJTlmg184F067Lgg0VSEYHMR4UObsR8ieVkGYIJkfqUp1ADj
 bPX8+aX47VGlyI7UoH80/m0J382+52uPzJGaqobMJ0Ky078PEE6NiRni
X-Gm-Gg: AZuq6aKQWF47P2xFUfDa5yCYILwu67MzLqG/KKtyr78xAFAUoHp0JqvqmzB1x3OLw9l
 1kzk4X8rsGKXmVSA8Gznaza5MCP4B9maEUDTg0/urmR0KPSBllZTOKmkFgEyrCIaMbrVAzds3Gq
 G3WDWKCEtPF0Drp8g4oqwb6ptCM6bminGzDol0KbFiyXiTEoAVTWVouPGXEU8nqZqIQ8iDPJL9i
 pA2qJ1yK/Nt8cqo6aCrQsRDxu6gw1XC/tNl7vP7H2jiP6jR5msgc4bmZ2gWQA2MMratyPnu7btU
 JzPNEEK1/PvBAEFL2xXac5vuiGA42eKNBA7EXp+mYCvwpPGqktJD5rAglziyRDHgFp6ZQZ9h1Bn
 VUqMUt5YkmXOcWEklPzWLXR9QT8yt1B2mxI/Gw83FjgKDOrupd0AdC4fNX2yVY1UzQHVN2iDmoR
 w31S+QTTcbblk7pYuvURrX/7h9czgoyRmYxgJowUHr0nEx6TkUZTO5C0m2Ceg8Qp5d
X-Received: by 2002:a17:907:3ea8:b0:b71:a627:3d9f with SMTP id
 a640c23a62f3a-b8e9ec91abamr22683566b.0.1770145005819; 
 Tue, 03 Feb 2026 10:56:45 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8e9fad97a7sm16715766b.0.2026.02.03.10.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 10:56:45 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org,
 daniel@fooishbar.org, admin@ptr1337.dev
Subject: [PATCH v3 11/19] drm/amd/display: Support HDMI VRRmax=0
Date: Tue,  3 Feb 2026 19:56:18 +0100
Message-ID: <20260203185626.55428-12-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Feb 2026 08:10:21 +0000
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

[Why]
VRRmax=0 is a valid value and means that the upper bound is guared by
the selected video mode.

[How]
In this context, saved vrr max is the max possible refresh rate ever.
Try getting upper VRR bound from AMD vsdbif it exists or rely on the
limitations of BRR in VTEM info frames.

I found through testing, that TVs seem to reject VTEM when BRR is set
to over 1023 Hz. Use this as the last resort VRRmax. 1023 is the max
value for a 10-bit field as well.

v2:
- Update max BRR value to 1023

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +++++++++++++++----
 .../amd/display/modules/inc/mod_info_packet.h |  2 ++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6fb23d59fcc9..2200161da71b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13232,14 +13232,27 @@ static void monitor_range_from_vsdb(struct drm_display_info *display,
 }
 
 /**
- * Get VRR range from HDMI VRR info in EDID.
+ * Get VRR range from HDMI VRR info in EDID. If VRRmax == 0,
+ * try getting upper bound from AMD vsdb.
  *
  * @conn: drm_connector with HDMI VRR info
+ * @vsdb: AMD vsdb from CAE
  */
-static void monitor_range_from_hdmi(struct drm_display_info *display)
+static void monitor_range_from_hdmi(struct drm_display_info *display,
+				    const struct amdgpu_hdmi_vsdb_info *vsdb)
 {
+	u16 vrr_max = display->hdmi.vrr_cap.vrr_max;
+
+	/* Try getting upper vrr bound from AMD vsdb */
+	if (vrr_max == 0)
+		vrr_max = vsdb->max_refresh_rate_hz;
+
+	/* Use max possible BRR value as a last resort */
+	if (vrr_max == 0)
+		vrr_max = VTEM_BRR_MAX;
+
 	display->monitor_range.min_vfreq = display->hdmi.vrr_cap.vrr_min;
-	display->monitor_range.max_vfreq = display->hdmi.vrr_cap.vrr_max;
+	display->monitor_range.max_vfreq = vrr_max;
 }
 
 /*
@@ -13374,8 +13387,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	/* DP -> HDMI PCON */
 	} else if (pcon_allowed) {
 		/* Prefer HDMI VRR */
-		if (hdmi_vrr.supported && hdmi_vrr.vrr_max > 0)
-			monitor_range_from_hdmi(&connector->display_info);
+		if (hdmi_vrr.supported)
+			monitor_range_from_hdmi(&connector->display_info, &vsdb_info);
 		else if (vsdb_info.freesync_supported) {
 			amdgpu_dm_connector->vsdb_info = vsdb_info;
 			monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
index 5de8a6918e6a..306eb7355c25 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
@@ -33,6 +33,8 @@ struct dc_stream_state;
 struct dc_info_packet;
 struct mod_vrr_params;
 
+#define VTEM_BRR_MAX 1023
+
 void set_vsc_packet_colorimetry_data(
 		const struct dc_stream_state *stream,
 		struct dc_info_packet *info_packet,
-- 
2.52.0

