Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40C5C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 13:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 511BA10E398;
	Thu, 20 Mar 2025 13:02:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KJRQSEJ8";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C05610E398
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 13:02:55 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso4865765e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 06:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742475774; x=1743080574; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=je1eE3H12kY7CL8qU8eNgWyBBLrOFUBYh2morwG30Sc=;
 b=KJRQSEJ8Sen1Wj49wftj4w+mMN4Svse9OhkyestFjjM93pU8XgoMiKWVEvE9t+iljM
 Zvyum+gh7R7Rl7q67DiIJjCxJ4Gz+ilEEvaxMYVs+VfLYX7NzJe5FhM6Vi3pt21s0WPD
 Gei4QJli2zpmQBpeBzN23ATmSu3DNTVyeCZSy4lkRwHnXuFOKKRBPF39p8vKkBnoqtEh
 V25E1d7KPnc2DT9ZT49pDuyAaGRx3pdLDsCtUp8iACkyP2sZXQu++cDlJBQqK3RetsHM
 E1k69SJs5Rcl5LuCMks8lggL/UylQxsaEIwbquaksC/saLsrzoIG3gedyfaGHX2aUGOF
 GJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742475774; x=1743080574;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=je1eE3H12kY7CL8qU8eNgWyBBLrOFUBYh2morwG30Sc=;
 b=VNJM7XsVeH3q31XhbuiHu6ILWrL5mWr6TxJYxIqglZAdT1F4jc52CHaU4W2oc13w9L
 pbHHEKcK9F30icvWKihle3IUkxBhxPWgAQqC/6MgZ6xk0g/QzoQNed7hWp8Svy0OPhf3
 2Q6RezJQ3iB1UoT2ZemdoRYYmTAiBwCEaCSq2URTPziYa3lwf0W4ZBQ5mVCEwKqWPYOs
 uG5viW7TW34g9VkcRGyr4jGnKgPFA2dEo3lasuzUMpFf+VV2hRbnCHxITu6HrfkWHg8S
 NxiZ6c2U63IOPcwtJxV/4Wwk+uel9jkm3Pv3pLQK2tWJ+6UlFKli91aBA4Q1y4gEbjMf
 k0fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAmP1fBkUxaey8fC8ZpiOOo/vQXhRhyIdWaZYNVWa85nbz/ofbCqtefXL+dyEf5wUNxpNpShvb@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxeP+db2dmp4OBuaddyoKoe9U0AoPIPfgs7Kforq6BFOszN92jh
 83LPRxaaryP5CfHPLIvLJKmGNUhfks/1/r5vGeCaZBYA/zo9pZzb
X-Gm-Gg: ASbGncta4+UwcVxli3KKXIO/ls7/SF9oCMh1jcAwtwlw5AqcH7ZyGdS/p0tKWi64r/W
 mF0ulUr8fjZ62Xnl2Id7euPXbx1XeJwvzACzwk7/Pr1dm5YYZ+1U5xnpLj/ZJfsdInhOknC+dQk
 o2jduyg5ufow0cqIHUPRt5CTxUusNL+ww9iF9Jc/bxo7dOmF8knVVcBqgPQtF8eUZiedcG0TX1j
 3hb876f1UzhIxugyVVvnhQTBGG5RFLSlAwiTroOGFer+qBsl/sOKYxqgLlR8zi4rxwefucurN/H
 I2fGv+3M42cWCJ3ZspyAYKdqRT246hfOx27BiCqiioceN0t6MlmsW/4oSgLuP6CtfEOG
X-Google-Smtp-Source: AGHT+IHpqV9vtBFWC1G/cRM8QR1vq4wVNOETBGz1/NDIDANxSLhLJCR6+DInE4jFCooDrd1CPjjppA==
X-Received: by 2002:a5d:5f41:0:b0:391:3150:96fb with SMTP id
 ffacd0b85a97d-399739c8c85mr5300296f8f.23.1742475772853; 
 Thu, 20 Mar 2025 06:02:52 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:154d:6e00:a3b8:e632:c155:6cb5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3c5abca26sm174951366b.106.2025.03.20.06.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 06:02:52 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexdeucher@gmail.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: stop unmapping MQD for kernel queues v2
Date: Thu, 20 Mar 2025 14:02:51 +0100
Message-Id: <20250320130251.2089-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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

