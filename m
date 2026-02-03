Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49091E83EE8
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 08:10:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F04F710E542;
	Wed,  4 Feb 2026 08:10:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bAiOPvF5";
	dkim-atps=neutral
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1391A10E759
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 18:56:42 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-658ce852fbaso685786a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Feb 2026 10:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770145000; x=1770749800; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mAB3KDw5GOUIKIF2o4N4gSZWkxRRmgXSHPln09h9Vw=;
 b=bAiOPvF5UOfNpBofOx15OXb1wRGEHGpJEE+al/3g8P9jdtYPPl3ORN/uqnBkxtWP85
 eV+Y7U7b1TEWY1ub2TbU8PMIDQRx4qqeEamyZrazAZS7AEUnEXncmwNYil3Vq/4hHO3G
 ccOkGXpW5PeMhshYFMmnTgc+Arvq7dU5VZkU8zLH/LE4mEDezylPLXVcLtHcHPT7Yl4U
 KPdaxy93lCgYGqfan2fpKpEHdnj6JPztrxnYHDpUhUGjox3mQUH/NWl/M+ljhJc9crNH
 ty2BN8/zpbqww1lqcI8Xmyjq+Sp9iXQ1SJcjIMT3VqkuBzQSH2hWnM/LKXWigsRifaS6
 IVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770145000; x=1770749800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2mAB3KDw5GOUIKIF2o4N4gSZWkxRRmgXSHPln09h9Vw=;
 b=s7OFbsv3nej9zcTL31b8fgRXP5wOIhn3wvK2tTiEwZOo20xyjpWHLvBxCsUyZi6QB+
 PZPcbbg9q12zC5Fo9KxEBXCxTYmpFXRjGUwhFlSh650xA1bFMKQF5EZ/a7yqbkRnK7k+
 c3Z3z8Oeo23pFmm/g/Vswd4lxmy+pIVMLRseh6DPTJP+vJ3G0X4bIbGYVRWdeY66VsO7
 Yod1cFamAhOYcKt2aYGDOVChkJF0YzHvF8OftqCNFSre96E7VGCrjr2VOkMqTV8tCHl1
 RaZVskL3nCZLx4CJItkZGiLwnXx0Oo0UHLyGZSZTkhv+1VEQ88rVa2JB+5tQGmymgepM
 sPaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXleU1n31Sx6JJtrOO5TrAGmuz1nxZBUBCicgW+4nMqxEQ1KTwCwxYFw6Zh0SGB320aTon7Kehr@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6dT/qOCMVLR1RS8rtt2mqvBif2mk7mF/xnYY36m7pBc9SxVIb
 itXQ5xpUAECyvmG1MJXBbrd4CfWVtofW8U7ta6L5Mg1I5wm/1RPeQsHX
X-Gm-Gg: AZuq6aIQfVghHqNDs8CPI5CM/wD8zAvsALFkUB08OXLfcwFdm37+ljKtlhOLkQYeOJR
 PMVW+kE3EYfCxPkcCfVWNg8ujnpIrAaffNTbpgJAMhNChvWqDav2K4RJEYW46F6OvfYzYajQG38
 1ByrqmdgNXEt01weK79Ajb9ywsWeY+N7ueuLkqqNBtpViAT5uxdaEcyvtKJ439PrdMcyS35Wqme
 IfBdjF5gItIQm3glCdc+9gJWxr8wKFKxryv/LnYgEAosBRpzNz2lYtsxE5MB8TK+s+3JtZwTZNO
 4yJ/qRirjd6+jz8n7sGJjOKfuVp3qb+U7JFb43dJZ0M4OnJptOLb4uOZvWfrrjoOc4lTeoSWPnh
 dvpNnnuBNHydnW7/KAcBNHYiTxeCPm6k+NaLv4CSyhrlwscYqZ1jRUqZOx878tSEepECORbe5XK
 vZs7ohjwXEk2fLKNMumXHVDBkLUyjtjWkDukYDjyQxdNy6XNov85yaRewdT7JpjmdVBIh75xZjm
 kI=
X-Received: by 2002:a05:6402:5214:b0:658:1299:8a03 with SMTP id
 4fb4d7f45d1cf-659499b6960mr282428a12.1.1770145000338; 
 Tue, 03 Feb 2026 10:56:40 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8e9fad97a7sm16715766b.0.2026.02.03.10.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 10:56:40 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org,
 daniel@fooishbar.org, admin@ptr1337.dev
Subject: [PATCH v3 08/19] drm/edid: Parse more info from HDMI Forum vsdb
Date: Tue,  3 Feb 2026 19:56:15 +0100
Message-ID: <20260203185626.55428-9-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Feb 2026 08:10:21 +0000
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
Drivers may need info about gaming features exposed by HDMI sinks. Add
a central way of storing this information.

[How]
Adds flags and a struct to hold HDMI VRR information. `supported` here
is an additional property which allows easier parsing in consumers and
adds a bit of logic used to detect malformed VRRmin/VRRmax values.

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Tested-by: Bernhard Berger <bernhard.berger@gmail.com>
---
 drivers/gpu/drm/drm_edid.c  | 41 +++++++++++++++++++++++++++++++-
 include/drm/drm_connector.h | 47 +++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 26bb7710a462..056eff8cbd1a 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6152,6 +6152,33 @@ static void drm_parse_ycbcr420_deep_color_info(struct drm_connector *connector,
 	hdmi->y420_dc_modes = dc_mask;
 }
 
