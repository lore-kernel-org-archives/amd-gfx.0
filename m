Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE87C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 12:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 550FB10E197;
	Tue, 12 Apr 2022 12:03:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB9CF10E197
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 12:03:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBi9+58Dk2gBwoGNXAJVb3HqXCHQeJibKCgOH2oBiKv1PcENTTPsTeeQH/If0HYcTJV8MSRXUqmcLwmcthdJYNqFHPMtkQKXaNvLF4jiun7r/Hdee2m+azrlcT1bTXqZKl7ntJS4796mRt3+/5WWj3YI33lNBgJcUz05yez5T3DDXaDn0YnwgI1Yt0cCsxoPlAXz5+UEV1GjKJFtpW9aKEindZW/p+68Yq+XfDiSuToLrOdFrgKiN1LQVYrolKqOmh/4V+BYa1G5dTWgsACCf/tYYXnSVScit/r0pZJJ7QdjlpFg1UCOO0LM2QT7FBxtnt0bwqN+PAZzS3IQE+dqIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwWGMTZXoFDsuPaEP1FoKak4PaY7Mgg5UB9IzXiZ8Ew=;
 b=KRLu4TZeYLO5k4Dq7Sjzq5wXrES6gYAD/g+gwAn/sylYnIUbzQsLZHorO7qukZk0EOYoFheWg8ZmEoYnicnIIT7BsUoTUSQCbye098livSPKZ2vzk+uuGKmFDT1vVLoli7Yn245CfPqAbxceM6Nr2dFnS5kAnCuBD5N+HJC/NdWYNI5VkIjcF8VKxAQbj3F1/y8dJ4S0xH5KSLhYujRovjvquMyKrb+u8RJxVHU1Vvirh7sXF1D5F5sb02XNlqs71XmuFX7jLOiaiacyD+O7JB5HfS0YdUX5dxOOQXTQ27jL+IXu8YbImdS7KknBlZ0tcTcxKh+ibB0JUCDApbp86A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwWGMTZXoFDsuPaEP1FoKak4PaY7Mgg5UB9IzXiZ8Ew=;
 b=K83LHHJ5rhGizBooLz8dZhKrdnEsOP6VAfzc6PJAFg6J43Xm4t5tZ34Lidc1vGltMh5W6JdEeC2pKSfcegss22rcj+eXlmqUoPhch/U9llMzz3O7MG9nymZU8NLHiPvKHbkjDc0IMU0OE4xvjhsGR+3GAVWFQc2CFwE1i1Ic0IE=
Received: from MW4PR03CA0125.namprd03.prod.outlook.com (2603:10b6:303:8c::10)
 by BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Tue, 12 Apr
 2022 12:03:50 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::94) by MW4PR03CA0125.outlook.office365.com
 (2603:10b6:303:8c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Tue, 12 Apr 2022 12:03:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Tue, 12 Apr 2022 12:03:49 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Apr
 2022 07:03:47 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix one use-after-free of VM
Date: Tue, 12 Apr 2022 20:03:22 +0800
Message-ID: <20220412120322.28169-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39c24d29-94fc-4ce6-c7fb-08da1c7c8177
X-MS-TrafficTypeDiagnostic: BL1PR12MB5269:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5269515595107ADDA3BC026387ED9@BL1PR12MB5269.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5sJpWDKxIunv/DvEsQ8TkqyydxgB5HrBMG9mEbW/ndGxhD96nYImFNddGT2Sh1NlO/0f+8w+vFSzqi1KFLfGDgTZ5mar5F+6FIGpblHDwM/UCtctkAlnsAWGzrCMxOzolV2/uKDbSnyt7lAvYTbAkvwbHhVvIIO4l6VQNpUtyOSgW8Nm5li3NgpFco3C0WAXsQJ/xXvjQcM4EiGGLYtLac2eAfqaNINCCIpRTkeKQb4LNKO0r27kg9MIAwykB+BMPL6YwoqXufcg/bGeUAkpumkiG+bBTHFvT6jATsde1yzHb8gqC+jhJleB1mMfM65QRsgbJXaEgHAl/wMOf0ei4YSSmXG6iFj5gNOkPIFq2JrWmIPYH4vkPjIv73mB9o/Y3iP+NUgoYP3PQJtnwkH22rg8OCtG4o9VVnGpTWJWRcIFCRmWQZoEEl7BdDbi3TmKI/tw+kMkcUex6I6ThTPnrFpW2JFQFkvYUCAxMp1uD3JqQhJ13wQepNszPoKAoa+0LDn5hx3BuwQZkMKX05YqnZskG/UwL8bHTrMI9ztCF8JFahzMPvELhifYKUtWqRHsLjXNhmMiGYEQFVWSvgQhaN4PSdRFg59BKdbEOn4a6oSkV8bZmcb/o6iQR/ciOFb8CgdU1grsYdDnty8lM66vgyoAGvgUlKi5jnzoxaLfVwdCOn6uGiiETyPiAbKHmxG/mkwWDTBB591VtB8mw2Jf1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36756003)(82310400005)(316002)(81166007)(86362001)(70206006)(47076005)(66574015)(40460700003)(426003)(336012)(54906003)(6916009)(70586007)(36860700001)(83380400001)(2906002)(2616005)(4326008)(8676002)(16526019)(186003)(356005)(1076003)(26005)(8936002)(6666004)(7696005)(5660300002)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 12:03:49.8104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c24d29-94fc-4ce6-c7fb-08da1c7c8177
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5269
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
Cc: alexander.deucher@amd.com, xinhui pan <xinhui.pan@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VM might already be freed when amdgpu_vm_tlb_seq_cb() is called.
We see the calltrace below.

