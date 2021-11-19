Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC90C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 22:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 719CA6E2E6;
	Fri, 19 Nov 2021 22:30:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06F8D6E210
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 22:30:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Viou/oRQGvLPtwztQt5NcbSAyY95FkoElUaNBz0hBVYEKc1T66rpdoAmyFOBxtPd1b67ornj9Onn6D4HN1dGP2BiPmJB7DBugUBV0vlqkL/KhhlJ7VbBWwLVNLiGjM+ZzTtw1+HEbpyyvgw5IJ5+HNQKtomLuKPLF6LvJhZE5Jg4k+7/iZpq0zOEZXQd275OJ4FlwZhFZ5ZeKPXFA5dk+eikKTuXkYiecFXMRB8fd7xoH4vFX9EEPifSZiLB0OB2g4AbGGJXYNB8loCYJx3y1KPSNKgNq+ffT1GNwsPu9qAFTkQxIoTi3+DcyZQiBULuwguTZkvI23Qfc/dxMqsq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXefKx+VUMMV3LXti7a6Ke6tn1hSVkRPo4Q1FbkP4xg=;
 b=LX9+NAwVEtz//dDlvi9wRL0gFmGky0a+7XZTRqvq9/LigVVkMMzfIMi4hzMB6U6qu85iJmKlZvL8JLFhI3NQrb2T4QokZlpgkFYQotOxJyzNG1zjNlHpa9ZOuYbhJaLORhUVrh5UnsCbQZMSLw2HFKLtXP42Q4pe9uz0Y3fni/Yg4RjE2h8rSlpMVru+W0kfBH7FplHgsT8sq4xU2V8W9M+z5zwFOlM3V4Nc/X1H0aZXHQI8MVoWRlw7d5YbcsDR8GIfWsIragmxHrINteNbIdeBafhRlOiRt0QFVNlUXJ/N9Kck8LKwPcIDRMETVeJHzHjlfgKdAY+6j7JanXahgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXefKx+VUMMV3LXti7a6Ke6tn1hSVkRPo4Q1FbkP4xg=;
 b=oxmalUKzVjW2rw769vxOaX6uWmSrtquuz6T4j4LaB2Dt0RpR20t6SlFdo2diRPRx4NMaKMwkitV8QOZXHWkoe6+RoNL5UY9Puc5KJu756n6N6YrY/oZiliiMmeodKTo6qaYJOurMoQpkjJj48mGPtlM3h2CQx0TVNAuy9mJw+e0=
Received: from BN9PR03CA0068.namprd03.prod.outlook.com (2603:10b6:408:fc::13)
 by BYAPR12MB3318.namprd12.prod.outlook.com (2603:10b6:a03:df::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Fri, 19 Nov
 2021 22:30:07 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::6a) by BN9PR03CA0068.outlook.office365.com
 (2603:10b6:408:fc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24 via Frontend
 Transport; Fri, 19 Nov 2021 22:30:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 22:30:06 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 16:30:05 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/3] drm/amdkfd: process exit and retry fault race
Date: Fri, 19 Nov 2021 17:29:39 -0500
Message-ID: <20211119222941.18053-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc8b260c-f81e-46ac-6889-08d9abac2325
X-MS-TrafficTypeDiagnostic: BYAPR12MB3318:
X-Microsoft-Antispam-PRVS: <BYAPR12MB33182AFF6E93D5A12DAE633FE69C9@BYAPR12MB3318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AygZFe0B0lbjp2ql70Iv8S+wkSexWqOQSwXOZAnxA5VlgeGPHdqlkHkJK3hokUUvU/D4ebWL8I+TyuMcP13qc051iEXc/Op22GhfSGmGp9y+olfXEimOo7gSCCUrnBjxanyEhU7gbX1Fq6VHK+ann2ubZ6cIVsjSFrxJGOwWzt62635DqGkIsHU0UP2kqxCln33tQQct22sgv2qK2E20i6pRNXQZBSn+AWGK4Oe4T1d+Ibc0CWpMsxqRatRwHHin6F31184E1D26/5e6pwxjW/L0JfR1QpK4VqwiWyWZSA5Z82OF3DnCoj/5cd8qwVgbi7JL/x3zdTz2rnz+ttERJnwqDzvykSG3bTcF9S0RWyoVazJaHe2P5pqB+HEL5+I95gFYwpVDAZ/ACOyLnYtOFYRaQYz4rsbJlPYjmkikc1LXOb/eVD9rMJRUEiGRhIDCXDrtf67BbNya8ziPW4+lM1tcDytAsDb5BuaLWmXwUg4MtTTtGm4Oat9xYqK2DECphGac3afOX7UG3LHFbbPnmwVpLQNRNW5aQuwuP2DU3K5VKPfK/+EKa06QcvESC7Xv/EtCn3zkmHZjDt06+WhFf4B9Ogt7GKb+6jHoiUnlK2Na+k7wLtvsJg3yco2+qtJFRAxf1IlPFJeTTkotZsZ4efmPmiGZ99aL7aDrEHMZMsAOdQOjR+/fhphtrV4sy38o5XgIITTitvXAopeK04uNFY7IRXmHfPXV+JWgvaEP2c8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(7696005)(82310400003)(1076003)(36756003)(2616005)(70206006)(70586007)(426003)(8676002)(16526019)(186003)(6666004)(47076005)(508600001)(336012)(54906003)(356005)(81166007)(86362001)(4326008)(5660300002)(83380400001)(316002)(36860700001)(6916009)(8936002)(26005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 22:30:06.1574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8b260c-f81e-46ac-6889-08d9abac2325
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3318
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

kfd_process_wq_release drain retry fault to ensure no retry fault comes
after removing kfd process from the hash table, otherwise svm page fault
handler will fail to recover the fault and dump GPU vm fault log.

Refactor deferred list work to get_task_mm and take mmap write lock
to handle all ranges, and avoid mm is gone while inserting mmu notifier.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 61 ++++++++++++++++------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 9e566ec54cf5..5fa540828ed0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1979,43 +1979,42 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 	struct svm_range_list *svms;
 	struct svm_range *prange;
 	struct mm_struct *mm;
+	struct kfd_process *p;
 
 	svms = container_of(work, struct svm_range_list, deferred_list_work);
 	pr_debug("enter svms 0x%p\n", svms);
 
+	p = container_of(svms, struct kfd_process, svms);
+	/* Avoid mm is gone when inserting mmu notifier */
+	mm = get_task_mm(p->lead_thread);
+	if (!mm) {
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
@@ -2031,12 +2030,13 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 
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
 
@@ -2600,10 +2600,12 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	pr_debug("restoring svms 0x%p fault address 0x%llx\n", svms, addr);
 
+	/* p->lead_thread is available as kfd_process_wq_release flush the work
+	 * before releasing task ref.
+	 */
 	mm = get_task_mm(p->lead_thread);
 	if (!mm) {
 		pr_debug("svms 0x%p failed to get mm\n", svms);
-		r = -ESRCH;
 		goto out;
 	}
 
@@ -2730,6 +2732,13 @@ void svm_range_list_fini(struct kfd_process *p)
 	/* Ensure list work is finished before process is destroyed */
 	flush_work(&p->svms.deferred_list_work);
 
+	/*
+	 * Ensure no retry fault comes in afterwards, as page fault handler will
+	 * not find kfd process and take mm lock to recover fault.
+	 */
+	svm_range_drain_retry_fault(&p->svms);
+
+
 	list_for_each_entry_safe(prange, next, &p->svms.list, list) {
 		svm_range_unlink(prange);
 		svm_range_remove_notifier(prange);
-- 
2.17.1

