Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1A8CCFA03
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 22:24:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7641110E4C6;
	Mon,  3 Nov 2025 22:24:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YRifLoXk";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67D7F10E4C6
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 22:24:15 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-640aa1445c3so3296918a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 14:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762208654; x=1762813454; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k6RUAT0t1x3yHypLmF5XTkG2D6h/5V21vKp2QHKfxFA=;
 b=YRifLoXk3gnQ0Ywg58pxB00ga4MR9uyiV3LzuUFW2bhh6ZnuSN+MtxE71Lw1nvk2Kw
 a0HXwIByni2DI+rwAutIKcDrDYb4QrTYELN0mSG29Vtr1mxfx3n1DJ6NVBJVVblEm7r1
 uGNl0AJgA0IGWK9DWZjoZjrPeE5PvZ1sXderMPSQdLnEUZCzoo2NPAdR02rxvq96Do0H
 UPHN+CSLwJa5W7woCH6B9byioCQas8S25+HMPbQVuElxG0gymA2KrmeEAdY9yzPWpDIW
 2QwEMMdQhJnOzvT7M5D6gE7+bmwhoWlTsc5P2cfo6NfyF+P6j7v/TjtBAu3nxdUIz930
 FdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762208654; x=1762813454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k6RUAT0t1x3yHypLmF5XTkG2D6h/5V21vKp2QHKfxFA=;
 b=jf379RPBc9kjtjf7Tkmy0uGNNbcUDU0ZqwvSXAhsYd9i7mQHlyuKNka3XQOIJlSl1a
 xrTUn6WutZzkHD9A+nyZ2H47EE3SUc5FZl4Fn51O0Qp80HxkPGeOel8FIcg86GH8Z/2N
 CJUXQN6fcXzKjPTXhpLO8I1TucPX92p6qbaTaWYSYGMGiQ4o1B154FUX4YVIFIL9kTIs
 NuozCcTtaR6qlrlKzJXII2fI6yh0i1s5H+KhMUAsNUZd8r88NN5f5CyFIC68Q9D5Xkm0
 oQQeKxC9OpsXMEgj9LxEF3o60mYredBdVw2plxTPuXVlcSbE3eYIGfix+XvOZI+3dnpO
 8YWA==
X-Gm-Message-State: AOJu0YxEquzZu3lxM0DYetMhfqnHsvKAb/QVVdMeJOwPYKF6HJ+4ECYF
 z8pba8jK8tw64h2O8WJO/YfCs1XLyCWsLwjvUSCBsoBih73Ov0QyU4TLMsc1dADe
X-Gm-Gg: ASbGncvifOweFu5XLK+p0mTPDG0dkUBfWpkfTPVMOm1lTVs/ir9zKwaWcFbdGFTpIqV
 VRWBH8wGhAbKti1cw+qBG31XWF0svIjkQbPVCi4uxjLqpf4arSnvVqTEhj+8L41kmppfEe2XCUe
 mVpH1clEPmtMHKGlL3FXkdGKNQm6Zg9W4VuzM0S3lqgsvjNCEsOK4vgEyQgO8bTxKTJHPBB1K2t
 W9J3k8b5Xe4GLTV2sBcIqolxKC0zT3gn6Gyl0dBKHVu5NlCXenc2Z9Al/vUVSjemyx+FC1Zq82x
 LumGygJk2t6OgIz2gL23A6p6W3bc+PlLm38uOgBEIPOTBImX/qD7CebiY+rXE3509UNV92xFDsT
 6E9XmSFeun0rFGF/GvW+kzqE4ZJVl5U1FZHFyE7PqOlQxeW0v+3BgZ/z7e4AfMkbgBo7Ywul50S
 ysJ/E1GvQj3Z5GfeACgbYpzLJYGMG/Zg==
X-Google-Smtp-Source: AGHT+IHLGCvhPdGgqxg/DBjaCtrHstaKHh0BlbUAePNNJts8iG2OxcXz0GL/ozuBjGlTZm9lUY+ojg==
X-Received: by 2002:a05:6402:51c8:b0:640:931a:7c2f with SMTP id
 4fb4d7f45d1cf-640931a7eabmr9147540a12.7.1762208653870; 
 Mon, 03 Nov 2025 14:24:13 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6a5cb5dsm486635a12.17.2025.11.03.14.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 14:24:12 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 11/16] drm/amdgpu/vce1: Load VCE1 firmware
Date: Mon,  3 Nov 2025 23:23:28 +0100
Message-ID: <20251103222333.37817-12-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103222333.37817-1-timur.kristof@gmail.com>
References: <20251103222333.37817-1-timur.kristof@gmail.com>
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

Load VCE1 firmware using amdgpu_ucode_request, just like
it is done for other VCE versions.

All SI chips share the same VCE1 firmware file: vce_1_0_0.bin
which will be sent to linux-firmware soon.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 4beec5b56c4f..2761c096c4cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -41,6 +41,9 @@
 #define VCE_IDLE_TIMEOUT	msecs_to_jiffies(1000)
 
 /* Firmware Names */
+#ifdef CONFIG_DRM_AMDGPU_SI
+#define FIRMWARE_VCE_V1_0	"amdgpu/vce_1_0_0.bin"
+#endif
 #ifdef CONFIG_DRM_AMDGPU_CIK
 #define FIRMWARE_BONAIRE	"amdgpu/bonaire_vce.bin"
 #define FIRMWARE_KABINI	"amdgpu/kabini_vce.bin"
@@ -61,6 +64,9 @@
 #define FIRMWARE_VEGA12		"amdgpu/vega12_vce.bin"
 #define FIRMWARE_VEGA20		"amdgpu/vega20_vce.bin"
 
+#ifdef CONFIG_DRM_AMDGPU_SI
+MODULE_FIRMWARE(FIRMWARE_VCE_V1_0);
+#endif
 #ifdef CONFIG_DRM_AMDGPU_CIK
 MODULE_FIRMWARE(FIRMWARE_BONAIRE);
 MODULE_FIRMWARE(FIRMWARE_KABINI);
@@ -99,6 +105,12 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 static const char *amdgpu_vce_firmware_name(struct amdgpu_device *adev)
 {
 	switch (adev->asic_type) {
+#ifdef CONFIG_DRM_AMDGPU_SI
+	case CHIP_PITCAIRN:
+	case CHIP_TAHITI:
+	case CHIP_VERDE:
+		return FIRMWARE_VCE_V1_0;
+#endif
 #ifdef CONFIG_DRM_AMDGPU_CIK
 	case CHIP_BONAIRE:
 		return FIRMWARE_BONAIRE;
-- 
2.51.0

