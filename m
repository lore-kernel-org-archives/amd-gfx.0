Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5A0C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 03:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845C161A64
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 03:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 845C161A64
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E36926E125;
	Wed, 17 Nov 2021 03:43:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 227226E125
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 03:43:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oexxsi8carxNVQ3Y79x8MEIIoKlDoZPlo+lttTor4h08xJ1w12u407CHq5KR2rW5sWUqqqkBDqCW95+4qyRZ52yPaVcpldCA9UDFOm07xWsp3/p4iMexDr4o51EBRX9Apx1DmOUBWgu3WqZ/vD0lA2pWiJ4lKfFyAkufvlKoh7ja1YsPJRSdOGtUSlo3FaPD0T0viT/icyWARGBlCEgNnGYn8XbEumuIiJVaM39DSa73aHteNUsCK4k/eWhLQoGeQj1kYlk3PjLaUTQwYvyrTUFLvFimjVeMfNzHxsDOEBpwtlFb0BcZ80bEnulwSHOoXBUkezuqQ0Zj5rh+NZQdag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIV9BsDCXXY6HB28g/bQvld0D8eYsUcNOJrt7erZowo=;
 b=XSX49ZsknDIjYwyq47ifkOY2uFAwe11c6gMuuG3lHNVs85c4o2e3Et1yb+kbwRrf2+BkY8PM/6a4zPjIv8O7mEMrepa1erOsro5b65Ez/Q3Q+Ku6U4OXIsE0NqcsnSA2JKsIk07+n81p8F/9Oj96UDrVa6pM59qif2VBYpsdZcwquKqM2eSTcqwWoT9RITTLzuBvVDIZ7CTpRIC6O4f3RBq0Jzh7TQuVhlwRY6JGrcO6RQWCMOQ3IXWRngNlrit4XdmEMM96gq885TSIBuSqw7GHx0Fr69Wuo/bWTL/i6mKhaKMjC6yfHmyRZqryrkx17WlcQI4YiLg7HXUTuob11g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIV9BsDCXXY6HB28g/bQvld0D8eYsUcNOJrt7erZowo=;
 b=2UGbvp6Swpw6cBU0dQ6Bo65E9YAG3yiN8LZPAutzjF/8u6JEhqV96dviVBBvqNZiuqEhJkmQLS2vp2MsR2JO6mawqVlHa5P8qUpBez5TdRt5jDpMmSxr/BHO7Uca0dxKrDdaNed1mi3WktfAWutLorUNSuPMrvC7L8g0nv1cVEg=
