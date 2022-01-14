Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A57C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 20:39:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E413D10E243;
	Fri, 14 Jan 2022 20:39:04 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2085.outbound.protection.outlook.com [40.107.212.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3B6810E225
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 20:39:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJAmzmdqe0AYNFbsWIx4eKsKtHXkM25zpxWEH1Z8U0VN7rkEBvyB9rD73AsigEPgkthK798bIs/ebWB3gIN39aBrTef1OPvmZl4LvLAy3BS27s9s2gQ72Il+FbavyJIwEzVN2XgaqoVTnNhFrmt50ljfAINb8J7mtWbspzKmE+aGcA+xBp2zdDur6gj02esfTYLZFJPGThGfUPzVVlwTjF+9zq1OdWAGoLlIMDSqacvVzChzgrvZa6PVIVAGYhJ4mESO9omZHEy0m20UhfUQJc1vRqKEEuK5Ak5S+5J0oVSFyZ2wNPTaLvbjOltzO7e/nt+bf/+NKRq0dndwEly2HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMMPSSV7kPYUTn/dN+C8dqz1mqwJlBMyp+NKj9RUGeE=;
 b=OgGwcngw5OWlCSUwB5k6cDa1RT2yZ5G6KmapCX/mAShkhqavLKf4nQF8/PkzhFDwqDDRHSqg+dprIdsk1GvqkpVkaY9L4L9LUvpHukX6ySZIYARPHSCt+/2NuRaJyzCe2BZsZodcrL8GKrb3DjTvGoqE6VUt4XIsy3ggK4ZGiG5petOH1Tp8fhpHfk+LFPTB9JUkw2ou9ls7CDmV0nWHML1joYPFeMcTZhgP2ggvR01Dt/Z8egde58mpitj6qh1/dqeSR+xbr3BR4xMwpB1vWZiIeyBkyDibW4IjJoZOb4ODnlyksZIpkP9SKN2Cu4+QZQbjfkYBOnTgJpZ5ZW5IYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMMPSSV7kPYUTn/dN+C8dqz1mqwJlBMyp+NKj9RUGeE=;
 b=xE+A59hSBSmIIo5wtTDeg/h2ykeKvjQo0pUrBLSaTtwgyUGynX8zugnaxev/2lAkTNDJj6UWMEC6G4EHelL6iBGOilXmDpqqFXRaWBvI6AdweZ1JWbk9EFYLKeeTzwx6V6YiFtMEv6QAmyBjp+MwQ8wYbyJVAUnUu+x4l448io4=
Received: from DS7P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::9) by
 CH2PR12MB5019.namprd12.prod.outlook.com (2603:10b6:610:6a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Fri, 14 Jan 2022 20:38:57 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::5e) by DS7P222CA0023.outlook.office365.com
 (2603:10b6:8:2e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Fri, 14 Jan 2022 20:38:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 20:38:56 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 14 Jan
 2022 14:38:55 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdkfd: add user queue eviction restore SMI event
Date: Fri, 14 Jan 2022 15:38:39 -0500
Message-ID: <20220114203839.21707-6-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220114203839.21707-1-Philip.Yang@amd.com>
References: <20220114203839.21707-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a22020d4-c702-47a5-8a48-08d9d79de301
X-MS-TrafficTypeDiagnostic: CH2PR12MB5019:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB5019D64A1268F1D104503D23E6549@CH2PR12MB5019.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BoLxIR6a0CF7DzMBI7RJFuL3ntOHGMvtuCtqDJ3AACHo6gaXXxcbqAqWaJwEKmRbH7AbKTxoKD4ZzcT+OUpiEqcpTIooMo9imYR04b6jmkGCdIHLVZ4OBP/7sJWt63NomVQiHnjstcQh76BNKANvfLMx6ibjvhY6+bOsGIU1Nnnxap3/QG1iV8uUQdWUJGe7KRONxNYERWs/OScquCisXMnwq1wb0yVRQeh8ZPMj67OwwYWy+/fqPhh9jtuIF/KuqKAQba9c1i2Mb0sUZ/hOMG4Aow3Q0/bBIbt1yynFNWfhSXyyfhwFiZjtfD0gR3JGDlLUukq6MHVW4mgpXa3wqdQCvOQKfSxafZSZZgQEqVMJLZJOE6yp9wsfXX6m6wTypvvMhl/I5+9exjaK1BxddswAKkNkC2XQWdKOFQ51iPSA6+Ri+pGLCsbVjnYexTCoNBFYdQWeYRVPyyLbJoDBVGk41DLkZvwRpDz0ZMNjjE3cFdk3nQw+0WgXc4guInIjW9bm0D/VAi3shtWTrQSy9CSFrXyz0EXTZTpodrdF3NnBri1Cvl33SjGZgAeQj473EEAu3pLJHBh9OGDYOPN6pfjFMkNBt/vspz1cIV9cDxlf/WHRYDMwoNDe91RE63NuicOTrxtVESYw+IYQMWNc10rCrg0+YxQfvv9H6bDDKButpqgg2o2bg/uJ3GxbwhMBhKkMSjf1wQljFUIec7Ipyry0B7IFDgLFD6f+uUZlywyxShKayTiLwcI4TO6pz9q3P+K/rOvJQFHTuu4iqX0czQMoRbA3BzACI7Su315xpTI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(86362001)(336012)(508600001)(36756003)(70206006)(2616005)(26005)(36860700001)(7696005)(5660300002)(2906002)(426003)(30864003)(6916009)(316002)(83380400001)(47076005)(8676002)(1076003)(82310400004)(186003)(16526019)(40460700001)(4326008)(8936002)(6666004)(54906003)(81166007)(70586007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 20:38:56.7064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a22020d4-c702-47a5-8a48-08d9d79de301
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5019
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Output user queue eviction and restore event. User queue eviction may be
triggered by migration, MMU notifier, TTM eviction or device suspend.

User queue restore may be rescheduled if eviction happens again while
restore.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  7 +++-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 11 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  4 +--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 36 +++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   | 35 ++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h   |  4 +++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  6 ++--
 8 files changed, 92 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index ac841ae8f5cc..bd3301e2c682 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -309,6 +309,7 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
  */
 void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
 void amdgpu_amdkfd_reserve_system_mem(uint64_t size);
+void kfd_process_smi_event_restore_rescheduled(struct mm_struct *mm);
 #else
 static inline
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
@@ -325,9 +326,13 @@ static inline
 void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
 {
 }
+
+static inline void kfd_process_smi_event_restore_rescheduled(struct mm_struct *mm)
+{
+}
 #endif
 /* KGD2KFD callbacks */
-int kgd2kfd_quiesce_mm(struct mm_struct *mm);
+int kgd2kfd_quiesce_mm(struct mm_struct *mm, uint32_t trigger);
 int kgd2kfd_resume_mm(struct mm_struct *mm);
 int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
 						struct dma_fence *fence);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index f9bab963a948..d168934d7664 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2072,7 +2072,7 @@ int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem,
 	evicted_bos = atomic_inc_return(&process_info->evicted_bos);
 	if (evicted_bos == 1) {
 		/* First eviction, stop the queues */
-		r = kgd2kfd_quiesce_mm(mm);
+		r = kgd2kfd_quiesce_mm(mm, USERPTR_EVICTION);
 		if (r)
 			pr_err("Failed to quiesce KFD\n");
 		schedule_delayed_work(&process_info->restore_userptr_work,
@@ -2346,13 +2346,16 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 
 unlock_out:
 	mutex_unlock(&process_info->lock);
-	mmput(mm);
-	put_task_struct(usertask);
 
 	/* If validation failed, reschedule another attempt */
-	if (evicted_bos)
+	if (evicted_bos) {
 		schedule_delayed_work(&process_info->restore_userptr_work,
 			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
+
+		kfd_process_smi_event_restore_rescheduled(mm);
+	}
+	mmput(mm);
+	put_task_struct(usertask);
 }
 
 /** amdgpu_amdkfd_gpuvm_restore_process_bos - Restore all BOs for the given
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 5a47f437b455..ffaa80447d9c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -783,7 +783,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
 	spin_unlock_irqrestore(&kfd->interrupt_lock, flags);
 }
 
-int kgd2kfd_quiesce_mm(struct mm_struct *mm)
+int kgd2kfd_quiesce_mm(struct mm_struct *mm, uint32_t trigger)
 {
 	struct kfd_process *p;
 	int r;
@@ -797,7 +797,7 @@ int kgd2kfd_quiesce_mm(struct mm_struct *mm)
 		return -ESRCH;
 
 	WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
-	r = kfd_process_evict_queues(p);
+	r = kfd_process_evict_queues(p, trigger);
 
 	kfd_unref_process(p);
 	return r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index ea68f3b3a4e9..39519084df78 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -906,7 +906,7 @@ static inline struct kfd_process_device *kfd_process_device_from_gpuidx(
 }
 
 void kfd_unref_process(struct kfd_process *p);
-int kfd_process_evict_queues(struct kfd_process *p);
+int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger);
 int kfd_process_restore_queues(struct kfd_process *p);
 void kfd_suspend_all_processes(void);
 int kfd_resume_all_processes(void);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 74f162887d3b..e4f67fa003b9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -43,6 +43,7 @@ struct mm_struct;
 #include "kfd_dbgmgr.h"
 #include "kfd_iommu.h"
 #include "kfd_svm.h"
+#include "kfd_smi_events.h"
 
 /*
  * List of struct kfd_process (field kfd_process).
@@ -1701,7 +1702,7 @@ struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm)
  * Eviction is reference-counted per process-device. This means multiple
  * evictions from different sources can be nested safely.
  */
-int kfd_process_evict_queues(struct kfd_process *p)
+int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger)
 {
 	int r = 0;
 	int i;
@@ -1710,6 +1711,9 @@ int kfd_process_evict_queues(struct kfd_process *p)
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 
+		kfd_smi_event_queue_eviction(pdd->dev, p->pasid, ktime_get_ns(),
+					     trigger);
+
 		r = pdd->dev->dqm->ops.evict_process_queues(pdd->dev->dqm,
 							    &pdd->qpd);
 		/* evict return -EIO if HWS is hang or asic is resetting, in this case
@@ -1734,6 +1738,10 @@ int kfd_process_evict_queues(struct kfd_process *p)
 
 		if (n_evicted == 0)
 			break;
+
+		kfd_smi_event_queue_eviction_restore(pdd->dev, p->pasid,
+						     ktime_get_ns(), false);
+
 		if (pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
 							      &pdd->qpd))
 			pr_err("Failed to restore queues\n");
@@ -1753,6 +1761,9 @@ int kfd_process_restore_queues(struct kfd_process *p)
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 
+		kfd_smi_event_queue_eviction_restore(pdd->dev, p->pasid,
+						     ktime_get_ns(), false);
+
 		r = pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
 							      &pdd->qpd);
 		if (r) {
@@ -1765,6 +1776,25 @@ int kfd_process_restore_queues(struct kfd_process *p)
 	return ret;
 }
 
+void kfd_process_smi_event_restore_rescheduled(struct mm_struct *mm)
+{
+	struct kfd_process *p;
+	int i;
+
+	p = kfd_lookup_process_by_mm(mm);
+	if (!p)
+		return;
+
+	for (i = 0; i < p->n_pdds; i++) {
+		struct kfd_process_device *pdd = p->pdds[i];
+
+		kfd_smi_event_queue_eviction_restore(pdd->dev,
+						pdd->process->pasid,
+						ktime_get_ns(), true);
+	}
+	kfd_unref_process(p);
+}
+
 int kfd_process_gpuidx_from_gpuid(struct kfd_process *p, uint32_t gpu_id)
 {
 	int i;
@@ -1814,7 +1844,7 @@ static void evict_process_worker(struct work_struct *work)
 	flush_delayed_work(&p->restore_work);
 
 	pr_debug("Started evicting pasid 0x%x\n", p->pasid);
-	ret = kfd_process_evict_queues(p);
+	ret = kfd_process_evict_queues(p, TTM_EVICTION);
 	if (!ret) {
 		dma_fence_signal(p->ef);
 		dma_fence_put(p->ef);
@@ -1881,7 +1911,7 @@ void kfd_suspend_all_processes(void)
 		cancel_delayed_work_sync(&p->eviction_work);
 		cancel_delayed_work_sync(&p->restore_work);
 
-		if (kfd_process_evict_queues(p))
+		if (kfd_process_evict_queues(p, SUSPEND_EVICTION))
 			pr_err("Failed to suspend process 0x%x\n", p->pasid);
 		dma_fence_signal(p->ef);
 		dma_fence_put(p->ef);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 7996438377bc..9a6c3a1e89f9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -330,6 +330,41 @@ void kfd_smi_event_page_fault(struct kfd_dev *dev, uint16_t pasid,
 	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_PAGE_FAULT, fifo_in, len);
 }
 
+void kfd_smi_event_queue_eviction(struct kfd_dev *dev, uint16_t pasid,
+				  uint64_t ts, uint32_t trigger)
+{
+	char fifo_in[64];
+	pid_t pid;
+	int len;
+
+	if (!kfd_smi_event_pid_duration(dev, pasid, &pid, 0, NULL))
+		return;
+
+	len = snprintf(fifo_in, sizeof(fifo_in), "%d ts=%lld pid=%d gpuid=0x%x"
+		       " trigger=%d\n", KFD_SMI_EVENT_QUEUE_EVICTION, ts, pid,
+		       dev->id, trigger);
+
+	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_QUEUE_EVICTION, fifo_in, len);
+}
+
+void kfd_smi_event_queue_eviction_restore(struct kfd_dev *dev, uint16_t pasid,
+					  uint64_t ts, bool rescheduled)
+{
+	char fifo_in[64];
+	pid_t pid;
+	int len;
+
+	if (!kfd_smi_event_pid_duration(dev, pasid, &pid, 0, NULL))
+		return;
+
+	len = snprintf(fifo_in, sizeof(fifo_in), "%d ts=%lld pid=%d gpuid=0x%x"
+		       " %s\n", KFD_SMI_EVENT_QUEUE_EVICTION_RESTORE, ts, pid,
+		       dev->id, rescheduled ? "rescheduled" : "success");
+
+	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_QUEUE_EVICTION_RESTORE,
+			   fifo_in, len);
+}
+
 int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
 {
 	struct kfd_smi_client *client;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index 7dcc66ac8798..a39b7e4f2a07 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -36,5 +36,9 @@ void kfd_smi_event_migration(struct kfd_dev *dev, uint16_t pasid,
 void kfd_smi_event_page_fault(struct kfd_dev *dev, uint16_t pasid,
 			      unsigned long address, bool migration,
 			      bool write_fault, uint64_t ts);
+void kfd_smi_event_queue_eviction(struct kfd_dev *dev, uint16_t pasid,
+				  uint64_t ts, uint32_t trigger);
+void kfd_smi_event_queue_eviction_restore(struct kfd_dev *dev, uint16_t pasid,
+					  uint64_t ts, bool rescheduled);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index d7dcc443c16f..51a8b0c69895 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1704,14 +1704,16 @@ static void svm_range_restore_work(struct work_struct *work)
 out_reschedule:
 	mutex_unlock(&svms->lock);
 	mmap_write_unlock(mm);
-	mmput(mm);
 
 	/* If validation failed, reschedule another attempt */
 	if (evicted_ranges) {
 		pr_debug("reschedule to restore svm range\n");
 		schedule_delayed_work(&svms->restore_work,
 			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
+
+		kfd_process_smi_event_restore_rescheduled(mm);
 	}
+	mmput(mm);
 }
 
 /**
@@ -1767,7 +1769,7 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 			 prange->svms, prange->start, prange->last);
 
 		/* First eviction, stop the queues */
-		r = kgd2kfd_quiesce_mm(mm);
+		r = kgd2kfd_quiesce_mm(mm, SVM_RANGE_EVICTION);
 		if (r)
 			pr_debug("failed to quiesce KFD\n");
 
-- 
2.17.1

