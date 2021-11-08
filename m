Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19263C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 14:16:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9BF3604DB
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 14:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C9BF3604DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67A4D6E3EF;
	Mon,  8 Nov 2021 14:16:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B373B6E3EF
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 14:16:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZDkUYgEOJG8Llwr9G7FPXcMXBbubHVtRvIooHUxRemTO3ebDTuVwVo+DTguEEHYjfZkTdITClTokMFQBehNjnd+bppshzXUB3Ib5KFksPHd0uE2vGNXzrn9OpCZXL4oD6DM02RrMzvOXUMND5VF1zs9EQ4d63ba2TV4QOA9DbUahAwg8RKOlwA8fiYDHS7tBhITBpyzv0UPI98TDU6hdizgyIgH5xqxV4Q7FDVaL5hnR9WBVLqRQsgwU80J9wfD4N2+GYldOCOy4f/+h/iIF7olAgUjm3RlEtq5Ub2BG9gs7PKJF6MwWsyX0jWkwFZFMvmt3OCjStVE0ynA6i2ACw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=es5UTF1+IdGEMvFDy44AuiSsMrDvvj7yC7oxKDODmrk=;
 b=A5IBWm9k6xewVz3ls2q97hwXIedPG3w+hLAj7cq+bMHL/NRgFgWofgpCcObXscywWny/VlGD9uYqlYgfznp5oMiuG6Qlahc6ICuL9/X5umfvP19BTmRQgHnsNmaFvOg6c4Ps8gRREVFxsNdjVJIL8gO59TAPfXamuaq0JGM+BJHGTjlax0HyS2NbbGaIUxFLJGTETj6kR7cyznM5diFABVgmjf26DAnETIRtF7iNTffWf/MIcVO5A39rz23JBJtOHaPIP56ufQilQIBxlWCm1V5PXPdEjmeEe4LAtJtcS5ybyG2vuHblc/a5xSqQhNX5X0GFsrk/5Rag6f/dnkWmhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=es5UTF1+IdGEMvFDy44AuiSsMrDvvj7yC7oxKDODmrk=;
 b=Las3vsH0iqXKXKiMUGn0c6ouYQv8uuWLH8AP694bMMgBaLgMRuBv5zsvFCVK9VTWVrZUZEuuKIIvqZzIajENDGwAXam2WaQ+JbBeIjZ85QMThDuvPBQzYAMbw80bfZ5NvYOCOwVim0AFZ6dgKdZdYmGBDg6P1Tp8DpNJChBVzm4=