This looks unnecessary and actually extremely harmful since using kmap()
is not possible while inside the ring reset.

Remove all the extra mapping and unmapping of the MQDs.

v2: also fix debugfs

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com> (v1)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  58 ++-----------
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  88 +++----------------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  88 +++----------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 102 ++++-------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    |  45 ++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  57 ++-----------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  61 +++-----------
 7 files changed, 67 insertions(+), 432 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index ba8f2785865a..c877769f0883 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -572,59 +572,17 @@ static ssize_t amdgpu_debugfs_mqd_read(struct file *f, char __user *buf,
 				       size_t size, loff_t *pos)
 {
 	struct amdgpu_ring *ring = file_inode(f)->i_private;
-	volatile u32 *mqd;
-	u32 *kbuf;
-	int r, i;
-	uint32_t value, result;
+	ssize_t bytes = min_t(ssize_t, ring->mqd_size - *pos, size);
+	void *from = ((u8*)ring->mqd_ptr) + *pos;
 
-	if (*pos & 3 || size & 3)
-		return -EINVAL;
-
-	kbuf = kmalloc(ring->mqd_size, GFP_KERNEL);
-	if (!kbuf)
-		return -ENOMEM;
-
-	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-	if (unlikely(r != 0))
-		goto err_free;
-
-	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&mqd);
-	if (r)
-		goto err_unreserve;
-
-	/*
-	 * Copy to local buffer to avoid put_user(), which might fault
-	 * and acquire mmap_sem, under reservation_ww_class_mutex.
-	 */
-	for (i = 0; i < ring->mqd_size/sizeof(u32); i++)
-		kbuf[i] = mqd[i];
+	if (*pos > ring->mqd_size)
+		return 0;
 
-	amdgpu_bo_kunmap(ring->mqd_obj);
-	amdgpu_bo_unreserve(ring->mqd_obj);
+	if (copy_to_user(buf, from, bytes))
+		return -EFAULT;
 
-	result = 0;
-	while (size) {
-		if (*pos >= ring->mqd_size)
-			break;
-
-		value = kbuf[*pos/4];
-		r = put_user(value, (uint32_t *)buf);
-		if (r)
-			goto err_free;
-		buf += 4;
-		result += 4;
-		size -= 4;
-		*pos += 4;
-	}
-
-	kfree(kbuf);
-	return result;
-
-err_unreserve:
-	amdgpu_bo_unreserve(ring->mqd_obj);
-err_free:
-	kfree(kbuf);
-	return r;
+	*pos += bytes;
+	return bytes;
 }
 
 static const struct file_operations amdgpu_debugfs_mqd_fops = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 6d514efb0a6d..a63ce747863f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6851,22 +6851,9 @@ static int gfx_v10_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
 static int gfx_v10_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 {
 	int r, i;
-	struct amdgpu_ring *ring;
 
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-		ring = &adev->gfx.gfx_ring[i];
-
-		r = amdgpu_bo_reserve(ring->mqd_obj, false);
-		if (unlikely(r != 0))
-			return r;
-
-		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-		if (!r) {
-			r = gfx_v10_0_kgq_init_queue(ring, false);
-			amdgpu_bo_kunmap(ring->mqd_obj);
-			ring->mqd_ptr = NULL;
-		}
-		amdgpu_bo_unreserve(ring->mqd_obj);
+		r = gfx_v10_0_kgq_init_queue(&adev->gfx.gfx_ring[i], false);
 		if (r)
 			return r;
 	}
