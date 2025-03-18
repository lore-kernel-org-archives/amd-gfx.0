Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2AEC28B2F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 15:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B51DC10E4A9;
	Tue, 18 Mar 2025 15:19:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XrZ1FHli";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA49F10E4A9
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 15:19:18 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-5e5b56fc863so8078416a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742311157; x=1742915957; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dz0YpjdyJ1556ZOcMQlMie+5D3COD7W1uRUSUJ6odqA=;
 b=XrZ1FHli6Vimqp7nykTwKCvhFm21txMyTrg5YdXbNo/baFBUnVeFt+hpO11fEUNOHP
 HUrndP/HB5+0wp7xfKIO4+JE2M2ugjmy9KpndoYzNrf5RoIuEZKmLTs44j6qhSKVSIJx
 yvkoOqk0v+R7OnNis6f/I4WdyhbKroTUAk9b0p6fBJseXoeCKoNqU2BRJ9sVhQ4/4NnK
 2+6nWfzCc8iG6a5w77cLhjExlzKZwH/RRGrqyq5UEMTa1/61JcxfB2Zo3F0Ap5tC0Yvk
 rG1l2BCnmDw4NrmcJ9/9zFzfKpP5hGlOFtgV3FMw3v0b3st5QYuGGYC9qZGKcQmcxglF
 hkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742311157; x=1742915957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dz0YpjdyJ1556ZOcMQlMie+5D3COD7W1uRUSUJ6odqA=;
 b=B8y+Nr+pWnddQ6IvBk25IQ5VYS4VMHozDbcYayb+x/WLh+vw6qjNlLVhWPFBMiXw31
 sVAnX+aRTPjusyw/R16woEtnb8LmYpyjotHIxu0rF85oJQhhN1Unojr6XMcEs5ihzSX0
 O39YGWke5t4/rerCVqnHhtagpBWYfjUWar/4Ju8eP4CYVdjIDkexISMh84GWFTQ3UPUL
 blmg3DChEx9819ta3W0S2E2CIhczvT4syQqIG07/VoGs1pSkjeat3k4HKKIbSe+sl8xf
 LP0MuVuEptLiTXEaZbV4ETQM7w2etnaeKtdmHrpSssJUo8T0EKdI6OriTimPCuDBhcda
 Msvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmrAbPgA8OHrUkYPglye7MWVBoXB9DVLfZQRDlHT6hGjsi5m/xGZokUH8RVYk6IOYZwonnx+kx@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwptgxFb2wD4n9US+R1XGAdJR20pFYv6krbCaLI7WSOmrmms2Ol
 Ll51rM0X7oAvYfPJNxihUsOmosUF/ag3+NVpBuBVbOFHZm//5B3bZr245ldl
X-Gm-Gg: ASbGncsRpc6oBtvyhydw6z5Qgmg0b1env4t8cqmzsNqc57qw24kowBloDguy5SYlBzF
 uJ0C26qs46wGxkDktzxjCi77umA1zDcrQVyPmTahxwbkZUwvPHswq5W75aMUAUUK4dDOBo7DFLq
 MSh4H+UPsCLvNgmB/WIcY5QWaESHrTkzFiFKIzFNN6jQoEjnwzCOaJt98SCt6HDeOBAeGYwza2z
 chC8ZCfSVJwC8fXTcvzMjyyQS+TYog3ZS1/7M/dEwCstQMDIY8Z+8o1CqEUBq5iYYBEvSMzJA+u
 fyRsExB3cKnqKkGQgNGIKsVhUMNZsLRNv0Y7uXyuPC5HWnXmpih2aZ29wA==
X-Google-Smtp-Source: AGHT+IH2vjF6eUZfVtRNtXKAnDIpCvL9RhaFSjofSRPwq3LsrfqqI/97eprA27eivM37Bbfe5sKr7w==
X-Received: by 2002:a05:6402:354d:b0:5e5:bdfe:6c16 with SMTP id
 4fb4d7f45d1cf-5eb1deab100mr3861526a12.3.1742311156812; 
 Tue, 18 Mar 2025 08:19:16 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1527:7100:dc64:6e75:5ed1:a43e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e816974b63sm7846852a12.28.2025.03.18.08.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 08:19:16 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexdeucher@gmail.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: stop unmapping MQD for kernel queues
Date: Tue, 18 Mar 2025 16:19:15 +0100
Message-Id: <20250318151915.5413-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318151915.5413-1-christian.koenig@amd.com>
References: <20250318151915.5413-1-christian.koenig@amd.com>
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

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  88 +++-----------------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  88 +++-----------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 102 ++++--------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  45 ++---------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  57 ++-----------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  61 +++-----------
 6 files changed, 59 insertions(+), 382 deletions(-)

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
index 95eefd9a40d2..5961fe15a3e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4134,22 +4134,9 @@ static int gfx_v11_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
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
@@ -4475,57 +4462,24 @@ static int gfx_v11_0_kcq_init_queue(struct amdgpu_ring *ring, bool reset)
 
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
@@ -6688,20 +6642,9 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
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
 
@@ -6728,20 +6671,9 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
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
index 9cb499195fff..bcbb9dffe987 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3047,37 +3047,19 @@ static int gfx_v12_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
 
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
@@ -3394,57 +3376,25 @@ static int gfx_v12_0_kcq_init_queue(struct amdgpu_ring *ring, bool reset)
 
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
@@ -5272,20 +5222,9 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
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
 
@@ -5312,20 +5251,9 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
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
index d345285ea885..1080e9198ad9 100644
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
@@ -7319,20 +7287,9 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
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

