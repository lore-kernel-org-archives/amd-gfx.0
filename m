Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BCBCA0FED
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 14:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36D6510E771;
	Tue,  9 Sep 2025 14:49:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B3F6+pUH";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35F4610E75A
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 14:49:47 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-24457f581aeso52108795ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Sep 2025 07:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757429387; x=1758034187; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JY2G52TxC2VFMrczcF6VF6VJB0SzM4PHxb10Ektvpnc=;
 b=B3F6+pUHxd4gjzJM0rY5bIHPVHNxX0xJxBFEwsGELwdL0Nq7eLCRFz06/dBv8IzwPZ
 crF9Dt5Lu2FrF+GKXEJAPurUY2S741vytldeV/gwytqrFu35ufJK0vCU3h+rDDnvziyY
 ELfrhO2PwGZaYvMU/1b6s/j1zGxJdAsO2VxkZOY0BoHDLzZAaap8xnHs9CSmfWRDdSwc
 HCFNz9w4kIXSH3AxL1Dsh6OCL94fnkIvIbgzsc4M+Ny2pDNNfhDMsBx/3A8Cw6b422ro
 sGQJkZ/Q3GWqs3cguBHu3BC7jRTFnc5qod+yr1dc3B0ODgMpzdFst67SxyQoPIHVijxb
 yiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757429387; x=1758034187;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JY2G52TxC2VFMrczcF6VF6VJB0SzM4PHxb10Ektvpnc=;
 b=i5BLZ7DFIcclmcKqHQbXlGCLbOxrhpkE7TDTYqui/4f5kolUU52U418LsbcJRl54/K
 AwFsc8VpBgGPBmsxcsDmIowbaY+Fk8OWTX9Ase5QE/HLo7FOV1XOlaod8/hOXwBCoD/v
 NhGP4D7qk1LxKRSrrPjT/FwSXN9ILBU4i1T0cDwYd3fYM6jEDYaU4npjvXJKRB+x2KYi
 b8GfBrwm5RF/FTPj4alnNWd7uGvxGCcJAofKVvA3/mkZfFZoXKK6pNSbIJrvoKWw+JSe
 8qu+hhIIM6f1l088Nwq8s73KF+cLB1YyZTtxweufVtKl7K2ThK0onz44V2+NQCCYICQa
 0XOw==
X-Gm-Message-State: AOJu0YwikLImqWh2zDxKoaoDaMdP3lHRHZ8gUbhgu5yDSdSXs1VAVNhA
 4INvrvrIFnSwJKmtqTSd/1aM/Ry6nsLOR/Dt4UGhr/1e8+rYCrjOGfYN5kBWuw==
X-Gm-Gg: ASbGncsk4APdoc3rF/rFvWY9iTrpoi3b5ch0z8rqK357KO801E4Q5uG4/LbBnQ6IXuK
 cF10LQWENvmzc8Kml2vJPiC9cx9DrEYTZQrRiNy4F8cPWuMqwdMpdflfj50bV+Ab+8oifVKvbtm
 inWx8pOzLOAt380tDCGlbhztOWsBpduksYkfKGRwHuhbGyfUTaHBo8bx7cdZpo3xhLljwG8T58D
 x6AAbaOBFA7QCkrK8wcqo15tsc8jMVc1uw0Uj21SsPuG/WoVn4HGn7pgE0pATsAfve9HJmaaOno
 aWtZd7WNF1Lrx35gJoamc4PFiPRImLVJBodMBe7KMVAZ2sBqN9EEdnCM4xhHOisG0brBKXMb/fO
 V2oGCa00nGpN4RVIFreMykbGvQizsF9K7jm+ZbiMubAkS3BzKNF0fxJrqZI1LfSYw0VX/GZhcrY
 6yc/3MjOF4Bj1Y6oPxhg9MhLisZZ3Uk1DMsllCNg==
