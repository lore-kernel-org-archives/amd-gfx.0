Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BAACD5BA1
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 08:36:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDB9710E653;
	Thu, 13 Nov 2025 08:36:12 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D28A410E752
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 15:18:46 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-429c4c65485so756340f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 07:18:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762960725; x=1763565525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CoNxldqQ9XC46fWcQpE6fTzrSoqa7Z4c9uT8rkaqQDA=;
 b=dwyK524q0hPYCp9t4+Zow//eyjkIASI2/o6O7LEAEuT8PTk7+i6e6AhGxEDF6CHyEG
 OVRD57mLe7NjsrqbT91OP+OrFyC8uBf88Y25Bqk1zbNZRI2YOuiNYEukXn3UO3ZFOFDU
 p8nbeN5LHL0z/I0Nk++heaweZ1pSzyEti3OYxR3vGeoePtzpLOCXLfoM/2u65Wy79MjH
 POarB+Oa42U2os/MgQMjhyFD7mEo2zIOCZN3yxbclAP1Vem2XjRzKn+dnh29k19R/1oB
 w7v889++nmvzRitc66WyzO9boXPCnEUW3MakErvfsCOuZfvhARIFe2m4MmX1/tClBOSp
 4kFw==
X-Gm-Message-State: AOJu0YwqcEfBrLEWysGlrSuQOyFL18uXGHa3be52QXD8XQ1hmQnw/en9
 ocTbIIH775UjEi4z8Lu/4jv+oSBPFajJtZLNDtpBR6qunq7nWxvoEsNo
X-Gm-Gg: ASbGncuFM6JZ+F6v4akHyfQF7aQvA1/R/DCA5luniQcQmNxEpZXnh1kZlDa25WgwPzA
 cvp+c6NFJN94aaBK3UYo6/sgNsH5ESIm5XkS+WvkOdF5Kl3A2V1Ac+TgZHv9dszaP+Eu0uO0uxY
 pzwmVML1hLobt1fr01fqJGoSqt90i3yxkbdKtljGUO3SQ5GM0beDFaNVKoxd4CPKyM+OtDvD/Il
 kMGFyCq5RyPyyMI0Su9IWq/vxJytYZlsMGRkouMTLXtqwLd0Fcfmbq9OkiJPKfSejv8vhY2IKkb
 jlhQr5PFeW8U7bFzisWh5VfIrafF86RrF8P9mQfynaQEXA5ti3LNuArbXEHMHkt0m8oHPlHTA3k
 PYTFe7O940C/qAcq0VCq8vAy+Wi4KHg+pA+greP6bT7gjiXjHkr2QGGhbAUPgLQjUbISupLGVU/
 WWNfcZMt5Y4HxCSAmc60npRAgWvOPEAA==
X-Google-Smtp-Source: AGHT+IGF7nGz/ug3qY7kPQEMpiNaYPXy+qWXoxY1uIwMuOXL0cO51Om5p4heD/ImJII5Z0tzw/FHWw==
X-Received: by 2002:a5d:5d10:0:b0:405:3028:1be2 with SMTP id
 ffacd0b85a97d-42b4bb87689mr3349619f8f.11.1762960725208; 
 Wed, 12 Nov 2025 07:18:45 -0800 (PST)
Received: from xavers-framework.fritz.box ([193.124.138.23])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b32c1ad2bsm23255211f8f.6.2025.11.12.07.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 07:18:44 -0800 (PST)
From: Xaver Hugl <xaver.hugl@kde.org>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, wayland-devel@lists.freedesktop.org,
 harry.wentland@amd.com, Xaver Hugl <xaver.hugl@kde.org>
Subject: [PATCH 2/3] amdgpu_dm: also look for the AMD VSDB in CEA extensions
Date: Wed, 12 Nov 2025 16:18:31 +0100
Message-ID: <20251112151832.77867-2-xaver.hugl@kde.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112151832.77867-1-xaver.hugl@kde.org>
References: <20251112151832.77867-1-xaver.hugl@kde.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Nov 2025 08:36:11 +0000
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

This makes FreeSync 2 work on some DisplayPort monitors that are lacking the
vsdb in DisplayID extensions.

Signed-off-by: Xaver Hugl <xaver.hugl@kde.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 ++++++++++++-------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1660169ae5aa..6597fe07e984 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12557,9 +12557,9 @@ static int parse_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 	return false;
 }
 
-static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
-			       const struct edid *edid,
-			       struct amdgpu_hdmi_vsdb_info *vsdb_info)
+static int parse_cea_amd_vsdb(struct amdgpu_dm_connector *aconnector,
+			      const struct edid *edid,
+			      struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
 	u8 *edid_ext = NULL;
 	int i;
@@ -12657,16 +12657,22 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 				freesync_capable = true;
 		}
 
-		parse_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
-
-		if (vsdb_info.replay_mode) {
+		i = parse_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
+		if (i <= 0) {
+			/* Some DP monitors have the AMD VSDB in the CEA-861 block instead */
+			i = parse_cea_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
+		}
+		if (i >= 0) {
 			amdgpu_dm_connector->vsdb_info.replay_mode = vsdb_info.replay_mode;
 			amdgpu_dm_connector->vsdb_info.amd_vsdb_version = vsdb_info.amd_vsdb_version;
-			amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_EDP;
+			if (sink->sink_signal == SIGNAL_TYPE_EDP)
+			    amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_EDP;
+			else
+			    amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_DP;
 		}
 
 	} else if (drm_edid && sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {
-		i = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
+		i = parse_cea_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
 		if (i >= 0 && vsdb_info.freesync_supported) {
 			amdgpu_dm_connector->min_vfreq = vsdb_info.min_refresh_rate_hz;
 			amdgpu_dm_connector->max_vfreq = vsdb_info.max_refresh_rate_hz;
@@ -12682,7 +12688,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		as_type = dm_get_adaptive_sync_support_type(amdgpu_dm_connector->dc_link);
 
 	if (as_type == FREESYNC_TYPE_PCON_IN_WHITELIST) {
-		i = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
+		i = parse_cea_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
 		if (i >= 0 && vsdb_info.freesync_supported && vsdb_info.amd_vsdb_version > 0) {
 
 			amdgpu_dm_connector->pack_sdp_v1_3 = true;
-- 
2.51.1

