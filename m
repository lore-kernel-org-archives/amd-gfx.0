Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22FDC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 23:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36AB110E86B;
	Thu, 20 Jan 2022 23:13:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA8AE10E898
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 23:13:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pth6Whgv9Ch0WQ4Zjg7B9A8wS53BR8BKvLXGWKcs6n7hk15MNP6fM52ykn9DgUGPwcLfN3nV5j3lDb27eUbe7HVtEbNK2KS3qfOJll1P3De0thCG9JnfVGDbLH/dXzCV4089zwrRV/BLRlD9HRhcDrQZjDakXchAahsYtZpTg5QFsTX9MpfHuOGwQJcIBlViR1a9nkFqjRMHi6xYJ1/kzuHWYC6vHTW3NMKLWHxkBQt+LRzeVQ+m5UR1RXNJuHXcIH7aVjaUWGAPvEDVIwUndv++VSsty6jp661r0qVJ6mjR0LtZRU3u/90FOGF7ziupbwF7hgXcnwLTSMBeZJ84mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCwAppF0ovY7KLYaVXvgUF6bdozKSTe0WOsNYBJIfIg=;
 b=bT8LG/MamPvJjknVAV/m0f12udXJEMDbmeeYBQZazUFMUk3z2KsCu/9Vws2ordVX+5RZN4ivA1NVV+Dfe+6alHPwTH1AFujBEC1MAyN/y05+gMsmyK1aBeKRgTlHevsML4IXPWdFRGkR3khrR0tkiTXLit0wCYEwiq9Xadp6q9K8mHehmxvVciKs8V62hDwrJRnq3bCIwquVE01JRHOxwqkf4Nj8Ig5nL4mLbuFhFUrnKUlLdUbDcwTJVyuqAJTphcVJExVpYPtFUjrTOmdzlgHIZ3NHhCtjC6grVdY6HA0mo7MA4sNd8DHdxpD3twlRKr9YjdIssa0yzCGzjXqJNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCwAppF0ovY7KLYaVXvgUF6bdozKSTe0WOsNYBJIfIg=;
 b=SbcX8Of6Hv6goqk/4LBnS5WFbKZ4Nrgc4efl79sfhkwhMy017y3VhsvYBK3EvUWz/u921x7by61vxKutynuLZ/yETiNbu4uuU/cQO9XMicQFtzUz8iE559NUYOllXBU325VssNAU2uKIFYZ9cof0IhekXcKUNVYcpqQ8GdJSeRM=
Received: from MWHPR19CA0084.namprd19.prod.outlook.com (2603:10b6:320:1f::22)
 by CH0PR12MB5138.namprd12.prod.outlook.com (2603:10b6:610:bd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 23:13:41 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:1f:cafe::8a) by MWHPR19CA0084.outlook.office365.com
 (2603:10b6:320:1f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11 via Frontend
 Transport; Thu, 20 Jan 2022 23:13:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 23:13:40 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 17:13:37 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 6/8] drm/amdkfd: Add user queue eviction restore SMI event
