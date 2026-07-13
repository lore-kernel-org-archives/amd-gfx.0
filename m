Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372ECC44507
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 13:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C294210E998;
	Mon, 13 Jul 2026 13:07:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eSPnce2Q";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B64210E998
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 13:07:22 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493f0ae9572so12337305e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 06:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783948041; x=1784552841; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3lv740OPzSypMQdPjAzFtI2A3ANMfr/MkSnuva1lp7s=;
 b=eSPnce2QG2qW2u3MfncxIvV0za3JwckQvIeQ7OkElIae6FCCXw9SbcGzs9qHqJWpoJ
 eFvn2H3JCbjBopZMYGTNceCXJsUpZHA8qq92xFlGMDjKtLubHOyKxAZL/itF0ak/CHJr
 w09/usy8Gs7/P8RZa2ttpGuok51A19Rq8T047jwLw0uUwP3988ttqsZnJ+Twl8k9mmJa
 eiHvDhncUJlygvafO7nitHjPYz+d9OxsNqP+pEcPfFhbJE4mYQwQmrfNGrDvPbvFy2EE
 hoNLKk6N7QCFQbOk5Haw+NX+uG8GZNkuxe6qa6TuvqiHnh8EqdS4fPsI93LKUt/W2a+a
 WlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783948041; x=1784552841;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3lv740OPzSypMQdPjAzFtI2A3ANMfr/MkSnuva1lp7s=;
 b=BrupXh1kykehDnwi9jyYv2o4GlihtH9yH17F0ht5eMVEaw6E4n/GQQOoEOhGYg8QyI
 2bGntvm83xyNVMueTXbsRoGAmFY+S3qcB4TcTN6jkIWvPKtC5xjvLHy6nxVvqLA2lSI6
 XwnkWZR/4LvaqG0r/xDvhU9+A1DE2G3V+FraXPknrZk5ukbw7k5/Z184lhsB3NNYOSho
 mD5ok3+JVjysYg9qtjPoaVDnw51uPxvpWu8ZW7yEaxa/nug6is9DBU/KfCXY4a19Xcpb
 g0fPNwojkDEycB4hM8SHpT1kKPYW7cTVyIBB3/BIz9Nj0fDILEMA+Cej1LkWhCFHkXrg
 YsDA==
X-Gm-Message-State: AOJu0YyDgDzzVwGFLjydbp9xesG2jc4XSpV9ttjAHg9raPAkeK21pm40
 i3+26GjevIwVJr7Vo8l58UBPfaGRwU/7VDjmjcAPROtg/7ObW6dkemUbCQEAgA==
X-Gm-Gg: AfdE7cmeB18tu2slrlaNXTItea5YZw0yIrJbVd015O4Y/9aTuuHmM/12EvYF2HcnXZ/
 SmaGF7IgF8h+mtpsfY1gaNYzt6qDaU7cc9jEcYUd4fUts70W66fuX8RpG1DjNVqONw1gaJP3vsJ
 yXQtWM4lrCs4LOXIGhJgsb2GqHhTYWImmYEbhal6RioAd9U3VT0AMVUBS+nYuzbYLBcBpXeHwAw
 Dys5aSA+iQsQuwy1UYGqyJfUlY2l6naFCopGyiNh64JTAOBVnciXZ8XTlCodwcMVdvE63xHfy3W
 kX5EbdAPBD+tstUHSNgRkzNhB83wFbBASnFmBOopxSCpVuTiQQMlFRMeK3pw/kx61tl7S4S7DYX
 Ls20c+h5/3ecAPOZ6lp7pmIbLqkzE5t/R63XHMRJtFp5F3NWG4Cuu1BRfSyxm1DnpLy8Ci9WM4x
 0XW/iXECoVlskzrN+si7Nf7wFpi2gLmnmXse8NlNlqokQaCcKi08DiuPA4aJaPvp5a
X-Received: by 2002:a05:600c:8b35:b0:493:bb6b:5bb5 with SMTP id
 5b1f17b1804b1-493f87ebd6cmr97832535e9.13.1783948040776; 
 Mon, 13 Jul 2026 06:07:20 -0700 (PDT)
Received: from Timur-Hyperion.home (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6df417sm387974995e9.8.2026.07.13.06.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 06:07:19 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Tvrtko Ursulin <tursulin@ursulin.net>,
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 03/11] drm/amdgpu/gfx6: Use PFP on the compute queues too
Date: Mon, 13 Jul 2026 15:07:01 +0200
Message-ID: <20260713130709.34262-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713130709.34262-1-timur.kristof@gmail.com>
References: <20260713130709.34262-1-timur.kristof@gmail.com>
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

