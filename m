Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF4DC35274
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 20:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7800610E710;
	Thu, 21 Dec 2023 20:40:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 591A510E710
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 20:40:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTsdv8bm3iL9h4zPUo9Jf6tHdGiBGmFWIfV9JElCKPAYXtYMwqxJKaztjzNiAjIaqtGkj+kDsCTc4X5YZjC6u54PUnhtPLbe6pCTilypGvIbdz4wKPGPu4wL4cuY1os9mfx5Nqbf7Ood/LRxTYAfo1Bxoj4hfcXIwF3ewsTJyLQevfrSYoS4CvhBgPwNVm/5Nt0FOnLYq1WsDrrxqhhI0bQlHX4P9XMuNaj8FT/dEFBtZaVCta4Mvqu4mpQxHfnWx8YqqwRqmvqLMUa1c3oPvx54O2WehqTeRMOA5LMEJm/Wbuw57o3YDbLpstDOfe6+FEaG91Hg7uC+YS+hyyAVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4boL1LO8A/nTURwGKX15dkyTU5ZLiEFVDSl+c7Ijy4=;
 b=j84u5anVvNhBEVDl/K4Pp5cJLAz5ru9EZoT0JK+nnWnPFMOINC6O7bCylvE4FveEhwNgcjlndNAsg0wXllnIMWOUf+dmSjT15QP8FQhruhBIC4ZeyYXzEGXjcWfICZ+QPEozFjz+wCk1YEUSVvgDOjAK/rIL0a9HEznTqJlRXzZ3KgvF2nSaNrwi+r9RaMscduP40bnLTN04T9eowT3tlgjufyPof/cVFcZ4QRkm2vSBYc46baf+qdSL24km9PulzFlIyGt57yNLH1jdIiC/RHyQAoVTCh1+wFpcEIq48dHc0j41BQUyF4lDgn3JAOZIHcGCm+BcJQWVT7c9vZ6JeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4boL1LO8A/nTURwGKX15dkyTU5ZLiEFVDSl+c7Ijy4=;
 b=RJE1yE0eGuCucpXImRNFgTVdz+jDJXIicqwVwpKdYdDSV+LTMb06y3CoAIec8uDNO4mt+mkeujdq5RS3MkQYNdRItw+y0TLKXdx/9FjcGe3T5ThI4skUy4MSiP/9yqIrAcBNF7uHgXd+OXBkL1M4hAl2EXJ7Q0T1NhEr5znhLFA=
Received: from PA7P264CA0097.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:348::15)
 by DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 20:40:24 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10a6:102:348:cafe::66) by PA7P264CA0097.outlook.office365.com
 (2603:10a6:102:348::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.34 via Frontend
 Transport; Thu, 21 Dec 2023 20:40:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 20:40:22 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 14:40:21 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix lock dependency warning
Date: Thu, 21 Dec 2023 15:40:04 -0500
Message-ID: <20231221204004.830821-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|DS0PR12MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1a452f-ab15-4953-c72d-08dc02650e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: duR3VcEUmeawHiPJ3L/q7lnDuiipuYqLT02XYIn2gE6CRVyVtzaj99CUGIejU934WPBep+D4kUF5BvMGVoUf6ypUD4JhCgUiIKBIzMRua//WYRkuQ5hReeWPetygpUC72bYzwzpZKCC8OnggO27rp8Im7oRC3Jlfgbao2RqHimhzRfH2zagIp+LUCjSTRN7Pvrs4WxceV8Aj5w9xF796rmbwThSy4jWYYYEu65sFPgm3MitidUY7GVFCO6wIUMkqsXt3ZbHW8BSg0R2OFIGRXpdBPChoq7S0JSgjqAHPBCgco3YrX4tMXrwSm2kCulO/A0ktzLPGLXzZDMErdMS0CoNt9gT8Nt26qAEoPTjUKwlAv1Ol5Uom9Acp0Aica+ySAo2gIBPp3xA/RPpts9wKgey8lhUtDK9mOqzI02Y4/LZaYzyznfrtpo3i3vF2dBzx9hCoph0wNwaUF1oseA+e94IuykdSgijRn1xvrTPocyXjGPzPWBumd/12ij2c1tW5asI3PrIGiSYKFP77+m1g6qDkaYLwupzvsg2tSIX3B0OrygtVMrqnxbtKnQnROhlAu8UteZnJmQGOGJiUAK2ENpaOX7P106sNRn3H9DfeuvDNUARslYbLdH+4nvW816+VX9uYaNLx4rSZy2ufus+VhLvxIaGoMJd/tP1TUvDbUG1sRPI19PIBU3holhnQW+u9aIjzBWqv+0sDIN461R7Q38thfyHhcsZz6vlobV9DkGtpuMCA7CnOVg/FL+T/uktlgfhAntbrrqEBj3jffjIArmVrF9VxG0cCDbr4S88gLyPhc5FcT6YJQzZl0uYLrxbq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(230273577357003)(230173577357003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(40470700004)(36840700001)(46966006)(6666004)(7696005)(2906002)(86362001)(36756003)(356005)(478600001)(36860700001)(26005)(41300700001)(1076003)(47076005)(83380400001)(16526019)(82740400003)(2616005)(336012)(426003)(81166007)(5660300002)(70206006)(54906003)(70586007)(40480700001)(316002)(8676002)(6916009)(8936002)(4326008)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 20:40:22.9092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1a452f-ab15-4953-c72d-08dc02650e01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456
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
Cc: alex.sierra@amd.com, philip.yang@amd.com, xiaogang.chen@amd.com
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

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index afd98aace065..7683c96f0cbd 100644
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
@@ -3444,6 +3439,8 @@ int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence)
 		return 0;
 
 	if (fence->svm_bo) {
+		/* Reference is dropped in svm_range_evict_svm_bo_worker */
+		kref_get(&fence->svm_bo->kref);
 		WRITE_ONCE(fence->svm_bo->evicting, 1);
 		schedule_work(&fence->svm_bo->eviction_work);
 	}
@@ -3458,8 +3455,6 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 	int r = 0;
 
 	svm_bo = container_of(work, struct svm_range_bo, eviction_work);
-	if (!svm_bo_ref_unless_zero(svm_bo))
-		return; /* svm_bo was freed while eviction was pending */
 
 	if (mmget_not_zero(svm_bo->eviction_fence->mm)) {
 		mm = svm_bo->eviction_fence->mm;
-- 
2.34.1

