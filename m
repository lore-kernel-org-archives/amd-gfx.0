Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3155C79F99
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 18:11:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7976410E8C1;
	Tue,  8 Sep 2026 18:11:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RoH3e/Re";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13BA710E8C1
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 18:11:10 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so39016425e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Sep 2026 11:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788891068; x=1789495868; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nsX0s+NIbxTlU46SNcig6knlLOp4ZXdfSVseKyMtu9Y=;
 b=RoH3e/ReBRHRmAril1snfaTiaDcTyh3De1q+TZ8FUT1881O5ALHowX2N130AS3ECkp
 /stPDyXY75w2rP41SPsliXZiq9oxAQ3DlFpHKhshazPepc0VtsgnsBfKJtT2ANjOP8qI
 y8XF4dPZ15DYge/s8izGyFuLSfmTBMz3L6LXCDKygTi3ANI8x7PzBMgzInurkjy8QrEg
 2nLK5dYv4yF9qqPy3Ajtbkxewjzaph6bVU18Vh2BJD1dWBuryCRRl1ddaE57rE9Ya+ax
 HJOOhjLX7C7h86Sd5mWA6kKLTxB/Gq/2ITQYpxhQG8yzmlybQIOvTBSr2gAhGX4WKxsM
 YNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788891068; x=1789495868;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nsX0s+NIbxTlU46SNcig6knlLOp4ZXdfSVseKyMtu9Y=;
 b=OJNb0vpmeWuIUf8UHgFU/JjFiUXW8IqwIl7TRcm5AP6Bs6uzol7pOJq3K9SQyHmuTW
 3p59Dts3L/z/adnJf3hq4EBYr3D5YFXBKbQFwAc4dBc2ohXrw0TaQV9oDp2vKzWpdsQt
 CVPUv4gUW7Sklp+qJhGUTIDMJPuOb1fIEYemuxfjVFSao5VT9umc4Gl64Lz5BYqgszrM
 6kaC6IrTJ82fv0101/VQQsHtsgKoTS2I4CntbJOwYmtqXmDSLUj091Ehj9J0LGVbAgJF
 exj2spNHLk/gC+DbMlLWrA4YzMDxHLubXYRFaRQrS4p/Ia7AbsVkFiB5nOlp6fWJO+L7
 crHw==
X-Gm-Message-State: AFuF++lnOSpLn1fo/pOTOIHlKo6HqLKKuQb48JFfS7jIRTONgZG7reZY
 zmCyLLnRqu8FNy6GKLK7PUKxlCnPl5Y52l2T3S2NGygVUDDW9zln5RVhwHX3zoEu
X-Gm-Gg: AYBFou2A75S8RJxND/z3aUW6bW/BuhHc1X73SIm8hX0c/l3rIhfu1OFVRi7bREN14XZ
 r9w3wwpXmAIZb2Deo062aAlReHbtJBpx4t8TK2ORDVWl832i9m37XdXWwLdADdHgJ5k7Cl8pvte
 gLYZNrlsj8vdsgofv9LeXKsY12FB9nGi5VQ9hnw7YPIIF8veJjd+qYnonSj4SA4r0GILhg1CT5K
 /DlGetdnCRXEXOCAanrM/MAdZpv9oQj1wxF744OpSbM5ehYXw7a+09MBOqXNNOWtQm4lIedVzMm
 a4XL0+z37irUMakjVvxiSja1kB1ycckQxys45Nq4WIMQ1cFq8w2x+5pHo6BvdM9W7T2lIeWDPhr
 Dxje2QleIsx1N+OSnwOpz46RTkcPct218/fCWAKZ64TfYI3t0MFIlzxmQwl9T57lmFgpLN4NmiN
 dBkEXKb2gRyCp2CClJGc5AvO2L042kZl4pvkcVMOr9pC+PIjzcpkK6Lyox8XgLyj3tbdVMsFe1f
 +u5pQInLTfJr2gbDJa2
X-Received: by 2002:a05:600c:310d:b0:49c:dc14:d681 with SMTP id
 5b1f17b1804b1-49cf81e5449mr309126125e9.3.1788891068312; 
 Tue, 08 Sep 2026 11:11:08 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d1fb1e4e4sm5190125e9.2.2026.09.08.11.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 11:11:07 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/9] drm/amdgpu/sdma: Fix executing duplicate commands after
 recovery on SDMA v4.4.2
Date: Tue,  8 Sep 2026 20:10:46 +0200
Message-ID: <20260908181052.381126-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908181052.381126-1-timur.kristof@gmail.com>
References: <20260908181052.381126-1-timur.kristof@gmail.com>
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
index 6b6ee4083c8d..61e30de1977b 100644
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
index 7e8d528cf422..53c816043eb8 100644
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
@@ -1645,7 +1610,6 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	u32 instance_id = ring->me;
 	u32 inst_mask;
-	uint64_t rptr;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
@@ -1657,18 +1621,6 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
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

