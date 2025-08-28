Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FFECA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 14:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9AD310E9FE;
	Thu, 28 Aug 2025 14:50:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JIJH7wNh";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BC2510E9FE
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 14:50:42 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-45a1b0bde14so6519165e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 07:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756392641; x=1756997441; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k7O3sk+FK4NXBkeENeEOSw7BRtGcWLsUIYhRkNP4gnw=;
 b=JIJH7wNh2RpfSPPfMV1kHjrxM2lJM4CI8Lkgc6aF886MnbZU4zmAnQDdp2qzXuhmtT
 QaS0RcJoxlXf14EikM7SNS4hcOdyyAiSib2BV6goji9Hvd8bpl/lWwZRkWjBp9vzqSuv
 M1I6xAjxxmaUDY04s1skd48xuW8j2IV1sMKvhKhGhjX4BMFgZ5DHKndD5RWxwvJaDfhF
 2INysrMHYVepf9abeStY/iUvzwCNQ+WWxzuwjNwBNHxQZlNn2mE7zMhhM1sLjR7gfZ+Y
 dGXG1f9UQibwArhJquE0FA2pLEnbcv/sNJyHa47vgKn2Q6md+Q1nUTo2h9DsQY3VAjFr
 rHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756392641; x=1756997441;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k7O3sk+FK4NXBkeENeEOSw7BRtGcWLsUIYhRkNP4gnw=;
 b=qU2C94Oo82hiVT6TyNId73HzAb4LbpfVchsajeyzK2aL2NNQKbFLZsNIiauCVYuD9q
 8rDd0hIoHr/gjsHoE/g3e2QZOBxWELV3ZijlJ7tIo/KiUAPWc7h6ps0dQ85th/aosoEO
 AA8cyYoQK3A1ICLWcK+TtCiniYR9vHz7kun9Gr+5YwLIlaXIpyPtEiNFAREXXoPUx5by
 iW+avUvaUdcpHlPcVGpbPfQle+4ToiT63Xd2m97HNJISOtVefWIYD6L7Zc535JLwkQC9
 Jrq7POEWjdgndwmCOi+nM8z3bwnZU1n24R4xJqaZMICEkn8Cu6bYBZTosV1QtIJwVTUy
 e6LQ==
X-Gm-Message-State: AOJu0YxkbOuim0CIdzQbj5FNnJpefctgXRUTxXmurxwaKneEpZCWlgmd
 6yALJPW/WXrdhoOycv+L5tcS4FURLFnVoXNrXZS4/xFI9hDb6uAY76x/kUJk4w==
X-Gm-Gg: ASbGncur/+vDDPm36c40Fmb6+blMZ0BvcR2zeFKl8X6fpLh0rkZOZzcw0+AOCN9RmtR
 4uJzvkBkUdAXgBdGAlCbXyKrmq1lxnx5qjqRkl6wSaqLS43P0Mzdv1AiZoDGSECF24Z41qGUC5G
 EyYZ3teJmp6KTHmdYUL0IX/thLXQoRot2rKxONcVDmNLC5Uy8Jb9gwt/1W9dWJuDue7vNEJql7S
 fr/k7W7K+fvkK8oWZVRujnYjI8FLRnMjYpPx7FV1g5AQsHR5M3knOZPmMnxjIZ8MBA8iEIE0zc1
 120X+mSthR7EpsVY9/3kyOOY4X9jj0sTUgWgaysIfROmnot1VAQvPTQbVodVmUHjrbk42z+BxVC
 TzlWUKw6rKMQk3qs61TMamzlPKEqTESj5k8B2r+AfKW9vBqZ72VqgdvvF0GrNfJUWXFQ5EjqAiT
 H1Msw4og2lZGILWDj0rPIaJd9HhF++Yoc8Cxev
