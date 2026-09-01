Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD3BC61DD3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 08:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A8BD10E491;
	Tue,  1 Sep 2026 08:41:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IkXqfzB7";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 932BC10E3C7
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 08:41:31 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49b8e527d63so6680915e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Sep 2026 01:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788252090; x=1788856890; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dWo4zxexQG3BFmY0lNSf+g/GCUJ+1+Tx9VaU1GZ4oBw=;
 b=IkXqfzB7NBAYYi7J9fCROYNfek0v6rRQpujkB23n5O7H3tRyqzLymk+E64xSh41pv1
 ymDa5JC/NWGkUn19tDHojqsXrVnXJXZgqPL1zxNG58mX3bAlOjmQvaqWWBn8HuFFT7gV
 u+5Qvq8R6GFt1cfdj5TtRYnB3AqTnf4vqys4Wyei328F8YRn8U9IVhIUo/6to4nccUuo
 RHO78xhMbkHpTj94zPw+UbDLKPZ4nfj8bi5BEjNL1WUgEbBugwr9XcIBqaJqgRNR/5Am
 0vZTIzMSJ9c1aTiJ6kr8X1Zr7vux8Wj7McN6nPBByH8tw7W4gGtTzsgyISF4vTEO78Nb
 xWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788252090; x=1788856890;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dWo4zxexQG3BFmY0lNSf+g/GCUJ+1+Tx9VaU1GZ4oBw=;
 b=GgtoU0UDFWuH7NiTIzCu3R8f8yPwdeH1CiOgmFEANV1FvjsPmZZiBA0czxI5mReRnl
 5OEJeNdUnQdd5W+pSvss+dPWWA3be1JNHsXeszXzF4owOI3Z+KOr7l/x1zFbflEVZDNA
 bbxRletlFY51iGckAH8Y8NLbdVugUBgsGMsGREwzOCkhPi3XwTTbshB4jygoEvkiFTOS
 /tq8W8xle7LDJFQbOgMijo4fRSSJEwaXa8xwzY4bfBpz1ncw3WPUuSwzKQBMnxGznBuL
 KoyW0iiuXzZ7PvvihQZIHo4rv3jroVNoz5JX8vdMmDL6H4orMU4MmIfLO5bTP+yFdbL8
 sZpQ==
X-Gm-Message-State: AFuF++lNNNRdABooZ5Q7y0vgQ2AdepPc1kY7hCUDw2NsPvdG5v4HYN7D
 uvNiqGCGcHHUX4ckLDtdMIzvdgTrHk74dS14eVLrtvkyEhvyo6fBb3ugOpV9E+50Ucw=
X-Gm-Gg: AR+sD13TEWtLtt8fi7EfKwVR3BZEXD5Lf2gZKukp9s2oF4Kll2TN6aIgum2fhwVlwdK
 V0QvngbO+uZNKaF4yTWJJDcVxYhw3KAqxyuz8n8Jt7QjOUCZww8bnmNl1YvvWzRcUroRkvVcf+B
 g6Ez0EvzT6k+1fXnBtpyxeYMhW1IOOuUdjuYcnkFPEV9oP5ZxjTduMaKSlcbMU8zfl3jvto+dM4
 8Fherp8ihCWaMZxiSksUFWUpPdcQYsWP1Tx4SW1nhDhkWb6AkZPntw4v1xnhr/3RXn5YtwgANnQ
 RBP7Wy6KhPgw5wHgPgD2oa+K16aSFlvtrk75cesodYxUUVCX9//h7EYHLlXCL+6142FGkiNAyiS
 mqWiPaDMHeWQCWVy+6fJcRv4rldnQwbSjuxlJqZeprRL3D4oMwDVrNwwCpOc58HNFiIwj4EFLqZ
 nK19ahPliLBA1erqPSvpRud9n1YOKHsRmmbawh/sAKT5LvP6nEn0UoV2cnhhU5zyq0V9Yw+UF92
 +nxOMPzCoD5TS9MwKfSXsQ=
