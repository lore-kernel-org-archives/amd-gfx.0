Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C4DE6815A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 903EB10E4A0;
	Tue, 17 Feb 2026 08:05:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JLYtfb7V";
	dkim-atps=neutral
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9A7F10E3C8
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 16:45:40 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id
 a640c23a62f3a-b8de2b5a122so59441866b.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 08:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771260339; x=1771865139; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9OKWWD4fVuRFCLZG1mlotGGCycPT2eMUJpgDA/iY0b8=;
 b=JLYtfb7VIVHzy2k4hKHTV1PTnNZfKbvDkrRTjHupKOJ5IM00ZDyQoYxMIUV42ir16R
 88zYkAVR5AIVgd7u2r4wD+yXk/YYHL4i4+2+UpUp4jmQuvJb93G+hBdWyjQXyQEzbrHH
 dp6Seu0OP3FLG4acfM5JD9u4riFLnL5MZtJpF9jw5HB8nhFQN2u9eTlsoyCBvNT3e6cY
 T66DY/52YrdE6vIMxBV2nBkgYiw7L/n65hlOsCEPGXxEU+r2ioJT7L6IGleSFyFXNvoa
 CpVYGa/1077i0NUpaqhk7yHIuI045T7zEOsvIL6iNMOD8N1+cIx7zeIXVblMDEPrYPaK
 hlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260339; x=1771865139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9OKWWD4fVuRFCLZG1mlotGGCycPT2eMUJpgDA/iY0b8=;
 b=PN3oNbT2NKbbW9xKB/6XvB7Rf6hzLpL0+ermiMFs0RGOHsOKQh3sHKfsHMSYAUjT+I
 6xpLxtt+5EbpdTIuoV4i/trIOgRTKqtRZ/XYFeslKafd8Xip4pp4AL4u2PXN3n6yfyLd
 AbIdIkqPptN0pZvVBwysXYdUQ0xOaC6Z3uMoVzR4ANej78DLkaYupaze/MumcZGxm1FR
 ldBuj01OcFSZvkdrq0lO/2Wb0xa9uD6rF8M6eNUXMMqFGiFveMTL84KnPu+ru4Heeu/e
 3jAmk5bfC8KxK0lM73jz+sfXjGQ0rWLb75AJpfTDa3u2GMBOYqktciElLVLkqKea1E7P
 SJ4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKLn5TlkeWDz3II5nEZfs81ZAulbyUp4drVkZZ5ckCYmnmHkyIrfIgkMPFfGxwmPgGO059K4eh@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywn1FrZfaR+GrBVDTwBS9tyirXITCTkWiTn5KzdeMHOSmRhhaEd
 38VlJzGLY58sPh+smnLx9ik+1EFEdX7rcNqeUubL2Dz1+tV+6//dPeCx
X-Gm-Gg: AZuq6aKdpyN3cXY/OSduCrVXlY2Dd6SOekdQTi92qa+INFocYALdvHODJzil9ohpf7C
 vTBWM4GJOwWu29uQc7mpJntvOAlpEoMr7rz9wqjoYxnA/yBAq5JrALjivFFY62FIUZ4k1Wm/LA5
 93nCIZ+gvi3HOat5liCn2rKP/eBLBs25Ed21+YebpuzIOCInSX+IBkfzrVX2gtUWiqpOlFAJZaI
 6D/cMOSNJ7xTGxvp+aLwaH0qnz3phZU9rRyRAvaoPi9Vt06aZX4eeBoDy/3NtTzn8CJ/8tisGrF
 1UcZ9A4/1sCLm73BATI8+GRYeZqMNWgTl3URDlVqnC+k8wjewZCqS+6ivgRBNjQhpcRTT67u8t8
 M3DJNIUEpmD9xOl1oM383Mf+ToKcQqjRw1njBreLXIA22RtSXIoh/cxbQkxlJawcxibf3jLrgVL
 fM6KuQvChOHFbJUNf5ZFxkrEzFaFnWZTHgze5lYp9gomr+xZslexqZ1d5E+D8tS2z0y/pYlKqh4
 h7f
X-Received: by 2002:a17:907:3e88:b0:b87:2099:9f6b with SMTP id
 a640c23a62f3a-b8face2491bmr364262166b.3.1771260339213; 
 Mon, 16 Feb 2026 08:45:39 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d185sm264683866b.14.2026.02.16.08.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:45:38 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v4 15/27] drm/amd/display: Support HDMI VRRmax=0
Date: Mon, 16 Feb 2026 17:45:04 +0100
Message-ID: <20260216164516.36803-16-tomasz.pakula.oficjalny@gmail.com>
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

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +++++++++++++++----
 .../amd/display/modules/inc/mod_info_packet.h |  2 ++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 931493433439..991e2262ecbc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13259,14 +13259,27 @@ static void monitor_range_from_vsdb(struct drm_display_info *display,
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
@@ -13413,8 +13426,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
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
2.53.0

