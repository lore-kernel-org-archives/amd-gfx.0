Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69980CD5BD0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 21:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B43A10EA27;
	Wed, 27 May 2026 21:16:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TRdliN/0";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010043.outbound.protection.outlook.com
 [52.101.193.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02FE510EA27
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 21:16:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXWYlD2Sz90tW2zr7mv2gPxP6On5Bf8BzpPeETqnc2QsCdtOdR+TH4pGncNPHYmLtyb7zHfMF2drggDRJC9UGm/KVP7My8MzwQ7wTsqryvPEMKOqCivxiRfCq2uY6BWs/mYrFSWwxTw8Z5mMUetYE+wsSCotJOU4zC4mWuYfb6leDNBSMJfQDxuRtJMxdE9Gzcdpwgbdmr/oa8Az7O2mEfTqUCvxEJ5rL9wSxr2xHsae/CRmApEcrg+1iWdXIJ3HL2Qtkc9bf5CaCmBZbfKFK1Uit2/89YJJp2AFn0GsWrQ+Qt94Dxia1UdqESZB1azZ9utfu0l1dxviTW0y90mMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuGibyPh5B12vvHaJczx2A7mNdIe1im6UUXb+zhtOx8=;
 b=Tw+OYx0lzywFk0N+q2lhlfXCk/VZSUnAF+cDamshEpMIUQVsJ07o8b641+7g5JQC8aWs764da0JmKJtbhzwub4mYNROE+Q9O+RofsrCwE6Vm2BkCVzsiJWOhDlva+qQvM1O3lHHvTW5ANadnm6pPhYXQhwjlAK50tZlVEuzXXdekU6pcA+l8se9Fhd2mAwMC+0KMH1uQ7b/RiKx0tAGyo2U7NLbqHFCLk7IRAK8JPoTzK0rVPhHqYsUWzvGYnJ5RQz9yK5txyyLAUYRIc0b6F7cg66eKEJLMzZicmIPa+4gox6z8rNMK3UtM9OJMMdrcFLtD1diFdr5FpwQ0nOHWWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuGibyPh5B12vvHaJczx2A7mNdIe1im6UUXb+zhtOx8=;
 b=TRdliN/0ysQ2ySiRMrIKacYSsdfIfndCR0cp6JypYWLQ49eNO9EVioRw8MwjtzzDryPpVILSE5JC+D4xi0LDUydgQ6Yj7FWHEu6i4pKREbFKu08CbL9ZoUYcOZGQbkiWNglGE42vJbankOke1hB6/O6Fg/c+t00WC1gibnQpMOw=
Received: from BL1PR13CA0011.namprd13.prod.outlook.com (2603:10b6:208:256::16)
 by BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 21:15:54 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::a2) by BL1PR13CA0011.outlook.office365.com
 (2603:10b6:208:256::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Wed, 27
 May 2026 21:15:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 21:15:54 +0000
Received: from andmarti-mi100.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 16:15:53 -0500
From: Andrew Martin <andrew.martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Andrew Martin <andrew.martin@amd.com>, Andrew Martin <andmarti@amd.com>,
 "Claude : Sonnet 4" <noreply@anthropic.com>
Subject: [PATCH v3] drm/amdkfd: Fix SMI event PID reporting for containers
Date: Wed, 27 May 2026 17:15:25 -0400
Message-ID: <20260527211525.75006-1-andrew.martin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: e264920e-66b0-40fb-b852-08debc352325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|6123799006|3023799007|5023799004|11063799006|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 2XGYQV+pUoyRoZ6MIoROm7UTs7AxGVHswnFF+YXJCWQscDEjhLnMWsswPXZ8pFnt0Tc+CEOsrGurwxMGRWUpFOZcKjxwKUg/EOa1QnyeRw2Qgto25H5vsaZw3KZptDIav37PlrH/8G481KM1JF9evbeT2HBh40wUMRhXlsu5sV288CPXCNTyOcCRJpYSrZk7NACr33JxrcA4k9vq47YUehUUNtBPEswdf8D/+P0IdFE0YCAj+N9UXagSqXS98c0Wsbs5oVRjZUkhxBm94IeZDzLWmO1O+KdpJyvb7fEaaP7B36MoWhwu9NIxLwR3CihhwKu99rjsNJnA3pc90owRvnkrkVtr4WqCaZNjkIrfA7aYcNsyFhesnI+Cv2SUnMEOfJaFJIZTnRwMeFZ9Tc6pKzZi2C6b7JEU79Yh8kC5cEITppCa7Mljw4WYYJRVcAH4pIVY8KYVB3MwaHC3lKvH9xoKwPvxUGucNYrmPwiCPtvZIu5jtYaw/Z70RMWMmWqcWJ/HxavHzi2P+qyH7CujCh1gR7T9CQKnd4MmYcEtS+Ji5bJEsNmy+mn2LL6Nyt6bKuZ1SleyzQ1UbBLo+R/TT68tRyjta8x5fq654JOrkP7PfvS/FAW+ahqZxSrCTJuW/yaR46cDp8lQol4bwDV4qG/kdWdXiNyCpj42/JefUWoOsdEMCnPrLFh8zANCk2bxhc79tFMX64j91uoXvVJxVdQEV2aICklCwThrg8x5kYA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(6123799006)(3023799007)(5023799004)(11063799006)(6133799003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /h6LxOhzNYFOS1hezU1MGblUPDtHhYNoO9FWIoPtsEmWI0v+jiUm8e+X+Is2V++edszQLvq6xU4V6PEah2njiiJLDnQb4EAulzC3F+o4JWRO1ssuYb5m2PnxMOp0E2ZRMaHqFLhzRmBbbSGkmQiwy0XXV+zgjjY0Am1x3PYK1vKBiz5CGz73Rbndy4zMLhBJ67VIObKWw+vNUpbabNH7KelwXjxiu1R9Z3n4b40uBYrp/IsXXRM5loUHE1ARBNEMPwa5Ksu3eru9ej3fAnlG+iHn6EdBH8idw5VzNuQLfbqoN3O4+jhPqInhYbUfjz8Cih8cRdSfi4j/oTEwafCi5HwW2n49deGWwJZtxd+KvBBVPVgjxJsac6mk4xsgvUf/AV+ZHzVBZXJ6mpJtsRhhBoclm+5PxVX/F6g9eOUQg708pyZ6d7J9EWiEsMM8lEeq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 21:15:54.1717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e264920e-66b0-40fb-b852-08debc352325
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825
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

SMI events were reporting incorrect PIDs in containerized environments,
causing test failures where container processes expected to see their
namespace-local PIDs but instead received global host PIDs.

The issue had two root causes:

1. Event functions were called from kernel context (page fault handlers,
   migration workers) where 'current' refers to the kernel worker thread,
   not the userspace GPU process that triggered the event.

2. PID conversion used task_tgid_vnr() which returns the PID in the
   caller's namespace (init namespace for kernel threads), not the task's
   own namespace.

This patch updates the SMI event interface:

- Change 8 event function signatures to accept task_struct pointer
  instead of pid_t, allowing proper namespace-aware PID conversion

- Convert PIDs using task_tgid_nr_ns(task, task_active_pid_ns(task))
  which returns the PID as the process sees it via getpid()

- Update 10 call sites to pass p->lead_thread (the GPU process)
  instead of p->lead_thread->pid or current (kernel worker)

This ensures SMI events report container-local PIDs, which is critical
for containerized GPU workloads to correctly correlate events with their
processes.

Tested-by: Andrew Martin <andmarti@amd.com>
Assisted-by: Claude:Sonnet 4 <noreply@anthropic.com>
Signed-off-by: Andrew Martin <andrew.martin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    |  8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c    |  6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 95 +++++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h | 14 +--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c        |  6 +-
 5 files changed, 76 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 28dc6886c1ff..226e76ae0be7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -424,7 +424,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	migrate.dst = migrate.src + npages;
 	scratch = (dma_addr_t *)(migrate.dst + npages);
 
-	kfd_smi_event_migration_start(node, p->lead_thread->pid,
+	kfd_smi_event_migration_start(node, p->lead_thread,
 				      start >> PAGE_SHIFT, end >> PAGE_SHIFT,
 				      0, node->id, prange->prefetch_loc,
 				      prange->preferred_loc, trigger);
@@ -462,7 +462,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 
 out_free:
 	kvfree(buf);
-	kfd_smi_event_migration_end(node, p->lead_thread->pid,
+	kfd_smi_event_migration_end(node, p->lead_thread,
 				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
 				    0, node->id, trigger, r);
 out:
@@ -727,7 +727,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	migrate.fault_page = fault_page;
 	scratch = (dma_addr_t *)(migrate.dst + npages);
 
-	kfd_smi_event_migration_start(node, p->lead_thread->pid,
+	kfd_smi_event_migration_start(node, p->lead_thread,
 				      start >> PAGE_SHIFT, end >> PAGE_SHIFT,
 				      node->id, 0, prange->prefetch_loc,
 				      prange->preferred_loc, trigger);
@@ -766,7 +766,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 
 out_free:
 	kvfree(buf);
-	kfd_smi_event_migration_end(node, p->lead_thread->pid,
+	kfd_smi_event_migration_end(node, p->lead_thread,
 				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
 				    node->id, 0, trigger, r);
 out:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 419bb8086ccd..0ed315eb0bca 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1975,7 +1975,7 @@ int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger)
 		struct kfd_process_device *pdd = p->pdds[i];
 		struct device *dev = pdd->dev->adev->dev;
 
-		kfd_smi_event_queue_eviction(pdd->dev, p->lead_thread->pid,
+		kfd_smi_event_queue_eviction(pdd->dev, p->lead_thread,
 					     trigger);
 
 		r = pdd->dev->dqm->ops.evict_process_queues(pdd->dev->dqm,
@@ -2005,7 +2005,7 @@ int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger)
 		if (n_evicted == 0)
 			break;
 
-		kfd_smi_event_queue_restore(pdd->dev, p->lead_thread->pid);
+		kfd_smi_event_queue_restore(pdd->dev, p->lead_thread);
 
 		if (pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
 							      &pdd->qpd))
@@ -2028,7 +2028,7 @@ int kfd_process_restore_queues(struct kfd_process *p)
 		struct kfd_process_device *pdd = p->pdds[i];
 		struct device *dev = pdd->dev->adev->dev;
 
-		kfd_smi_event_queue_restore(pdd->dev, p->lead_thread->pid);
+		kfd_smi_event_queue_restore(pdd->dev, p->lead_thread);
 
 		r = pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
 							      &pdd->qpd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index d2bc169e84b0..a08fdef97917 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -195,17 +195,35 @@ static void add_event_to_kfifo(pid_t pid, struct kfd_node *dev,
 	rcu_read_unlock();
 }
 
+/**
+ * kfd_smi_task_to_pid - Convert task to namespace-aware PID
+ * @task: task_struct pointer (typically p->lead_thread)
+ *
+ * Returns the PID as it appears in the task's own PID namespace.
+ * For containerized processes, this returns the container-local PID
+ * (what getpid() returns), not the global host PID.
+ *
+ * Returns 0 if task is NULL.
+ */
+static inline pid_t kfd_smi_task_to_pid(struct task_struct *task)
+{
+	return task ? task_tgid_nr_ns(task, task_active_pid_ns(task)) : 0;
+}
+
 __printf(4, 5)
-static void kfd_smi_event_add(pid_t pid, struct kfd_node *dev,
+static void kfd_smi_event_add(struct task_struct *task, struct kfd_node *dev,
 			      unsigned int event, char *fmt, ...)
 {
 	char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
 	int len;
 	va_list args;
+	pid_t pid;
 
 	if (list_empty(&dev->smi_clients))
 		return;
 
+	pid = kfd_smi_task_to_pid(task);
+
 	len = snprintf(fifo_in, sizeof(fifo_in), "%x ", event);
 
 	va_start(args, fmt);
@@ -234,14 +252,15 @@ void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
 		amdgpu_reset_get_desc(reset_context, reset_cause,
 				      sizeof(reset_cause));
 
-	kfd_smi_event_add(0, dev, event, KFD_EVENT_FMT_UPDATE_GPU_RESET(
+	kfd_smi_event_add(NULL, dev, event, KFD_EVENT_FMT_UPDATE_GPU_RESET(
 			  dev->reset_seq_num, reset_cause));
 }
 
 void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
 					     uint64_t throttle_bitmask)
 {
-	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE, KFD_EVENT_FMT_THERMAL_THROTTLING(
+	kfd_smi_event_add(NULL, dev, KFD_SMI_EVENT_THERMAL_THROTTLE,
+			  KFD_EVENT_FMT_THERMAL_THROTTLING(
 			  throttle_bitmask,
 			  amdgpu_dpm_get_thermal_throttling_counter(dev->adev)));
 }
@@ -254,65 +273,67 @@ void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
 	if (task_info) {
 		/* Report VM faults from user applications, not retry from kernel */
 		if (task_info->task.pid)
-			kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, KFD_EVENT_FMT_VMFAULT(
+			kfd_smi_event_add(NULL, dev, KFD_SMI_EVENT_VMFAULT, KFD_EVENT_FMT_VMFAULT(
 					  task_info->task.pid, task_info->task.comm));
 		amdgpu_vm_put_task_info(task_info);
 	}
 }
 
-void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
+void kfd_smi_event_page_fault_start(struct kfd_node *node, struct task_struct *task,
 				    unsigned long address, bool write_fault,
 				    ktime_t ts)
 {
-	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_PAGE_FAULT_START,
-			  KFD_EVENT_FMT_PAGEFAULT_START(ktime_to_ns(ts), pid,
-			  address, node->id, write_fault ? 'W' : 'R'));
+	kfd_smi_event_add(task, node, KFD_SMI_EVENT_PAGE_FAULT_START,
+			  KFD_EVENT_FMT_PAGEFAULT_START(ktime_to_ns(ts),
+			  kfd_smi_task_to_pid(task), address, node->id,
+			  write_fault ? 'W' : 'R'));
 }
 
-void kfd_smi_event_page_fault_end(struct kfd_node *node, pid_t pid,
+void kfd_smi_event_page_fault_end(struct kfd_node *node, struct task_struct *task,
 				  unsigned long address, bool migration)
 {
-	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_PAGE_FAULT_END,
+	kfd_smi_event_add(task, node, KFD_SMI_EVENT_PAGE_FAULT_END,
 			  KFD_EVENT_FMT_PAGEFAULT_END(ktime_get_boottime_ns(),
-			  pid, address, node->id, migration ? 'M' : 'U'));
+			  kfd_smi_task_to_pid(task), address, node->id,
+			  migration ? 'M' : 'U'));
 }
 
-void kfd_smi_event_migration_start(struct kfd_node *node, pid_t pid,
+void kfd_smi_event_migration_start(struct kfd_node *node, struct task_struct *task,
 				   unsigned long start, unsigned long end,
 				   uint32_t from, uint32_t to,
 				   uint32_t prefetch_loc, uint32_t preferred_loc,
 				   uint32_t trigger)
 {
-	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_MIGRATE_START,
-			  KFD_EVENT_FMT_MIGRATE_START(
-			  ktime_get_boottime_ns(), pid, start, end - start,
-			  from, to, prefetch_loc, preferred_loc, trigger));
+	kfd_smi_event_add(task, node, KFD_SMI_EVENT_MIGRATE_START,
+			  KFD_EVENT_FMT_MIGRATE_START(ktime_get_boottime_ns(),
+			  kfd_smi_task_to_pid(task), start, end - start, from,
+			  to, prefetch_loc, preferred_loc, trigger));
 }
 
-void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,
+void kfd_smi_event_migration_end(struct kfd_node *node, struct task_struct *task,
 				 unsigned long start, unsigned long end,
 				 uint32_t from, uint32_t to, uint32_t trigger,
 				 int error_code)
 {
-	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_MIGRATE_END,
-			  KFD_EVENT_FMT_MIGRATE_END(
-			  ktime_get_boottime_ns(), pid, start, end - start,
-			  from, to, trigger, error_code));
+	kfd_smi_event_add(task, node, KFD_SMI_EVENT_MIGRATE_END,
+			  KFD_EVENT_FMT_MIGRATE_END(ktime_get_boottime_ns(),
+			  kfd_smi_task_to_pid(task), start, end - start, from,
+			  to, trigger, error_code));
 }
 
-void kfd_smi_event_queue_eviction(struct kfd_node *node, pid_t pid,
+void kfd_smi_event_queue_eviction(struct kfd_node *node, struct task_struct *task,
 				  uint32_t trigger)
 {
-	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_EVICTION,
-			  KFD_EVENT_FMT_QUEUE_EVICTION(ktime_get_boottime_ns(), pid,
-			  node->id, trigger));
+	kfd_smi_event_add(task, node, KFD_SMI_EVENT_QUEUE_EVICTION,
+			  KFD_EVENT_FMT_QUEUE_EVICTION(ktime_get_boottime_ns(),
+			  kfd_smi_task_to_pid(task), node->id, trigger));
 }
 
-void kfd_smi_event_queue_restore(struct kfd_node *node, pid_t pid)
+void kfd_smi_event_queue_restore(struct kfd_node *node, struct task_struct *task)
 {
-	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_RESTORE,
-			  KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(), pid,
-			  node->id, '0'));
+	kfd_smi_event_add(task, node, KFD_SMI_EVENT_QUEUE_RESTORE,
+			  KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(),
+			  kfd_smi_task_to_pid(task), node->id, '0'));
 }
 
 void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
@@ -327,21 +348,23 @@ void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 
-		kfd_smi_event_add(p->lead_thread->pid, pdd->dev,
+		kfd_smi_event_add(p->lead_thread, pdd->dev,
 				  KFD_SMI_EVENT_QUEUE_RESTORE,
 				  KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(),
-				  p->lead_thread->pid, pdd->dev->id, 'R'));
+				  kfd_smi_task_to_pid(p->lead_thread),
+				  pdd->dev->id, 'R'));
 	}
 	kfd_unref_process(p);
 }
 
