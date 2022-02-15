Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88B3C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 21:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 791AC10E4A8;
	Tue, 15 Feb 2022 21:23:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 332C810E1D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 21:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goIaiKXkhwJOPc+V7yTU7EwRAloGowqbIAeioUnH4e1sQNcj9E4owNJ+MFrLg+DhEnh0mnjKLHYvEQMQ49ny4YW7deSs549d3+qJPaLPCz0ZobDpDRBU2VleY0aW6AtaHX8+ec7n/cNrwBBh3CUmPMbjxUGkY5BRYjBeYqjOwtihiEnc3Y/7gHsW4c5JjqQAXiYLb90oy/3qhCtptxOwgrzZSUNJdwzO4e5Nolliqf8w/xh1XBV2rKiv9JwYJKSGY5mkLtWlfXs2e5m6/7WPR8uPREWkt7ra9DS8Nwbt2O0FCLDM/aNWRgph8MwQ+YSfQOEepjHGf4nBuNbm/KjMqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlSVZNHOoCsrWb29MYWdu2MCzUPaPPboNk3zIyxxxuw=;
 b=fyIgz3nM3Aj9SbhC2HdEtWub/aSNGIu0m+65F+/EhF3fjCWakCtwdoJwpsE16Y0N9VxRxBB9570ALJiKkhXeZYriDF17mBySymKyYsDAPyGEqCp4PvVo8BbMg55rqIawwXsdEpZFMpI1uvbj6pnISiRF3dvQv5K9rmBZxOFFrOGBnoXOZqrLqTrxttHBjnZT2xUMEdbHTiuZ11Fi3gA1tRerh24PM1W3/vbT5cg3+ptSQFvtqT241dg4no5Ob6AQq97oYC91lvK+vItkhFiACqJAcialtNR0yKEidD2nBS9gviPQFq1ajp2XGDVGz33sPLQioiEiG+Dklrmq94XpOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlSVZNHOoCsrWb29MYWdu2MCzUPaPPboNk3zIyxxxuw=;
 b=MT0sTIVqaRxOeXWrntLjLcLNO9ffzrqyY6P7q+J+40zdbNn1/sbawAdyWlugiriGmSeH2ml8y8Hqleqhq0PZb1r0zl6HxwYaHyZuMIk7hT1VsBlhSnUZnc2bySNczqB8aUqos3nzHpintKd3i2cC8JuYdTaff+AEFnT/NHpp33E=
Received: from CO2PR18CA0064.namprd18.prod.outlook.com (2603:10b6:104:2::32)
 by DM6PR12MB4515.namprd12.prod.outlook.com (2603:10b6:5:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 21:23:12 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::d5) by CO2PR18CA0064.outlook.office365.com
 (2603:10b6:104:2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Tue, 15 Feb 2022 21:23:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 21:23:11 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 15:23:05 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 6/8] drm/amdkfd: Add user queue eviction restore SMI event
Date: Tue, 15 Feb 2022 16:22:45 -0500
Message-ID: <20220215212247.16228-7-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215212247.16228-1-Philip.Yang@amd.com>
References: <20220215212247.16228-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7140e45e-4617-4883-7c81-08d9f0c95ec1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4515:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4515F5117812342EF80AFAAEE6349@DM6PR12MB4515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zM0oiJOEHWGu/tWSY+uKoKWDa03pIQN8pSrQoCzC7AIpLtC1ocsBW0oFRggj7eVvSH9vsHteEpFO27WGfmwrtjJYQfoEvxdo9cZSpWRWYRW1DShQiVmj2nHe0/a5RO//sXpyEcuPHdyfe9daqREOvU0o4MZ67FBaEK1bR1GQ/46MV3Fi+mygQcxbqu6Jcs0mUh2ruOnKdfaLbnZcoMI6oiiqByPwxWWrbroUjpuVei1lpBhlYdhZQSLI+fPE2dN2+dJrDNpbKLVyd5ZpiZeTKofEdXQ/MB6tBB2FH/cXKAW7Gbd9zuHg2DjWEYzgCYs+TBSyvRvFTpjQei5yjdsO0ADb1B+SrO4iOXqOnSIBToUSmxDRrnKl05hn8+q5aU0JmJfhMNAiyDhLEbt7orwItjMTFa+RSc5jJFUW0BetcIk+Fyhhxz9cR5l5nngcfqrFx5XZ9ivB9LD/N6fkNbsevLE+RdFVV5CTN3gfAyFojQ8DLunauten6BjmW5oaVh1ouKiDaUgUjpYtumiHkDgMS6Wejey89MbM+B7SVXlndOkrRN57GUgJMo36B/qUmJZUuADxz2y08Jj44jELdLnxVf9NBKvG7t+dCP9uFnI/mkqCyHPELoHuSitke7tbc8eVV0t2ZmZLN4AZzF73BG0FMlBshZLyQW1ry9pV6u0eUrCIyxfrJMQE4ah09mL9fz4VW42zuddecXP5nF9jv+vWrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70586007)(47076005)(83380400001)(508600001)(336012)(86362001)(8676002)(4326008)(36756003)(426003)(36860700001)(70206006)(54906003)(30864003)(316002)(16526019)(186003)(26005)(8936002)(6916009)(1076003)(81166007)(356005)(2616005)(2906002)(6666004)(82310400004)(5660300002)(7696005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 21:23:11.6592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7140e45e-4617-4883-7c81-08d9f0c95ec1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4515
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
triggered by svm or userptr MMU notifier, TTM eviction, device suspend
and CRIU checkpoint and restore.

