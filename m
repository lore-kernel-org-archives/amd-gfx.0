Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA08C44506
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jul 2026 11:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81E1F10E33B;
	Sat, 11 Jul 2026 11:50:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YGhggAHV";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 093B910E230
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jul 2026 11:50:07 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493b7612475so14607055e9.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jul 2026 04:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783770605; x=1784375405; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=59V83PsX7SeB+5pdUo464zcrZVuGQKuTijnAR/KSVt8=;
 b=YGhggAHVPgzW/815hmGWhg9aD/5Nw5OVvUI0rwbnMHTdR0EI+aNVrOW43y0BikfMp/
 Yu4WU/GWOd3hoz/jlvRNvmtwqDlSe8cTBUW6dT3v+Fq+/py3IejGrk/6o4kZddlXxnn7
 W2nknlb5yvBcE1RFz2lLeoZuSS8XyEnEGMbO3agHS9HdHMdl52GY5CKh2dDiT5IvRuHE
 mk64tuzfczNoExOo9dvGrbZyycSfkTrxqt7sjNqefNnmZjJm4AFV/xM0ck2BFqIE1/vC
 wN9/VuHFP7GwZbYzSzaXhi9F+Fq0xUTCB6pxLRt3vPzcAxc+L41qZ9OMzbDV9zPXQtQW
 oYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783770605; x=1784375405;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=59V83PsX7SeB+5pdUo464zcrZVuGQKuTijnAR/KSVt8=;
 b=jntHqC78vEoW3TLY5bKx8FRKhGxOKvcKYlE3a+qYGFmBEZmNWISgsa6/BM8P3Vm8NQ
 ZisUH3OZ7fZfFYQ1SCByvSqU/KHWxlOoLAnhY98J0za1aZQgJm1r6LVpL3ilmbSHwiHj
 kHbCmRCfMt4mg7JhXNPs6BAt6uFaVUWprRJ1yoHOlxC9uuNyEJ31y8cbkSB7y76IoANX
 EAMgvOPGsycobufRPWo4fCCpmJgtKU/mbp8Uchk62Nuu1yaoIOLQIGWdnxT4ONTAKQ/c
 Gh2r1aQtDDpVa630ECFhc9MZNvQPa0yrtdZB7KZPHxxAEnz66gK9DrAA58SmaHt3VNZv
 Fkkw==
X-Gm-Message-State: AOJu0YzFp808rc+YAKSKrbM+afK4V3NIvE2MpWhjtGODJArkyQyXPLMm
 GJZJVWUzOCpOYPiwg83ALRuGntfmYGR+ekuAKq6rAvOhYPPIOwfPTw5ywXbbow==
X-Gm-Gg: AfdE7cnw9yp6AM1cWdi9fUo2iCjXqiMGYNZaFquuJyHNrpljXNahgJqND0KjadRVLF+
 zqfG2NXGNqPbMgAcbR+Kriu+ILF3dLLZHfTz6YPoOlUFPREMq280Jd0/wV9g2tKvwTewrYrJX2c
 +u570g1RhnLX8iL9tFBYVZppI91AIfZesdGj+xMoH386uhE0uBnnfB205gFO+j7FOAIoBHB5ZGV
 TfihMtASfxxmReHCzqgLlPjt8dbkqbX1y4ehWTYQ1MKfFduRpdDz9aY7gafgVmGqHQjLkqmcWY4
 /1B4os/2y7W9vvEdpc8xowhc7mGCCQzJetjdUv8if+4qfo+Fkk2UmGC/EGr6jtznGvFz3IBaQr5
 QOuSF08IfDu9Tf0sDsF5ebiNIK+Uqc8F9PaRft9lOsO4I074K6DS3Pg6Vg3cGftssoGVKdp7+6+
 Vf37QeqO6nB+0TX7aj2JlLiPv5zkHgwMEpw+wEfiSIkcseG7jprrVI8Q==
X-Received: by 2002:a05:600c:190f:b0:493:adcb:d368 with SMTP id
 5b1f17b1804b1-493f87e9aa1mr24534565e9.9.1783770605358; 
 Sat, 11 Jul 2026 04:50:05 -0700 (PDT)
