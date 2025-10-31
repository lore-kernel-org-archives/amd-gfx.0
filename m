Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23604CCFA06
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 13:45:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F52710EB8C;
	Fri, 31 Oct 2025 13:45:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FXALBBYo";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C56210EB62
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 13:45:00 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4710665e7deso10826965e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 06:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761918299; x=1762523099; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=meQ/lUtaRBcsedYV5hXQfaVQTPQRiVGI+spurVQtjks=;
 b=FXALBBYoqg6knpXWqLemt5Q/WKKMVSEcrmlczq2DTR0eHg1ktcooCepmME8QvwbVwv
 MWZq7yZrbwkHyaYh5m7ajgNBocCjxL3vYIZoUMjWQPvA8Qb2NOUG+6lsbbWI1rPuQEGV
 QDgaBXK0cpE4nTodX5MPd6jZlTQEoQUThUQ2dXwRGiOhOUaqTja+gtiNV7EU/DG5UZNy
 O1CRdCznDujlxedUFibeU5u1F1V2kKZhT4Clf2hvEyiCLoi8JmsO1agU+HbQSuK6mt0H
 zpZhDSnEwDTJSrKvtoMEnYXv5WtNvn+c6pellLJlJPW9OU6xkjDTw5nLn/oKMCRCO9mO
 F4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761918299; x=1762523099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=meQ/lUtaRBcsedYV5hXQfaVQTPQRiVGI+spurVQtjks=;
 b=hkqI1x7tOw7LLnYa45jDDZgLyTl3ka9vTUqiQJleBZfyye6f4NeAk5XErsmaAgAUgb
 Du9w1AM12G8LcNRkXt/761912nzFjWaACmiOXbW7nG+hRTW8S40lrf9G4ypsW2iD//Zx
 Z2bpKRfrwspXi+jlPs0zheT+TcRBHydo4oK9RTJdE6KRM0TsCTH3eQaVoWCIUG3z1pQl
 bqe+jZL1Lm5Flor7l/qozhNuvXi7yFhmmms8Dq6jjM4vHyJE9r2tF0kjmzfi6kJLXPKg
 8Wn+BRC6FiNK6pwP/OnW+w6lY4r/VKlyVoRcrDtJBmmjtY3gn4PVUtD5H4d41oQZERvA
 SCWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXWoAEoPVv8202CkozdxOSQh/o3gaGmg9HN4/N6IeGBmWzEgPrCwLy2DGMDoulY321PHCId0UD@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwfzaICajHuf6hxfiKqsPbAo4DkvmdOzg7DB3sab+6lHpdC4oWL
 lCqMPLA4wqWad4DBJE69dsgu77asRZAj9Bkm/5M4Cr8APnEgsFm6aWDN
X-Gm-Gg: ASbGnctW7uC/HpNpfOXxQpzDJO0e6bfVfSc2elZUXR3pLPbqwIx+Wy+6k46OeZclrlQ
 nGs0LTb6AYE5ug8QFvS1p78Q4aUNBr70C/aW4+0tnDsIiBOd20a9REtwt+jMot3xuApXH89BtMu
 8Ba186rqBJLabXUxXarzSVDjS44tTKOTMJTu4Kz3nqRB8RoECxHZrZXmd9HNdVJBdR7j3e6QNXT
 Ilu5FdRGrizGGQ/hatkLjQytNn0gTw2tqYCO/G9KelLZKEtN8zjz22bmR1v6b8eX+PBUkrqPRBO
 igiMq6taNMU9zMZF4MAuN2tT1Pdwzulg6UPqZ3qC1Sz9SmFYN+NXJTHjrtHRNmASBnNRhQy9OUo
 dlLoOzzcN9EkCR8dtdHtJ2GRcPNA+bZlnEi53g4GGPNt7baGl9mxcdwrsETwcvPD1qJvJpuAr2i
 Zno1giKM+RfDhbyShoyvpp4kwV
X-Google-Smtp-Source: AGHT+IFFRyJUxaAjl37wW1uC1IN4ighJedEFg50RORpq/yrPbiQXSAvoCpaaPc+ile3/7D8vpLOLfA==
X-Received: by 2002:a05:600c:6304:b0:477:be4:7a52 with SMTP id
 5b1f17b1804b1-477308e11bfmr30870035e9.39.1761918298283; 
 Fri, 31 Oct 2025 06:44:58 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1599:7d00:73cb:d446:bf90:f1c0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47732fe119bsm34502635e9.10.2025.10.31.06.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 06:44:57 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, airlied@gmail.com, felix.kuehling@amd.com,
 matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/20] dma-buf: use inline lock for the stub fence
Date: Fri, 31 Oct 2025 14:16:40 +0100
Message-ID: <20251031134442.113648-7-christian.koenig@amd.com>
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
 drivers/dma-buf/dma-fence.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index f9d7439275d1..0dbd2f641f37 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -24,7 +24,6 @@ EXPORT_TRACEPOINT_SYMBOL(dma_fence_emit);
 EXPORT_TRACEPOINT_SYMBOL(dma_fence_enable_signal);
 EXPORT_TRACEPOINT_SYMBOL(dma_fence_signaled);
 
-static DEFINE_SPINLOCK(dma_fence_stub_lock);
 static struct dma_fence dma_fence_stub;
 
 /*
@@ -123,12 +122,8 @@ static const struct dma_fence_ops dma_fence_stub_ops = {
 
 static int __init dma_fence_init_stub(void)
 {
-	dma_fence_init(&dma_fence_stub, &dma_fence_stub_ops,
-		       &dma_fence_stub_lock, 0, 0);
-
-	set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
-		&dma_fence_stub.flags);
-
+	dma_fence_init(&dma_fence_stub, &dma_fence_stub_ops, NULL, 0, 0);
+	set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT, &dma_fence_stub.flags);
 	dma_fence_signal(&dma_fence_stub);
 	return 0;
 }
@@ -160,16 +155,9 @@ struct dma_fence *dma_fence_allocate_private_stub(ktime_t timestamp)
 	if (fence == NULL)
 		return NULL;
 
-	dma_fence_init(fence,
-		       &dma_fence_stub_ops,
-		       &dma_fence_stub_lock,
-		       0, 0);
-
-	set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
-		&fence->flags);
-
+	dma_fence_init(fence, &dma_fence_stub_ops, NULL, 0, 0);
+	set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT, &fence->flags);
 	dma_fence_signal_timestamp(fence, timestamp);
-
 	return fence;
 }
 EXPORT_SYMBOL(dma_fence_allocate_private_stub);
-- 
2.43.0

