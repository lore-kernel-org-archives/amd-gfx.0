Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF41CCA479
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 14:51:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E4710F9D4;
	Tue, 28 Jun 2022 14:51:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 416D210F9FB
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 14:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNJCQ2nn2t/H2bzmNlAYi0Xy75PjvdRFYVpRJAaHBfEX92NgY59G0nZNq5u/FSU8rycy+uRCTiQ8xBntrd04V9+xiDSDcqRBokRH9J4WBiAZfMq7/qap6xzM7eHT9aVOlRwfEA3ZgbIps3x4rqI9Yzy/zkpHBaj3PmFXrCGtmd9SlRl/Lc1xsGkt+EnI6JWa2ADyL5urQcSqFVrA0bLa0PXxuc3V0zoRYLuTaZmjAwx4MbJqlp4hggfpUV68WWZlINMzZJz/Tap7EjjMflJyIUqQvLlUlfAZJzZbDb6MIQublPXf7hNVbu/oy1IHWvD4mLU5HN7AjM6OiiygwPIjpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NFKsChvSeVEzrJd3PvhuqMpgx4paW1RY6d7uBmX8Wk=;
 b=jhYlI8iE/ZZYkp6+hnkHTdq/ymHhFziTlbT1XheN0fUjHch3PaZzzl7dkBDQK9w/jodEO8G32JgqjFpX4aV4UuAJ9kZOJlqT7O80fvk2NNcXDEuA/RhPBT5+1vw/tTOIymdxOYuc4VBXK6CWT+CcKOgMDoIFWPpX9oGIvgn4qLK1+h/zzDxbqXsVTTbbPdzRbkynICI+IQuDUeLv+ZPzPOqf91qZEV4lta+p2qsNwK9iCKMwRx9qMqaJpf16EE8ejiuI/AlYqadNpvzhVyDiIJN6YzBJ8gO0Yib8fgoUfrS8acDnttpYbZbUZoQ9SASDbQFAUPfH2x01mc7P73F6vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NFKsChvSeVEzrJd3PvhuqMpgx4paW1RY6d7uBmX8Wk=;
 b=ErZJ27HEK5as+JPae1hh9M2TNEYGM36ajWbBg4R0qWcA+Vj8tnzPSDHney6cRZr2k7vIc09MKM2CrZ0UopH6qUejl2KTCJOT6SlwYl0M1VG+NhzX2WqLUw986KHC6mvCywrjaUTrQBccwONZh6Rb3vK50B7zNfBGvLzjHuNhRr0=
Received: from MWHPR17CA0095.namprd17.prod.outlook.com (2603:10b6:300:c2::33)
 by BYAPR12MB3237.namprd12.prod.outlook.com (2603:10b6:a03:13a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Tue, 28 Jun
 2022 14:51:27 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2::4) by MWHPR17CA0095.outlook.office365.com
 (2603:10b6:300:c2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Tue, 28 Jun 2022 14:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 14:51:27 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 09:51:21 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 5/11] drm/amdkfd: Add user queue eviction restore SMI event
