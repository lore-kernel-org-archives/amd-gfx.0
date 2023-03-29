Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA866C6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16D9910EC33;
	Wed, 29 Mar 2023 20:14:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E0BD10EC38
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:14:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJ8wMU5NqWOc0W5sbdp6wVQgNa+s3TyWrdRsEzym5E2wxGJ1dqJBJIfsnbqDnusK2rHUv/b9n+CqmPAFD9DPpVYDCyXGxLs5/RTpoga/Eiu26jqkA6gU5soPbhUEq8KrAppS9d5SEZMMuqYc0kZxybDrcCEsJb5bberkKJva3yrytGhEyEJ0QPtT8y7I2qlT08eYMXAbi9pCtlQOjBMk+ac4BUIZASTVTNeEOFAM0NlHYmCBI+7TCW2YECuZU5RoV8pJ/kdXHMPZVuuutKDvW2UZ0wLN3eyGeyRaXQKq+Mft+d4bx/MVXyN84kyJmOAvSYfuZVIGOqvzDeiXIL7C4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cW0XRFCw3MvBW90U1CA+tGSbK5heIZUAbb40S5y1cvA=;
 b=Q++ReaFCdAZM4k5lnPNELXswpIfw9YyKSqZ216/hovfel1wWaxbdYa79ky1zU/yjLBpJl4v7xjdQ5N5tO1CdwhTlj2RsoVgDqr7RyRJySDYdSh5ZNsKvZUwtTR9e82+QDQ6/veV+J6jXNWmWzIhNKdUHuVgI1oOgJZUvsoQ272sa6th4DAl3WLVbjAvOPCfT4zMeSPY1EZ/njHUIc7eLj3mmtlxibWCIxk8pQp5I5qXFJfVjKhQ0tZMGd9XNz+VKGpdx3TRH3WCaFjtxazkU8HNP3Jn0QRxaUiTPC1uwoPgzKLJWNRMJRbsOSqE+3/g2osk68usGFd2mBtjiM5OkWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cW0XRFCw3MvBW90U1CA+tGSbK5heIZUAbb40S5y1cvA=;
 b=R7OBnKwuSFpgkDevWHD0z+yiwF1gC3TDcaEN2IrkBYnxYB8MCosAT41CA+xUfjJhBDvlmRhSZPuAT5ZG49QkuDmt+hlKgVOJCCoyTH97CNwnXGTd8eZ939TLu5l94xnPkX0gED1EOVOjloQ8roBVdlSq32QskoTn9VSxjtqnsOw=
Received: from MW2PR2101CA0029.namprd21.prod.outlook.com (2603:10b6:302:1::42)
 by CH3PR12MB7619.namprd12.prod.outlook.com (2603:10b6:610:14b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Wed, 29 Mar
 2023 20:14:47 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::24) by MW2PR2101CA0029.outlook.office365.com
 (2603:10b6:302:1::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18 via Frontend
 Transport; Wed, 29 Mar 2023 20:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Wed, 29 Mar 2023 20:14:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:14:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/14] drm/amdkfd: Update SMI events for GFX9.4.3
