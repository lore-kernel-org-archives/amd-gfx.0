Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD9AC46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 20:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19A9310E203;
	Tue,  2 Jan 2024 20:08:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E69EC10E203
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 20:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQ7edWrIFofHlPAUO6MWnGE6mnwDy5dj4pr59mY2MA+h2WRVbkH7iryguPhBlGi2BpqdC6pXepLHkmVJ58+bNPPHB4NHEeOUMyTZKICI2UD2Q/GJ60BoDCKKP+zUtuFfBiTcRkrA3luuhB/oy+71LAb375Ws44cJuZ/ZLfVK4u+mFjAurKcIseAUXSkaGhcYfdJdv42D1NYVMH6qIlpO87+kknPhtxbj1T+Klle4jUg7J3uqvxsSAzW/7ZlKn6H/SNB64egq0Vlxd3VIff+oEOjwfi+pFIlo7+k0xuiNF96+1akAxVwW5VKDPMlWT+50aMHGIRAImnxFMVTG//qdrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TdOM2lILHWIH9jhZSxlet1lGP5xfWA78x5C5QGbGEs=;
 b=HKbdOz6jEXUqkxP48ciVHgBcJTVQfT0HCoAW1F+VbDfULKco4fvJZzBhH1VKw4gG3YmL6TRYhPp6dnPmkhC7ZECfY0X1TM6oRTJcZFK94TBg6SDgf7N7Jf4tq1bxZhyrPAPDwgfP/XTmDW2vYuY4q/eAV+bf8L+j8TZ32jQVTsby6b0AAPcr7Ly0yEsTxs72p4s8Xnuk/5BiCHmIwAcPTQmvtGOCEcr9gYGDpEZiSa+GhlWNU7320IY7k1/Rfxk7nDTPTGMDhQDPIAkfQLVju8EODR00sOAHuZzfAgdgekVf58GOwrrwFbTYGIsIHTBl5h1poW78RvCbFP3UgzCL6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TdOM2lILHWIH9jhZSxlet1lGP5xfWA78x5C5QGbGEs=;
 b=sTRtQiXUBGfzy0rGx0Xl3xybM7LZEbyExL6V+06aHPJbtc6BBgahyHwSL4MtamxxRtYzs1mb3roqy4VIJtu3sLlfbE+JGXQ+f/FuGJWZvwt6yHr1nB6zas1BDrr/Ia/Pbr1oMf7zqFkb0VhbtGLqR6srmeWp2lLhwMuoZ46m1po=
Received: from SN6PR08CA0004.namprd08.prod.outlook.com (2603:10b6:805:66::17)
 by DS0PR12MB8019.namprd12.prod.outlook.com (2603:10b6:8:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 20:08:35 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:805:66:cafe::a0) by SN6PR08CA0004.outlook.office365.com
 (2603:10b6:805:66::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Tue, 2 Jan 2024 20:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 20:08:35 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 14:08:34 -0600
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: Fix lock dependency warning
Date: Tue, 2 Jan 2024 15:08:04 -0500
Message-ID: <20240102200804.68030-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DS0PR12MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: e9429e9a-4e20-4f98-fe88-08dc0bce99d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uXs7afXxOBRIm3A3gMM8GEcSHIYwWdeqHLfh9HAlJFlI6uDUSJDezLjJhWGennKYLcd9C7WrvNrpe81jZu3IH2DW6hQAz+DFAoXsHAPcX4dQkDCXl5DKYzBl/AN7R5NjonQny/w4wDoH+izyGx9RlnZrn7XcFrDqSXTD7A699xbPrl1J7x9+/5AMZsq4k6LHoaqZZKUUaA9HHMph/JHhLCvmd1OkYxWvGBbMWhftbBauvY+QuKMvJyGuqj5cBepBsjlT078Kif+5YbecHOXtEwpIbXymkyhMq/2TPgMvgAs3Okf292KmCiHkQdWc/q0ei2tfaBNDnGBbp91dbcggmsDxXRAcOOy67jlwAhN4/ePfbHVb/9xG2ud1afYsAIA5U/dXn3vexatkilpIbthzQW6HMa4x5peoy03no2nvzMFEs0tBqTGMnOR5hMW3MYWXWoWUrIpzOp7RjnhbZ722hZ7pPmDqnmTdofLDfHsKTRtpuwQAokV8iMsGeK5JJkExRodiAHvDNY08BFXvSZafK/ZrUFq0mhnZuexF8TiJbqwpxPSOJk9muO0UwnQkQWsCRosodz+4RDc/VHfLng1DvvCNztxhWfOjleKYCZa64NWWp7OKF/x+sHUXxB5oniG8V1vmOJnfaPl1zvuNKXdRObtb8KYaFOGEBEPucSMAlCwMKtRn+ztD0r85LOvCGbYf88IfrrQqJo97YcG+oGCAz6VA50GCphDn37Lp0c3892JVz8IRSpewe+TUg7XFAfddNLvxzwIwYaYZwlOS3yR38vmjC4emK/Cw1HrQYmW168cEYvvj6ldLTZrfCw5tIUi+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230173577357003)(230922051799003)(230273577357003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(41300700001)(2906002)(5660300002)(44832011)(8676002)(4326008)(316002)(6916009)(70586007)(70206006)(36756003)(82740400003)(81166007)(356005)(8936002)(478600001)(7696005)(86362001)(6666004)(36860700001)(2616005)(336012)(26005)(16526019)(426003)(83380400001)(1076003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 20:08:35.1315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9429e9a-4e20-4f98-fe88-08dc0bce99d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8019
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
Cc: philip.yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

======================================================
WARNING: possible circular locking dependency detected
6.5.0-kfd-fkuehlin #276 Not tainted
------------------------------------------------------
kworker/8:2/2676 is trying to acquire lock:
ffff9435aae95c88 ((work_completion)(&svm_bo->eviction_work)){+.+.}-{0:0}, at: __flush_work+0x52/0x550

but task is already holding lock:
ffff9435cd8e1720 (&svms->lock){+.+.}-{3:3}, at: svm_range_deferred_list_work+0xe8/0x340 [amdgpu]

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (&svms->lock){+.+.}-{3:3}:
       __mutex_lock+0x97/0xd30
       kfd_ioctl_alloc_memory_of_gpu+0x6d/0x3c0 [amdgpu]
       kfd_ioctl+0x1b2/0x5d0 [amdgpu]
       __x64_sys_ioctl+0x86/0xc0
       do_syscall_64+0x39/0x80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&mm->mmap_lock){++++}-{3:3}:
       down_read+0x42/0x160
       svm_range_evict_svm_bo_worker+0x8b/0x340 [amdgpu]
       process_one_work+0x27a/0x540
       worker_thread+0x53/0x3e0
       kthread+0xeb/0x120
       ret_from_fork+0x31/0x50
       ret_from_fork_asm+0x11/0x20

-> #0 ((work_completion)(&svm_bo->eviction_work)){+.+.}-{0:0}:
       __lock_acquire+0x1426/0x2200
       lock_acquire+0xc1/0x2b0
       __flush_work+0x80/0x550
       __cancel_work_timer+0x109/0x190
       svm_range_bo_release+0xdc/0x1c0 [amdgpu]
       svm_range_free+0x175/0x180 [amdgpu]
       svm_range_deferred_list_work+0x15d/0x340 [amdgpu]
       process_one_work+0x27a/0x540
       worker_thread+0x53/0x3e0
       kthread+0xeb/0x120
       ret_from_fork+0x31/0x50
       ret_from_fork_asm+0x11/0x20

other info that might help us debug this:

Chain exists of:
  (work_completion)(&svm_bo->eviction_work) --> &mm->mmap_lock --> &svms->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&svms->lock);
                               lock(&mm->mmap_lock);
                               lock(&svms->lock);
  lock((work_completion)(&svm_bo->eviction_work));