Date: Tue, 28 Jun 2022 10:50:14 -0400
Message-ID: <20220628145020.26925-6-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628145020.26925-1-Philip.Yang@amd.com>
References: <20220628145020.26925-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb5ae5ed-77ed-4161-b186-08da5915ae21
X-MS-TrafficTypeDiagnostic: BYAPR12MB3237:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tnE2toJmFDsT6BiI1kA7lXETUGpNbCpuIz4RvRCZW/uiLXfCzJ/2I9NnQ6lMy7F9XJGWqW2OmT/2D8uzphMRojixrZcAT5hlh5DNhB9ee2QgM+OSWy1Rbe8bc0bGjKWsJ7d4Q/JDNk41UhX5gnG9gNMgMHIt+VWKWoNOrU6x2UR0YhdJRhGXeljK9pW9F+4x3jsgSn41JbyqNNbGXGR6BYwE++yKnpvKHc37xEI0Ff91Lo8RSMLMimH4lyePOFufyvSo86ScBt85EvwMSXsPuJQl2uNGSexB/bcQyRa4oFPHgJ67eseQ9y8aRTUMn9OGvRKYoXsn/ABOnptASb+Ggjyz13eGCujyCf356vUaBBnl1dwFN/sR/jcSt8guAVNvcst3GgvKxUaN31cXHV6NTakT/yvmXva3Q4BrU+uBM6P7QBwkEjD4AzCqxpjjCisZ8/MzU/NZBYJVE6voqVN5tPD7NbF+21cACZs52H4yD3nn27nuiPWKI7soJanrOhpuONnoA3pdUyF5w9wyjAwKEpR1VQItF4iM3UgaNUF9Fyst7JPxnchxKFhq+I7Jh8S9lDi1I95gccPihvq6DYvtWCdzfN/i2Jgn7boFoIAKoH0VKAkalVD6MveKMSpurMcYKU7uaFv6KrSSOuxfguBat6y5cbRVeXTFEZUsc8aANrl9pOaDNTlzOYag1edGlgpU3I9wk2gv0IxLKwmb9pO84zy1n4aFO7+VLWfF1DABrCH3mwxqweUu3Y4Iw87zFG/OsIbLTcYK+8dxFaYTDihluUmdrsnQS/dUgF0h3WWk1aQgDyWz+ojy33hw1e3KhVRPkKQcHQMFF+5uS5Prgdra4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(136003)(46966006)(36840700001)(40470700004)(54906003)(316002)(82310400005)(7696005)(40480700001)(478600001)(81166007)(6916009)(41300700001)(82740400003)(186003)(8676002)(356005)(70206006)(86362001)(16526019)(5660300002)(36756003)(83380400001)(2906002)(426003)(36860700001)(8936002)(70586007)(4326008)(1076003)(40460700003)(2616005)(26005)(6666004)(30864003)(47076005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 14:51:27.5100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5ae5ed-77ed-4161-b186-08da5915ae21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3237
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
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
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 12 ++++---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  4 +--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  4 +--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 15 ++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   | 35 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h   |  4 +++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  6 ++--
 9 files changed, 69 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index b25b41f50213..73bf8b5f2aa9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -336,7 +336,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
 }
 #endif
 /* KGD2KFD callbacks */
-int kgd2kfd_quiesce_mm(struct mm_struct *mm);
+int kgd2kfd_quiesce_mm(struct mm_struct *mm, uint32_t trigger);
 int kgd2kfd_resume_mm(struct mm_struct *mm);
 int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
 						struct dma_fence *fence);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 5ba9070d8722..6a7e045ddcc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -32,6 +32,7 @@
 #include "amdgpu_dma_buf.h"
 #include <uapi/linux/kfd_ioctl.h>
 #include "amdgpu_xgmi.h"
+#include "kfd_smi_events.h"
 
 /* Userptr restore delay, just long enough to allow consecutive VM
  * changes to accumulate
@@ -2381,7 +2382,7 @@ int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem,
 	evicted_bos = atomic_inc_return(&process_info->evicted_bos);
 	if (evicted_bos == 1) {
 		/* First eviction, stop the queues */
-		r = kgd2kfd_quiesce_mm(mm);
+		r = kgd2kfd_quiesce_mm(mm, KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
 		if (r)
 			pr_err("Failed to quiesce KFD\n");
 		schedule_delayed_work(&process_info->restore_userptr_work,
@@ -2655,13 +2656,16 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 
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
index a0246b4bae6b..6abfe10229a2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2428,7 +2428,7 @@ static int criu_restore(struct file *filep,
 	 * Set the process to evicted state to avoid running any new queues before all the memory
 	 * mappings are ready.
 	 */
-	ret = kfd_process_evict_queues(p);
+	ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_CRIU_RESTORE);
 	if (ret)
 		goto exit_unlock;
 
@@ -2547,7 +2547,7 @@ static int criu_process_info(struct file *filep,
 		goto err_unlock;
 	}
 
-	ret = kfd_process_evict_queues(p);
+	ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_CRIU_CHECKPOINT);
 	if (ret)
 		goto err_unlock;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index c8fee0dbfdcb..6ec0e9f0927d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -837,7 +837,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
 	spin_unlock_irqrestore(&kfd->interrupt_lock, flags);
 }
 
-int kgd2kfd_quiesce_mm(struct mm_struct *mm)
+int kgd2kfd_quiesce_mm(struct mm_struct *mm, uint32_t trigger)
 {
 	struct kfd_process *p;
 	int r;
@@ -851,7 +851,7 @@ int kgd2kfd_quiesce_mm(struct mm_struct *mm)
 		return -ESRCH;
 
 	WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
-	r = kfd_process_evict_queues(p);
+	r = kfd_process_evict_queues(p, trigger);
 
 	kfd_unref_process(p);
 	return r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 59ba50ce54d3..b9e7e9c52853 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -946,7 +946,7 @@ static inline struct kfd_process_device *kfd_process_device_from_gpuidx(
 }
 
 void kfd_unref_process(struct kfd_process *p);
-int kfd_process_evict_queues(struct kfd_process *p);
+int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger);
 int kfd_process_restore_queues(struct kfd_process *p);
 void kfd_suspend_all_processes(void);
 int kfd_resume_all_processes(void);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index a13e60d48b73..fc38a4d81420 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -43,6 +43,7 @@ struct mm_struct;
 #include "kfd_device_queue_manager.h"
 #include "kfd_iommu.h"
 #include "kfd_svm.h"