User queue restore may be rescheduled if eviction happens again while
restore.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 12 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 15 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   | 55 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h   |  4 ++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  6 +-
 9 files changed, 89 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 4cb14c2fe53f..96fe792a4e51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -332,7 +332,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
 }
 #endif
 /* KGD2KFD callbacks */
-int kgd2kfd_quiesce_mm(struct mm_struct *mm);
+int kgd2kfd_quiesce_mm(struct mm_struct *mm, uint32_t trigger);
 int kgd2kfd_resume_mm(struct mm_struct *mm);
 int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
 						struct dma_fence *fence);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index cd89d2e46852..748ccc9681e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -32,6 +32,7 @@
 #include "amdgpu_dma_buf.h"
 #include <uapi/linux/kfd_ioctl.h>
 #include "amdgpu_xgmi.h"
+#include "kfd_smi_events.h"
 
 /* Userptr restore delay, just long enough to allow consecutive VM
  * changes to accumulate
@@ -2113,7 +2114,7 @@ int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem,
 	evicted_bos = atomic_inc_return(&process_info->evicted_bos);
 	if (evicted_bos == 1) {
 		/* First eviction, stop the queues */
-		r = kgd2kfd_quiesce_mm(mm);
+		r = kgd2kfd_quiesce_mm(mm, KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
 		if (r)
 			pr_err("Failed to quiesce KFD\n");
 		schedule_delayed_work(&process_info->restore_userptr_work,
@@ -2387,13 +2388,16 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 
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
+		kfd_smi_event_queue_restore_rescheduled(mm);
+	}
+	mmput(mm);
+	put_task_struct(usertask);
 }
 
 /** amdgpu_amdkfd_gpuvm_restore_process_bos - Restore all BOs for the given
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 965af2a08bc0..c53b0798a35f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2404,7 +2404,7 @@ static int criu_restore(struct file *filep,
 	 * Set the process to evicted state to avoid running any new queues before all the memory
 	 * mappings are ready.
 	 */
-	ret = kfd_process_evict_queues(p);
+	ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_CRIU_RESTORE);
 	if (ret)
 		goto exit_unlock;
 
@@ -2523,7 +2523,7 @@ static int criu_process_info(struct file *filep,
 		goto err_unlock;
 	}
 
-	ret = kfd_process_evict_queues(p);
+	ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_CRIU_CHECKPOINT);
 	if (ret)
 		goto err_unlock;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 339e12c94cff..5de590eeec26 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -785,7 +785,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
 	spin_unlock_irqrestore(&kfd->interrupt_lock, flags);
 }
 
-int kgd2kfd_quiesce_mm(struct mm_struct *mm)
+int kgd2kfd_quiesce_mm(struct mm_struct *mm, uint32_t trigger)
 {
 	struct kfd_process *p;
 	int r;
@@ -799,7 +799,7 @@ int kgd2kfd_quiesce_mm(struct mm_struct *mm)
 		return -ESRCH;
 
 	WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
-	r = kfd_process_evict_queues(p);
+	r = kfd_process_evict_queues(p, trigger);
 
 	kfd_unref_process(p);
 	return r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 3e44c045d4aa..71822c95eb14 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -933,7 +933,7 @@ static inline struct kfd_process_device *kfd_process_device_from_gpuidx(
 }
 
 void kfd_unref_process(struct kfd_process *p);
-int kfd_process_evict_queues(struct kfd_process *p);
+int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger);
 int kfd_process_restore_queues(struct kfd_process *p);
 void kfd_suspend_all_processes(void);
 int kfd_resume_all_processes(void);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 59c04b2d383b..57ac7660e0c5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -43,6 +43,7 @@ struct mm_struct;
 #include "kfd_device_queue_manager.h"
 #include "kfd_iommu.h"
 #include "kfd_svm.h"
+#include "kfd_smi_events.h"
 
 /*
  * List of struct kfd_process (field kfd_process).
@@ -1710,7 +1711,7 @@ struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm)
  * Eviction is reference-counted per process-device. This means multiple
  * evictions from different sources can be nested safely.
  */
