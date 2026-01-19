Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D349CA6012
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 08:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D98C710E3B9;
	Mon, 19 Jan 2026 08:18:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VQzp6NrZ";
	dkim-atps=neutral
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AB4210E303
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 01:12:04 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id
 a640c23a62f3a-b8773fcff60so77526466b.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 17:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768785123; x=1769389923; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6HUGS6jvxmoIyvr+IqDq6ssoVfWMzXazHZIMF4nNX64=;
 b=VQzp6NrZYaIj/jPFy1O2356rAR4WJEHgRTLKKT4dZ8FZ4vqS3wCT0Lt4AGhJGPPNZM
 7tFs/Xu+lrT5o1Hg/vA+qCxJPMGBL/1X234d0PqQHdDF7ZH6Z4xBniPxBqAdhJCIgQPg
 Ay4J3juZqKXZibEgznj3w7T+IHCKRPZW1arrj2rvwNfvIAdoJSpJwD++Q/xBH9oyTy4M
 jPpCZPIKPA9wB7wP/zo4NsMNGfb2/n74lptLyeQqGBovdoZntPy+Awsj7YUR05yRYCGg
 kcK3YuVvIkcr4ueo4gKpuD6+kyGArvQD+PZWLjrUUGq/Rv1Xa8NhpJr42WGolC2Se9ks
 bLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768785123; x=1769389923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6HUGS6jvxmoIyvr+IqDq6ssoVfWMzXazHZIMF4nNX64=;
 b=nCTBtiODtQ/EqTX1gQfQzLmFrW93rrrp8Pb7BkGXPtheycVAJQY9NV6CP8L609t9CI
 X8myjVm98esqH9RKOh1hw78x6DnoqCUDnM1YxWKNCWuCdF3Z8ULWM5qghU9TnAuKJzWV
 vb68Wxf/o+InDuXEO7ApRkXAIDoRHQ7DXR+fUEGv5A0MJgou5f6W6pvboRML7U7Y/EdU
 g4R1D0K2gapekVyqRWz8dG/5eGtRONOWAArvoXUh9qwUHoRji3Dh/hkYJpSQvo+THaCw
 aQvgG0ICoTeKSiDZGQbyd/V3aJ9HViWaFNpdTKeX9hP4hZlHHNBgpkope9kazU4LXRwO
 ya+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmDFdfNGSliJBFHoecJaBQCNXDpjTaMquPtn5g0CLMMe9iIyX2rEyQhnDAgjzFbZ0KFI40wFcY@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2M2Px5lnW5K4UvB7e1npHmRMP9QLjDXY5CCqKPS5lsLqk/Aj8
 U4TpyDvAS8cTXPw+qAG37xT6gWL7w5pSX3J3KHmKzmOnNgZCr2J347Xh
X-Gm-Gg: AY/fxX7Gss4lxUEv4ClGLmN7wi0nn4mEmoyjXPHbizuhXWp8Nl2D7JadxE6ABO5bt4e
 l7GAU6ia1M3WFJYGoQeAdA7kp2rFc1nfDEar9wOSajtvPjL5Y6X8qKs9gDy9jsTcqZ0QoG4E221
 HJdLlYCSyd0R8iPTgNILPh9ncv/D47EtGAj9fhma4q/KuMavRj8YmxXIusB+Q9tQszmXQebpYWt
 Q2qG/7gXE5wjej1tLoVcgZt+32qern80a8CpubFzBifp7CCORf9KOCHoay5dCUKRwMKijO+jzKj
 b9pH0e4R23mIaIddIDAI3C2Zgalnf2V7bwfJNYrRxKmXPOfqdWBbS6aB/dTVgvzfaR5SsojZLAF
 6OytPk2zfD1zb7mrKrYhaTu6CAjIjizwm8MlDs3f9KIFVZa5TpAymaAyiUaVkKlFWj9V38JnnU6
 xs1fwk2Qy7vks8xIAhGpVbGdyHsYq745FFOP40eX/ow0JBsoyatdcCw/AvXRGm80agtns0E2cOX
 WQ=
X-Received: by 2002:a05:6402:3513:b0:64d:46f:331 with SMTP id
 4fb4d7f45d1cf-65452ddd6edmr4683637a12.8.1768785122665; 
 Sun, 18 Jan 2026 17:12:02 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654535c4912sm8989806a12.30.2026.01.18.17.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 17:12:02 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com
