Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AECCDB470
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 07:38:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 231F110E060;
	Wed, 24 Jun 2026 07:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cdkDEL5v";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDD6C10E060
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 07:38:34 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-463b2f6fc9dso795672f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 00:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782286713; x=1782891513; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EE7mNnOEUn97huWGdc0rfoBkbmuI0AZad1MlHLnIHgE=;
 b=cdkDEL5vh1g7p2n7c9PKkosXTuDyX1sMmukOr7jBWthr+rnHhHMDltt7v4SuUa9L0x
 v8D5RwumV1oNoqP9xYB2k/tC/FkqXmdBuGnJK+WMlOiGfHZmnBkxetsQ37C2Z+e+NlWj
 i1QODWd2LqMkQ1DGbXPGsz3DA96Tr7ipn12V5UWWvFsFUgOti8qSYy29MNHluKABygQg
 OIV7YxOQ8gRJDjvQ3cL3ksslz+M4IV+lrKIyk8JuiCPuQGbUjOhgkieINvTb2cEHLYpp
 nJudg3PErQAh3iyRWKbPfbHU5bRmATHbERl3Sc9kB1BnMubGASdJ3VYDkMF9lDR4nEnH
 LKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782286713; x=1782891513;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EE7mNnOEUn97huWGdc0rfoBkbmuI0AZad1MlHLnIHgE=;
 b=lrGmQL6+6SA08zRd6e9SIIbUKfTx+ShRrx/cd78fgXKCHIKKCOUuVPVMJMtueKbN+V
 CwVj5Wmn3L0+IDjNZZZ5Qmm02KeRwCievKbnFt5jbz9h+Kd2LYPpsQjHaoGQ1gUTgmLX
 VcvuBT2vUFkKl15J0I6ReYASpAn84+6mTgVHSWOpUSLvh9q7Ayd3ZoyyfikTt7iJv9fV
 k0mK33m03v7wIpgwExXMh+2lAx+X0q7WeJGmZpjbr7vm5s+fO8i8TYNx9C6i66OmTfLv
 X6dTUI5MHFB4Nvvj4GC734JgoorLNWM1EEtHv4JZX0hd+bKoAS99MLO+h45kFd8xQj/4
 wEUQ==
X-Gm-Message-State: AOJu0Yx0/h1aeb9V4X451C6K57TY1H/PCXvhHcSm9m6ZCEbU/78nuyyl
 dBhB6LqabPQSfy2BDVR9KV/sNLKvpxS1zFMSH31f6k53lsDgAlExqFOcFEwovg==
X-Gm-Gg: AfdE7ckBy7EPGU2NQMhQY4zW7JqGPIwYqxjcF7Av/SH9gYkdlV/sRg5hUu3i4AwNUAE
 IzCMEt3gAoVJxmTRq1/lV2EZroA+s37VthG2ok+8AFK5tOyc4NeLu6zFi5+8SzRdJIt7lfdcEBk
 vZPWcKUB/GW6wTUbwZlp4hfJ82h37LCBElkGi5Hb/YvRHD7cnfjswUM3rmf6PPTyc/A4zgk40Ru
 H8HyD+FUhWReK2nz9kUPKgVyp/J6VNXD4HObLbF+ek2djTDyizDRrEB78LZsDKLYOfFCbjN2i+/
 SjGPVWfQHFGYjO74+Rq+VX5LB8MFlV1Uqf6ACPBoYgR5bITUzNQ71KiYlK2/W0xRpdsXOs1IsPV
 xRGAKyIXug45lDmK+fcsXR194cIajZ+8pR+Xw0R5XNWhvLNm9FVfZVIhhm8PxSYVtF1skBdkbRo
 fkRgyGRrn4jHSov4X1+A3RFfJDSlSUFi3LI+c9//n4PCT96YzgZ/xKOg==
X-Received: by 2002:a05:6000:22c5:b0:460:71e6:e11 with SMTP id
 ffacd0b85a97d-46c0b3e3bb3mr3506492f8f.24.1782286712806; 
 Wed, 24 Jun 2026 00:38:32 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c9787dddbsm1683667f8f.3.2026.06.24.00.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 00:38:32 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Lazar Lijo <lijo.lazar@amd.com>, Martin Roukala <martin.roukala@mupuf.org>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/2] drm/amdgpu: Simplify filtering rings during IP block soft
 reset
