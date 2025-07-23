Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0368C83F17
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 15:58:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 725E210E815;
	Wed, 23 Jul 2025 15:58:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L/XpkcZT";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E1A10E804
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 15:58:36 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-3a510432236so11426f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286315; x=1753891115; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UDrjexqLJcjJ9Bqq1A3ZGrr5oyi/L6/STwz6Y0WLtqk=;
 b=L/XpkcZTlyIBQJnh/ohaXzKCh08xM7h8raBw77Frv2kBJn4HhF6a7U1T4No4qBRzdX
 Zk0vZlImC/VtWCtsNin3qjL1Kv/wuQ9GLgAtAJgqOM/94LdqRXRa3ZShJtb/maaoFG+p
 zYU9oaQD4lLyHKRWhHs1pHEonHjjTaFm7/k9xhSFm99NwjRi20EXeqJcUh3R7Pehm8yh
 9jofrvaQ6ds6esyGWR2qy/4E/DO4bJdESrWpciS6wEgIPCtnbfVsZWJwcPNFPhAj7py0
 v3sYinT6ZaXeUflhAJKeIz06eSQTIcALXNmyTJ/Nm2lFxnNtNV3cdwhyUojzVNQdCdM2
 i0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286315; x=1753891115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UDrjexqLJcjJ9Bqq1A3ZGrr5oyi/L6/STwz6Y0WLtqk=;
 b=jWwcYAJIDtjDhmlGZtgw4FJjVqfuaiTE5QQ47CUyZNzsGh5uvp1JTQCdP65By0Mnhr
 QPuDakvTWvOuKs63PAzCdQbO36qWgPSk8t9rJ0cYfh74YNeukKoL+yYtrlV49GTq4SNl
 rLMoLJ6kgp5cnTymdR83CqU2u+/O42f6DO97wd71F6OZWZfXKNDEeTQSGIIfTzQ422ne
 CRZZ/NZ/gGeDZFKWyBCpgh39Ykc+B7TBZIYMMq2kAUvXHry9PTc8SiVR+Y42fYN6oKBv
 7lyaqZQr0EAxJVfytGOdmyOdmRSNKkUJrhyYy67OH6GZ6ASmQveDhAZUyV+qA0EX5EAp
 75sA==
X-Gm-Message-State: AOJu0YzRlj4bZQ2U1udiKgiLrqd5AnXpnOfRpv1zoP67qNj0E0rg/5yK
 qQvQiO82zAhFceJGxFE7yjbGnRmw2QxazAPKiQFfJ9iwDmpKbCQi9y/MTi94BA==
X-Gm-Gg: ASbGnctwrqMPZ5nO0ME4d136AwQUoXkl2WR6giT7GFsiIpjDzJj6CLvHu9IOeri1D35
 oBbrbSNSsQdvqvfNl29u2HsaqAMZMQsxawwkTR+iJW2VPmYqcTY2mQDDNs/grs7qqX31O3Y6pss
 WgaiTFQpzYsUC7dHS7OjsZTA7e9zeMZ7gQirGhNBzUmR3ysMjaYX75/G/QOT3fd79PJXr0Fbpra
 gLtSofzBUFYNXudelxhBrbXOhLc7dd97nDhhQJieAHQiAmIsp4DOMnQBW7HqcyzE/Hbga7Ln8gn
 /t9NwZqrkmVbl5uHIu9BIQZdk6X/A6CpVDc7sfOdDA947ZtQQQuon8KpBne6Z2FMYhaJwy30LDV
 Sq4TY0o53d3S8tjP5Np1FS3g33jnUU4sEDhxJ7cF4pHVvRAzuq1r1APxzDFj8cx+DG9jFZMRo3d
 GqGEF8WUpMZoXCUYUhS10Da2C02g==
X-Google-Smtp-Source: AGHT+IGQ0KXKVf6w/umQFRZtYyyHNFUbeUI8Jmh7H8nXWF4X6On+cyrhCYbogu3e1x7dxwwYedDn/A==
X-Received: by 2002:a05:6000:26c6:b0:3b6:2f9:42b1 with SMTP id
 ffacd0b85a97d-3b768eedb05mr3118829f8f.13.1753286314921; 
 Wed, 23 Jul 2025 08:58:34 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4D24D8FC008443E005DD6C3C62.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:8443:e005:dd6c:3c62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bf99sm16710468f8f.32.2025.07.23.08.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:58:34 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 19/20] drm/amd/display: Add common modes to analog displays
 without EDID
Date: Wed, 23 Jul 2025 17:58:12 +0200
Message-ID: <20250723155813.9101-20-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723155813.9101-1-timur.kristof@gmail.com>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
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
index 49ee516dc83d..23333880f4e5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8172,7 +8172,7 @@ static void amdgpu_dm_get_native_mode(struct drm_connector *connector)
 
 static struct drm_display_mode *
 amdgpu_dm_create_common_mode(struct drm_encoder *encoder,
-			     char *name,
+			     const char *name,
 			     int hdisplay, int vdisplay)
 {
 	struct drm_device *dev = encoder->dev;
@@ -8194,6 +8194,24 @@ amdgpu_dm_create_common_mode(struct drm_encoder *encoder,
 
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
@@ -8204,23 +8222,6 @@ static void amdgpu_dm_connector_add_common_modes(struct drm_encoder *encoder,
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
 
 	n = ARRAY_SIZE(common_modes);
 
@@ -8440,6 +8441,15 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
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
 		if (encoder && (connector->connector_type != DRM_MODE_CONNECTOR_eDP) &&
-- 
2.50.1

