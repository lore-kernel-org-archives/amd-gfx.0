Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F52E6749B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 08:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 959A010E5B6;
	Mon, 22 Dec 2025 08:23:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HI1sGIuy";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AA1010E1F5
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Dec 2025 11:46:57 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-b735c1fe67aso34618266b.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Dec 2025 03:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766231216; x=1766836016; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Kxr5ddmQKReA91nA03TLo36yhYjQYmk2iEDV4ATAeY=;
 b=HI1sGIuyqsiPE8hFaIbpD5EgnavpQMd2U8Dh1qqLYBOB4DH70pdVK1cWl+YYYNVEEr
 4+G7TM6JQBGklnUYUKxKzgty6RcZoNto+uRNoaI/+4gL8smNyPq5rp4lmLAcWjvQ2Yq1
 doG8gXr/dzImFYZQi6OiIGqE123Xj8jH1Q1CMfsAWcrqtCkQ4QtR4GS2yrOex9NrE7ei
 rAZC6s4oo6Cvtaj1KX0PaTaHPk0ZJz94jdtUHDy6gya5eCjLM62OduE+R87WnD9L8b6O
 T+HA+aZPcQ7mXj/+Q4qFGsK9wdan9NEQT6OgT+TWRUJumq/9itgLuwRl7hFx1qN8fd86
 7RXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766231216; x=1766836016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3Kxr5ddmQKReA91nA03TLo36yhYjQYmk2iEDV4ATAeY=;
 b=g8mnjhbKoJXV6u7yzHGN8Lpi1XDUhnituN9TqQbUzEPEmCfRkc0bt0qspsYEFOLOZj
 FmenQ6wz7V9bQhCSg16Er2veAvjC6GoZ/5BOSJZbQO24aNF+HZyb8KTtzhiK4f9PfSDs
 TJFeGds2gO1SY1BSQudrQt+yR8A2vntadV1cYOpiDi1ks3OnyMuR9ro+Xv4EsZEhM2HW
 RknzVUhdYRopRKu3yYOcDjLanL0jzibpswv3YqlImGdHdF1M1aDobox+s1R77RPfrjOt
 mfPkCWG2NU9En3DHY/Zyx+fL6UetMV61+KXuoIeDRWBhyiFlFe8IxSVBoCA8JlgAz4ps
 WosA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw5NMh1tKd1M6OChseM19RLVmHFN6+5Bp2nIgHCm20I8GHxXKAMsSKwDS0yphMKJ06LE42jTY4@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyg7xuneFFS9gQeXf+FDP5+8LeGpp5sUvtA/VttFDkML2XOxH6l
 dk6fQXhhozjU9a8HbLBtfjwc4oHJEsbi4bLTZ+M6q0GUBxLrOCysEPNYKUP2OA==
X-Gm-Gg: AY/fxX6lcqK3JoqmidBYEIs8geBD66KvneASkRF1S2hLVTstYj3nnDlV/qwnnA0aeA2
 o868CpkxJ98srm19f/V+lhV1YYxaYwAZpHKRJAJTgoIkXMI5TFC4CktuxxPucoZfId1BkTBmBIl
 bphMahLFhtI2FpfaeUVHVWfzU2TLw156K7LXIXTTTBNWmIxcg4USR6IOSnjXqTvl0GlRLtagH25
 RNIizr0zOzXXQ5HZQ3kGEzBQ84fq9GPRrDOmDPQFtq6ieRr77rjwhjWGHwuk02vqRm9Z5rgZKIy
 iBM0mwVi+ldClux73WGrYePe64mCzWnG8Sr/mK4seU4irF06D1XVxCH6VzUuDfG7FvCBPSUu/0o
 vdzG89s+Fp3jx0OfAxq2EgXgxDD6ZaOATQCrW+1dWutTCSnTglvR9Y/WaCJ1oEQiNkqBRcjSH1y
 8JiQNTbQw98TMxN/VyZDsfKNHKkGH7kysQf45mODlRd2iMkrpSl/3rxjJtOa99LXhT
X-Google-Smtp-Source: AGHT+IH7wWv7EZ4MK00T1q4GjZttTeK1d4HACQz7QEcs955FA/z0aehTGE03UMfQb5gCYn+K2q5kqw==
X-Received: by 2002:a17:907:2da7:b0:b71:a627:3d9a with SMTP id
 a640c23a62f3a-b803695c415mr322917966b.0.1766231215354; 
 Sat, 20 Dec 2025 03:46:55 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037a5bdb9sm495449066b.7.2025.12.20.03.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Dec 2025 03:46:55 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, harry.wentland@amd.com, sunpeng.li@amd.com,
 siqueira@igalia.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 bernhard.berger@gmail.com
