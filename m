Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA052C25B47
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 22:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0710D10EA56;
	Fri, 27 Oct 2023 22:40:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C3F910EA56
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 22:40:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgQng+yJjV97/KZzHclYZt6r8/WruLJdch9YNO3KT6PxujHr6gm9XaIW1wNuINmpSr4GtiqUAYv2jAKTAvE0BVOoT99J89yvw7ww6A4FJM3zXpsKmbknPudshWLVMB654VZAYtRtMACeDcAYS/MvZoYq67RuSCgZhShoIzAJhUvRuUSYwGHr9ZL8jc9RQoaCjDx+8XEwM/5NjV/PiEDfsKzxUy5JBjnL9HbpOOPv40ura7B/JqMqhLNbeGfBROWMbIdmmyzEnhRFKvD/Ae4iOgpcMMNA+cvA5DtTtXa9/X+ZxkpYZY/hs9Y3f5KpoxB1B7QgOQhbj1ak/zFqt4cxaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTSLBhLxMpBtaDwYBeReEqV5iB0pQkQjbyZiYInCc4A=;
 b=ASfF2HC6OclKp/oLl85m688KNbLgJ2OECPkHEb7b7zGwyO0SRqEXALQdfvjyBUKF+v8dX1hGHNlRW6aYESgb2Ruyq2M5Ko4ujDfLQVRs27HrGNz3Naem0EVgMFDylnn1r2DYJMPFkzMe6bylwY19kVtxgoqhIkab0ilTY8q0ywP081ysPUzIe5jruDqegbx43eWQ18LrTfe+3Yn8Zm3bqeBevtuRIugm6/V/aiUSEWLq5PdzSu/MJ/lq965l/JcvmIGA3upQGLDKLrM7DHv0022Ko8yJCSnGyBHh3hv8wGvFIYgpacnQ58irCkH1A7j+lGQG+oMBCktpIXzN3B8FBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTSLBhLxMpBtaDwYBeReEqV5iB0pQkQjbyZiYInCc4A=;
 b=iH0ccydY4DDdeUuSrJ8Iot9lBh/UbhSeUb330UfEIfNwAeIEmTEBkCpc55o46LNB/evjMM36Za4+30jNfeZlRYiFgd88q1x9VC6oJHHRv/ZBNmIfwHt2U4g6cHVWuSBqwgo9NohT8pF6o2H+l5/Ed5wBneBNuHTEctcyjr9NmyY=
Received: from MW4PR04CA0385.namprd04.prod.outlook.com (2603:10b6:303:81::30)
 by SA3PR12MB8763.namprd12.prod.outlook.com (2603:10b6:806:312::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Fri, 27 Oct
 2023 22:40:00 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:81:cafe::9c) by MW4PR04CA0385.outlook.office365.com
 (2603:10b6:303:81::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22 via Frontend
 Transport; Fri, 27 Oct 2023 22:39:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.0 via Frontend Transport; Fri, 27 Oct 2023 22:39:58 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 27 Oct
 2023 17:39:57 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH] drm/amdkfd: Run restore_workers on freezable WQs
Date: Fri, 27 Oct 2023 18:39:11 -0400
Message-ID: <20231027223911.2640763-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|SA3PR12MB8763:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a42cf7b-1461-4193-3159-08dbd73da648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FozQ+i5AUi0wmwAnmInY62leebBqgo3Ljs0STsq7DvsF7R8D/o6AIXt+uOl3t2i7/UfyjxsDE+/6G7TG59TsB6ASRCLVVjmK932cPcCHPjY1njvYJTUld+HKcNKUJOQreAr7QPmDEfJ455nuJKHOEYulnm7nUa532Ps88BvEVAuCkW75nuqEHOBnBSc9aw9xfi7cAakTbd1K7yDLAY8vfIs5EZFc/z51bN/jW9Vv+Qa1TVUeQmK06gBUX8hrA0LOVs4L0aK+MMkpH1f820Gt2jgE19lwDb6bxTXJulWN3FaRaUY3Dby2P8Q07SHtlzV00N9NmnAsLSsEdAL8OcyY+F2p2Y+g/S8g82lsCv3lPc41ITPBA2YyDOMyN9AXV60KyajlDz25lSmm+EWi7iDgw491YK1EbqZmWG3widagoCfD/hfsYU7maOl24uKbZW/PyoEC9rNrVX7CdOKzhnqD6lEOt/9JhouH+MbgjDI7Vc5Bu5shLOb9eCugXu15Y/2RTM6ijSHSG7IjNBHFFStew8/BCDUSNY8nUdO/EIilcO2Y5AU0tGLfEUalXWC52jGHff4Qgjx/+ffQ9DxEe/mC2x1ENlD4gOEsjakJQJrpLihELvfGwnS2AvmzxbRCl2mJC5BalgT29R9zs4dCwub5f5aQIcDmsQcQrVVlzIUwJcDyQxOKsG6cHzJWz5sZRFh9DzGTLfoBlqICJgI3/AgafU//eQHcB8NdR6X5PtArmNw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(1800799009)(82310400011)(64100799003)(186009)(451199024)(46966006)(36840700001)(40470700004)(2906002)(316002)(478600001)(45080400002)(81166007)(70586007)(356005)(1076003)(2616005)(54906003)(7696005)(6666004)(70206006)(426003)(47076005)(82740400003)(83380400001)(40460700003)(40480700001)(336012)(86362001)(5660300002)(8676002)(4326008)(41300700001)(36860700001)(6916009)(8936002)(36756003)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 22:39:58.4220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a42cf7b-1461-4193-3159-08dbd73da648
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8763
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
Cc: emily.deng@amd.com, xinhui.pan@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make restore workers freezable so we don't have to explicitly flush them
in suspend and GPU reset code paths, and we don't accidentally try to
restore BOs while the GPU is suspended. Not having to flush restore_work
also helps avoid lock/fence dependencies in the GPU reset case where we're
not allowed to wait for fences.

