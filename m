Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133EFC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 12:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 762A210E595;
	Mon, 25 Apr 2022 12:23:52 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6C9410E503
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 12:23:51 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id h12so22928982plf.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 05:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dzFm1XZWI2Qh6PbNdtmoo5qtNeP6zaJIucZ8A9qqv6A=;
 b=qb6gxF1X5DQa3KgJJnULL2rqyYoZ/xQK7Ejg6ru2pmAoMCyuuWgzSQ/8/aPS5UVOtU
 KgzA7WkD4MOyp+dJR2Fuf7+53TyVDKECTxpuPf75S87T50vHdxzT/zbt1IvwX/iveO8J
 TrMDUidZIsWebXTKsQKV47/UGBzVyr7v+vPGYNc3pff39NS4+sCO/Zvn/x9WDJw7z5l3
 9nQs+blsvma2fmkKwIrMxZ2B5zDWVlXqOAQjRcKJvxI+lD/nGISQKmy8+P7Y5FIIYZhJ
 hZAWAz3gdVTeTg4MhkE9BGeSKbq34bJbXZsxH3Sr4oPOf9E1lIRLg3tG9dtp0JMB4H8I
 y14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dzFm1XZWI2Qh6PbNdtmoo5qtNeP6zaJIucZ8A9qqv6A=;
 b=evg1DZY3Qdix4Bsdf8mjHm3CyJW6N1zAaxGTRJ3I99VqlBwwB9KIX1xGoQtYg42FHo
 rWv0S3W5TdSJD7hnVcHIuufV0ivfJ2WUp3CNQoXyNTFe1XHMC3hmNbKBxc5oWEO94OBI
 axDpe1kiSfELfmESK0kPpijqwevzOhQP2PSMpz/sNnjSeuetc6Usl97wSmy9ov9fEOT3
 3pkSz0zGxEESq1PP1EMT/9jqmF+91chfiXqTqhp7l5sduC9mh9wXDBOUDBpLNbD6wV/3
 obP6LkozDLDNS6WoaD+z2yGlmFqZaDjoKqHQ1o7lBeQi9Zc7Vn52POrvYwwAFS2jsPmD
 iASw==
X-Gm-Message-State: AOAM532cCEwWEpEmpjTDL0Nwx7u3U4Z+JuxyC69fo6AvrZDg+2kjqEcP
 5LNH79Ahbg6PuOHmOQLNOHu61XHk0OD3vhbzL/bdwgSrNeWH0g==
X-Google-Smtp-Source: ABdhPJwO9E1mVrQjOvjfsdenVH3h5hxJioBXRURUb72vH/P20/jVyX+LuHfskX1joUgNNeTvv5D1bzINQ0ZAnHD4jtE=
X-Received: by 2002:a17:90a:488c:b0:1c7:b62e:8e8c with SMTP id
 b12-20020a17090a488c00b001c7b62e8e8cmr30966063pjh.157.1650889431167; Mon, 25
 Apr 2022 05:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpOOhHdH8=zEGu1oX_7DGTotO7pnXLk_XGyKddk89iaTJ1rKw@mail.gmail.com>
 <ff41e2a0-ae1a-7394-0060-aed4ab542927@gmail.com>
In-Reply-To: <ff41e2a0-ae1a-7394-0060-aed4ab542927@gmail.com>
From: Haohui Mai <ricetons@gmail.com>
Date: Mon, 25 Apr 2022 20:23:38 +0800
Message-ID: <CAHpOOhEq_0NQ9y_fpUs3JbPJVzcv1mOrp4dy6_shBzHnVNrOrg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Remove redundant lower_32_bits() calls when settings
 SDMA doorbell
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: emily.deng@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Sounds good to me.

Updated the patch for the CIK / SI hardware. I kept the clamping code
to be safe.

