Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A59C88E64
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 08:09:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67DF210E3CD;
	Mon, 26 Jan 2026 08:09:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ngSo/3/X";
	dkim-atps=neutral
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7486D10E379
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 18:39:42 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id
 a640c23a62f3a-b8719f5a2b5so50780566b.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 10:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769366381; x=1769971181; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hdLeMslJpmP5aqg3skjNgOL1QWmOegbJOT5yvSqo4kw=;
 b=ngSo/3/XqfS8cX9nLV7P7rGuNZtWcvffoP9nHjK5Kk9nxt8RoCRiC3adNFmHi/eVCF
 pI2h33yCPQGuhWvC50tG1R4v6gd5Vw0xarR6bvd/LoO/UnizHllkuAHEsmz/tIJP0wTi
 qpil+3yczYpU9Aw1BqLML2pdKGc7YVoS1wj8p4pkhEJXuSV+k6zlyjvUgI72D+HfhEwl
 z7C+0a99qCoKJ7VrozJJq/vd4fkaIFV/lg7C+2qA+/3CRl0oqFRoUxCeNYhzSwgKpbe+
 aMLcXTfUHTpMHLU8ZJ9IAQviuE++zreRXULdkLmgn2RsfHggY4A37x/iQqVtM6EBeDr/
 0O7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769366381; x=1769971181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hdLeMslJpmP5aqg3skjNgOL1QWmOegbJOT5yvSqo4kw=;
 b=Pp+hzfx8ojQTNaTTMbTsRjS9PtIfqVWDJHrGd4iAL52VBVjR0NrJ8VM2knN/LVobnd
 D71/yBdTgOACG1M2gYOxdGG7DG0eXM27NBMCklehyNIor50OmZcwNpSd+IHdMhwXlSc5
 //wJOdP6UG36owHQKdI67JJh54DPbczEQPmBmaOguWpz+QO3WT5cXB2P6dkX1D66GWKi
 5XY/uGWogW5+41ov2heQY8XXqQ9DDDKqJl6UBBmGLA1nkiL8pHqWvge6sfix/aXYfUgv
 nOlmEiVKXtGE/NzFFBiCQTrBY2uLVPZ8CS/v2chrwjhoGaG4ZX5XqJdD0SrZqD9JoXLP
 oUzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQlLoHnpzSO4zeWGSNfAAFLpmkcI4o7MEVQWAPh3zqo6qysvqHPAyZo8AYvC0El/TAvDuWdzNa@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZd0OrJ4zOODZcYcUg79yoRChfKpbBxjFOWJi9xxcGBQscq/cI
 vvOfVhnXMWoFtIi5qDrIHxWjjhz9eFIUBxyuPmABCZamxyTdU4eDF7yI
X-Gm-Gg: AZuq6aKvo3u3jeSTr4S370DEn27U4KQbDitWaZ302znCggXhkHxSdABhPuiUt9IqQKX
 Zsrxz4QDFqArTPpweIkYyeWDxF9Y9RHazh3rVDaOjwR+rqQ/TfQAxxd039yHN8v6FUFyhkhTO6t
 1besfhYl6NDxq1eD50GKAuI+xdJlFB9UuvJ8S1rL4eJy7wV2Fk24Wu7ZsBDdZvQHUKLuuHNcwwH
 CqX9uqGAJIAmNIizL9yYjpB+HZIDEAAHwAIIDRyfdtYpZmsps8CvlIFi7JOc9wbSK4pUHCGqf2Z
 0HEj5CXmpFOEcjlZPbtp5i3JX3Krq0GeZtNiBHai49W3OW+EXUaULmGGRBvLP0Us5ICyiF+2yc5
 /XfcdNxSs/2bDLsYNko2Q4pH6T9im+mc4CaVuV1LjYr8vlZ4f9VsA6DqfyQg2oMDQMThiYhwzwI
 QfE6tP/k51NwOxenRZ6AyZk3KlQ7APIq9GnSiK7xdPgAPJ8UI83/Cq4CAI52bq8z9C
X-Received: by 2002:a17:907:6ea2:b0:b73:99f7:8130 with SMTP id
 a640c23a62f3a-b8d3fbe920fmr79276666b.6.1769366380901; 
 Sun, 25 Jan 2026 10:39:40 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b885b3dad3asm499133766b.12.2026.01.25.10.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 10:39:40 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v2 18/19] drm/amd/display: Enable HDMI VRR
Date: Sun, 25 Jan 2026 19:39:13 +0100
Message-ID: <20260125183914.459228-19-tomasz.pakula.oficjalny@gmail.com>
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
We'd like to expose VRR functionality to end user if HDMI sink is
advertising it's support.

[How]
VTEM info frame is used to signal HDMI sink that VRR is active.
Use VTEM info packet as vrr_infopacket

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 13 +++++++++++--
 .../gpu/drm/amd/display/modules/freesync/freesync.c |  4 ++++
 .../drm/amd/display/modules/inc/mod_info_packet.h   |  1 +
 .../amd/display/modules/info_packet/info_packet.c   |  1 +
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f95e8a739303..7ebac7b610e7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9614,6 +9614,9 @@ static void update_freesync_state_on_stream(
 					&new_stream->adaptive_sync_infopacket);
 	}
 
+	if (aconn && aconn->as_type == ADAPTIVE_SYNC_TYPE_HDMI)
+		packet_type = PACKET_TYPE_VTEM;
+
 	mod_freesync_build_vrr_infopacket(
 		dm->freesync_module,
 		new_stream,
@@ -13364,8 +13367,14 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		}
 
 	/* HDMI */
-	} else if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A && vsdb_freesync) {
-		monitor_range_from_vsdb(connector, &vsdb_info);
+	} else if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {
+		/* Prefer HDMI VRR */
+		if (hdmi_vrr->supported) {
+			amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_HDMI;
+			monitor_range_from_hdmi(connector, valid_vsdb_cea ? &vsdb_info : NULL);
+		} else if (vsdb_freesync)
+			monitor_range_from_vsdb(connector, &vsdb_info);
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
index 07e86b16ef77..ca7c5542620d 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
@@ -60,6 +60,7 @@ enum adaptive_sync_type {
 	ADAPTIVE_SYNC_TYPE_PCON_ALLOWED     = 2,
 	ADAPTIVE_SYNC_TYPE_PCON_NOT_ALLOWED = 3,
 	ADAPTIVE_SYNC_TYPE_EDP              = 4,
+	ADAPTIVE_SYNC_TYPE_HDMI             = 5,
 };
 
 enum adaptive_sync_sdp_version {
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 5e245a053267..38056b2d37b2 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -719,6 +719,7 @@ void mod_build_adaptive_sync_infopacket(const struct dc_stream_state *stream,
 		break;
 	case ADAPTIVE_SYNC_TYPE_NONE:
 	case ADAPTIVE_SYNC_TYPE_PCON_NOT_ALLOWED:
+	case ADAPTIVE_SYNC_TYPE_HDMI:
 	default:
 		break;
 	}
-- 
2.52.0