@@ -7173,55 +7160,24 @@ static int gfx_v10_0_kcq_init_queue(struct amdgpu_ring *ring, bool restore)
 
 static int gfx_v10_0_kiq_resume(struct amdgpu_device *adev)
 {
-	struct amdgpu_ring *ring;
-	int r;
-
-	ring = &adev->gfx.kiq[0].ring;
-
-	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-	if (unlikely(r != 0))
-		return r;
-
-	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-	if (unlikely(r != 0)) {
-		amdgpu_bo_unreserve(ring->mqd_obj);
-		return r;
-	}
-
-	gfx_v10_0_kiq_init_queue(ring);
-	amdgpu_bo_kunmap(ring->mqd_obj);
-	ring->mqd_ptr = NULL;
-	amdgpu_bo_unreserve(ring->mqd_obj);
+	gfx_v10_0_kiq_init_queue(&adev->gfx.kiq[0].ring);
 	return 0;
 }
 
 static int gfx_v10_0_kcq_resume(struct amdgpu_device *adev)
 {
-	struct amdgpu_ring *ring = NULL;
-	int r = 0, i;
+	int i, r;
 
 	gfx_v10_0_cp_compute_enable(adev, true);
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		ring = &adev->gfx.compute_ring[i];
-
-		r = amdgpu_bo_reserve(ring->mqd_obj, false);
-		if (unlikely(r != 0))
-			goto done;
-		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-		if (!r) {
-			r = gfx_v10_0_kcq_init_queue(ring, false);
-			amdgpu_bo_kunmap(ring->mqd_obj);
-			ring->mqd_ptr = NULL;
-		}
-		amdgpu_bo_unreserve(ring->mqd_obj);
+		r = gfx_v10_0_kcq_init_queue(&adev->gfx.compute_ring[i],
+					     false);
 		if (r)
-			goto done;
+			return r;
 	}
 
-	r = amdgpu_gfx_enable_kcq(adev, 0);
-done:
-	return r;
+	return amdgpu_gfx_enable_kcq(adev, 0);
 }
 
 static int gfx_v10_0_cp_resume(struct amdgpu_device *adev)
@@ -9579,20 +9535,9 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	if (r)
 		return r;
 
-	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-	if (unlikely(r != 0)) {
-		DRM_ERROR("fail to resv mqd_obj\n");
-		return r;
-	}
-	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-	if (!r) {
-		r = gfx_v10_0_kgq_init_queue(ring, true);
-		amdgpu_bo_kunmap(ring->mqd_obj);
-		ring->mqd_ptr = NULL;
-	}
-	amdgpu_bo_unreserve(ring->mqd_obj);
+	r = gfx_v10_0_kgq_init_queue(ring, true);
 	if (r) {
-		DRM_ERROR("fail to unresv mqd_obj\n");
+		DRM_ERROR("fail to init kgq\n");
 		return r;
 	}
 
@@ -9649,20 +9594,9 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-	if (unlikely(r != 0)) {
-		dev_err(adev->dev, "fail to resv mqd_obj\n");
-		return r;
-	}
-	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-	if (!r) {
-		r = gfx_v10_0_kcq_init_queue(ring, true);
-		amdgpu_bo_kunmap(ring->mqd_obj);
-		ring->mqd_ptr = NULL;
-	}
-	amdgpu_bo_unreserve(ring->mqd_obj);
+	r = gfx_v10_0_kcq_init_queue(ring, true);
 	if (r) {
-		dev_err(adev->dev, "fail to unresv mqd_obj\n");
+		dev_err(adev->dev, "fail to init kcq\n");
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 8261308fc1f2..91afb7d5929a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4117,22 +4117,9 @@ static int gfx_v11_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
 static int gfx_v11_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 {
 	int r, i;
-	struct amdgpu_ring *ring;
 
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-		ring = &adev->gfx.gfx_ring[i];
-
-		r = amdgpu_bo_reserve(ring->mqd_obj, false);
-		if (unlikely(r != 0))
-			return r;
-
-		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-		if (!r) {
-			r = gfx_v11_0_kgq_init_queue(ring, false);
-			amdgpu_bo_kunmap(ring->mqd_obj);
-			ring->mqd_ptr = NULL;
-		}
-		amdgpu_bo_unreserve(ring->mqd_obj);
+		r = gfx_v11_0_kgq_init_queue(&adev->gfx.gfx_ring[i], false);
 		if (r)
 			return r;
 	}
@@ -4458,57 +4445,24 @@ static int gfx_v11_0_kcq_init_queue(struct amdgpu_ring *ring, bool reset)
 
 static int gfx_v11_0_kiq_resume(struct amdgpu_device *adev)
 {
-	struct amdgpu_ring *ring;
-	int r;
-
-	ring = &adev->gfx.kiq[0].ring;
-
-	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-	if (unlikely(r != 0))
-		return r;
-
-	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-	if (unlikely(r != 0)) {
-		amdgpu_bo_unreserve(ring->mqd_obj);
-		return r;
-	}
-
-	gfx_v11_0_kiq_init_queue(ring);
-	amdgpu_bo_kunmap(ring->mqd_obj);
-	ring->mqd_ptr = NULL;
-	amdgpu_bo_unreserve(ring->mqd_obj);
-	ring->sched.ready = true;
+	gfx_v11_0_kiq_init_queue(&adev->gfx.kiq[0].ring);
 	return 0;
 }
 
 static int gfx_v11_0_kcq_resume(struct amdgpu_device *adev)
 {
-	struct amdgpu_ring *ring = NULL;
-	int r = 0, i;
+	int i, r;
 
 	if (!amdgpu_async_gfx_ring)
 		gfx_v11_0_cp_compute_enable(adev, true);
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		ring = &adev->gfx.compute_ring[i];
-
-		r = amdgpu_bo_reserve(ring->mqd_obj, false);
-		if (unlikely(r != 0))
-			goto done;
-		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-		if (!r) {
-			r = gfx_v11_0_kcq_init_queue(ring, false);
-			amdgpu_bo_kunmap(ring->mqd_obj);
-			ring->mqd_ptr = NULL;
-		}
-		amdgpu_bo_unreserve(ring->mqd_obj);
+		r = gfx_v11_0_kcq_init_queue(&adev->gfx.compute_ring[i], false);
 		if (r)
-			goto done;
+			return r;
 	}
 
-	r = amdgpu_gfx_enable_kcq(adev, 0);
-done:
-	return r;
+	return amdgpu_gfx_enable_kcq(adev, 0);
 }
 
 static int gfx_v11_0_cp_resume(struct amdgpu_device *adev)