This is an RFC and request for testing. I have not tested this myself yet.
My notes below:

Restore work won't be frozen during GPU reset. Does it matter? Queues will
stay evicted until resume in any case. But restore_work may be in trouble
if it gets run in the middle of a GPU reset. In that case, if anything
fails, it will just reschedule itself, so should be fine as long as it
doesn't interfere with the reset itself (respects any mechanisms in place
to prevent HW access during the reset).

What HW access does restore_work perform:
- migrating buffers: uses GPU scheduler, should be suspended during reset
- TLB flushes in userptr restore worker: not called directly, relies on
  HWS to flush TLBs on VMID attachment
- TLB flushes in SVM restore worker: Does TLB flush in the mapping code
- Resuming user mode queues: should not happen while GPU reset keeps queue
  eviction counter elevated
Ergo: Except for the SVM case, it's OK to not flush restore work before
GPU resets. I'll need to rethink the interaction of SVM restore_work with
GPU resets.

What about cancelling p->eviction_work? Eviction work would normally be
needed to signal eviction fences, but we're doing that explicitly in
suspend_all_processes. Does eviction_work wait for fences anywhere? Yes,
indirectly by flushing restore_work. So we should not try to cancel it
during a GPU reset.

Problem: accessing p->ef concurrently in evict_process_worker and
suspend_all_processes. Need a spinlock to use and update it safely.
Problem: What if evict_process_worker gets stuck in flushing restore_work?
We can skip all of that if p->ef is NULL (which it is during the reset).
Even if it gets stuck, it's no problem if the reset doesn't depend on it.
It should get unstuck after the reset.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  9 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 49 +++++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  4 +-
 4 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 54f31a420229..89e632257663 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1644,7 +1644,8 @@ int amdgpu_amdkfd_criu_resume(void *p)
 		goto out_unlock;
 	}
 	WRITE_ONCE(pinfo->block_mmu_notifications, false);
-	schedule_delayed_work(&pinfo->restore_userptr_work, 0);
+	queue_delayed_work(system_freezable_wq,
+			   &pinfo->restore_userptr_work, 0);
 
 out_unlock:
 	mutex_unlock(&pinfo->lock);
@@ -2458,7 +2459,8 @@ int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
 				       KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
 		if (r)
 			pr_err("Failed to quiesce KFD\n");