Subject: [PATCH 09/17] drm/amd/display: Rename PCON adaptive sync types
Date: Mon, 19 Jan 2026 02:11:38 +0100
Message-ID: <20260119011146.62302-10-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119011146.62302-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260119011146.62302-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Jan 2026 08:18:28 +0000
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
PCONs support sending out HDMI VRR infopackets on their own and this
makes this types not specific to FreeSync

[How]
Make the name more generic for the upcoming HDMI VRR over PCON
implementation

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Tested-by: Bernhard Berger <bernhard.berger@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      |  5 +++--
 .../gpu/drm/amd/display/modules/inc/mod_info_packet.h  | 10 +++++-----
 .../drm/amd/display/modules/info_packet/info_packet.c  |  4 ++--
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 859e34235769..b7deff137df4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9597,7 +9597,8 @@ static void update_freesync_state_on_stream(
 
 	aconn = (struct amdgpu_dm_connector *)new_stream->dm_stream_context;
 
-	if (aconn && (aconn->as_type == FREESYNC_TYPE_PCON_IN_WHITELIST || aconn->vsdb_info.replay_mode)) {
+	if (aconn && (aconn->as_type == ADAPTIVE_SYNC_TYPE_PCON_ALLOWED ||
+		      aconn->vsdb_info.replay_mode)) {
 		pack_sdp_v1_3 = aconn->pack_sdp_v1_3;
 
 		if (aconn->vsdb_info.amd_vsdb_version == 1)
@@ -13324,7 +13325,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 
 	/* DP -> HDMI PCON */
 	} else if (pcon_allowed && vsdb_freesync) {
-		amdgpu_dm_connector->as_type = FREESYNC_TYPE_PCON_IN_WHITELIST;
+		amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_PCON_ALLOWED;
 		amdgpu_dm_connector->pack_sdp_v1_3 = true;
 		amdgpu_dm_connector->vsdb_info = vsdb_info;
 
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
index ddd64b7e4c04..5de8a6918e6a 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
@@ -48,11 +48,11 @@ void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
 		struct dc_info_packet *info_packet);
 
 enum adaptive_sync_type {
-	ADAPTIVE_SYNC_TYPE_NONE                  = 0,
-	ADAPTIVE_SYNC_TYPE_DP                    = 1,
-	FREESYNC_TYPE_PCON_IN_WHITELIST          = 2,
-	FREESYNC_TYPE_PCON_NOT_IN_WHITELIST      = 3,
-	ADAPTIVE_SYNC_TYPE_EDP                   = 4,
+	ADAPTIVE_SYNC_TYPE_NONE             = 0,
+	ADAPTIVE_SYNC_TYPE_DP               = 1,
+	ADAPTIVE_SYNC_TYPE_PCON_ALLOWED     = 2,
+	ADAPTIVE_SYNC_TYPE_PCON_NOT_ALLOWED = 3,
+	ADAPTIVE_SYNC_TYPE_EDP              = 4,
 };
 
 enum adaptive_sync_sdp_version {
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 00473c6284d5..294f56d20062 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -590,7 +590,7 @@ void mod_build_adaptive_sync_infopacket(const struct dc_stream_state *stream,
 		if (stream != NULL)
 			mod_build_adaptive_sync_infopacket_v2(stream, param, info_packet);
 		break;
-	case FREESYNC_TYPE_PCON_IN_WHITELIST:
+	case ADAPTIVE_SYNC_TYPE_PCON_ALLOWED:
 	case ADAPTIVE_SYNC_TYPE_EDP:
 		if (stream && stream->link->replay_settings.config.replay_supported &&
 			stream->link->replay_settings.config.replay_version == DC_VESA_PANEL_REPLAY)
@@ -599,7 +599,7 @@ void mod_build_adaptive_sync_infopacket(const struct dc_stream_state *stream,
 			mod_build_adaptive_sync_infopacket_v1(info_packet);
 		break;
 	case ADAPTIVE_SYNC_TYPE_NONE:
-	case FREESYNC_TYPE_PCON_NOT_IN_WHITELIST:
+	case ADAPTIVE_SYNC_TYPE_PCON_NOT_ALLOWED:
 	default:
 		break;
 	}
-- 
2.52.0

