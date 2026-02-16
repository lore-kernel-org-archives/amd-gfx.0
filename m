Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5422EE63F2C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D6F510E462;
	Tue, 17 Feb 2026 08:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HhZU/Y2R";
	dkim-atps=neutral
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFBE910E3CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 16:45:48 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id
 a640c23a62f3a-b8f8324d2eeso40830366b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 08:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771260347; x=1771865147; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=61QqaYqAJ4tBG5OXB271IehCG1TZaMd4977PuSXDslQ=;
 b=HhZU/Y2RaAFYxgumqRTaIbehPgO8Y45251ow7V9TmvcxwbpKQxJr/R8HvlKo3QwCDj
 qd89euCVsAbE2AsoNFQQCBUjdWU/id4DnPJQHB/DOSf5WUhkoeEKWisvpUfN/rIUcANq
 cIydtzCyYrS3o+HlK4hqeJwdRvW7V9Zn5d6DnbAFEqSkDbOFdD0MN20puuIkS3xrr/4Q
 VCWHYfAdEmLCLClPgLlTpPTwxMNq4duZCZx7XVE5ApCIjQeM5rC3oJCaP6/zqy4EKeFr
 A3ff8ve8hTIeepz50nuHV3IsHZYy26Kki//gONLlaY4nSSH5BVHtQk6cSXtq1AFxPTUp
 sKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260347; x=1771865147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=61QqaYqAJ4tBG5OXB271IehCG1TZaMd4977PuSXDslQ=;
 b=E3Ie31xPHdylCqa+BZnXwOSQi9gkgSXZ79ftVATyp5WTjcxVAWk3aWKm6dCkU8zn55
 pqUDua+L6lT/aawu9wYR16jaYl4zbtOPDkN8ET8sEzfaf0fE18BXaUc9LQ7b3nuBqTtY
 5u/TbNKlS+r/B+/VciCmWcVyRxyQ3YiiDL8b+g2kl9m5ek/d0qk08tqx7kt/+rgHbTo7
 3BoIEoDTSAFd809vebNPvJ3YyAJbDmknqH7c57nE2sWyI0SNvKqdFEn1eAbeolmhgFYY
 6x41pKpfKKEtezo/JIo9dgyF0lGmMtM4m/0wCDTjeUgPK5m/HzkgCTY9DyrN9ZJxgm6J
 9lsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoDSSn921gjDXHfujQiu8E+tvPkYzoTp7v8DsGfQY5i259iqqemN0pIplnbPpzHUD9WLEeuM9g@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwnsXAUL9qWYeg0S7c3Kf1S5EN1+xYnJXMdUMyoqzYZwUvQwSmT
 yztyBCrK+v964wj5O2pyvB5KX1CKGvlg+UvNIo8ayzSzrfOsvQmB5LdV
X-Gm-Gg: AZuq6aJOXRw9unx1/AVb4mIitAMu08uxJrEEbdg1S0D+RPZT1ZEcOW8jeQWx80To08a
 qqiGk0EvLB5o/9GOzcsNxanhEBnhP/RNFKPkEXJ8yGG22hPus2ZbccUB20ea9W5ZAK6azp4hQM6
 j109dYTDmRvfyAOyYqzNahzOP+eKUq543ntzXqIhiRZmx8w/+qcvwHFIWYCXLxLKnX4h0V9sjFP
 4xQA0DZCUagpDgCoShSE3HvIZQj1/DYYz9IJUOODMYBk8fmckko6p4Inf+ixgxNhxF8mgMp+Aeb
 Zkfyz27qtRXJTgPqHNta3f4Ek9TnpME2BnGMxttXADHQMvTFoTUfjS+jfXmVCujOXF0IQXncT85
 9UGcyDLPv4hpDHNbRhr0x1/kdzfg6ok19sTCtmw0dTkJqY+IoBIINVrqmyJS11Z17oSSso+/pns
 V5KOo0N/aJgj68LsNfkU7k8vBoU3dIITMoqNHWQAAT5iXvWNhtvDKYaCXdP/3GixrDaiFGKsT9c
 vZw