+#include "kfd_smi_events.h"
 
 /*
  * List of struct kfd_process (field kfd_process).
@@ -1736,7 +1737,7 @@ struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm)
  * Eviction is reference-counted per process-device. This means multiple
  * evictions from different sources can be nested safely.
  */
-int kfd_process_evict_queues(struct kfd_process *p)
+int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger)
 {
 	int r = 0;
 	int i;
@@ -1745,6 +1746,9 @@ int kfd_process_evict_queues(struct kfd_process *p)
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 
+		kfd_smi_event_queue_eviction(pdd->dev, p->lead_thread->pid,
+					     trigger);
+
 		r = pdd->dev->dqm->ops.evict_process_queues(pdd->dev->dqm,
 							    &pdd->qpd);
 		/* evict return -EIO if HWS is hang or asic is resetting, in this case
@@ -1769,6 +1773,9 @@ int kfd_process_evict_queues(struct kfd_process *p)
 
 		if (n_evicted == 0)
 			break;
+
+		kfd_smi_event_queue_restore(pdd->dev, p->lead_thread->pid);
+
 		if (pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
 							      &pdd->qpd))
 			pr_err("Failed to restore queues\n");
@@ -1788,6 +1795,8 @@ int kfd_process_restore_queues(struct kfd_process *p)
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 
+		kfd_smi_event_queue_restore(pdd->dev, p->lead_thread->pid);
+
 		r = pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
 							      &pdd->qpd);
 		if (r) {
@@ -1849,7 +1858,7 @@ static void evict_process_worker(struct work_struct *work)
 	flush_delayed_work(&p->restore_work);
 
 	pr_debug("Started evicting pasid 0x%x\n", p->pasid);
-	ret = kfd_process_evict_queues(p);
+	ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_TTM);
 	if (!ret) {
 		dma_fence_signal(p->ef);
 		dma_fence_put(p->ef);
@@ -1916,7 +1925,7 @@ void kfd_suspend_all_processes(void)
 		cancel_delayed_work_sync(&p->eviction_work);
 		cancel_delayed_work_sync(&p->restore_work);
 
-		if (kfd_process_evict_queues(p))
+		if (kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SUSPEND))
 			pr_err("Failed to suspend process 0x%x\n", p->pasid);
 		dma_fence_signal(p->ef);
 		dma_fence_put(p->ef);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index ec4d278c2a47..3917c38204d0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -283,6 +283,41 @@ void kfd_smi_event_migration_end(struct kfd_dev *dev, pid_t pid,
 			  from, to, trigger);
 }
 
+void kfd_smi_event_queue_eviction(struct kfd_dev *dev, pid_t pid,
+				  uint32_t trigger)
+{
+	kfd_smi_event_add(pid, dev, KFD_SMI_EVENT_QUEUE_EVICTION,
+			  "%lld -%d %x %d\n", ktime_get_boottime_ns(), pid,
+			  dev->id, trigger);
+}
+
+void kfd_smi_event_queue_restore(struct kfd_dev *dev, pid_t pid)
+{
+	kfd_smi_event_add(pid, dev, KFD_SMI_EVENT_QUEUE_RESTORE,
+			  "%lld -%d %x\n", ktime_get_boottime_ns(), pid,
+			  dev->id);
+}
+
+void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
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
+		kfd_smi_event_add(p->lead_thread->pid, pdd->dev,
+				  KFD_SMI_EVENT_QUEUE_RESTORE,
+				  "%lld -%d %x %c\n", ktime_get_boottime_ns(),
+				  p->lead_thread->pid, pdd->dev->id, 'R');
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
index 5cead2a0e819..ddc1e4651919 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1730,14 +1730,16 @@ static void svm_range_restore_work(struct work_struct *work)
 	mutex_unlock(&svms->lock);
 	mmap_write_unlock(mm);
 	mutex_unlock(&process_info->lock);
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
@@ -1793,7 +1795,7 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 			 prange->svms, prange->start, prange->last);
 
 		/* First eviction, stop the queues */
-		r = kgd2kfd_quiesce_mm(mm);
+		r = kgd2kfd_quiesce_mm(mm, KFD_QUEUE_EVICTION_TRIGGER_SVM);
 		if (r)
 			pr_debug("failed to quiesce KFD\n");
 
-- 
2.35.1

