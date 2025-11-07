Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C627CCFA05
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 15:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B83510EB02;
	Fri,  7 Nov 2025 15:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SpuFv62y";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 899C210EAFE
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 15:57:58 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso9136875e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Nov 2025 07:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762531077; x=1763135877; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jwpv4mT1ZXGnAhAT/xXPcNnsxOfa9p2140bSUo4l4IA=;
 b=SpuFv62y8HAg7wR5XEUKB3Xq3sR0Y+2nrNztRyJmXcK6mhobOg7NAikqDSNfUEzTXE
 YvEa23RdmgczBaVo/PySaPRStXBoM3uacmQ85KqB9USMHNoE8YqbrpfjZhiXt/LFQR4G
 pk5u6ImM9vgLDzmoepWvEkvyyM3EIXtjMP3ADZZe8pXmwFFbfk2LBrQxMBHZIT/QbTgE
 4g7Csn+2QVRd+C3vkmbbemOcFCSb7lm+461a9ZUgLXgRAfxWlgEGJPDVaT6DiHvnbcDN
 KKxVe1m5CioMPuvVVUyuyGY++9BUhEwZ70DK4mxZLZRlO2LDgp8BlOHDgM+XFVO20kSM
 L9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762531077; x=1763135877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jwpv4mT1ZXGnAhAT/xXPcNnsxOfa9p2140bSUo4l4IA=;
 b=htpP0nk+zjnQW4KZ7ZLyiUnpDAboWMAPYb1GLOWPN0VhTqJoFT8ZPwwYJaM30N0GAx
 JZ7AlIS1MVfTV2p91lveSeJXF62EvHlXhxi/QwrZiLTfG9RYDZdcSFJyyI//16MH4BAg
 BodAzy0IzUa61g0M/+pjvSkDAHxmLgkgVgQ5qOD1kuQB+3RJc/PesBS4x2hTYg1gdFOl
 SzJHBbrzWalK7S900xntntTc/95S+UjrSp9TJmZK9s7SRnjAIr8Pw0YQ3uJbqlOE5iDp
 vgWXframLqPW/aQUlgPuXsmXrcmAyC3LT3Egt1BgSpK4pCcB2RmJDM8cjX4NN1RqSLLi
 eH5w==
X-Gm-Message-State: AOJu0YxvsDaEmyv7hAwk0HlXLqoztc+FeIAGQnYz+p+bcYwTydpgeC1s
 EkgyE4qGSscJgIEAxqTQc/Lppog9ONdp0yMIoxdCMxLqqaCVsIoEdL2548reAg==
X-Gm-Gg: ASbGncvBMjEnvX/kZQ8f6A3XuxcTU/nec+HYmQ9JmbhkulxgVIjzZRagL7GXvMFulyP
 xbyXiwqPJwmbUdhdmt16MVFV8HmY9/FqaB4weyXVtWmw5cjZS6Uby+hzActMdV4xnnlXxiL2yfn
 T9nrMoPbAtL/g07ElWN3NvFZN2j3R2m30+t3oEdx0DIZjon7ftaGSltlyljbETJxCcPF6yg8kiF
 u6FCbBi4BzMV87uBoo9jIlQNCQfgWct30MRJw90BiSQg9qgovITgaee2cuFex7KfwufPmQL+cjM
 YzlyUmNJd/ICZKR5dGqA70iu81HUCXFQClpwIfdosFl1ZkZneFxZpCOVrtW+v5sifkA9RmCR5On
 4EJsL8GEHWQgG8KIwPyPq+abQoMf/NQWricI46xblcJo36lLSdLuX2zMdvfk3TyaoSURJ+rVoz7
 Rx/6W6Dz4A359Z9rzaSpA=
X-Google-Smtp-Source: AGHT+IHz7qEiZGdJHCgQYjawlExOXAxiDFXnrB4GV+RZpCjCLLWX5tlUS8CfOsYHhF3ZZoOKoku5Vw==
X-Received: by 2002:a05:600c:1e8b:b0:46e:1a5e:211 with SMTP id
 5b1f17b1804b1-4776bcb8977mr32610415e9.21.1762531076956; 
 Fri, 07 Nov 2025 07:57:56 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775cdc33c8sm170266365e9.2.2025.11.07.07.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 07:57:56 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Cc: Leo Liu <leo.liu@amd.com>
Subject: [PATCH 04/12] drm/amdgpu/vce: Move firmware load to
 amdgpu_vce_early_init
