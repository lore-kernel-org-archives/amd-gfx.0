Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24CFE7BDA2
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA7610E466;
	Tue, 17 Feb 2026 08:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CGiZ7jEr";
	dkim-atps=neutral
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ACAD10E094
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 16:45:38 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id
 a640c23a62f3a-b8fa19e6186so64120466b.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 08:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771260337; x=1771865137; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kS7PzC/JbAdPihFpg3ya83BJ8JEcjwBMKcTZhCYl4bU=;
 b=CGiZ7jErrAk8jaDShm0zg/1TuiOrGZio1ZUr26Qd+mO5QmTCZDY4H32R9PCLZgsl/T
 qe2TPFB+3PJOkiMmK2SEjxEDJcqeQIyabQKYH9JtEA+BV0+ToQ1hZ7zdxF5UVVmY7T0p
 oeak17Q5+yDySg4a8OU7CAK9Cmz2z6Dbiicd9GZ8nMwm4Xbff854ZZ5sAwJsi4d4fb+v
 jt0G32rQgnGUrkvAQb8CBejcXvH7RVghJJZ5QcH+sr6ZG3zab8CfrvWHnMPpcj5gI11d
 lLd6D7d9Gw23dE06BRNJezir9HMXyluN5X1R0CIMYgyqqNRcBxfGAl0ExEg+zNzR5zF8
 BVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260337; x=1771865137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kS7PzC/JbAdPihFpg3ya83BJ8JEcjwBMKcTZhCYl4bU=;
 b=hwCw+fx8RQlVbmMiXItSBZjoOI4mNeK9KU0l+ZGadQkWk/sgNc3jlZRl3XVGO7ugQ6
 wzF+5rEXLItGY4QcfvBwzq1XbE2rqTSOJAKRd35d1+HR+zzEHa2g4cUHwwrDhJPji5ZI
 1xuYDz/bkhRMRLAQ+RPNFGtR6LseGg3TJemk6IG3V4PbazalMshP/tclOcPwMvvyo/og
 wEQ/eFqYwhb+zgy370mr54mEFWBCZziHnkjQVV5ibGqEHTMA7lp8ujukkFFAVJ8N0CMZ
 o+QbjEq+8Ksj9pwAUpy6lzdtAJesVnCTwhaEJDV3HbaRZysQi2qr+KqeY3hp+SpyYvx3
 ZAYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKqhNoCLbvpqiWMVafpZQPIfON2BXXzch8t8YgYUfwFpiwwl1WVT6yaRFEreHv70ULgwNG2leM@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBAztF+uvheGHldaVnFfThMyaoEmqPr/ACml5x627KmJuLcRCC
 l4NVKxSlHg97G8nhiMRIN46vR2BkIqEtOnwxbslm1oubYp3NMPZ9ScYo
X-Gm-Gg: AZuq6aI6acSqukh6lMSAgHLo7zGNZxj2xHDzR4ScudGv+fgKHM/SJRM1aLumL4IegEF
 9SXQc6o+S5eDUMK73Lg24MtB/+7+91hGj2/Onk+7ZCAXjI9EeJI6ugVxbSrjw/dz2q+YFhejPfE
 XDPXEV4uy7LKIJlzp4WJyYSeJsFe5VOeifgJj0hyYQyIjae51XgrmYxdjztImbfI+OoUP6cVx2k
 Z5FZMQe0+QvO7yoo9c0ru8o0P9cOlgJHuAOoAbZc6COkMm3krdSDUut7DwpXjgG83pmsHzHZm+1
 R/6ozQuUWNMj7wkzqsv2MH+HlHo6bi40nf5Pt6fiBWIBp3mNCdrJGcswwoaEQ/gJ1g3HaBmavfi
 Yn6yndmey5WsOYBoxMG79UHQCx25z8QlAEKcB7jOX3q6LmqC1CRK68F1XjfPmi+ScM7pB8eBVwa
 xP3yVS73OGTgRbTmc/fkODUMdmTgSLWZqjgji9JqQtQIkLujDSFCMnGdJYI56h2Pn6A5bHyFl8Q
 yrk
X-Received: by 2002:a17:907:2686:b0:b8e:fd74:f6b7 with SMTP id
 a640c23a62f3a-b8facdf05a6mr322183666b.5.1771260336510; 
 Mon, 16 Feb 2026 08:45:36 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d185sm264683866b.14.2026.02.16.08.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:45:36 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v4 13/27] drm/amd/display: Rename PCON adaptive sync types
Date: Mon, 16 Feb 2026 17:45:02 +0100
Message-ID: <20260216164516.36803-14-tomasz.pakula.oficjalny@gmail.com>
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
PCONs support sending out HDMI VRR infopackets on their own and this
makes this types not specific to FreeSync

[How]
Make the name more generic for the upcoming HDMI VRR over PCON
implementation

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Tested-by: Bernhard Berger <bernhard.berger@gmail.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      |  5 +++--
 .../gpu/drm/amd/display/modules/inc/mod_info_packet.h  | 10 +++++-----
 .../drm/amd/display/modules/info_packet/info_packet.c  |  4 ++--
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b6079a1ce2ac..e511eb5a1f7f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9629,7 +9629,8 @@ static void update_freesync_state_on_stream(
 
 	aconn = (struct amdgpu_dm_connector *)new_stream->dm_stream_context;
 
-	if (aconn && (aconn->as_type == FREESYNC_TYPE_PCON_IN_WHITELIST || aconn->vsdb_info.replay_mode)) {
+	if (aconn && (aconn->as_type == ADAPTIVE_SYNC_TYPE_PCON_ALLOWED ||
+		      aconn->vsdb_info.replay_mode)) {
 		pack_sdp_v1_3 = aconn->pack_sdp_v1_3;
 
 		if (aconn->vsdb_info.amd_vsdb_version == 1)
@@ -13398,7 +13399,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 
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
2.53.0

