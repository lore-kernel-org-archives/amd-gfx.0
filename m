Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96360CAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:02:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BA2710EAB2;
	Fri, 26 Sep 2025 18:02:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d2uGv7Ca";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B02F910EAB2
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:02:26 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-27c369f8986so24674885ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758909746; x=1759514546; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LxiGj+CM3qtjfo2HCFmEbMDyBqyILSp5cxtgeNpe78A=;
 b=d2uGv7CaSQ2fC44IkjACBqOjlBiQDipvGL1ZmOZ0wID7E0gUzAQhurcrEdeoHcInTv
 lfM2AAPbDIv0awdIQQiVxCFLtjyDsBXSlFSsOPZKhMOu7dLiqHUj+uZA0A5QRd1XDXXk
 zivpY9kqS7psW6rrmadViKu2gkO0aZj1e+c41TtCV/ngCqK7cyOOMJFnAS9wopfPjSLt
 ioin0i/E+uCkE5mxdwyAm8OYvJByyKvVNEy8X5/nIK6EZu+QGXwy0uJlLAp3J/mUJ1v0
 GPB4ViM2V/G9QGZ/wPce940HXDfvprwaFg/a7XkmX19+41wBfKAiEblgdPwkE79qWp4O
 xBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758909746; x=1759514546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LxiGj+CM3qtjfo2HCFmEbMDyBqyILSp5cxtgeNpe78A=;
 b=TXCD4TEs/BZdjj5yhE8r1hrNU1HcEdCcWGMY3hpPpXwjzehSU17bQRlzDpGVYPH92L
 pAQrEN4mK/JfxBsTdjp1EoBryC/VKay11rwcu1XqnmGFPwmP5m9UpMTBqhEiJVP77HtC
 4kE52LmNSSOJPy0nj3ojYEgMSe40lH1mVh9pBDgMcRG0QyIraqDc+qdp7ZH+jZ8tOUDr
 zNHDNPTwWBkVeeoP2tOUiN5gtRQ6tsqKPK/O2G0z8JDy9HbGToc5nr2IGNcTZwJviuz5
 KZPDk3UStxmMt7L3zpng2u2vAsc/s6UlVgrUoJvYINsXMwzSht49sut8h+Vo7VD7AlZ4
 VyVg==
X-Gm-Message-State: AOJu0Yw0ZsRorVua8nsbCMqRHKG1OHN820DYk0P5HwRYJzYYCFnWv3lz
 6OonQRQn2q6fyvIGliW4j5hMrHIEJeYSIZ2hF305LUsxpwzI55Ww30nP4+v+Zg==
X-Gm-Gg: ASbGncs9mDeWvTVpoFimimXdyI6t7kP633N3cNwEVnSxxcUT0xXas1Qc8GRNa8tDQRw
 oWwDN0cK8V68YPIxRDIidHs0TnTIAwnJzXOip23bOmpnAWsk+46Rk403wk3SzUiPOi+BtRBMxaU
 vWl1ezp45fzxnOgYBXSGPL32/1zfGhI4pTAuRalMgwpJSNbLgDpHqC0p2ULDkBTV4369aBrPSBm
 23x0C3kjOrmXv6CxCfBe8ZyvZQNMlHJH2G4dQMz3OwTe5qsu3UelIx3aFdMEKjnk0ERl1KNuGzZ
 52Je84yqLkYbF4vISxnG4AiFOW9RApk955m53XXEjjcDFHhWSvX3fv1ytDOAhMAvhvynJGrrN5q
 u3rU/3XEbgztwgwAJvUbdc5VAqNYXirrlWg0fU4V5uMdR8/ag9C526dQGQnkdOHg77h40VEUylG
 H4Q/+LSDjHhdUxo8SoWMEOsyoBJToAn8TBMKbk6qBW
X-Google-Smtp-Source: AGHT+IEcu3+T9Hw7Ypr8lV+voZ8go+TkjrzlLVQ14REoUpSK13exUfcHJ8IvcvxcOpr3G9pDe8ZVZw==
X-Received: by 2002:a17:902:e88d:b0:263:b8f:77dd with SMTP id
 d9443c01a7336-27ed4a5ec57mr98591345ad.57.1758909746086; 
 Fri, 26 Sep 2025 11:02:26 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27f1d2ef8c5sm22186835ad.151.2025.09.26.11.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:02:25 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 02/23] drm/amd/display: Add analog bit to edid_caps (v2)
Date: Fri, 26 Sep 2025 20:01:42 +0200
Message-ID: <20250926180203.16690-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926180203.16690-1-timur.kristof@gmail.com>
References: <20250926180203.16690-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

The new analog bit will be used with DVI-I connectors.

DVI-I connectors can connect to both digital and analog monitors
and this bit will help distinguish between those.

v2:
Sanitize analog bit based on connector type.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h                 | 5 +++++
 drivers/gpu/drm/amd/display/dc/link/link_detection.c      | 2 ++
 drivers/gpu/drm/amd/display/include/grph_object_id.h      | 7 +++++++
 4 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index fe100e4c9801..a14076878b89 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -130,6 +130,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 	edid_caps->serial_number = edid_buf->serial;
 	edid_caps->manufacture_week = edid_buf->mfg_week;
 	edid_caps->manufacture_year = edid_buf->mfg_year;
+	edid_caps->analog = !(edid_buf->input & DRM_EDID_INPUT_DIGITAL);
 
 	drm_edid_get_monitor_name(edid_buf,
 				  edid_caps->display_name,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index b5aa03a3e39c..d948cdb98ea8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -185,6 +185,10 @@ struct dc_panel_patch {
 	unsigned int wait_after_dpcd_poweroff_ms;
 };
 
+/**
+ * struct dc_edid_caps - Capabilities read from EDID.
+ * @analog: Whether the monitor is analog. Used by DVI-I handling.
+ */
 struct dc_edid_caps {
 	/* sink identification */
 	uint16_t manufacturer_id;
@@ -212,6 +216,7 @@ struct dc_edid_caps {
 	bool edid_hdmi;
 	bool hdr_supported;
 	bool rr_capable;
+	bool analog;
 
 	struct dc_panel_patch panel_patch;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 85303167a553..2ab8ee7f42c1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1103,6 +1103,8 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 			break;
 		}
 
+		sink->edid_caps.analog &= dc_connector_supports_analog(link->link_id.id);
+
 		// Check if edid is the same
 		if ((prev_sink) &&
 		    (edid_status == EDID_THE_SAME || edid_status == EDID_OK))
diff --git a/drivers/gpu/drm/amd/display/include/grph_object_id.h b/drivers/gpu/drm/amd/display/include/grph_object_id.h
index 54e33062b3c0..1386fa124e85 100644
--- a/drivers/gpu/drm/amd/display/include/grph_object_id.h
+++ b/drivers/gpu/drm/amd/display/include/grph_object_id.h
@@ -310,4 +310,11 @@ static inline bool dal_graphics_object_id_equal(
 	}
 	return false;
 }
+
+static inline bool dc_connector_supports_analog(const enum connector_id conn)
+{
+	return conn == CONNECTOR_ID_VGA ||
+		conn == CONNECTOR_ID_SINGLE_LINK_DVII ||
+		conn == CONNECTOR_ID_DUAL_LINK_DVII;
+}
 #endif
-- 
2.51.0

