Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0076BE7BDA6
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F1DA10E467;
	Tue, 17 Feb 2026 08:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J+rRvzrb";
	dkim-atps=neutral
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE90510E3BC
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 16:45:27 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id
 a640c23a62f3a-b8fa19e6186so64116666b.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 08:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771260326; x=1771865126; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Ztq3hyjq4dBqjOVD+VwET2LGqK9hc4CUPcVZQOdgeE=;
 b=J+rRvzrbm2UFM7+3+5qRE5yQtJlWdkStQiWfof3DwlZyNhN/mop/L664bUty87sD7/
 0kLGs8efkxQIiY1cYZWS0TfOdh+XKDVVvZbmOQ7oFsm8JPzEZsCEU0A/v1crH5VIPeiJ
 8JeuvdAZprYY2ruaFk1ZTuIGdIniXPVNbrzQws9jfz/Q2eq+ZC7EdCTcdltS7r6Du3iX
 8FVfSFoRWPDMEqATvjTlgsb2OJIPP3hotjM8n2our5yRX5aZnLq5sCtjRHXF7VMmY4V1
 L53byrsSCQQaixRt6E7OjwjTNq+mqi6EFEDMb8nCchsxvzYX+tC9HtOakBgQY1h86ZMQ
 lFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260326; x=1771865126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Ztq3hyjq4dBqjOVD+VwET2LGqK9hc4CUPcVZQOdgeE=;
 b=ZZaPbJQdmSvBHJDnAIx2b6snmaH3Eci+Rya6NiGSrI+laE4Vs5zmd0jvABXMTqzj6v
 LRCA8TADqboyn67MiH74BT2TvasfvutgVxIvi0As/gXpNqqpjeBH6+AeKuZF7zWd78FT
 VOAD3XRPf0NQ7GjJGCthfe5oHpE0KFyYnFcO+HC8n7pzCuCDc6WoMW3x5MJwrMfdZioQ
 VYmPvudMJwH2zMGvlfQnaizhCfoZruN62ePtbh6RYBgQKIudF9ckV4pUhTS3VJNpP1wN
 VMwQM1kuoPTkQ7Wwx2axWvgZZuNeQutgjXGd4c+tLT8AzRnWl3hduiKQ555vnfkFKmp/
 8feg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBrYdZ5wXpeWc9cxn0IIda5eCiOTHHctnqTA6g1lUZvXn/WryKkOrD8BHbgKGsYUXAfyGckpB+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzMD7U1uajkmKNG/fIYvmKmsmyVEZSVvKLerW+6aQCfcyJyT7se
 h8y7Q89u7ewC+q7pJUg/PTajaBKAKHghHdxyyHNB9mXvPlzJwq96MxTO
X-Gm-Gg: AZuq6aIHErjbwBCzGKm7r711hBQr7/kllX8RwH8OSnWxvA9wmlfb7cNVrsy2pErCbFo
 nuDzKQza4SHHKvpC/W81Bg8t0a9AhHThYyKm93Pa6eRSEZzGfLrfH79pKEisq6P6zBNflD4WDrk
 ESK56aK+UY2dgnMpwTUB9hbbfDPzO6bI41wE3XlGpqnBs8IdZYutotNTsQXwzlBzw4hp6KEeX1O
 lXdyE9YRB4Lz6Y+GCK2bVhhze4JwOJFgHk21fbiaFLVF2ku2U3WDLNQLux1OCeXYk62fsIOIgkA
 Jk/gQuoZSHMSQRBSHv8FNK7f+fctyS/AibEndeHPkj78Hg4LF8jexP6iotNf1XXtXDnFeUi3ZVi
 MEZxv0OxKnF8CjpVB9uLLEW3xAHo2vLT/9HDm0jeB+KYGj9GYr7fvb2KCFn8YXRJ3RokbYL1Ame
 nHH5kL3sD+Nd1jL3JuFUMNWpSCIzWc73KEvQpDTBxoIvU3cbM95rwHdxfpkodrs4f0Gxwae9fUG
 i0r
X-Received: by 2002:a17:907:608c:b0:b8f:e96:7880 with SMTP id
 a640c23a62f3a-b8fac86c68dmr364359766b.0.1771260326136; 
 Mon, 16 Feb 2026 08:45:26 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d185sm264683866b.14.2026.02.16.08.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:45:25 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v4 05/27] drm/amd/display: Always try to parse AMD vsdb
Date: Mon, 16 Feb 2026 17:44:54 +0100
Message-ID: <20260216164516.36803-6-tomasz.pakula.oficjalny@gmail.com>
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
Allows us to make the code inside amdgpu_dm_update_freesync_caps() more
concise and prepares for vsdb usage outside of HDMI and
DP -> HDMI 2.1 dongles.

[How]
Move the parsing function outside of specific signal type blocks.
Merge signal type checks and freesync_supported checks

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 27 ++++++++-----------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index be3bb5a86959..64d1dae4d214 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13322,6 +13322,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		goto update;
 
 	edid = drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
+	parse_amd_vsdb_cea(amdgpu_dm_connector, edid, &vsdb_info);
 
 	if (amdgpu_dm_connector->dc_link)
 		dpcd_caps = amdgpu_dm_connector->dc_link->dpcd_caps;
@@ -13343,28 +13344,22 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 			amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_EDP;
 		}
 
-	} else if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {
-		parse_amd_vsdb_cea(amdgpu_dm_connector, edid, &vsdb_info);
-		if (vsdb_info.freesync_supported) {
-			monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
-			freesync_capable = copy_range_to_amdgpu_connector(connector);
-		}
+	} else if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A && vsdb_info.freesync_supported) {
+		monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
+		freesync_capable = copy_range_to_amdgpu_connector(connector);
 	}
 
 	if (amdgpu_dm_connector->dc_link)
 		as_type = dm_get_adaptive_sync_support_type(amdgpu_dm_connector->dc_link);
 
-	if (as_type == FREESYNC_TYPE_PCON_IN_WHITELIST) {
-		parse_amd_vsdb_cea(amdgpu_dm_connector, edid, &vsdb_info);
-		if (vsdb_info.freesync_supported) {
-			amdgpu_dm_connector->pack_sdp_v1_3 = true;
-			amdgpu_dm_connector->as_type = as_type;
-			amdgpu_dm_connector->vsdb_info = vsdb_info;
+	if (as_type == FREESYNC_TYPE_PCON_IN_WHITELIST && vsdb_info.freesync_supported) {
+		amdgpu_dm_connector->pack_sdp_v1_3 = true;
+		amdgpu_dm_connector->as_type = as_type;
+		amdgpu_dm_connector->vsdb_info = vsdb_info;
 
-			parse_amd_vsdb_cea(amdgpu_dm_connector, edid, &vsdb_info);
-			monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
-			freesync_capable = copy_range_to_amdgpu_connector(connector);
-		}
+		parse_amd_vsdb_cea(amdgpu_dm_connector, edid, &vsdb_info);
+		monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
+		freesync_capable = copy_range_to_amdgpu_connector(connector);
 	}
 
 update:
-- 
2.53.0

