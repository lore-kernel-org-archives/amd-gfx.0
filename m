Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04227C79F80
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2026 07:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6877F10F8CD;
	Fri,  4 Sep 2026 07:29:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tlj9B+n3";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B22210F8CC
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 07:29:08 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49b8e527d63so8063035e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Sep 2026 00:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788506947; x=1789111747; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cIPe2iDx1q04AOuThkTiqVbSHD6gJz+15yfxxKXnVIw=;
 b=Tlj9B+n3gyslvBnoY5zQFxkNl7Ui7AJ+b9Z6hyag0ljVJ21ldzKU78igEyoovzeYqZ
 j18nHfN6fIlTe8gXRluyrsMV3AcqMosCZiwt50hiTZdQN9FSoHe83sPUzp3720yA89kS
 JN1Ofc1V22NMIOANfs6WVO9QiVEp8erdvpfV6Ftth9tcMUVp/lNUEjrEhuoOR5S0+Eq5
 YQs53zYg7V+KaQfn+hfy83m93diqf4pbTyupSSClNDusO0ETZUkOpF56TY4FWsvmCJj8
 ddO3jXoD5G6TqjCaQPqkPZLqRWaEtt8lGkscwAe6yPDnD7mNs75q8l/dpW1yoFlTdcbn
 fBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788506947; x=1789111747;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cIPe2iDx1q04AOuThkTiqVbSHD6gJz+15yfxxKXnVIw=;
 b=l+VH+scRW0anGHwbb9dZGnBKLjhZchm194vSkUrTRGETVLrJeOBFOQg++PR1TJt66f
 eG5fLaDBaCIBe0RamdRWL5haKeVy51gp+PFgiv65CHGFC184+LEEdSuDds9xoaCNRStI
 RyE9nNwyVALFuIfRYErXQLVLhRIzMPm0fE8A13p0tSRBB073vA9dlVSZKZr1sRqj59B5
 8FrW+0d8L3tVau8+VkKl3P1eQMzm1DXa2dIj+22SrOeXsEnr9jvs/L80CG8n2rhzrKmr
 aD8EMm85RJuvxcDdJgqFLljC8UBtQmtGVgn/6bjFiinsPKch7bd7enaGxxq/SG+5et+y
 2Kuw==
X-Gm-Message-State: AFuF++kZ9ndIfu2d8fWOto5V6GWunlWV3o/c7pTShmEmU/ml7JlYSCqX
 F+js1WccDwAWfA5aswBjRaBnGFoAlhx8wYuFp2q1zPGKtCZVa1D7AV5sqooYi5BTAg0=
X-Gm-Gg: AYBFou07Uw/OXobUeCKSPo8LmHZghj2y2ssIxJ77b1QEYUQDFQ8fSwNUEAskP1qnmnp
 XsUvSEcRs80QdQAvlVHmld108PVj+Qqzo0NV2RCY04bIL5dwXAL2aDtgMEsPC3yvoq9Go0CBnWJ
 RAS55zszx8Ji84GL8pgz/QiCYRD0quyS62tSG+fsZrrRv8gYs0jgFIQoanjON1+MNmpgFiGW4eC
 J+e5ELWO3v71OLzhFT4L4NWvaiyV48QgNJQwtjHcZ6pjxICeLfA60vcd0JaJmoYrvKGnnTODjnp
 UYkAT+4t4IxjXVIgj8L2tBrxlSW9wdZeqTNok17J0J3FBAgSEo2+JGswiwwKxeDh+pFX5jNOeqM
 rbhxtF80gZO5o19kOgWOxFS5OSTTEBU+AOfUQKT7wHOOeKh16Y3JFUDqjqmGpcPuOOzVTJPkec6
 o38rf1RNTFf0XZEXEpVtpx+5STLdrfhGPnDx2lkqojWUSYvt2wacjxhlLVLGJvSb/+5ylQMjjGT
 yFiIrBY+v6vxgXtHsVc
X-Received: by 2002:a05:600c:4f48:b0:49c:fc6e:8cb7 with SMTP id
 5b1f17b1804b1-49cfc6e90a2mr13253895e9.27.1788506946775; 
 Fri, 04 Sep 2026 00:29:06 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf75ce49esm86698155e9.1.2026.09.04.00.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 00:29:06 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 5/8] drm/amdgpu/sdma: Clear SDMA rings after reset before
 starting them
Date: Fri,  4 Sep 2026 09:28:47 +0200
Message-ID: <20260904072850.321759-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904072850.321759-1-timur.kristof@gmail.com>
References: <20260904072850.321759-1-timur.kristof@gmail.com>
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

The ring contains commands that were emitted before the reset.
These need to be cleared to make sure the HW doesn't execute
them, because they are garbage at this point.

Note that the ring reset helpers will re-emit the commands
that are necessary after the reset.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index fbac732f3e01..66f278f77f71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -593,6 +593,18 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 		goto exit;
 	}
 
+	amdgpu_ring_clear_ring(gfx_ring);
+	gfx_ring->wptr = 0;
+	atomic64_set((atomic64_t *)gfx_ring->wptr_cpu_addr, 0);
+	atomic64_set((atomic64_t *)gfx_ring->rptr_cpu_addr, 0);
+
+	if (adev->sdma.has_page_queue) {
+		amdgpu_ring_clear_ring(page_ring);
+		page_ring->wptr = 0;
+		atomic64_set((atomic64_t *)page_ring->wptr_cpu_addr, 0);
+		atomic64_set((atomic64_t *)page_ring->rptr_cpu_addr, 0);
+	}
+
 	if (sdma_instance->funcs->start_kernel_queue) {
 		sdma_instance->funcs->start_kernel_queue(gfx_ring);
 		if (adev->sdma.has_page_queue)
-- 
2.55.0