X-Received: by 2002:a05:600c:354b:b0:495:4d88:e630 with SMTP id
 5b1f17b1804b1-49b91c4fb4amr475210015e9.10.1788252089513; 
 Tue, 01 Sep 2026 01:41:29 -0700 (PDT)
Received: from Timur-Max (athedsl-4457084.home.otenet.gr. [79.129.242.108])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce08b8esm47139235e9.3.2026.09.01.01.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 01:41:29 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/8] drm/amdgpu/sdma: Fix executing duplicate commands after
 recovery on SDMA v4.4.2
Date: Tue,  1 Sep 2026 10:41:10 +0200
Message-ID: <20260901084115.262457-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901084115.262457-1-timur.kristof@gmail.com>
References: <20260901084115.262457-1-timur.kristof@gmail.com>
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

SDMA v4.4.2 had a custom recovery implementation that
tried to keep ring contents and restore the rptr after
an SDMA soft reset. Later it was changed to use the
more common amdgpu_sdma_reset_engine() implementation.

Currently, SDMA v4.4.2 may execute some commands twice
after a recovery:

1. From the old ring buffer contents at the restored rptr
2. From the contents restored by amdgpu_sdma_reset_engine()
   that calls the ring reset helper functions.

Fix that by removing the code that restores rptr.
This is not needed anymore because amdgpu_sdma_reset_engine()
already saves and restores the contents of both the SDMA gfx
and paging rings, so there is no need to do anything extra.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 -
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 76 +++++-------------------
 3 files changed, 14 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 686c92e96025..132ca5ce3a6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -347,8 +347,6 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	ring->buf_mask = (ring->ring_size / 4) - 1;
 	ring->ptr_mask = ring->funcs->support_64bit_ptrs ?
 		0xffffffffffffffff : ring->buf_mask;
-	/*  Initialize cached_rptr to 0 */
-	ring->cached_rptr = 0;
 
 	if (!ring->ring_backup) {
 		ring->ring_backup = kvzalloc(ring->ring_size, GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 015623b8fd05..5af539a89ba7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -423,8 +423,6 @@ struct amdgpu_ring {
 
 	bool            is_sw_ring;
 	unsigned int    entry_index;
-	/* store the cached rptr to restore after reset */
-	uint64_t cached_rptr;
 };
 
 #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p), (job), (ib)))
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 06b4bd8fca00..890513d7c18f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -660,12 +660,11 @@ static uint32_t sdma_v4_4_2_rb_cntl(struct amdgpu_ring *ring, uint32_t rb_cntl)
  *
  * @adev: amdgpu_device pointer
  * @i: instance to resume
- * @restore: used to restore wptr when restart
  *
  * Set up the gfx DMA ring buffers and enable them.
  * Returns 0 for success, error for failure.
  */
-static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, bool restore)
+static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
 {
 	struct amdgpu_ring *ring = &adev->sdma.instance[i].ring;
 	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
@@ -673,7 +672,6 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, b
 	u32 doorbell;
 	u32 doorbell_offset;
 	u64 wptr_gpu_addr;
-	u64 rwptr;
 
 	wb_offset = (ring->rptr_offs * 4);
 
@@ -693,32 +691,16 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, b
 	WREG32_SDMA(i, regSDMA_GFX_RB_BASE, ring->gpu_addr >> 8);
 	WREG32_SDMA(i, regSDMA_GFX_RB_BASE_HI, ring->gpu_addr >> 40);
 
-	if (!restore)
-		ring->wptr = 0;
+	ring->wptr = 0;
 
 	/* before programing wptr to a less value, need set minor_ptr_update first */
 	WREG32_SDMA(i, regSDMA_GFX_MINOR_PTR_UPDATE, 1);
 
-	/* For the guilty queue, set RPTR to the current wptr to skip bad commands,
-	 * It is not a guilty queue, restore cache_rptr and continue execution.
-	 */
-	if (adev->sdma.instance[i].gfx_guilty)
-		rwptr = ring->wptr;
-	else
-		rwptr = ring->cached_rptr;
-
 	/* Initialize the ring buffer's read and write pointers */
-	if (restore) {
-		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(rwptr << 2));
-		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(rwptr << 2));
-		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(rwptr << 2));
-		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(rwptr << 2));
-	} else {
-		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
-		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
-		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
-		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
-	}
+	WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
+	WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
+	WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
+	WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
 
 	doorbell = RREG32_SDMA(i, regSDMA_GFX_DOORBELL);
 	doorbell_offset = RREG32_SDMA(i, regSDMA_GFX_DOORBELL_OFFSET);