Received: from Timur-Hyperion.home (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493fbae1cdbsm16352865e9.10.2026.07.11.04.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2026 04:50:04 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Tvrtko Ursulin <tursulin@ursulin.net>,
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/3] drm/amdgpu/ttm: Use more optimal copy packet sizes for
 copy and fill
Date: Sat, 11 Jul 2026 13:50:00 +0200
Message-ID: <20260711115000.40655-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260711115000.40655-1-timur.kristof@gmail.com>
References: <20260711115000.40655-1-timur.kristof@gmail.com>
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

Currently when amdgpu copies or fills a buffer,
it uses the maximum byte count supported by the
copy engine (SDMA). This is problematic when the
maximum byte count is not aligned to 256 bytes
because it then can't use all memory channels
optimally and can cause the SDMA to operate in its
slower byte mode (as opposed to the faster dword mode).

For example, when copying a 10 MiB buffer on SDMA v2.4,
we get 5 packets copying 2097151 bytes and 1 packet copying
the remaining 5 bytes. All 6 packets are misaligned and operate
in byte mode.
For this example, the optimal solution would be to have
5 packets each copying 2096896 bytes and 1 last packet to
copy the remaining 1280 bytes, in which case all 6 packets
are aligned to 256 bytes and operate in dword mode.

Let's use the following scheme from now on:

When byte count is dword-aligned and fits a single packet,
just emit a single packet.

Otherwise, align the copy packet size down to 256 bytes
for optimal use of memory channels and to ensure the HW
can use the dword mode.

This assumes that the starting addresses of BOs are always
dword aligned, which should be the case for every copy
operation in the kernel, because the kernel always copies
pages.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 27 +++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 50725bd2448d..42ed02e7cd85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2464,6 +2464,27 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
 						   DMA_RESV_USAGE_BOOKKEEP);
 }
 
+static int amdgpu_calc_bytes_per_packet(u32 max_bytes_per_packet,
+					u32 byte_count)
+{
+	/* Byte count is dword-aligned and fits a single packet */
+	if (!(byte_count & 0x3) && byte_count <= max_bytes_per_packet)
+		return max_bytes_per_packet;
+
+	/*
+	 * Align down maximum byte count to 256 bytes so that
+	 * the copy optimally uses all memory channels and
+	 * also to ensure that SDMA can use its dword mode, which
+	 * is faster.
+	 *
+	 * This assumes that the starting addresses of BOs are always
+	 * dword aligned, which should be the case for every copy
+	 * operation in the kernel, because the kernel always copies
+	 * pages.
+	 */
+	return ALIGN_DOWN(max_bytes_per_packet, SZ_256);
+}
+
 int amdgpu_copy_buffer(struct amdgpu_device *adev,
 		       struct amdgpu_ttm_buffer_entity *entity,
 		       uint64_t src_offset,
@@ -2487,7 +2508,8 @@ int amdgpu_copy_buffer(struct amdgpu_device *adev,
 		return -EINVAL;
 	}
 
-	max_bytes = adev->mman.buffer_funcs->copy_max_bytes;
+	max_bytes = amdgpu_calc_bytes_per_packet(adev->mman.buffer_funcs->copy_max_bytes,
+						 byte_count);
 	num_loops = DIV_ROUND_UP(byte_count, max_bytes);
 	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->copy_num_dw, 8);
 	r = amdgpu_ttm_prepare_job(adev, entity, num_dw,
@@ -2531,7 +2553,8 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_device *adev,
 	unsigned int i;
 	int r;
 
-	max_bytes = adev->mman.buffer_funcs->fill_max_bytes;
+	max_bytes = amdgpu_calc_bytes_per_packet(adev->mman.buffer_funcs->fill_max_bytes,
+						 byte_count);
 	num_loops = DIV_ROUND_UP_ULL(byte_count, max_bytes);
 	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->fill_num_dw, 8);
 	r = amdgpu_ttm_prepare_job(adev, entity, num_dw, resv,
-- 
2.55.0