Received: from BN6PR2001CA0041.namprd20.prod.outlook.com
 (2603:10b6:405:16::27) by DM6PR12MB3770.namprd12.prod.outlook.com
 (2603:10b6:5:1c4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Wed, 17 Nov
 2021 03:43:40 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::19) by BN6PR2001CA0041.outlook.office365.com
 (2603:10b6:405:16::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend
 Transport; Wed, 17 Nov 2021 03:43:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.19 via Frontend Transport; Wed, 17 Nov 2021 03:43:39 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 16 Nov
 2021 21:43:38 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdkfd: process exit and retry fault race
Date: Tue, 16 Nov 2021 22:43:22 -0500
Message-ID: <20211117034324.4663-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63a9a907-3937-4ba2-a6cd-08d9a97c717c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3770:
X-Microsoft-Antispam-PRVS: <DM6PR12MB37707D8C07B266B13FAFA37CE69A9@DM6PR12MB3770.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vls509L7xdEC3jECHG4hJCUBCBUGDF+VxYgA3d+Q9icbYZ/E7TGrufWphzf7lKLKstlihR3WrzPOYr58+sPZYqfNJAgcMoCEsrcgUh+ogeyuHQl+2Dly0l5EnBrRyNavRjSZjMdmqPDv0MksbxgdVd3mwwgZN7H0EB4ddQabKuQtbQp1pT45YkiM/GNY8behm/EBfOtDuLlAncFHuPvnHOFA3W2cIbRogLOxTyMieM18DhhP2AU5lERV4wS6H4yT8oRTMEVFIG1OnR6NeoZDtlbEOn/fBBCnYg00Z9NGQODt1ta35WwtAZtRF9wyy9Bl38L1cV2aReEGMguksiWS4wScOWBBa4X1Krs3UcOuVdr3jHdZUYi+wmeSBLKKq9voVG+V3vi5Y5202HBF7GBl02xzjkfzkLbPi5bhj2NApGRSj8WEt/KoACnQwWU6QOhyXtFRS5NpUPiVd8EVdGD46glnW2/Ko8DeE9Iv9QTfrbkbRFizyLGK17ERI+MEvqqdBpLkvPGWtTnk2maXB/MPZVWxVzeYKYFpVEVk3pRisxS6PYDXNW2O2fWkNTMBZ9GQFdb5RtTM2PDvPIYSqZms7uTN5+CfObZ2kawQmOCmWv1o5OFkud7Y2A3t4V6TBEQfM2RKNxgVWnH84nijJ4aqzb3SsSMHXeKx/4iouQXB2JLGnLNKvYroGTxQnPI73D7vsBtLOpzrN0LciNBbmoReL902mgPoETjfbQeSuX13JLI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(336012)(36860700001)(86362001)(186003)(16526019)(81166007)(36756003)(7696005)(4326008)(8676002)(426003)(2616005)(5660300002)(2906002)(6666004)(26005)(6916009)(316002)(82310400003)(47076005)(54906003)(8936002)(70206006)(1076003)(70586007)(356005)(508600001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 03:43:39.4239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a9a907-3937-4ba2-a6cd-08d9a97c717c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3770
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

kfd process mmu release notifier callback drain retry fault to ensure no
retry fault comes after removing kfd process from the hash table,
otherwise svm page fault handler will fail to recover the fault and dump
GPU vm fault log.

Drain retry fault needs flush restore page fault work to wait for
the last fault is handled because IH dispatch increase rptr first and
then calls restore_pages, so restore pages may still handle the last
fault but amdgpu_ih_has_checkpoint_processed return true.

restore pages can not call mmget because mmput may call mmu notifier
release to cause deadlock.

Refactor deferred list work to call mmget and take mmap write lock to
handle all ranges, to avoid mm is gone while inserting mmu notifier.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |  6 +++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 69 ++++++++++++------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  1 +
 3 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d4c8a6948a9f..8b4b045d5c92 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1143,6 +1143,12 @@ static void kfd_process_notifier_release(struct mmu_notifier *mn,
 	if (WARN_ON(p->mm != mm))
 		return;
 
+	/*
+	 * Ensure no retry fault comes in afterwards, as page fault handler will
+	 * not find kfd process and take mm lock to recover fault.
+	 */
+	svm_range_drain_retry_fault(&p->svms);
+
 	mutex_lock(&kfd_processes_mutex);
 	hash_del_rcu(&p->kfd_processes);
 	mutex_unlock(&kfd_processes_mutex);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 88360f23eb61..c1f367934428 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1953,9 +1953,10 @@ svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange)
 	}
 }
 
-static void svm_range_drain_retry_fault(struct svm_range_list *svms)
+void svm_range_drain_retry_fault(struct svm_range_list *svms)
 {
 	struct kfd_process_device *pdd;
+	struct amdgpu_device *adev;
 	struct kfd_process *p;
 	uint32_t i;
 
@@ -1967,9 +1968,11 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 			continue;
 
 		pr_debug("drain retry fault gpu %d svms %p\n", i, svms);
+		adev = pdd->dev->adev;
+		amdgpu_ih_wait_on_checkpoint_process(adev, &adev->irq.ih1);
 
-		amdgpu_ih_wait_on_checkpoint_process(pdd->dev->adev,
-						     &pdd->dev->adev->irq.ih1);
+		/* Wait for the last page fault is handled */
+		flush_work(&adev->irq.ih1_work);
 		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
 	}
 }
@@ -1979,43 +1982,43 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 	struct svm_range_list *svms;
 	struct svm_range *prange;
 	struct mm_struct *mm;
+	struct kfd_process *p;
 
 	svms = container_of(work, struct svm_range_list, deferred_list_work);
 	pr_debug("enter svms 0x%p\n", svms);
 
