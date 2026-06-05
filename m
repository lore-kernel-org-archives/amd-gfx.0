Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E69CD6E5D
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 09:13:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B2C911A616;
	Fri,  5 Jun 2026 09:13:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5a0UWDAq";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EA0511A616
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 09:13:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5t2ouZsGZbT4kc6ZcdCpgp6pLLViKzEKLy2csCIiOi4H1HlIyk88U67ke7f/eS9rRgwUzTGpCgyTDv/jtJsDPRgCy7mKb5RmqQPdJBudsFIwZ+10iNRXZJuBz9EHqKqpdbngQ4JsvNSrxEh5GY5kFC4V69/sWlgq5qx6+X9fmkD13BpaFAKgI89n0JGqVYSBQwFMh/ehFtyWa8ggaxcqlPs0wxzrMUL9GKqVLy7dkJyhZXahYNO6MvK82sfkGMuTxZX0nfwJsrNne35xM6S6GtNLSChK35gQtLhRgALkPY1uY7rJROIGdF7dsTt9zCj8Y++MUCP9fgPEl9c9aE48A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlvRrSrb5OvN2C7YF7+jcGLQh/f/ij7ycA+96otQ7Oc=;
 b=RfH88M/tvRzEqJDa/aI4EHUeXWMxAQ7Zk98mWSK4BoC0Hfq/7bHi0pl+AXkCgAFLeldxxkrwYLeBvbuwm6w5wtyPxPrVqxbzyxhQ2ZZdjsxVDjC2pPKBOaGFzy+Mb9adO3NmbKKRCnN2nlfQaDuBgz5oAlkPJwwkA9sdO5YXWIVwMJtEg7py+ng3cz3sZXEgsXsQ0IVpe8Bk1pq6KKYmLlxlGg6G1EehuXNabFV6MoJVY7mUL/Ekk4vfKCyzfwnoNeaq1JYEF+Ea9S3kxaFkqSNgI7o3Y3S8UanaHEazEfLwsrZRopsJE80kHKQ805+uTTovRTO9pzVTPBqVOW5mjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlvRrSrb5OvN2C7YF7+jcGLQh/f/ij7ycA+96otQ7Oc=;
 b=5a0UWDAqBj4tNiN0zgKKrFOWqUgv4v2FOF7Rbrm8Ki3REaHx/OzxUbsZ6dl4rztbbfKfzxDraXY7mjO9dOaHKWJGC7SdEuUOxTE5zlpypYHJIxfAhyaxFGrl49MQQKacWx8x0TjCJF5U+UJk5OK0dU6BcB0NsvDC30W7d0WmyKY=
