Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E61DC55182
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 13:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A706B10E6D4;
	Mon,  3 Aug 2026 13:23:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eaBHB7o9";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D852010E6A6
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 13:23:16 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c167bda216fso510342866b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Aug 2026 06:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785763395; x=1786368195; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pRmVNz8ZKQ5POJD2bip8iNxE5+bsrIXqbUSCTu5Xm+g=;
 b=eaBHB7o9kamU1bexDZK6/JAeiq7xxZAYpLceJAD0o+KkAJrN4NvR/EAN0TJVGaQcth
 Xky86zcwxDaM493oj+cG/asayEg55kKzsHOed5vwdl2PFTGx7u1xoawThHS8+cxafYTD
 vUv2f7OnGBoaf3nZTDLLR3mVNOUSmtuacUKEfAums3YXKvv1UXPBzgzW8urZAu8KCYN0
 xQxdC4WSfS/VwRPxHiu84gdSTA95Nn5aV3/sIiufNtAEdelkOiemN6sCLFFZZsCgUH/Y
 6pjopc0yIGsKNUwQm/yHNVFEyLpyYvVKdt8AqE/Ijvr++9yG+ib0qtOqex6BDkWw4TUi
 lVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785763395; x=1786368195;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pRmVNz8ZKQ5POJD2bip8iNxE5+bsrIXqbUSCTu5Xm+g=;
 b=k9h9nZ0r+5uE+53ndu7/Dqc2qr0cMe2XEGu6XT7JcAhjCmgYlFjLNQ2TGKMoz7Lvx4
 /J5Q8qUcc9UPgIomUXnoxeml8LklaQHxb0+uREAvlHxJ3WqMZebO1zdttJAPwv4NODBr
 JcFHXLrefXPk0L9ZbmcmJT14p333s3S4wqo5+K4Z4Jn2/ZLjXkDOU2LcP8fYo5hZQspV
 sW20zSTFmDSuUF4UYs3lyD5fcOE4TLMPd9Tmj6peKKG43Yod3u0SbjK1VCw0+Gqg11Tl
 1BNe6cqGtvOvczyB7Kw5IH+EvRajp6Nn9Rn81umeDjyu4jZ9Tt6FUOyd47ehLK8GutBI
 CUng==
X-Gm-Message-State: AOJu0Yzd5jV86nPp5zU3Ekw0aKWindcLComV+6gMd49+6OHzPNbTqmL8
 eSQkjtleUTn/D+gNSCGhb8kmGM1vhvoYUjjASovAmbbkL3zRBCCFLUuFsHIJ5FgM
X-Gm-Gg: AR+sD10ozYcLKJ2kUWV4kseCm8ivGwV59513GYFjshXuVCY8lqjZcXhxpdlJPMVtgft
 8NLQqwH14CE+6VLe/B38WQ/tsB/uUZGXOKHCMcnNXJeVXAazPrOp2dmFRWy+46exrfwPycxG0ep
 Yip1H49EDMYJJnjCSZXq/tCzpHWTh0ZtdxKc+KBBjIvx1O2iOJH8cfLbOBxUGAkBqA14tkaonCE
 Zn5SVHADg+AK8o8quJzsx0/O3mk6ej2LzgDHc1BBjMm8KK/PAY5owkkgGwc1at7LsGfBTaCh64a
 YXUDPvyleot3zX6uuLIZkwd2YO5Go5isDmc4hQwpZhoEcRdjg81/ZVDAtZ0+4J0JAz4Y1kTdLNx
 Yv3W7jEw+AXcd7WygDapmiVn9HJEsa8lGvwzWEwcZbfSLNiU4pLe1DknLa2JD9L+4DNzRXyNvAJ
 DWhH/YF/HYwe1ZrpmJAHVBL8As4qNbwlYNK61iZQsiJptx8C6T5HTfC3Xge6SDVzjDDn/IcL627
 DnunofNa6Z+I1/pFUPNMou0jzjcGwo=
X-Received: by 2002:a17:907:ea8c:b0:c16:75cc:33a9 with SMTP id
 a640c23a62f3a-c1fe81de492mr832470966b.20.1785763395154; 
 Mon, 03 Aug 2026 06:23:15 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D2B5.dsl.pool.telekom.hu.
 [84.1.210.181]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd445432dsm549201266b.41.2026.08.03.06.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 06:23:14 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <nat@pixelcluster.dev>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 03/10] drm/amdgpu/gfx6: Use PFP on the compute queues too
Date: Mon,  3 Aug 2026 15:23:02 +0200
Message-ID: <20260803132309.36326-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803132309.36326-1-timur.kristof@gmail.com>
References: <20260803132309.36326-1-timur.kristof@gmail.com>
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

After a VM flush, emit PFP_SYNC_ME on compute
queues as well.

Fixes: 2cd46ad22383 ("drm/amdgpu: add graphic pipeline implementation for si v8")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index b84d05e7f09e..9b18ddcd597b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -2346,7 +2346,7 @@ static int gfx_v6_0_cp_resume(struct amdgpu_device *adev)
 
 static void gfx_v6_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 {
-	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
+	int usepfp = 1;
 	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
@@ -2364,7 +2364,7 @@ static void gfx_v6_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 static void gfx_v6_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 					unsigned vmid, uint64_t pd_addr)
 {
-	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
+	int usepfp = 1;
 
 	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
 
@@ -2388,7 +2388,7 @@ static void gfx_v6_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 static void gfx_v6_0_ring_emit_wreg(struct amdgpu_ring *ring,
 				    uint32_t reg, uint32_t val)
 {
-	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
+	int usepfp = 1;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
 	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(usepfp) |
@@ -3554,7 +3554,7 @@ static const struct amdgpu_ring_funcs gfx_v6_0_ring_funcs_compute = {
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

