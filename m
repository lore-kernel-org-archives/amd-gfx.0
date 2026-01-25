Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE4BC88E77
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 08:09:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADF7210E3E3;
	Mon, 26 Jan 2026 08:09:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DuWn2/nL";
	dkim-atps=neutral
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF08710E372
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 18:39:30 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id
 4fb4d7f45d1cf-6505d1420daso572306a12.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 10:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769366369; x=1769971169; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRzbLCxrVkWp1Gv9W66KOOv/WVW000APHSi4XKPpJIk=;
 b=DuWn2/nLQ6y8Dulz0uRIFgK6HegIChVagRFKGy0+2L19KbN3V+ndZusPNKXoyVj3J7
 qzlOMspHXNO6c3gFwN1zGB031sXNsIOnYvblnsxyKSPv/yz46/77ap/evtzXa1z7q9bi
 irhXj0kAAv0oX+Ur/X1h6JSkKO5p1E6sHjiCFsXI7CIEQD6ffFtR7HpJ6i7gw/DFkyXf
 Rff7StDBk17/FveDHV/SeZtPoGL17gwq/vvg+K1/A8EK1nfh8xT0jkBYFnON0x7AN3TQ
 oZH9TySJR6tPn6HZM1wIStjWEjkqzhycutCywj9ABol/b0k2VTWLSCwMlvA02KFb/fCt
 3Qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769366369; x=1769971169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IRzbLCxrVkWp1Gv9W66KOOv/WVW000APHSi4XKPpJIk=;
 b=VueoT98algcN9kVB2beSRzYA0UhYxfdMeJ0jMvbT1o+RPFEiTYEI4o5l2yS4AWxriU
 eUig+fFQt13qFBHlFwZpMTdD3h2r1l5wRqL3LEjCiTpswGibGzfi38MnuV/Di6J9WLHP
 KJj9zAkvNJKVEvmGvXHE07hlrxkqvuPGdFkr8MVXFMoUlUtyC2a7/096+K5HU84gYMZ/
 4aZ7DE8VFF1MVEtfV/9ply0Vhe2607lSL5luz0yesKGj5a/wTwP+4zo9rrHEvH4Lr/er
 AjmChgHz7KopI4rw5HtGoSVLGXdAngwXcbs+kOTtxjyvZi49CJS4GE8tXAkz6qDFBHgC
 HAyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBWhD69tOa1u8mE0Kp7C5HKU48hRPfehw9gj6M1yeKVfgOsbNXtpx94zpMRJOZYTwnXuV/2Ae3@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8su0WjxWB2VlnD6vgoUHnh+aau6TBqT9bn04Z3yYNCCslmOP8
 ChqTatISd03EYidHF4/1u9rE7cKgjovJz1R97LFhbybanWs5WFBn2MY1
X-Gm-Gg: AZuq6aKQxie9xhlQ8ZCSwP4qgM+Qr5Fjmpci5aKqIaYYpuivmun7sv5OV1gIW32o6nN
 AMsnE93Exul+Zr72EplyBLiPI0Sw1ltEq4BjPJxRydmO5XBiHJGR5WM8Kpk0Tml/DdGiAJy9/vg
 vCc1mVsuUKtqEJ908lkavzZ6onon1RHLPS4LsMhB7EPo6VdrYVHFQrm2E4zxgdzj/9tPMQKJkIP
 EA1yyJ8hq0ZcjeoG75HgOGLAGh2t1l3ZTTx4xxilOxoVvqFqQ637ebTaSgpTP9xSFh5hrLeJ5R1
 GcRj7XsULgpDrWXhZ5Y0vpq3YCL9Vqu8lBEpjDahQNds2e/5gH4YGAI1Q1m2i3iilBFWVY5S9BQ
 xslsUMIvM49jmiRL7Ruamo+SZqZ6jq1EBjBOWx6KeE9yMTK8/fX2W9Lo219CMehQSu4ReJM6/w4
 CIOSQTSYT7nC/wCTwqi7nvsEuon99WkgRrv+XXkDfS7jJbvD1WFpaN+jicWa4LQ7hP
X-Received: by 2002:a17:907:787:b0:b8a:f2d7:9942 with SMTP id
 a640c23a62f3a-b8d3fce31cdmr73331066b.3.1769366369311; 
 Sun, 25 Jan 2026 10:39:29 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b885b3dad3asm499133766b.12.2026.01.25.10.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 10:39:29 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v2 09/19] drm/amd/display: Rename PCON adaptive sync types
Date: Sun, 25 Jan 2026 19:39:04 +0100
Message-ID: <20260125183914.459228-10-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260125183914.459228-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260125183914.459228-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Jan 2026 08:09:08 +0000
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
index 7673143ba651..2f856833806e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9599,7 +9599,8 @@ static void update_freesync_state_on_stream(
 
 	aconn = (struct amdgpu_dm_connector *)new_stream->dm_stream_context;
 
-	if (aconn && (aconn->as_type == FREESYNC_TYPE_PCON_IN_WHITELIST || aconn->vsdb_info.replay_mode)) {
+	if (aconn && (aconn->as_type == ADAPTIVE_SYNC_TYPE_PCON_ALLOWED ||
+		      aconn->vsdb_info.replay_mode)) {
 		pack_sdp_v1_3 = aconn->pack_sdp_v1_3;
 
 		if (aconn->vsdb_info.amd_vsdb_version == 1)
@@ -13341,7 +13342,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 
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

