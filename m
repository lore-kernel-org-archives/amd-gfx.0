Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A254FAD3E5
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 01:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D073C10EACA;
	Thu, 23 Apr 2026 01:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bFyEcHkq";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2555510EACA
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 01:16:25 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso24779385e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 18:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776906984; x=1777511784; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9ufsw7/WVlksgnt/Mbk19LcDbxwogEIQ/h18zwY5ow=;
 b=bFyEcHkqsWqzQ92KUX/KLF6Vpi2YoGOjdL2r0zAvPnbVtr83JO5TNQOAFlexrneoS+
 cXTlXA7H/lyNpVDUfGYJYnmyIywbV25laP8wFDb0NY5tFgwz56UmQuQXrY9SPvnuEPEc
 oeIjFnFIfVG9NjlIHNxp39DP0pN4aBebxv4TgoGeA3i0Io1JrcJBGt4FHaXnT6sLx8dl
 v1dzkHZspeDXCY6Vj/qPAN/n3HYma57fz4E4dCgs+bt39WOV2YBkm4D6ZarZAp87E3TH
 iNgZ1kLOMw/dygNl5nYNWlog8BT8v4lB0ghQEB79Ua3RTissUiS3VXswCzyOnxjE32OJ
 sxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776906984; x=1777511784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+9ufsw7/WVlksgnt/Mbk19LcDbxwogEIQ/h18zwY5ow=;
 b=ChNGDIUd1id6kI+NwrF/t3R3EyZykPMxCVCK8ZfShIWMP0pNfLd0cP36PbdTb6o6EC
 EwIK9YqbqM16T0cO8TfDKu0z5bKLX1LTr7ej/ClShI7GfNx2ubqH0o7RnsYAjlLqg8l9
 J7btCDHfD0hnTX5T1N9ZE0WiSzJDn0JxZATcDqjLi2FJSl9xHpVeZUaeTUDk29pPrDFF
 JQF61apyeNDPyf4gNaPHXWZnPGWFjvDPQ2Lgfsx6q5Q37JS0SRYjO80XjIoDkMJUA5xY
 Wj52r5YxuoclhAej8GM3cCi4oUuZdj3hlCHpU9si5YKlyKgynB8XcHT1lePuazBgsZB7
 R9LA==
X-Gm-Message-State: AOJu0YyDoLvEsYUOo8gzpbxHCEEt6YlIPj5YeKjiMfDgxo4BZ8qI93Z8
 TGpy6L2X+ev7NaI5g8Zbq72ZJ95o7THgXtv9zjCtwxfDot2NocldMV+MTCJYKQ==
X-Gm-Gg: AeBDiesZNPWM7uKBJal9sxaPG7InhiBm/1FTVQF3xVbOtnX4P7WmnuW5lqY3RVU5bUw
 ceeP5XvVZF+dVjHpGoOtpzoHhUKBaEEq8X34NXod9HzBCzaWVoiIngArQGOtrM01/AQiAc1dmkM
 1bVvLLJm6I9Sc69vDAtECRsLJp2Mq7yReZ05MJqEknXMlR0BZ9BY5478D1J0cfWrvauc26LNphy
 +s+wq0Tsz0wP9qRTSlcoRotgWsZcaRWkPgqWBBsCVjtZXFYS4m88hRgdE6TYqBWfew5QKWlohJH
 qIswzb6FM7DTnuBxI9tMAFhr73BVMiB9fYbd/32/wveis6/oJcSp9tGWWFoHTA9OfZYJ1H5ZDV1
 OX2zNY1Av3gXYytVwPMDpotK849bihX2SqVpPDYeBfKXH8QGa2efedR9sYMWRV9kaDTuG2dwUlo
 zH39hiBFzo/JGO3zhGA4n2xyJuPx8kQJGDiiCUjp3g3gi/+k/oUm9rYeMFTrT1sc4X17ANzpIyf
 RNeKw==
X-Received: by 2002:a05:600d:b:b0:48a:56de:d63c with SMTP id
 5b1f17b1804b1-48a56dedadfmr89445755e9.27.1776906983565; 
 Wed, 22 Apr 2026 18:16:23 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a4b329542sm370664435e9.3.2026.04.22.18.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 18:16:22 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, John Olender <john.olender@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 06/11] drm/amdgpu/vce1: Fix VCE 1 firmware size and offsets
Date: Thu, 23 Apr 2026 03:16:09 +0200
Message-ID: <20260423011614.309180-7-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423011614.309180-1-timur.kristof@gmail.com>
References: <20260423011614.309180-1-timur.kristof@gmail.com>
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

The VCPU BO contains the actual FW at an offset, but
it was not calculated into the VCPU BO size.
Subtract this from the FW size to make sure there is
no out of bounds access.