X-Received: by 2002:a17:907:3e88:b0:b73:59b0:34c6 with SMTP id
 a640c23a62f3a-b8face510e0mr348090166b.4.1771260347159; 
 Mon, 16 Feb 2026 08:45:47 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d185sm264683866b.14.2026.02.16.08.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:45:46 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v4 21/27] drm/amd/display: Enable HDMI VRR
Date: Mon, 16 Feb 2026 17:45:10 +0100
Message-ID: <20260216164516.36803-22-tomasz.pakula.oficjalny@gmail.com>
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
We'd like to expose VRR functionality to end user if HDMI sink is
advertising it's support.

[How]
VTEM info frame is used to signal HDMI sink that VRR is active.
Use VTEM info packet as vrr_infopacket

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++++++++++++---
 .../drm/amd/display/modules/freesync/freesync.c   |  4 ++++
 .../drm/amd/display/modules/inc/mod_info_packet.h |  1 +
 .../amd/display/modules/info_packet/info_packet.c |  1 +
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 288437ada2a5..6a2806cc800a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9629,7 +9629,10 @@ static void update_freesync_state_on_stream(
 
 	aconn = (struct amdgpu_dm_connector *)new_stream->dm_stream_context;
 
-	if (aconn && (aconn->as_type == ADAPTIVE_SYNC_TYPE_PCON_ALLOWED ||
+	if (aconn && aconn->as_type == ADAPTIVE_SYNC_TYPE_HDMI)
+		packet_type = PACKET_TYPE_VTEM;
+
+	else if (aconn && (aconn->as_type == ADAPTIVE_SYNC_TYPE_PCON_ALLOWED ||
 		      aconn->vsdb_info.replay_mode)) {
 		pack_sdp_v1_3 = aconn->pack_sdp_v1_3;
 
@@ -13419,8 +13422,14 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		}
 
 	/* HDMI */
-	} else if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A && vsdb_info.freesync_supported) {
-		monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
+	} else if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {
+		/* Prefer HDMI VRR */
+		if (hdmi_vrr.supported) {
+			amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_HDMI;
+			monitor_range_from_hdmi(&connector->display_info, &vsdb_info);
+		} else if (vsdb_info.freesync_supported)
+			monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
+
 		freesync_capable = copy_range_to_amdgpu_connector(connector);
 
 	/* DP -> HDMI PCON */
diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 1aae46d703ba..db197cf048e1 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -27,6 +27,7 @@
 #include "dc.h"
 #include "mod_freesync.h"
 #include "core_types.h"
+#include "mod_info_packet.h"
 
 #define MOD_FREESYNC_MAX_CONCURRENT_STREAMS  32
 
@@ -955,6 +956,9 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
 		return;
 
 	switch (packet_type) {
+	case PACKET_TYPE_VTEM:
+		mod_build_vtem_infopacket(stream, vrr, infopacket);
+		break;
 	case PACKET_TYPE_FS_V3:
 		build_vrr_infopacket_v3(stream->signal, vrr, app_tf, infopacket, stream->freesync_on_desktop);
 		break;
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
index 027113ec147d..03d37b6f1cd0 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
@@ -59,6 +59,7 @@ enum adaptive_sync_type {
 	ADAPTIVE_SYNC_TYPE_PCON_ALLOWED     = 2,
 	ADAPTIVE_SYNC_TYPE_PCON_NOT_ALLOWED = 3,
 	ADAPTIVE_SYNC_TYPE_EDP              = 4,
+	ADAPTIVE_SYNC_TYPE_HDMI             = 5,
 };
 
 enum adaptive_sync_sdp_version {
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 96c84f70ed44..7106b409ae54 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -699,6 +699,7 @@ void mod_build_adaptive_sync_infopacket(const struct dc_stream_state *stream,
 		break;
 	case ADAPTIVE_SYNC_TYPE_NONE:
 	case ADAPTIVE_SYNC_TYPE_PCON_NOT_ALLOWED:
+	case ADAPTIVE_SYNC_TYPE_HDMI:
 	default:
 		break;
 	}
-- 
2.53.0

