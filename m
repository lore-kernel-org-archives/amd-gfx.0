Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A56C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 11:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE9F010E436;
	Tue, 29 Apr 2025 11:24:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j9SCRZjH";
	dkim-atps=neutral
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7512610E436
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 11:24:32 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7be49f6b331so710403385a.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 04:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745925871; x=1746530671; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eI2j9jVoQs6Sn36RUeVfjg5IRrWpXCvWOriJJVa8/9w=;
 b=j9SCRZjHJc4dd1BW6sxdG5bFPKZJwFMTF+yEW8EUBxDP10wm1HtlkaJc2W7AxqEhir
 uASefOuRrM1fOjlF+iHVcBgktQqydbf/utASmjIwCGwvC3+TbbZ1UfPVzkFPAvXaxICw
 NeqPlSxQ0FgdCiOfSjtbkPEPmP7RQaE1lI2D/+XAMt8t6bO3+5rmhmhDs/jqzoC///lC
 dFrCzr5m3QqrZhCJGi/Oxoun3v5zVwCkqE+Y6Dj5giTMbpGcM3X3JukbE7sAlNJpQSv+
 DMbYm60KNxu0V6sO9Vp5BC/oGVTJD/Tuq3JvG9MGoW0bja5CmFMxtjLhFGcmE6TbkWNA
 0llw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745925871; x=1746530671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eI2j9jVoQs6Sn36RUeVfjg5IRrWpXCvWOriJJVa8/9w=;
 b=DFTdUPanFMcuC1nGuxz8E8g430Ha3vaYDgTp2DE9erXb5KXUjEjjzu3JmT1vYtRlrD
 GKsfz90CSgJt7MHCRhCOVK/JDFLCx4fGM9LEUy55Vb7BvMgRmiGrYDw8zlekttsH/l/8
 8WehEd9/UWvoehdv2U9Rkpf0wScLIh0JzUOlLbguuPX0hn46VstawMEWQT7IJz0WA4rQ
 tl9yI73dfZyLivMS2khky5VmQrswDSpVwA4jz09X5fRI3J2GbDhQztgLL0u2IVWs+yLT
 e6jPX8OlbgdPl7hQY1evcs9it5veDKh8PQAz8TxgbJ+ygFUlcW1BVIirxyoexxDjE/oo
 Yc6A==
X-Gm-Message-State: AOJu0Yzq/xscLADcF99p7FMyFxPyJgEmnwoIc2KnyT/0oZEScRnB1+2u
 1OrKEV7tfou3fUi2lkJGvIVSlK9CJ1HG97P/3y72a1lZGTBKDt1tdKrbzuDY
X-Gm-Gg: ASbGncuw/hj38eZ0uEu69IUdKhz+Smgfqyo6uDR1mBPNOOw/RcoQagk0WB2C33TfLA0
 CZRvi2WnMFXq3y9c04MznaIoB68V/tpdsYo5oSNzaVkApyD75BBBSmtSA851PEeHVgAt0Pxk1jX
 SU4hW1Hd34Jfz51Hep5zUoLP+SCMmNvYC7vBBEfrG7IauuauBYb/Q96rw3hkqkSHB246HupMZ2r
 7hFfIyN6i0cy6NXZ+XOhBjh9Vf2yRVaFmrSeu93j5yyI8/s5OBCwRb3dpZGox/TFdaNv+xeQZy4
 d5gCjoJa5wLJ8+3sWcS5BthRyfSSTybUYgUOtAd3WjWNoDcS1so=
X-Google-Smtp-Source: AGHT+IF7ESM9PzI+tMt/+U5h5zgGRsT2gD8CUx4YRGHwfPyJ4VIh5d3OPqU+d8PIWfuPq9YaWfYbOA==
X-Received: by 2002:a05:620a:4316:b0:7c7:73cd:1475 with SMTP id
 af79cd13be357-7cabe697ef0mr297011685a.3.1745925871456; 
 Tue, 29 Apr 2025 04:24:31 -0700 (PDT)
