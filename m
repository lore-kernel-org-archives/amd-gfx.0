Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12916CCF9FF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 13:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88A5D10EBAF;
	Fri, 31 Oct 2025 13:45:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SopuIB/Y";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF58B10EB85
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 13:45:19 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-475dc6029b6so23046055e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 06:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761918318; x=1762523118; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1vtve7xgnWRe/vOdHtoREn4DAu8sZ2mMOpzTrHCPaxI=;
 b=SopuIB/Y4/qJfkG9gcnGFrPiBORGBOs17a5nWgBwvI1rAXpzdebv8NwWkwIh77iPRR
 nW+wwYLZk/qBvItau97ISUol/UYcHFJ9x+UG0TicYz8FqJ77oi7lQWe4jE7UvhUwv+XC
 WFoS12ZI0xdBXXzgZ1EE9ZlNz1b5gRKi5kdnGDseAijc2ip/gIaDcRMAUlMgBAQVhsb5
 obsZQaqn+Wwe288Sq1pst8KYr5sG/Z24/SlJaVd6itxtiJEID4zO3/dmjzhDegpDCmDw
 Ev6RrkBooiU6MkaoaaeNUu3fwtfsTEnazgqVx+XU3SfwyFKCLl2ubWMJA3CcIrqbJxLQ
 gYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761918318; x=1762523118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1vtve7xgnWRe/vOdHtoREn4DAu8sZ2mMOpzTrHCPaxI=;
 b=sOG04nqDTuzMT+8MpXGOUkqfcCeDDkspfu7a7xYVZqqOqMdB6MPoGS/k1eZxoi6pjd
 Nu/grRF8C/ihLp1gDSWaedaYoK/5Cy+JICZ1v9jE7IiC+/csZ/vxc6NobwjXwzRGBP/N
 6UygitCIwN0MYpcIE9c7V9bs3gH2cFOKVGYeISqJ/HuJDqaysKGgnP2G2UIwEtC2xXxi
 2iID1dQ+Nn51U4pKw7wqSuJl9OyHYA+O8JWCDKaTpKARpW9yeHXwonVfgXWkMQO/V//i
 +bKISsjDE1XoUYg+wlvFPDTSOcCuBLrZ8O5sLt+lcEInm4UfTsFv1BmPRYn+Nc0ph7+m
 MytA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+787u0azJEwUTUrKUui7c/QPM1eypEbpekgkL+iJqFTm6btDvN1i32a2x+1ZmpgLj6yFZXHiV@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwSSHQMUT0Ti985gOBfycQXtcJK/5qJGUESS0seE8Z64O2HFvyp
 hMLW7e/p4b2OyrA5TomHhCEcRnz0cyD1o0SsxN6ZiLeVSrvVXsYJcH2p
X-Gm-Gg: ASbGnctZ9K7R2lhcue/TeJaMncF4hvsg0alozfyMCr6E9mfy2GfAQtXAa6PB4gEZ2cw
 Tyl9pOYPwnmUpjlKUvHN15Ay1xuoOOd4dyTZoUZCkBgjDuZySJzkqw+P87J3/G1EfHMsHjumGR6
 uTHqXM01njUdXwytBwLlBf+bdP5NFQToEGrMW5jOFBfC/FjPSGIu1nrzpG6Nu4uelxuCK46zuP1
 cE86jO/Sre7LT6TsxHwx2Rzrcrmx98lwJcPGiqKCtzCC/b42cxkLND8z5BqYzyuLfrutXr7BYc5
 WfAUI+A/8KCcghXNLnH4FX0C3jEhwcz+MzrrGtx/8ER0g/iffMmq+Gt83VKuefJt9hgJeYjoodq
 98XZwHnuPjYRm2I3vb9coRfdhoymHLw1s4+OHOdfhLH0P6RN6mTuHS/q9DFfD1jfQ8hycPvTQnC
 4DQ7qYjUotEMW1zCp1aycwM4K4
X-Google-Smtp-Source: AGHT+IGIzclpM7lnvjdWsgUHdOVq6+rOhqTzcODwfT9Xra3mnD/4VUOCxNJ4wncXtuaa4hG4XwxhCQ==
X-Received: by 2002:a05:600c:c178:b0:46d:9d28:fb5e with SMTP id
 5b1f17b1804b1-4773a7384c3mr11798345e9.5.1761918318217; 
 Fri, 31 Oct 2025 06:45:18 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1599:7d00:73cb:d446:bf90:f1c0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47732fe119bsm34502635e9.10.2025.10.31.06.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 06:45:17 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, airlied@gmail.com, felix.kuehling@amd.com,
 matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 18/20] drm/xe: Drop HW fence slab