+static void drm_parse_hdmi_gaming_info(struct drm_hdmi_info *hdmi, const u8 *db)
+{
+	struct drm_hdmi_vrr_cap *vrr = &hdmi->vrr_cap;
+
+	if (cea_db_payload_len(db) < 8)
+		return;
+
+	hdmi->fapa_start_location = db[8] & DRM_EDID_FAPA_START_LOCATION;
+	hdmi->allm = db[8] & DRM_EDID_ALLM;
+	vrr->fva = db[8] & DRM_EDID_FVA;
+	vrr->cnmvrr = db[8] & DRM_EDID_CNMVRR;
+	vrr->cinema_vrr = db[8] & DRM_EDID_CINEMA_VRR;
+	vrr->mdelta = db[8] & DRM_EDID_MDELTA;
+
+	if (cea_db_payload_len(db) < 9)
+		return;
+
+	vrr->vrr_min = db[9] & DRM_EDID_VRR_MIN_MASK;
+	vrr->supported = (vrr->vrr_min > 0 && vrr->vrr_min <= 48);
+
+	if (cea_db_payload_len(db) < 10)
+		return;
+
+	vrr->vrr_max = (db[9] & DRM_EDID_VRR_MAX_UPPER_MASK) << 2 | db[10];
+	vrr->supported &= (vrr->vrr_max == 0 || vrr->vrr_max >= 100);
+}
+
 static void drm_parse_dsc_info(struct drm_hdmi_dsc_cap *hdmi_dsc,
 			       const u8 *hf_scds)
 {
@@ -6277,7 +6304,7 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
 	}
 
 	drm_parse_ycbcr420_deep_color_info(connector, hf_scds);
-
+	drm_parse_hdmi_gaming_info(&connector->display_info.hdmi, hf_scds);
 	if (cea_db_payload_len(hf_scds) >= 11 && hf_scds[11]) {
 		drm_parse_dsc_info(hdmi_dsc, hf_scds);
 		dsc_support = true;
@@ -6287,6 +6314,18 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
 		    "[CONNECTOR:%d:%s] HF-VSDB: max TMDS clock: %d KHz, HDMI 2.1 support: %s, DSC 1.2 support: %s\n",
 		    connector->base.id, connector->name,
 		    max_tmds_clock, str_yes_no(max_frl_rate), str_yes_no(dsc_support));
+	drm_dbg_kms(connector->dev,
+		    "[CONNECTOR:%d:%s] FAPA in blanking: %s, ALLM support: %s, Fast Vactive support: %s\n",
+		    connector->base.id, connector->name, str_yes_no(hdmi->fapa_start_location),
+		    str_yes_no(hdmi->allm), str_yes_no(hdmi->vrr_cap.fva));
+	drm_dbg_kms(connector->dev,
+		    "[CONNECTOR:%d:%s] Negative M VRR support: %s, CinemaVRR support: %s, Mdelta: %d\n",
+		    connector->base.id, connector->name, str_yes_no(hdmi->vrr_cap.cnmvrr),
+		    str_yes_no(hdmi->vrr_cap.cinema_vrr), hdmi->vrr_cap.mdelta);
+	drm_dbg_kms(connector->dev,
+		    "[CONNECTOR:%d:%s] VRRmin: %u, VRRmax: %u, VRR supported: %s\n",
+		    connector->base.id, connector->name, hdmi->vrr_cap.vrr_min,
+		    hdmi->vrr_cap.vrr_max, str_yes_no(hdmi->vrr_cap.supported));
 }
 
 static void drm_parse_hdmi_deep_color_info(struct drm_connector *connector,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 8f34f4b8183d..dab9d5521f41 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -254,6 +254,44 @@ struct drm_scdc {
 	struct drm_scrambling scrambling;
 };
 
+/**
+ * struct drm_hdmi_vrr_cap - Information about VRR capabilities of a HDMI sink
+ *
+ * Describes the VRR support provided by HDMI 2.1 sink. The information is
+ * fetched fom additional HFVSDB blocks defined for HDMI 2.1.
+ */
+struct drm_hdmi_vrr_cap {
+	/** @fva: flag for Fast VActive (Quick Frame Transport) support */
+	bool fva;
+
+	/** @mcnmvrr: flag for Negative M VRR support */
+	bool cnmvrr;
+
+	/** @mcinema_vrr: flag for Cinema VRR support */
+	bool cinema_vrr;
+
+	/** @mdelta: flag for limited frame-to-frame compensation support */
+	bool mdelta;
+
+	/**
+	 * @vrr_min : minimum supported variable refresh rate in Hz.
+	 * Valid values only inide 1 - 48 range
+	 */
+	u16 vrr_min;
+
+	/**
+	 * @vrr_max : maximum supported variable refresh rate in Hz (optional).
+	 * Valid values are either 0 (max based on video mode) or >= 100
+	 */
+	u16 vrr_max;
+
+	/**
+	 * @supported: flag for vrr support based on checking for VRRmin and
+	 * VRRmax values having correct values.
+	 */
+	bool supported;
+};
+
 /**
  * struct drm_hdmi_dsc_cap - DSC capabilities of HDMI sink
  *
@@ -330,6 +368,15 @@ struct drm_hdmi_info {
 	/** @max_lanes: supported by sink */
 	u8 max_lanes;
 
+	/** @fapa_start_location: flag for the FAPA in blanking support */
+	bool fapa_start_location;
+
+	/** @allm: flag for Auto Low Latency Mode support by sink */
+	bool allm;
+
+	/** @vrr_cap: VRR capabilities of the sink */
+	struct drm_hdmi_vrr_cap vrr_cap;
+
 	/** @dsc_cap: DSC capabilities of the sink */
 	struct drm_hdmi_dsc_cap dsc_cap;
 };
-- 
2.52.0