-int kfd_process_evict_queues(struct kfd_process *p)
+int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger)
 {
 	int r = 0;
 	int i;
@@ -1719,6 +1720,9 @@ int kfd_process_evict_queues(struct kfd_process *p)
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 
+		kfd_smi_event_queue_eviction(pdd->dev, p->lead_thread->pid,
+					     trigger);
+
 		r = pdd->dev->dqm->ops.evict_process_queues(pdd->dev->dqm,
 							    &pdd->qpd);
 		/* evict return -EIO if HWS is hang or asic is resetting, in this case
@@ -1743,6 +1747,9 @@ int kfd_process_evict_queues(struct kfd_process *p)
 
 		if (n_evicted == 0)
 			break;
+
+		kfd_smi_event_queue_restore(pdd->dev, p->lead_thread->pid);
+
 		if (pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
 							      &pdd->qpd))
 			pr_err("Failed to restore queues\n");
@@ -1762,6 +1769,8 @@ int kfd_process_restore_queues(struct kfd_process *p)
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 
+		kfd_smi_event_queue_restore(pdd->dev, p->lead_thread->pid);
+
 		r = pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
 							      &pdd->qpd);
 		if (r) {
@@ -1823,7 +1832,7 @@ static void evict_process_worker(struct work_struct *work)
 	flush_delayed_work(&p->restore_work);
 
 	pr_debug("Started evicting pasid 0x%x\n", p->pasid);
-	ret = kfd_process_evict_queues(p);
+	ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_TTM);
 	if (!ret) {
 		dma_fence_signal(p->ef);
 		dma_fence_put(p->ef);
@@ -1890,7 +1899,7 @@ void kfd_suspend_all_processes(void)
 		cancel_delayed_work_sync(&p->eviction_work);
 		cancel_delayed_work_sync(&p->restore_work);
 
-		if (kfd_process_evict_queues(p))
+		if (kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SUSPEND))
 			pr_err("Failed to suspend process 0x%x\n", p->pasid);
 		dma_fence_signal(p->ef);
 		dma_fence_put(p->ef);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 6d2f56a4773e..2ee092f90f16 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -342,6 +342,61 @@ void kfd_smi_event_migration_end(struct kfd_dev *dev, pid_t pid,
 	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_MIGRATE_END, fifo_in, len);
 }
 
+void kfd_smi_event_queue_eviction(struct kfd_dev *dev, pid_t pid,
+				  uint32_t trigger)
+{
+	char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
+	int len;
+
+	if (list_empty(&dev->smi_clients))
+		return;
+
+	len = snprintf(fifo_in, sizeof(fifo_in), "%x %lld -%d %x %d\n",
+		       KFD_SMI_EVENT_QUEUE_EVICTION, ktime_get_boottime_ns(),
+		       pid, dev->id, trigger);
+
+	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_QUEUE_EVICTION, fifo_in, len);
+}
+
+void kfd_smi_event_queue_restore(struct kfd_dev *dev, pid_t pid)
+{
+	char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
+	int len;
+
+	if (list_empty(&dev->smi_clients))
+		return;
+
+	len = snprintf(fifo_in, sizeof(fifo_in), "%x %lld -%d %x\n",
+		       KFD_SMI_EVENT_QUEUE_RESTORE, ktime_get_boottime_ns(),
+		       pid, dev->id);
+
+	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_QUEUE_RESTORE, fifo_in, len);
+}
+
+void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
+{
+	struct kfd_process *p;
+	char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
+	int len;
+	int i;
+
+	p = kfd_lookup_process_by_mm(mm);
+	if (!p)
+		return;
+
+	for (i = 0; i < p->n_pdds; i++) {
+		struct kfd_process_device *pdd = p->pdds[i];
+
+		len = snprintf(fifo_in, sizeof(fifo_in), "%x %lld -%d %x %c\n",
+			       KFD_SMI_EVENT_QUEUE_RESTORE,
+			       ktime_get_boottime_ns(), p->lead_thread->pid,
+			       pdd->dev->id, 'R');
+		add_event_to_kfifo(p->lead_thread->pid, pdd->dev,
+				   KFD_SMI_EVENT_QUEUE_RESTORE, fifo_in, len);
+	}
+	kfd_unref_process(p);
+}
+
 int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
 {
 	struct kfd_smi_client *client;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index ec5d74a2fef4..b23292637239 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -42,4 +42,8 @@ void kfd_smi_event_migration_start(struct kfd_dev *dev, pid_t pid,
 void kfd_smi_event_migration_end(struct kfd_dev *dev, pid_t pid,
 			     unsigned long start, unsigned long end,
 			     uint32_t from, uint32_t to, uint32_t trigger);
+void kfd_smi_event_queue_eviction(struct kfd_dev *dev, pid_t pid,
+				  uint32_t trigger);
+void kfd_smi_event_queue_restore(struct kfd_dev *dev, pid_t pid);
+void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm);
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 35b2a0f63521..1833ee7bcd95 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1706,14 +1706,16 @@ static void svm_range_restore_work(struct work_struct *work)
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
+		kfd_smi_event_queue_restore_rescheduled(mm);
 	}
+	mmput(mm);
 }
 
 /**
@@ -1769,7 +1771,7 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 			 prange->svms, prange->start, prange->last);
 
 		/* First eviction, stop the queues */
-		r = kgd2kfd_quiesce_mm(mm);
+		r = kgd2kfd_quiesce_mm(mm, KFD_QUEUE_EVICTION_TRIGGER_SVM);
 		if (r)
 			pr_debug("failed to quiesce KFD\n");
 
-- 
2.17.1

