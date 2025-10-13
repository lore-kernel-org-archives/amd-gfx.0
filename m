Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF327CCD190
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 14:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1BFA10E46D;
	Mon, 13 Oct 2025 14:35:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KNav2rJW";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D69FE10E46B
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 14:35:10 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-62fc0b7bf62so6423814a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 07:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760366109; x=1760970909; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LLQnmXItSmy81z20hFdhZJLlxzeiJ2xCH+H+JdwHWVU=;
 b=KNav2rJWaq6vw8z/DRP5OSynYAic3wOiOBsJ1WYorAAvYlOHVfCmqFibBPbhcjPzcZ
 5z1kuwpBDIxkHmTuBOiLqhHD4ceGd8SBicNk6WiT0m5Kbxo3G2Dw62P4rDezpQpXdasE
 +suFffGr3IAKAztvCTYYwgr7C2rrlJNPtuAoj92POWjp3s5ZGWCd1Loz49cRlOkBEeYP
 TP27iuuJVwO7uBksibUjBdH4zbbYoh5r97aYFO8t5pCOFWzeidYOGSnLcT/jJhM+yZ9y
 X9nXyvP2fVELAhyeQ2rGxWZvVJ+ER8bzI/ideg+FAwodtnypZczUcVsGtka6iP5A1vO5
 TcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760366109; x=1760970909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LLQnmXItSmy81z20hFdhZJLlxzeiJ2xCH+H+JdwHWVU=;
 b=fKUJ9ik/+IugtErQFdh0Drfk61+uJSllAWZSIEqFMlDwYbBnrJbA+q2h4ebbqZ+lgM
 ojZNaWECL5qtTu7Z9ENtWE7EFm/t125tiz8LTgs2cjqfQwqj9xk7HUTloFtw0qxv+cgn
 4mgEzwoajcGKsuqIfZGUJVHZ01T+XJl4cO24WsUljNnfV4qv4a6xUNeciDt9qiX20FpY
 DwL9lHTqT51lCfrn3WXXCivT7bxb5h12sn0XhoKxO/Om/ohkdRuYWMe9GtOrBoVv9Idf
 p8L+9RJLF4nMIX9cVls1K9sMK0i+1coIZs8/p9ydy3QbuocXoGww8+65B2/jrwNBo/k+
 4pQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoKkmznDT0R2yHZyLyvKhmRKf4i0bIwH30xB/jBKaSIt2XvXIwZa76WjMz4aT7Paamgni0R1ud@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+QOkCxCVT7N9tI62TvL8lR6YsS0le2382kJ0cMOzX/vEmi6iQ
 jA5CEX776wXGfWV9z+KEqqGklDPbxy095EbR+Eedhqrx3PLZfoSu1m3E
X-Gm-Gg: ASbGnctgJzE1zYpYTb7p2eiHcpktsAD05ZMrjA0vDerQpNyfc6ZoZtBXBulQbLhJ9+t
 pNB05JYvplSgMY6c1W5OsNYBtLBpGzz08R1BnceHTxQ1djT9ELlCB0e9WD/pxjDM1Y+lc6ocwy5
 InH3FeNI5QM9Z1OSwuiLXxiISAx9q0YlvsFMsk1hcbjEfTcyVr8TYLch9A0amNra1gpjacjRF3B
 VklS58Bw/c+2ITozFrTTISacacvluG5k1+74Q1/qDpB5+wTJrUB/StNkIQeo0p7Lwz+XxLwzeOO
 EX1kBjm/thfUEmPoIwUImEnwfeaqy8akR6QA875lDnqDhBVYHghBBxYe/fUvAEkzf2RH1pbFQ9G
 xpNcW/eGeSV1purzgR/Qm+6DdtwR1gd35nebvQYZ2TrQg+6cZNytDfzwIKnqZsjO62g==
X-Google-Smtp-Source: AGHT+IGraj4A+6lMzs855DlaUrHnPyCcPhX9oMUFWGOkTxIrwLA1mLTwn1XCHCxbI5xAn9lrH5/XZw==
X-Received: by 2002:a05:6402:1d4b:b0:63a:3e7:4a07 with SMTP id
 4fb4d7f45d1cf-63a03e75e95mr14420483a12.6.1760366109313; 
 Mon, 13 Oct 2025 07:35:09 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:151b:dc00:15d1:ebc5:76e6:730f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a5c321453sm8942037a12.39.2025.10.13.07.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 07:35:08 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/15] dma-buf: use inline lock for the stub fence
Date: Mon, 13 Oct 2025 15:48:33 +0200
Message-ID: <20251013143502.1655-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013143502.1655-1-christian.koenig@amd.com>
References: <20251013143502.1655-1-christian.koenig@amd.com>
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
index a0b328fdd90d..a41ff8e8cd25 100644
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
 	dma_fence_signal_locked(&dma_fence_stub);
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

