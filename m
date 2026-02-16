Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F73E6814F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 749D810E487;
	Tue, 17 Feb 2026 08:05:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V4U2WR2t";
	dkim-atps=neutral
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B05A10E3CA
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 16:45:39 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id
 a640c23a62f3a-b8f7fd33bd2so48124666b.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 08:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771260338; x=1771865138; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qp5SXJGMlbR2C2KjVkdcVn6F2JKroblos6Aoghsh/Sw=;
 b=V4U2WR2tyHo0LDfV0q57O9Nmg6tf/ZiOFu5VUOsxKVqjjUZaZtTNzF2abWxOFr2YSA
 aF8+gGzQD1EiPw+W6D9XHUjYpcSUoIqbJf4KuWb7nXmJPomYFx5B+M4xnykcdYfsf/JL
 JXxM30M5o16xwU5drao/dALu2nQDoz3hTeXDUN+ZKtA3i1djh5p7GmVl5ewnaOv+0+LR
 OojvRh66qhWOyXzr6cJHveT61CzWLAWZMbKpW4CfQknE+Adi3XEPjld+Nk33D5TYk+Vb
 kKN+KPfHLzpOdGQ8TbPC6mmkw9ovDi2KOqrdFRv01frPXQ9Ap8OgqyhltUEn1YvhC2eC
 92aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260338; x=1771865138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qp5SXJGMlbR2C2KjVkdcVn6F2JKroblos6Aoghsh/Sw=;
 b=xLceUk+v4nGNJJ8zlmrtcSjxd/7SrOD/os+L4URaE9ZbtY4zQyiIqmf8dRHnlQt7KT
 CdWe/I5u6pO6F3wORzanal9qKNk5jYUbgCFL3wS/i/tppuISTapX0So8guMHMk0LogtI
 0zDzw9vz8h/qvcnXvIG/aBMsGFAr02JvmM8tIwIJtB3a2TbwrxkcVbW5EKfAdopOL/f8
 K0vzlOy1RGtRmAJTxaF649LJO/MZzDxAHr0BDM+EmoInlg5idZKLdJbiCWSELFQyxUsT
 FBTr1ywcZOipZ8RNyHNv50Klv8NXJBB9Uvtf78/kaCaaq22MvPV8OVqKDi1GeOgeajQG
 n8WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtBe9AlIXyR6FSXzyhQQk2M0wFlPJrEjzu0fUpi7X6FLWwJQkqlFuwZLazOPFlCf3GwfMiJxMp@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwnPeGSo3n4M+Qto52KVry4MYeV66eB2DZBNzjEqSAbUzyvaPhK
 EXeDJCNmikbHQF3jgwtpjP6Xye0eXR70HQYaOsbc4vBTe8pQkqNXN6L1
X-Gm-Gg: AZuq6aI1OAtZewQVOMfXNGEZbh5oxM7heluirf3UYbfAdkdbrnEBBkGUwQRyYN1l5/3
 3dxxJVfi04NOKUDCq1rHBO04qxWMxszBpFpy5acVfs0M9lOQrT8TEX8Md3n7xjlFm38qz419r0b
 VIwE8ny7x6r5kS1aOMmg8KnlnKnTBWDXXZKQ8IbC/xAmBTrxuAyLB12lgeMZGdyLkG6gWKVNUQn
 2Mljl1onch2W8CaIbCEG3pc+ltTao/opXjtcvrsRgp87Pga7uU5IxWj25u+SAgaBEHMh7bRF1Lt
 CyWhzLr5QPyzWoJA8jvJLqvqCKXpX3tJFu5R/KHcGBkANqkORd8IahZCi9sCEvrJyz7GAYMelR+
 VBtMCGmnR/7hw9/79Hf7MoC0BLGop9RK3ij3paFEUM3EKB1ZxKka2bj8do+Pp3bN1zNiwSHPQTO
 z6P9OkN1gPkN5nYbmMVODaNnWNH71WxeK5mh3hjTHyM7+FlAYBBGNMHav+gRFvlnPoG0FE5UssH
 qaw
