Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4B3CA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 22:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60B8810E590;
	Mon, 25 Aug 2025 22:10:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aFX8RIrY";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C47410E590
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 22:10:50 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-45a1b05fe23so28382885e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 15:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756159849; x=1756764649; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0JHmKA/+o/pItfttoTrFfAne2Hy98BToRQOkwj9K93I=;
 b=aFX8RIrYC66d1fqBDkL1Cxo0AkA42tEVlSqpYoPAz1iASrE73/ytAe5r2Wg30Dd/ei
 1wxFxDIaj/OtC1WJInoJcnlRBoqtA584lzkNhzdbJ4/pXa/r2KklGB21J3buNL6Xy5X/
 /WaA6ThaFS7mRpoOhHLER6mYxVmY3AmqfMwGdTpQ7/QuzgrQ3h8O5mgMgYXcpn3c7zDO
 oL1tX5p99/DK/uwxn0R3gtK6Qw1CG8RS2C+3PAjsAQzU3K6NAcFi4JjFC6NVBktBam5q
 iEE0JK0QgvqzPUFyxcZlKxYoFrXfy8C2XeHeVUGQHbATYTYZfH8wtBiiiopJpfU5GHPQ
 cedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756159849; x=1756764649;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0JHmKA/+o/pItfttoTrFfAne2Hy98BToRQOkwj9K93I=;
 b=pnXMzitRwApyAh9Fp5oFrqrJ/sPlq270gaL1S28vZme79445frlUrM5M0FG8CkwQnK
 fJO5IBeLyJ7n7UkuBA+u5UJqhoeI0I/E4UsYMhUis/up9O40w29ZQoz5LlqHZ9jN1xMJ
 /oDfGVTAW33jGOyyQVXL7/IbK3eTsotee2wxTdumstA/3LzcQrSvFZHywvcPKZq5WW/w
 Ut5zeBvklWubhozAsJI2oONb7M77D5TDvc+XvigS4hJ3dBsKKyYgQ+fdPzUiqLxk87uV
 Xyf0hayVCP48cH2SdxXXjD/QwvKtJrxs1avXDdlTfXq1i0Toc6fY9Etz78N1DvlrI77P
 3hQQ==
X-Gm-Message-State: AOJu0YytDoXiOxS6QCqia3sJgfSCXtNo875RLELnS70tDc7zCOpKZzcz
 4rWyG+YqmDx3YP8WAjH/Ptd3PBss5eYe5HudlWIuC0LnFRrL69lrYdmmaIKf2Q==
X-Gm-Gg: ASbGnctaPZ7aKatXq4E3GOY8Dbdw2UXLiFcHs6darAVkMiWRBeJs4p/eUYA2psuKuFK
 7daYbGBYYs36PGitkakKfh3xmQT3WejjAYctT3THwQzM523iEnPZWcgcG4p4Y5mYn88evPt7pmo
 ykl4YBa6nYRSm0X28VcSTIZtb4kZRxwrlk2De1tY6oL1/yMoZc8pfC+PZckwJZOY5NA5YmKH0ES
 mGDW1OWDV4TCnai2oz2S8dlTmBj4DRIlk10BrOordD40iNQia+9CVwbOJOtYyelH89FSl9b7Yik
 mlFWfiUvAUT3EFLwNcl6EZCMLPEt0vrs8nac15ZgntlpnHphODeSLUHPt0txjqHMdNrXyOQH9rE
 xYXEwrdNCaxqWvTL4L9Yrvvi3EULixpDz3pMiNQw3wdYCkiynqv89VCVipRpEgCs82nEjaYRahl
 Gj9Pmt4hEN6GCkY4Gv+Bf2/FVZUEQz2sSBz2n0
X-Google-Smtp-Source: AGHT+IHdmvA9O/2k54AGITUfgEuNAsg65L7izEoIBqE6t7xEa1H06q77syITALJsy4L6E8U4dKamtg==
X-Received: by 2002:a05:600c:1e8b:b0:45b:47e1:ef6f with SMTP id
 5b1f17b1804b1-45b517fabfbmr99911215e9.34.1756159849018; 
 Mon, 25 Aug 2025 15:10:49 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b5748e743sm126203485e9.17.2025.08.25.15.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:10:48 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, alexander.deucher@amd.com, harry.wentland@amd.com,
 alex.hung@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH] drm/amdgpu: Respect max pixel clock for HDMI and DVI-D
Date: Tue, 26 Aug 2025 00:10:46 +0200
Message-ID: <20250825221046.639289-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
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

Change the legacy (non-DC) display code to respect the maximum
pixel clock for HDMI and DVI-D. Reject modes that would require
a higher pixel clock than can be supported.

Also update the maximum supported HDMI clock value depending on
the ASIC type.

For reference, see the DC code:
check max_hdmi_pixel_clock in dce*_resource.c

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 5e375e9c4f5d..abcc4469cf57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -1195,12 +1195,26 @@ static void amdgpu_connector_dvi_force(struct drm_connector *connector)
 		amdgpu_connector->use_digital = true;
 }
 
+/**
+ * Returns the maximum supported HDMI (TMDS) pixel clock in KHz.
+ */
+static int amdgpu_max_hdmi_pixel_clock(const struct amdgpu_device *adev)
+{
+	if (adev->asic_type >= CHIP_POLARIS10)
+		return 600000;
+	else if (adev->asic_type >= CHIP_TONGA)
+		return 300000;
+	else
+		return 297000;
+}
+
 static enum drm_mode_status amdgpu_connector_dvi_mode_valid(struct drm_connector *connector,
 					    const struct drm_display_mode *mode)
 {
 	struct drm_device *dev = connector->dev;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
+	const int max_hdmi_pixel_clock = amdgpu_max_hdmi_pixel_clock(adev);
 
 	/* XXX check mode bandwidth */
 
@@ -1208,10 +1222,13 @@ static enum drm_mode_status amdgpu_connector_dvi_mode_valid(struct drm_connector
 		if ((amdgpu_connector->connector_object_id == CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_I) ||
 		    (amdgpu_connector->connector_object_id == CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_D) ||
 		    (amdgpu_connector->connector_object_id == CONNECTOR_OBJECT_ID_HDMI_TYPE_B)) {
-			return MODE_OK;
+			if (mode->clock > max_hdmi_pixel_clock)
+				return MODE_CLOCK_HIGH;
+			else
+				return MODE_OK;
 		} else if (connector->display_info.is_hdmi) {
 			/* HDMI 1.3+ supports max clock of 340 Mhz */
-			if (mode->clock > 340000)
+			if (mode->clock > max_hdmi_pixel_clock)
 				return MODE_CLOCK_HIGH;
 			else
 				return MODE_OK;
-- 
2.50.1

