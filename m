Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4719CCD183
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 14:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DC4F10E0D7;
	Mon, 13 Oct 2025 14:35:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d2UmbmEg";
	dkim-atps=neutral
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77BE210E45E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 14:35:09 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6399706fd3cso6316468a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 07:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760366108; x=1760970908; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tx+FtWNVNlgZFr6xVE4UGgIzNBLnYCt+kgcUHpCDArs=;
 b=d2UmbmEg0WJXYiFBsTWRZhMIuCUnDHZlLzb2KBGHSOFn+zxSgS5RW6vwziB4rVOOXx
 swj4FVd/hZ/anyCDZv66ruzpTCgCRJwMQHBAFxjtNOfSqZaIOy8zh9hsBdZ5QS/bO20K
 YFxyM5CqG/6BHNccyzeCTVXwiBWyiJXTiJ7PXE8OMZr0VF+3/AcWgc0cE9mJCb0nR90M
 qveascJ24yFJ6NhcIz/Cvv6oquDQe6p6CgRKMbfS0GQc3Ys9rlgLzH+GVPX+VIEdAPMF
 U7cxZuVzISMDNbiFP64+/cZcunFk6LhbuiQSO4RToORrY69wfh57+mMspMuX+oYjNGvg
 ukfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760366108; x=1760970908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tx+FtWNVNlgZFr6xVE4UGgIzNBLnYCt+kgcUHpCDArs=;
 b=V5d1In8MgKQ74cimudhAuZZanWP6DVft4XocO3SDDMIocw9XE4Yoe5rRYshOZ3gE2+
 KPNIalo+LIVQrWj22OvBtd22qwbWyB/3lFE5KB+qS9SwWf1YSB0ZU61eCiKEP+f+f0KV
 0SiN2Zsp0zMc5bkuUmiGxJ8ZFpD8SZUj2lJXtMrrH24/aD4KVnoGqmr2uOotryat2mfU
 LS9smh5zAE1thPfIAOJLgabbb28dPWyhoVlvIrlXEhdZUJxVY+qRk5AI2gAOqAoqV4ci
 JfA3Cw4gL66vh6RYi9nxxd2Pq0NwZpobB5Tr1eHcvhSXaooCIRHXWxVQzYsJyyMCRNEC
 esMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4lCjO1eJ7wo6UtVqmkgAuoPKnz7t0SUSNRfRAc9JMsHIbscBoHzCqkeybQSZFiEivtyC+eROv@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz22HP/5vwdkjsFse30bsgegRiNp/Sm+z9P9JJQdF2AX8zajD6+
 gEAg05Pdjx8ZlnVcmktZffN12NzZFDfjPKFh/JKS+5tqUCYOC/BVNo8U
X-Gm-Gg: ASbGncumdbmj/ylhqXRecOVXs7CmHB2U3ONXIGnRpD51/DGg67Kff+bq1zYianhRa40
 I4yhDtMtwBhmeld7yqxqAwh+FDK7a5Gvs8ZAbD5XB/tmSn9e/Mp2eAC+t2VBoEw4Bur9kYjZs6E
 +/bTdEYiUoojJNXll9jLqxKy3J1S6BQ9CVE13CjymIME3iFbyiTRt/bG6alvlXFPCq0q9sABqQb
 R4X0dCONJwlPyxdKOx1SVzc6ACMYebgXDvQ8hCj1BKGFrrv0SyQEFcPC/AR1tsoOpI8VCoLK3Lb
 gc0Cop/TxTHFiXfT7W/NocBWaQEgDIJcnMOU6ivxYGtDTKryUdDyZYRFqwwpbztC4DzE895aF3Z
 J+Gf9YPeYOOwZomnUj+p0UFqa6K71kK98CCer6wAHwKo8MHxmAMSS1ZfKHk2Ze8WQnQ==
X-Google-Smtp-Source: AGHT+IFjVJo679Q0mMrbPwX/7nA4iRE8O67sN1Bgj1XsaQH+i3JJN/ehRKg8h87ZTjYyV5ssQwhtPQ==
X-Received: by 2002:a05:6402:5cb:b0:634:ce70:7c5 with SMTP id
 4fb4d7f45d1cf-639d5c440abmr18248832a12.17.1760366107870; 
 Mon, 13 Oct 2025 07:35:07 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:151b:dc00:15d1:ebc5:76e6:730f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a5c321453sm8942037a12.39.2025.10.13.07.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 07:35:07 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/15] dma-buf: detach fence ops on signal
Date: Mon, 13 Oct 2025 15:48:31 +0200
Message-ID: <20251013143502.1655-5-christian.koenig@amd.com>
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

When neither a release nor a wait operation is specified it is possible
to let the dma_fence live on independent of the module who issued it.

This makes it possible to unload drivers and only wait for all their
fences to signal.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-fence.c | 16 ++++++++++++----
 include/linux/dma-fence.h   |  4 ++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 982f2b2a62c0..39f73edf3a33 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -374,6 +374,14 @@ int dma_fence_signal_timestamp_locked(struct dma_fence *fence,
 				      &fence->flags)))
 		return -EINVAL;
 
+	/*
+	 * When neither a release nor a wait operation is specified set the ops
+	 * pointer to NULL to allow the fence structure to become independent
+	 * who originally issued it.
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
index 38421a0c7c5b..e1ba1d53de88 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -425,7 +425,7 @@ dma_fence_is_signaled_locked(struct dma_fence *fence)
 
 	rcu_read_lock();
 	ops = rcu_dereference(fence->ops);
-	if (ops->signaled && ops->signaled(fence)) {
+	if (ops && ops->signaled && ops->signaled(fence)) {
 		rcu_read_unlock();
 		dma_fence_signal_locked(fence);
 		return true;
@@ -461,7 +461,7 @@ dma_fence_is_signaled(struct dma_fence *fence)
 
 	rcu_read_lock();
 	ops = rcu_dereference(fence->ops);
-	if (ops->signaled && ops->signaled(fence)) {
+	if (ops && ops->signaled && ops->signaled(fence)) {
 		rcu_read_unlock();
 		dma_fence_signal(fence);
 		return true;
-- 
2.43.0

