Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A59CCFA18
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 15:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5978B10EB03;
	Fri,  7 Nov 2025 15:58:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gmjPOJP+";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 613AE10EB01
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 15:58:01 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4775638d819so5319575e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Nov 2025 07:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762531080; x=1763135880; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ctNyePx+bWoNx3CbPtflTXDFY5hEqX/IRcGoXNIa4VU=;
 b=gmjPOJP+MGjKAKk6XsuJvmC9wnTkw27gVLcGkAiRERNUPYqmxI8kHpx/TdEUJ52meQ
 3op8TkZZTGNqKaxQDyroc7XpxpWxBzxa9yaonsSHlzBfNliUh0YaS3AP5usyW+ab1kfl
 wwcLvQGtHiF4J97BpXhVFPZXF5bcH0XJgxkvBCpw9a757QgUxhsjzvFnZRrH2n1TD0aE
 mDifahSOe9digWYR3E2DyCHr1KiKriWug72p2xVWfI3cYBZGYrg7bNZuk3UPS4f8EtC7
 dr20yIT0TxQ5uUlzfWsGljaj3NmSFhwldGo6zmYk7zO/rM0AmD8EYfWlyEDNJEJjgAED
 xYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762531080; x=1763135880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ctNyePx+bWoNx3CbPtflTXDFY5hEqX/IRcGoXNIa4VU=;
 b=TsQnq90TNxjkaIsC83qKKArzgr+1SSy8aGa+GFQrb3g2XYhB+eklKrEk7e6k3Fybbr
 9Z+lmB+dAKG0ykZ9fEnmatK+h2cnA4ZebqiCdBEjc1Fpr49CNCQBdQ7e8lQZKdj93G60
 JNXRVxxpyRc1DE3HjZ8sSSQFCw5/HbxVwIMh4jorNMLfh8QltxN+o+NxiGyfrBRxBHz4
 FYzWQ2HPZeX/VZ7TFWwjZrLSMp+wXtNQ+BrDqfZdv7byMBYPLNoopk6faOuAxC51yzcE
 7qqVnvfHncNjktUE4JrgYY+UAarGLIvPAgoNsdV/eIuX7gEHTKKj3nhxNK9TusqAceeT
 wiFQ==
X-Gm-Message-State: AOJu0YyyCg/NlRMIx+U2dsLWRAREwKrVMjlFmcnJFtXU2JPLfqzHh/7w
 EgS1bv0SMumJAnpCySSew+Eg2WVscuzrn4NpCR9MYXMY4qY5E6476wEG3D8hPg==
X-Gm-Gg: ASbGncuNePQx/uWScgVMzOBOsH7x6rmt+Eu8VY8/nVKLj2zCvbFk/VAJev76NHgMcK3
 ML/vHbWKAM1Ss4no7wTs3mYKJXH8DJMY5h4IIUa/KJpb3qCuD3ZfI7Te1N3PpFE4EcPf9k4LT+j
 aICdtcNok0A5SVmgUkNpn//ff5BPibe/RontkJG8Go2W5gImb+m+FiqjmnkExFD3ypN0EnH+5I0
 fGJeRHE6XOG3sdj3+zzO8PDl+G5+y4YMMH6Y3glHh0MQG1/MKCuO+rAHi2RofBp2BO7K9hB4ezW
 R9DDgeqCBG/lA4Cpw9TeOjIV8w1kB6kNOc3h5k40mZKU7MtWUy1GnzJtOzEnFc+sJd66EegsR9F
 fUjxcwU5SgXukojBn+WA7O/KtYLwcr38PqB4EcGt5EUzAPSnRc+JEss23K33OYC7CCNAS3ZFyAC
 OH4Xv+LIHzVAfvpOMjpnI=
X-Google-Smtp-Source: AGHT+IFyF5yKtnA0ZSxwupRkw1z45lvKdeyU70lBBfF29Pd/bYXXAdrNUlQ8y6W3Q1qw0TLUU+lM1A==
X-Received: by 2002:a05:600c:4fd5:b0:477:557b:6926 with SMTP id
 5b1f17b1804b1-4776bc8d908mr29939955e9.10.1762531079711; 
 Fri, 07 Nov 2025 07:57:59 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775cdc33c8sm170266365e9.2.2025.11.07.07.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 07:57:59 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 07/12] drm/amdgpu/vce1: Load VCE1 firmware
Date: Fri,  7 Nov 2025 16:57:40 +0100
Message-ID: <20251107155745.8334-8-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107155745.8334-1-timur.kristof@gmail.com>
References: <20251107155745.8334-1-timur.kristof@gmail.com>
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
index 3a986e3589a5..7fead2eebd36 100644
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

