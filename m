Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3542EC44532
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 11:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADE3C10E947;
	Tue, 21 Jul 2026 11:43:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RlYccwKh";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4114810E93A
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 11:43:32 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c15f360851aso1201000766b.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 04:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784634211; x=1785239011; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tuWl18n6f/vvwxs09ejkKqkDFVTf5KS60/MXFZu7lC4=;
 b=RlYccwKhpgOaPTfiAtCKzChNDXiETUJtmqdKU5ciDDKWztBvRA3cG7IjUFzKfEhSBx
 zKTwXMhMdJBuKw5K5tWQb3v/g3KAisQcUp+szqN2yfGR3zCrpR9zFudp9KqoF1rQN7xM
 inXBwJBMGrgKxieieVzZ8Dc7A4fDvOjaH41QpgNCBndegqFEQ1qPHq/8OTQJ8mVoSlua
 sxrTrt/hm8X6RB5qqZbve0Emc4HDgKiXt8Ssxg6zeTh+LAHpvJ7Ez6rqYcMmkIiXwBDY
 CNToq9yffckJI5Vj3p97hh0DWp4GkqbuuMtC+Do9vw13qkfg0+Wrk6RcOSJp0UKTSBwy
 WyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784634211; x=1785239011;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tuWl18n6f/vvwxs09ejkKqkDFVTf5KS60/MXFZu7lC4=;
 b=Z4EgGRu/ZonypIvvLNx9YxQFNl9eLIzutgDPZ1Z0MFVbP33MPFbK3iogv6y8n0S+Na
 FoO1VmLFxILbfoNmr6PvF2Hcvc5qGhOa9XD9/mN/oF+z73eVjlwozWRNqGyC4s9Ak/1q
 avd4WclKiymqOs/F8BeFCFPJTdjWVYoIuK1qJW7GLKMhYfusijJuOBIwi7Ra+j5o0HAB
 UZWwBC9V9I+2I/lKd6ErI3CcdBmL9XMiLxPNxg/yczKN+jOChqdHDSN4CQXChhZaqyh4
 +qQYO3/m9zomZSm79iCO8Iaqm6mwBNcVu3vcZVO5e0N7J1cP0vIZGdWce/DLenXHBvBc
 Dg4g==
X-Gm-Message-State: AOJu0YwYVmdnZqaHJ9fE8VrAkiZIGbL9ySIZpqSnWYH+H5uNpYISImmx
 AHNWvMen+ISJR7Tws+ImJxSCnT0Jv/pg4fl1pT+naGUIFiRVm1NTGGTDdBnt+DYh
X-Gm-Gg: AR+sD12nKPLcHaJUR/qSX2lQN/6N6Ncy9SfSsBueBOJoJ9pyHzOEN5XLBbvjpk0NAZ/
 z2Y8ulOawYu2DwPiInd/bAjczrOWp+qmsfaSaZcsrp8tipi+Q0zbK/xvQk/uu2e/qdx2kgylP5B
 QkTzk6KfnbyuL2AcjxH4wMnWK4/QYoWv34qkb6GmZpu551ryvaGTNLSy/hL8bYYYwRj19W2C2Dt
 Hv3LIOEi497yS2SZMhrst0IYlKvMuR7tiU6QWXrt+mKwRukS2ISSqmzknypFXP3GgXVD1vn1kH6
 SYvlxjP1bcKUTlQZZJCNZNcLPTR7RoKz4Phic6r5LNzntPtobXTITtAVzMqqa6jdoopsAvB5YwW
 LEVbS0GDgic2IpSGxkY8wpcRPM2D1BGyVqnrTNAV+Bgm75SFppeMyg3IkTgPK0TiTYM0ftD0iyo
 +etoX8pQBsPxf4cnaU6EbT2mSL2hKdLwpAz2t+qlAn1QHI1ORCFJm41g==
