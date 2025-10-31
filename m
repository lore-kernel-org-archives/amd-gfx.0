Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D948BCCF9FE
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 13:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7840410EB53;
	Fri, 31 Oct 2025 13:44:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AYpT51EO";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE4910EB55
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 13:44:52 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4270491e9easo1974678f8f.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 06:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761918291; x=1762523091; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lz7nSJb0Sp+sy2fFkGoNzLTsSE9Ff1nmykLyZLMIIpA=;
 b=AYpT51EODp/8RH1VKjiNlhV1fB0XPJbHEbH4VkB7ca6usg7WsZia8HD6eGUNCWG2y8
 KV8tM+IjdJJr2FFr10hNrkNh3Nl94hiIXyPswFlSLE7YnI/1/B080eoxmSK5jEI6zTpf
 JJTNYLVko6pcsvSCiXTluqlr3aR459DFBnALU0i9CyJuNG81OLipNaT5a+hmJTpAvptD
 rvLS5V0AaUeneIVwq3iIWRYwq8ihYpfbzViF5um+ShU4P9ErWOrcQtCBbuPXbLBhhf9X
 srBs+hCcWcstt9eMxFTusBwspka2+e+SPapY2pnfxfRonWDDER4gWfIKRQbLDAQNWeC/
 uFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761918291; x=1762523091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lz7nSJb0Sp+sy2fFkGoNzLTsSE9Ff1nmykLyZLMIIpA=;
 b=Msf28jfCrdhakHJyB8lRCPC4gJmBidstjwL1M8sxomgJaW/GBaOhRkg6jVEnmH7u5D
 uTX1j8xNm6au9y58Hq36WArcufnNlxhJ0M/bdgCi5aR7x8VrfzkOhY/tO/usl2RzwGkx
 WT8j3PYn9og264VAo/RCoejqzTUAbwF1+PScWz1h2P+qqjeFi3a1ydnJ5Hapw+IvU5Yt
 fZJmK1bpZdbTKaaEIv/zWQrDp5hn1caQo1QCStj7bQY4BMfc8iJwyQaiAiqkgSYJdMLS
 maa79G4JTA8uM4KQv54y63gMe6txfodKTbLmQQqeX8Ym9GVHZVX1FeP8VGKMhEwzdZKB
 Pc6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0QD6b+aVoCznxEtOiYdhJw2Oma39GSD6PDAz5wugA8S1WLSdYB5igbFL2sEGfgavicD6y0jF6@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNN2Ok7DdefAMiK47lKEjpeFnR5Bwz561BFGnwF2eD9BKpQ2NV
 /ObPaJQ5O5Yx4t3z2Djd/jwjxwbANaPsld+iHn5UmgMaF5NdbloEJeh1W3d2zIyQ6ag=
X-Gm-Gg: ASbGncsQ0mVBoF4nb2HL2q6JlqM8Hr3vRNuQ3HvaYHCOS4LIzXWbcM4mDNdJlefvK+m
 b8tZA6W2Cn/SEm1wNEDSudhd2XYo+HUnJJkguOyh+JWIlrLmyYCu+M5KNheUFSBfhL+aQbtvfYm
 v1OjLAwVpt2zKc8ixjccRPyTdtrajO27LJhIwjL36c5fUQ/ctsOv10eXDu1Vu3hIbOaL4w06EdO
 xb3Qmnrc9XqafjS42nLzzqnvMSRVK/4uVbMHVyNBPWUI0L4GaTQq6p5g1oz5Np/X/AhBX4VS5rJ
 UHdCSEveR4wu0yJ8NX/yLc9QOnHN9FavaR3eLkGXsN8o8LLBJj67Brzaoj+CDCJy5mAVfavlDQv
 D9RVpGH3cdVGABd22yDO7LzPPVgPOe2ZY4Hxv7etI5hJ3VxdCLb8xUY/oJAA3Vxvx14RiiNyyas
 BujVcdOZQf9XL9kaUG40Wu8HF+
X-Google-Smtp-Source: AGHT+IFX6Ta9CYbUtJzM5PiYi/UpTYqzIRRkMQiJ4fP17ykxBqc5ghDpURSmf9BUutDj5IVWkT0/Jw==
X-Received: by 2002:a05:600c:8185:b0:475:da13:2566 with SMTP id
 5b1f17b1804b1-477308a690dmr36307795e9.35.1761918291097; 
 Fri, 31 Oct 2025 06:44:51 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1599:7d00:73cb:d446:bf90:f1c0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47732fe119bsm34502635e9.10.2025.10.31.06.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 06:44:50 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, airlied@gmail.com, felix.kuehling@amd.com,
 matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/20] dma-buf: rework stub fence initialisation v2
Date: Fri, 31 Oct 2025 14:16:36 +0100
Message-ID: <20251031134442.113648-3-christian.koenig@amd.com>
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

Instead of doing this on the first call of the function just initialize
the stub fence during kernel load.

This has the clear advantage of lower overhead and also doesn't rely on
the ops to not be NULL any more.

v2: use correct signal function

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-fence.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index cfa6ddcc1278..b229d96f551c 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -121,29 +121,27 @@ static const struct dma_fence_ops dma_fence_stub_ops = {
 	.get_timeline_name = dma_fence_stub_get_name,
 };
 
+static int __init dma_fence_init_stub(void)
+{
+	dma_fence_init(&dma_fence_stub, &dma_fence_stub_ops,
+		       &dma_fence_stub_lock, 0, 0);
+
+	set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
+		&dma_fence_stub.flags);
+
+	dma_fence_signal(&dma_fence_stub);
+	return 0;
+}
+subsys_initcall(dma_fence_init_stub);
+
 /**
  * dma_fence_get_stub - return a signaled fence
  *
- * Return a stub fence which is already signaled. The fence's
- * timestamp corresponds to the first time after boot this
- * function is called.
+ * Return a stub fence which is already signaled. The fence's timestamp
+ * corresponds to the initialisation time of the linux kernel.
  */
 struct dma_fence *dma_fence_get_stub(void)
 {
-	spin_lock(&dma_fence_stub_lock);
-	if (!dma_fence_stub.ops) {
-		dma_fence_init(&dma_fence_stub,
-			       &dma_fence_stub_ops,
-			       &dma_fence_stub_lock,
-			       0, 0);
-
-		set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
-			&dma_fence_stub.flags);
-
-		dma_fence_signal_locked(&dma_fence_stub);
-	}
-	spin_unlock(&dma_fence_stub_lock);
-
 	return dma_fence_get(&dma_fence_stub);
 }
 EXPORT_SYMBOL(dma_fence_get_stub);
-- 
2.43.0

