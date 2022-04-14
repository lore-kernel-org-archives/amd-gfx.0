Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18EFC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Apr 2022 05:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EC8910FCF8;
	Thu, 14 Apr 2022 05:04:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BCC010FCF8
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Apr 2022 05:04:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6OFOO8QgWKXG/z034QGON1kKTDHpaciUNuH/M46xko7wGrSjRqgnHWseTS2LAtvlh4gQpb0s6zqMrqkQSYeiwdM7kQrPTNzJppvlCW/e1p3ci2lYix/qrPwOlPtXOiu5thKp84PJgMCS2EqG+DI1DkRDwsLqQsoR5TEaQ11LmUSpiTEcq/9YN3AwwCgVTR7Z2jVqrXEtmyJm5Jz6L98hf+ZuG86izvAZ9kVgz9CRW/q1lRIFkP7sQl0EWTwi7hXqe7zrf2BQbz5Er7kDoGMOGa6TgJlt02Fp2lmmHT1iPDkSCaQhgxiNgrYQS2m5vaHm9okQPEvhpDZQ8wxOnu9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zGK1wNXVjylS5+Ns73pRNSQpnKU00iJiuYP69xGHTM=;
 b=AzyJ1/maUmnYF1qhisVE999YWK5BKjr0FP7l8bUGHEe9ydLOOvTgL0z6/YzdQWzLejdoeC5OgeENa8CMPSOs8Dw2U7SY4LrXsbMQoFrD7y9Es68rljL043+AcMBbJJadaAIFtcmTMr0VwTZHKjqOm+Tzuyuh/DorixFgf1qeL2D5hoohv4U11/28pSlUsqDRW3TXDvkvQOziXib1MXFh0tLBnl+Z3f8n7PiCdUFv11p6t/LKXubpbc6RWysCo4u8zx8tMCAHtQ9rHnfPGOPW9h+6efe2uQ/XTrdOWoEbIstw2T1bLpUH870fGZvi36USM0kMk2rDxUVlgK4i5vCudw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zGK1wNXVjylS5+Ns73pRNSQpnKU00iJiuYP69xGHTM=;
 b=jNqTQy4wM3JTUoWvar7+OauBzb9xBwa5x4W5PVXAIHXmKypGgqvHz1dElnvPwkxv0tS75kpix+OxgDTXAhSYV5Sgg3w+fLrCblOeGyL6J68kMyKd3J7BBurFaZuglqCRt36rOwE06oOzBP5bl37TtAPZIkr7c9owUFyZMM3Gpm4=
