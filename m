Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FFBCCFA03
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 13:45:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E804610EB8F;
	Fri, 31 Oct 2025 13:45:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RE6CGzTd";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCF3610EB5D
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 13:44:56 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-475db4ad7e4so8930865e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 06:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761918295; x=1762523095; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jmLBsYIn6oMty4dRfFfTl1HxF7zM4zI5t3+Hyyih94s=;
 b=RE6CGzTdYT7NcmuAnSJ/oJVq7zThGYxdl7rVQBBR0EPMZ3Oz5IDy2hp/rqho2rqy76
 lgG4L5Y9MSRMJLz3RkHKIue9UC0E7BA+PwVnPqen9UGkHiupMUnm5vJhXGIFGEK+Vyt6
 wM1EgzjJJtDTApnznI0iqlpiqTNveTrJL3iyE5KXw3Re2T/7sqRvZHVBFWwkl/h3xEIc
 diMOOzRRnLA7CFosTcRUnVkMdINjmgmHAuoCxcEcX+y1eSvAqqucVPyMCuvvgVUUE8Aq
 ObmItVULEyHwo17yy4rF8raNxCwPIyhKQN6yj14t2QMUlP0lvaJkOK2sZd08zz8Guo5S
 G3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761918295; x=1762523095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jmLBsYIn6oMty4dRfFfTl1HxF7zM4zI5t3+Hyyih94s=;
 b=Mh0xm83OIk60JT2I5z/YYYwnU/gUgj3bHMHuoqTKKm+tWO1upkubmGSe3YfXQHrS4m
 Ufa20NWidZTWFv5cjDz+iJYAiBBa+g99dln2H9svI20o0xIbaHurZmdp3GvdOaAFYeG1
 +5ergv5tBCz2Zvl4cz/sKz+UgoBQtzJ4UhVv9Jq5Cq2yY45ISV/UqjahdCLLFwZmr1XP
 wq0HHAMakW9mlQAxYwlyAhJyT9VKxeIXvbflCzdCRIZwllo31p29CihZRKCg0q05fzZb
 wr8Lj2KM7JUc3CX9X6cLwQrScPJzczBxoQ/7DCDW2bcvn9f97zdm53b6ytgb7k4GOabv
 a+gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR10pfjxviCiNHzc+qpvRBlOXgwa4rRRisR0AXrvCWFwOBIMRYOP7jQb+gGc249G76vObT+x95@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyfePc8WpMdgYjQA9FAwduZt7M0uR+4cMDTzekr5LdI6pykTnOm
 LW2iWrCz4i5Hx1KYt81hs/obI8DFV5ex7sN92lKOf+DDXREdMfeYvH+D
X-Gm-Gg: ASbGncv8jT0hvlspIzcSBj98FOEIpOP+ltpjuyEmHYHIbWhxv8RsZsHD9Ce2G/TZH4f
 jWHG994ecpxcFJxRBXZdyrlnpMCnA0C79fDn7ZxuGIlWcXKg85eMs9m0KcQWGAE+r1ume2FNNi/
 gmZwFpUxYFPnIfe8SJYltu3Hz1J2x5fKmDYbmYsJXNYMgjYd3T+jxjrpjFWnIAOCau8K22cyRgx
 rfljAe1G8XJ4uiFxeFAOol2NpX39i2Bqx6SkjeQT7355FooqJ2ykEWyVnt6LkT2dD+JQv+N29gX
 7M/QkAUr2nJmMmjCpgnD8F87sSLWSEMiLioQNhW5+fuFGkpWmwSNizMk5jeuyHVHKEJA8ny9W/5
 pb1fLIDUyMt3M6LgIyrPF8nXnSz7LO3xEUbksb7gYcOH0QXPJ6hG17ul9CECiZ1k8J72pTBSURB
 VEYFKTrPqEaGdZ2oeAo629dgz7
X-Google-Smtp-Source: AGHT+IG2g4OH+iIhkbUnEaINLExZ1Sz974rltnwS7mjOF8eDfsp2QsHvkxjjI266V4topcp6ssFQCw==
X-Received: by 2002:a05:600c:528d:b0:477:ad4:4920 with SMTP id
 5b1f17b1804b1-47730802698mr27513045e9.10.1761918295114; 
 Fri, 31 Oct 2025 06:44:55 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1599:7d00:73cb:d446:bf90:f1c0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47732fe119bsm34502635e9.10.2025.10.31.06.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 06:44:53 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, airlied@gmail.com, felix.kuehling@amd.com,
 matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/20] dma-buf: detach fence ops on signal
Date: Fri, 31 Oct 2025 14:16:38 +0100
Message-ID: <20251031134442.113648-5-christian.koenig@amd.com>
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
index ed82e8361096..cd222984e2e1 100644
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