+	p = container_of(svms, struct kfd_process, svms);
+	mm = p->mm;
+
+	/* Take mm->mm_users to avoid mm is gone when inserting mmu notifier */
+	if (!mm || !mmget_not_zero(mm)) {
+		pr_debug("svms 0x%p process mm gone\n", svms);
+		return;
+	}
+retry:
+	mmap_write_lock(mm);
+
+	/* Checking for the need to drain retry faults must be inside
+	 * mmap write lock to serialize with munmap notifiers.
+	 */
+	if (unlikely(READ_ONCE(svms->drain_pagefaults))) {
+		WRITE_ONCE(svms->drain_pagefaults, false);
+		mmap_write_unlock(mm);
+		svm_range_drain_retry_fault(svms);
+		goto retry;
+	}
+
 	spin_lock(&svms->deferred_list_lock);
 	while (!list_empty(&svms->deferred_range_list)) {
 		prange = list_first_entry(&svms->deferred_range_list,
 					  struct svm_range, deferred_list);
+		list_del_init(&prange->deferred_list);
 		spin_unlock(&svms->deferred_list_lock);
+
 		pr_debug("prange 0x%p [0x%lx 0x%lx] op %d\n", prange,
 			 prange->start, prange->last, prange->work_item.op);
 
-		mm = prange->work_item.mm;
-retry:
-		mmap_write_lock(mm);
 		mutex_lock(&svms->lock);
-
-		/* Checking for the need to drain retry faults must be in
-		 * mmap write lock to serialize with munmap notifiers.
-		 *
-		 * Remove from deferred_list must be inside mmap write lock,
-		 * otherwise, svm_range_list_lock_and_flush_work may hold mmap
-		 * write lock, and continue because deferred_list is empty, then
-		 * deferred_list handle is blocked by mmap write lock.
-		 */
-		spin_lock(&svms->deferred_list_lock);
-		if (unlikely(svms->drain_pagefaults)) {
-			svms->drain_pagefaults = false;
-			spin_unlock(&svms->deferred_list_lock);
-			mutex_unlock(&svms->lock);
-			mmap_write_unlock(mm);
-			svm_range_drain_retry_fault(svms);
-			goto retry;
-		}
-		list_del_init(&prange->deferred_list);
-		spin_unlock(&svms->deferred_list_lock);
-
 		mutex_lock(&prange->migrate_mutex);
 		while (!list_empty(&prange->child_list)) {
 			struct svm_range *pchild;
@@ -2031,12 +2034,13 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 
 		svm_range_handle_list_op(svms, prange);
 		mutex_unlock(&svms->lock);
-		mmap_write_unlock(mm);
 
 		spin_lock(&svms->deferred_list_lock);
 	}
 	spin_unlock(&svms->deferred_list_lock);
 
+	mmap_write_unlock(mm);
+	mmput(mm);
 	pr_debug("exit svms 0x%p\n", svms);
 }
 
@@ -2600,12 +2604,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	pr_debug("restoring svms 0x%p fault address 0x%llx\n", svms, addr);
 
-	mm = get_task_mm(p->lead_thread);
-	if (!mm) {
-		pr_debug("svms 0x%p failed to get mm\n", svms);
-		r = -ESRCH;
-		goto out;
-	}
+	/* mm is available because kfd_process_notifier_release drain fault */
+	mm = p->mm;
 
 	mmap_read_lock(mm);
 retry_write_locked:
@@ -2708,7 +2708,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	svm_range_count_fault(adev, p, gpuidx);
 
-	mmput(mm);
 out:
 	kfd_unref_process(p);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 6dc91c33e80f..0a8bcdb3dddf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -189,6 +189,7 @@ void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm,
 struct kfd_process_device *
 svm_range_get_pdd_by_adev(struct svm_range *prange, struct amdgpu_device *adev);
 void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_struct *mm);
+void svm_range_drain_retry_fault(struct svm_range_list *svms);
 
 /* SVM API and HMM page migration work together, device memory type
  * is initialized to not 0 when page migration register device memory.
-- 
2.17.1