-void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, pid_t pid,
+void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, struct task_struct *task,
 				  unsigned long address, unsigned long last,
 				  uint32_t trigger)
 {
-	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_UNMAP_FROM_GPU,
+	kfd_smi_event_add(task, node, KFD_SMI_EVENT_UNMAP_FROM_GPU,
 			  KFD_EVENT_FMT_UNMAP_FROM_GPU(ktime_get_boottime_ns(),
-			  pid, address, last - address + 1, node->id, trigger));
+			  kfd_smi_task_to_pid(task), address,
+			  last - address + 1, node->id, trigger));
 }
 
 void kfd_smi_event_process(struct kfd_process_device *pdd, bool start)
@@ -356,7 +379,7 @@ void kfd_smi_event_process(struct kfd_process_device *pdd, bool start)
 	task_info = amdgpu_vm_get_task_info_vm(avm);
 
 	if (task_info) {
-		kfd_smi_event_add(0, pdd->dev,
+		kfd_smi_event_add(NULL, pdd->dev,
 				  start ? KFD_SMI_EVENT_PROCESS_START :
 				  KFD_SMI_EVENT_PROCESS_END,
 				  KFD_EVENT_FMT_PROCESS(task_info->task.pid,
@@ -385,7 +408,7 @@ int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd)
 	spin_lock_init(&client->lock);
 	client->events = 0;
 	client->dev = dev;
-	client->pid = current->tgid;
+	client->pid = kfd_smi_task_to_pid(current);
 	client->suser = capable(CAP_SYS_ADMIN);
 
 	spin_lock(&dev->smi_lock);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index bb4d72b57387..afa93d7cfa7f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -32,25 +32,25 @@ void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
 					     uint64_t throttle_bitmask);
 void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
 				    struct amdgpu_reset_context *reset_context);
-void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
+void kfd_smi_event_page_fault_start(struct kfd_node *node, struct task_struct *task,
 				    unsigned long address, bool write_fault,
 				    ktime_t ts);
-void kfd_smi_event_page_fault_end(struct kfd_node *node, pid_t pid,
+void kfd_smi_event_page_fault_end(struct kfd_node *node, struct task_struct *task,
 				  unsigned long address, bool migration);
-void kfd_smi_event_migration_start(struct kfd_node *node, pid_t pid,
+void kfd_smi_event_migration_start(struct kfd_node *node, struct task_struct *task,
 			     unsigned long start, unsigned long end,
 			     uint32_t from, uint32_t to,
 			     uint32_t prefetch_loc, uint32_t preferred_loc,
 			     uint32_t trigger);
-void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,
+void kfd_smi_event_migration_end(struct kfd_node *node, struct task_struct *task,
 			     unsigned long start, unsigned long end,
 			     uint32_t from, uint32_t to, uint32_t trigger,
 			     int error_code);
-void kfd_smi_event_queue_eviction(struct kfd_node *node, pid_t pid,
+void kfd_smi_event_queue_eviction(struct kfd_node *node, struct task_struct *task,
 				  uint32_t trigger);
-void kfd_smi_event_queue_restore(struct kfd_node *node, pid_t pid);
+void kfd_smi_event_queue_restore(struct kfd_node *node, struct task_struct *task);
 void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm);
-void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, pid_t pid,
+void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, struct task_struct *task,
 				  unsigned long address, unsigned long last,
 				  uint32_t trigger);
 void kfd_smi_event_process(struct kfd_process_device *pdd, bool start);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 25b3ecf85f30..b9f62129a825 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1408,7 +1408,7 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 			return -EINVAL;
 		}
 
-		kfd_smi_event_unmap_from_gpu(pdd->dev, p->lead_thread->pid,
+		kfd_smi_event_unmap_from_gpu(pdd->dev, p->lead_thread,
 					     start, last, trigger);
 
 		r = svm_range_unmap_from_gpu(pdd->dev->adev,
@@ -3205,7 +3205,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		 svms, prange->start, prange->last, best_loc,
 		 prange->actual_loc);
 
-	kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
+	kfd_smi_event_page_fault_start(node, p->lead_thread, addr,
 				       write_fault, timestamp);
 
 	/* Align migration range start and size to granularity size */
@@ -3248,7 +3248,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			 r, svms, start, last);
 
 out_migrate_fail:
-	kfd_smi_event_page_fault_end(node, p->lead_thread->pid, addr,
+	kfd_smi_event_page_fault_end(node, p->lead_thread, addr,
 				     migration);
 
 out_unlock_range:
-- 
2.34.1

