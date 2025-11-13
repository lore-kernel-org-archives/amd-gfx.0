Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA9ACD8C80
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 14:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 619D510E83D;
	Thu, 13 Nov 2025 14:53:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="URCGf1TT";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A75110E839
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 14:53:42 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b3c2db014easo153308166b.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 06:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763045621; x=1763650421; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2ma830UDBT4pjVp7KvmyTGIRgR1+38znq+/rAoJE0o0=;
 b=URCGf1TT95AziNZ92auo7pIYEUemjo9N3XnsqyjHccMR0qmSuIx24r6jQ0LMkyPpNl
 /3zqGFUasIwfCpHQbzKysAhjVqm0whNNDfTswRUeOFMgk0k+xcenL/LbQjIYFxFHpLtd
 eR5M4tzkJIxZLD9DEcH7k3ra+WIYQIFxKF0M4GYJPpAS8POZcL70yUruA6vljAL5NKDA
 J7Qh2E0A0O2nCmvJRtUItrG5N59ePUa/a0YFPVYQWOdkUBWPtsIUvtNg1cop/iKfY+af
 WgxVyK+9Boc3GfzG3CxZ+8TmyhSjmIaeM5Bn9fRz0Z7RqpFz7eS3Ih2KdR2GM3IsTKlZ
 2JnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763045621; x=1763650421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2ma830UDBT4pjVp7KvmyTGIRgR1+38znq+/rAoJE0o0=;
 b=IETQelvSGMJ/EnFS3lUXFHFPlIZqzTz57LGcCbp8+Jbo9Tkx2xa35YSMZmGSsRrIvb
 cSHWEy5c9O71B/G68dgvb4rSRGH3LpsKOb4ERh9poXGk8HkvVXhiPus0a9tT6/Gtg4zx
 F0i4dbC9Vt6C8mhhJto66coLR7wJjYPAv1Jy9sHnpNylP7omxIOMWX9lk3FRO444L9dV
 4Rgw5aKS9QNs79eUYj7wppOmEMPPO14CxSfYj1igXcSsSfbV7NsXyMr78z3hOPTaPIzV
 RpvYeG8Tq/3ybXiq0jNXIoGlWHFBBgeNulI+t9O31d9DUflY7gTz0Bm9LzQYEys2wNaL
 WwuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQBrw6g5XMyUniy3raXe7ytuqwgb33QY5BeVLdtijfrgva5o9KAi4DM+Kz2RYDIpj3MkRE7ppt@lists.freedesktop.org
X-Gm-Message-State: AOJu0YymCYCx0XOxGy2ROyph8GPMJF7/8vGQyOUotyen4JJdKVM19366
 xinJCwB6QQ8BPsBVG9oMtew2olnH8/MHl+ptnsc2uKS7WrRhhNg55B/e
X-Gm-Gg: ASbGncuEmHTLuN7BMaDTY5ndfIa/a8FOOK4NcOonYsDXMiK6sgSO11209Szow+FKN6a
 rWjdXY/i9M07TgoZ7PYsCTg1YwoWuzU+01GLE2ja2aZ9uAbTH8GLKOCBOjEgNrAlE//Jgr+DCbB
 ljEQTxSKgE9iNZT+/8lGo1vmLMJ9Wm/T0lih7cpZPPFy8prYYXO0iQQOzCIEzEXWfr4JjIxcHfX
 9oTuWN6eJxRiSE9tx9RmIV3QVF3kIHFqNgzV7Beh0zegwuXDi50j8OqlyCZOJsNXsnIS7ryydNw
 agwiwvnCdy/qjLyBlPwNi+RVKVe189r9L+30AHJzMuSxFi1wgvxS51xVCdC4Rtn61vlSQKiKzwM
 d8nKyLDnhsfYpYetP6D6rkKD8H6pmnwbR92IiXKZkgzTYlLCHhl2cYGKMdmd3uIboLwiBAoevOY
 htGBGMGTHRLd4=
X-Google-Smtp-Source: AGHT+IGmTxRltBDCj6Rm69m8Ui1k6YY9cv5jYHS0CdN2mzixtVtyrx5F6p+iFVQIfWYtnTMy2kFBfw==
X-Received: by 2002:a17:907:96a1:b0:b72:1ced:f213 with SMTP id
 a640c23a62f3a-b7331a5d757mr684327766b.37.1763045620550; 
 Thu, 13 Nov 2025 06:53:40 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15aa:c600:cef:d94:436c:abc5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b73513b400fsm173747166b.1.2025.11.13.06.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 06:53:40 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, matthew.brost@intel.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, sumit.semwal@linaro.org
Subject: [PATCH 07/18] dma-buf: use inline lock for the dma-fence-chain
Date: Thu, 13 Nov 2025 15:51:44 +0100
Message-ID: <20251113145332.16805-8-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113145332.16805-1-christian.koenig@amd.com>
References: <20251113145332.16805-1-christian.koenig@amd.com>
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

Using the inline lock is now the recommended way for dma_fence implementations.

So use this approach for the framework internal fences as well.

Also saves about 4 bytes for the external spinlock.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
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

