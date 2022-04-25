Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511E6C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 11:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4A6410E652;
	Mon, 25 Apr 2022 11:49:38 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B54910E652
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 11:49:38 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id k4so14858443plk.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 04:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=CLwXMGfjo8sS9sBm5qFCBv/5xTephOH1PvS7+Cfh+64=;
 b=BJN7uJ4NwA8laG1sb2qTKnhOMYwOHQ5wn/QekU5lkrYsmM+ZBsMbZNVVDA2j8pBMK5
 E2mr136K+ZJliEDueEfzp0zVnmr+/IGj521GPi84bRLsaiZT2ornH1H0UVwik6iUQRJi
 juaC0kba0TMBYmsG9sKhQxRZhQF/JOJ7352i49SAAD9tPo+49TtoHGICbNYcpr8/tpc4
 +9u+28d9VlIqvOE+Q54KaZokjoKW88lwoEI1LvkenDJMpEFpwSiPRfKgET3pmAgOhXTe
 ErlKqzK5i3mnAvmxlQUFP1yUWW8QUx2bcWCwrowGiyOhjPc5J1CEt3xiIDgt6z9hlJ0I
 akFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=CLwXMGfjo8sS9sBm5qFCBv/5xTephOH1PvS7+Cfh+64=;
 b=XjD4tHTGie/4Ozrz4ff4XyAD4gsfUOEu8ep8xSyBlLvk6F0Fv+Pqe0wNVmHxHFykOF
 Z4vYiJQkdUX82/bBwxa0MEfQrwGITTXJ2uyxS1Chw1UktjAnShnhr18dvdQuHlWxiC33
 jSi99kNLdSuwYYNAHTwYob8ZdaKGv2GSuFiEJzgXYC5hXQE9CrRRlcCkGdubSEx7Csub
 t3peI5ELpBwVrhERW3y99XSHDy7KRZvGOdUpzBjgS4yVz5ky2vU2xZ1d6YRu7kohuj1l
 g/lLs6UsHunEE70stP84Fro2VRIAPndpdjl9IzSuElisEUASGN6QNOkudOBzlwB9p4NP
 fqwg==
X-Gm-Message-State: AOAM530goUgivueUMifZ2v/Qrnp6aANrcObFllH5d7/zulsz1XB+0kKE
 Mxu6lfIG9xsqKXcae8i+esdPbMA31+OVVa3sSEGlt4+AVIirNA==
X-Google-Smtp-Source: ABdhPJxakJHrQt9FmYoNmy4bdFzJZ1vVtQN3hLS6B6qTHlcY5JZvrHygQZTnIDxM/YOUHG93kxgKjoCZER43mW7wHrU=
X-Received: by 2002:a17:902:d2c5:b0:158:f839:4d8a with SMTP id
 n5-20020a170902d2c500b00158f8394d8amr17586484plc.108.1650887377817; Mon, 25
 Apr 2022 04:49:37 -0700 (PDT)
MIME-Version: 1.0
From: Haohui Mai <ricetons@gmail.com>
Date: Mon, 25 Apr 2022 19:49:26 +0800
Message-ID: <CAHpOOhHdH8=zEGu1oX_7DGTotO7pnXLk_XGyKddk89iaTJ1rKw@mail.gmail.com>
Subject: [PATCH 2/2] Remove redundant lower_32_bits() calls when settings SDMA
 doorbell
To: amd-gfx@lists.freedesktop.org
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
Cc: ckoenig.leichtzumerken@gmail.com, emily.deng@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I kept the original clamping for CIK / SI in this patch.

Please let me know if you want to remove them.

Signed-off-by: Haohui Mai <ricetons@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c  | 5 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/si_dma.c    | 5 ++---
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index df863d346995..cf99f6d07b49 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -194,8 +194,7 @@ static void cik_sdma_ring_set_wptr(struct amdgpu_ring *ring)
 {
  struct amdgpu_device *adev = ring->adev;

- WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
-        (lower_32_bits(ring->wptr << 2)) & 0x3fffc);
+ WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me], (ring->wptr <<
2) & 0x3fffc);
 }

 static void cik_sdma_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
@@ -487,7 +486,7 @@ static int cik_sdma_gfx_resume(struct amdgpu_device *adev)
  WREG32(mmSDMA0_GFX_RB_BASE_HI + sdma_offsets[i], ring->gpu_addr >> 40);

  ring->wptr = 0;
- WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr << 2));
+ WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], ring->wptr << 2);

  /* enable DMA RB */
  WREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i],
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index b83fd00466fe..84b57b06b20c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -223,7 +223,7 @@ static void sdma_v2_4_ring_set_wptr(struct
amdgpu_ring *ring)
 {
  struct amdgpu_device *adev = ring->adev;

- WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
lower_32_bits(ring->wptr << 2));
+ WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me], ring->wptr << 2);
 }

 static void sdma_v2_4_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
@@ -465,7 +465,7 @@ static int sdma_v2_4_gfx_resume(struct amdgpu_device *adev)
  WREG32(mmSDMA0_GFX_RB_BASE_HI + sdma_offsets[i], ring->gpu_addr >> 40);

  ring->wptr = 0;
- WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr << 2));
+ WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], ring->wptr << 2);

  /* enable DMA RB */
  rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 557a7d5174b0..c86f181623f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -389,14 +389,14 @@ static void sdma_v3_0_ring_set_wptr(struct
amdgpu_ring *ring)
  if (ring->use_doorbell) {
  u32 *wb = (u32 *)&adev->wb.wb[ring->wptr_offs];
  /* XXX check if swapping is necessary on BE */
- WRITE_ONCE(*wb, (lower_32_bits(ring->wptr << 2)));
- WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr << 2));
+ WRITE_ONCE(*wb, ring->wptr << 2);
+ WDOORBELL32(ring->doorbell_index, ring->wptr << 2);
  } else if (ring->use_pollmem) {
  u32 *wb = (u32 *)&adev->wb.wb[ring->wptr_offs];

- WRITE_ONCE(*wb, (lower_32_bits(ring->wptr << 2)));
+ WRITE_ONCE(*wb, ring->wptr << 2);
  } else {
- WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
lower_32_bits(ring->wptr << 2));
+ WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me], ring->wptr << 2);
  }
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c
b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 0af11d3b00e7..2f95235bbfb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -56,8 +56,7 @@ static void si_dma_ring_set_wptr(struct amdgpu_ring *ring)
  struct amdgpu_device *adev = ring->adev;
  u32 me = (ring == &adev->sdma.instance[0].ring) ? 0 : 1;

- WREG32(DMA_RB_WPTR + sdma_offsets[me],
-        (lower_32_bits(ring->wptr << 2)) & 0x3fffc);
+ WREG32(DMA_RB_WPTR + sdma_offsets[me], (ring->wptr << 2) & 0x3fffc);
 }

 static void si_dma_ring_emit_ib(struct amdgpu_ring *ring,
@@ -175,7 +174,7 @@ static int si_dma_start(struct amdgpu_device *adev)
  WREG32(DMA_CNTL + sdma_offsets[i], dma_cntl);

  ring->wptr = 0;
- WREG32(DMA_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr << 2));
+ WREG32(DMA_RB_WPTR + sdma_offsets[i], ring->wptr << 2);
  WREG32(DMA_RB_CNTL + sdma_offsets[i], rb_cntl | DMA_RB_ENABLE);

  ring->sched.ready = true;
--
2.25.1