Date: Thu, 20 Jan 2022 18:13:20 -0500
Message-ID: <20220120231322.10321-7-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220120231322.10321-1-Philip.Yang@amd.com>
References: <20220120231322.10321-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b9290dd-fed5-4b05-6067-08d9dc6a7f39
X-MS-TrafficTypeDiagnostic: CH0PR12MB5138:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5138A51E426F749299B81401E65A9@CH0PR12MB5138.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S60QkkqqeWxhgDc9MtTgBK2kVbaraJsIKT34xVUkijHC59qecbULwEa8hAyL2caA1PiYPVFR3U5iVke7LvbUgR2iZ2qNbFb41W/IOR69xlsUUcySX+IZMCgz/LmYKV+W7s7o0Xc6wOeyaPqjO5W7NAqQYIU0B9LnkTtKiXDjFb+IGX2SBxlUTZt6OacHjXmay8RqpYI0RuRKlx2m7//3CrpuAj8N2vbxJaOPQ21NoVO0rwmxlT598zynAm5lgSH7ZiOJuadapcDJND53goWYZyeK1Q6Mxv/3gEWedALEebeXIDrRBzjlVx8l+eT23sfbfbawZ/PNOLwDIdbBIFlTMs66E1JceTkValOVkS4ErB76aEHW57eRXaBWw6aPjcWXR3o0Ji0qbvgiXCvWoUQq5h2Tie4bCazPqoNKYC5cIEMJhyizZuIIvUETqRtk5aA6BB+mtcTaWK9ty6AU67L5eYeFHPxiN5fsAHbi4w58UE1ZHNV6eCvkNNVMqDZUC/XmxO5yBINBkLS1KuvAsCd+mESZQ1CLBES43PwSzVez4mOcMlZCxS6UIlLLWknE6kOirjOzWjs7NYuhdGyhzhWAEqZ1BsK8azB7LcCaH4+/6mFQEOq4ZXjeo/gGZURh4yJvHcW03aEYUxPdNL+4IGb2Ui2kAoh5URXxtL5r73R0VgX+MhhrDHwNJi0g9g10uN6jgPYobPme2HMItHnxX58W4Hz8SXlm7cSxutUGwD6oHW6TKha6oq740Sk8YG4bfs229VsSHnI75FhXHM4CS48HdJtpm6d/rCIi8mUrfEsvndk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(6916009)(5660300002)(47076005)(8676002)(54906003)(36860700001)(356005)(36756003)(4326008)(316002)(82310400004)(81166007)(83380400001)(8936002)(70206006)(86362001)(7696005)(30864003)(426003)(40460700001)(2906002)(16526019)(1076003)(2616005)(70586007)(508600001)(336012)(186003)(26005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 23:13:40.7184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9290dd-fed5-4b05-6067-08d9dc6a7f39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5138
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
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 11 ++++--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 37 +++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   | 34 +++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h   |  4 ++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 16 ++++++--
 8 files changed, 101 insertions(+), 14 deletions(-)

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
index 5df387c4d7fb..c44e8dc0d869 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2066,7 +2066,7 @@ int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem,
 	evicted_bos = atomic_inc_return(&process_info->evicted_bos);
 	if (evicted_bos == 1) {
 		/* First eviction, stop the queues */
-		r = kgd2kfd_quiesce_mm(mm);
+		r = kgd2kfd_quiesce_mm(mm, USERPTR_EVICTION);
 		if (r)
 			pr_err("Failed to quiesce KFD\n");
 		schedule_delayed_work(&process_info->restore_userptr_work,
@@ -2340,13 +2340,16 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 
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
index 74f162887d3b..e4ba4d537b3c 100644
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
 
+		kfd_smi_event_queue_eviction(pdd->dev, p->lead_thread->pid,
+					     trigger);
+
 		r = pdd->dev->dqm->ops.evict_process_queues(pdd->dev->dqm,
 							    &pdd->qpd);
 		/* evict return -EIO if HWS is hang or asic is resetting, in this case
@@ -1734,6 +1738,11 @@ int kfd_process_evict_queues(struct kfd_process *p)
 
 		if (n_evicted == 0)
 			break;
+
+		kfd_smi_event_queue_eviction_restore(pdd->dev,
+						     p->lead_thread->pid,
+						     false);
+
 		if (pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
 							      &pdd->qpd))
 			pr_err("Failed to restore queues\n");
@@ -1753,6 +1762,10 @@ int kfd_process_restore_queues(struct kfd_process *p)
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 
+		kfd_smi_event_queue_eviction_restore(pdd->dev,
+						     p->lead_thread->pid,
+						     false);
+
 		r = pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
 							      &pdd->qpd);
 		if (r) {
@@ -1765,6 +1778,24 @@ int kfd_process_restore_queues(struct kfd_process *p)
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
+						     p->lead_thread->pid, true);
+	}
+	kfd_unref_process(p);
+}
+
 int kfd_process_gpuidx_from_gpuid(struct kfd_process *p, uint32_t gpu_id)
 {
 	int i;
@@ -1814,7 +1845,7 @@ static void evict_process_worker(struct work_struct *work)
 	flush_delayed_work(&p->restore_work);
 
 	pr_debug("Started evicting pasid 0x%x\n", p->pasid);
-	ret = kfd_process_evict_queues(p);
+	ret = kfd_process_evict_queues(p, TTM_EVICTION);
 	if (!ret) {
 		dma_fence_signal(p->ef);
 		dma_fence_put(p->ef);
@@ -1881,7 +1912,7 @@ void kfd_suspend_all_processes(void)
 		cancel_delayed_work_sync(&p->eviction_work);
 		cancel_delayed_work_sync(&p->restore_work);
 
-		if (kfd_process_evict_queues(p))
+		if (kfd_process_evict_queues(p, SUSPEND_EVICTION))
 			pr_err("Failed to suspend process 0x%x\n", p->pasid);
 		dma_fence_signal(p->ef);
 		dma_fence_put(p->ef);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 97393f4f3549..facc8d7627d8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -343,6 +343,40 @@ void kfd_smi_event_migration(struct kfd_dev *dev, uint16_t pasid,
 	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_MIGRATION, fifo_in, len);
 }
 
+void kfd_smi_event_queue_eviction(struct kfd_dev *dev, pid_t pid,
+				  uint32_t trigger)
+{
+	char fifo_in[64];
+	int len;
+
+	if (list_empty(&dev->smi_clients))
+		return;
+
+	len = snprintf(fifo_in, sizeof(fifo_in), "%x %lld -%d @%x %d\n",
+		       KFD_SMI_EVENT_QUEUE_EVICTION, ktime_get_boottime_ns(),
+		       pid, dev->id, trigger);
+
+	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_QUEUE_EVICTION, fifo_in, len);
+}
+
+void kfd_smi_event_queue_eviction_restore(struct kfd_dev *dev, pid_t pid,
+					  bool rescheduled)
+{
+	char fifo_in[64];
+	int len;
+
+	if (list_empty(&dev->smi_clients))
+		return;
+
+	len = snprintf(fifo_in, sizeof(fifo_in), "%x %lld -%d @%x %c\n",
+		       KFD_SMI_EVENT_QUEUE_EVICTION_RESTORE,
+		       ktime_get_boottime_ns(), pid, dev->id,
+		       rescheduled ? 'r' : ' ');
+
+	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_QUEUE_EVICTION_RESTORE,
+			   fifo_in, len);
+}
+
 int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
 {
 	struct kfd_smi_client *client;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index 5788728f2879..d85300b5af23 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -39,4 +39,8 @@ void kfd_smi_event_migration(struct kfd_dev *dev, uint16_t pasid,
 			     uint32_t from, uint32_t to,
 			     uint32_t prefetch_loc, uint32_t preferred_loc,
 			     uint32_t trigger, uint64_t ts);
+void kfd_smi_event_queue_eviction(struct kfd_dev *dev, pid_t pid,
+				  uint32_t trigger);
+void kfd_smi_event_queue_eviction_restore(struct kfd_dev *dev, pid_t pid,
+					  bool rescheduled);
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 7dbc724364e6..30aaa9764067 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1712,7 +1712,10 @@ static void svm_range_restore_work(struct work_struct *work)
 		pr_debug("reschedule to restore svm range\n");
 		schedule_delayed_work(&svms->restore_work,
 			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
+
+		kfd_process_smi_event_restore_rescheduled(mm);
 	}
+	mmput(mm);
 }
 
 /**
@@ -1732,15 +1735,22 @@ static void svm_range_restore_work(struct work_struct *work)
  */
 static int
 svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
-		unsigned long start, unsigned long last)
+		unsigned long start, unsigned long last,
+		enum mmu_notifier_event event)
 {
 	struct svm_range_list *svms = prange->svms;
 	struct svm_range *pchild;
 	struct kfd_process *p;
+	uint32_t trigger;
 	int r = 0;
 
 	p = container_of(svms, struct kfd_process, svms);
 
+	if (event == MMU_NOTIFY_MIGRATE)
+		trigger = SVM_RANGE_MIGRATION;
+	else
+		trigger = SVM_RANGE_EVICTION;
+
 	pr_debug("invalidate svms 0x%p prange [0x%lx 0x%lx] [0x%lx 0x%lx]\n",
 		 svms, prange->start, prange->last, start, last);
 
@@ -1768,7 +1778,7 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 			 prange->svms, prange->start, prange->last);
 
 		/* First eviction, stop the queues */
-		r = kgd2kfd_quiesce_mm(mm);
+		r = kgd2kfd_quiesce_mm(mm, trigger);
 		if (r)
 			pr_debug("failed to quiesce KFD\n");
 
@@ -2303,7 +2313,7 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
 		svm_range_unmap_from_cpu(mni->mm, prange, start, last);
 		break;
 	default:
-		svm_range_evict(prange, mni->mm, start, last);
+		svm_range_evict(prange, mni->mm, start, last, range->event);
 		break;
 	}
 
-- 
2.17.1

