Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0EDD116F1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 10:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D67310E38F;
	Mon,  1 Dec 2025 10:50:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rLTAWzYx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 576ED10E38D;
 Mon,  1 Dec 2025 10:50:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CAF2B60137;
 Mon,  1 Dec 2025 10:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E334C113D0;
 Mon,  1 Dec 2025 10:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764586256;
 bh=psV3AjFMvx+hXzUq9J8i739SH64kLqL5g0LrFSRpUkM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rLTAWzYx6rzjm5FOB1qQRsnqmGx9jZme2PkpQdPQ5Gk9SYiCeR3uqyFWB/ecKz80T
 dFkAKaEmVUAj/yOX/dJf22/kQnshwBsC3eedsv1wk5Ojj1vQnEi6rZqpRTA3Ufntdr
 P7OmsO/ICoEgrwsStpB/dILe4tLxYKj5JGeQQT1jXrkaLHVbmo6FhS1377mQIm2awY
 2ptlOGK6moAeJgfunx/ryXcHzUc0TXM8v0mN+koe4xQcIdrOVPAouclixrhcHNccdv
 rXFXI0ABcANLgSdbNSwCebdfb7OA2BZE4GhcD9eWrQt8VoUQLnNNo0O1ZvzdLUMnUl
 YmmkPTZeKOJ1A==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH v2 5/8] dma-buf: Don't misuse dma_fence_signal()
Date: Mon,  1 Dec 2025 11:50:09 +0100
Message-ID: <20251201105011.19386-7-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251201105011.19386-2-phasta@kernel.org>
References: <20251201105011.19386-2-phasta@kernel.org>
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

The return code of dma_fence_signal() is not really useful as there is
nothing reasonable to do if a fence was already signaled. That return
code shall be removed from the kernel.

Moreover, dma_fence_signal() should not be used to check whether fences
are signaled. That's what dma_fence_is_signaled() and
dma_fence_test_signaled_flag() exist for.

Replace the non-canonical usage of dma_fence_signal().

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/dma-buf/st-dma-fence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/st-dma-fence.c b/drivers/dma-buf/st-dma-fence.c
index 27a36045410b..4dbe39c58bfb 100644
--- a/drivers/dma-buf/st-dma-fence.c
+++ b/drivers/dma-buf/st-dma-fence.c
@@ -126,7 +126,7 @@ static int test_signaling(void *arg)
 		goto err_free;
 	}
 
-	if (dma_fence_signal(f)) {
+	if (dma_fence_check_and_signal(f)) {
 		pr_err("Fence reported being already signaled\n");
 		goto err_free;
 	}
@@ -136,7 +136,7 @@ static int test_signaling(void *arg)
 		goto err_free;
 	}
 
-	if (!dma_fence_signal(f)) {
+	if (!dma_fence_test_signaled_flag(f)) {
 		pr_err("Fence reported not being already signaled\n");
 		goto err_free;
 	}
-- 
2.49.0

