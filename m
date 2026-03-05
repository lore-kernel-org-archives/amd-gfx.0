Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AAEF33A7C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 14:56:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D4A910E217;
	Thu,  5 Mar 2026 14:56:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZnEjUiNM";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013040.outbound.protection.outlook.com
 [40.93.196.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8264410E217
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 14:56:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBhq4ZXjL61XSH5zNum35ToiAPaoOlQxpv2eHBTKQBff2gHlNRqHBjWvVA4Xa8eDsCdgrem71BtcDpfir46tD7jk1/rq8aotfQ2RTf5gHSclpMKOVZW3f3igF2oC8mffYMw15KbrTEwuShgxbs0g1gea8feVNPYs3W/u/1zJC2zbnSLS9QexLNn/io6oOsS7CSAStmPPDuHAtaRvCOkAPo8MQHg8SqHiwYOH+0mvGA6uc1Qw/sx6aNw6/6ORK9u2uUmBkzsESJub2B8Of+bI7k+7bSfCTbfgeHmIgJwstxwRwAdHXnt+ehdMPoTyHFzJQI//kjk1TpxFRanCCDXwSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoGtKid+n7yKHnmRBM8WlocO9SOEVMZF5VI0S1/x52w=;
 b=XUluN4GNH8MZoCLh8z81mxDZCxg4pe3B/56t3kJ7HDDaHm3OD54YzokYvOS4b68xxK0t++9rEJdtd2K9YyTtKkAr2ig38887mfy3oeF4NYB0CjiZPvm0UydW1kjH6u7SsBq8pAkHOBxBu2Jelrz5SJRbqgpxYyHEVm2VpVyR6g+w399JxD95nCo2KMjiNs6icoWBBMuXZqTqt3SddK1FQJZzG7GEQsj1hccGVmoMZIzsjYG/2ukbFcB2mTp6OZp2xt7l2ojg4sEYtgzsp18JMii5rLm5bofpUVRpWBWvUqJkZgjKp8X6dhZh2BsAwYn2rrNzgHRFMdAtMv+4I4X2Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoGtKid+n7yKHnmRBM8WlocO9SOEVMZF5VI0S1/x52w=;
 b=ZnEjUiNM5aicdZC4oRRIBZRkbsSJlyTk4567eyzYZOChCOBAQfTVoffYN9Egox9a1ij31yZTWNtcqMjIBZ3UUEgexg2KD8LBVPPKHEdfMvSLSe/Kd7tAileWAwKJRvBNfF6SE1VdiiESRGShBdb8zX/0RsJpr1imsm7zHQfHj98=
Received: from CH5P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::12)
 by DS2PR12MB9664.namprd12.prod.outlook.com (2603:10b6:8:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 14:56:02 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::32) by CH5P220CA0008.outlook.office365.com
 (2603:10b6:610:1ef::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Thu,
 5 Mar 2026 14:56:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 14:56:01 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 08:56:01 -0600
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <cfreehil@amd.com>, David Francis <David.Francis@amd.com>
Subject: [PATCH] drm/amdgpu: Add profiling counters in fdinfo
Date: Thu, 5 Mar 2026 09:55:48 -0500
Message-ID: <20260305145548.1253522-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|DS2PR12MB9664:EE_
X-MS-Office365-Filtering-Correlation-Id: bc74c25a-ef9d-4e08-64fc-08de7ac751aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026; 
X-Microsoft-Antispam-Message-Info: 7cJNzKUZjHsEEz5gUMDx0ON6eiYbvC6hefUErxDsl7usgompgyk+jHd5amZeGeVW/9u0Pf2RDp92lXAy/Gs3UHQR9BkO+FpIqHaHyPhDNIb1Ej07WOSZJid41H/Z55iKlJms1tfkyDFORe6yb7qqfxKUz5SU4lFjV+1QdMP5/Mp3paynWqhkRX6Qn80aR6Gtm177VpbVtJjrgOXrG4IKJkhxPTWCsAmxEDsoVQUmSN469GDgefb2kS4QB9Gqoj2rrQCYLAojNBER9QVMSqNVcJmBSlPGtBmes8N8KnAxudZdaN5jU08CugT0YyFB44gfWCQNfUOwmqVcj/jCyeG8dRBjxt4ZHQPeBKfiRH/A73ZHL3DwZoa5kU30qRzvOqMlAVwJQcxdMKLoifFqcQLenm1ZFJdS25VdO0BUiJcrIpsycRe8muoVw6nwIDumHrC4Z8yw9t2R+l5dZPUaJpSBY8xlOco4r3a8JEaOf30PCrywdh2j73IftfhQWiAiRnDEFw4nCNae9eiCMDPz/TYS3su9z92zuceKHZc91hszXbLaChGwA4jBBm/u4t2hwcQeFdrrGKwF1LPWdu5DMHl2fJNTUIsVS5RJQxSeT5YSLwYH0ATBooGo6CmosGKN/Q0bEb8J2L3TmXjr4lqngszhUAz+Pt/9/jqWDvmuAQ5j+OlPC+6ipb6fjbYIfj62oLogWCBckD2ochhA6rzxcPFmwuEq82ei1291cPrl3dGooqUuDKmq4IbzN2iLoe9yq9Vn0uj7IyYs+TFe8Qt0oXKcEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nqeMJmXBY1yRU4Ji6KaFEhUYLoNCpwVo9tLo4vJEg6ddhXxQT/C6eidwYmar3EfhQsNDaIgCwbJpvI6p5PD9Vnhlc+d6e7P/VTJTsfO+4RYLlvGIFkSOSIEJHwAdEYWr8hR6zWOfe9b9zTYc1lkF3401VTExVDpj1ELRk2ETS5YENh4QR2RQuIyeMXZRcvI9qZx9fm41Jcy1QTW+hWx6tD8bMqJnP/UFFzN1jN8Czj0zqN/RqEMHGJYS+kktAgNVelFqWwPnD+5jxvErxHwRXyUAz04/vDP2jIqMqgGfoxV5Ta3SLWIsnqKUZfdtKkWbgiUgNTSvV1EAa+nKrOGbJOGnweec+t6ggsuOcyEgUzdhVdKYldsScrI9bg/ebEOC24xBE0J5nW67hCHCNeeH5itHRmPi7ya27Nfatt9XFMpOG1YVz34Xg+wLrHqeNUvM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 14:56:01.9835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc74c25a-ef9d-4e08-64fc-08de7ac751aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9664
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

Add five counters to the fdinfo for amdgpu device files.

They are:
amd-vmfault-counter: %llu
amd-queue-eviction-counter: %llu
amd-svm-migrate-counter: %llu
amd-svm-page-fault-counter: %llu
amd-svm-unmap-counter: %llu

These counters begin at 0 when a device file is opened.
They are for use by profiling applications.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 15 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    |  5 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 31 ++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     | 26 ++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c   |  6 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c       | 11 ++++++--
 7 files changed, 90 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index b349bb3676d5..96d6063ecaa8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -61,6 +61,7 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 	struct amdgpu_vm *vm = &fpriv->vm;
 
 	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
+	struct amdgpu_process_stats process_stats;
 	ktime_t usage[AMDGPU_HW_IP_NUM];
 	const char *pl_name[] = {
 		[TTM_PL_VRAM] = "vram",
@@ -74,7 +75,7 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 	};
 	unsigned int hw_ip, i;
 
-	amdgpu_vm_get_memory(vm, stats);
+	amdgpu_vm_get_memory(vm, stats, &process_stats);
 	amdgpu_ctx_mgr_usage(&fpriv->ctx_mgr, usage);
 
 	/*
@@ -114,6 +115,18 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 		   (stats[TTM_PL_TT].drm.shared +
 		    stats[TTM_PL_TT].drm.private) / 1024UL);
 
+	/* Amdgpu specific counters: */
+	drm_printf(p, "amd-vmfault-counter:\t%llu\n",
+		   process_stats.vmfault_counter);
+	drm_printf(p, "amd-queue-eviction-counter:\t%llu\n",
+		   process_stats.queue_eviction_counter);
+	drm_printf(p, "amd-svm-migrate-counter:\t%llu\n",
+		   process_stats.svm_migrate_counter);
+	drm_printf(p, "amd-svm-page-fault-counter:\t%llu\n",
+		   process_stats.svm_page_fault_counter);
+	drm_printf(p, "amd-svm-unmap-counter:\t%llu\n",
+		   process_stats.svm_unmap_counter);
+
 	for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
 		if (!usage[hw_ip])
 			continue;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 82bc6d657e5a..ad1042639dbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -476,6 +476,7 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
 	struct amdgpu_iv_entry entry;
 	unsigned int client_id, src_id;
 	struct amdgpu_irq_src *src;
+	struct amdgpu_vm *vm;
 	bool handled = false;
 	int r;
 
@@ -513,6 +514,10 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
 			client_id, src_id);
 
 	} else if ((src = adev->irq.client[client_id].sources[src_id])) {
+		vm = amdgpu_vm_get_vm_from_pasid(adev, entry.pasid);
+		if (vm)
+			amdgpu_vm_increment_process_counter(vm, AMDGPU_VM_VMFAULT_COUNTER);
+
 		r = src->funcs->process(adev, src, &entry);
 		if (r < 0)
 			dev_err(adev->dev, "error processing interrupt (%d)\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 001fcfcbde0f..9ba6f166cb5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1300,6 +1300,9 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 		queue = amdgpu_userq_get(uq_mgr, queue_id);
 		if (!queue)
 			continue;
+
+		amdgpu_vm_increment_process_counter(queue->fw_obj.obj->vm_bo->vm, AMDGPU_VM_QUEUE_EVICTION_COUNTER);
+
 		r = amdgpu_userq_preempt_helper(queue);
 		if (r)
 			ret = r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 01fef0e4f408..d7d82f23377f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1241,10 +1241,12 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 }
 
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
-			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
+			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM],
+			  struct amdgpu_process_stats *process_stats)
 {
 	spin_lock(&vm->status_lock);
 	memcpy(stats, vm->stats, sizeof(*stats) * __AMDGPU_PL_NUM);
+	memcpy(process_stats, &vm->process_stats, sizeof(*process_stats));
 	spin_unlock(&vm->status_lock);
 }
 