Received: from DM5PR07CA0095.namprd07.prod.outlook.com (2603:10b6:4:ae::24) by
 DM5PR12MB1452.namprd12.prod.outlook.com (2603:10b6:4:a::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.30; Thu, 14 Apr 2022 05:04:31 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::28) by DM5PR07CA0095.outlook.office365.com
 (2603:10b6:4:ae::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Thu, 14 Apr 2022 05:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 05:04:30 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 14 Apr
 2022 00:04:01 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Fix one use-after-free of VM
Date: Thu, 14 Apr 2022 13:03:48 +0800
Message-ID: <20220414050348.8888-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f252d6b-5eb3-4b98-e036-08da1dd44253
X-MS-TrafficTypeDiagnostic: DM5PR12MB1452:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1452717D86B9581D5EB152E687EF9@DM5PR12MB1452.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pglTdP2gXBP5wiANRHVEsoixYRKLwAgv2ios1/ZK0+pPdXxYFl9qZPiTCUzWBUlSXcspMXRjSbcZDBe3uJxSiYcJeMAOVJxCS3/XN2Y34+Zny7L+ZA7Xa724yYV/XU5zKrFzL95pZW2kS4aV3mUu27K8+Mz6QGGS3oMnhEkuoSrgfDFjbo35TKd5mmyGngmmyMGJ0mF3yZuK0gPdbSHD5lqHX9ZtTGjtKPwnovEZpsgqJlv4fQMqCNWO6+bgqeIl8B4d/C5ULsx88aBszqwzPwmlcCQh5XH4j5S0d0W/FD8yXiB3+wI+Od8N5I6sc8jEsiBg3UST/RwglCDXfgNCTVZAEBC+QgTfAFY3oB0Caas9D7Y/ExNIyaqit7aLk9L1SA36usHiLasR1fHuDUkHzs1Ac/XxShMW8fGmYZ8gpLZupSd5amELUcAidV4qvogAPe4cpfiL9MygQ3J5f9jDSF0oDZYxVygOMONQ2HmdKpkhWuEOfZLodClDp2vYvEPc+IcEN7g6Jz8Knmd2/hT6hkO7Sjh7PT/ZqLnOpBW1TSp+j7pKX+QofOYjcR6PgMXaTqolsMv/snzCtKT5s3wsyr7N3QNfi/te+Om5OFKfl0VkaFMOJYycNN4uHl0J3zjW6WBrdDvsEE5V8ArEHi8HAzZ5Qc2FSwo43FH0mDiOt7wBhUouAzHm/9NEwjLiDx0QurRzCI6A5yELociQ2yKzT1sbW/wNU3Q+vheZBtJHgp8U4lH0b3D55wjmxWvnu0kV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(5660300002)(86362001)(4326008)(8676002)(70206006)(6916009)(356005)(81166007)(6666004)(2616005)(1076003)(40460700003)(8936002)(508600001)(7696005)(26005)(186003)(16526019)(70586007)(316002)(54906003)(2906002)(426003)(83380400001)(36756003)(47076005)(82310400005)(66574015)(336012)(36860700001)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 05:04:30.8318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f252d6b-5eb3-4b98-e036-08da1dd44253
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1452
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

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 ++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  1 +
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 645ce28277c2..cd5aa7edd451 100644
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
+			dma_fence_put(vm->last_tlb_flush);
+			vm->last_tlb_flush = dma_fence_get(*fence);
+		} else
 			amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
 		tlb_cb = NULL;
 	}
@@ -2094,6 +2097,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		vm->update_funcs = &amdgpu_vm_sdma_funcs;
 	vm->last_update = NULL;
 	vm->last_unlocked = dma_fence_get_stub();
+	vm->last_tlb_flush = dma_fence_get_stub();
 
 	mutex_init(&vm->eviction_lock);
 	vm->evicting = false;
@@ -2132,6 +2136,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	vm->root.bo = NULL;
 
 error_free_delayed:
+	dma_fence_put(vm->last_tlb_flush);
 	dma_fence_put(vm->last_unlocked);
 	drm_sched_entity_destroy(&vm->delayed);
 
@@ -2248,6 +2253,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	struct amdgpu_bo_va_mapping *mapping, *tmp;
 	bool prt_fini_needed = !!adev->gmc.gmc_funcs->set_prt;
 	struct amdgpu_bo *root;
+	unsigned long flags;
 	int i;
 
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
@@ -2257,6 +2263,11 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	amdgpu_vm_set_pasid(adev, vm, 0);
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
+	dma_fence_wait(vm->last_tlb_flush, false);
+	/* Make sure that all fence callbacks have completed */
+	spin_lock_irqsave(vm->last_tlb_flush->lock, flags);
+	spin_unlock_irqrestore(vm->last_tlb_flush->lock, flags);
+	dma_fence_put(vm->last_tlb_flush);
 
 	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
 		if (mapping->flags & AMDGPU_PTE_PRT && prt_fini_needed) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 1a814fbffff8..6b06a214f05f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -286,6 +286,7 @@ struct amdgpu_vm {
 
 	/* Last finished delayed update */
 	atomic64_t		tlb_seq;
+	struct dma_fence	*last_tlb_flush;
 
 	/* Last unlocked submission to the scheduler entities */
 	struct dma_fence	*last_unlocked;
-- 
2.25.1

