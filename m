Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D56CCD6E78
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 14:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 414A810E830;
	Thu, 13 Nov 2025 14:53:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bIHNDqG/";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9682310E830
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 14:53:38 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b72db05e50fso160090166b.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 06:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763045617; x=1763650417; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TKX9weevS+NcJ407xi5DYySlL9DlXey2iX34pOiJQdM=;
 b=bIHNDqG/iIE67Sc3qtVVeTos4ALCaOEoK82Ipdd3K1DpEUFnnnqMu0p5t2FJMgwSJS
 y3QvUpzzkB/Cj0PEkfyg1jDlkdYC5PEtP3P6a4fXRu4R4xqFYItiwVqMckUY8R7X4pFT
 8ygq/tlv90RkFDYfcymdPilZryLPsKQaRf1ZcS0mrmRW31XrMSqkF7XphQurTFf7NzMH
 j1utl569YVCLWlo5LnOTX8tqW6U6gZKO+M8WoB27d3b6snqVW+Y1OROzDa0hIyz3rKR7
 C/hQzzjFl6J78p3AGb9YkVyRCT7EWX1XxSw8bG/2YyPozxQcTjFpQ7/0ymxpL1yw3HrR
 b8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763045617; x=1763650417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TKX9weevS+NcJ407xi5DYySlL9DlXey2iX34pOiJQdM=;
 b=A8wl6ksOpUcz1TJW4g3Wz5a2IUy8xTiL5iqK+EJOJ2jN6qCyp0xWZ9THyR7VCiiZh/
 OIFpB26xRORTXxhIs1Zjf8jeOD9xddyn1g6zVmqs2EhZjWGkr1EJuyttEspMRVfK7owD
 S07V+wYm/VQN3kO5GMYJ2MLclYvlPmdNTHp6PPyPGl+Du4SMMJyqoHjvVnhMWLeW5AN2
 yooZmY6CJgcCLf7JHWqWm2qqhiRSs8P/V9uX6b9ZGH8im90XyRw0v4l0FHUCx0/2gj6D
 UZDd4co7IX4xcfg0on4NODVVQ6dgFjIBQ13bci1fJuXZwpQOiq971BD46tqIIzuwHDla
 hPHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhC5ElusCVh9IH71v2uSJfr6iOUIzE61Qqr9xC9WKCrEW36/oWb8mYEDRwi3KxzESNFf3+Ym5l@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgzRt+th8UnfxbAyF3+tyMu0ndXqCvXraPV+T5brZN7KwvQBSs
 RgLfFf1fXtjnrnMk4l2rs8xl/qoRS55LtAghvOKuHbUSV3ckepzzp2qZll+ypQ==
X-Gm-Gg: ASbGncuRk0JepJ8CbYRZk4nzWSyD9C8UpKZC/zPsIvjpRaj5CbufPiPOxoHHQXaxQEl
 HASJmj6OZPGcS+nkv6N/JypKWYSFdGx6MD2jAhDjHnF4MIEwkvIBbR2yBi9vnb7BtGEtT3GpOQA
 XuM72zUsLqANIC0wq4YOxoEoruTX6djlHLECQ0Qy/6MbrM2+PnWjFsBKe6+2ZbI+zDv1iLA7bjZ
 sjVKCiX9ScCQ8tKjQu1E89H5WEgWS6a5oObu/o3ujvWbKlUi6ANqTMw58GONl50K2pLbvijZzFv
 k/YKu0egPzmW9yY1roGoCRhMU2yyGFmkY1bZkgve4XSjx6s9r14FDuLT/Gmxlixe0wN+V1fat+7
 eNLx2kAp6t/Qe6cv+S8O1oVbgwjhq0meWm6TY2x58ny4uUbx6XDK0B5Ofb/aWKBeoBCjxs8kupz
 4M0Q1YN4Y8g7Me3Lvnk8+qbg==