Date: Wed, 29 Mar 2023 16:14:16 -0400
Message-ID: <20230329201426.1982669-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329201426.1982669-1-alexander.deucher@amd.com>
References: <20230329201426.1982669-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|CH3PR12MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b99c210-ed75-4918-4cd9-08db30923de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7msTp2YYu+dFPQMdiRkVt9Ib484JdPMM+zzlz4u9vBHv58LoQn4IHwtS+MvC0Mvk2j8+3kZOMN11PyHKUsz66bBaygDQiULbezob2eWGbq+x+L9x0KfioUc5wJkaO1arp8MIMsbJDHC96cE5BCStZ0EPPbSRpIDrvn40GQc/5L3PddUqXyYKAU9hWxknIB/6RFYY4d92dPxhFP89CSp1Fnmg0UnfhCxlmqufu1W9ScL4X4RrenYGAdd8Pw8HVQ8qUH0E8Sfdg5lb7zTzDGPLAIwHn5Gg+rMrwTbvg2JP+38VA7IJNDIUTkE41L2dhpr1O4Tw+94hKOeS1jUhuorpdiSWUzP0BnaJQNt5u7ctQl6V5hQwIrzW9BJ7x+6EOlZw+Wy9+sA+X5AthUip5Ym4XiXtxmneBU5R5pVZdMhyH3S02/ygBLxJUkHvv+XmY0KH8W6Tp2tgSJXLxUc6uWOxKR9E6GGftF6zSBFOE40RkvEkGDJAGrxvYJUDfsQsxW/poBrtETeSlySp1KcYHx9sRieOAIF15RMg3avDmVPsevPsdcT51IVcrdxIkbUhHDcF4OdMuRScUHmxOSO14SAL9sIPLCPII/BE+GnuSLwU8PS547AusCrXuMz3h2Iccoto3mtqs+1TTU8VpIV/0w7D6yz8RjFNoqpA/v0oCrSAUpzvzH3IvPS7vqGkf6kMT1MT/fv9TPLhu+OMCUdrHyUy0TXamxEG5EAZRMHia7UaWU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(82740400003)(70206006)(40480700001)(86362001)(8936002)(70586007)(7696005)(478600001)(81166007)(8676002)(54906003)(36860700001)(316002)(4326008)(2906002)(36756003)(6666004)(40460700003)(47076005)(6916009)(5660300002)(82310400005)(336012)(41300700001)(2616005)(26005)(83380400001)(186003)(16526019)(1076003)(30864003)(356005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:14:46.3381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b99c210-ed75-4918-4cd9-08db30923de4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7619
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

On GFX 9.4.3, there can be multiple KFD nodes. As a result,
SMI events for SVM, queue evict/restore should be raised for
each node independently.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    | 16 ++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_process.c    |  6 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 38 ++++++++++-----------
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h | 14 ++++----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c        |  6 ++--
 5 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index e7e5abc32c84..42e599912e52 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -423,9 +423,9 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	migrate.dst = migrate.src + npages;
 	scratch = (dma_addr_t *)(migrate.dst + npages);
 
-	kfd_smi_event_migration_start(adev->kfd.dev, p->lead_thread->pid,
+	kfd_smi_event_migration_start(node, p->lead_thread->pid,
 				      start >> PAGE_SHIFT, end >> PAGE_SHIFT,
-				      0, adev->kfd.dev->nodes[0]->id, prange->prefetch_loc,
+				      0, node->id, prange->prefetch_loc,
 				      prange->preferred_loc, trigger);
 
 	r = migrate_vma_setup(&migrate);
@@ -456,9 +456,9 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
 
-	kfd_smi_event_migration_end(adev->kfd.dev, p->lead_thread->pid,
+	kfd_smi_event_migration_end(node, p->lead_thread->pid,
 				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
-				    0, adev->kfd.dev->nodes[0]->id, trigger);
+				    0, node->id, trigger);
 
 	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
 	svm_range_free_dma_mappings(prange);
@@ -702,9 +702,9 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	migrate.fault_page = fault_page;
 	scratch = (dma_addr_t *)(migrate.dst + npages);
 
-	kfd_smi_event_migration_start(adev->kfd.dev, p->lead_thread->pid,
+	kfd_smi_event_migration_start(node, p->lead_thread->pid,
 				      start >> PAGE_SHIFT, end >> PAGE_SHIFT,
-				      adev->kfd.dev->nodes[0]->id, 0, prange->prefetch_loc,
+				      node->id, 0, prange->prefetch_loc,
 				      prange->preferred_loc, trigger);
 
 	r = migrate_vma_setup(&migrate);
@@ -738,9 +738,9 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
 
-	kfd_smi_event_migration_end(adev->kfd.dev, p->lead_thread->pid,
+	kfd_smi_event_migration_end(node, p->lead_thread->pid,
 				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
-				    adev->kfd.dev->nodes[0]->id, 0, trigger);
+				    node->id, 0, trigger);
 
 	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 273002466dd9..0a9103326157 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1817,7 +1817,7 @@ int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger)
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 
-		kfd_smi_event_queue_eviction(pdd->dev->kfd, p->lead_thread->pid,
+		kfd_smi_event_queue_eviction(pdd->dev, p->lead_thread->pid,
 					     trigger);
 
 		r = pdd->dev->dqm->ops.evict_process_queues(pdd->dev->dqm,
@@ -1845,7 +1845,7 @@ int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger)
 		if (n_evicted == 0)
 			break;
 
-		kfd_smi_event_queue_restore(pdd->dev->kfd, p->lead_thread->pid);
+		kfd_smi_event_queue_restore(pdd->dev, p->lead_thread->pid);
 
 		if (pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
 							      &pdd->qpd))
@@ -1866,7 +1866,7 @@ int kfd_process_restore_queues(struct kfd_process *p)
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 
-		kfd_smi_event_queue_restore(pdd->dev->kfd, p->lead_thread->pid);
+		kfd_smi_event_queue_restore(pdd->dev, p->lead_thread->pid);
 
 		r = pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
 							      &pdd->qpd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index b703da59e067..d9953c2b2661 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -250,58 +250,58 @@ void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
 			  task_info.pid, task_info.task_name);
 }
 
