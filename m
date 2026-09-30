Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F391CA5FAC
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 13:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E874610F3D7;
	Wed, 30 Sep 2026 13:42:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vfVmLSfk";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012033.outbound.protection.outlook.com
 [40.107.200.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8304810F3D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 13:42:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fC7vQUZu0a9IXmGNhs7gcGl5qZS7BsW7h6mTg26gAXzbA+JgVz5jkgDt/we/dWLmyBpmLYvWyPYL8xydJY6Dy5zN3qR7ct99ueZySewWHpnCZXRKvG3vqP3/kJouwHT/ycN9zSiCTtRlGNeqTEN190tOaq3wCrjMn27/RbdvfR4P9zxqah7nETuxwmrhg3SNotzfP9lIe7pGoVOB+eRjDil3TOOG5YofarA6v3LfOSSrHDjYYTCciVWWw1XX/iQSH0hOpGTn+TAo58MNDaMjIOFQPJCnbwtB3EQl3DoaRJARBk8LdZYxsbzDmbzQsu35EhaUZFh/E+h/e5BvCLxh+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPQEC+2AesXh2rqlHAmfOlmPqMkKyudeeeQZA18g2RQ=;
 b=Lo0LCx+zUhvqh4MBY6P/xcfHiUvRkHnNmrE5GTOjVgUeMt1Oz2y2KQ0LfSS1pVuHpzUNbB+9jee1p7Y+52cyu7+N4oSXQLIzaIOCpRSAB+gq2Oo6WswE+kK/3siRBRi0yU094zF6k5wDCtsJAjVXcWi78cGvKG8XV1oIiL6ZXyyrNakjn/xWcZSve8beJbwuUiowxLJhIQJaq5PukGSzN8b1BwUEqnLfpQFvxktgx09et+0vUv6/QZTlqWIE3c1aSHqTYgHIeyWGVd6fauftleK/axbJN76UELADz4GELzFBIU3V1xhTHvUjMvSAMX8oP1onTBNr4MJ2NSCq/AZDaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPQEC+2AesXh2rqlHAmfOlmPqMkKyudeeeQZA18g2RQ=;
 b=vfVmLSfk/gYhwd+9ywUXYLZCwsdyxaI4NyZ0kc35XUvIZz9wSRzT7QDT5ayVzVzAI8Uze6jIbghtT7muZMCrwx9LagEczXdwR/BX4v/xviFpFJR1nGQsxBPkqbw58FhaCHj1hXIWlEs+4bTfvMCkqMG2IqIDb1azCz5Z6xVIPJs=
Received: from PH5P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::9)
 by BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 13:42:31 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:510:34a:cafe::91) by PH5P220CA0012.outlook.office365.com
 (2603:10b6:510:34a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 13:42:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Wed, 30 Sep 2026 13:42:30 +0000
Received: from marui-Super-Server.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 08:42:27 -0500
From: Heng Zhou <Heng.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, <Christian.Koenig@amd.com>, <Emily.Deng@amd.com>,
 <Victor.Zhao@amd.com>, <Felix.Kuehling@amd.com>, <phasta@kernel.org>,
 <Qing.Ma@amd.com>, <HaiJun.Chang@amd.com>, <Heng.Zhou@amd.com>,
 <Jonathan.Kim@amd.com>
Subject: [PATCH] drm/amdkfd: fix lost wakeup in interrupt drain on debugged
 process exit
Date: Wed, 30 Sep 2026 21:42:05 +0800
Message-ID: <20260930134205.469578-1-Heng.Zhou@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|BL1PR12MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: f638b15f-22f3-4bf7-4ec4-08df1ef8ace1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: NfBnEg/E8lD2LAeqoCfkMsdEh0tn8Xaau0CpkbnafRHLjtH7AzgLsD852zk0EygmgqaKjgJZ/Dh8fz7ZEDc2D/5DjlkZGsPX1mQV3NAxnphiVc11AfQfaQDHZwffx29IculHxTIl2inXJuC3rsDMnLYnZ54yzxvWzuunQ2mnJsiGrAgTghdyIEkNtQHq0/rezHxdNddEUYasvLJpLceuyQ7Q3GvGrXKu4fOvZEiOxjEiKAE8LjLvIf6J4LN07DB02TglHuRaL9GCQTihV8WIFCZBVmhrOcl1P/R2vTGD35bQe0cNDaFsMDLwcsXeboiGNV3pIj9of5cp4Q7Bscig/5NUZvfmR52AR+UbYjqxNavj39CKGOlOxII+kT9hFvVUr6J1w3Uh/v6S09OXvI0aHhP1arNEOttjRzYunA/wGrXFrToXvpFmusnD22kfdkA4BKfEZD+2+R38LoQwTrap35O9ZJx8QfXn5C979j2aZ2BZuAaBOpkEfwm+jKvC7KbH1Z7Yhc2VtNUrob1JUpsh/A3oDYZNk2f4V26DKlUOo1dM1QtgUbqHxhrXJ/exi142fWqHl+gxMrjNXVVVBiO1YLhXxRmJlFqrjf0j8GLHC/aPDcsADknXQ2EVTuO49m4FZOAQP3W+Xes4O8y6FojTlyO9F6Wxnlsk1k1TYioZpkKTnsxptsp5PIKd8iSB+s4eyqGLH0I+doZIcjo1UumbOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(10067099003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oSqa48oIRPA/ruRHjjUvJMhMu6Un2Leh7NNnmmjL8XOjIYezq7FoF7cufpLDD8390+XdWe6BObQ85ASlMRHgWnRixpzBslFHJb3SNAuOPrNQgkwkYqGfRGT46Th8lN//BBvqjcxgRCDtjVIX3omZBxZdF0rVIldmjO+tZII1pO3HEcxfT5eXzKKr/+EqWvoXieWTBuQdnmSUB1P/VhWcsCbaCd+Ou9PSH0fmfo0XFnbR0EC8VZpXKTWRYwwZ6WntwgRgSCeY7KqjsSv52b+UOOEq132/BYVrJXjksAIFcznmDhyf+GYCIufoKRlbimNgUW8ImlXB312yivZIeD+sNudkpwCfTaPOX4JInZbBpRSUau4cPCRxWdXBDydu7h8ApiAUe6IIKn8fuuSH43E0pnBzGj6D+dFE6T3+NwBNi2Hv48M6MZUA/ZtK1KBjTv3x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 13:42:30.9804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f638b15f-22f3-4bf7-4ec4-08df1ef8ace1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753
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

When a debugged process exits, kfd_process_notifier_release_internal()
first removes it from kfd_processes_table and then calls
kfd_dbg_trap_disable(), which drains the process interrupts. The drain
sends a fence through the IH and waits, without a timeout, for
kfd_process_close_interrupt_drain() to wake it up. That wakeup looks
the process up by PASID in kfd_processes_table, which no longer holds
it, so the wakeup is lost and the exiting task sleeps forever. The
fatal signal has already been consumed in do_exit(), so the
interruptible wait cannot be broken either.

The wait happens inside the mmu_notifier release callback, i.e. within
the global mmu_notifier SRCU read-side critical section, so every
synchronize_srcu() on it stalls as well. Any other process releasing
its mm then hangs in D state and the system needs a reboot. This is
seen with rocgdb on MI300X.

Fix this by:

- Tracking pending drains in a list keyed by PASID instead of looking
  the process up in kfd_processes_table, so the drain fence always
  finds its waiter.
- Bounding the wait with a timeout, since the fence can be lost when
  the IH ring or the KFD interrupt FIFO overflows, and warning when the
  drain does not complete.
- Deferring the drain of an exiting debugged process from the
  mmu_notifier release path to kfd_process_wq_release(), before the
  PDDs and their PASIDs are released, so that stale interrupts cannot
  hit a process that reuses the PASID.

Signed-off-by: Heng Zhou <Heng.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c   |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 89 +++++++++++++++++-------
 3 files changed, 68 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 0dd1fd448059..2b227d9de492 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -664,7 +664,8 @@ static void kfd_dbg_clean_exception_status(struct kfd_process *target)
 	for (i = 0; i < target->n_pdds; i++) {
 		struct kfd_process_device *pdd = target->pdds[i];
 
-		kfd_process_drain_interrupts(pdd);
+		if (!target->irq_drain_deferred)
+			kfd_process_drain_interrupts(pdd);
 
 		pdd->exception_status = 0;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 2847a5ec5ede..c04c3a03f559 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1030,9 +1030,7 @@ struct kfd_process {
 	uint64_t exception_enable_mask;
 	uint64_t exception_status;
 
-	/* Used to drain stale interrupts */
-	wait_queue_head_t wait_irq_drain;
-	bool irq_drain_is_open;
+	bool irq_drain_deferred;
 
 	/* shared virtual memory registered by this process */
 	struct svm_range_list svms;
@@ -1245,7 +1243,8 @@ bool enqueue_ih_ring_entry(struct kfd_node *kfd, const void *ih_ring_entry);
 bool interrupt_is_wanted(struct kfd_node *dev,
 				const uint32_t *ih_ring_entry,
 				uint32_t *patched_ihre, bool *flag);
-int kfd_process_drain_interrupts(struct kfd_process_device *pdd);
+void kfd_process_drain_interrupts(struct kfd_process_device *pdd);
+void kfd_process_drain_deferred_interrupts(struct kfd_process *p);
 void kfd_process_close_interrupt_drain(unsigned int pasid);
 
 /* amdkfd Apertures */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 226f52626e84..b2365c21db9e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -55,6 +55,22 @@ DEFINE_MUTEX(kfd_processes_mutex);
 
 DEFINE_SRCU(kfd_processes_srcu);
 
+/*
+ * Pending interrupt drains, keyed by PASID. Deliberately not keyed off
+ * kfd_processes_table: a draining process may already have been removed from
+ * it, and the drain fence must still be able to find its waiter.
+ */
+struct kfd_irq_drain_waiter {
+	struct list_head list;
+	u32 pasid;
+	struct completion done;
+};
+
+static DEFINE_SPINLOCK(kfd_irq_drain_lock);
+static LIST_HEAD(kfd_irq_drain_list);
+
+#define KFD_IRQ_DRAIN_TIMEOUT	msecs_to_jiffies(1000)
+
 /* For process termination handling */
 static struct workqueue_struct *kfd_process_wq;
 
@@ -1019,8 +1035,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 		if (ret)
 			pr_warn("Failed to create debugfs entry for the kfd_process, ret = %d\n",
 				ret);
-
-		init_waitqueue_head(&process->wait_irq_drain);
 	}
 out:
 	mutex_unlock(&kfd_processes_mutex);
@@ -1344,6 +1358,8 @@ static void kfd_process_wq_release(struct work_struct *work)
 	kfd_process_free_outstanding_kfd_bos(p);
 	svm_range_list_fini(p);
 
+	kfd_process_drain_deferred_interrupts(p);
+
 	kfd_process_destroy_pdds(p);
 	dma_fence_put(ef);
 
@@ -1420,6 +1436,8 @@ void kfd_process_notifier_release_internal(struct kfd_process *p)
 	 * back on the MES list and, once proc_ctx_bo is freed, MES would fault
 	 * on the freed process context. Retiring the context last avoids this.
 	 */
+	if (p->debug_trap_enabled)
+		p->irq_drain_deferred = true;
 	kfd_dbg_trap_disable(p);
 
 	if (atomic_read(&p->debugged_process_count) > 0) {
@@ -2313,17 +2331,16 @@ int kfd_resume_all_processes(void)
 	return ret;
 }
 
-/* assumes caller holds process lock. */
-int kfd_process_drain_interrupts(struct kfd_process_device *pdd)
+void kfd_process_drain_interrupts(struct kfd_process_device *pdd)
 {
+	struct kfd_irq_drain_waiter waiter;
 	uint32_t irq_drain_fence[8];
+	unsigned long flags;
 	uint8_t node_id = 0;
-	int r = 0;
+	long r;
 
 	if (!KFD_IS_SOC15(pdd->dev))
-		return 0;
-
-	pdd->process->irq_drain_is_open = true;
+		return;
 
 	memset(irq_drain_fence, 0, sizeof(irq_drain_fence));
 	irq_drain_fence[0] = (KFD_IRQ_FENCE_SOURCEID << 8) |
@@ -2341,33 +2358,53 @@ int kfd_process_drain_interrupts(struct kfd_process_device *pdd)
 		irq_drain_fence[3] |= node_id << 16;
 	}
 
+	waiter.pasid = pdd->pasid;
+	init_completion(&waiter.done);
+
+	spin_lock_irqsave(&kfd_irq_drain_lock, flags);
+	list_add(&waiter.list, &kfd_irq_drain_list);
+	spin_unlock_irqrestore(&kfd_irq_drain_lock, flags);
+
 	/* ensure stale irqs scheduled KFD interrupts and send drain fence. */
-	if (amdgpu_amdkfd_send_close_event_drain_irq(pdd->dev->adev,
-						     irq_drain_fence)) {
-		pdd->process->irq_drain_is_open = false;
-		return 0;
+	if (!amdgpu_amdkfd_send_close_event_drain_irq(pdd->dev->adev,
+						      irq_drain_fence)) {
+		r = wait_for_completion_interruptible_timeout(&waiter.done,
+							      KFD_IRQ_DRAIN_TIMEOUT);
+		if (r <= 0)
+			dev_warn_ratelimited(pdd->dev->adev->dev,
+					     "irq drain on pasid 0x%x did not complete (%ld)\n",
+					     waiter.pasid, r);
 	}
 
-	r = wait_event_interruptible(pdd->process->wait_irq_drain,
-				     !READ_ONCE(pdd->process->irq_drain_is_open));
-	if (r)
-		pdd->process->irq_drain_is_open = false;
-
-	return r;
+	spin_lock_irqsave(&kfd_irq_drain_lock, flags);
+	list_del(&waiter.list);
+	spin_unlock_irqrestore(&kfd_irq_drain_lock, flags);
 }
 
-void kfd_process_close_interrupt_drain(unsigned int pasid)
+void kfd_process_drain_deferred_interrupts(struct kfd_process *p)
 {
-	struct kfd_process *p;
-
-	p = kfd_lookup_process_by_pasid(pasid, NULL);
+	int i;
 
-	if (!p)
+	if (!p->irq_drain_deferred)
 		return;
 
-	WRITE_ONCE(p->irq_drain_is_open, false);
-	wake_up_all(&p->wait_irq_drain);
-	kfd_unref_process(p);
+	p->irq_drain_deferred = false;
+
+	for (i = 0; i < p->n_pdds; i++)
+		kfd_process_drain_interrupts(p->pdds[i]);
+}
+
+void kfd_process_close_interrupt_drain(unsigned int pasid)
+{
+	struct kfd_irq_drain_waiter *waiter;
+	unsigned long flags;
+
+	spin_lock_irqsave(&kfd_irq_drain_lock, flags);
+	list_for_each_entry(waiter, &kfd_irq_drain_list, list) {
+		if (waiter->pasid == pasid)
+			complete(&waiter->done);
+	}
+	spin_unlock_irqrestore(&kfd_irq_drain_lock, flags);
 }
 
 struct send_exception_work_handler_workarea {
-- 
2.43.0

