Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C225CC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 16:23:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44BC810E3BB;
	Wed, 19 Jan 2022 16:23:34 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CC2310E3BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 16:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lR+YpqXBe+SucaSaxt26aVY04TE61x3hNlnnJaXFbI6wZFaqrzC5KFHK9Qx/nbROQ/lLUd5jx/vWi/fRH9WCx+Sgn8vy37/DQA9QkFJENingyWJdJlT+dgN2hePslTOIfoK3BnzyiG5vhnnU0MTDF1+BnLT1I7XbLq9hESMzbidO7tc5mdqXeZwoDBivcGgJA2B4HUYn03M7ppyH4W7Se6rZeQAm7UwjKCyVZLs8eWU/KWxg5QrX/8EqvBOBne75Pnp5kg6E74MmKiGXlURNRm8Exy9w2ZrJ5UESVBf0Q1GAWF3o9jeJAAGX4qAuAM0TJY4RCJnHCrjr/FpYmjbhcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQ6QvW97EavMucRopJbb2L7TLVvDsfRctWlgdHd0XSQ=;
 b=mZoYXD16bgYusZzc+85Ra2QkLhNc3FBEe0LF1Shymj9X24ZGFY/SN9EOOCjyiZRrHNItiZu66tLQuFUfjxLB9LcnI4r8YpqmVvxZh7kp0BOXgBTGQ2PuTD0rOtJ3P8/riUhWf+t/aJXW14wR/t+1T7e7QLrRTLMf/Xn82ZSfwqGV4TAufB/VvFvKNrbuSL+GESNM7VnohcQPomVGvGSgeYm5snLhmWfhQnh4sLgLxXpW7lOovBS1mGefSDAChV6/VauD/cl7Fxlr96pjb7qRqcXnNXxfPyWUQJ4IoT7eiHg/xRDpPMm6Z2mw8fhOrGo1yKI+MzSz7uRr7waOOI34Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQ6QvW97EavMucRopJbb2L7TLVvDsfRctWlgdHd0XSQ=;
 b=1/dKfJAIKuREzS7oSgD09F3sIyu3xi1nhrcGnrq5xU1K3eG7GhHFhV/hkhCvyVFRe8RrMpHfJqoJD3seLdEffiPN4HfQbXyMm061CaRb8zy9RtrJ2PkKifVXCO3EIDXR/05SSwFi6YxU5XI2RRuzHSO3l1bbSIhlW+mn3KVgqIQ=