@@ -6644,20 +6598,9 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	if (r)
 		return r;
 
-	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-	if (unlikely(r != 0)) {
-		dev_err(adev->dev, "fail to resv mqd_obj\n");
-		return r;
-	}
-	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-	if (!r) {
-		r = gfx_v11_0_kgq_init_queue(ring, true);
-		amdgpu_bo_kunmap(ring->mqd_obj);
-		ring->mqd_ptr = NULL;
-	}
-	amdgpu_bo_unreserve(ring->mqd_obj);
+	r = gfx_v11_0_kgq_init_queue(ring, true);
 	if (r) {
-		dev_err(adev->dev, "fail to unresv mqd_obj\n");
+		dev_err(adev->dev, "failed to init kgq\n");
 		return r;
 	}
 
@@ -6684,20 +6627,9 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 		return r;
 	}
 
-	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-	if (unlikely(r != 0)) {
-		dev_err(adev->dev, "fail to resv mqd_obj\n");
-		return r;
-	}
-	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-	if (!r) {
-		r = gfx_v11_0_kcq_init_queue(ring, true);
-		amdgpu_bo_kunmap(ring->mqd_obj);
-		ring->mqd_ptr = NULL;
-	}
-	amdgpu_bo_unreserve(ring->mqd_obj);
+	r = gfx_v11_0_kcq_init_queue(ring, true);
 	if (r) {
-		dev_err(adev->dev, "fail to unresv mqd_obj\n");
+		dev_err(adev->dev, "fail to init kcq\n");
 		return r;
 	}
 	r = amdgpu_mes_map_legacy_queue(adev, ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 85dc6d8f0571..80a16cc13e80 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3030,37 +3030,19 @@ static int gfx_v12_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
 
 static int gfx_v12_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 {
-	int r, i;
-	struct amdgpu_ring *ring;
+	int i, r;
 
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-		ring = &adev->gfx.gfx_ring[i];
-
-		r = amdgpu_bo_reserve(ring->mqd_obj, false);
-		if (unlikely(r != 0))
-			goto done;
-
-		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-		if (!r) {
-			r = gfx_v12_0_kgq_init_queue(ring, false);
-			amdgpu_bo_kunmap(ring->mqd_obj);
-			ring->mqd_ptr = NULL;
-		}
-		amdgpu_bo_unreserve(ring->mqd_obj);
+		r = gfx_v12_0_kgq_init_queue(&adev->gfx.gfx_ring[i], false);
 		if (r)
-			goto done;
+			return r;
 	}
 
 	r = amdgpu_gfx_enable_kgq(adev, 0);
 	if (r)
-		goto done;
-
-	r = gfx_v12_0_cp_gfx_start(adev);
-	if (r)
-		goto done;
+		return r;
 
-done:
-	return r;
+	return gfx_v12_0_cp_gfx_start(adev);
 }
 
 static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
