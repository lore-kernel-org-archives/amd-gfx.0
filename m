Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581E1FF885D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 11:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED7E110EB36;
	Tue, 28 Apr 2026 11:40:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sHPt1Z0W";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A99D210EB25
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 11:40:50 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso60526665e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 04:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777376449; x=1777981249; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ypH27uQwuy5pDnE68T5zg/kDCAEZgZSBRLcrCnC/X9I=;
 b=sHPt1Z0W8gnVjl0NXNteb8g9CtNZmidjq3uHy4j5fpKImGKVPXvqcNFJ5GfcokBJsu
 NTmIAK5SSw1MObi8X6S749/CCxYhws4M1ehMXZ+PAoZXl4opQ148w0eXhqp1xKuz+Ns+
 Oe4osHki7FqpJ9MqGldJimey/tdbA+hojeIUGOdNNFkKhUKruGXfB0MurG/ZcZZCn1XC
 +LwW28e3wwjyN2Uw8OymSWX2hhxr8G2bMYZO9a/kBPeporLC8wSPOImnq/mjFxcQlLaW
 CdG4yVGFmzEaAVA5NFNUfbrwGo3uZyR8/v+q61NxMO5KTqVT+LUyNkoJVcU+XFQLfH23
 4MKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777376449; x=1777981249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ypH27uQwuy5pDnE68T5zg/kDCAEZgZSBRLcrCnC/X9I=;
 b=JXbuIgqIVC0DopYciKY13v/zT1HBgUxmqKo1DxtMRXXKeQ/a8OCHT/fdA0l5gwhs+j
 gTzi9JDDSbP69tvmPoBeuU3cwPKr7AM6mE+A/TMTl445p2xtyLQukqnEZ+CKN0dbRFAE
 R1dVk94/xKxSb3+TVkTI96G2CLnu+vGGb9pMP0/Gg6CDLqBH2bDlUggxr4UCBi6KhM+1
 lZS/6+xtQcScAgVWJ6+IvsG4EuMFGQJfwlMflr3SQteIU5nJ/uM57LsmJOoAXeGkpWMr
 JrUquPSVdbxBYiJvNzjOUZUVbq0aUZ6EQsY1JNhwG05HD8AII/Amkv2jMzYAXlHgubXl
 QVKQ==
X-Gm-Message-State: AOJu0Yyi+Xxk8yxrnAshO32Zuw8Ix7FG/scINBiS4byFWHTx1vLrlQrC
 v8MqUpAXp5uZ0MuVogZhZtw9PeQP1wQ70Vd5/QbaEVyvj7hK5a4v8Na5XOYDyh/o
X-Gm-Gg: AeBDietYpuGy6GkdOLP+fsQsC+nD11iZziQChia/sK6YYFuoWCVFJi82Wf/wEGJQp6P
 lccAQNoeiK8LrE4VpT3rJOE6tH/mmESysiKPqXBbUK/II5dkpWBKV7ZguafWAPjpU2KW5258a3M
 LYcpM3+gu8WxEc4YcvqtxZTVbjY71echAuGI6nPfgUo+O9pS8Krvtdv4U1I2AFP0FtTGCsnwb/I
 Z4io3v9uqEOiNqT7SP9zZ2SQ4jRgMagXJwcCsJyO2Wki8t86cP8ORENjq/Z016SfWQO7bpiKtxz
 D399OmhoH8ajt8ap4g32BfYRVATdv2bCr8xUDw4vPrttVZkkXJRdyg5ArX16auxxv7yOLX68Mbq
 ulVd+gtqf8OBhUE++ivDadyAgtBYwYMXHm2XaAvMrWyoyJK1KOATzTOJeHWi2yG5QAUvyI7xLCo
 YchIhIC+MuO5YwoY+ABWNSqEOaU5BBdGQAtq/2UIl8Es/m/VHh+uVqhuIOZlTQwVkLt5kXZyk6G
 /mg
X-Received: by 2002:a05:600c:1396:b0:48a:5565:ec3d with SMTP id
 5b1f17b1804b1-48a77b1b85fmr44369135e9.22.1777376448989; 
 Tue, 28 Apr 2026 04:40:48 -0700 (PDT)
Received: from Timur-Hyperion.home (5401DFC2.dsl.pool.telekom.hu.
 [84.1.223.194]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a775e4bd0sm25048275e9.8.2026.04.28.04.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 04:40:48 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/6] drm/amd/display: Allow embedded connectors without DDC
Date: Tue, 28 Apr 2026 13:40:40 +0200
Message-ID: <20260428114045.40710-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428114045.40710-1-timur.kristof@gmail.com>
References: <20260428114045.40710-1-timur.kristof@gmail.com>
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

On some laptops, the embedded panel may not have
a DDC (display data channel) available. On these,
the EDID may be hardcoded in ACPI or the VBIOS.

In this case, use GPIO_DDC_LINE_UNKNOWN and don't fail.

Fixes: def3488eb0fd ("drm/amd/display: refactor HPD to increase flexibility")
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5192
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                | 2 +-
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c | 3 +++
 drivers/gpu/drm/amd/display/dc/link/link_factory.c | 4 +++-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 50ec5acb6c7b7..0ad654775fd4b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1683,7 +1683,7 @@ struct dc_scratch_space {
 	struct dc_link_training_overrides preferred_training_settings;
 	struct dp_audio_test_data audio_test_data;
 
-	uint8_t ddc_hw_inst;
+	enum gpio_ddc_line ddc_hw_inst;
 
 	uint8_t hpd_src;
 
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
index 942d9f0b6df25..ae890765a1844 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
@@ -646,6 +646,9 @@ enum gpio_result dal_ddc_change_mode(
 enum gpio_ddc_line dal_ddc_get_line(
 	const struct ddc *ddc)
 {
+	if (!ddc)
+		return GPIO_DDC_LINE_UNKNOWN;
+
 	return (enum gpio_ddc_line)dal_gpio_get_enum(ddc->pin_data);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 765b731a12a44..75c0c1e7fc160 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -568,7 +568,9 @@ static bool construct_phy(struct dc_link *link,
 		goto ddc_create_fail;
 	}
 
-	if (!link->ddc->ddc_pin) {
+	/* Embedded display connectors such as LVDS may not have DDC. */
+	if (!link->ddc->ddc_pin &&
+	    !dc_is_embedded_signal(link->connector_signal)) {
 		DC_ERROR("Failed to get I2C info for connector!\n");
 		goto ddc_create_fail;
 	}
-- 
2.53.0