Date: Wed, 24 Jun 2026 09:38:28 +0200
Message-ID: <20260624073829.40835-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Instead of storing pointers to affected rings in an array,
just iterate over all rings of the device and filter the
affected rings by type using the type mask.

This is done to save memory used by the array of affected
rings which was sized AMDGPU_MAX_RINGS.

Suggested-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c   | 30 ++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 53 ++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 +-
 3 files changed, 40 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
index 65505bc50399a..99ed0b0d82e94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
@@ -481,28 +481,6 @@ static u32 amdgpu_ring_mask_from_ip(const enum amd_ip_block_type ip_type)
 	}
 }
 
-/**
- * amdgpu_filter_rings() - Filter rings according to a mask.
- *
- * @adev: amdgpu_device pointer
- * @ring_type_mask: Mask of ring types you are looking for
- * @out_rings: Array of rings which is going to be filled
- * @out_num_rings: Number of rings which were filtered
- */
-static void amdgpu_filter_rings(struct amdgpu_device *adev, const u32 ring_type_mask,
-				struct amdgpu_ring **out_rings, u32 *out_num_rings)
-{
-	u32 num_rings = 0;
-	int i;
-
-	for (i = 0; i < adev->num_rings; ++i) {
-		if (BIT(adev->rings[i]->funcs->type) & ring_type_mask)
-			out_rings[num_rings++] = adev->rings[i];
-	}
-
-	*out_num_rings = num_rings;
-}
-
 /**
  * amdgpu_device_ip_soft_reset() - Perform a graceful soft reset on an IP block.
  *
@@ -524,10 +502,9 @@ int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
 				struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = guilty_ring->adev;
-	struct amdgpu_ring *rings[AMDGPU_MAX_RINGS];
 	struct amdgpu_ip_block *ip_block;
 	enum amd_ip_block_type ip_type;
-	u32 num_rings, ring_type_mask;
+	u32 ring_type_mask;
 	int r;
 
 	ip_type = amdgpu_ip_from_ring(guilty_ring->funcs->type);
@@ -543,14 +520,13 @@ int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
 		ip_block->version->funcs->name);
 
 	ring_type_mask = amdgpu_ring_mask_from_ip(ip_type);
-	amdgpu_filter_rings(adev, ring_type_mask, rings, &num_rings);
 
 	amdgpu_device_lock_reset_domain(adev->reset_domain);
-	amdgpu_multi_ring_reset_helper_begin(rings, num_rings, guilty_ring, guilty_fence);
+	amdgpu_multi_ring_reset_helper_begin(ring_type_mask, guilty_ring, guilty_fence);
 
 	r = ip_block->version->funcs->soft_reset(ip_block);
 
-	r = amdgpu_multi_ring_reset_helper_end(rings, num_rings, guilty_ring, r);
+	r = amdgpu_multi_ring_reset_helper_end(ring_type_mask, guilty_ring, r);
 	amdgpu_device_unlock_reset_domain(adev->reset_domain);
 
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 8062135e73a1d..ab5df854c1d20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -884,8 +884,7 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 /**
  * amdgpu_multi_ring_reset_helper_begin() - Prepare multiple rings for a reset.
  *
- * @rings: Pointer to an array of amdgpu rings that are affected.
- * @num_rings: Number of rings in the array.
+ * @ring_type_mask: Bitmask of affected ring types
  * @guilty_ring: The ring which is guilty of causing a reset.
  * @guilty_fence: The fence which didn't signal on the guilty ring.
  *
@@ -904,7 +903,7 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
  * After the reset is complete, the caller should then call
  * amdgpu_multi_ring_reset_helper_end() to restore the rings.
  */