@@ -3377,57 +3359,25 @@ static int gfx_v12_0_kcq_init_queue(struct amdgpu_ring *ring, bool reset)
 
 static int gfx_v12_0_kiq_resume(struct amdgpu_device *adev)
 {
-	struct amdgpu_ring *ring;
-	int r;
-
-	ring = &adev->gfx.kiq[0].ring;
-
-	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-	if (unlikely(r != 0))
-		return r;
-
-	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-	if (unlikely(r != 0)) {
-		amdgpu_bo_unreserve(ring->mqd_obj);
-		return r;
-	}
-
-	gfx_v12_0_kiq_init_queue(ring);
-	amdgpu_bo_kunmap(ring->mqd_obj);
-	ring->mqd_ptr = NULL;
-	amdgpu_bo_unreserve(ring->mqd_obj);
-	ring->sched.ready = true;
+	gfx_v12_0_kiq_init_queue(&adev->gfx.kiq[0].ring);
+	adev->gfx.kiq[0].ring.sched.ready = true;
 	return 0;
 }
 
 static int gfx_v12_0_kcq_resume(struct amdgpu_device *adev)
 {
-	struct amdgpu_ring *ring = NULL;
-	int r = 0, i;
+	int i, r;
 
 	if (!amdgpu_async_gfx_ring)
 		gfx_v12_0_cp_compute_enable(adev, true);
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		ring = &adev->gfx.compute_ring[i];
-
-		r = amdgpu_bo_reserve(ring->mqd_obj, false);
-		if (unlikely(r != 0))
-			goto done;
-		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-		if (!r) {
-			r = gfx_v12_0_kcq_init_queue(ring, false);
-			amdgpu_bo_kunmap(ring->mqd_obj);
-			ring->mqd_ptr = NULL;
-		}
-		amdgpu_bo_unreserve(ring->mqd_obj);
+		r = gfx_v12_0_kcq_init_queue(&adev->gfx.compute_ring[i], false);
 		if (r)
-			goto done;
+			return r;
 	}
 
-	r = amdgpu_gfx_enable_kcq(adev, 0);
-done:
-	return r;
+	return amdgpu_gfx_enable_kcq(adev, 0);
 }
 
 static int gfx_v12_0_cp_resume(struct amdgpu_device *adev)
@@ -5187,20 +5137,9 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 		return r;
 	}
 
-	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-	if (unlikely(r != 0)) {
-		dev_err(adev->dev, "fail to resv mqd_obj\n");
-		return r;
-	}
-	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-	if (!r) {
-		r = gfx_v12_0_kgq_init_queue(ring, true);
-		amdgpu_bo_kunmap(ring->mqd_obj);
-		ring->mqd_ptr = NULL;
-	}
-	amdgpu_bo_unreserve(ring->mqd_obj);
+	r = gfx_v12_0_kgq_init_queue(ring, true);
 	if (r) {
-		DRM_ERROR("fail to unresv mqd_obj\n");
+		dev_err(adev->dev, "failed to init kgq\n");
 		return r;
 	}
 
@@ -5227,20 +5166,9 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 		return r;
 	}
 
