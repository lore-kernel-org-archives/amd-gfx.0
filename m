Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC9DCCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 13:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FB2810EB5A;
	Fri, 31 Oct 2025 13:45:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T5pQGM8+";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4948610EB5A
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 13:45:01 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-475ca9237c2so12789775e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 06:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761918300; x=1762523100; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dcs5G3OnlnQFK9aYqll3CwX2/M7qzjpRhdjkxpesGLA=;
 b=T5pQGM8+xh5mRSx/oOe0F4n3l6ZTR8B+3CgPMvI4l7ykEmtXaInRw4G/bUSRpTFsIq
 suRXSPdzuF9IlKCyFaMihdHTi9DtxVZbH2idytBmSU3d+PYa+/1MiMO/P0J3lxZfHGSI
 6EZyEDlfGpBSmdMXHG1i3E5jEJuFpZIJCyyRayav/UGcP6muRRDr7Rq0nuAgnvAFbyI5
 +4bDcJw6K5ljG4/sHSNEz0lBxcpyLSxpmV2UVgb7+FkIZ3eBdOUaW0H0Uhjrh7fJzG1x
 1UPfLs5tu0BJFuAW04Yul0vrpTweftOB/wNBlRcXX4FQXmm/SBrEZ/Y97Yha4Nr4nKia
 7vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761918300; x=1762523100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dcs5G3OnlnQFK9aYqll3CwX2/M7qzjpRhdjkxpesGLA=;
 b=reWQnC+UGfaYetwSYzRm5rNVblrfPw581JPk0wjIsnL+bHzqdwotREBkKx9hhuS1Ua
 eHhEuADRqnEQufwTu/epx5YV1Xs1TThbe9fV3q/6IM1eT4lk5XmDBA1UUmcJpROs3dfR
 obJeoDHIx1j1Z9CqSzysmCmUlgL3BNkx0Gyz+CApracBb7IGH4Vqx4FbY6/C4lAdFsX3
 i0KK0NMwZ6+SNoJqcdqdpTT+ElL/RbFaHHyF/eoM2ZsxGi8j8iVgdyDyrzXJMLwdom/I
 9dCigzGzj4AeoAaL9PXATzJQL7xTTx7PNZY9oE6fDgwMhKQkg7jNNQQa6dE/i8stxILn
 kVdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP1OYzq3Xt5df3mNbb9s2znNiJpiUMd/iOWsyCFaeDcq9JKRJSfPwgja1zp2bOYWDk5qBqJxUK@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxl2cTgaNJHFV0/BL9EKA+2O43Ah43+3M7+zhDY1tHqjGO9MAC7
 p6uhYW6h/6MaI89gpERH66Jrja8OAv56G0IJegodBF/wBZx5bxxl24Zy
X-Gm-Gg: ASbGncshMPAcij19zHQ2krAp7QTD/HIOp11E9+Dl9d/s4QpA6aMgO722Pi9SK9ZnxV4
 gc/EcJfN2zaSuIqeSdPuWawJJr8pIYUID7Lk9h8nwNVA1rngHS97Ouq/5nBuyiPMT/sCKx8qkUi
 v2So2jWjznOmlhpXdBEzEc1vlAZeMQoI5V0dvc3Hd5oe3onXHnmuufCX27dFh32ktLe5GnzLGnm
 4Z8mKgxwCYzf53cte45RH2lyyVvZlQUbdUb4pAnP4h4I/ITHl3f/0MMc9594cxENWFwysYMT/gS
 8DjeXjrtNH3XV4ZNmtI3ghtFiVUXmXLtCAzk4l+aWMEaZVhw+8QHnZXU6uX77YeEoLFV8ruvJ7S
 Bn6hGRFGFJhPQS6rXgY04trbaN8uUE6wC9MjZ+Nnais6iw+PGAHd3EUKC2efIMBLb3GdZf5/fVG
 o0RL9s3JdUz0CFhg==
X-Google-Smtp-Source: AGHT+IEeMawiv1AWBoc/CNasg45ysKOcunYStFH+uIR99FYt1fcC4OBFuND6mmh9bIRXBFr2NSMQ6g==
X-Received: by 2002:a05:600c:4710:b0:46f:b42e:e360 with SMTP id
 5b1f17b1804b1-477308a8972mr30699455e9.40.1761918299694; 
 Fri, 31 Oct 2025 06:44:59 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1599:7d00:73cb:d446:bf90:f1c0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47732fe119bsm34502635e9.10.2025.10.31.06.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 06:44:58 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, airlied@gmail.com, felix.kuehling@amd.com,
 matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/20] dma-buf: use inline lock for the dma-fence-array
Date: Fri, 31 Oct 2025 14:16:41 +0100
Message-ID: <20251031134442.113648-8-christian.koenig@amd.com>
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
 drivers/dma-buf/dma-fence-array.c | 5 ++---
 include/linux/dma-fence-array.h   | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/dma-fence-array.c b/drivers/dma-buf/dma-fence-array.c
index 6657d4b30af9..c2119a8049fe 100644
--- a/drivers/dma-buf/dma-fence-array.c
+++ b/drivers/dma-buf/dma-fence-array.c
@@ -204,9 +204,8 @@ void dma_fence_array_init(struct dma_fence_array *array,
 
 	array->num_fences = num_fences;
 
-	spin_lock_init(&array->lock);
-	dma_fence_init(&array->base, &dma_fence_array_ops, &array->lock,
-		       context, seqno);
+	dma_fence_init(&array->base, &dma_fence_array_ops, NULL, context,
+		       seqno);
 	init_irq_work(&array->work, irq_dma_fence_array_work);
 
 	atomic_set(&array->num_pending, signal_on_any ? 1 : num_fences);
diff --git a/include/linux/dma-fence-array.h b/include/linux/dma-fence-array.h
index 079b3dec0a16..370b3d2bba37 100644
--- a/include/linux/dma-fence-array.h
+++ b/include/linux/dma-fence-array.h
@@ -38,7 +38,6 @@ struct dma_fence_array_cb {
 struct dma_fence_array {
 	struct dma_fence base;
 
-	spinlock_t lock;
 	unsigned num_fences;
 	atomic_t num_pending;
 	struct dma_fence **fences;
-- 
2.43.0

