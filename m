Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9764C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 21:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48B2810E1DB;
	Mon, 24 Jan 2022 21:12:09 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2073.outbound.protection.outlook.com [40.107.100.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBC7E10E1C8
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 21:12:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VU5rgavy0jrKRcarIbxvQFvU5fwFl62kSpbpnxZdWG3yCFlHTsJUopxAT1OtQFK3mFHCulDSpFJkeYeyeuMPqxNGp/hKZjrl8X4utm854OrBoTe3pHQWe9ZQ/6KOrTY+OHyG1BvjnUdepM6KpuNg9C6NOBK5ikQAdKydS9k59GTqs4MvczIhmorJrTLpPPWHxUBm6+iY3fIzQXmpLaBWbqkjtYf8+d0jehtm6uEIIcwDVA9WR0dg5G6kmdONELWaHofKWV4jrw0O4LVXKDHeTp8I2+ttgQl7wG7uQLKTX9edjhqREurApBHQwd07i2sF1Yhz1qOtLCOyYOR2nm2GSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liZ+oFYg2KrFcrFcVhR1O60u1T3HzDScU72/ueAeN0o=;
 b=Z+vdddyBGCsgUugrY07AELk3BjYv9CcLnrwSXi4FIPf7R4FUeV79ocnplhq8kNHtAXWrjzbstWi5dXXzGqXm0Z5WOk5WfLpz4hFLq7uaGNTbEjteQnMrCkFGPLgHnZIQCIaUaPr8oA2kN6mt0CyyW+vUXm9RucksLKPaFYUTUaPdlBtGWf/y7jqw0pQLPQMC/LcZbrgGvCkdW0+YSMCfUBVhzC3jDEcY3og+G8AHCq+FEJO69dO2Luh34DOxlGgqburigW8iBinLqJdb58tXytV5abpMf9dsIQn332AtC8owiCuzfV2kEMLJf/suVhWYfsuI64Zv31DJkK5XW8MDkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liZ+oFYg2KrFcrFcVhR1O60u1T3HzDScU72/ueAeN0o=;
 b=iVOapMpXvTxr9LUcJurJTzWvUwVYvFn7B+50FWU9OUudT0GZwK/HeQ1yrYe0yTMf3WXS0P0nBpJLBQp115ktarzitn45XDHTmP94Ab0fcrKf9MQr2TZKGDu4igLf4WaQ4D2wP9CDkhsK7LiCVlNf2nF0nYf4VYKhOJvSEmzIKnE=
Received: from DM6PR12CA0029.namprd12.prod.outlook.com (2603:10b6:5:1c0::42)
 by MWHPR1201MB0221.namprd12.prod.outlook.com (2603:10b6:301:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Mon, 24 Jan
 2022 21:12:05 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::c) by DM6PR12CA0029.outlook.office365.com
 (2603:10b6:5:1c0::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10 via Frontend
 Transport; Mon, 24 Jan 2022 21:12:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 21:12:05 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 24 Jan
 2022 15:12:04 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amdkfd: Ensure mm remain valid in svm
 deferred_list work
Date: Mon, 24 Jan 2022 16:11:43 -0500
Message-ID: <20220124211144.15161-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f0bc125-8f7c-4e06-a88d-08d9df7e2c7b
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0221:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB02211B333BEAB2758E750A07E65E9@MWHPR1201MB0221.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3cbh/VMboBMEH88Cp4dxGPecYCLQNsjniezxQ2Wefafo3TzAQx+4HvJP7ILaNmAdAE7XnNgaPK0h0HdJSNA4oxw8ZhevsFk5Q+GdV6wgzAfLHvNm6/d69bdVOlg+OTyXbiySLuh1pmtE61yTznefIjghHq9Bw5wesQ6yBQtxAZPAYsNKrj9KTP8ycu89aLITigIGDhAXDWhWIqlMglkFWjZaPm/CYWN7ykN169AqeSVUBooSJhMuUWCxwS1z5wFOATGw+kkRvwxFBhAaiivx34PYdk20Ju7eQ9GS7mTElAC6Mb0hq7AmkPHE3uIptSpjSpBZhcG6mrC1pimyyswfKOE3Z2iKXr66KocxvFczNcZmz9JpM/jNgl1Tx0sT5sBmzys8LhswbUowzQq7y9e/WbkL9fu7Xk9BpVOuqpm11arQ7RsdhidXcT9tt027+nHPE+C7taT6OiBcUqORHYR0+MtZMKFlD+rFiNOB0DaV4PqQzzADEoCW37DEv8lCYLfCsI0bz4xx+5XKXjtSVqNrocP9DD+ct3GAAagI4/81h/WLuA4ibMVaDaIe6lrUQtSndWKjbNhgpQU1Z43MzSanPMh9Q9d+cYFEqqr1l9SrXnOIWbWv+mntj0iZWmF135Qyjk7WOQg+J64sGgftG9Q0IKFBWCQqcV8lHwS7zf/kNZt2tvbDs2BkqhsYcjqqNIF+WixP9st31vMkMgbHNTpXAOPQcrNgGzW7BAfnEn0kExWIOnJMSdV9yx6riqnHxVakxhzIzCsmq9p1dZ6o1HtCpc7XwQc3vW5LE5W+nIqzNTM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700004)(46966006)(86362001)(1076003)(186003)(16526019)(8676002)(7696005)(426003)(336012)(356005)(2616005)(36860700001)(36756003)(40460700003)(6666004)(70206006)(5660300002)(70586007)(26005)(47076005)(508600001)(82310400004)(83380400001)(2906002)(54906003)(6916009)(8936002)(4326008)(81166007)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 21:12:05.3873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0bc125-8f7c-4e06-a88d-08d9df7e2c7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0221
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

svm_deferred_list work should continue to handle deferred_range_list
which maybe split to child range to avoid child range leak, and remove
ranges mmu interval notifier to avoid mm mm_count leak. So taking mm
reference when adding range to deferred list, to ensure mm is valid in
the scheduled deferred_list_work, and drop the mm referrence after range
is handled.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reported-by: Ruili Ji <ruili.ji@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 62 ++++++++++++++++------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index f2805ba74c80..225affcddbc1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1985,10 +1985,9 @@ svm_range_update_notifier_and_interval_tree(struct mm_struct *mm,
 }
 
 static void
-svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange)
+svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange,
+			 struct mm_struct *mm)
 {
-	struct mm_struct *mm = prange->work_item.mm;
-
 	switch (prange->work_item.op) {
 	case SVM_OP_NULL:
 		pr_debug("NULL OP 0x%p prange 0x%p [0x%lx 0x%lx]\n",
@@ -2071,34 +2070,41 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 	pr_debug("enter svms 0x%p\n", svms);
 
 	p = container_of(svms, struct kfd_process, svms);
-	/* Avoid mm is gone when inserting mmu notifier */
-	mm = get_task_mm(p->lead_thread);
-	if (!mm) {
-		pr_debug("svms 0x%p process mm gone\n", svms);
-		return;
-	}
-retry:
-	mmap_write_lock(mm);
-
-	/* Checking for the need to drain retry faults must be inside
-	 * mmap write lock to serialize with munmap notifiers.
-	 */
-	if (unlikely(atomic_read(&svms->drain_pagefaults))) {
-		mmap_write_unlock(mm);
-		svm_range_drain_retry_fault(svms);
-		goto retry;
-	}
 
 	spin_lock(&svms->deferred_list_lock);
 	while (!list_empty(&svms->deferred_range_list)) {
 		prange = list_first_entry(&svms->deferred_range_list,
 					  struct svm_range, deferred_list);
-		list_del_init(&prange->deferred_list);
 		spin_unlock(&svms->deferred_list_lock);
 
 		pr_debug("prange 0x%p [0x%lx 0x%lx] op %d\n", prange,
 			 prange->start, prange->last, prange->work_item.op);
 
+		mm = prange->work_item.mm;
+retry:
+		mmap_write_lock(mm);
+
+		/* Checking for the need to drain retry faults must be inside
+		 * mmap write lock to serialize with munmap notifiers.
+		 */
+		if (unlikely(atomic_read(&svms->drain_pagefaults))) {
+			mmap_write_unlock(mm);
+			svm_range_drain_retry_fault(svms);
+			goto retry;
+		}
+
+		/* Remove from deferred_list must be inside mmap write lock, for
+		 * two race cases:
+		 * 1. unmap_from_cpu may change work_item.op and add the range
+		 *    to deferred_list again, cause use after free bug.
+		 * 2. svm_range_list_lock_and_flush_work may hold mmap write
+		 *    lock and continue because deferred_list is empty, but
+		 *    deferred_list work is actually waiting for mmap lock.
+		 */
+		spin_lock(&svms->deferred_list_lock);
+		list_del_init(&prange->deferred_list);
+		spin_unlock(&svms->deferred_list_lock);
+
 		mutex_lock(&svms->lock);
 		mutex_lock(&prange->migrate_mutex);
 		while (!list_empty(&prange->child_list)) {
@@ -2109,19 +2115,20 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 			pr_debug("child prange 0x%p op %d\n", pchild,
 				 pchild->work_item.op);
 			list_del_init(&pchild->child_list);
-			svm_range_handle_list_op(svms, pchild);
+			svm_range_handle_list_op(svms, pchild, mm);
 		}
 		mutex_unlock(&prange->migrate_mutex);
 
-		svm_range_handle_list_op(svms, prange);
+		svm_range_handle_list_op(svms, prange, mm);
 		mutex_unlock(&svms->lock);
+		mmap_write_unlock(mm);
+
+		/* Pairs with mmget in svm_range_add_list_work */
+		mmput(mm);
 
 		spin_lock(&svms->deferred_list_lock);
 	}
 	spin_unlock(&svms->deferred_list_lock);
-
-	mmap_write_unlock(mm);
-	mmput(mm);
 	pr_debug("exit svms 0x%p\n", svms);
 }
 
@@ -2139,6 +2146,9 @@ svm_range_add_list_work(struct svm_range_list *svms, struct svm_range *prange,
 			prange->work_item.op = op;
 	} else {
 		prange->work_item.op = op;
+
+		/* Pairs with mmput in deferred_list_work */
+		mmget(mm);
 		prange->work_item.mm = mm;
 		list_add_tail(&prange->deferred_list,
 			      &prange->svms->deferred_range_list);
-- 
2.17.1