-	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-	if (unlikely(r != 0)) {
-		DRM_ERROR("fail to resv mqd_obj\n");
-		return r;
-	}
-	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-	if (!r) {
-		r = gfx_v12_0_kcq_init_queue(ring, true);
-		amdgpu_bo_kunmap(ring->mqd_obj);
-		ring->mqd_ptr = NULL;
-	}
-	amdgpu_bo_unreserve(ring->mqd_obj);
+	r = gfx_v12_0_kcq_init_queue(ring, true);
 	if (r) {
-		DRM_ERROR("fail to unresv mqd_obj\n");
+		dev_err(adev->dev, "failed to init kcq\n");
 		return r;
 	}
 	r = amdgpu_mes_map_legacy_queue(adev, ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index d116a2e2f469..bfedd487efc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4683,60 +4683,25 @@ static void gfx_v8_0_set_mec_doorbell_range(struct amdgpu_device *adev)
 
 static int gfx_v8_0_kiq_resume(struct amdgpu_device *adev)
 {
-	struct amdgpu_ring *ring;
-	int r;
-
-	ring = &adev->gfx.kiq[0].ring;
-
-	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-	if (unlikely(r != 0))
-		return r;
-
-	r = amdgpu_bo_kmap(ring->mqd_obj, &ring->mqd_ptr);
-	if (unlikely(r != 0)) {
-		amdgpu_bo_unreserve(ring->mqd_obj);
-		return r;
-	}
-
-	gfx_v8_0_kiq_init_queue(ring);
-	amdgpu_bo_kunmap(ring->mqd_obj);
-	ring->mqd_ptr = NULL;
-	amdgpu_bo_unreserve(ring->mqd_obj);
+	gfx_v8_0_kiq_init_queue(&adev->gfx.kiq[0].ring);
 	return 0;
 }
 
 static int gfx_v8_0_kcq_resume(struct amdgpu_device *adev)
 {
-	struct amdgpu_ring *ring = NULL;
-	int r = 0, i;
+	int i, r;
 
 	gfx_v8_0_cp_compute_enable(adev, true);
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		ring = &adev->gfx.compute_ring[i];
-
-		r = amdgpu_bo_reserve(ring->mqd_obj, false);
-		if (unlikely(r != 0))
-			goto done;
-		r = amdgpu_bo_kmap(ring->mqd_obj, &ring->mqd_ptr);
-		if (!r) {
-			r = gfx_v8_0_kcq_init_queue(ring);
-			amdgpu_bo_kunmap(ring->mqd_obj);
-			ring->mqd_ptr = NULL;
-		}
-		amdgpu_bo_unreserve(ring->mqd_obj);
+		r = gfx_v8_0_kcq_init_queue(&adev->gfx.compute_ring[i]);
 		if (r)
-			goto done;
+			return r;
 	}
 
 	gfx_v8_0_set_mec_doorbell_range(adev);
 
-	r = gfx_v8_0_kiq_kcq_enable(adev);
-	if (r)
-		goto done;
-
-done:
-	return r;
+	return gfx_v8_0_kiq_kcq_enable(adev);
 }
 
 static int gfx_v8_0_cp_test_all_rings(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 5bf9d27d1ead..3e87a234d4b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3890,55 +3890,23 @@ static int gfx_v9_0_kcq_init_queue(struct amdgpu_ring *ring, bool restore)
 
 static int gfx_v9_0_kiq_resume(struct amdgpu_device *adev)
 {
-	struct amdgpu_ring *ring;
-	int r;
-
-	ring = &adev->gfx.kiq[0].ring;
-
-	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-	if (unlikely(r != 0))
-		return r;
-
-	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-	if (unlikely(r != 0)) {
-		amdgpu_bo_unreserve(ring->mqd_obj);
-		return r;
-	}
-
-	gfx_v9_0_kiq_init_queue(ring);
-	amdgpu_bo_kunmap(ring->mqd_obj);
-	ring->mqd_ptr = NULL;
-	amdgpu_bo_unreserve(ring->mqd_obj);
+	gfx_v9_0_kiq_init_queue(&adev->gfx.kiq[0].ring);
 	return 0;
 }
 
 static int gfx_v9_0_kcq_resume(struct amdgpu_device *adev)
 {
-	struct amdgpu_ring *ring = NULL;
-	int r = 0, i;
+	int i, r;
 
 	gfx_v9_0_cp_compute_enable(adev, true);
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		ring = &adev->gfx.compute_ring[i];
-
-		r = amdgpu_bo_reserve(ring->mqd_obj, false);
-		if (unlikely(r != 0))
-			goto done;
-		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-		if (!r) {
-			r = gfx_v9_0_kcq_init_queue(ring, false);
-			amdgpu_bo_kunmap(ring->mqd_obj);
-			ring->mqd_ptr = NULL;
-		}
-		amdgpu_bo_unreserve(ring->mqd_obj);
+		r = gfx_v9_0_kcq_init_queue(&adev->gfx.compute_ring[i], false);
 		if (r)
-			goto done;
+			return r;
 	}
 
-	r = amdgpu_gfx_enable_kcq(adev, 0);
-done:
-	return r;
+	return amdgpu_gfx_enable_kcq(adev, 0);
 }
 
 static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
