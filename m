Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2823DCCF9FF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 13:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B2CF10EB7A;
	Fri, 31 Oct 2025 13:45:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kiqthR5H";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEEFB10EB63
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 13:45:02 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4710683a644so19956545e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 06:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761918301; x=1762523101; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r+M6T90aofvVrx2e1vqwPoDjqCLdEjx6BHMLbVIttJc=;
 b=kiqthR5HkFJa3oJv4kf09BX6GQh+oRz4EQucKUfZoKTmLU0prRAQpggPuRn+jHAjeS
 IaNw4sLgLLYjcnfW8YDBkTAmAikm6hiN7j7LDTrJy10P62Vp4AxmfbF4MoTbM4P9jGc0
 Inelk1on+pK2r4O1bUU0I8jpB29cEs+po2MHZxPU5TyhoiVnfxVral5ArNB6P4A1iP56
 x59egKyvsdIzVEk4KdUDJyzxd8d+b8ds184pvSAeZL2ZQnkQXovYLOD72zClR3pz/Mch
 vtgi9qZVOYa+eA3OVEl/E4AbuSlTdaQNVAnniZ/BBOPAv/p5diVafuspmbwXpAQ171TB
 +FoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761918301; x=1762523101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r+M6T90aofvVrx2e1vqwPoDjqCLdEjx6BHMLbVIttJc=;
 b=Brtm5qzhfOGa5PepfVbTjK59lhbjUe5MeGq2Zk0kz3oMJRvdkExql7w7ecd5I6cbbT
 3Aa1894ikaBRlqX40JtlUHXf3FRBlMu3j84uqjS9Vh2ZV+3slLthpFbPuHe8GQHvhcw9
 fgW7h1wbt6h+r+QOT9Xq8D04V468e569Lcb5nFtMKqysTuSzswCrILNMh+33tyNSP9CO
 9I+Ua3DKAapmC6WYc+60M21vZFgz0/BfBecgwjxjilLsHsUuWGFqYV7ex5/lcg8OEpQ+
 4w41GVo57k1DUYiyGKURxwEpVXWjPRPBigNQtvcL2/xgEpsyVWNZ7adV6QutZ/TZhpt3
 8pCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+cfpx6P7mIGK90+W+YkFORZ7bCw7hH5KR6KRkruHMNu0d30mqdIR8XrmNoTB0WexaUie5u4DB@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/n7iL9caEd2fVLQZE0rEwkqKr0tH78POq8Tfs0uxh2ud3w1DG
 36Yvkm1Fb2ngHnESRgiEIEXVkNsq+EBcSw+LCObf1MMIwdM0fKpXjRbd
X-Gm-Gg: ASbGncvp7aVt8ybDeh1rFxTKYQ50RwojyBqZD5lxIjJ2GMplawdNaAdRFq/ChyujSLM
 jhRBEslD0sogPmkYw7GAzsEEyTaQXOLxuqg7BJoldt/duxkCz/vkSrM9BiuMwiAFVzILetH3YlU
 oWfNCxc+dPFvSGv72PHlvvqhAhqpZpIDJ0vtxu7WQ5l05P3zkXZYI06xzB7Zr8lNZCKio+OhYvT
 jEs8J6fKD3RMbcoOfDFd9Z0e+F8rQUQ3LHt1dlnlBMfBctFpUuE+G5UYAkxv0lLueMAKD8f2pap
 CxZuPHqq7FP5pUioSobraYcQv2siAcm9Jt0ZLBYoKx4JYNPGAHPU6oPb4OKkdFFgv1XNfWQNugV
 iGFTzSPWg8+d2A6ZPd/kPjNEv4vg6FwFNX6iPUSoIouvo9NaaD804cnEuv6sWgq8oYnnBz8R8Ap
 2wgFUqIQfQ8lAVB0u6ziofGus4
X-Google-Smtp-Source: AGHT+IFX7whiEu3T/ZniEyZKLJWgGOatI/5lyGdQEDOZSx8nSdql+w6Wj2GIpV8aiN9yL6yui9Uzdg==
X-Received: by 2002:a05:600c:8a8:b0:471:793:e795 with SMTP id
 5b1f17b1804b1-47729701baamr34765925e9.0.1761918301096; 
 Fri, 31 Oct 2025 06:45:01 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1599:7d00:73cb:d446:bf90:f1c0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47732fe119bsm34502635e9.10.2025.10.31.06.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 06:45:00 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, airlied@gmail.com, felix.kuehling@amd.com,
 matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/20] dma-buf: use inline lock for the dma-fence-chain
Date: Fri, 31 Oct 2025 14:16:42 +0100
Message-ID: <20251031134442.113648-9-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031134442.113648-1-christian.koenig@amd.com>
References: <20251031134442.113648-1-christian.koenig@amd.com>
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

Just as proof of concept and minor cleanup.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-fence-chain.c | 3 +--
 include/linux/dma-fence-chain.h   | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma-buf/dma-fence-chain.c b/drivers/dma-buf/dma-fence-chain.c
index a8a90acf4f34..a707792b6025 100644
--- a/drivers/dma-buf/dma-fence-chain.c
+++ b/drivers/dma-buf/dma-fence-chain.c
@@ -245,7 +245,6 @@ void dma_fence_chain_init(struct dma_fence_chain *chain,
 	struct dma_fence_chain *prev_chain = to_dma_fence_chain(prev);
 	uint64_t context;
 
-	spin_lock_init(&chain->lock);
 	rcu_assign_pointer(chain->prev, prev);
 	chain->fence = fence;
 	chain->prev_seqno = 0;
@@ -261,7 +260,7 @@ void dma_fence_chain_init(struct dma_fence_chain *chain,
 			seqno = max(prev->seqno, seqno);
 	}
 
-	dma_fence_init64(&chain->base, &dma_fence_chain_ops, &chain->lock,
+	dma_fence_init64(&chain->base, &dma_fence_chain_ops, NULL,
 			 context, seqno);
 
 	/*
diff --git a/include/linux/dma-fence-chain.h b/include/linux/dma-fence-chain.h
index 68c3c1e41014..d39ce7a2e599 100644
--- a/include/linux/dma-fence-chain.h
+++ b/include/linux/dma-fence-chain.h
@@ -46,7 +46,6 @@ struct dma_fence_chain {
 		 */
 		struct irq_work work;
 	};
-	spinlock_t lock;
 };
 
 
-- 
2.43.0