Received: from CH2PR19CA0005.namprd19.prod.outlook.com (2603:10b6:610:4d::15)
 by IA0PPFD7DCFAC03.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 09:13:35 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::4f) by CH2PR19CA0005.outlook.office365.com
 (2603:10b6:610:4d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 09:13:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 09:13:34 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 04:13:33 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <vitaly.prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: allocate lockdep mutex on the heap to fix stack
 overflow
Date: Fri, 5 Jun 2026 17:13:22 +0800
Message-ID: <20260605091322.144703-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|IA0PPFD7DCFAC03:EE_
X-MS-Office365-Filtering-Correlation-Id: dadcb2da-f4bd-4af6-2ccb-08dec2e2b892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: fEQzMmGgi6R0N6Y5j93vK/VsTpYOC+WyNcUMHPW49l1ef/OGnm+y2thBDjmTPyPtKjG5QmAZafLb/HREOo4CPwXOFYekLPSlLYMEchmyN5rfYKajAeUtZyIB6zi9Ak1JGc/5bgABBJ9ZlrpjQWKwbhiVrOVCJmQsqMWufylmYoKE+FmciWT3Uyr0cj09mCVqI1volX5DEiVGV+HeWeCg63ZpORpkURgEeXXmXvwxnA2iP4w5PuRJMdNuyjVL8D2UlrEiaMjkiZafx7Jm0S2Zu8Q3i81MDpjMzqiim+SwG1ikbgfUy9zgwk7HRA59Now7z5piHL4FxsAhwf1k1I3bPBQHox64DlDS8Rt46ibV8N6G+AZ07vLSxhMaJV8VwRVFjkziep5Z9AmmqHnJthKUvGaT35XQZYkNeVkskeh0i5JGWoZXXF7XJ/+mliIcCTupaJuMWtEYNrCF/q/Pq5HvgOUlxGyrHfUj85z+Uvyk2u77TFC8chPU+iDje2FPP5EsPMVo6CrGb3l7Cpc2uOsbumkMeooQvKP5IN+ogMQGJfBfwjUveqlrvYjuj04AIC7y+ayLmbrCKng6Z09QTP5dXBxlG55SruwfcZh+tbr/lOkC6QUrA9N0hR3RIwQvpKQhlnde/gNd5YLqMnHb3TDKntb4KQO9r0Xe8XOI5J70TxD8L5d5T2liAxyvgt2tx2ck+LP9PXiQq+SDaNKuiL7UeKeC0Jmn51R5T3hPx8wZdmM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7gt/oCGMBEYNErfni5DB+TMfcKpag3X0WZ72L7cQS22apdCUsrKWfHKEggXhPK9HVYcSWFV6oWb2XVvNl8qMo9XdQ7U0d+d5ICd1H4k4LyYN4QySE4nWQJjXgk5k9dnxx6wbafOoa++XWUh2LnzD2rnbEceGX/p/+H54fQsfNRyiGgPqFs7w/BYHYFiAIDzh7QADThDSn0TWZwCjRwJoHHFPknxt2HiT9gdm6eZyyjl3xUOgf3fLWM7gEcABGsHtw7TQTFg5sZdsMlfkm8Ep/1BzdSm1qzdHuqyObk4/QTLUkAMBYtv4ojr1BsdGPlXlu+IDynPk07SjUtGiTNMQryR0LNhNmMi1RDWJeJggPzJpSRQYJVx6c/ar1vN+9Ki3rQ8RKkfJ/f97Rsz+a9LAjqh6G/6u38NNwZxHlgB0x5fXmaRB+FBd9qkYOGuE9wXw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 09:13:34.7373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dadcb2da-f4bd-4af6-2ccb-08dec2e2b892
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD7DCFAC03
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

Replace the stack-allocated amdgpu_lockdep mutex with a heap allocation
via kmalloc to fix a stack overflow caused by the large struct size.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c | 93 ++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h | 12 +++
 2 files changed, 55 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
index d5d71fd7c70d..c13bfaa3dfa7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
@@ -13,6 +13,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_reset.h"
+#include "amdgpu_lockdep.h"
 
 #ifdef CONFIG_LOCKDEP
 
@@ -84,72 +85,65 @@ void amdgpu_lockdep_set_class(struct amdgpu_device *adev)
 int amdgpu_lockdep_init(void)
 {
 	struct amdgpu_reset_domain *reset_domain = NULL;
-	struct amdgpu_reset_control reset_ctl;
-	struct mutex userq_sch_mutex;
-	struct mutex userq_mutex;
-	struct mutex notifier_lock;
-	struct mutex vram_lock;
-	struct mutex srbm_mutex;
-	struct mutex grbm_idx_mutex;
-	spinlock_t mmio_idx_lock;
+	struct amdgpu_lockdep_dummy_locks *locks;
 	unsigned long flags;
 
+	locks = kzalloc(sizeof(*locks), GFP_KERNEL);
+	if (!locks)
+		return -ENOMEM;
+
 	/*
 	 * Initialize dummy reset domain
 	 */
 	reset_domain = amdgpu_reset_create_reset_domain(SINGLE_DEVICE,
 							"lockdep_test");
-	if (!reset_domain)
+	if (!reset_domain) {
+		kfree(locks);
 		return -ENOMEM;
-
+	}
 	/* Initialize dummy locks */
-	mutex_init(&userq_sch_mutex);
-	mutex_init(&userq_mutex);
-	mutex_init(&notifier_lock);
-	mutex_init(&vram_lock);
-	mutex_init(&reset_ctl.reset_lock);
-	mutex_init(&srbm_mutex);
-	mutex_init(&grbm_idx_mutex);
-	spin_lock_init(&mmio_idx_lock);
+	mutex_init(&locks->userq_sch_mutex);
+	mutex_init(&locks->userq_mutex);
+	mutex_init(&locks->notifier_lock);
+	mutex_init(&locks->vram_lock);
+	mutex_init(&locks->reset_lock);
+	mutex_init(&locks->srbm_mutex);
+	mutex_init(&locks->grbm_idx_mutex);
+	spin_lock_init(&locks->mmio_idx_lock);
 
 	/*
 	 * Associate dummy locks with the same class keys used for real
 	 * driver locks. This ensures lockdep connects the ordering learned
 	 * here with the actual locks used at runtime.
 	 */
-	lockdep_set_class(&userq_sch_mutex, &amdgpu_userq_sch_mutex_key);
-	lockdep_set_class(&userq_mutex, &amdgpu_userq_mutex_key);
-	lockdep_set_class(&notifier_lock, &amdgpu_notifier_lock_key);
-	lockdep_set_class(&vram_lock, &amdgpu_vram_lock_key);
+	lockdep_set_class(&locks->userq_sch_mutex, &amdgpu_userq_sch_mutex_key);
+	lockdep_set_class(&locks->userq_mutex, &amdgpu_userq_mutex_key);
+	lockdep_set_class(&locks->notifier_lock, &amdgpu_notifier_lock_key);
+	lockdep_set_class(&locks->vram_lock, &amdgpu_vram_lock_key);
 	lockdep_set_class(&reset_domain->sem, &amdgpu_reset_sem_key);
-	lockdep_set_class(&reset_ctl.reset_lock, &amdgpu_reset_lock_key);
-	lockdep_set_class(&srbm_mutex, &amdgpu_srbm_lock_key);
-	lockdep_set_class(&grbm_idx_mutex, &amdgpu_grbm_lock_key);
-	lockdep_set_class(&mmio_idx_lock, &amdgpu_mmio_lock_key);
-
+	lockdep_set_class(&locks->reset_lock, &amdgpu_reset_lock_key);
+	lockdep_set_class(&locks->srbm_mutex, &amdgpu_srbm_lock_key);
+	lockdep_set_class(&locks->grbm_idx_mutex, &amdgpu_grbm_lock_key);
+	lockdep_set_class(&locks->mmio_idx_lock, &amdgpu_mmio_lock_key);
 	/*
 	 * Take locks in the correct order to train lockdep.
 	 * This establishes the dependency chain.
 	 */
 
 	/* Level 1: Global userq scheduler mutex (outermost) */
-	mutex_lock(&userq_sch_mutex);
+	mutex_lock(&locks->userq_sch_mutex);
 
 	/* Level 2: Per-context userq mutex */
-	mutex_lock(&userq_mutex);
-
+	mutex_lock(&locks->userq_mutex);
 	/* Level 3: MMU notifier lock */
-	mutex_lock(&notifier_lock);
-
+	mutex_lock(&locks->notifier_lock);
 	/* Level 4: VRAM allocator lock */
-	mutex_lock(&vram_lock);
-
+	mutex_lock(&locks->vram_lock);
 	/* Level 5: Reset domain semaphore */
 	down_read(&reset_domain->sem);
 
 	/* Level 6: Reset control lock */
-	mutex_lock(&reset_ctl.reset_lock);
-
+	mutex_lock(&locks->reset_lock);
 	/*
 	 * Mark potential memory reclaim boundary.
 	 * GPU operations might trigger memory allocation/reclaim.
@@ -157,36 +151,35 @@ int amdgpu_lockdep_init(void)
 	fs_reclaim_acquire(GFP_KERNEL);
 
 	/* Level 7: SRBM register access */
-	mutex_lock(&srbm_mutex);
-
+	mutex_lock(&locks->srbm_mutex);
 	/* Level 8: GRBM index access */
-	mutex_lock(&grbm_idx_mutex);
+	mutex_lock(&locks->grbm_idx_mutex);
 
 	/* Level 9: MMIO index access (innermost lock, spinlock) */
-	spin_lock_irqsave(&mmio_idx_lock, flags);
-
+	spin_lock_irqsave(&locks->mmio_idx_lock, flags);
 	/*
 	 * All locks acquired in order.
 	 * Lockdep has now learned the valid dependency chain.
 	 */
 
 	/* Release in reverse order */
-	spin_unlock_irqrestore(&mmio_idx_lock, flags);
-	mutex_unlock(&grbm_idx_mutex);
-	mutex_unlock(&srbm_mutex);
-
+	spin_unlock_irqrestore(&locks->mmio_idx_lock, flags);
+	mutex_unlock(&locks->grbm_idx_mutex);
+	mutex_unlock(&locks->srbm_mutex);
 	fs_reclaim_release(GFP_KERNEL);
 
-	mutex_unlock(&reset_ctl.reset_lock);
+	mutex_unlock(&locks->reset_lock);
 	up_read(&reset_domain->sem);
-	mutex_unlock(&vram_lock);
-	mutex_unlock(&notifier_lock);
-	mutex_unlock(&userq_mutex);
-	mutex_unlock(&userq_sch_mutex);
+
+	mutex_unlock(&locks->vram_lock);
+	mutex_unlock(&locks->notifier_lock);
+	mutex_unlock(&locks->userq_mutex);
+	mutex_unlock(&locks->userq_sch_mutex);
 
 	/* Cleanup */
 	amdgpu_reset_put_reset_domain(reset_domain);
 
+	kfree(locks);
 	pr_info("AMDGPU: Lockdep annotations initialized (9 lock levels)\n");
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h
index 04adb58665bf..8bff09bd2dbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h
@@ -9,9 +9,21 @@
 #define __AMDGPU_LOCKDEP_H__
 
 #include <linux/lockdep.h>
+#include <linux/mutex.h>
 
 struct amdgpu_device;
 
+struct amdgpu_lockdep_dummy_locks {
+	struct mutex reset_lock;
+	struct mutex userq_sch_mutex;
+	struct mutex userq_mutex;
+	struct mutex notifier_lock;
+	struct mutex vram_lock;
+	struct mutex srbm_mutex;
+	struct mutex grbm_idx_mutex;
+	spinlock_t mmio_idx_lock;
+};
+
 #ifdef CONFIG_LOCKDEP
 
 /**
-- 
2.34.1