-void kfd_smi_event_page_fault_start(struct kfd_dev *dev, pid_t pid,
+void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
 				    unsigned long address, bool write_fault,
 				    ktime_t ts)
 {
-	kfd_smi_event_add(pid, dev->nodes[0], KFD_SMI_EVENT_PAGE_FAULT_START,
+	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_PAGE_FAULT_START,
 			  "%lld -%d @%lx(%x) %c\n", ktime_to_ns(ts), pid,
-			  address, dev->nodes[0]->id, write_fault ? 'W' : 'R');
+			  address, node->id, write_fault ? 'W' : 'R');
 }
 
-void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t pid,
+void kfd_smi_event_page_fault_end(struct kfd_node *node, pid_t pid,
 				  unsigned long address, bool migration)
 {
-	kfd_smi_event_add(pid, dev->nodes[0], KFD_SMI_EVENT_PAGE_FAULT_END,
+	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_PAGE_FAULT_END,
 			  "%lld -%d @%lx(%x) %c\n", ktime_get_boottime_ns(),
-			  pid, address, dev->nodes[0]->id, migration ? 'M' : 'U');
+			  pid, address, node->id, migration ? 'M' : 'U');
 }
 
-void kfd_smi_event_migration_start(struct kfd_dev *dev, pid_t pid,
+void kfd_smi_event_migration_start(struct kfd_node *node, pid_t pid,
 				   unsigned long start, unsigned long end,
 				   uint32_t from, uint32_t to,
 				   uint32_t prefetch_loc, uint32_t preferred_loc,
 				   uint32_t trigger)
 {
-	kfd_smi_event_add(pid, dev->nodes[0], KFD_SMI_EVENT_MIGRATE_START,
+	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_MIGRATE_START,
 			  "%lld -%d @%lx(%lx) %x->%x %x:%x %d\n",
 			  ktime_get_boottime_ns(), pid, start, end - start,
 			  from, to, prefetch_loc, preferred_loc, trigger);
 }
 
-void kfd_smi_event_migration_end(struct kfd_dev *dev, pid_t pid,
+void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,
 				 unsigned long start, unsigned long end,
 				 uint32_t from, uint32_t to, uint32_t trigger)
 {
-	kfd_smi_event_add(pid, dev->nodes[0], KFD_SMI_EVENT_MIGRATE_END,
+	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_MIGRATE_END,
 			  "%lld -%d @%lx(%lx) %x->%x %d\n",
 			  ktime_get_boottime_ns(), pid, start, end - start,
 			  from, to, trigger);
 }
 
-void kfd_smi_event_queue_eviction(struct kfd_dev *dev, pid_t pid,
+void kfd_smi_event_queue_eviction(struct kfd_node *node, pid_t pid,
 				  uint32_t trigger)
 {
-	kfd_smi_event_add(pid, dev->nodes[0], KFD_SMI_EVENT_QUEUE_EVICTION,
+	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_EVICTION,
 			  "%lld -%d %x %d\n", ktime_get_boottime_ns(), pid,
-			  dev->nodes[0]->id, trigger);
+			  node->id, trigger);
 }
 
-void kfd_smi_event_queue_restore(struct kfd_dev *dev, pid_t pid)
+void kfd_smi_event_queue_restore(struct kfd_node *node, pid_t pid)
 {
-	kfd_smi_event_add(pid, dev->nodes[0], KFD_SMI_EVENT_QUEUE_RESTORE,
+	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_RESTORE,
 			  "%lld -%d %x\n", ktime_get_boottime_ns(), pid,
-			  dev->nodes[0]->id);
+			  node->id);
 }
 
 void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
