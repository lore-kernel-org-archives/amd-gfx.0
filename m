Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B39CAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F4F110EACD;
	Fri, 26 Sep 2025 18:04:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DCWCBdlG";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37D0310EACC
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:04:05 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b5506b28c98so1744707a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758909845; x=1759514645; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bG0JDw3QHJerpIxI8nfa8J0OuVfzbxw0qLl4r+EJark=;
 b=DCWCBdlGw0lzrJYP27pcm3FkVnLX0hQF7gDNM7JsuP6Bwit7qwTNExfmakPBkxPVtU
 XORm0gL1D0W+d+acj+SCWJZcyi1jt/chcJBHyKiovqW5flOmGABFUxX0eSPn68njGh5C
 12oaTBVSLNvGgkzzT23iW+7U1h5VTwMAs+dYBaJ4gs2iyBjbckHbhPJkTybFP7ZPOdt1
 hC15HWuJijN8SYPP94GLOvRee6nlR73jIdsU4C4llt/CWSUsSzs8hiZGICAPDNz13Syu
 RVHv1J6jWpQAy72SB8ify+W5AS73spASeylDGNEHLUaL3XJBlhEcFe4z2ZalFqgTlkSq
 iorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758909845; x=1759514645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bG0JDw3QHJerpIxI8nfa8J0OuVfzbxw0qLl4r+EJark=;
 b=DxpDyz/ipwpEDtWRtyK5DUU0ynqOLY5cJy9+eHb4k9ZYS+GyMXGn31NELkpY2wV5Q/
 kgzmqq4OzoVJDNLXFdhH8fkgK7FAdcSL/XQ9DqXX/33rICH6aYRXh6SebACSyrF4s8Ti
 3uTVXINRyIICifvPGbLhmyLMNE13OlXcg6zgNB8SP5kSdIF83nulFGQRMP2Zrf9z/aLF
 PydqvLVfW96FvcGk98bp4WS1zbXD4IbHhdy26MHXPMIbESLiAjhhNf8lFA3lsHvQmS4+
 m6NkxCDoUEekAinA80LtMxiu+6jPAADcML3/Es6U4+tgx7Q0kOskW0ln0x5AuyI+Bf8N
 Vz+w==
X-Gm-Message-State: AOJu0Yw8o+UiFnKbnzvfIIl+IS2ypbJtI5gQg6+M2x2LMiBUh1MprK9V
 +Kj7gvuEjofBDDgtnUWsHDFpXElQGoP8tSkCC+COlvYdeDWFfa4mpnfW6z7Hvg==
X-Gm-Gg: ASbGncvyAnRgOJ42Tu2Itg5JvMB6Mc2soNUBOovvyrOVT1xIoHG69U7fZ4nLDnm8QJO
 NuNBCOeshaYg/DaSepEXihw0DRVGQ78b0jHBwDwMEIJbZ5yrT563C9sXjELx8mOipOexvnrorQA
 3aukSuXXhhTBbJpF4Wt3Hw1K+yKwlzEJkoQ/OZyrqUMz9dLGJD8HKOWZ0Nisog1lU+Oh0L9VANd
 Ul1uOv1NcAG99zq0xMrEbPmtAY+CZQVdddiXLfNRLLoRELt7yirdXQcerGSnpoKupCuq45r+LSh
 2xTu7nxSUFde0iStU+E/T4jx4a0mRVoHFrYr95lrlnxBLm16Tfjz57evPfcAfbJmTloIugs8jvG
 2Yb2vAdknbdZSiX+TKV0Y2AFKFWQq+lH0MHLeiHMA25FWG3T8Je1LeAxBiX8OPME1PIAswWMzyB
 MEhL1aQ1ZXBfo+BohqGjo=
X-Google-Smtp-Source: AGHT+IE9rjbT8vVu0WcXTSjxgW1D/yryKnfdhMhKFZ6rNSD7jlEBNxBa+jvTJ4DU4KJj+K+0JNacag==
X-Received: by 2002:a17:903:2a8b:b0:279:a5bb:54e2 with SMTP id
 d9443c01a7336-27ed4a3e08dmr105016225ad.20.1758909844763; 
 Fri, 26 Sep 2025 11:04:04 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27f1d2ef8c5sm22186835ad.151.2025.09.26.11.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:04:04 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 21/23] drm/amd/display: Add common modes to analog displays
 without EDID
