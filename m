Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558AEC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 07:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D540D10FD9B;
	Tue, 12 Apr 2022 07:17:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 721FC10FCF3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 07:17:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MX1JVlZzx3mu3X1sKGLjiH/5ZVa/znn+g3X/dksdSsUPHWItA2iWxfq+OHARlypn1UNbaXEeNLwssKQN6UNZQDfI7dhJxaHkjHLazj/uHubR8iwZFI6/fDHrHiqfINr4L4/bqLOhplD0EWgu72nmz8BAWk2wL+OWcS2O+VcJMKoYv+LBpcy//3OkvxoNgzbCeA0zlBHWFbSCWzToDUaUYEs7FFQrYxQCQhblcUJX+MmolxJ/XxTEJvJtD9ulGdDqd2kQ7iYJwBRO2Vww3PrjhVM/8pdVwKPm22hw/LSdkXOwH6N2o/EBxnGx3WcYRWhUW5VlL7vuY1v0+wDxuPymvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPtYsKKgx0GvoFvMH53uIudi9EkAmd/6r6IMCB2Wt5A=;
 b=C0TxLCjWIxP1VPwuq1RhlT4XwOLp3pee8z0knPwnTxHLfFbg9keLDjEizJJmiSXhElJoXBVZ2AsL9bY2i9AZo7auxSe4GUMqw9M/2KJDe2mbdiB77tDI0ST7Hf8EheP+wK0xlSKUTp36Ai/rTGt1uULbGNA6bHnh5flQLBs+Q6FGIc9dDz+I/W6DPuX4j28OihAJzVaEq39IJdmLtS9c1dX7U82EJC5QwINRM0suP8mfM+MiPsf//q+JG5kayJwE8n03hi9QvhLviIkJNVatE+V2Jwg4+Dt848yOpQTDBnzkafbHaMoqWpdQJz/Baz7mV0wUXNdtZJCsNjsfmEk6eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPtYsKKgx0GvoFvMH53uIudi9EkAmd/6r6IMCB2Wt5A=;
 b=sNqhk86TRZhVoONREZh8IRHALdV5sLVM7U/aRWkTpYY9hNGftoBiuj7KHFAyS/jSDR+/rmHJ/rblejv4bS4MsiSbu2KCB8lLVUhHlAH8nEYziNqPEgyJ+DkHuCP6hDys6ItTlZlGy7I0CNev2XNv8Q5c09Gm/O4jrOdZLNF5ahU=
Received: from DM6PR06CA0030.namprd06.prod.outlook.com (2603:10b6:5:120::43)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 07:17:17 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::ee) by DM6PR06CA0030.outlook.office365.com
 (2603:10b6:5:120::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Tue, 12 Apr 2022 07:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Tue, 12 Apr 2022 07:17:16 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Apr
 2022 02:17:14 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH] drm/amdgpu: Fix one use-after-free of VM
Date: Tue, 12 Apr 2022 15:16:56 +0800
Message-ID: <20220412071656.16500-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1a1824e-5129-413f-59b1-08da1c54797f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4222:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4222035066C14967C9B0717A87ED9@MN2PR12MB4222.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6lnHILev5Ns2OUCYrvmuuQKPGiNxkZ7rgU6vai1GfDifVxwu0+TLUxYwJlOCUsN52h/jNxpXY3RMd0uj33Th8NTOppHu2pRjh1aXTmGHvxRK/7rNO+wNaIqUPjDq20glIlnxOmDn4eCGAmFlwp7em5hXvjSmcSzf/Dj32GraXUiewZZWU539Rc0pkYw/LLo2pLhdp1DvaenBvIc/hLfS6TLtMMgcR1nGSIgx4AN+nCMjbxBb2MOaRp4Vjux60q+EK6IiaYK1kFhll3j7NEe1tRq9VhOrgEY5UsEyLgmHN++CsCfGiLcnwY2ioKnG6NNjSs14nscdipazHleqIG/9qItzQH/vQLqLxaz5tPlXfoKF771IJ/gOVwNL3Yjr5yynVywksam2ajHQIqX6/Qf12PoySF/vHZ7iDYd5Qux4F46jhaFzE5FDMTSEQFWBGcaWpTl16cYUB6n3j8SmAatmsnIxNHkopPrv1iNkRwCRqgAs//IooEbL1qRsLMQWaD7k9FfGUyZGvUy+mAQNR3R6NYpMJWNIAP1gNjR2BRlsWOZklCVCP7ePwKI9xCvPCi1GBk7pbyTK9AoAdw+RmNfM/3g7zntq16LlTJo4B3Sj3JTVunEpH+3MR5aqIuGmB8kBX/mkCHwqL71mbPrChvP//AXsZvRDpYVlFagQ0LXpy1jvHfbQXhoYg5Mv2ive+4wDJzRBIW7ZXU9iccn++8mb1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400005)(2906002)(81166007)(36860700001)(5660300002)(8936002)(356005)(86362001)(316002)(508600001)(36756003)(54906003)(6916009)(2616005)(6666004)(7696005)(47076005)(1076003)(40460700003)(83380400001)(70586007)(4326008)(70206006)(8676002)(426003)(26005)(16526019)(186003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 07:17:16.6628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a1824e-5129-413f-59b1-08da1c54797f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
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

VM might already be freed when amdgpu_vm_tlb_seq_cb() is called.  We see
the calltrace below.

Fix it by adding vm.delayed_tlb_flush and check this value in vm_fini().

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

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 645ce28277c2..0e89f42283c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -789,6 +789,7 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
 
 	tlb_cb = container_of(cb, typeof(*tlb_cb), cb);
 	atomic64_inc(&tlb_cb->vm->tlb_seq);
+	atomic64_dec(&tlb_cb->vm->delayed_tlb_flush);
 	kfree(tlb_cb);
 }
 
@@ -932,6 +933,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	if (flush_tlb || params.table_freed) {
 		tlb_cb->vm = vm;
+		atomic64_inc(&vm->delayed_tlb_flush);
 		if (!fence || !*fence ||
 		    dma_fence_add_callback(*fence, &tlb_cb->cb,
 					   amdgpu_vm_tlb_seq_cb))
@@ -2257,6 +2259,8 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	amdgpu_vm_set_pasid(adev, vm, 0);
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
+	while (atomic64_read(&vm->delayed_tlb_flush))
+		schedule();
 
 	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
 		if (mapping->flags & AMDGPU_PTE_PRT && prt_fini_needed) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 1a814fbffff8..4dc9f493d355 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -286,6 +286,7 @@ struct amdgpu_vm {
 
 	/* Last finished delayed update */
 	atomic64_t		tlb_seq;
+	atomic64_t		delayed_tlb_flush;
 
 	/* Last unlocked submission to the scheduler entities */
 	struct dma_fence	*last_unlocked;
-- 
2.25.1