Fix it by keeping the last flush fence around and wait for it to signal

BUG kmalloc-4k (Not tainted): Poison overwritten

0xffff9c88630414e8-0xffff9c88630414e8 @offset=5352. First byte 0x6c
instead of 0x6b Allocated in amdgpu_driver_open_kms+0x9d/0x360 [amdgpu]
age=44 cpu=0 pid=2343
 __slab_alloc.isra.0+0x4f/0x90
 kmem_cache_alloc_trace+0x6b8/0x7a0
 amdgpu_driver_open_kms+0x9d/0x360 [amdgpu]
 drm_file_alloc+0x222/0x3e0 [drm]
 drm_open+0x11d/0x410 [drm]
 drm_stub_open+0xdc/0x230 [drm]
 chrdev_open+0xa5/0x1e0
 do_dentry_open+0x16c/0x3c0
 vfs_open+0x2d/0x30
 path_openat+0x70a/0xa90
 do_filp_open+0xb2/0x120
 do_sys_openat2+0x245/0x330
 do_sys_open+0x46/0x80
 __x64_sys_openat+0x20/0x30
 do_syscall_64+0x38/0xc0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
Freed in amdgpu_driver_postclose_kms+0x3e9/0x550 [amdgpu] age=22 cpu=1
pid=2485
 kfree+0x4a2/0x580
 amdgpu_driver_postclose_kms+0x3e9/0x550 [amdgpu]
 drm_file_free+0x24e/0x3c0 [drm]
 drm_close_helper.isra.0+0x90/0xb0 [drm]
 drm_release+0x97/0x1a0 [drm]
 __fput+0xb6/0x280
 ____fput+0xe/0x10
 task_work_run+0x64/0xb0
 do_exit+0x406/0xcf0
 do_group_exit+0x50/0xc0
 __x64_sys_exit_group+0x18/0x20
 do_syscall_64+0x38/0xc0
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 22 +++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  1 +
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 645ce28277c2..e2486e95ca69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -932,9 +932,12 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	if (flush_tlb || params.table_freed) {
 		tlb_cb->vm = vm;
-		if (!fence || !*fence ||
-		    dma_fence_add_callback(*fence, &tlb_cb->cb,
-					   amdgpu_vm_tlb_seq_cb))
+		if (fence && *fence &&
+		    !dma_fence_add_callback(*fence, &tlb_cb->cb,
+					   amdgpu_vm_tlb_seq_cb)) {
+			dma_fence_put(vm->last_delayed_tlb_flush);
+			vm->last_delayed_tlb_flush = dma_fence_get(*fence);
+		} else
 			amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
 		tlb_cb = NULL;
 	}
@@ -2258,6 +2261,19 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
 
+	if (vm->last_delayed_tlb_flush) {
+		/* Wait until fence is signaled.
+		 * But must double check to make sure fence cb is called.
+		 * As dma_fence_default_wait checks DMA_FENCE_FLAG_SIGNALED_BIT without
+		 * holding fence lock(the first test_bit).
+		 * So call dma_fence_get_status which will hold the fence lock.
+		 * Then we can make sure fence cb has been called.
+		 */
+		(void)dma_fence_wait(vm->last_delayed_tlb_flush, false);
+		(void)dma_fence_get_status(vm->last_delayed_tlb_flush);
+		dma_fence_put(vm->last_delayed_tlb_flush);
+	}
+
 	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
 		if (mapping->flags & AMDGPU_PTE_PRT && prt_fini_needed) {
 			amdgpu_vm_prt_fini(adev, vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 1a814fbffff8..c1a48f5c1019 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -286,6 +286,7 @@ struct amdgpu_vm {
 
 	/* Last finished delayed update */
 	atomic64_t		tlb_seq;
+	struct dma_fence	*last_delayed_tlb_flush;
 
 	/* Last unlocked submission to the scheduler entities */
 	struct dma_fence	*last_unlocked;
-- 
2.25.1