-		schedule_delayed_work(&process_info->restore_userptr_work,
+		queue_delayed_work(system_freezable_wq,
+			&process_info->restore_userptr_work,
 			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
 	}
 	mutex_unlock(&process_info->notifier_lock);
@@ -2793,7 +2795,8 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 
 	/* If validation failed, reschedule another attempt */
 	if (evicted_bos) {
-		schedule_delayed_work(&process_info->restore_userptr_work,
+		queue_delayed_work(system_freezable_wq,
+			&process_info->restore_userptr_work,
 			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
 
 		kfd_smi_event_queue_restore_rescheduled(mm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 9cc32f577e38..cf017d027fee 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -919,6 +919,7 @@ struct kfd_process {
 	 * during restore
 	 */
 	struct dma_fence *ef;
+	spinlock_t ef_lock;
 
 	/* Work items for evicting and restoring BOs */
 	struct delayed_work eviction_work;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index fbf053001af9..a07cba58ec5e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -664,7 +664,8 @@ int kfd_process_create_wq(void)
 	if (!kfd_process_wq)
 		kfd_process_wq = alloc_workqueue("kfd_process_wq", 0, 0);
 	if (!kfd_restore_wq)
-		kfd_restore_wq = alloc_ordered_workqueue("kfd_restore_wq", 0);
+		kfd_restore_wq = alloc_ordered_workqueue("kfd_restore_wq",
+							 WQ_FREEZABLE);
 
 	if (!kfd_process_wq || !kfd_restore_wq) {
 		kfd_process_destroy_wq();
@@ -1460,6 +1461,7 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 
 	kref_init(&process->ref);
 	mutex_init(&process->mutex);
+	spin_lock_init(&process->ef_lock);
 	process->mm = thread->mm;
 	process->lead_thread = thread->group_leader;
 	process->n_pdds = 0;
@@ -1904,6 +1906,19 @@ kfd_process_gpuid_from_node(struct kfd_process *p, struct kfd_node *node,
 	return -EINVAL;
 }
 
+static void signal_eviction_fence(struct kfd_process *p)
+{
+	spin_lock(&p->ef_lock);
+	if (!p->ef)
+		goto unlock_out;
+	dma_fence_signal(p->ef);
+	dma_fence_put(p->ef);
+	WRITE_ONCE(p->ef, NULL);
+
+unlock_out:
+	spin_unlock(&p->ef_lock);
+}
+
 static void evict_process_worker(struct work_struct *work)
 {
 	int ret;
@@ -1916,8 +1931,11 @@ static void evict_process_worker(struct work_struct *work)
 	 * lifetime of this thread, kfd_process p will be valid
 	 */
 	p = container_of(dwork, struct kfd_process, eviction_work);
-	WARN_ONCE(p->last_eviction_seqno != p->ef->seqno,
-		  "Eviction fence mismatch\n");
+	/* If the eviction fence is not valid, we're probably in a suspend
+	 * or GPU reset cycle. There is nothing to do in this case.
+	 */
+	if (!READ_ONCE(p->ef))
+		return;
 
 	/* Narrow window of overlap between restore and evict work
 	 * item is possible. Once amdgpu_amdkfd_gpuvm_restore_process_bos
@@ -1930,9 +1948,7 @@ static void evict_process_worker(struct work_struct *work)
 	pr_debug("Started evicting pasid 0x%x\n", p->pasid);
 	ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_TTM);
 	if (!ret) {
-		dma_fence_signal(p->ef);
-		dma_fence_put(p->ef);
-		p->ef = NULL;
+		signal_eviction_fence(p);
 		queue_delayed_work(kfd_restore_wq, &p->restore_work,
 				msecs_to_jiffies(PROCESS_RESTORE_TIME_MS));
 
@@ -1967,9 +1983,19 @@ static void restore_process_worker(struct work_struct *work)
 
 	p->last_restore_timestamp = get_jiffies_64();
 	/* VMs may not have been acquired yet during debugging. */
-	if (p->kgd_process_info)
+	if (p->kgd_process_info) {
+		struct dma_fence *ef = NULL;
+
 		ret = amdgpu_amdkfd_gpuvm_restore_process_bos(p->kgd_process_info,
-							     &p->ef);
+							     &ef);
+		if (!ret) {
+			spin_lock(&p->ef_lock);
+			WARN_ONCE(p->ef, "Eviction fence is not NULL");
+			WRITE_ONCE(p->ef, ef);
+			spin_unlock(&p->ef_lock);
+		}
+	}
+
 	if (ret) {
 		pr_debug("Failed to restore BOs of pasid 0x%x, retry after %d ms\n",
 			 p->pasid, PROCESS_BACK_OFF_TIME_MS);
@@ -1994,14 +2020,9 @@ void kfd_suspend_all_processes(void)
 
 	WARN(debug_evictions, "Evicting all processes");
 	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
-		cancel_delayed_work_sync(&p->eviction_work);
-		flush_delayed_work(&p->restore_work);
-
 		if (kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SUSPEND))
 			pr_err("Failed to suspend process 0x%x\n", p->pasid);
-		dma_fence_signal(p->ef);
-		dma_fence_put(p->ef);
-		p->ef = NULL;
+		signal_eviction_fence(p);
 	}
 	srcu_read_unlock(&kfd_processes_srcu, idx);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index fe937670c927..aa6c34127be9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1869,7 +1869,7 @@ static void svm_range_restore_work(struct work_struct *work)
 	/* If validation failed, reschedule another attempt */
 	if (evicted_ranges) {
 		pr_debug("reschedule to restore svm range\n");
-		schedule_delayed_work(&svms->restore_work,
+		queue_delayed_work(system_freezable_wq, &svms->restore_work,
 			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
 
 		kfd_smi_event_queue_restore_rescheduled(mm);
@@ -1945,7 +1945,7 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 			pr_debug("failed to quiesce KFD\n");
 
 		pr_debug("schedule to restore svm %p ranges\n", svms);
-		schedule_delayed_work(&svms->restore_work,
+		queue_delayed_work(system_freezable_wq, &svms->restore_work,
 			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
 	} else {
 		unsigned long s, l;
-- 
2.34.1