Date: Fri, 31 Oct 2025 14:16:52 +0100
Message-ID: <20251031134442.113648-19-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031134442.113648-1-christian.koenig@amd.com>
References: <20251031134442.113648-1-christian.koenig@amd.com>
MIME-Version: 1.0
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

From: Matthew Brost <matthew.brost@intel.com>

Helps with disconnecting fences from Xe module.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_hw_fence.c | 25 ++-----------------------
 drivers/gpu/drm/xe/xe_hw_fence.h |  3 ---
 drivers/gpu/drm/xe/xe_module.c   |  5 -----
 3 files changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_hw_fence.c b/drivers/gpu/drm/xe/xe_hw_fence.c
index 3456bec93c70..5edcf057aceb 100644
--- a/drivers/gpu/drm/xe/xe_hw_fence.c
+++ b/drivers/gpu/drm/xe/xe_hw_fence.c
@@ -6,7 +6,6 @@
 #include "xe_hw_fence.h"
 
 #include <linux/device.h>
-#include <linux/slab.h>
 
 #include "xe_bo.h"
 #include "xe_device.h"
@@ -16,28 +15,9 @@
 #include "xe_map.h"
 #include "xe_trace.h"
 
-static struct kmem_cache *xe_hw_fence_slab;
-
-int __init xe_hw_fence_module_init(void)
-{
-	xe_hw_fence_slab = kmem_cache_create("xe_hw_fence",
-					     sizeof(struct xe_hw_fence), 0,
-					     SLAB_HWCACHE_ALIGN, NULL);
-	if (!xe_hw_fence_slab)
-		return -ENOMEM;
-
-	return 0;
-}
-
-void xe_hw_fence_module_exit(void)
-{
-	rcu_barrier();
-	kmem_cache_destroy(xe_hw_fence_slab);
-}
-
 static struct xe_hw_fence *fence_alloc(void)
 {
-	return kmem_cache_zalloc(xe_hw_fence_slab, GFP_KERNEL);
+	return kzalloc(sizeof(struct xe_hw_fence), GFP_KERNEL);
 }
 
 static void fence_free(struct rcu_head *rcu)
@@ -45,8 +25,7 @@ static void fence_free(struct rcu_head *rcu)
 	struct xe_hw_fence *fence =
 		container_of(rcu, struct xe_hw_fence, dma.rcu);
 
-	if (!WARN_ON_ONCE(!fence))
-		kmem_cache_free(xe_hw_fence_slab, fence);
+	kfree(fence);
 }
 
 static void hw_fence_irq_run_cb(struct irq_work *work)
diff --git a/drivers/gpu/drm/xe/xe_hw_fence.h b/drivers/gpu/drm/xe/xe_hw_fence.h
index f13a1c4982c7..96f34332fd8d 100644
--- a/drivers/gpu/drm/xe/xe_hw_fence.h
+++ b/drivers/gpu/drm/xe/xe_hw_fence.h
@@ -11,9 +11,6 @@
 /* Cause an early wrap to catch wrapping errors */
 #define XE_FENCE_INITIAL_SEQNO (-127)
 
-int xe_hw_fence_module_init(void);
-void xe_hw_fence_module_exit(void);
-
 void xe_hw_fence_irq_init(struct xe_hw_fence_irq *irq);
 void xe_hw_fence_irq_finish(struct xe_hw_fence_irq *irq);
 void xe_hw_fence_irq_run(struct xe_hw_fence_irq *irq);
diff --git a/drivers/gpu/drm/xe/xe_module.c b/drivers/gpu/drm/xe/xe_module.c
index d08338fc3bc1..32517bcd533c 100644
--- a/drivers/gpu/drm/xe/xe_module.c
+++ b/drivers/gpu/drm/xe/xe_module.c
@@ -12,7 +12,6 @@
 
 #include "xe_drv.h"
 #include "xe_configfs.h"
-#include "xe_hw_fence.h"
 #include "xe_pci.h"
 #include "xe_pm.h"
 #include "xe_observation.h"
@@ -114,10 +113,6 @@ static const struct init_funcs init_funcs[] = {
 		.init = xe_configfs_init,
 		.exit = xe_configfs_exit,
 	},
-	{
-		.init = xe_hw_fence_module_init,
-		.exit = xe_hw_fence_module_exit,
-	},
 	{
 		.init = xe_sched_job_module_init,
 		.exit = xe_sched_job_module_exit,
-- 
2.43.0