X-Google-Smtp-Source: AGHT+IFNu3Vw4uzfgTRAOQaAdcHcPfUy3c2OfWiSEzcrxmiCcrsEEMKrX/iqxojGh2OBLG3spiaZbg==
X-Received: by 2002:a05:600c:19cd:b0:456:db0:4f3d with SMTP id
 5b1f17b1804b1-45b517b9571mr251805175e9.24.1756392640293; 
 Thu, 28 Aug 2025 07:50:40 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cd5997658fsm5193138f8f.46.2025.08.28.07.50.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 07:50:39 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, harry.wentland@amd.com, alex.hung@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH] drm/amdgpu: Respect max pixel clock for HDMI and DVI-D (v2)
Date: Thu, 28 Aug 2025 16:50:36 +0200
Message-ID: <20250828145036.6853-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Update the legacy (non-DC) display code to respect the maximum
pixel clock for HDMI and DVI-D. Reject modes that would require
a higher pixel clock than can be supported.

Also update the maximum supported HDMI clock value depending on
the ASIC type.

For reference, see the DC code:
check max_hdmi_pixel_clock in dce*_resource.c

v2:
Fix maximum clocks for DVI-D and DVI/HDMI adapters.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 57 ++++++++++++++-----
 1 file changed, 44 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 5e375e9c4f5d..a381de8648e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -1195,29 +1195,60 @@ static void amdgpu_connector_dvi_force(struct drm_connector *connector)
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
+/**
+ * Validates the given display mode on DVI and HDMI connectors,
+ * including analog signals on DVI-I.
+ */
 static enum drm_mode_status amdgpu_connector_dvi_mode_valid(struct drm_connector *connector,
 					    const struct drm_display_mode *mode)
 {
 	struct drm_device *dev = connector->dev;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
+	const int max_hdmi_pixel_clock = amdgpu_max_hdmi_pixel_clock(adev);
+	const int max_dvi_single_link_pixel_clock = 165000;
+	int max_digital_pixel_clock_khz;
 
 	/* XXX check mode bandwidth */
 
-	if (amdgpu_connector->use_digital && (mode->clock > 165000)) {
-		if ((amdgpu_connector->connector_object_id == CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_I) ||
-		    (amdgpu_connector->connector_object_id == CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_D) ||
-		    (amdgpu_connector->connector_object_id == CONNECTOR_OBJECT_ID_HDMI_TYPE_B)) {
-			return MODE_OK;
-		} else if (connector->display_info.is_hdmi) {
-			/* HDMI 1.3+ supports max clock of 340 Mhz */
-			if (mode->clock > 340000)
-				return MODE_CLOCK_HIGH;
-			else
-				return MODE_OK;
-		} else {
-			return MODE_CLOCK_HIGH;
+	if (amdgpu_connector->use_digital) {
+		switch (amdgpu_connector->connector_object_id) {
+		case CONNECTOR_OBJECT_ID_HDMI_TYPE_A:
+			max_digital_pixel_clock_khz = max_hdmi_pixel_clock;
+			break;
+		case CONNECTOR_OBJECT_ID_SINGLE_LINK_DVI_I:
+		case CONNECTOR_OBJECT_ID_SINGLE_LINK_DVI_D:
+			max_digital_pixel_clock_khz = max_dvi_single_link_pixel_clock;
+			break;
+		case CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_I:
+		case CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_D:
+		case CONNECTOR_OBJECT_ID_HDMI_TYPE_B:
+			max_digital_pixel_clock_khz = max_dvi_single_link_pixel_clock * 2;
+			break;
 		}
+
+		/* When the display EDID claims that it's an HDMI display,
+		 * we use the HDMI encoder mode of the display HW,
+		 * so we should verify against the max HDMI clock here.
+		 */
+		if (connector->display_info.is_hdmi)
+			max_digital_pixel_clock_khz = max_hdmi_pixel_clock;
+
+		if (mode->clock > max_digital_pixel_clock_khz)
+			return MODE_CLOCK_HIGH;
 	}
 
 	/* check against the max pixel clock */
-- 
2.51.0