X-Received: by 2002:a17:907:9628:b0:b87:6c5c:d3d4 with SMTP id
 a640c23a62f3a-b8facc7b4ebmr343317866b.2.1771260337873; 
 Mon, 16 Feb 2026 08:45:37 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d185sm264683866b.14.2026.02.16.08.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:45:37 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v4 14/27] drm/amd/display: Enable HDMI VRR over PCON
Date: Mon, 16 Feb 2026 17:45:03 +0100
Message-ID: <20260216164516.36803-15-tomasz.pakula.oficjalny@gmail.com>
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
Not all TVs support FreeSync and many TVs suffer from VRR flickering
while Freesync is activated.

[How]
This works the same as FreeSync over PCON just without sending FreeSync
info packets (we're sending standard DisplayPort info packets) + reading
the VRR range from the HDMI Forum vendor specific data block. PCONs take
over HDMI VRR triggering.

Prefer HDMI VRR over FreeSync to reduce VRR flickering on many TVs.
FreeSync over HDMI seems to be a fallback solution and not a first-class
citizen. This especially helps VMM7100.

Tested with VMM7100 and CH7218 based adapters on multiple HDMI 2.1 and
HDMI 2.0 devices. (Samsung S95B, LG C4, Sony Bravia 8, Dell AW3423DWF)

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4805

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Tested-by: Bernhard Berger <bernhard.berger@gmail.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 29 +++++++++++++++----
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e511eb5a1f7f..931493433439 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13258,6 +13258,17 @@ static void monitor_range_from_vsdb(struct drm_display_info *display,
 	display->monitor_range.max_vfreq = vsdb->max_refresh_rate_hz;
 }
 
+/**
+ * Get VRR range from HDMI VRR info in EDID.
+ *
+ * @conn: drm_connector with HDMI VRR info
+ */
+static void monitor_range_from_hdmi(struct drm_display_info *display)
+{
+	display->monitor_range.min_vfreq = display->hdmi.vrr_cap.vrr_min;
+	display->monitor_range.max_vfreq = display->hdmi.vrr_cap.vrr_max;
+}
+
 /*
  * Returns true if connector is capable of freesync
  * Optionally, can fetch the range from AMD vsdb
@@ -13322,6 +13333,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	struct amdgpu_device *adev = drm_to_adev(connector->dev);
 	struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
 	struct amdgpu_hdmi_vsdb_info vsdb_did = {0};
+	struct drm_hdmi_vrr_cap hdmi_vrr = {0};
 	struct dpcd_caps dpcd_caps = {0};
 	const struct edid *edid;
 	bool freesync_capable = false;
@@ -13357,6 +13369,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	/* Gather all data */
 	edid = drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
 	parse_amd_vsdb_cea(amdgpu_dm_connector, edid, &vsdb_info);
+	hdmi_vrr = connector->display_info.hdmi.vrr_cap;
 
 	if (amdgpu_dm_connector->dc_link) {
 		dpcd_caps = amdgpu_dm_connector->dc_link->dpcd_caps;
@@ -13398,13 +13411,17 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		freesync_capable = copy_range_to_amdgpu_connector(connector);
 
 	/* DP -> HDMI PCON */
-	} else if (pcon_allowed && vsdb_info.freesync_supported) {
-		amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_PCON_ALLOWED;
-		amdgpu_dm_connector->pack_sdp_v1_3 = true;
-		amdgpu_dm_connector->vsdb_info = vsdb_info;
+	} else if (pcon_allowed) {
+		/* Prefer HDMI VRR */
+		if (hdmi_vrr.supported && hdmi_vrr.vrr_max > 0)
+			monitor_range_from_hdmi(&connector->display_info);
+		else if (vsdb_info.freesync_supported) {
+			amdgpu_dm_connector->vsdb_info = vsdb_info;
+			monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
+		}
 
-		parse_amd_vsdb_cea(amdgpu_dm_connector, edid, &vsdb_info);
-		monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
+		amdgpu_dm_connector->pack_sdp_v1_3 = true;
+		amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_PCON_ALLOWED;
 		freesync_capable = copy_range_to_amdgpu_connector(connector);
 	}
 
-- 
2.53.0