X-Received: by 2002:a17:907:c012:b0:c15:e8c8:34d with SMTP id
 a640c23a62f3a-c16b47d83b6mr741647966b.47.1784634208742; 
 Tue, 21 Jul 2026 04:43:28 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D94C.dsl.pool.telekom.hu.
 [84.1.217.76]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c17009ae00asm571635366b.7.2026.07.21.04.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 04:43:28 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 2/9] drm/amdgpu/gfx7: Refactor MQD initialization and
 finalization
Date: Tue, 21 Jul 2026 13:43:15 +0200
Message-ID: <20260721114322.17535-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721114322.17535-1-timur.kristof@gmail.com>
References: <20260721114322.17535-1-timur.kristof@gmail.com>
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

Call amdgpu_gfx_mqd_sw_init()/_fini() on GFX7 to initialize and
finalize MQD BOs, just like GFX8 and newer; instead of doing
an ad-hoc BO allocation. Introduce the possibility of backing
up the MQD instead of trying to reinitialize every time.

This solves an issue with GFX IP block soft reset where
all compute rings would hang after the reset.

Rename gfx_v7_0_mqd_deactivate() to gfx_v7_0_deactivate_hqd()
to more closely reflect what it does and for consistency
with the GFX8 code.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 106 +++++++++++++-------------
 1 file changed, 51 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 65b8497ad5f0..1fac8ccfd381 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2698,25 +2698,6 @@ static int gfx_v7_0_cp_compute_load_microcode(struct amdgpu_device *adev)
 	return 0;
 }
 
