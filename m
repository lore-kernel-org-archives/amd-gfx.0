Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAD7D31A26
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 08:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24E8810E5D5;
	Wed, 14 Jan 2026 08:29:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VS7SFDzv";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E3C110E553
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 21:41:09 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-64b7d213fd6so1122161a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 13:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768340468; x=1768945268; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jnOk7xTeKASHRNhT1/DjMa9A/4WgBFppfopFsMljQZA=;
 b=VS7SFDzv6AcHSxJRdAEBpMC/ZBS/xBIZ6Nj992KG5tZI9PaSRoc63Wq5DScN4ElBxI
 fXsnRLjGX1zgOTxO8rkcv2LuQgytgnyoeZ5UQTEkCXYYMw73TYoeotqwjg5bDhekEAkZ
 y2cQXcyZrmKvZNIQnMJjU7hc7tEY1HRzq1oGT2gPfbh7Lx9vhciSciidXaDYBB6b3g+X
 +YsMJ0fmL7KNS+iWWPoC154rY6zXpBz0LWn192K35mkV5FQbdS0fPOCQts9kAelefIlW
 zZfJvXrFdpPDXkZ8qUtgbmUp6YkPMDF4z4dA/Gto+CW3jEtHqPCo/XiCrhTbHfSnZxVP
 gDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768340468; x=1768945268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jnOk7xTeKASHRNhT1/DjMa9A/4WgBFppfopFsMljQZA=;
 b=ARI9uD0X4uSJP++ywOyIop3L1UOG+friI9URifBdosWcbH/ZUWLnT1LJi2yCaUwTfG
 NQdfvgzcUrd0bV+AisczqkeQyT/jvBFkr0kfxi+k/m/eNcR1b6irZIuLboWIUFlGZyR8
 vh67CZ2VSiptnZllhG6sFhnXN0zJvtiM001aN6EnM2mfkoWf4R7jTBLIdHnaCpbRCVaA
 sQxXOpMIr6wq5uUiNgyMWFxcV2YWZvlB487qXjERdC+sPASE/ijm7PmPzrXGjE+oRjhp
 MiCzyBJZpqGtKtOqMFzAq2Q3GjYEbZpvAGIa7vllEoTQaQ/swGWMXZCZmArMSBKE0HT8
 gcPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqx95j0DxR4RlgRgj+JdZ019IqI3k8LO97yEAjUhhcQJBwEXrWPHtFCf87lZZNleiZWQw+QqYP@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPL89/MKBhV6m3HyBtfvxRJ3G4aTSszx+8kO9BiNyUR0gwby4I
 Ktj4u+KQWu/ck4KodRerUhT4RnTi4FxqG8FSxZXQtT9DEhoB2oWqf4eJ
X-Gm-Gg: AY/fxX5nfdqgur7+3NWrPpYjjdu0ltEckMJS1YeoQyE2zBCaN+Jtjr7gXa7dtf/7y0W
 01Hl9iWaM4wP9wZ9Cco+ix1zH0YMB75L4nVdsRkIx+72w85M3srlkoCfTMa5krt0jTKbT7BT/Df
 KLxF0q+LV1kAlNiG8r3axz1C8KPvxPLEBZwbzzJStZZcsAKa0Zdc41wyHTK8xNPvBKLm09eyY9a
 F4p0LH6VjSrFqr4q7Q5tf+1LvEgK09YkgESUjpO4VSO5wu5A6q2a01QogWMfM7eSYyVyjcrxUIY
 XmJAKS/sk/P+LRPsvCUmUG1AFBUkbRU98CXyUX2H7R4g1R5sYEG6n+amqvgKCS4F7GzW4kuilSi
 Wp0EGXKt+Tu9+NrdtfuxeYG2C07f0yzy0naCATq8ArBJoFP7pJRYpqKI/Ou3ewuRdjiTk+DDeZw
 NHIUQ6j18ttOO5rWHVSMI+UYoPMgyPCFB4bvQ8GIcTWsE2ENG0fuaF+GQv7jdHxym3
X-Received: by 2002:a05:6402:35ca:b0:64d:2889:cf4e with SMTP id
 4fb4d7f45d1cf-653ec47d79emr190526a12.7.1768340467986; 
 Tue, 13 Jan 2026 13:41:07 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6d5e0sm20858052a12.31.2026.01.13.13.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 13:41:07 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, harry.wentland@amd.com, sunpeng.li@amd.com,
 siqueira@igalia.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] drm/edid: parse more info from HDMI Forum vsdb
Date: Tue, 13 Jan 2026 22:41:02 +0100
Message-ID: <20260113214104.146856-2-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113214104.146856-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260113214104.146856-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Jan 2026 08:29:27 +0000
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
index e2e85345aa9a..1e066d614da7 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6149,6 +6149,33 @@ static void drm_parse_ycbcr420_deep_color_info(struct drm_connector *connector,
 	hdmi->y420_dc_modes = dc_mask;
 }
 
+static void drm_parse_vrr_info(struct drm_hdmi_info *hdmi, const u8 *db)
+{
+	struct drm_hdmi_vrr_cap *vrr = &hdmi->vrr_cap;
+
+	if (cea_db_payload_len(db) < 8)
+		return;
+
+	hdmi->fapa_start_location = db[8] & DRM_EDID_FAPA_START_LOCATION;
+	hdmi->allm = db[8] & DRM_EDID_ALLM;
+	hdmi->fva = db[8] & DRM_EDID_FVA;
+	vrr->cnmvrr = db[8] & DRM_EDID_CNMVRR;
+	vrr->cinema_vrr = db[8] & DRM_EDID_CINEMA_VRR;
+	vrr->mdelta = db[8] & DRM_EDID_MDELTA;
+
+	if (cea_db_payload_len(db) < 9)
+		return;
+
+	vrr->vrr_min = db[9] & DRM_EDID_VRR_MIN_MASK;
+	vrr->supported = (vrr->vrr_min >= 1 && vrr->vrr_min <= 48);
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
+	drm_parse_vrr_info(&connector->display_info.hdmi, hf_scds);
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
+		    str_yes_no(hdmi->allm), str_yes_no(hdmi->fva));
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
index 8f34f4b8183d..296f26551206 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -254,6 +254,41 @@ struct drm_scdc {
 	struct drm_scrambling scrambling;
 };
 
+/**
+ * struct drm_hdmi_vrr_cap - Information about VRR capabilities of a HDMI sink
+ *
+ * Describes the VRR support provided by HDMI 2.1 sink. The information is
+ * fetched fom additional HFVSDB blocks defined for HDMI 2.1.
+ */
+struct drm_hdmi_vrr_cap {
+	/** @mcnmvrr: flag for Negative M VRR support by sink */
+	bool cnmvrr;
+
+	/** @mcinema_vrr: flag for Cinema VRR support by sink */
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
@@ -330,6 +365,18 @@ struct drm_hdmi_info {
 	/** @max_lanes: supported by sink */
 	u8 max_lanes;
 
+	/** @fapa_start_location: flag for the FAPA in blanking support */
+	bool fapa_start_location;
+
+	/** @allm: flag for Auto Low Latency Mode support by sink */
+	bool allm;
+
+	/** @fva: flag for Fast Vactive support by sink */
+	bool fva;
+
+	/** @vrr_cap: VRR capabilities of the sink */
+	struct drm_hdmi_vrr_cap vrr_cap;
+
 	/** @dsc_cap: DSC capabilities of the sink */
 	struct drm_hdmi_dsc_cap dsc_cap;
 };
-- 
2.52.0

