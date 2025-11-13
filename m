Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F34CD8C85
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 14:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B297A10E857;
	Thu, 13 Nov 2025 14:53:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I8cQLBKC";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07D2210E849
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 14:53:49 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b72dc0c15abso154653066b.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 06:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763045627; x=1763650427; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1vtve7xgnWRe/vOdHtoREn4DAu8sZ2mMOpzTrHCPaxI=;
 b=I8cQLBKCLHafg6SC9Rb7Bf9EoQd+dFyYoWKmrEWL+B7710mcG8zKURcg5SIprrg4g3
 qmcL1/CKJCOY8R9bwpil6tnscvTa8wiTqDlwc/JwL51R8VJd1vfFnZsSOkjNbJM/cdLZ
 xG8nU1glu5Cg4lp3rmfrewKW2OKxWiNWEMMpI31R8ywdA2d+7NhCxiWUqkQHIkwSHRFI
 1tD37Xeara3TW95VW56shMzoa9x4NXOqnw12Gia3Wu9uO92zFfO3iMSp/t8BvGBenQOz
 eN+Ym1lYwV/ydJ29q8Dum/8PTD12Ztsioyssh8GSNn57vjiu701Z0S0s/gdeDA3LyFZU
 NGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763045627; x=1763650427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1vtve7xgnWRe/vOdHtoREn4DAu8sZ2mMOpzTrHCPaxI=;
 b=rMAJBrK8UqdrAozcyjSIyB7Jz+ui3T7idDbVEFBXRQb8iF94qfkhVX2a2ZymR2McCD
 4pqkmnlnACoQ1G++lhPfFIz6XEU912DuN0zLK9y9L3hqm9eN35DJnJ8wMXBBijGF6j6L
 LVySQTdhdMowLPbuQHJmXFST41x1EQGS3BQu90x/nsUvmv9axWCL/SQCSqM1RbZwLxvg
 y7NMWpPgKSkpEe11tn1W1SGDWWqbm1KlQJVOuR73YvhjSQ/lWBDdmLXG2EpX7E/cQ9jx
 24hzaIN785pKU3XXnmRN8ehOSBp+fnchRhJS+5PF5wtF2VeLtyz5udpuPHwyzsyefFcz
 2xLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeeAjj4RXS9GAiswJFy4tnqon0PrkeMoAeUWD9ldhFh/lvCDjPI9tcTUXHNIcAjrJ8Hk+bmyAN@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwzBlI5/GVKoFzddTeuV69cOpU8NPGmnH3JdlEI19SYLmg+VneO
 cS0WeJIayPtWeel9bwtU0ztRs0Fv2V4hT7l/LBR9YMet3ZIlxkF4+grB
X-Gm-Gg: ASbGncsroKTPH44af7rdZdJMtbDzbuyX6UntOYWFJM0bWEsA1EEx47G5a6P/IL03sYO
 InDhDBxTXf9sJ35TXSnRgvJiJilHUwGVEGb7019/HPXgRv0QrqWhjskg2EiT7eaPjQwyZaej9G/
 huk8TZ7bFf9P3Of/LgK7MTGPPzwATRxPbm/oJTa52exDlUY0aR96KRNrMR5pyQ1+B0e8Tr8CyiR
 33GN0qx62Wiudyx12/KdFg2c0Qgij2DlqUOPVVe59mirC89TyS2DSPm17ddoxX4sMUU391J23D2
 t/jMHZFBymb/ijidMdSx7P5ucGxrpXbRkJ4hqBfIyjRK1TonQpZczhC7rbHatDCxBY8OSQ+6FDV
 egML+gFhtHFM8us0Mtn/BDf1XG8sqxbUusetovjgOj54h/JjuzmlYu5EGZ9OdEIIHKBa5R8E0ep
 y+htBytBbep60=
X-Google-Smtp-Source: AGHT+IGhN0BwuRz6xHS4a4rKQwJnNXuC7Dv18mVfD20rjR0xsbY2hGCz0+6Jk5TkTMzE1pREPfPY0Q==
X-Received: by 2002:a17:907:3e23:b0:b71:df18:9fd6 with SMTP id
 a640c23a62f3a-b7331aaac19mr727099166b.50.1763045627465; 
 Thu, 13 Nov 2025 06:53:47 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15aa:c600:cef:d94:436c:abc5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b73513b400fsm173747166b.1.2025.11.13.06.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 06:53:47 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, matthew.brost@intel.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, sumit.semwal@linaro.org
Subject: [PATCH 16/18] drm/xe: Drop HW fence slab
Date: Thu, 13 Nov 2025 15:51:53 +0100
Message-ID: <20251113145332.16805-17-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113145332.16805-1-christian.koenig@amd.com>
References: <20251113145332.16805-1-christian.koenig@amd.com>
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