Date: Fri,  7 Nov 2025 16:57:37 +0100
Message-ID: <20251107155745.8334-5-timur.kristof@gmail.com>
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

Try to load the VCE firmware at early_init.

When the correct firmware is not found, return -ENOENT.
This way, the driver initialization will complete even
without VCE, and the GPU will be functional, albeit
without video encoding capabilities.

This is necessary because we are planning to add support
for the VCE1, and AMD hasn't yet publised the correct
firmware for this version. So we need to anticipate that
users will try to boot amdgpu on SI GPUs without the
correct VCE1 firmware present on their system.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 121 +++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h |   1 +
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c   |   5 +
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c   |   5 +
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c   |   5 +
 5 files changed, 91 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index b9060bcd4806..c4e9d1862108 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -88,82 +88,87 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 				      bool direct, struct dma_fence **fence);
 
 /**
- * amdgpu_vce_sw_init - allocate memory, load vce firmware
+ * amdgpu_vce_firmware_name() - determine the firmware file name for VCE
  *
  * @adev: amdgpu_device pointer
- * @size: size for the new BO
  *
- * First step to get VCE online, allocate memory and load the firmware
+ * Each chip that has VCE IP may need a different firmware.
+ * This function returns the name of the VCE firmware file
+ * appropriate for the current chip.
  */