@@ -2472,7 +2474,7 @@ static void amdgpu_vm_destroy_task_info(struct kref *kref)
 	kfree(ti);
 }
 
-static inline struct amdgpu_vm *
+inline struct amdgpu_vm *
 amdgpu_vm_get_vm_from_pasid(struct amdgpu_device *adev, u32 pasid)
 {
 	struct amdgpu_vm *vm;
@@ -3234,3 +3236,28 @@ void amdgpu_sdma_set_vm_pte_scheds(struct amdgpu_device *adev,
 	adev->vm_manager.vm_pte_num_scheds = adev->sdma.num_instances;
 	adev->vm_manager.vm_pte_funcs = vm_pte_funcs;
 }
+
+void amdgpu_vm_increment_process_counter(struct amdgpu_vm *vm, enum amdgpu_process_stat_type stat_type)
+{
+	spin_lock(&vm->status_lock);
+	switch (stat_type) {
+	case AMDGPU_VM_VMFAULT_COUNTER:
+		vm->process_stats.vmfault_counter++;
+		break;
+	case AMDGPU_VM_QUEUE_EVICTION_COUNTER:
+		vm->process_stats.queue_eviction_counter++;
+		break;
+	case AMDGPU_VM_SVM_MIGRATE_COUNTER:
+		vm->process_stats.svm_migrate_counter++;
+		break;
+	case AMDGPU_VM_SVM_PAGE_FAULT_COUNTER:
+		vm->process_stats.svm_page_fault_counter++;
+		break;
+	case AMDGPU_VM_SVM_UNMAP_COUNTER:
+		vm->process_stats.svm_unmap_counter++;
+		break;
+	default:
+		pr_debug("unknown process stat type 0x%x\n", stat_type);
+	}
+	spin_unlock(&vm->status_lock);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index dc4b0ec672ec..4a63f0384c7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -334,6 +334,14 @@ struct amdgpu_mem_stats {
 	uint64_t evicted;
 };
 
+struct amdgpu_process_stats {
+	uint64_t vmfault_counter;
+	uint64_t queue_eviction_counter;
+	uint64_t svm_migrate_counter;
+	uint64_t svm_page_fault_counter;
+	uint64_t svm_unmap_counter;
+};
+
 struct amdgpu_vm {
 	/* tree of virtual addresses mapped */
 	struct rb_root_cached	va;
@@ -348,8 +356,9 @@ struct amdgpu_vm {
 	/* Lock to protect vm_bo add/del/move on all lists of vm */
 	spinlock_t		status_lock;
 
-	/* Memory statistics for this vm, protected by status_lock */
+	/* Statistics for this vm, protected by stats_lock */
 	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
+	struct amdgpu_process_stats process_stats;
 
 	/*
 	 * The following lists contain amdgpu_vm_bo_base objects for either
@@ -586,6 +595,8 @@ amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
 
 void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info);
 
+struct amdgpu_vm *amdgpu_vm_get_vm_from_pasid(struct amdgpu_device *adev, u32 pasid);
+
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    u32 vmid, u32 node_id, uint64_t addr, uint64_t ts,
 			    bool write_fault);
@@ -595,7 +606,8 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
 void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm);
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
-			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM]);
+			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM],
+			  struct amdgpu_process_stats *process_stats);
 
 int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       struct amdgpu_bo_vm *vmbo, bool immediate);
@@ -621,6 +633,16 @@ int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 
 bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *vm, struct amdgpu_bo *bo);
 
+enum amdgpu_process_stat_type {
+	AMDGPU_VM_VMFAULT_COUNTER,
+	AMDGPU_VM_QUEUE_EVICTION_COUNTER,
+	AMDGPU_VM_SVM_MIGRATE_COUNTER,
+	AMDGPU_VM_SVM_PAGE_FAULT_COUNTER,
+	AMDGPU_VM_SVM_UNMAP_COUNTER,
+};
+
+void amdgpu_vm_increment_process_counter(struct amdgpu_vm *vm, enum amdgpu_process_stat_type stat_type);
+
 /**
  * amdgpu_vm_tlb_seq - return tlb flush sequence number
  * @vm: the amdgpu_vm structure to query
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index b3d304aab686..c341b6842460 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -427,6 +427,9 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 				      start >> PAGE_SHIFT, end >> PAGE_SHIFT,
 				      0, node->id, prange->prefetch_loc,
 				      prange->preferred_loc, trigger);
+	pdd = svm_range_get_pdd_by_node(prange, node);
+	if (pdd)
+		amdgpu_vm_increment_process_counter(drm_priv_to_vm(pdd->drm_priv), AMDGPU_VM_SVM_MIGRATE_COUNTER);
 
 	r = migrate_vma_setup(&migrate);
 	if (r) {
@@ -729,6 +732,9 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 				      start >> PAGE_SHIFT, end >> PAGE_SHIFT,
 				      node->id, 0, prange->prefetch_loc,
 				      prange->preferred_loc, trigger);
+	pdd = svm_range_get_pdd_by_node(prange, node);
+	if (pdd)
+		amdgpu_vm_increment_process_counter(drm_priv_to_vm(pdd->drm_priv), AMDGPU_VM_SVM_MIGRATE_COUNTER);
 
 	r = migrate_vma_setup(&migrate);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index fcddb54a439f..499882a76581 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1375,9 +1375,11 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 	struct kfd_process_device *pdd;
 	struct dma_fence *fence = NULL;
 	struct kfd_process *p;
+	struct amdgpu_vm *vm;
 	uint32_t gpuidx;
 	int r = 0;
 
+
 	if (!prange->mapped_to_gpu) {
 		pr_debug("prange 0x%p [0x%lx 0x%lx] not mapped to GPU\n",
 			 prange, prange->start, prange->last);
@@ -1398,13 +1400,14 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 			pr_debug("failed to find device idx %d\n", gpuidx);
 			return -EINVAL;
 		}
+		vm = drm_priv_to_vm(pdd->drm_priv);
 
 		kfd_smi_event_unmap_from_gpu(pdd->dev, p->lead_thread->pid,
 					     start, last, trigger);
+		amdgpu_vm_increment_process_counter(vm, AMDGPU_VM_SVM_UNMAP_COUNTER);
 
 		r = svm_range_unmap_from_gpu(pdd->dev->adev,
-					     drm_priv_to_vm(pdd->drm_priv),
-					     start, last, &fence);
+					     vm, start, last, &fence);
 		if (r)
 			break;
 
@@ -3039,6 +3042,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	struct svm_range_list *svms;
 	struct svm_range *prange;
 	struct kfd_process *p;
+	struct kfd_process_device *pdd;
 	ktime_t timestamp = ktime_get_boottime();
 	struct kfd_node *node;
 	int32_t best_loc;
@@ -3193,6 +3197,9 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
 				       write_fault, timestamp);
+	pdd = svm_range_get_pdd_by_node(prange, node);
+	if (pdd)
+		amdgpu_vm_increment_process_counter(drm_priv_to_vm(pdd->drm_priv), AMDGPU_VM_SVM_MIGRATE_COUNTER);
 
 	/* Align migration range start and size to granularity size */
 	size = 1UL << prange->granularity;
-- 
2.34.1