@@ -324,13 +324,13 @@ void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
 	kfd_unref_process(p);
 }
 
-void kfd_smi_event_unmap_from_gpu(struct kfd_dev *dev, pid_t pid,
+void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, pid_t pid,
 				  unsigned long address, unsigned long last,
 				  uint32_t trigger)
 {
-	kfd_smi_event_add(pid, dev->nodes[0], KFD_SMI_EVENT_UNMAP_FROM_GPU,
+	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_UNMAP_FROM_GPU,
 			  "%lld -%d @%lx(%lx) %x %d\n", ktime_get_boottime_ns(),
-			  pid, address, last - address + 1, dev->nodes[0]->id, trigger);
+			  pid, address, last - address + 1, node->id, trigger);
 }
 
 int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index 59cd089f80d1..fa95c2dfd587 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -29,24 +29,24 @@ void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid);
 void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
 					     uint64_t throttle_bitmask);
 void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset);
-void kfd_smi_event_page_fault_start(struct kfd_dev *dev, pid_t pid,
+void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
 				    unsigned long address, bool write_fault,
 				    ktime_t ts);
-void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t pid,
+void kfd_smi_event_page_fault_end(struct kfd_node *node, pid_t pid,
 				  unsigned long address, bool migration);
-void kfd_smi_event_migration_start(struct kfd_dev *dev, pid_t pid,
+void kfd_smi_event_migration_start(struct kfd_node *node, pid_t pid,
 			     unsigned long start, unsigned long end,
 			     uint32_t from, uint32_t to,
 			     uint32_t prefetch_loc, uint32_t preferred_loc,
 			     uint32_t trigger);
-void kfd_smi_event_migration_end(struct kfd_dev *dev, pid_t pid,
+void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,
 			     unsigned long start, unsigned long end,
 			     uint32_t from, uint32_t to, uint32_t trigger);
-void kfd_smi_event_queue_eviction(struct kfd_dev *dev, pid_t pid,
+void kfd_smi_event_queue_eviction(struct kfd_node *node, pid_t pid,
 				  uint32_t trigger);
-void kfd_smi_event_queue_restore(struct kfd_dev *dev, pid_t pid);
+void kfd_smi_event_queue_restore(struct kfd_node *node, pid_t pid);
 void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm);
-void kfd_smi_event_unmap_from_gpu(struct kfd_dev *dev, pid_t pid,
+void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, pid_t pid,
 				  unsigned long address, unsigned long last,
 				  uint32_t trigger);
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b3c10d8fbe0b..0e2b21ec468c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1271,7 +1271,7 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 			return -EINVAL;
 		}
 
-		kfd_smi_event_unmap_from_gpu(pdd->dev->kfd, p->lead_thread->pid,
+		kfd_smi_event_unmap_from_gpu(pdd->dev, p->lead_thread->pid,
 					     start, last, trigger);
 
 		r = svm_range_unmap_from_gpu(pdd->dev->adev,
@@ -2923,7 +2923,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		 svms, prange->start, prange->last, best_loc,
 		 prange->actual_loc);
 
-	kfd_smi_event_page_fault_start(adev->kfd.dev, p->lead_thread->pid, addr,
+	kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
 				       write_fault, timestamp);
 
 	if (prange->actual_loc != best_loc) {
@@ -2961,7 +2961,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
 			 r, svms, prange->start, prange->last);
 
-	kfd_smi_event_page_fault_end(adev->kfd.dev, p->lead_thread->pid, addr,
+	kfd_smi_event_page_fault_end(node, p->lead_thread->pid, addr,
 				     migration);
 
 out_unlock_range:
-- 
2.39.2