-void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_ring **rings, u32 num_rings,
+void amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
 					  struct amdgpu_ring *guilty_ring,
 					  struct amdgpu_fence *guilty_fence)
 {
@@ -915,8 +914,11 @@ void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_ring **rings, u32 num_ri
 	int i;
 	u32 t;
 
-	for (i = 0; i < num_rings; ++i) {
-		ring = rings[i];
+	for (i = 0; i < adev->num_rings; ++i) {
+		ring = adev->rings[i];
+
+		if (!(BIT(ring->funcs->type) & ring_type_mask))
+			continue;
 
 		/* Don't accept new submissions on the ring. */
 		if (amdgpu_ring_sched_ready(ring) && !drm_sched_is_stopped(&ring->sched))
@@ -949,8 +951,11 @@ void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_ring **rings, u32 num_ri
 		rings_busy = false;
 
 		/* Check if any of the non-guilty rings are busy */
-		for (i = 0; i < num_rings; ++i) {
-			ring = rings[i];
+		for (i = 0; i < adev->num_rings; ++i) {
+			ring = adev->rings[i];
+
+			if (!(BIT(ring->funcs->type) & ring_type_mask))
+				continue;
 
 			if (ring == guilty_ring)
 				continue;
@@ -966,8 +971,11 @@ void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_ring **rings, u32 num_ri
 		mdelay(10);
 	}
 
-	for (i = 0; i < num_rings; ++i) {
-		ring = rings[i];
+	for (i = 0; i < adev->num_rings; ++i) {
+		ring = adev->rings[i];
+
+		if (!(BIT(ring->funcs->type) & ring_type_mask))
+			continue;
 
 		/*
 		 * Find guilty fences, ie. the fences that didn't signal
@@ -991,8 +999,7 @@ void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_ring **rings, u32 num_ri
 /**
  * amdgpu_multi_ring_reset_helper_end() - Prepare multiple rings for a reset.
  *
- * @rings: Pointer to an array of amdgpu rings that are affected.
- * @num_rings: Number of rings in the array.
+ * @ring_type_mask: Bitmask of affected ring types
  * @guilty_ring: The ring which is guilty of causing a reset.
  * @ret: Return code from the reset function.
  *
@@ -1004,7 +1011,7 @@ void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_ring **rings, u32 num_ri
  * be called to restore some state, but it won't attempt to
  * fully restore the ring contents.
  */
-int amdgpu_multi_ring_reset_helper_end(struct amdgpu_ring **rings, u32 num_rings,
+int amdgpu_multi_ring_reset_helper_end(const u32 ring_type_mask,
 				       struct amdgpu_ring *guilty_ring, int ret)
 {
 	struct amdgpu_device *adev = guilty_ring->adev;
@@ -1012,8 +1019,11 @@ int amdgpu_multi_ring_reset_helper_end(struct amdgpu_ring **rings, u32 num_rings
 	int i, r;
 
 	/* Set preempt condition, rings are now allowed to execute submissions */
-	for (i = 0; i < num_rings; ++i) {
-		ring = rings[i];
+	for (i = 0; i < adev->num_rings; ++i) {
+		ring = adev->rings[i];
+
+		if (!(BIT(ring->funcs->type) & ring_type_mask))
+			continue;
 
 		if (ring->funcs->init_cond_exec)
 			amdgpu_ring_set_preempt_cond_exec(ring, true);
@@ -1027,9 +1037,13 @@ int amdgpu_multi_ring_reset_helper_end(struct amdgpu_ring **rings, u32 num_rings
 		return ret;
 
 	/* Restore contents of all rings */
-	for (i = 0; i < num_rings; ++i) {
-		ring = rings[i];
+	for (i = 0; i < adev->num_rings; ++i) {
+		ring = adev->rings[i];
+
+		if (!(BIT(ring->funcs->type) & ring_type_mask))
+			continue;
 
+		/* Restore contents of the ring */
 		r = amdgpu_ring_reset_helper_end(ring, ring->guilty_fence);
 		if (r) {
 			dev_err(adev->dev,
@@ -1040,8 +1054,11 @@ int amdgpu_multi_ring_reset_helper_end(struct amdgpu_ring **rings, u32 num_rings
 	}
 
 	/* Accept submissions on all rings again */
-	for (i = 0; i < num_rings; ++i) {
-		ring = rings[i];
+	for (i = 0; i < adev->num_rings; ++i) {
+		ring = adev->rings[i];
+
+		if (!(BIT(ring->funcs->type) & ring_type_mask))
+			continue;
 
 		if (!amdgpu_ring_sched_ready(ring))
 			continue;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index c272e0b028ad8..9d3934b4f1069 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -595,10 +595,10 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 				    struct amdgpu_fence *guilty_fence);
 int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *guilty_fence);
-void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_ring **rings, u32 num_rings,
+void amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
 					  struct amdgpu_ring *guilty_ring,
 					  struct amdgpu_fence *guilty_fence);
-int amdgpu_multi_ring_reset_helper_end(struct amdgpu_ring **rings, u32 num_rings,
+int amdgpu_multi_ring_reset_helper_end(const u32 ring_type_mask,
 				       struct amdgpu_ring *guilty_ring, int ret);
 bool amdgpu_ring_is_reset_type_supported(struct amdgpu_ring *ring,
 					 u32 reset_type);
-- 
2.54.0

