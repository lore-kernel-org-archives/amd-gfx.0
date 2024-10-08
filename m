Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862DECEFC38
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 18:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DD6B10E238;
	Tue,  8 Oct 2024 18:11:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hIUz1cHk";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8653A10E238
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 18:11:37 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-a99422929c5so401131266b.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Oct 2024 11:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728411096; x=1729015896; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=0LzL2F/J08MGzCeQsydX6hPYw1M+b93sSEtHEp8SDDU=;
 b=hIUz1cHkWJp5BTWTOwWBTayT80dOPVDBU4e2Vwilf9InCnsFwEiWfyXUZILxBBYvGH
 6Ld7H6UTQPVgLjjNEN/XGa+oiK0m73+UaFFQSO6kWAr3eEpA6UjQrPSpeCHTd4H+OLTS
 eO+Dcc/Nz7/67OJembFlv3V2CBA6alJV3PWDGmCoSqf3NdeIDoAPicNZ43uq+1UPsVkT
 uZV2SWKl2Z6HQzpsKr6zb0JskuLmVc8/KjjPN9f0F4h9CRvwfa8y40HABZmWv64JF3Px
 v6/oc+MFl200l2IzHtgv4dmMQaE3W4mP2qYz4N7aStgLXbYGhGQhB+Ec0gxhxEYJ+VEh
 pahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728411096; x=1729015896;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0LzL2F/J08MGzCeQsydX6hPYw1M+b93sSEtHEp8SDDU=;
 b=o5V2bvTouJdsM0cF87edrylDlIVrmi1HM+ekBm25w7WqZnO/8Omy4odjNtG1x7f/ee
 KVe/IX7Iky5X7mb/DuG3rTP8cCsn3Zl6AZw/6w7LYjmUWILpG5rDygptP+eFxyQO0VSJ
 nROAD9wIoseHKjlIxV/r1JVK7EGmnfFxiULIFhPPVxmLNmp/sN2a4xoVoYhND6VhQcEp
 HndCwIErnuAWvReGT0y28YheAqAuqDWopzjyJiy46mrgS8+HYdmEmPF7yPZkllCS3MuR
 Y0nlQwqQ+NsdTk7oel8Fszgl3HJhL8CqVKymguK9if2i8yI/+YX3eUZBtJXZt3G9GTjP
 YeSg==
X-Gm-Message-State: AOJu0YzNTOOFjZfkoUNdVt0303ZptLmqNf5moKLUgrkmF0wxo6yKR0NR
 aBR4uS6E00Bc7+nZ8FR4Sv1TSXAzLaOwLJNVrm/cuFjjBlAE5VjMWjzNX6Xp
X-Google-Smtp-Source: AGHT+IHSpS0ceDN2oiNLDsx46jAl+j8+OL0cO+yUo1UiOrCghoKjcUczHMxhfGk+DRYwrLQTeu4S5Q==
X-Received: by 2002:a17:906:eec2:b0:a99:46cd:1d84 with SMTP id
 a640c23a62f3a-a9946cd1e74mr1046096066b.25.1728411095471; 
 Tue, 08 Oct 2024 11:11:35 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15ee:d600:b61a:9639:f0e8:34b5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a996274deeesm182016866b.103.2024.10.08.11.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 11:11:35 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, tursulin@igalia.com, sunil.khatri@amd.com
Subject: [PATCH 1/2] drm/amdgpu: drop volatile from ring buffer
Date: Tue,  8 Oct 2024 20:11:33 +0200
Message-Id: <20241008181134.1350-1-christian.koenig@amd.com>
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

Volatile only prevents the compiler from re-ordering reads and writes.
Since we always only modify the ring buffer from one CPU thread and have
an explicit barrier before signaling the HW this should have no effect at
all and just prevents compiler optimisations.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 10 +++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 11 ++++-------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 910293664902..a6e28fe3f8d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -109,21 +109,17 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
 void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	uint32_t occupied, chunk1, chunk2;
-	uint32_t *dst;
 
 	occupied = ring->wptr & ring->buf_mask;
-	dst = &ring->ring[occupied];
 	chunk1 = ring->buf_mask + 1 - occupied;
 	chunk1 = (chunk1 >= count) ? count : chunk1;
 	chunk2 = count - chunk1;
 
 	if (chunk1)
-		memset32(dst, ring->funcs->nop, chunk1);
+		memset32(&ring->ring[occupied], ring->funcs->nop, chunk1);
 
-	if (chunk2) {
-		dst = ring->ring;
-		memset32(dst, ring->funcs->nop, chunk2);
-	}
+	if (chunk2)
+		memset32(ring->ring, ring->funcs->nop, chunk2);
 
 	ring->wptr += count;
 	ring->wptr &= ring->ptr_mask;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 574336d6714a..36fc9578c53c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -246,7 +246,7 @@ struct amdgpu_ring {
 	struct drm_gpu_scheduler	sched;
 
 	struct amdgpu_bo	*ring_obj;
-	volatile uint32_t	*ring;
+	uint32_t		*ring;
 	unsigned		rptr_offs;
 	u64			rptr_gpu_addr;
 	volatile u32		*rptr_cpu_addr;
@@ -288,7 +288,7 @@ struct amdgpu_ring {
 	u64			cond_exe_gpu_addr;
 	volatile u32		*cond_exe_cpu_addr;
 	unsigned int		set_q_mode_offs;
-	volatile u32		*set_q_mode_ptr;
+	u32			*set_q_mode_ptr;
 	u64			set_q_mode_token;
 	unsigned		vm_hub;
 	unsigned		vm_inv_eng;
@@ -386,10 +386,8 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
 					      void *src, int count_dw)
 {
 	unsigned occupied, chunk1, chunk2;
-	void *dst;
 
 	occupied = ring->wptr & ring->buf_mask;
-	dst = (void *)&ring->ring[occupied];
 	chunk1 = ring->buf_mask + 1 - occupied;
 	chunk1 = (chunk1 >= count_dw) ? count_dw : chunk1;
 	chunk2 = count_dw - chunk1;
@@ -397,12 +395,11 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
 	chunk2 <<= 2;
 
 	if (chunk1)
-		memcpy(dst, src, chunk1);
+		memcpy(&ring->ring[occupied], src, chunk1);
 
 	if (chunk2) {
 		src += chunk1;
-		dst = (void *)ring->ring;
-		memcpy(dst, src, chunk2);
+		memcpy(ring->ring, src, chunk2);
 	}
 
 	ring->wptr += count_dw;
-- 
2.34.1