Received: from MWHPR13CA0038.namprd13.prod.outlook.com (2603:10b6:300:95::24)
 by DM5PR1201MB2539.namprd12.prod.outlook.com (2603:10b6:3:ea::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Mon, 8 Nov
 2021 14:16:17 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::db) by MWHPR13CA0038.outlook.office365.com
 (2603:10b6:300:95::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.5 via Frontend
 Transport; Mon, 8 Nov 2021 14:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 14:16:17 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 Nov 2021
 08:16:16 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdkfd: Fix retry fault drain race conditions
Date: Mon, 8 Nov 2021 09:15:49 -0500
Message-ID: <20211108141549.1573995-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1ed263c-971a-4786-211e-08d9a2c25494
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2539:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB25393817240453E42A51E87492919@DM5PR1201MB2539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GikF4R8CGl20fNhAedVJcb56+hLojHWOZav7KE8TOZ7zZO8+fUAaHIG4kSfLRWHMqPmo9zKeKTwqgQfbE0z6VbES+//oYYnQ80WtPgEeQlsU4XBszgqL51GdjeyQKPZkKV8/wozWtifSgwwCxTfmiNU6eTZ9OqkzdOk/ZY5nyKZdccnIX3Zpo/77D4jRToTsSs3GpAaA8tgZd453WQKGn4QXr7JvOsEF5DH1UDsAXeK0atCbE+93mPMfRWG+1XyHGuTyvHZrw4JK9FIXbaveGShidCyZGp7FLmv0TlZw7EM6N57NMdRG/48Fu7lV1KjO9C8JaO16RvxLlCGErfYCfLaqZTBYJl7cwP7YdAFjvvT8/8UXJNevdJIA91IcvUHEe1XjB2VJHdfgyJMu4RCXdWEnntF63WQeMmz8TxnAkQzpy9zbB30JNxRTd+BSzK+WNgSgzFtSvffKzsCXCe4p5/3Qjg9ltpTQ6iYVcnWvyNJcK6TWmdyNV4qJRWm7uuS6lpoi0yJLD+4BW1VwAqZmTfxOpJX1xAojI79/bczr9biEqKEuGKeZbmZH7dkSTq8rF3ncmtSosw7ysXS5bpZhyI9TD0UiBIrH2bJxPyv0E83x3Kusv2rf/Szg7DEw7fXOacqw9xEeuziREVeEBI2HxhvlH8BIkSiEGLxho3gIQhxtO7ATTT3Ef+bShxnbQjhugH93UXPd79AGzeeANYlB3H1IaiHWvleX+0C4M8TJCSw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(26005)(81166007)(2616005)(508600001)(83380400001)(16526019)(36860700001)(47076005)(426003)(356005)(7696005)(8936002)(36756003)(8676002)(82310400003)(186003)(316002)(6666004)(86362001)(54906003)(6916009)(1076003)(70586007)(4326008)(70206006)(2906002)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 14:16:17.4385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ed263c-971a-4786-211e-08d9a2c25494
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2539
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
Cc: Alex Sierra <Alex.Sierra@amd.com>, Philip Yang <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The check for whether to drain retry faults must be under the mmap write
lock to serialize with munmap notifier callbacks.

We were also missing checks on child ranges. To fix that, simplify the
logic by using a flag rather than checking on each prange. That also
allows draining less freqeuntly when many ranges are unmapped at once.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Tested-by: Philip Yang <Philip.Yang@amd.com>
Tested-by: Alex Sierra <Alex.Sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 24 +++++++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 2a5b4d86bf40..78ae96fc8a6a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -766,6 +766,7 @@ struct svm_range_list {
 	struct list_head		deferred_range_list;
 	spinlock_t			deferred_list_lock;
 	atomic_t			evicted_ranges;
+	bool				drain_pagefaults;
 	struct delayed_work		restore_work;
 	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
 	struct task_struct 		*faulting_task;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 065fa2a74c78..77239b06b236 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1991,20 +1991,28 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 		pr_debug("prange 0x%p [0x%lx 0x%lx] op %d\n", prange,
 			 prange->start, prange->last, prange->work_item.op);
 
-		/* Make sure no stale retry fault coming after range is freed */
-		if (prange->work_item.op == SVM_OP_UNMAP_RANGE)
-			svm_range_drain_retry_fault(prange->svms);
-
 		mm = prange->work_item.mm;
+retry:
 		mmap_write_lock(mm);
 		mutex_lock(&svms->lock);
 
-		/* Remove from deferred_list must be inside mmap write lock,
+		/* Checking for the need to drain retry faults must be in
+		 * mmap write lock to serialize with munmap notifiers.
+		 *
+		 * Remove from deferred_list must be inside mmap write lock,
 		 * otherwise, svm_range_list_lock_and_flush_work may hold mmap
 		 * write lock, and continue because deferred_list is empty, then
 		 * deferred_list handle is blocked by mmap write lock.
 		 */
 		spin_lock(&svms->deferred_list_lock);
+		if (unlikely(svms->drain_pagefaults)) {
+			svms->drain_pagefaults = false;
+			spin_unlock(&svms->deferred_list_lock);
+			mutex_unlock(&svms->lock);
+			mmap_write_unlock(mm);
+			svm_range_drain_retry_fault(svms);
+			goto retry;
+		}
 		list_del_init(&prange->deferred_list);
 		spin_unlock(&svms->deferred_list_lock);
 
@@ -2037,6 +2045,12 @@ svm_range_add_list_work(struct svm_range_list *svms, struct svm_range *prange,
 			struct mm_struct *mm, enum svm_work_list_ops op)
 {
 	spin_lock(&svms->deferred_list_lock);
+	/* Make sure pending page faults are drained in the deferred worker
+	 * before the range is freed to avoid straggler interrupts on
+	 * unmapped memory causing "phantom faults".
+	 */
+	if (op == SVM_OP_UNMAP_RANGE)
+		svms->drain_pagefaults = true;
 	/* if prange is on the deferred list */
 	if (!list_empty(&prange->deferred_list)) {
 		pr_debug("update exist prange 0x%p work op %d\n", prange, op);
-- 
2.32.0

