Return-Path: <SRS0=/zhQ=I7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE54BC433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 03:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C6FA610A5
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 03:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6FA610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=126.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 295CB6E9D5;
	Fri,  2 Apr 2021 03:29:17 +0000 (UTC)
Received: from m15114.mail.126.com (m15114.mail.126.com [220.181.15.114])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44E356E042;
 Fri,  2 Apr 2021 03:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=6Kim097pCo81vc2sXb
 pdlitPc6VpRrbnKVChlbFJMpA=; b=BIuE9AoUHmnIDE0Or9/Y9WXO0ZhvHoZnS1
 rj9YOCFzwDuH7G50yuOWmwSqq77CC415Tg9cfxQh9+XLc1ZLLx30DIzIbIH5Juop
 MH0unEdZlhx23xThqHpg+Kt4zdjuODwe7zV0RD6A4aO7QHyKfYRVvqF/6vBJTnVA
 vwPXPwWM4=
Received: from localhost.localdomain.localdomain (unknown [182.150.46.145])
 by smtp7 (Coremail) with SMTP id DsmowABHgnQfjWZgWTR9PQ--.23034S2;
 Fri, 02 Apr 2021 11:18:56 +0800 (CST)
From: Qu Huang <jinsdb@126.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, sumit.semwal@linaro.org, airlied@redhat.com,
 ray.huang@amd.com, Mihir.Patel@amd.com, nirmoy.aiemd@gmail.com
Subject: [PATCH] drm/amdgpu: Fix a potential sdma invalid access
Date: Fri,  2 Apr 2021 11:18:47 +0800
Message-Id: <1617333527-89782-1-git-send-email-jinsdb@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DsmowABHgnQfjWZgWTR9PQ--.23034S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrykXFW3CF1fur4fuF45Wrg_yoW8WF1DpF
 s5GFy2kr1UZw47XrWDZF4kX3s0k3Z3XFy8GF4av3ZIqw13XF98XFyrJFW3tF17XF4xursF
 qF1vk3yfu3Wj9F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRAsqAUUUUU=
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: pmlq2vbe6rjloofrz/1tbigQBoDlpECr--IAAAsT
X-Mailman-Approved-At: Fri, 02 Apr 2021 03:29:16 +0000
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
Cc: jinsdb@126.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 amd-gfx@lists.freedesktop.org, linux-media@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Before dma_resv_lock(bo->base.resv, NULL) in amdgpu_bo_release_notify(),
the bo->base.resv lock may be held by ttm_mem_evict_first(),
and the VRAM mem will be evicted, mem region was replaced
by Gtt mem region. amdgpu_bo_release_notify() will then
hold the bo->base.resv lock, and SDMA will get an invalid
address in amdgpu_fill_buffer(), resulting in a VMFAULT
or memory corruption.

To avoid it, we have to hold bo->base.resv lock first, and
check whether the mem.mem_type is TTM_PL_VRAM.

Signed-off-by: Qu Huang <jinsdb@126.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 4b29b82..8018574 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1300,12 +1300,16 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
 	if (bo->base.resv == &bo->base._resv)
 		amdgpu_amdkfd_remove_fence_on_pt_pd_bos(abo);

-	if (bo->mem.mem_type != TTM_PL_VRAM || !bo->mem.mm_node ||
-	    !(abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE))
+	if (!(abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE))
 		return;

 	dma_resv_lock(bo->base.resv, NULL);

+	if (bo->mem.mem_type != TTM_PL_VRAM || !bo->mem.mm_node) {
+		dma_resv_unlock(bo->base.resv);
+		return;
+	}
+
 	r = amdgpu_fill_buffer(abo, AMDGPU_POISON, bo->base.resv, &fence);
 	if (!WARN_ON(r)) {
 		amdgpu_bo_fence(abo, fence, false);
--
1.8.3.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
