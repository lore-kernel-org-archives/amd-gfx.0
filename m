Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592F2E68145
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 658E610E49D;
	Tue, 17 Feb 2026 08:05:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vzsmd3j4";
	dkim-atps=neutral
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 750FA10E3D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 16:45:55 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id
 a640c23a62f3a-b8f7f7a1b80so42158966b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 08:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771260354; x=1771865154; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7aD3otBgcxZjv1qvxWCjHurqs+NRqtEYA6dA7W84qVQ=;
 b=Vzsmd3j4X6gj1uoIRX8IE0HPSy3tqW2Th6M23JK7dHbm2M3/1CKZT+H/2IS5UDs6lZ
 +VjB0FW9N+5ASTeH7BJG9DQ8il1a31Ht1RXEtJ7hfOTIRVKlFgzNO24dRohE5EOVF1AJ
 CvxcNjBthUIQfAoXfT9DfwDjHxXmgSVlo+2hVokvAjGVhVp+ITCOw5Ynacc2HpOHEUxe
 lnX+Lmuhj6rA77SKjfrqBTEcyT2iNGW0uHrnSWwDSwNRK8TgQjSd4tOjK5YHh8Uxo7bz
 QCPQ4N+ThiA45lnIlw3ZACCEZNvY72Bsilz/f0YFCo4wOk2IZc/eBmqYPsnsA2mtRNMG
 u+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260354; x=1771865154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7aD3otBgcxZjv1qvxWCjHurqs+NRqtEYA6dA7W84qVQ=;
 b=ZdvC674W0sCBuvtA8EktGE+BNxp/5gSsapDJy+jygwV3gLSHVDcS/aCmEKGLvFGgRf
 oDQV14+gC8YXBWAbkmjPZtQPEKEHQ83SFVugew3VlriAYdEoC39dz/K/xkRtrOJsxHIS
 h1tK/NF/dLHtx2042zop7ph5cby8h4s7waqKGASZAzbesxsAeffoahVrvea1ptuIRMv6
 v0ndIz6FGrWToRLTBYbrU0hK0TNTcqtea7hrp1azIx9lJmNb7sKZ7u90QYIwb9lWBh/r
 Gr/dwKNs1YoDGi3XhQU/nngONApg2QPIZtDZ6khQ4tixqvrlKkV1o7SO/hg5YbSM2slD
 ZLOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN9gKSKaSwvAy2PqRBzQ/qzOHnh8UTSfPJui12XqYiQcKNvxSf2YR4q+MHU3ZQ7Gnz6svq0cLL@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw7/AETqjWB08OjPynsX1Fa6GURdACJ3Co8Vflf9yQfjEoAUMOs
 tfi7sQ4zVzo8RTkhrR4IeApIkGjjfzyaamsvKOJykHUUb7ekn0pOUEgK
X-Gm-Gg: AZuq6aJUNlxmTT2CTLR0H8mE3oNQkhQxg/ACy6k9472+7+6DyiEMuO+wgSyyB+Z7LN7
 O/pA49krXfY1dWOen5gB4u3hzqS5nlgMf3vai3j08QJNBrIizNQs/0w4Tlj+YqUPJDLW+ulsIwK
 drCjPc7YQn5VTtHYfiIpwNAKHCmvb4Cau+ji1lD2qb2/Ws+iFR8peIG4Y3skITheLkcbYEalZDu
 BSz78CrWD444pbvtPBoK6W8BbSaFxGRHi55aYaNj5KBBIDb1W3SysA+ajBq220MP8yAE26TeVwq
 MBc2VH/gp1Rl2Yp+NaaxyrrG4byWF3kHQf2YpReo3AdT0pgtDwJlUA9QiBQFHVZOIpsjpvEnOtc
 tVBRqi+xsgPte765aLhWQ15Y1bWRTKQ3IHLeEnwA0DczF2I5x/bO5UQAfGEFkuqoIWrNmxy3qN0
 4DKdcRk5dq9m0z4buqG813NJ4NU1+mMWVzWOoo/erIv9+bpnk9A5j0j0ZUlR/ZO6shEVI+Zzh5h
 owf
X-Received: by 2002:a17:907:98d:b0:b8f:bf8:e04a with SMTP id
 a640c23a62f3a-b8fac8b3924mr328939466b.0.1771260353828; 
 Mon, 16 Feb 2026 08:45:53 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d185sm264683866b.14.2026.02.16.08.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:45:53 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v4 26/27] drm/amd/display: Use passive_vrr properties in amdgpu