Date: Fri, 26 Sep 2025 20:02:01 +0200
Message-ID: <20250926180203.16690-22-timur.kristof@gmail.com>
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

When the EDID of an analog display is not available, we can't
know the possible modes supported by the display. However, we
still need to offer the user to select from a variety of common
modes. It will be up to the user to select the best one, though.

This is how it works on other operating systems as well as the
legacy display code path in amdgpu.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 46 +++++++++++--------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 09248ac2f37d..2773436d49d1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8282,7 +8282,7 @@ static void amdgpu_dm_get_native_mode(struct drm_connector *connector)
 
 static struct drm_display_mode *
 amdgpu_dm_create_common_mode(struct drm_encoder *encoder,
-			     char *name,
+			     const char *name,
 			     int hdisplay, int vdisplay)
 {
 	struct drm_device *dev = encoder->dev;
@@ -8304,6 +8304,24 @@ amdgpu_dm_create_common_mode(struct drm_encoder *encoder,
 
 }
 
+static const struct amdgpu_dm_mode_size {
+	char name[DRM_DISPLAY_MODE_LEN];
+	int w;
+	int h;
+} common_modes[] = {
+	{  "640x480",  640,  480},
+	{  "800x600",  800,  600},
+	{ "1024x768", 1024,  768},
+	{ "1280x720", 1280,  720},
+	{ "1280x800", 1280,  800},
+	{"1280x1024", 1280, 1024},
+	{ "1440x900", 1440,  900},
+	{"1680x1050", 1680, 1050},
+	{"1600x1200", 1600, 1200},
+	{"1920x1080", 1920, 1080},
+	{"1920x1200", 1920, 1200}
+};
+
 static void amdgpu_dm_connector_add_common_modes(struct drm_encoder *encoder,
 						 struct drm_connector *connector)
 {
@@ -8314,23 +8332,6 @@ static void amdgpu_dm_connector_add_common_modes(struct drm_encoder *encoder,
 				to_amdgpu_dm_connector(connector);
 	int i;
 	int n;
-	struct mode_size {
-		char name[DRM_DISPLAY_MODE_LEN];
-		int w;
-		int h;
-	} common_modes[] = {
-		{  "640x480",  640,  480},
-		{  "800x600",  800,  600},
-		{ "1024x768", 1024,  768},
-		{ "1280x720", 1280,  720},
-		{ "1280x800", 1280,  800},
-		{"1280x1024", 1280, 1024},
-		{ "1440x900", 1440,  900},
-		{"1680x1050", 1680, 1050},
-		{"1600x1200", 1600, 1200},
-		{"1920x1080", 1920, 1080},
-		{"1920x1200", 1920, 1200}
-	};
 
 	if ((connector->connector_type != DRM_MODE_CONNECTOR_eDP) &&
 	    (connector->connector_type != DRM_MODE_CONNECTOR_LVDS))
@@ -8554,6 +8555,15 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 		if (dc->link_srv->dp_get_encoding_format(verified_link_cap) == DP_128b_132b_ENCODING)
 			amdgpu_dm_connector->num_modes +=
 				drm_add_modes_noedid(connector, 1920, 1080);
+
+		if (amdgpu_dm_connector->dc_sink->edid_caps.analog) {
+			/* Analog monitor connected by DAC load detection.
+			 * Add common modes. It will be up to the user to select one that works.
+			 */
+			for (int i = 0; i < ARRAY_SIZE(common_modes); i++)
+				amdgpu_dm_connector->num_modes += drm_add_modes_noedid(
+					connector, common_modes[i].w, common_modes[i].h);
+		}
 	} else {
 		amdgpu_dm_connector_ddc_get_modes(connector, drm_edid);
 		if (encoder)
-- 
2.51.0