-int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
+static const char *amdgpu_vce_firmware_name(struct amdgpu_device *adev)
 {
-	const char *fw_name;
-	const struct common_firmware_header *hdr;
-	unsigned int ucode_version, version_major, version_minor, binary_id;
-	int i, r;
-
 	switch (adev->asic_type) {
 #ifdef CONFIG_DRM_AMDGPU_CIK
 	case CHIP_BONAIRE:
-		fw_name = FIRMWARE_BONAIRE;
-		break;
+		return FIRMWARE_BONAIRE;
 	case CHIP_KAVERI:
-		fw_name = FIRMWARE_KAVERI;
-		break;
+		return FIRMWARE_KAVERI;
 	case CHIP_KABINI:
-		fw_name = FIRMWARE_KABINI;
-		break;
+		return FIRMWARE_KABINI;
 	case CHIP_HAWAII:
-		fw_name = FIRMWARE_HAWAII;
-		break;
+		return FIRMWARE_HAWAII;
 	case CHIP_MULLINS:
-		fw_name = FIRMWARE_MULLINS;
-		break;
+		return FIRMWARE_MULLINS;
 #endif
 	case CHIP_TONGA:
-		fw_name = FIRMWARE_TONGA;
-		break;
+		return  FIRMWARE_TONGA;
 	case CHIP_CARRIZO:
-		fw_name = FIRMWARE_CARRIZO;
-		break;
+		return  FIRMWARE_CARRIZO;
 	case CHIP_FIJI:
-		fw_name = FIRMWARE_FIJI;
-		break;
+		return  FIRMWARE_FIJI;
 	case CHIP_STONEY:
-		fw_name = FIRMWARE_STONEY;
-		break;
+		return  FIRMWARE_STONEY;
 	case CHIP_POLARIS10:
-		fw_name = FIRMWARE_POLARIS10;
-		break;
+		return  FIRMWARE_POLARIS10;
 	case CHIP_POLARIS11:
-		fw_name = FIRMWARE_POLARIS11;
-		break;
+		return  FIRMWARE_POLARIS11;
 	case CHIP_POLARIS12:
-		fw_name = FIRMWARE_POLARIS12;
-		break;
+		return  FIRMWARE_POLARIS12;
 	case CHIP_VEGAM:
-		fw_name = FIRMWARE_VEGAM;
-		break;
+		return  FIRMWARE_VEGAM;
 	case CHIP_VEGA10:
-		fw_name = FIRMWARE_VEGA10;
-		break;
+		return  FIRMWARE_VEGA10;
 	case CHIP_VEGA12:
-		fw_name = FIRMWARE_VEGA12;
-		break;
+		return  FIRMWARE_VEGA12;
 	case CHIP_VEGA20:
-		fw_name = FIRMWARE_VEGA20;
-		break;
+		return  FIRMWARE_VEGA20;
 
 	default:
-		return -EINVAL;
+		return NULL;
 	}
+}
+
+/**
+ * amdgpu_vce_early_init() - try to load VCE firmware
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Tries to load the VCE firmware.
+ *
+ * When not found, returns ENOENT so that the driver can
+ * still load and initialize the rest of the IP blocks.
+ * The GPU can function just fine without VCE, they will just
+ * not support video encoding.
+ */
+int amdgpu_vce_early_init(struct amdgpu_device *adev)
+{
+	const char *fw_name = amdgpu_vce_firmware_name(adev);
+	const struct common_firmware_header *hdr;
+	unsigned int ucode_version, version_major, version_minor, binary_id;
+	int r;
+
+	if (!fw_name)
+		return -ENOENT;
 
 	r = amdgpu_ucode_request(adev, &adev->vce.fw, AMDGPU_UCODE_REQUIRED, "%s", fw_name);
 	if (r) {
-		dev_err(adev->dev, "amdgpu_vce: Can't validate firmware \"%s\"\n",
-			fw_name);
+		dev_err(adev->dev,
+			"amdgpu_vce: Firmware \"%s\" not found or failed to validate (%d)\n",
+			fw_name, r);
+
 		amdgpu_ucode_release(&adev->vce.fw);
-		return r;
+		return -ENOENT;
 	}
 
 	hdr = (const struct common_firmware_header *)adev->vce.fw->data;
@@ -172,11 +177,35 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
 	version_major = (ucode_version >> 20) & 0xfff;
 	version_minor = (ucode_version >> 8) & 0xfff;
 	binary_id = ucode_version & 0xff;
-	DRM_INFO("Found VCE firmware Version: %d.%d Binary ID: %d\n",
+	dev_info(adev->dev, "Found VCE firmware Version: %d.%d Binary ID: %d\n",
 		version_major, version_minor, binary_id);
 	adev->vce.fw_version = ((version_major << 24) | (version_minor << 16) |
 				(binary_id << 8));
 
+	return 0;
+}
+
+/**
+ * amdgpu_vce_sw_init() - allocate memory for VCE BO
+ *
+ * @adev: amdgpu_device pointer
+ * @size: size for the new BO
+ *
+ * First step to get VCE online: allocate memory for VCE BO.
+ * The VCE firmware binary is copied into the VCE BO later,
+ * in amdgpu_vce_resume. The VCE executes its code from the
+ * VCE BO and also uses the space in this BO for its stack and data.
+ *
+ * Ideally this BO should be placed in VRAM for optimal performance,
+ * although technically it also runs from system RAM (albeit slowly).
+ */
+int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
+{
+	int i, r;
+
+	if (!adev->vce.fw)
+		return -ENOENT;
+
 	r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
 				    AMDGPU_GEM_DOMAIN_VRAM |
 				    AMDGPU_GEM_DOMAIN_GTT,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
index 6e53f872d084..22acd7b35945 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
@@ -53,6 +53,7 @@ struct amdgpu_vce {
 	unsigned		num_rings;
 };
 
+int amdgpu_vce_early_init(struct amdgpu_device *adev);
 int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size);
 int amdgpu_vce_sw_fini(struct amdgpu_device *adev);
 int amdgpu_vce_entity_init(struct amdgpu_device *adev, struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index bee3e904a6bc..8ea8a6193492 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -407,6 +407,11 @@ static void vce_v2_0_enable_mgcg(struct amdgpu_device *adev, bool enable,
 static int vce_v2_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int r;
+
+	r = amdgpu_vce_early_init(adev);
+	if (r)
+		return r;
 
 	adev->vce.num_rings = 2;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 708123899c41..719e9643c43d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -399,6 +399,7 @@ static unsigned vce_v3_0_get_harvest_config(struct amdgpu_device *adev)
 static int vce_v3_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int r;
 
 	adev->vce.harvest_config = vce_v3_0_get_harvest_config(adev);
 
@@ -407,6 +408,10 @@ static int vce_v3_0_early_init(struct amdgpu_ip_block *ip_block)
 	    (AMDGPU_VCE_HARVEST_VCE0 | AMDGPU_VCE_HARVEST_VCE1))
 		return -ENOENT;
 
+	r = amdgpu_vce_early_init(adev);
+	if (r)
+		return r;
+
 	adev->vce.num_rings = 3;
 
 	vce_v3_0_set_ring_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 335bda64ff5b..2d64002bed61 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -410,6 +410,11 @@ static int vce_v4_0_stop(struct amdgpu_device *adev)
 static int vce_v4_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int r;
+
+	r = amdgpu_vce_early_init(adev);
+	if (r)
+		return r;
 
 	if (amdgpu_sriov_vf(adev)) /* currently only VCN0 support SRIOV */
 		adev->vce.num_rings = 1;
-- 
2.51.0

