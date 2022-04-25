Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4064C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 09:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4033D10E06D;
	Mon, 25 Apr 2022 09:15:29 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BD5110E06D
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 09:15:28 +0000 (UTC)
Received: by mail-pg1-x532.google.com with SMTP id s137so12910704pgs.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 02:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=Ga17vWhC3spOWBjmExGdm8iCRbnZ+KR8qSiKr53Jtpc=;
 b=TSzEIViWYAgtojne8VENP8Whbq3UJizPj6dTmGTDGQr6S9x15ZfqUphsZRePFaJQ2T
 cjwdhOASUB0gWMkCkqk9FsnBeXIer6Z/Y6rcfrUgjzHTnkH5PIfEmDsDXvIUCr2MZP56
 DDb/PJkdwyutjVbExNhmH6RyKGOgIUFIhgftyiBmTlwTu0YiyyCfH1krlyb/grch2JSX
 jUw31RMPieb0CByDVpxOwz5DN+rE2kqOp3t8VPS5CSmskNfSS6VnqTcpHcbXLYz/9c3W
 cjtnFCrwnpj/yZ3iAvDT+dTJHNocMZlGZFMH+IzsUlCAAJML2exXLIA4Gr2zs5xOOiG2
 GvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=Ga17vWhC3spOWBjmExGdm8iCRbnZ+KR8qSiKr53Jtpc=;
 b=cN/9ME60QzAn7YiNWMTERqU0KPkbVgrEd5I6cjrkNlp3rKFJBTmSXJlgtBMKRe+Yau
 STRlJXnH16cav876ZFdU2Lc65i7/UvdTkabNnmYh6n0Tq30t38as0VVVyTRM7Uq7OAhR
 9qX/2hUN64X2uR2Bu3nLeVGoi5y83BbIiX4Isuot+IkOTvzH9L536CnaakR5Jnwansx9
 Sog5Ee8Xue8LQ60Xe3QXQZAtJ91/akEa5HB/YO78Sl2u9t7R8wxFvuwlWXvOXJBgCbGs
 HgAHUPcn1jWgnJlppLrX4IKWYKDhfWpGwaYtTPQOZhAun0ELlLGkscvlJYFhbpsuI00q
 HzhQ==
X-Gm-Message-State: AOAM533TskCw517Wj4mxxl67PEfSvW1jO9huooW67nHY/zVFO3VD6wAh
 F01Gi7AC6NAwsvUt7y8njGF/E7DHj+wpUJj2vvuqCGnNuZjh1Q==
X-Google-Smtp-Source: ABdhPJyQwJfDjox/CqrjI5o3xqgE1GKdO8OoK/f+w5M9xcveMfbqIrNNUa54M+W3c15vrwxvbQyqrlnsDIQf1ohWeAk=
X-Received: by 2002:a63:4b1e:0:b0:3a3:9226:594c with SMTP id
 y30-20020a634b1e000000b003a39226594cmr14040046pga.5.1650878127566; Mon, 25
 Apr 2022 02:15:27 -0700 (PDT)
MIME-Version: 1.0
From: Haohui Mai <ricetons@gmail.com>
Date: Mon, 25 Apr 2022 17:15:14 +0800
Message-ID: <CAHpOOhHuoZzFfXgM35b65pXxAtFoyTFKGYGO2NT7kKZ1-oNN9A@mail.gmail.com>
Subject: [PATCH] Set the 64-bit address of the wptr of SDMA doorbell properly
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

Computing the address of the doorbell should be done before instead of after
separating the 64-bit address into the higher and lower half. The
current code sets the MMIO registers incorrectly if the address of the
doorbell is above 1G.

Signed-off-by: Haohui Mai <ricetons@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/si_dma.c    | 4 ++--
 7 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index c8ebd108548d..df863d346995 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -195,7 +195,7 @@ static void cik_sdma_ring_set_wptr(struct amdgpu_ring *ring)
  struct amdgpu_device *adev = ring->adev;

  WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
-        (lower_32_bits(ring->wptr) << 2) & 0x3fffc);
+        (lower_32_bits(ring->wptr << 2)) & 0x3fffc);
 }

 static void cik_sdma_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
@@ -487,7 +487,7 @@ static int cik_sdma_gfx_resume(struct amdgpu_device *adev)
  WREG32(mmSDMA0_GFX_RB_BASE_HI + sdma_offsets[i], ring->gpu_addr >> 40);

  ring->wptr = 0;
- WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr) << 2);
+ WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr << 2));

  /* enable DMA RB */
  WREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i],
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 1d8bbcbd7a37..b83fd00466fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -223,7 +223,7 @@ static void sdma_v2_4_ring_set_wptr(struct
amdgpu_ring *ring)
 {
  struct amdgpu_device *adev = ring->adev;

- WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
lower_32_bits(ring->wptr) << 2);
+ WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
lower_32_bits(ring->wptr << 2));
 }

 static void sdma_v2_4_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
@@ -465,7 +465,7 @@ static int sdma_v2_4_gfx_resume(struct amdgpu_device *adev)
  WREG32(mmSDMA0_GFX_RB_BASE_HI + sdma_offsets[i], ring->gpu_addr >> 40);

  ring->wptr = 0;
- WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr) << 2);
+ WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr << 2));

  /* enable DMA RB */
  rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 4ef4feff5649..557a7d5174b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -389,14 +389,14 @@ static void sdma_v3_0_ring_set_wptr(struct
amdgpu_ring *ring)
  if (ring->use_doorbell) {
  u32 *wb = (u32 *)&adev->wb.wb[ring->wptr_offs];
  /* XXX check if swapping is necessary on BE */
- WRITE_ONCE(*wb, (lower_32_bits(ring->wptr) << 2));
- WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr) << 2);
+ WRITE_ONCE(*wb, (lower_32_bits(ring->wptr << 2)));
+ WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr << 2));
  } else if (ring->use_pollmem) {
  u32 *wb = (u32 *)&adev->wb.wb[ring->wptr_offs];

- WRITE_ONCE(*wb, (lower_32_bits(ring->wptr) << 2));
+ WRITE_ONCE(*wb, (lower_32_bits(ring->wptr << 2)));
  } else {
- WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
lower_32_bits(ring->wptr) << 2);
+ WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
lower_32_bits(ring->wptr << 2));
  }
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index d7e8f7232364..ff86c43b63d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -772,8 +772,8 @@ static void sdma_v4_0_ring_set_wptr(struct
amdgpu_ring *ring)

  DRM_DEBUG("Using doorbell -- "
  "wptr_offs == 0x%08x "
- "lower_32_bits(ring->wptr) << 2 == 0x%08x "
- "upper_32_bits(ring->wptr) << 2 == 0x%08x\n",
+ "lower_32_bits(ring->wptr << 2) == 0x%08x "
+ "upper_32_bits(ring->wptr << 2) == 0x%08x\n",
  ring->wptr_offs,
  lower_32_bits(ring->wptr << 2),
  upper_32_bits(ring->wptr << 2));
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index a8d49c005f73..627eb1f147c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -394,8 +394,8 @@ static void sdma_v5_0_ring_set_wptr(struct
amdgpu_ring *ring)
  if (ring->use_doorbell) {
  DRM_DEBUG("Using doorbell -- "
  "wptr_offs == 0x%08x "
- "lower_32_bits(ring->wptr) << 2 == 0x%08x "
- "upper_32_bits(ring->wptr) << 2 == 0x%08x\n",
+ "lower_32_bits(ring->wptr << 2) == 0x%08x "
+ "upper_32_bits(ring->wptr << 2) == 0x%08x\n",
  ring->wptr_offs,
  lower_32_bits(ring->wptr << 2),
  upper_32_bits(ring->wptr << 2));
@@ -774,9 +774,9 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)

  if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write
for wptr */
  WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR),
-        lower_32_bits(ring->wptr) << 2);
+        lower_32_bits(ring->wptr << 2));
  WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI),
-        upper_32_bits(ring->wptr) << 2);
+        upper_32_bits(ring->wptr << 2));
  }

  doorbell = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i,
mmSDMA0_GFX_DOORBELL));
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 824eace69884..a5eb82bfeaa8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -295,8 +295,8 @@ static void sdma_v5_2_ring_set_wptr(struct
amdgpu_ring *ring)
  if (ring->use_doorbell) {
  DRM_DEBUG("Using doorbell -- "
  "wptr_offs == 0x%08x "
- "lower_32_bits(ring->wptr) << 2 == 0x%08x "
- "upper_32_bits(ring->wptr) << 2 == 0x%08x\n",
+ "lower_32_bits(ring->wptr << 2) == 0x%08x "
+ "upper_32_bits(ring->wptr << 2) == 0x%08x\n",
  ring->wptr_offs,
  lower_32_bits(ring->wptr << 2),
  upper_32_bits(ring->wptr << 2));
@@ -672,8 +672,8 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
  WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i,
mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);

  if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write
for wptr */
- WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR),
lower_32_bits(ring->wptr) << 2);
- WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI),
upper_32_bits(ring->wptr) << 2);
+ WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR),
lower_32_bits(ring->wptr << 2));
+ WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI),
upper_32_bits(ring->wptr << 2));
  }

  doorbell = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i,
mmSDMA0_GFX_DOORBELL));
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c
b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 195b45bcb8ad..0af11d3b00e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -57,7 +57,7 @@ static void si_dma_ring_set_wptr(struct amdgpu_ring *ring)
  u32 me = (ring == &adev->sdma.instance[0].ring) ? 0 : 1;

  WREG32(DMA_RB_WPTR + sdma_offsets[me],
-        (lower_32_bits(ring->wptr) << 2) & 0x3fffc);
+        (lower_32_bits(ring->wptr << 2)) & 0x3fffc);
 }

 static void si_dma_ring_emit_ib(struct amdgpu_ring *ring,
@@ -175,7 +175,7 @@ static int si_dma_start(struct amdgpu_device *adev)
  WREG32(DMA_CNTL + sdma_offsets[i], dma_cntl);

  ring->wptr = 0;
- WREG32(DMA_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr) << 2);
+ WREG32(DMA_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr << 2));
  WREG32(DMA_RB_CNTL + sdma_offsets[i], rb_cntl | DMA_RB_ENABLE);

  ring->sched.ready = true;
--
2.25.1