Received: from johnnyzero.szero ([32.220.111.111])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c958d86f1asm725583285a.69.2025.04.29.04.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 04:24:31 -0700 (PDT)
From: John Olender <john.olender@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: arunpravin.paneerselvam@amd.com
Subject: [RFC PATCH 2/2] drm/amdgpu/uvd: Ensure vcpu bos are within the uvd
 segment
Date: Tue, 29 Apr 2025 07:24:29 -0400
Message-ID: <20250429112429.5646-3-john.olender@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429112429.5646-1-john.olender@gmail.com>
References: <20250429112429.5646-1-john.olender@gmail.com>
MIME-Version: 1.0
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

If the vcpu bos are allocated outside the uvd segment,
amdgpu_uvd_ring_test_ib() times out waiting on the ring's fence.

See amdgpu_fence_driver_start_ring() for more context.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3851
Signed-off-by: John Olender <john.olender@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 36 ++++++++++++++-----------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 74758b5ffc6c..a6b3e75ffa2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -139,15 +139,20 @@ static void amdgpu_uvd_force_into_uvd_segment(struct amdgpu_bo *abo);
 
 static int amdgpu_uvd_create_msg_bo_helper(struct amdgpu_device *adev,
 					   uint32_t size,
-					   struct amdgpu_bo **bo_ptr)
+					   struct amdgpu_bo **bo_ptr,
+					   bool interruptible)
 {
-	struct ttm_operation_ctx ctx = { true, false };
+	struct ttm_operation_ctx ctx = { interruptible, false };
 	struct amdgpu_bo *bo = NULL;
+	u32 initial_domain = AMDGPU_GEM_DOMAIN_GTT;
 	void *addr;
 	int r;
 
+	if (!interruptible && adev->uvd.address_64_bit)
+		initial_domain |= AMDGPU_GEM_DOMAIN_VRAM;
+
 	r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_GTT,
+				      initial_domain,
 				      &bo, NULL, &addr);
 	if (r)
 		return r;
@@ -319,19 +324,23 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
 		bo_size += AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
+	/* from uvd v5.0 HW addressing capacity increased to 64 bits */
+	if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0))
+		adev->uvd.address_64_bit = true;
+
 	for (j = 0; j < adev->uvd.num_uvd_inst; j++) {
 		if (adev->uvd.harvest_config & (1 << j))
 			continue;
-		r = amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
-					    AMDGPU_GEM_DOMAIN_VRAM |
-					    AMDGPU_GEM_DOMAIN_GTT,
-					    &adev->uvd.inst[j].vcpu_bo,
-					    &adev->uvd.inst[j].gpu_addr,
-					    &adev->uvd.inst[j].cpu_addr);
+		r = amdgpu_uvd_create_msg_bo_helper(adev, bo_size,
+				&adev->uvd.inst[j].vcpu_bo, false);
 		if (r) {
 			dev_err(adev->dev, "(%d) failed to allocate UVD bo\n", r);
 			return r;
 		}
+		adev->uvd.inst[j].gpu_addr =
+				amdgpu_bo_gpu_offset(adev->uvd.inst[j].vcpu_bo);
+		adev->uvd.inst[j].cpu_addr =
+				amdgpu_bo_kptr(adev->uvd.inst[j].vcpu_bo);
 	}
 
 	for (i = 0; i < adev->uvd.max_handles; ++i) {
@@ -339,11 +348,8 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 		adev->uvd.filp[i] = NULL;
 	}
 
-	/* from uvd v5.0 HW addressing capacity increased to 64 bits */
-	if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0))
-		adev->uvd.address_64_bit = true;
-
-	r = amdgpu_uvd_create_msg_bo_helper(adev, 128 << 10, &adev->uvd.ib_bo);
+	r = amdgpu_uvd_create_msg_bo_helper(adev, 128 << 10, &adev->uvd.ib_bo,
+			true);
 	if (r)
 		return r;
 
@@ -1236,7 +1242,7 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 	if (direct) {
 		bo = adev->uvd.ib_bo;
 	} else {
-		r = amdgpu_uvd_create_msg_bo_helper(adev, 4096, &bo);
+		r = amdgpu_uvd_create_msg_bo_helper(adev, 4096, &bo, true);
 		if (r)
 			return r;
 	}
-- 
2.47.2