Received: from CO2PR04CA0010.namprd04.prod.outlook.com (2603:10b6:102:1::20)
 by CY4PR1201MB0231.namprd12.prod.outlook.com (2603:10b6:910:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Wed, 19 Jan
 2022 16:23:30 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::e6) by CO2PR04CA0010.outlook.office365.com
 (2603:10b6:102:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Wed, 19 Jan 2022 16:23:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 16:23:30 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 10:23:28 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdkfd: svm range restore work deadlock when process
 exit
Date: Wed, 19 Jan 2022 11:22:46 -0500
Message-ID: <20220119162246.21457-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220119162246.21457-1-Philip.Yang@amd.com>
References: <20220119162246.21457-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 502372bd-f50d-4b1d-76df-08d9db6807b6
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0231:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB02314B3F938B09C6B3C2905DE6599@CY4PR1201MB0231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6FS7dZf2F0iRydqHbCVaXfx2p3nSHl3y2uMH56OruZjDSowRQd8jN1S7ECy7JdAFNtpKp/gd/yBB12DStpjqLTcgU6MQe1TXq/rIwNiUKtNkRGNkh3x7FAmNK3WbwzoR7imYCgCpI4l/Qc0/eFfbJLgi0fIWv/bCD2Ho99yAb4DSBcB+eOSl+liZTd/Ib8PAwPdBmBljKhHEK9cn3u45mwbepYr5927IMVyBFAnkD3si+Nk9/Ozq1Z//B/2VPj2uYgOepIXlkk3NZH6sgTNB4bRlkEYZZ01TZ7/C7YgoSUZ/kSlXtJFPQPLquN+/iZh4rl10Z9EmtMnMDgwrCWMzw1ctiQOwImhhWQZ+mU7596KAMdPAYVj6CUirTBDUC04JekE/DR2gfEZpJLadR16u49Hj4n3Dr2wNvQaisGdsjqL0cxvTJAVZCPkbrufT1Jsc8sVxB/Slv87Vw3crN9+l6XFDl7CKwZt4q1xb77GhPjvysoPTlODWReym3/+kjRdk+xYM1ugmrIwzS5YJslHZcPTqeSLfIQ99XcCOUowTW8O4Hl2/nVFweGPxG6RqI1PIZdkPifSlVrdYYYfzky2vk93k78vWZmI/qsiFp0riFaui7LWTB33u8iC9ZAAiDK6iPNgZHUQsTJWGMFrTwFRhjL4g0QskMP1risN49F2Pfn7nViVdsI1TYrcSGOC7vRpnXAKPyn+0cnaxYD8XVIwR0THdgmHcUpLmAmDpnrsgB0rjazkjV2RxRb9prIH0AOIz2px7g0yma+9W6ew4teAxgryeoMMf/yXU93FeDBkdUDs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(336012)(8936002)(508600001)(6666004)(26005)(82310400004)(7696005)(47076005)(36756003)(16526019)(8676002)(316002)(356005)(6916009)(54906003)(2906002)(5660300002)(81166007)(4326008)(86362001)(83380400001)(1076003)(70206006)(70586007)(36860700001)(2616005)(40460700001)(186003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 16:23:30.0241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 502372bd-f50d-4b1d-76df-08d9db6807b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0231
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
Cc: ruili.ji@amd.com, felix.kuehling@amd.com, Philip Yang <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

kfd_process_notifier_release flush svm_range_restore_work
which calls svm_range_list_lock_and_flush_work to flush deferred_list
work, but if deferred_list work mmput release the last user, it will
call exit_mmap -> notifier_release, it is deadlock with below backtrace.

Move flush svm_range_restore_work to kfd_process_wq_release to avoid
deadlock. Then svm_range_restore_work take task->mm ref to avoid mm is
gone while validating and mapping ranges to GPU.

Workqueue: events svm_range_deferred_list_work [amdgpu]
Call Trace:
 wait_for_completion+0x94/0x100
 __flush_work+0x12a/0x1e0
 __cancel_work_timer+0x10e/0x190
 cancel_delayed_work_sync+0x13/0x20
 kfd_process_notifier_release+0x98/0x2a0 [amdgpu]
 __mmu_notifier_release+0x74/0x1f0
 exit_mmap+0x170/0x200
 mmput+0x5d/0x130
 svm_range_deferred_list_work+0x104/0x230 [amdgpu]
 process_one_work+0x220/0x3c0

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reported-by: Ruili Ji <ruili.ji@amd.com>
Tested-by: Ruili Ji <ruili.ji@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 15 +++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d1145da5348f..74f162887d3b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1150,7 +1150,6 @@ static void kfd_process_notifier_release(struct mmu_notifier *mn,
 
 	cancel_delayed_work_sync(&p->eviction_work);
 	cancel_delayed_work_sync(&p->restore_work);
-	cancel_delayed_work_sync(&p->svms.restore_work);
 
 	mutex_lock(&p->mutex);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 9ec195e1ef23..2d2cae05dbea 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1643,13 +1643,14 @@ static void svm_range_restore_work(struct work_struct *work)
 
 	pr_debug("restore svm ranges\n");
 
-	/* kfd_process_notifier_release destroys this worker thread. So during
-	 * the lifetime of this thread, kfd_process and mm will be valid.
-	 */
 	p = container_of(svms, struct kfd_process, svms);
-	mm = p->mm;
-	if (!mm)
+
+	/* Keep mm reference when svm_range_validate_and_map ranges */
+	mm = get_task_mm(p->lead_thread);
+	if (!mm) {
+		pr_debug("svms 0x%p process mm gone\n", svms);
 		return;
+	}
 
 	svm_range_list_lock_and_flush_work(svms, mm);
 	mutex_lock(&svms->lock);
@@ -1703,6 +1704,7 @@ static void svm_range_restore_work(struct work_struct *work)
 out_reschedule:
 	mutex_unlock(&svms->lock);
 	mmap_write_unlock(mm);
+	mmput(mm);
 
 	/* If validation failed, reschedule another attempt */
 	if (evicted_ranges) {
@@ -2837,6 +2839,8 @@ void svm_range_list_fini(struct kfd_process *p)
 
 	pr_debug("pasid 0x%x svms 0x%p\n", p->pasid, &p->svms);
 
+	cancel_delayed_work_sync(&p->svms.restore_work);
+
 	/* Ensure list work is finished before process is destroyed */
 	flush_work(&p->svms.deferred_list_work);
 
@@ -2847,7 +2851,6 @@ void svm_range_list_fini(struct kfd_process *p)
 	atomic_inc(&p->svms.drain_pagefaults);
 	svm_range_drain_retry_fault(&p->svms);
 
-
 	list_for_each_entry_safe(prange, next, &p->svms.list, list) {
 		svm_range_unlink(prange);
 		svm_range_remove_notifier(prange);
-- 
2.17.1

