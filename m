Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14861E83EEF
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 08:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8587410E4CE;
	Wed,  4 Feb 2026 08:10:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aYHcA+iJ";
	dkim-atps=neutral
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 397D110E759
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 18:56:44 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id
 a640c23a62f3a-b8dd0168b90so64198966b.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Feb 2026 10:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770145003; x=1770749803; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YdVCQxWwUXKIDsVOML24aA9ZG1ZMvoKKkZER9vT4/Og=;
 b=aYHcA+iJeF3sh7oWCAzA1HlDQR81amFbVT0+Zvuxtfp9bko/vMVs+0rieQcm+vkHRf
 s7iuAVdbPGeo9DLSpA/KfsNQrhAhbdW1IyEe0SctXaIEgu79aphq88wyPkjSbLC2dMli
 7lmVZf74J8D3KPlV0vsKE5hYHYzCM3zatIUa/3MlA7SQqQXoen7n10zqE5U4jmISdLHs
 uIlGvWNPbsbZFgF0ymiiNPfXst5/tM5xoYdPDWpsB/o8Zd38/Rmuud7uPke9euR+BEtF
 vnUic8kNNIrmJLkVBtAPwtailf3lCmVZPRch5nlg2PbN0Ip/KN4xw5lUCjG1RlKGzvIl
 SPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770145003; x=1770749803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YdVCQxWwUXKIDsVOML24aA9ZG1ZMvoKKkZER9vT4/Og=;
 b=agaof536yw9gSzrhXXn87qYsFmtS38t8WygfnxB/hVjoeEQqI8qEIe/VBpIqeZ/93g
 kYsks3u+1+Ua8LBvuVS1/sowxVomwJvKMEsott7Aofn/u7K9HxfeW3cd6+d9MvXSs/Kn
 TCNS5qiATlxV2pBoftjmTq941GE0r0qvmXMfgWEW8Fo2oufNtJmwOE4fRom0Rmq6mEbP
 tRJXTrCoT3CyPjZqyR3uRpQKzIwCPfwMwUvDBusB4XO4CR4N++RNO5Z3zQvfTwG1VGC9
 3wCdaj4GVJbfTKqILTPkw2s8Cg0yxt1x4gtjEA8KVvmGdSghoLW0yeExwNE6pamrCEm8
 fWgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiGUgF+WmRDfEcstTn13gDdYjd13S9BbQpi7KHuKmN896jURtOwO4ZqEF8pwXdTFUNN/hqNcZ9@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5XjDM7FojU3Q27jAmgse5nFswQEs2g9Oof18Y0Ym/AEZqgoRv
 cjkmG1MCmzN0j36G8xxLwUrtq+2PTf5wNsj+nLFc9RV7ah2FOIy3CTRF
X-Gm-Gg: AZuq6aLQhaGU8wiJdMkyFEt5i8Uh83zDxYC1Z0n69fyMnMtNLBm235bO/ZMOGtbBi5G
 F/gSvsT3f/wVO8xPd/BEQ6ebiTyBE4yCunQhxaIBwKYgcoL5Zft4WWsJPKaLYtDEqNh3boD2mmv
 MTVv1gfCDli1POX5N0NvYq0lUCC33EZTu/XY9+fVf1GkYIxPqhiAurYb4aiBnIdWvEzS1QGtqeE
 TCVnpy8beljhU+KHLiqkWEM6m9ug4bxg1FfNM/osN3h06WV6sBkGYzEz893GWtN/ix5MrGkxE4y
 KOeGo9Qb9b1XOXfK9rL9InAgLYvwWDpGWS4nFch7aa81vsXrcjAM/1z7ur1rM3dH+l4+F1synuz
 +Gb43Esnr725EgxOwZiI9JMDrwHrQ2BaCcGxXUr77jdIvhMIj2usiPW6Pqk31wLJtH3qcx2gRh8
 FhLBE9GgUjUnHuVGUzjZCc7bQBN+oxJU5Fmz+8UhjcL7eNXXoS3sYA/sPk6gOgBEzn
X-Received: by 2002:a17:907:6d27:b0:b88:5095:b740 with SMTP id
 a640c23a62f3a-b8e9f545b58mr17871866b.7.1770145002568; 
 Tue, 03 Feb 2026 10:56:42 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8e9fad97a7sm16715766b.0.2026.02.03.10.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 10:56:42 -0800 (PST)
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
Subject: [PATCH v3 09/19] drm/amd/display: Rename PCON adaptive sync types
Date: Tue,  3 Feb 2026 19:56:16 +0100
Message-ID: <20260203185626.55428-10-tomasz.pakula.oficjalny@gmail.com>
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
index 306c29ff38f0..92e571e687e9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9620,7 +9620,8 @@ static void update_freesync_state_on_stream(
 
 	aconn = (struct amdgpu_dm_connector *)new_stream->dm_stream_context;
 
-	if (aconn && (aconn->as_type == FREESYNC_TYPE_PCON_IN_WHITELIST || aconn->vsdb_info.replay_mode)) {
+	if (aconn && (aconn->as_type == ADAPTIVE_SYNC_TYPE_PCON_ALLOWED ||
+		      aconn->vsdb_info.replay_mode)) {
 		pack_sdp_v1_3 = aconn->pack_sdp_v1_3;
 
 		if (aconn->vsdb_info.amd_vsdb_version == 1)
@@ -13359,7 +13360,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 
 	/* DP -> HDMI PCON */
 	} else if (pcon_allowed && vsdb_info.freesync_supported) {
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