I believe this cannot really lead to a deadlock in practice, because
svm_range_evict_svm_bo_worker only takes the mmap_read_lock if the BO
refcount is non-0. That means it's impossible that svm_range_bo_release
is running concurrently. However, there is no good way to annotate this.

To avoid the problem, take a BO reference in
svm_range_schedule_evict_svm_bo instead of in the worker. That way it's
impossible for a BO to get freed while eviction work is pending and the
cancel_work_sync call in svm_range_bo_release can be eliminated.

v2: Use svm_bo_ref_unless_zero and explained why that's safe. Also
removed redundant checks that are already done in
amdkfd_fence_enable_signaling.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index afd98aace065..6b314e4d3ae0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -404,14 +404,9 @@ static void svm_range_bo_release(struct kref *kref)
 		spin_lock(&svm_bo->list_lock);
 	}
 	spin_unlock(&svm_bo->list_lock);
-	if (!dma_fence_is_signaled(&svm_bo->eviction_fence->base)) {
-		/* We're not in the eviction worker.
-		 * Signal the fence and synchronize with any
-		 * pending eviction work.
-		 */
+	if (!dma_fence_is_signaled(&svm_bo->eviction_fence->base))
+		/* We're not in the eviction worker. Signal the fence. */
 		dma_fence_signal(&svm_bo->eviction_fence->base);
-		cancel_work_sync(&svm_bo->eviction_work);
-	}
 	dma_fence_put(&svm_bo->eviction_fence->base);
 	amdgpu_bo_unref(&svm_bo->bo);
 	kfree(svm_bo);
@@ -3437,13 +3432,14 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
 
 int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence)
 {
-	if (!fence)
-		return -EINVAL;
-
-	if (dma_fence_is_signaled(&fence->base))
-		return 0;
-
-	if (fence->svm_bo) {
+	/* Dereferencing fence->svm_bo is safe here because the fence hasn't
+	 * signaled yet and we're under the protection of the fence->lock.
+	 * After the fence is signaled in svm_range_bo_release, we cannot get
+	 * here any more.
+	 *
+	 * Reference is dropped in svm_range_evict_svm_bo_worker.
+	 */
+	if (svm_bo_ref_unless_zero(fence->svm_bo)) {
 		WRITE_ONCE(fence->svm_bo->evicting, 1);
 		schedule_work(&fence->svm_bo->eviction_work);
 	}
@@ -3458,8 +3454,6 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 	int r = 0;
 
 	svm_bo = container_of(work, struct svm_range_bo, eviction_work);
-	if (!svm_bo_ref_unless_zero(svm_bo))
-		return; /* svm_bo was freed while eviction was pending */
 
 	if (mmget_not_zero(svm_bo->eviction_fence->mm)) {
 		mm = svm_bo->eviction_fence->mm;
-- 
2.34.1