X-Google-Smtp-Source: AGHT+IGeAZF85ICmo0VNXke3C8HHhMxGCL8qZo/GvJrql/AmUo1bbx5Y/IWrPHDA2Nh2yJYBCufDBA==
X-Received: by 2002:a17:902:d2c4:b0:24c:965a:f97e with SMTP id
 d9443c01a7336-2516f05008amr153365625ad.2.1757429386532; 
 Tue, 09 Sep 2025 07:49:46 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24D7A10085C74347BA908E23.dsl.pool.telekom.hu.
 [2001:4c4e:24d7:a100:85c7:4347:ba90:8e23])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-25a2a3449f7sm239455ad.88.2025.09.09.07.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 07:49:46 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/3] drm/amdgpu: Fix allocating extra dwords for rings (v2)
Date: Tue,  9 Sep 2025 16:49:35 +0200
Message-ID: <20250909144937.22452-1-timur.kristof@gmail.com>
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

Rename extra_dw to extra_bytes and document what it's for.

The value is already used as if it were bytes in vcn_v4_0.c
and in amdgpu_ring_init. Just adjust the dword count in
jpeg_v1_0.c so that it becomes a byte count.

v2:
Rename extra_dw to extra_bytes as discussed during review.

Fixes: c8c1a1d2ef04 ("drm/amdgpu: define and add extra dword for jpeg ring")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 11 ++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 13 ++++++++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  2 +-
 4 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 6379bb25bf5c..eca8b28e3fb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -364,11 +364,12 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 
 	/* Allocate ring buffer */
 	if (ring->ring_obj == NULL) {
-		r = amdgpu_bo_create_kernel(adev, ring->ring_size + ring->funcs->extra_dw, PAGE_SIZE,
-					    AMDGPU_GEM_DOMAIN_GTT,
-					    &ring->ring_obj,
-					    &ring->gpu_addr,
-					    (void **)&ring->ring);
+		r = amdgpu_bo_create_kernel(adev, ring->ring_size + ring->funcs->extra_bytes,
+						PAGE_SIZE,
+						AMDGPU_GEM_DOMAIN_GTT,
+						&ring->ring_obj,
+						&ring->gpu_addr,
+						(void **)&ring->ring);
 		if (r) {
 			dev_err(adev->dev, "(%d) ring create failed\n", r);
 			kvfree(ring->ring_backup);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7670f5d82b9e..12783ea3ba0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -211,7 +211,18 @@ struct amdgpu_ring_funcs {
 	bool			support_64bit_ptrs;
 	bool			no_user_fence;
 	bool			secure_submission_supported;
-	unsigned		extra_dw;
+
+	/**
+	 * @extra_bytes:
+	 *
+	 * Optional extra space in bytes that is added to the ring size
+	 * when allocating the BO that holds the contents of the ring.
+	 * This space isn't used for command submission to the ring,
+	 * but is just there to satisfy some hardware requirements or
+	 * implement workarounds. It's up to the implementation of each
+	 * specific ring to initialize this space.
+	 */
+	unsigned		extra_bytes;
 
 	/* ring read/write ptr handling */
 	u64 (*get_rptr)(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index 9e428e669ada..b5bb7f4d607c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -557,7 +557,7 @@ static const struct amdgpu_ring_funcs jpeg_v1_0_decode_ring_vm_funcs = {
 	.nop = PACKET0(0x81ff, 0),
 	.support_64bit_ptrs = false,
 	.no_user_fence = true,
-	.extra_dw = 64,
+	.extra_bytes = 256,
 	.get_rptr = jpeg_v1_0_decode_ring_get_rptr,
 	.get_wptr = jpeg_v1_0_decode_ring_get_wptr,
 	.set_wptr = jpeg_v1_0_decode_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index d0d27790b73b..099698cb1a3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1986,7 +1986,7 @@ static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
-	.extra_dw = sizeof(struct amdgpu_vcn_rb_metadata),
+	.extra_bytes = sizeof(struct amdgpu_vcn_rb_metadata),
 	.get_rptr = vcn_v4_0_unified_ring_get_rptr,
 	.get_wptr = vcn_v4_0_unified_ring_get_wptr,
 	.set_wptr = vcn_v4_0_unified_ring_set_wptr,
-- 
2.51.0

