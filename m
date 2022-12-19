Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B3EC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Dec 2022 10:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFE9310E224;
	Mon, 19 Dec 2022 10:47:28 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1AB710E224
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Dec 2022 10:47:22 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id m19so12234188edj.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Dec 2022 02:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ny935q0jsiqLfV0aitfnpfy0tly85WQIbjVjQEBFMWI=;
 b=j2bDKYUKxmEh5uI1Nuo4KGcANFC3caGxLoXo/2HOjsbIMhpImf66KtQbIpxDJujVMj
 pX3dopMk3pVMGkt9pnTMBVg9Gjyd7Zc98G0A3R+9Uz82O7RxRmsCERv9+qwaU6bfCNYh
 8cVyOzkzJw/v4iGO1Zmp5EznNMYYiaLycscEbLAxU4fs08er9Nu9fsi0j3EGwpYgXxOe
 7l7TNVFXpiPCmXAFhF2eMmJwkQ48Gt/KgmFZfWh+U2jf3RsnMmAThRkL0bDUwWEsDKSX
 Te+wxoniPaTxBEx4f9Hq/18hN3zKbdf/8Bs2GXg/zBKrIc7pAims+pmxQy2tVGLEl4k1
 e99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ny935q0jsiqLfV0aitfnpfy0tly85WQIbjVjQEBFMWI=;
 b=tGqgOENDarMeKBif8O6F6SII+aP8RWH/tvpbfIY3/UkKAMPw7xy6Fa6rDOiL03Wn9U
 w4Pj0dqvFd6Mv+eQ1DV2nq76vv/o+0IAqQOQ/LqxHR1Blus9IqMkbSdrD+lD8K0G4yy4
 HtcWuJ6oLkwaaGK7CTmIA1lmBuSPGk03CzYA0V8+3v+qcbiba+Zc66SgZ5m5dh3Sm6m3
 8TKUscuM7YeOqGzTnvaFKoTEEgHQim7h7wwZrWqI5lus2zIuxIRMkkAMwY1V1HltqYTm
 /mVeAVv60MsFTuG1l3kN9yRCdJswruQtyvMqztfFW/prq2CqiotkEiBJ4dhfDbkWFxs3
 RZmQ==
X-Gm-Message-State: ANoB5pkabBSHPJhV7o3h0t+spRaL2lbhZIFIGzuJeDFrJB9Y46Y2Ko96
 waZmT5SFlvUd+UCzCkuUick=
X-Google-Smtp-Source: AA0mqf44+BsWXhDRI0njl9qTDj8zYO6tNuPSaa6SrlJXQ8T5sP6KYfeZdowMN+/VtICWndpKCPNLPw==
X-Received: by 2002:a05:6402:3481:b0:46d:53d7:d236 with SMTP id
 v1-20020a056402348100b0046d53d7d236mr48162493edc.26.1671446840732; 
 Mon, 19 Dec 2022 02:47:20 -0800 (PST)
Received: from able.fritz.box (p5b0ea2e7.dip0.t-ipconnect.de. [91.14.162.231])
 by smtp.gmail.com with ESMTPSA id
 da15-20020a056402176f00b004615f7495e0sm4210446edb.8.2022.12.19.02.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Dec 2022 02:47:20 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: bp@alien8.de, mikhail.v.gavrilov@gmail.com, michel@daenzer.net,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: grab extra fence reference for
 drm_sched_job_add_dependency
Date: Mon, 19 Dec 2022 11:47:18 +0100
Message-Id: <20221219104718.21677-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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

That function consumes the reference.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: aab9cf7b6954 ("drm/amdgpu: use scheduler dependencies for VM updates")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 59cf64216fbb..535cd6569bcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -238,8 +238,10 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 	/* Wait for PD/PT moves to be completed */
 	dma_resv_iter_begin(&cursor, bo->tbo.base.resv, DMA_RESV_USAGE_KERNEL);
 	dma_resv_for_each_fence_unlocked(&cursor, fence) {
+		dma_fence_get(fence);
 		r = drm_sched_job_add_dependency(&p->job->base, fence);
 		if (r) {
+			dma_fence_put(fence);
 			dma_resv_iter_end(&cursor);
 			return r;
 		}
-- 
2.34.1