-/**
- * gfx_v7_0_cp_compute_fini - stop the compute queues
- *
- * @adev: amdgpu_device pointer
- *
- * Stop the compute queues and tear down the driver queue
- * info.
- */
-static void gfx_v7_0_cp_compute_fini(struct amdgpu_device *adev)
-{
-	int i;
-
-	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
-
-		amdgpu_bo_free_kernel(&ring->mqd_obj, NULL, NULL);
-	}
-}
-
 static void gfx_v7_0_mec_fini(struct amdgpu_device *adev)
 {
 	amdgpu_bo_free_kernel(&adev->gfx.mec.hpd_eop_obj, NULL, NULL);
@@ -2788,28 +2769,29 @@ static void gfx_v7_0_compute_pipe_init(struct amdgpu_device *adev,
 	mutex_unlock(&adev->srbm_mutex);
 }
 
-static int gfx_v7_0_mqd_deactivate(struct amdgpu_device *adev)
+static int gfx_v7_0_deactivate_hqd(struct amdgpu_device *adev, u32 req)
 {
-	int i;
+	int i, r = 0;
 
 	/* disable the queue if it's active */
-	if (RREG32(mmCP_HQD_ACTIVE) & 1) {
-		WREG32(mmCP_HQD_DEQUEUE_REQUEST, 1);
+	if (RREG32(mmCP_HQD_ACTIVE) & CP_HQD_ACTIVE__ACTIVE_MASK) {
+		WREG32_FIELD(CP_HQD_DEQUEUE_REQUEST, DEQUEUE_REQ, req);
 		for (i = 0; i < adev->usec_timeout; i++) {
-			if (!(RREG32(mmCP_HQD_ACTIVE) & 1))
+			if (!(RREG32(mmCP_HQD_ACTIVE) & CP_HQD_ACTIVE__ACTIVE_MASK))
 				break;
 			udelay(1);
 		}
 
 		if (i == adev->usec_timeout)
-			return -ETIMEDOUT;
+			r = -ETIMEDOUT;
 
-		WREG32(mmCP_HQD_DEQUEUE_REQUEST, 0);
-		WREG32(mmCP_HQD_PQ_RPTR, 0);
-		WREG32(mmCP_HQD_PQ_WPTR, 0);
 	}
 
-	return 0;
+	WREG32(mmCP_HQD_DEQUEUE_REQUEST, 0);
+	WREG32(mmCP_HQD_PQ_RPTR, 0);
+	WREG32(mmCP_HQD_PQ_WPTR, 0);
+
+	return r;
 }
 
 static void gfx_v7_0_mqd_init(struct amdgpu_device *adev,
@@ -2964,31 +2946,42 @@ static int gfx_v7_0_mqd_commit(struct amdgpu_device *adev, struct cik_mqd *mqd)
 
 static int gfx_v7_0_compute_queue_init(struct amdgpu_device *adev, int ring_id)
 {
-	int r;
-	u64 mqd_gpu_addr;
-	struct cik_mqd *mqd;
 	struct amdgpu_ring *ring = &adev->gfx.compute_ring[ring_id];
-
-	r = amdgpu_bo_create_reserved(adev, sizeof(struct cik_mqd), PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
-				      &mqd_gpu_addr, (void **)&mqd);
-	if (r) {
-		dev_warn(adev->dev, "(%d) create MQD bo failed\n", r);
-		return r;
+	struct cik_mqd *mqd = ring->mqd_ptr;
+	int mqd_idx = ring - &adev->gfx.compute_ring[0];
+
+	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
+		memset((void *)mqd, 0, ring->mqd_size);
+		mutex_lock(&adev->srbm_mutex);
+		cik_srbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+		gfx_v7_0_mqd_init(adev, mqd, ring->mqd_gpu_addr, ring);
+		gfx_v7_0_deactivate_hqd(adev, 1);
+		gfx_v7_0_mqd_commit(adev, mqd);
+		cik_srbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+
+		if (adev->gfx.mec.mqd_backup[mqd_idx])
+			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, ring->mqd_size);
+	} else {
+		/* restore MQD to a clean status */
+		if (adev->gfx.mec.mqd_backup[mqd_idx])
+			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], ring->mqd_size);
+
+		/* Re-commit the restored backup */
+		mutex_lock(&adev->srbm_mutex);
+		cik_srbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+		gfx_v7_0_deactivate_hqd(adev, 2);
+		gfx_v7_0_mqd_commit(adev, mqd);
+		cik_srbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+
+		/* reset ring buffer */
+		ring->wptr = 0;
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
+		atomic64_set((atomic64_t *)ring->rptr_cpu_addr, 0);
+		amdgpu_ring_clear_ring(ring);
 	}
 
-	mutex_lock(&adev->srbm_mutex);
-	cik_srbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-
-	gfx_v7_0_mqd_init(adev, mqd, mqd_gpu_addr, ring);
-	gfx_v7_0_mqd_deactivate(adev);
-	gfx_v7_0_mqd_commit(adev, mqd);
-
-	cik_srbm_select(adev, 0, 0, 0, 0);
-	mutex_unlock(&adev->srbm_mutex);
-
-	amdgpu_bo_kunmap(ring->mqd_obj);
-	amdgpu_bo_unreserve(ring->mqd_obj);
 	return 0;
 }
 
@@ -3020,10 +3013,8 @@ static int gfx_v7_0_cp_compute_resume(struct amdgpu_device *adev)
 	/* init the queues */
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		r = gfx_v7_0_compute_queue_init(adev, i);
-		if (r) {
-			gfx_v7_0_cp_compute_fini(adev);
+		if (r)
 			return r;
-		}
 	}
 
 	gfx_v7_0_cp_compute_enable(adev, true);
@@ -4430,6 +4421,11 @@ static int gfx_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
+	/* create MQD for all compute queues */
+	r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct cik_mqd), 0);
+	if (r)
+		return r;
+
 	adev->gfx.ce_ram_size = 0x8000;
 
 	gfx_v7_0_gpu_early_init(adev);
@@ -4452,7 +4448,7 @@ static int gfx_v7_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->gfx.num_compute_rings; i++)
 		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
 
-	gfx_v7_0_cp_compute_fini(adev);
+	amdgpu_gfx_mqd_sw_fini(adev, 0);
 	amdgpu_gfx_rlc_fini(adev);
 	gfx_v7_0_mec_fini(adev);
 	amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
-- 
2.55.0

