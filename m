Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8476BCCF9FE
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 13:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 978FB10EB5D;
	Fri, 31 Oct 2025 13:44:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JrsDq6gL";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A00510EB56
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 13:44:51 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-475dae5d473so18292515e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 06:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761918290; x=1762523090; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ag5FkbZtay2eYReP7iBnTnWXSWPnI35nFvt7qbQnJDY=;
 b=JrsDq6gLIcRFGga6IZ9fqnorsjia/0PAlhUONyardc2sVwoZyads3zIpOmdu2ViJMb
 OnsAZc/qMWgvrDBgWMgnro5sGtOxVhfJtwc4jbekHZV2tvU3/Yi8mVLruIfawSEMc5ZA
 aV9wfy2BA1GzEbLuxjomipmWCCZUGu7wyDdmHUOsgmowO0TLc6CO32nxiIBdUjGkEIyn
 pxsyrK5Xh/wPiUmUgk4ePfRjHO5oDidvlV0AhTCwPhWWpipLNYyLpS94w5f5pny/uWS9
 ZCAT1mlK+IhkBX6joYvV1Kp0VbuT9kO+LbNgZImSoO9sB4GMq7u/DajQd9OU9pHacr+9
 5Eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761918290; x=1762523090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ag5FkbZtay2eYReP7iBnTnWXSWPnI35nFvt7qbQnJDY=;
 b=PXtEDDDe5W0t8kuHzdwl2Ti1kloVA8N++bw7hsV5HBI0LYXqsxshkVy65gfEvQoEJO
 qIuveoAhPB5IkL0nwTy/hnAtc4q1sCz0ifBwZATw0Z2vp+6Vez2/o2OAwfIQH3ClH4ru
 iiSltTvyjyNVmdSn9/x+ZBxm90N0RnV/WWOePLP4wwvLl7hS5+CPx/3QEhaWE/baG3xV
 PYd3bGXskM9p0wwJUaWQxEqBTnQOiA78OWtMafu7g88vxgkoRmp5iUwocvVWgYDnFTys
 HuJ1zg+REUAJybMVRAOENCRGgq8gxw0yuRoFAWzcamjFwY1LIST6M19wMjSyCIH+zzAt
 TXTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSd9Aiczv118tLTYEDptyOWOLMvEin0PDt9LoI2Q3U3HGjfnQaZ0vBJnWTjMSctNLuIoQNKraZ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMXwJ/w511KwVe+e4xXldfpFcrzfisPwpYTcTSWSbcbbTF5Lhk
 MectCXBPz+BYJZuH3HAGF6iKmXQ4WYkidDdcYtZq+BGSpQUyAT2kKITg
X-Gm-Gg: ASbGnct2Xh2o96oanDluBs1+zO87W+d6RW0hu9W+n7Myecf4ZEjCsr3p+XuDeNSqWgt
 Ab2azBpCbboIdvHHruqqaP4+h+CyqX4yEES9M4V5W40CckUSz6KxbUVVot3iYIrFg9w05x6Uwih
 hy3xlWQ7Vg/Ax6VblaZ4Cg/e1QsARmcqLHs7bda2o1fJcNbZ65e9PnjYtvk6b4cu3i3+icK36Pc
 2dNLW5Cc5apypMnH1nxo3Ju8RFY8mQ4sly/a/xhuNpFXpXEl57v7eTZQIyvcmrHXtcKe3sGBAHQ
 UvHQk0+0lrqCfuXSOAr4CyGwPy+AQ/8veOEB/6dxJ+yQVUv/1RY3Wbzc7fIvB5fu/TQGAQ1jqEo
 7wUjZZAp+GuTflgTXQsVtsB0APxZMcSCDdUNT9syV+/ZU+EfPB/KvXDqyNeWG2CPlBn0qGsFDIt
 x2R07Hs8CkL7rVjCzoph27U+SZ
X-Google-Smtp-Source: AGHT+IFkbldy8xg68PffupyHqmyaNVMQ3g8iX3n65HmihoTKQ5OEIUFxTJf4S7hJ5dPJRm+hfyZiCg==
X-Received: by 2002:a05:600c:1d9e:b0:46e:37fe:f0e6 with SMTP id
 5b1f17b1804b1-477308b0b93mr34279835e9.30.1761918289395; 
 Fri, 31 Oct 2025 06:44:49 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1599:7d00:73cb:d446:bf90:f1c0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47732fe119bsm34502635e9.10.2025.10.31.06.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 06:44:47 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, airlied@gmail.com, felix.kuehling@amd.com,
 matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/20] dma-buf: cleanup dma_fence_describe v2
Date: Fri, 31 Oct 2025 14:16:35 +0100
Message-ID: <20251031134442.113648-2-christian.koenig@amd.com>
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

The driver and timeline name are meaningless for signaled fences.

Drop them and also print the context number.

v2: avoid the calls when the BO is already signaled.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-fence.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 39e6f93dc310..cfa6ddcc1278 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -999,19 +999,20 @@ EXPORT_SYMBOL(dma_fence_set_deadline);
  */
 void dma_fence_describe(struct dma_fence *fence, struct seq_file *seq)
 {
-	const char __rcu *timeline;
-	const char __rcu *driver;
+	const char __rcu *timeline = "";
+	const char __rcu *driver = "";
+	const char *signaled = "";
 
 	rcu_read_lock();
 
-	timeline = dma_fence_timeline_name(fence);
-	driver = dma_fence_driver_name(fence);
+	if (!dma_fence_is_signaled(fence)) {
+		timeline = dma_fence_timeline_name(fence);
+		driver = dma_fence_driver_name(fence);
+		signaled = "un";
+	}
 
-	seq_printf(seq, "%s %s seq %llu %ssignalled\n",
-		   rcu_dereference(driver),
-		   rcu_dereference(timeline),
-		   fence->seqno,
-		   dma_fence_is_signaled(fence) ? "" : "un");
+	seq_printf(seq, "%llu %s %s seq %llu %ssignalled\n", fence->context,
+		   timeline, driver, fence->seqno, signaled);
 
 	rcu_read_unlock();
 }
-- 
2.43.0