X-Google-Smtp-Source: AGHT+IGXKsqirjAlMp585gkAkiQJO7pFlXJ2rNvLaF2oiytnabvZYB83EV9YYgjEuGG19e6QmbGeaQ==
X-Received: by 2002:a17:906:a207:b0:b73:39c3:b4f with SMTP id
 a640c23a62f3a-b7339c30d46mr374756366b.50.1763045617052; 
 Thu, 13 Nov 2025 06:53:37 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15aa:c600:cef:d94:436c:abc5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b73513b400fsm173747166b.1.2025.11.13.06.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 06:53:36 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, matthew.brost@intel.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, sumit.semwal@linaro.org
Subject: [PATCH 03/18] dma-buf: detach fence ops on signal v2
Date: Thu, 13 Nov 2025 15:51:40 +0100
Message-ID: <20251113145332.16805-4-christian.koenig@amd.com>
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

When neither a release nor a wait backend ops is specified it is possible
to let the dma_fence live on independently of the module who issued it.

This makes it possible to unload drivers and only wait for all their
fences to signal.

v2: fix typo in comment

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-fence.c | 16 ++++++++++++----
 include/linux/dma-fence.h   |  4 ++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index ec21be9b089a..7074347f506d 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -374,6 +374,14 @@ int dma_fence_signal_timestamp_locked(struct dma_fence *fence,
 				      &fence->flags)))
 		return -EINVAL;
 
+	/*
+	 * When neither a release nor a wait operation is specified set the ops
+	 * pointer to NULL to allow the fence structure to become independent
+	 * from who originally issued it.
+	 */
+	if (!fence->ops->release && !fence->ops->wait)
+		RCU_INIT_POINTER(fence->ops, NULL);
+
 	/* Stash the cb_list before replacing it with the timestamp */
 	list_replace(&fence->cb_list, &cb_list);
 
@@ -513,7 +521,7 @@ dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
 	rcu_read_lock();
 	ops = rcu_dereference(fence->ops);
 	trace_dma_fence_wait_start(fence);
-	if (ops->wait) {
+	if (ops && ops->wait) {
 		/*
 		 * Implementing the wait ops is deprecated and not supported for
 		 * issuer independent fences, so it is ok to use the ops outside
@@ -578,7 +586,7 @@ void dma_fence_release(struct kref *kref)
 	}
 
 	ops = rcu_dereference(fence->ops);
-	if (ops->release)
+	if (ops && ops->release)
 		ops->release(fence);
 	else
 		dma_fence_free(fence);
@@ -614,7 +622,7 @@ static bool __dma_fence_enable_signaling(struct dma_fence *fence)
 
 	rcu_read_lock();
 	ops = rcu_dereference(fence->ops);
-	if (!was_set && ops->enable_signaling) {
+	if (!was_set && ops && ops->enable_signaling) {
 		trace_dma_fence_enable_signal(fence);
 
 		if (!ops->enable_signaling(fence)) {
@@ -1000,7 +1008,7 @@ void dma_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
 
 	rcu_read_lock();
 	ops = rcu_dereference(fence->ops);
-	if (ops->set_deadline && !dma_fence_is_signaled(fence))
+	if (ops && ops->set_deadline && !dma_fence_is_signaled(fence))
 		ops->set_deadline(fence, deadline);
 	rcu_read_unlock();
 }
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 77f07735f556..eb57bcc8712f 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -436,7 +436,7 @@ dma_fence_is_signaled_locked(struct dma_fence *fence)
 
 	rcu_read_lock();
 	ops = rcu_dereference(fence->ops);
-	if (ops->signaled && ops->signaled(fence)) {
+	if (ops && ops->signaled && ops->signaled(fence)) {
 		rcu_read_unlock();
 		dma_fence_signal_locked(fence);
 		return true;
@@ -472,7 +472,7 @@ dma_fence_is_signaled(struct dma_fence *fence)
 
 	rcu_read_lock();
 	ops = rcu_dereference(fence->ops);
-	if (ops->signaled && ops->signaled(fence)) {
+	if (ops && ops->signaled && ops->signaled(fence)) {
 		rcu_read_unlock();
 		dma_fence_signal(fence);
 		return true;
-- 
2.43.0

