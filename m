Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3101CA6009
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 08:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B49A10E3C3;
	Mon, 19 Jan 2026 08:18:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VCT1wNq5";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E57C10E309
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 01:12:02 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-64b5b68a9bdso593721a12.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 17:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768785121; x=1769389921; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0A5eHusdWY5bDg+aivWCgCoxrDZwEpdh2mh6IhrC0mc=;
 b=VCT1wNq5l7XDBpKphGVmPHuywXhlzpwpLDsN2B+ZBmOeuD1g4txMHJfaemzTeO8UAV
 RHtsUigjk/edCqUh+7mtZktQBAov8nmZWq/JqE5WPocSJCFSCTf49hF2iKWS4lFumkwl
 ugZTIwV6G1B+MqyvD7kGn0Cvo/hpNpA0GKK1hNuaN8Y5KS5yRzgRGFuHnC9RqzbLKv4t
 2EzLSLFhoXheCbXjfuy0CzQW/5fVpIKXkDAVj5iqXPq0G7OJxHzxXwKYOEJl2L+tqxCQ
 fnNrh30X4c/v5WEXVYYxG3iYT4FuBMHf9JSQmZGARYXbIEV6mIevOHodTScDMg0oMptX
 T/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768785121; x=1769389921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0A5eHusdWY5bDg+aivWCgCoxrDZwEpdh2mh6IhrC0mc=;
 b=fDmYlkBaAPPvhFMV/goJ4EkdNC1E6Z/63YeRL4V7uYsCKxA8Q0iIsumg3XG4nBARvN
 bQ7KikEVEE7c+x5gXixy7BTINSOzkGHeNnE6DmVe9thpFp/BdZB7C/RvAFCLtP217jEP
 ZiKyqfRZTimRRNDtHaRvbdR4BKAPVgSZzNNMd59b2OnvAwxYLuLqYrIKiLR3gdH3Dy1b
 L384fe5QZNNPZ4XA3F2/sf3KnWHkDilxL9AhjDwyP8VEzSp8y6Fy7W7IQZ5xO1mxRR+x
 tds57e4H0CvaHHyuv+6EpW7WjgG2TfezhXAoCpBh8vW+unsgwbMhVct6iliGIjwF29D7
 gw9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4RK9bf3ZiTPReA7Xqhfi2g+29QWX/K4vwD2pxlhVYY69DQZ8Tdr/N38yi7JE+zgdML51i1L04@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxomQsJHwaqWHmhtESfuWRllxBp7DyloEYeMHfM+eEtD2ZVAG1B
 PDrXx8aGN30V3L3ucqe8njMQ0MsfZw6WSSAWfKUg5DRy+7rWkXC6eKel
X-Gm-Gg: AY/fxX4uknCCZ/le4T6HDdQ7EUHN6ZYlBRW15YxJJklmEtNanyp+svESJtB5o4u5D2D
 xXdzlohk7Ypc5jaHI0xTiTGtl1zqNq5o30iGW9AXXpzA9Bgu/y7DRsAASmcsIdNRoyxPoTu3y2T
 cMbsQGD3VzVK0lxSgg1BCfdzWqsnGsLQiNtzXYqVVHIBSP1ymA1XBrwEVCGvp2ctXF3hfa5NbAI
 chi51QQLOf6Tma1hKHVbX5G1kAWLOeOmvddEv5aoXXBPX+wmFGGcWCAffE7lF7Y0qB6FHVzFJu0
 6uZNegzP1LCF2Vp700MvU2QxcTZzlRDMma+fzppOk3WTX9jEXLOj0RVdSJV1B8gb4ir1WWkQAe2
 R3tkmCWedeV7qHpV35ChCWw9lP6HwHDZpKFQ2TwxHaZBX+t5Kf+7uqm2+7UOt8Spc/sebdFcGg8
 HCZrQsXYpOurGLo/CuTSOQ43ZkD/FlkL6S821ecbVzYgi1pKd5mlTqIn8+r8ulhYO3
X-Received: by 2002:a05:6402:520c:b0:64d:23ac:6ca6 with SMTP id
 4fb4d7f45d1cf-65452ad0b19mr4219339a12.4.1768785120824; 
 Sun, 18 Jan 2026 17:12:00 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654535c4912sm8989806a12.30.2026.01.18.17.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 17:12:00 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com
Subject: [PATCH 08/17] drm/edid: Parse more info from HDMI Forum vsdb
Date: Mon, 19 Jan 2026 02:11:37 +0100
Message-ID: <20260119011146.62302-9-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119011146.62302-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260119011146.62302-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Jan 2026 08:18:28 +0000
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
index e2e85345aa9a..5bdacd425908 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6149,6 +6149,33 @@ static void drm_parse_ycbcr420_deep_color_info(struct drm_connector *connector,
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
@@ -6274,7 +6301,7 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
 	}
 
 	drm_parse_ycbcr420_deep_color_info(connector, hf_scds);
-
+	drm_parse_hdmi_gaming_info(&connector->display_info.hdmi, hf_scds);
 	if (cea_db_payload_len(hf_scds) >= 11 && hf_scds[11]) {
 		drm_parse_dsc_info(hdmi_dsc, hf_scds);
 		dsc_support = true;
@@ -6284,6 +6311,18 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
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