Date: Mon, 16 Feb 2026 17:45:15 +0100
Message-ID: <20260216164516.36803-27-tomasz.pakula.oficjalny@gmail.com>
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

[How]
Attach and use this properties for HDMI sinks which are troublesome
with their VRR state transitions. Hook into already-established
freesync_on_desktop logic.

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 ++++++++++++++++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6a2806cc800a..41677c50b3d2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7850,6 +7850,8 @@ amdgpu_dm_connector_atomic_duplicate_state(struct drm_connector *connector)
 	__drm_atomic_helper_connector_duplicate_state(connector, &new_state->base);
 
 	new_state->freesync_capable = state->freesync_capable;
+	new_state->freesync_on_desktop_capable =
+		state->freesync_on_desktop_capable;
 	new_state->abm_level = state->abm_level;
 	new_state->scaling = state->scaling;
 	new_state->underscan_enable = state->underscan_enable;
@@ -9057,8 +9059,10 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	    connector_type == DRM_MODE_CONNECTOR_eDP) {
 		drm_connector_attach_hdr_output_metadata_property(&aconnector->base);
 
-		if (!aconnector->mst_root)
+		if (!aconnector->mst_root) {
 			drm_connector_attach_vrr_capable_property(&aconnector->base);
+			drm_connector_attach_passive_vrr_capable_property(&aconnector->base);
+		}
 
 		if (adev->dm.hdcp_workqueue)
 			drm_connector_attach_content_protection_property(&aconnector->base, true);
@@ -11338,6 +11342,12 @@ static void get_freesync_config_for_crtc(
 		config.vsif_supported = true;
 		config.btr = true;
 
+		if (new_con_state->freesync_on_desktop_capable)
+			new_crtc_state->stream->freesync_on_desktop =
+				!new_crtc_state->base.passive_vrr_disabled;
+		else
+			new_crtc_state->stream->freesync_on_desktop = false;
+
 		if (fs_vid_mode) {
 			config.state = VRR_STATE_ACTIVE_FIXED;
 			config.fixed_refresh_in_uhz = new_crtc_state->freesync_config.fixed_refresh_in_uhz;
@@ -11349,6 +11359,7 @@ static void get_freesync_config_for_crtc(
 		}
 	} else {
 		config.state = VRR_STATE_UNSUPPORTED;
+		new_crtc_state->stream->freesync_on_desktop = false;
 	}
 out:
 	new_crtc_state->freesync_config = config;
@@ -13352,6 +13363,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	struct drm_hdmi_vrr_cap hdmi_vrr = {0};
 	struct dpcd_caps dpcd_caps = {0};
 	const struct edid *edid;
+	bool freesync_on_desktop = false;
 	bool freesync_capable = false;
 	bool pcon_allowed = false;
 	bool is_pcon = false;
@@ -13431,6 +13443,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 			monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
 
 		freesync_capable = copy_range_to_amdgpu_connector(connector);
+		freesync_on_desktop = freesync_capable;
 
 	/* DP -> HDMI PCON */
 	} else if (pcon_allowed) {
@@ -13445,11 +13458,14 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		amdgpu_dm_connector->pack_sdp_v1_3 = true;
 		amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_PCON_ALLOWED;
 		freesync_capable = copy_range_to_amdgpu_connector(connector);
+		freesync_on_desktop = freesync_capable;
 	}
 
 update:
-	if (dm_con_state)
+	if (dm_con_state) {
 		dm_con_state->freesync_capable = freesync_capable;
+		dm_con_state->freesync_on_desktop_capable = freesync_on_desktop;
+	}
 
 	if (connector->state && amdgpu_dm_connector->dc_link && !freesync_capable &&
 	    amdgpu_dm_connector->dc_link->replay_settings.config.replay_supported) {
@@ -13458,8 +13474,10 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	}
 
 	if (connector->vrr_capable_property)
-		drm_connector_set_vrr_capable_property(connector,
-						       freesync_capable);
+		drm_connector_set_vrr_capable_property(connector, freesync_capable);
+
+	if (connector->passive_vrr_capable_property)
+		drm_connector_set_passive_vrr_capable_property(connector, freesync_on_desktop);
 }
 
 void amdgpu_dm_trigger_timing_sync(struct drm_device *dev)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 800813671748..88ec2b88dcaf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1020,6 +1020,7 @@ struct dm_connector_state {
 	uint8_t underscan_hborder;
 	bool underscan_enable;
 	bool freesync_capable;
+	bool freesync_on_desktop_capable;
 	bool update_hdcp;
 	bool abm_sysfs_forbidden;
 	uint8_t abm_level;
-- 
2.53.0