Make sure the stack and data offsets are aligned to
the 32K TLB size.

Check that the FW microcode actually fits in the
space that is reserved for it.

Fixes: d4a640d4b9f3 ("drm/amdgpu/vce1: Implement VCE1 IP block (v2)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index 92c3cf3fce4f0..c8e7297fd7ca3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
@@ -42,9 +42,10 @@
 #include "oss/oss_1_0_d.h"
 #include "oss/oss_1_0_sh_mask.h"
 
+#define VCE_V1_0_ALIGNMENT	(32 * 1024)
 #define VCE_V1_0_FW_SIZE	(256 * 1024)
 #define VCE_V1_0_STACK_SIZE	(64 * 1024)
-#define VCE_V1_0_DATA_SIZE	(7808 * (AMDGPU_MAX_VCE_HANDLES + 1))
+#define VCE_V1_0_DATA_SIZE	(ALIGN(7808 * (AMDGPU_MAX_VCE_HANDLES + 1), VCE_V1_0_ALIGNMENT))
 #define VCE_STATUS_VCPU_REPORT_FW_LOADED_MASK	0x02
 
 static void vce_v1_0_set_ring_funcs(struct amdgpu_device *adev);
@@ -189,17 +190,22 @@ static int vce_v1_0_load_fw_signature(struct amdgpu_device *adev)
 {
 	const struct common_firmware_header *hdr;
 	struct vce_v1_0_fw_signature *sign;
-	unsigned int ucode_offset;
+	u32 ucode_offset;
+	u32 ucode_size;
 	uint32_t chip_id;
 	u32 *cpu_addr;
 	int i;
 
 	hdr = (const struct common_firmware_header *)adev->vce.fw->data;
 	ucode_offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
+	ucode_size = hdr->ucode_size_bytes - sizeof(struct vce_v1_0_fw_signature *);
 	cpu_addr = adev->vce.cpu_addr;
 
 	sign = (void *)adev->vce.fw->data + ucode_offset;
 
+	if (ucode_size > VCE_V1_0_FW_SIZE - AMDGPU_VCE_FIRMWARE_OFFSET)
+		return -EINVAL;
+
 	switch (adev->asic_type) {
 	case CHIP_TAHITI:
 		chip_id = 0x01000014;
@@ -231,7 +237,7 @@ static int vce_v1_0_load_fw_signature(struct amdgpu_device *adev)
 	cpu_addr[4] = cpu_to_le32(le32_to_cpu(sign->length) + 64);
 
 	memset_io(&cpu_addr[5], 0, 44);
-	memcpy_toio(&cpu_addr[16], &sign[1], hdr->ucode_size_bytes - sizeof(*sign));
+	memcpy_toio(&cpu_addr[16], &sign[1], ucode_size);
 
 	cpu_addr += (le32_to_cpu(sign->length) + 64) / 4;
 	memcpy_toio(&cpu_addr[0], &sign->val[i].sigval[0], 16);
@@ -312,17 +318,22 @@ static int vce_v1_0_mc_resume(struct amdgpu_device *adev)
 	WREG32(mmVCE_VCPU_SCRATCH7, AMDGPU_MAX_VCE_HANDLES);
 
 	offset =  adev->vce.gpu_addr + AMDGPU_VCE_FIRMWARE_OFFSET;
-	size = VCE_V1_0_FW_SIZE;
+	size = VCE_V1_0_FW_SIZE - AMDGPU_VCE_FIRMWARE_OFFSET;
 	WREG32(mmVCE_VCPU_CACHE_OFFSET0, offset);
 	WREG32(mmVCE_VCPU_CACHE_SIZE0, size);
 
 	offset += size;
 	size = VCE_V1_0_STACK_SIZE;
+	WARN_ON(!IS_ALIGNED(offset, VCE_V1_0_ALIGNMENT));
+	WARN_ON(!IS_ALIGNED(size, VCE_V1_0_ALIGNMENT));
 	WREG32(mmVCE_VCPU_CACHE_OFFSET1, offset);
 	WREG32(mmVCE_VCPU_CACHE_SIZE1, size);
 
 	offset += size;
 	size = VCE_V1_0_DATA_SIZE;
+	WARN_ON(!IS_ALIGNED(offset, VCE_V1_0_ALIGNMENT));
+	WARN_ON(!IS_ALIGNED(size, VCE_V1_0_ALIGNMENT));
+	WARN_ON(offset + size > amdgpu_bo_size(adev->vce.vcpu_bo));
 	WREG32(mmVCE_VCPU_CACHE_OFFSET2, offset);
 	WREG32(mmVCE_VCPU_CACHE_SIZE2, size);
 
-- 
2.53.0

