Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334DFE6814C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34BE910E482;
	Tue, 17 Feb 2026 08:05:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gMdf2U5j";
	dkim-atps=neutral
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9304210E3C0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 16:45:31 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id
 a640c23a62f3a-b8f8d9b2c50so27321666b.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 08:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771260330; x=1771865130; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JEn0R38mGrwNqYAUGw253vwfhRvgl/ooBxvHfFpzd00=;
 b=gMdf2U5jfX3hEfu2VNBuHzDgrCTusI4igtRw6QF6gFhy49qRsISHejUq+3ruQP7aC6
 xFL732uu9jcCQ5fqKWNaakhxaQ7Y0cW7WgqQQ70Ted8YvfQI5LxArWSH9kdrge/FHbWH
 Y/ZgWugs6+pIWHsQFIV2XFsBHZ54sGNP/lRQPptDXJL3/CTHbmkoqnPdm6ZmpXgLIWmB
 rOraJZPdPk4cGZtY3AWA1XpgoK7hzEa5Z2DIQE26ABATNBCrfxlSSlLbBusbBOq6RTcb
 sQ4ucnh1NAVnk/+iaqfa8qyZZd7OM0GJACiTdrUrnQV5vPayl5Jzf4cVA6tYRNg1u/L8
 ACvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260330; x=1771865130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JEn0R38mGrwNqYAUGw253vwfhRvgl/ooBxvHfFpzd00=;
 b=uVNR7G7OCTM2PQulQ3AOdU4hbofcU23fZNxX5mbXmkrC4IOKJWJAuvuTjd2pBYm/ZX
 kNmP1R6Q8LolxW+8oyZcWCMQRZztvsXIK9ew1vfRk0bM8zZHfmqcaJoUYOA8Y3BSSHYG
 vJVNEiLFO0JeNSIfWIfuCGShpwmh+XXDz71bxlVsa4PZmCxw4RwjOfgxAXBevvqxE7WM
 x9SxePnl5AUkGmVC6QB6VItqu8El6YcGDVTUApIyeiEPRULJzN1RqCS5CovhhYyw7shy
 osbVnTBpr79mhF0QZ+7LUY75HpUnSmfHCrAbrSYWrwcKOnEWC+jp6VAH1m5PCk/JN/Yt
 W/GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcD6rRaQAITYMhFBJ4rYkwy7ffIHDdHvb3D51/jt/AFJ/rI1wCvMPvAUWJHUEiOSoprQkIW/tb@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyfSFh6+EVbzlxmucdWJhsbJxxqFDoN1p3vQelf4Gk5eEMwCdkY
 BKLFPDMwFLMMBXobJtGHnWZCUK2s2iu1Ri4uYn0Ibi1R6otcwTmhG8g2
X-Gm-Gg: AZuq6aKJ8yAWqzqKRoVGVf+bJQ7K1S7zy64pWu016m0IJMdB6i7Mvu3aSaH5QAmqBQl
 bj+gJMTsnyHGpzVDXoDrL5xZpWjaZivmvo33OjHZZ/YzOAwgwk/GGcxDGH/l7LIM1i3FuhotEqz
 /7hGBG8P1uMGj+dmYcOi7T3tXf1GUaQl+0gy1YpCrn1y7CsBUC2QnreSzPhwRokHrMy4rFcfIgE
 op68WzJzxIgCiNl0xhL199ZSQIW3EVE/fYl1nFvHK4z/dsXgbNN2X+lCp79DxlKZ3NnJj356MyS
 c6e5DJJYUFMOg4KgNVHvaZC49PplbdnIHA95bCEaHDvg9QG7tC9OEXnArFQjrUH4qlQrE0Odqyv
 3kKwlhY5XAbNkKCxKLUbLaDl43/PtLQqX2hfxn6ti17rBcYLVOyAZyBe6QxmiIYLf7hGveoAUgw
 BICMXCQn8WzCBk0n5QI/Xov8yyoiIhweGDfBME63nGkYkHhWI5wLR4EB7IimJTsPLkQmPrmfjFd
 2Uv
X-Received: by 2002:a17:907:3e88:b0:b87:20c2:e837 with SMTP id
 a640c23a62f3a-b8face05dd0mr357799766b.5.1771260330026; 
 Mon, 16 Feb 2026 08:45:30 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d185sm264683866b.14.2026.02.16.08.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:45:29 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v4 08/27] drm/amd/display: Separate DP/eDP and PCON paths
 completely
Date: Mon, 16 Feb 2026 17:44:57 +0100
Message-ID: <20260216164516.36803-9-tomasz.pakula.oficjalny@gmail.com>
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
DP -> HDMI PCONs need a completely separate treatment but they did fall
into DP/eDP path in amdgpu_dm_update_freesync_caps() previously. This
could sometimes result in weird values assigned to the connector even
though it doesn't support VRR at all and needs a bit of HDMI-like
treatment.

[How]
Check if the connected sink is a HDMI -> DP converter earlier and
gate DP/eDP path

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f36059bb0324..2f31fe7265d9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13321,6 +13321,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	struct dpcd_caps dpcd_caps = {0};
 	const struct edid *edid;
 	bool freesync_capable = false;
+	bool is_pcon = false;
 	enum adaptive_sync_type as_type = ADAPTIVE_SYNC_TYPE_NONE;
 
 	if (!connector->state) {
@@ -13349,14 +13350,18 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (!adev->dm.freesync_module || !dc_supports_vrr(sink->ctx->dce_version))
 		goto update;
 
+	/* Gather all data */
 	edid = drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
 	parse_amd_vsdb_cea(amdgpu_dm_connector, edid, &vsdb_info);
 
-	if (amdgpu_dm_connector->dc_link)
+	if (amdgpu_dm_connector->dc_link) {
 		dpcd_caps = amdgpu_dm_connector->dc_link->dpcd_caps;
+		is_pcon = dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER;
+	}
 
-	if (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
-	    sink->sink_signal == SIGNAL_TYPE_EDP) {
+	/* DP & eDP excluding PCONs */
+	if ((sink->sink_signal == SIGNAL_TYPE_EDP ||
+	     sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT) && !is_pcon) {
 		/* Some eDP panels only have the refresh rate range info in DisplayID */
 		if (is_monitor_range_invalid(connector))
 			parse_edid_displayid_vrr(connector, edid);
@@ -13381,14 +13386,16 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 			amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_EDP;
 		}
 
+	/* HDMI */
 	} else if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A && vsdb_info.freesync_supported) {
 		monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
 		freesync_capable = copy_range_to_amdgpu_connector(connector);
 	}
 
-	if (amdgpu_dm_connector->dc_link)
+	if (amdgpu_dm_connector->dc_link && is_pcon)
 		as_type = dm_get_adaptive_sync_support_type(amdgpu_dm_connector->dc_link);
 
+	/* DP -> HDMI PCON */
 	if (as_type == FREESYNC_TYPE_PCON_IN_WHITELIST && vsdb_info.freesync_supported) {
 		amdgpu_dm_connector->pack_sdp_v1_3 = true;
 		amdgpu_dm_connector->as_type = as_type;
-- 
2.53.0

