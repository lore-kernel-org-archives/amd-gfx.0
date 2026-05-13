Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7F7CD4F25
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 20:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B892210F04D;
	Wed, 13 May 2026 20:04:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VW7N4Ew3";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F32710F046
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 20:04:26 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so64217755e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 13:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778702665; x=1779307465; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gqVPXuY4WMEFziOMD+NmgZEzJHc+x457xlV8nA30Rik=;
 b=VW7N4Ew3oVwmnxMlOjIpBGYviXqdUnBYQD1RWl/KwYDB7RlGMC/jqkq2F42gkaTbso
 tt5+DcrZ6JD15x662SC3kXEVXWmw4BnxtquTIrc8OLVzj7O2BDSWuZL63q6GAfmVsiLT
 KEzEUzwc9u0koOB9BtNIb7H/l2rumCA0RCio3xSV7AfIkKhhDmUylZFQaZZHMO/FQRrz
 1aHGpd0huXpebQQH/CsGJ1E2TMSLWxec/HMzUsI0/q8/rmNNitK+uIGX+A3XYFQB0Pe4
 lWgg9RO6tdx6sKFHpl/tqFPBVLUvO4vpPAupc5tSrGgljpdyRtON5ps26Vwv5KGcgiec
 aGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778702665; x=1779307465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gqVPXuY4WMEFziOMD+NmgZEzJHc+x457xlV8nA30Rik=;
 b=ZV7J9YkD5V++XenPUmEioQLq+fw2iy3Za8RfhJIgkMszTMqRpKU/jHU0fSx+nM7aj8
 oMh6gwrtFoqRwxMFdyJAjpxZoUnpPKeZfujjza/+wIuMZmeyx8ZnTCBf8JphRoFb81Rc
 oQ03DvOwMIPE5RXinha36lvGhttH3UnAyzHM7L4rq0lqS0haBTwHQ1C0dHWv4ML3vkfF
 Wj2TUING2W3tPQp5uikw9uCWlCa65+TlyqBC/ZoXj45EFFxm3t/sGrt5NBWbPLlDCfuI
 rT5AVEcZQJFF2N3imvOcZWwulXjbKZlLWa1Z9k+G1B2vCkgfUXoD8xbp3NRAZMPzeh0F
 G5Tg==
X-Gm-Message-State: AOJu0YzAMY6TUyMoigiAcyrt8yVnT+2MwAsMcPYEReYF4KDHU4Hi4ieP
 fVeY2MDRUYypgwifMRtM3z3xiNz2XPwnOndl4MbGHlIbFdpZ42cCjJGxq69Rbg==
X-Gm-Gg: Acq92OFZdNCAVmj596p0gZqdGU/TzOLQEMHCRVr4i099N5KCj2kFS6SnW48uxvLJzj7
 YuwmROhIHYnO0zvuZqhBgXXTp5J9opBHoPHXZ/d36+6WfwNp4RhiPgDDQWpHmo9qwn3jRsJ7QIW
 /qGwm2QGM4fFvB/6WjKGFPgHhMPGo0r+YoTcp81wktqSuAXQGEffIPSCB7kkSdxmxmnLkq22wmF
 EoZpWS2Kvo25FGIOSqbiGN5iOd6w9dxtV9eqtrcEhuYnbyEZNyfNpPbMSC9xpWHYwF4bMCVRB0A
 32jOjnVuttJujbfy1WWscXcmNlqlkLLRnPy9FTdQkUXZOhdgtuz6WUn/Mxruo5Jvw26Zi7u1gzL
 Zi21yi7e+RxbKqT9467SkAiV3Jcu5zW1/diQSYoUHMvmunNZP5Gak0KKzhnrihUjN6dam+B7j8w
 OHUEqH9anabfortBZZIKG2Kg5qH4pX5m4SMb1a6mlFIDe4C0TWMeDawK7C9IlVgQqQ
X-Received: by 2002:a05:600c:45c8:b0:48d:35e:84a0 with SMTP id
 5b1f17b1804b1-48fcea151fbmr63708875e9.28.1778702664693; 
 Wed, 13 May 2026 13:04:24 -0700 (PDT)
Received: from Timur-Hyperion.home (540017BE.dsl.pool.telekom.hu.
 [84.0.23.190]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768c4fsm1257463f8f.8.2026.05.13.13.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 13:04:24 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 6/9] drm/amdgpu/vce1: Fix VCE 1 firmware size and offsets
Date: Wed, 13 May 2026 22:04:13 +0200
Message-ID: <20260513200416.35631-7-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513200416.35631-1-timur.kristof@gmail.com>
References: <20260513200416.35631-1-timur.kristof@gmail.com>
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
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index 92c3cf3fce4f..32ee6452f95d 100644
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
+	WARN_ON((offset + size - adev->vce.gpu_addr) > amdgpu_bo_size(adev->vce.vcpu_bo));
 	WREG32(mmVCE_VCPU_CACHE_OFFSET2, offset);
 	WREG32(mmVCE_VCPU_CACHE_SIZE2, size);
 
-- 
2.54.0