On GFX6, the compute rings use the same CP path as
the graphics ring. The only difference is that they
don't support draw commands. (As opposed to GFX7 and
newer which have a separate command parser that is
called MEC for compute queues.)

This means that we have to take into consideration
that the PFP also exists on compute queues on GFX6:

Use PFP for register writes on both graphics and
compute queues.

In the pipeline sync, use the PFP to wait for the
previous fence (and not the ME) to prevent the PFP
from starting to execute the next submission while
the ME is still in the previous submission.

In the VM flush, writing the TLB flush registers
is now done by the PFP. Synchronize PFP to ME before
doing the TLB flush to make sure the ME isn't using the
VMID being flushed. Then the register is read by the
PFP now so there is no need to sync with ME afterwards.

Fixes: 2cd46ad22383 ("drm/amdgpu: add graphic pipeline implementation for si v8")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 1a9866e40912..8e8e5fe487f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -2347,14 +2347,13 @@ static int gfx_v6_0_cp_resume(struct amdgpu_device *adev)
 
 static void gfx_v6_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 {
-	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
 	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
 	amdgpu_ring_write(ring, (WAIT_REG_MEM_MEM_SPACE(1) | /* memory */
 				 WAIT_REG_MEM_FUNCTION(3) | /* equal */
-				 WAIT_REG_MEM_ENGINE(usepfp)));   /* pfp or me */
+				 WAIT_REG_MEM_ENGINE(1))); /* pfp */
 	amdgpu_ring_write(ring, addr & 0xfffffffc);
 	amdgpu_ring_write(ring, upper_32_bits(addr) & 0xffffffff);
 	amdgpu_ring_write(ring, seq);
@@ -2365,34 +2364,29 @@ static void gfx_v6_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 static void gfx_v6_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 					unsigned vmid, uint64_t pd_addr)
 {
-	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
+	/* sync PFP to ME, otherwise ME might still use the VMID when we flush it */
+	amdgpu_ring_write(ring, PACKET3(PACKET3_PFP_SYNC_ME, 0));
+	amdgpu_ring_write(ring, 0x0);
 
+	/* Write VM_CONTEXT0_PAGE_TABLE_BASE_ADDR and VM_INVALIDATE_REQUEST using PFP */
 	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
 
 	/* wait for the invalidate to complete */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
 	amdgpu_ring_write(ring, (WAIT_REG_MEM_FUNCTION(0) |  /* always */
-				 WAIT_REG_MEM_ENGINE(0))); /* me */
+				 WAIT_REG_MEM_ENGINE(1))); /* pfp */
 	amdgpu_ring_write(ring, mmVM_INVALIDATE_REQUEST);
 	amdgpu_ring_write(ring, 0);
 	amdgpu_ring_write(ring, 0); /* ref */
 	amdgpu_ring_write(ring, 0); /* mask */
 	amdgpu_ring_write(ring, 0x20); /* poll interval */
-
-	if (usepfp) {
-		/* sync PFP to ME, otherwise we might get invalid PFP reads */
-		amdgpu_ring_write(ring, PACKET3(PACKET3_PFP_SYNC_ME, 0));
-		amdgpu_ring_write(ring, 0x0);
-	}
 }
 
 static void gfx_v6_0_ring_emit_wreg(struct amdgpu_ring *ring,
 				    uint32_t reg, uint32_t val)
 {
-	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
-
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(usepfp) |
+	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(1) | /* pfp */
 				 WRITE_DATA_DST_SEL(0)));
 	amdgpu_ring_write(ring, reg);
 	amdgpu_ring_write(ring, 0);
@@ -3556,7 +3550,7 @@ static const struct amdgpu_ring_funcs gfx_v6_0_ring_funcs_compute = {
 	.emit_frame_size =
 		5 + 5 + /* hdp flush / invalidate */
 		7 + /* gfx_v6_0_ring_emit_pipeline_sync */
-		SI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + /* gfx_v6_0_ring_emit_vm_flush */
+		SI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 2 + /* gfx_v6_0_ring_emit_vm_flush */
 		14 + 14 + 14 + /* gfx_v6_0_ring_emit_fence x3 for user fence, vm fence */
 		3 * 2 + /* gfx_v6_0_ring_emit_sb x3 (from amdgpu_vm_flush, amdgpu_ib_schedule) */
 		5, /* SURFACE_SYNC */
-- 
2.55.0