Signed-off-by: Haohui Mai <ricetons@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c  | 5 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/si_dma.c    | 5 ++---
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index c8ebd108548d..cf99f6d07b49 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -194,8 +194,7 @@ static void cik_sdma_ring_set_wptr(struct amdgpu_ring *ring)
 {
  struct amdgpu_device *adev = ring->adev;

- WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
-        (lower_32_bits(ring->wptr) << 2) & 0x3fffc);
+ WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me], (ring->wptr <<
2) & 0x3fffc);
 }

 static void cik_sdma_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
@@ -487,7 +486,7 @@ static int cik_sdma_gfx_resume(struct amdgpu_device *adev)
  WREG32(mmSDMA0_GFX_RB_BASE_HI + sdma_offsets[i], ring->gpu_addr >> 40);

  ring->wptr = 0;
- WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr) << 2);
+ WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], ring->wptr << 2);

  /* enable DMA RB */
  WREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i],
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 1d8bbcbd7a37..84b57b06b20c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -223,7 +223,7 @@ static void sdma_v2_4_ring_set_wptr(struct
amdgpu_ring *ring)
 {
  struct amdgpu_device *adev = ring->adev;

- WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
lower_32_bits(ring->wptr) << 2);
+ WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me], ring->wptr << 2);
 }

 static void sdma_v2_4_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
@@ -465,7 +465,7 @@ static int sdma_v2_4_gfx_resume(struct amdgpu_device *adev)
  WREG32(mmSDMA0_GFX_RB_BASE_HI + sdma_offsets[i], ring->gpu_addr >> 40);

  ring->wptr = 0;
- WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr) << 2);
+ WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], ring->wptr << 2);

  /* enable DMA RB */
  rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 4ef4feff5649..c86f181623f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -389,14 +389,14 @@ static void sdma_v3_0_ring_set_wptr(struct
amdgpu_ring *ring)
  if (ring->use_doorbell) {
  u32 *wb = (u32 *)&adev->wb.wb[ring->wptr_offs];
  /* XXX check if swapping is necessary on BE */
- WRITE_ONCE(*wb, (lower_32_bits(ring->wptr) << 2));
- WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr) << 2);
+ WRITE_ONCE(*wb, ring->wptr << 2);
+ WDOORBELL32(ring->doorbell_index, ring->wptr << 2);
  } else if (ring->use_pollmem) {
  u32 *wb = (u32 *)&adev->wb.wb[ring->wptr_offs];

- WRITE_ONCE(*wb, (lower_32_bits(ring->wptr) << 2));
+ WRITE_ONCE(*wb, ring->wptr << 2);
  } else {
- WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
lower_32_bits(ring->wptr) << 2);
+ WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me], ring->wptr << 2);
  }
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c
b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 195b45bcb8ad..2f95235bbfb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -56,8 +56,7 @@ static void si_dma_ring_set_wptr(struct amdgpu_ring *ring)
  struct amdgpu_device *adev = ring->adev;
  u32 me = (ring == &adev->sdma.instance[0].ring) ? 0 : 1;

- WREG32(DMA_RB_WPTR + sdma_offsets[me],
-        (lower_32_bits(ring->wptr) << 2) & 0x3fffc);
+ WREG32(DMA_RB_WPTR + sdma_offsets[me], (ring->wptr << 2) & 0x3fffc);
 }

 static void si_dma_ring_emit_ib(struct amdgpu_ring *ring,
@@ -175,7 +174,7 @@ static int si_dma_start(struct amdgpu_device *adev)
  WREG32(DMA_CNTL + sdma_offsets[i], dma_cntl);

  ring->wptr = 0;
- WREG32(DMA_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr) << 2);
+ WREG32(DMA_RB_WPTR + sdma_offsets[i], ring->wptr << 2);
  WREG32(DMA_RB_CNTL + sdma_offsets[i], rb_cntl | DMA_RB_ENABLE);

  ring->sched.ready = true;
-- 
2.25.1