@@ -771,7 +753,7 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, b
  * Set up the page DMA ring buffers and enable them.
  * Returns 0 for success, error for failure.
  */
-static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i, bool restore)
+static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i)
 {
 	struct amdgpu_ring *ring = &adev->sdma.instance[i].page;
 	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
@@ -779,7 +761,6 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i,
 	u32 doorbell;
 	u32 doorbell_offset;
 	u64 wptr_gpu_addr;
-	u64 rwptr;
 
 	wb_offset = (ring->rptr_offs * 4);
 
@@ -787,26 +768,11 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i,
 	rb_cntl = sdma_v4_4_2_rb_cntl(ring, rb_cntl);
 	WREG32_SDMA(i, regSDMA_PAGE_RB_CNTL, rb_cntl);
 
-	/* For the guilty queue, set RPTR to the current wptr to skip bad commands,
-	 * It is not a guilty queue, restore cache_rptr and continue execution.
-	 */
-	if (adev->sdma.instance[i].page_guilty)
-		rwptr = ring->wptr;
-	else
-		rwptr = ring->cached_rptr;
-
 	/* Initialize the ring buffer's read and write pointers */
-	if (restore) {
-		WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, lower_32_bits(rwptr << 2));
-		WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, upper_32_bits(rwptr << 2));
-		WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, lower_32_bits(rwptr << 2));
-		WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, upper_32_bits(rwptr << 2));
-	} else {
-		WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, 0);
-		WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, 0);
-		WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, 0);
-		WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, 0);
-	}
+	WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, 0);
+	WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, 0);
+	WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, 0);
+	WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, 0);
 
 	/* set the wb address whether it's enabled or not */
 	WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_ADDR_HI,
@@ -820,8 +786,7 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i,
 	WREG32_SDMA(i, regSDMA_PAGE_RB_BASE, ring->gpu_addr >> 8);
 	WREG32_SDMA(i, regSDMA_PAGE_RB_BASE_HI, ring->gpu_addr >> 40);
 
-	if (!restore)
-		ring->wptr = 0;
+	ring->wptr = 0;
 
 	/* before programing wptr to a less value, need set minor_ptr_update first */
 	WREG32_SDMA(i, regSDMA_PAGE_MINOR_PTR_UPDATE, 1);
@@ -959,9 +924,9 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
 		uint32_t temp;
 
 		WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 0);
-		sdma_v4_4_2_gfx_resume(adev, i, restore);
+		sdma_v4_4_2_gfx_resume(adev, i);
 		if (adev->sdma.has_page_queue)
-			sdma_v4_4_2_page_resume(adev, i, restore);
+			sdma_v4_4_2_page_resume(adev, i);
 
 		/* set utc l1 enable flag always to 1 */
 		temp = RREG32_SDMA(i, regSDMA_CNTL);
@@ -1640,7 +1605,6 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	u32 instance_id = ring->me;
 	u32 inst_mask;
-	uint64_t rptr;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
@@ -1652,18 +1616,6 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
 		adev->sdma.instance[instance_id].page_guilty =
 			sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
 
-	/* Cache the rptr before reset, after the reset,
-	* all of the registers will be reset to 0
-	*/
-	rptr = amdgpu_ring_get_rptr(ring);
-	ring->cached_rptr = rptr;
-	/* Cache the rptr for the page queue if it exists */
-	if (adev->sdma.has_page_queue) {
-		struct amdgpu_ring *page_ring = &adev->sdma.instance[instance_id].page;
-		rptr = amdgpu_ring_get_rptr(page_ring);
-		page_ring->cached_rptr = rptr;
-	}
-
 	/* stop queue */
 	inst_mask = 1 << ring->me;
 	sdma_v4_4_2_inst_gfx_stop(adev, inst_mask);
-- 
2.55.0

