Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC910CCF9F8
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Nov 2025 18:26:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41C3210E25A;
	Sun,  9 Nov 2025 18:26:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T89Sss1f";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EA1710E25A
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Nov 2025 18:26:52 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47755a7652eso15649675e9.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Nov 2025 10:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762712811; x=1763317611; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Trmaznl1Eh0NUXBAHNtFsV7QiT0dhzcFUzjn9ylYDhA=;
 b=T89Sss1f9v6/pphnX46jOzb+0KjrCxQuRT5c2sVCkd+fyse01YTRRXtK/ZtLITPDub
 tqYIH3y6+7J9QFIBOF9HUel+BGqN8PyNwlJixRHcTVX1bfRU4ofw7i3xnpikv2FpczUa
 uoq1bFjOSPWpbkJ6MoVZ+h7Pd27HSh7TiO2Mbg8fkVLhkZ8DJnSdSgM+d7QFLDdrdPWW
 5KzutdIQLyRhT9fpb5SM+tqFf+pWv0kaRoF5BL7oth3srkvu2hituGS9+JOvecPf1LQf
 8Kmgc/NLKNIIoU3xRdy13wZqNUGeo7sOt5tdjUE53f4qQZkq/TaY3ULFjXmpZUZav31q
 EZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762712811; x=1763317611;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Trmaznl1Eh0NUXBAHNtFsV7QiT0dhzcFUzjn9ylYDhA=;
 b=tsxwQKc3H+vN9jEgEVqaMt/Mhn8RwOkoVgq5nQBU8yOcF1sHkBAgZwm6a55FOaJwbq
 3UiNOrfpMwFbXfub9hhw5x189Lr7Fca3yG2RGO5y/F6lv0vrZH503U63gcbHBuFZ0BC0
 LPikIGM4W+Z6fdfFOX5xf/DbP5rmlPeS0Rwtthi90UlEHuwZAACd8n7APtBURCzIWq9D
 Wx8aeDsEt2mFMtCkm9c5PUdC3EOfP2+BXOv5x0PrKgn+4G7UVC60o1QMikdrl5RsFb2R
 D8xxFUxUUPHLMl0GDDWxNu01FJSsbU9dHIr0tqbI3lvKb3dMf6XLHwOTTyudJr9Ko9e9
 HBDA==
X-Gm-Message-State: AOJu0YwVexIjANv+XnTmBR6zcHjY2ymlaZT1WWOXhb7M7/It0ECLWxeV
 ZsXYWNiWZUJr6zSf5ioT/bnnELZWbhWaCRYW3TcK0El6WkhLQDff6dJWkT96YA==
X-Gm-Gg: ASbGncsxXDIDg+ULNCKgfH8U0MO6VkMAa88CQyUZYHLh7/+yP1+yzUYGddopWRtN+Yd
 WhfppfB6lTrmoI9Di9imPcDAUxvhqEuQzh5QR2bZjiKNLKVUn9UwhFdADO8WMGTgiz0LaiLCoCc
 51UWqpL3NjJsQIBMqYsdOdFDTBUs9AEMaiqzvStPRc1AP9PQf7wJPqgr/KvGNPTI4PABwztQgi4
 GTKDr6sMlm1B/bVrwn/2mDNsmBlE/tmp5gxYD+GLl5fVA+QGQyZBHwr0n246wGnv07kR3s25D05
 fhhT1OTHncS5Gd4HoLtpbWB0N18OLpH2mlGzB1WapO31vcsK3uu2yyJOF28hkpXxHDY0I4siPlo
 gHAl/XqubZMJy0p0z4lisYUv3y6DTYCca/iT5kEn5zhxwh6SMxrGCIpDnDY0A8YwYyD8EvJs4DZ
 /LFKSfgo5pym4hmuftsu8EdMBCXre+00Bd5uVwwo0=
X-Google-Smtp-Source: AGHT+IE2VtG4y91FwvpJJ5o6kgFcvdr1ZBtuR65ZVQsKZfrqRDWW835IujhHMJmxgzjyWsUHTK2y+A==
X-Received: by 2002:a05:600c:3511:b0:475:e007:bae0 with SMTP id
 5b1f17b1804b1-4777323ec8fmr34185395e9.16.1762712810497; 
 Sun, 09 Nov 2025 10:26:50 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24e1:af00:6cff:cfe4:4da7:ae2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4776bc82967sm161320085e9.0.2025.11.09.10.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 10:26:50 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH] drm/amdgpu: Use DC by default on SI dGPUs
Date: Sun,  9 Nov 2025 19:26:40 +0100
Message-ID: <20251109182640.58237-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.1
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

Now that DC supports analog connectors, it has reached feature
parity with the legacy non-DC display driver on SI dGPUs.
Use the DC display driver by default on SI dGPUs, unless it is
explicitly disabled using the amdgpu.dc=0 module parameter.

DC brings proper support for DP/HDMI audio, DP MST,
10-bit colors, some HDR features, atomic modesetting, etc.

Also clarify the comment about what is missing to have full
DC support for CIK APUs.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1e8725abcded..860ac1f9e35d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4249,24 +4249,13 @@ bool amdgpu_device_asic_has_dc_support(struct pci_dev *pdev,
 	case CHIP_PITCAIRN:
 	case CHIP_VERDE:
 	case CHIP_OLAND:
-		/*
-		 * We have systems in the wild with these ASICs that require
-		 * LVDS and VGA support which is not supported with DC.
-		 *
-		 * Fallback to the non-DC driver here by default so as not to
-		 * cause regressions.
-		 */
-#if defined(CONFIG_DRM_AMD_DC_SI)
-		return amdgpu_dc > 0;
-#else
-		return false;
-#endif
+		return amdgpu_dc != 0 && IS_ENABLED(CONFIG_DRM_AMD_DC_SI);
 	case CHIP_KAVERI:
 	case CHIP_KABINI:
 	case CHIP_MULLINS:
 		/*
 		 * We have systems in the wild with these ASICs that require
-		 * VGA support which is not supported with DC.
+		 * TRAVIS and NUTMEG support which is not supported with DC.
 		 *
 		 * Fallback to the non-DC driver here by default so as not to
 		 * cause regressions.
-- 
2.51.1

