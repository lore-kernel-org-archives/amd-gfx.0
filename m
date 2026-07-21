Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77204C4452F
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 11:43:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 107FE10E955;
	Tue, 21 Jul 2026 11:43:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fFN3VuiV";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7283410E955
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 11:43:35 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-69c600f76ccso11960377a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 04:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784634214; x=1785239014; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4lvCd0yY+gwMZkPvywZbxcWgDEoZJRxziXfhsbZyyEE=;
 b=fFN3VuiVIUHHI/LoskKI/d0BOQrsRM7SV/5kYgkrGCu8kE/zP3H6uI2Ffr6UX8ttB5
 ZRXEQfVUywv2pq/98fAaffPUg5smWxLOmRrNA2ncuKxa3dg4OARto1O6gdQXwZc4HIqQ
 HzRvYxajZiTnYn3gwi9IhA69u9WWWGBaJIC7DhoGWYUkUaLUO/WxAIChoNyaLfkb/qGZ
 8iuxgCP4NgTQ8LmAhMRL+5X6YPfmgAfpaMdVla7fuGcG2350+3nsTWINeWAsDqFeynVG
 QctVcBHgpBdOUQ2D8U03yRYxp1TuJN2ek5sDA8NVjxzHUtNnJ1gnc/Ndg5bqCPLts2pZ
 yg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784634214; x=1785239014;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4lvCd0yY+gwMZkPvywZbxcWgDEoZJRxziXfhsbZyyEE=;
 b=sgBYlNGjkBRlAxUXD82SiN+/ineVWjOTQrTH5wYvO0tv6C/p/Vnv1lo62th183TYHy
 KqNTVU3gai9ol1PPY6LJ4PTWATeqqu0ajduf8XhWEyuNVXkgH4PyQuE5YaJdmtLGef/x
 QGoNP7OrHXgkN22mfMLrCkpYJUBWsYTbO41Sxn/VHJYDG8AH2IynYKbu/s2V4sr/2Gw9
 sav/vWjCRL0BwmkNJYZJx6+eg9klVMSKOLAvEQjiGRjeoXXciFT4MHZqgp9wGRAE9Gih
 qH+K954x/khpuQ2F04b8l+oRQYx5QfWVxABK4Xb0LCvoruryZlPmOn0FIF6841ev278Q
 j3QA==
X-Gm-Message-State: AOJu0YxQCEkiQYsqZsMi9ld2Tz19odHpJ+zTvfAdzEMq/O7+zAvXKSnT
 NtclnZbFU9eM6ZpXVYlQ8MFF+9KehN1eCkTneLpk6n7G6+mGJ6MN8A7IIjHBAExe
X-Gm-Gg: AR+sD12TtbHJCW0CTzgrVTuBQf3p2gKjC8jev0XljUJRW7ns/XgEX/bBLdJb4Pv5Nzp
 rsd+oZstCJDxMlPQbqPJ0DaR8XPRPwZmNOS3H+tYojS9YPoXHadUiKmmsLspOW0VtrddZoDoDHp
 nDyCuQpgKwdhXymG/CsrweLzikp1Wpu6SzVpUTlMI3NcjNhD1KMf8Tygy2k6HHc7iqyIWujR3rc
 mj6MxlGzmlvIHdWO/p2FffxSxz9HOr1gHdeY9PusJQTo1sr3mnFEUutmiNoOz3Yl6YwDezlTu+0
 ygwZm/ZAzy4awyOkeAvzLXDFEufoGmzqFwoPlW4ycXy/wS23Y7UXlv/cGzLCHpRvgXZpjZcWhRG
 khA2m3GENX9cHwaZoCjyayihB856M2lCb7qXcH4CYaPuZXVnWL3UCLWChSKED0n8I1Oe5EggzLt
 DhJsYEQgYBx315G+vWInEV7WcGGoGUKXR9fS7G4sLOZyM=
X-Received: by 2002:a17:907:db02:b0:c16:652c:3db7 with SMTP id
 a640c23a62f3a-c16b47818bdmr700269466b.36.1784634213670; 
 Tue, 21 Jul 2026 04:43:33 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D94C.dsl.pool.telekom.hu.
 [84.1.217.76]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c17009ae00asm571635366b.7.2026.07.21.04.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 04:43:33 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 6/9] drm/amdgpu/gfx7: Clean up gfx ring during reset
Date: Tue, 21 Jul 2026 13:43:19 +0200
Message-ID: <20260721114322.17535-7-timur.kristof@gmail.com>
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

Clear the WPTR and RPTR at ring initialization.
Additionally clear the ring contents during reset.

After a reset, the ring contents could be "dirty"
and contain packets emitted before the reset.
and thus need to be cleared to prevent the command
processor from executing packets left over in the
ring from before the reset.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 6b76cf31b4d3..67dfda7c0a45 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2546,8 +2546,12 @@ static int gfx_v7_0_cp_gfx_resume(struct amdgpu_device *adev)
 	WREG32(mmSCRATCH_ADDR, 0);
 
 	/* ring 0 - compute and gfx */
-	/* Set ring buffer size */
 	ring = &adev->gfx.gfx_ring[0];
+	*ring->wptr_cpu_addr = 0;
+	*ring->rptr_cpu_addr = 0;
+	amdgpu_ring_clear_ring(ring);
+
+	/* Set ring buffer size */
 	rb_bufsz = order_base_2(ring->ring_size / 8);
 	tmp = (order_base_2(AMDGPU_GPU_PAGE_SIZE/8) << 8) | rb_bufsz;
 #ifdef __BIG_ENDIAN
@@ -2559,6 +2563,7 @@ static int gfx_v7_0_cp_gfx_resume(struct amdgpu_device *adev)
 	WREG32(mmCP_RB0_CNTL, tmp | CP_RB0_CNTL__RB_RPTR_WR_ENA_MASK);
 	ring->wptr = 0;
 	WREG32(mmCP_RB0_WPTR, lower_32_bits(ring->wptr));
+	WREG32(mmCP_RB0_RPTR, lower_32_bits(ring->wptr));
 
 	/* set the wb address whether it's enabled or not */
 	rptr_addr = ring->rptr_gpu_addr;
-- 
2.55.0

