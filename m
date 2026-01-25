Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23EDC88E6B
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 08:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 540ED10E3C6;
	Mon, 26 Jan 2026 08:09:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d/BGM2kh";
	dkim-atps=neutral
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7232610E376
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 18:39:33 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id
 4fb4d7f45d1cf-64b6f896689so546358a12.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 10:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769366372; x=1769971172; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=03JVoj5pQZnfXuN1Dsu194SUGxgQv5HQ+1Go+Oa8Fms=;
 b=d/BGM2khFP6XDIkkB27qvJM6B7FUk+mtJhGcjuQgPntBffFrvcAyjaYnWRRF51oBRD
 z8leSWL9FY+keOqEvGuwvF0ysukIC2M725kIlQ48XcthFkPxnLO3kRUMfybY+nNA9dUy
 wzxY22dLXYXL2NHonHRV30336MARPgq9TphnjqmskFfvJzud4jByEQR8qxElg9AWdBAF
 fNDYWwPesveGD0VVrBSVhjHR+9nxlJogj5cATSczfnalfKtu7rJbe9q5mOngFrqtIsc3
 bLuTxSsHkVyWSjAQVvgHgIMlRXQyfbg6si7Rl8xMqD/svj2j0S5akyIylAPPOm4U53HL
 IjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769366372; x=1769971172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=03JVoj5pQZnfXuN1Dsu194SUGxgQv5HQ+1Go+Oa8Fms=;
 b=L7z6i7uxQhbucDJkikbqu1RPRGsd6az0dVOROr1glQZiY+Ttmilr7C2D039xo1hL8D
 /1s9RJX5hbpr/F/CpX64eQgddL3uiGoS/NUx/NAKt70HMrBB3NyHudiOHf7jOirmyajr
 pklIBNDtxb2fXxiwvL/uoqGlAi2SSg68ZGiXje9cLgbUV1C9YqjDcIs50N9X1E5e0Bwf
 HRIXxhrrbkmxBWm/76f9dPAZjtUGqljbiXxmtm1wBtFACWWzi398zZxwgWZ1fuw/cgJ7
 /FtLYcgmKCFH1g/ux06Sk44LGn+Qpey96b6Pjei6HUB9kLDtWq04dZ3/7q0OwLXzSznD
 qkIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4g1WZQ37u84IUJq6fELpZDu2gfwbvkby0ahcRhF69u5SPoTX8NMe3b9wZkjyAiB05LBdhu9H0@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxVdSfU4MZZv4uFYgfvn5P0eEy8fsQxOGynLT9YrJunPSBTCQI8
 U9J6SmqkpUYB0zhrIz1GQbSluJSMWIU2NiMmBnEYZY4Kh1Xxs/EaodAL
X-Gm-Gg: AZuq6aIdLv3taPamGakbq4ZVWPwTD2fREIVyBQqitrQeJxZqnnzXOsGx8Rwu7ZWO2TY
 eZf1hcnfbiDOU25Uqim9/IT9tAWvqlr9PjC6cN8ZUD0o9V9kjmDKZr2mPpxhysxquausDTaBA9i
 WGBS3GAS9zHu8FbJva/889RWityKiNpEsDSrjptv/STTgeGakfs/o7fkhxE1TZQWQHbtkhwNXmx
 PoMfvNQrNTJF1kXihAqNI+dSbZWyURg1QQV0QCMMJyis0kfCDOWrq24W44bCKwsPVvkwVXMG0It
 qAfqV+DQ8WOD8ph/p60NbTwmkgTVI5D8mpX7wiSrm903JLiV7LkkK3yuyizD+opoiQvaxTyAgye
 rDCOAKLWI1eUzG+C04OghNRsbhednOkGsQeV5yhjcN0LUgJTv99/12PAGbANa2wo00yoSTN716A
 lNnvOHfBEfRi6S///3zReoMPBxJ8WvFQwU9xHlz1omCo7AcSi1mc5CYkpk+Otd/vMC
X-Received: by 2002:a17:906:c104:b0:b87:3087:54f0 with SMTP id
 a640c23a62f3a-b8d3fa9d567mr110192266b.3.1769366371750; 
 Sun, 25 Jan 2026 10:39:31 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b885b3dad3asm499133766b.12.2026.01.25.10.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 10:39:31 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v2 11/19] drm/amd/display: Support HDMI VRRmax=0
Date: Sun, 25 Jan 2026 19:39:06 +0100
Message-ID: <20260125183914.459228-12-tomasz.pakula.oficjalny@gmail.com>
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
VRRmax=0 is a valid value and means that the upper bound is guared by
the selected video mode.

[How]
In this context, saved vrr max is the max possible refresh rate ever.
Try getting upper VRR bound from AMD vsdbif it exists or rely on the
limitations of BRR in VTEM info frames.

I found through testing, that TVs seem to reject VTEM when BRR is set
to over 1023 Hz. Use this as the last resort VRRmax.

v2:
- Update max BRR value to 1023

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++++++----
 .../amd/display/modules/inc/mod_info_packet.h |  2 ++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d3464705ab7f..b93ba14d87d1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13215,14 +13215,25 @@ static void monitor_range_from_vsdb(struct drm_connector *conn,
  * try getting upper bound from AMD vsdb (if passed).
  *
  * @conn: drm_connector with HDMI VRR info
+ * @vsdb: AMD vsdb from CAE. Can be NULL if not found.
  */
-static void monitor_range_from_hdmi(struct drm_connector *conn)
+static void monitor_range_from_hdmi(struct drm_connector *conn,
+				    const struct amdgpu_hdmi_vsdb_info *vsdb)
 {
 	struct drm_monitor_range_info *range = &conn->display_info.monitor_range;
 	struct drm_hdmi_vrr_cap *caps = &conn->display_info.hdmi.vrr_cap;
+	u16 vrr_max = caps->vrr_max;
+
+	/* Try getting upper vrr bound from AMD vsdb */
+	if (vrr_max == 0 && vsdb)
+		vrr_max = vsdb->max_refresh_rate_hz;
+
+	/* Use max possible BRR value as a last resort */
+	if (vrr_max == 0)
+		vrr_max = VTEM_BRR_MAX;
 
 	range->min_vfreq = caps->vrr_min;
-	range->max_vfreq = caps->vrr_max;
+	range->max_vfreq = vrr_max;
 }
 
 /*
@@ -13360,8 +13371,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	/* DP -> HDMI PCON */
 	} else if (pcon_allowed) {
 		/* Prefer HDMI VRR */
-		if (hdmi_vrr->supported && hdmi_vrr->vrr_max > 0)
-			monitor_range_from_hdmi(connector);
+		if (hdmi_vrr->supported)
+			monitor_range_from_hdmi(connector, valid_vsdb_cea ? &vsdb_info : NULL);
 		else if (vsdb_freesync) {
 			amdgpu_dm_connector->vsdb_info = vsdb_info;
 			monitor_range_from_vsdb(connector, &vsdb_info);
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
index 5de8a6918e6a..306eb7355c25 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
@@ -33,6 +33,8 @@ struct dc_stream_state;
 struct dc_info_packet;
 struct mod_vrr_params;
 
+#define VTEM_BRR_MAX 1023
+
 void set_vsc_packet_colorimetry_data(
 		const struct dc_stream_state *stream,
 		struct dc_info_packet *info_packet,
-- 
2.52.0