@@ -7278,20 +7246,9 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-	if (unlikely(r != 0)){
-		dev_err(adev->dev, "fail to resv mqd_obj\n");
-		return r;
-	}
-	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-	if (!r) {
-		r = gfx_v9_0_kcq_init_queue(ring, true);
-		amdgpu_bo_kunmap(ring->mqd_obj);
-		ring->mqd_ptr = NULL;
-	}
-	amdgpu_bo_unreserve(ring->mqd_obj);
+	r = gfx_v9_0_kcq_init_queue(ring, true);
 	if (r) {
-		dev_err(adev->dev, "fail to unresv mqd_obj\n");
+		dev_err(adev->dev, "fail to init kcq\n");
 		return r;
 	}
 	spin_lock_irqsave(&kiq->ring_lock, flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index efe45e4edfd7..bfd3efe8ebe4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2169,55 +2169,27 @@ static int gfx_v9_4_3_xcc_kcq_fini_register(struct amdgpu_device *adev, int xcc_
 
 static int gfx_v9_4_3_xcc_kiq_resume(struct amdgpu_device *adev, int xcc_id)
 {
-	struct amdgpu_ring *ring;
-	int r;
-
-	ring = &adev->gfx.kiq[xcc_id].ring;
-
-	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-	if (unlikely(r != 0))
-		return r;
-
-	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-	if (unlikely(r != 0)) {
-		amdgpu_bo_unreserve(ring->mqd_obj);
-		return r;
-	}
-
-	gfx_v9_4_3_xcc_kiq_init_queue(ring, xcc_id);
-	amdgpu_bo_kunmap(ring->mqd_obj);
-	ring->mqd_ptr = NULL;
-	amdgpu_bo_unreserve(ring->mqd_obj);
+	gfx_v9_4_3_xcc_kiq_init_queue(&adev->gfx.kiq[xcc_id].ring, xcc_id);
 	return 0;
 }
 
 static int gfx_v9_4_3_xcc_kcq_resume(struct amdgpu_device *adev, int xcc_id)
 {
-	struct amdgpu_ring *ring = NULL;
-	int r = 0, i;
+	struct amdgpu_ring *ring;
+	int i, r;
 
 	gfx_v9_4_3_xcc_cp_compute_enable(adev, true, xcc_id);
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		ring = &adev->gfx.compute_ring[i + xcc_id * adev->gfx.num_compute_rings];
-
-		r = amdgpu_bo_reserve(ring->mqd_obj, false);
-		if (unlikely(r != 0))
-			goto done;
-		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-		if (!r) {
-			r = gfx_v9_4_3_xcc_kcq_init_queue(ring, xcc_id, false);
-			amdgpu_bo_kunmap(ring->mqd_obj);
-			ring->mqd_ptr = NULL;
-		}
-		amdgpu_bo_unreserve(ring->mqd_obj);
+		ring = &adev->gfx.compute_ring[i + xcc_id *
+			adev->gfx.num_compute_rings];
+
+		r = gfx_v9_4_3_xcc_kcq_init_queue(ring, xcc_id, false);
 		if (r)
-			goto done;
+			return r;
 	}
 
-	r = amdgpu_gfx_enable_kcq(adev, xcc_id);
-done:
-	return r;
+	return amdgpu_gfx_enable_kcq(adev, xcc_id);
 }
 
 static int gfx_v9_4_3_xcc_cp_resume(struct amdgpu_device *adev, int xcc_id)
@@ -3589,20 +3561,9 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 			return r;
 	}
 
-	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-	if (unlikely(r != 0)){
-		dev_err(adev->dev, "fail to resv mqd_obj\n");
-		return r;
-	}
-	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-	if (!r) {
-		r = gfx_v9_4_3_xcc_kcq_init_queue(ring, ring->xcc_id, true);
-		amdgpu_bo_kunmap(ring->mqd_obj);
-		ring->mqd_ptr = NULL;
-	}
-	amdgpu_bo_unreserve(ring->mqd_obj);
+	r = gfx_v9_4_3_xcc_kcq_init_queue(ring, ring->xcc_id, true);
 	if (r) {
-		dev_err(adev->dev, "fail to unresv mqd_obj\n");
+		dev_err(adev->dev, "fail to init kcq\n");
 		return r;
 	}
 	spin_lock_irqsave(&kiq->ring_lock, flags);
-- 
2.34.1