Subject: [PATCH 2/4] drm/edid: parse HDMI VRR information
Date: Sat, 20 Dec 2025 12:46:47 +0100
Message-ID: <20251220114649.169147-3-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251220114649.169147-1-tomasz.pakula.oficjalny@gmail.com>
References: <20251220114649.169147-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 22 Dec 2025 08:23:36 +0000
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

Adds a struct to hold HDMI VRR information. `supported` here is an
additional property which allows easier parsing in consumers and adds a
bit of logic used by most driver to decide if VRR is worthwhile.

Additionally, edid-decode seems to throw errors if VRRmin is above 48 Hz
and VRRmax is below 100 Hz. I'm not sure if it's based on an actual HDMI
spec or, again, is showing "best practices".

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Tested-by: Bernhard Berger <bernhard.berger@gmail.com>
---
 drivers/gpu/drm/drm_edid.c  | 19 +++++++++++++++++--
 include/drm/drm_connector.h | 20 ++++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index bb6cee249749..981b3b28c94b 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6149,6 +6149,19 @@ static void drm_parse_ycbcr420_deep_color_info(struct drm_connector *connector,
 	hdmi->y420_dc_modes = dc_mask;
 }
 
+static void drm_parse_vrr_info(struct drm_connector *connector, const u8 *db)
+{
+	struct drm_hdmi_vrr_cap *vrr = &connector->display_info.hdmi.vrr_cap;
+
+	vrr->supported = false;
+	if (!(cea_db_payload_len(db) >= 10) || !db[9] || !db[10])
+		return;
+
+	vrr->min_hz = db[9] & DRM_EDID_VRR_MIN_MASK;
+	vrr->max_hz = (db[9] & DRM_EDID_VRR_MAX_UPPER_MASK) << 2 | db[10];
+	vrr->supported = (vrr->min_hz > 0) && (vrr->max_hz - vrr->min_hz > 10);
+}
+
 static void drm_parse_dsc_info(struct drm_hdmi_dsc_cap *hdmi_dsc,
 			       const u8 *hf_scds)
 {
@@ -6277,6 +6290,7 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
 	if (cea_db_payload_len(hf_scds) >= 8 && hf_scds[8])
 		hdmi->allm_supported = hf_scds[8] & DRM_EDID_ALLM;
 
+	drm_parse_vrr_info(connector, hf_scds);
 	if (cea_db_payload_len(hf_scds) >= 11 && hf_scds[11]) {
 		drm_parse_dsc_info(hdmi_dsc, hf_scds);
 		dsc_support = true;
@@ -6287,8 +6301,9 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
 		    connector->base.id, connector->name,
 		    max_tmds_clock, str_yes_no(max_frl_rate), str_yes_no(dsc_support));
 	drm_dbg_kms(connector->dev,
-		"[CONNECTOR:%d:%s] ALLM support: %s\n",
-		connector->base.id, connector->name, str_yes_no(hdmi->allm_supported));
+		"[CONNECTOR:%d:%s] ALLM support: %s, VRR support: %s, VRR min Hz: %u, VRR max Hz: %u\n",
+		connector->base.id, connector->name, str_yes_no(hdmi->allm_supported),
+		str_yes_no(hdmi->vrr_cap.supported), hdmi->vrr_cap.min_hz, hdmi->vrr_cap.max_hz);
 }
 
 static void drm_parse_hdmi_deep_color_info(struct drm_connector *connector,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index ac84884a96a5..8663daccf1db 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -254,6 +254,23 @@ struct drm_scdc {
 	struct drm_scrambling scrambling;
 };
 
+/**
+ * struct drm_hdmi_vrr_cap - Information about VRR capabilities of a HDMI sink
+ *
+ * Describes the VRR support provided by HDMI 2.1 sink. The information is
+ * fetched fom additional HFVSDB blocks defined for HDMI 2.1.
+ */
+struct drm_hdmi_vrr_cap {
+	/** @supported: flag for vrr support by sink */
+	bool supported;
+
+	/** @min_hz : minimum supported variable refresh rate */
+	u16 min_hz;
+
+	/** @max_hz : maximum supported variable refresh rate */
+	u16 max_hz;
+};
+
 /**
  * struct drm_hdmi_dsc_cap - DSC capabilities of HDMI sink
  *
@@ -333,6 +350,9 @@ struct drm_hdmi_info {
 	/** @allm_supported: flag for auto low latency mode support by sink */
 	bool allm_supported;
 
+	/** @vrr_cap: VRR capabilities of the sink */
+	struct drm_hdmi_vrr_cap vrr_cap;
+
 	/** @dsc_cap: DSC capabilities of the sink */
 	struct drm_hdmi_dsc_cap dsc_cap;
 };
-- 
2.52.0

