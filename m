Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433E7C47258
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 17:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5966B10FB8A;
	Wed, 31 Jan 2024 17:15:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB39010FB8A
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 17:15:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpxCcsmQKWytaQXRYBdhzc5B+BdCJkHIkchfAUEkA24bRvv28dNwGWSx+GCj78Hi3TsCEkViUk61nJbIV3DwWkkNg6N9QxUBVNkePckdZQbGGJd3zoN0bZj4/MhSgAdsbsZ5N4/NKzSO0u6QeXe4Ai0lgeT9raW9Dgax5xNZYTJmor9sEy8uRvMqPNfvvIS81Drms5AZAL24Nkm6WjgLT2mCNtG5sVdkYlmHi+6eAT9KP/0kw90A2dyFe4B1YjUlBijFpzm2DSKacUPrU0OiwhqbNX4kDXvARfbA940vdNtfef87w6MZGnpfHNbL2r4OE0MQMLbUvA16zEpa+C3Lyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CQk840NsgfQ580FsXA/3bKg1+OiKk1kImnDoM07Ajw=;
 b=HXz4czvmncGzRXpsQi6ldSFf9nDjqzKYW3zHpO+oqwHclN95Umscb1Wp7FlFIWqIuKDFsbK48yV1fBZDJJt158eZTFVoD3avbuEnGxGFoC/c8K/XPzMmxQTe372oRhK7UxWmPCmfFqP110JYAzgN0zAB/JAvcjYlszvisWAAmRBiXgKQYOfc9sLnDpiUc/dKcB+j9huieBsjj2IGPvVNInJE8ynSqioX7W+5ZeCy3wdw+AdPDD/u061KrcdUNVn2KnSvnkbRqkOHlTBaoP89wBt/Onh0cpODoXRyz+HdBg0fP9og1/49RLG18syeLrxOUtbUN9NbMFXKsVx9sfZKOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CQk840NsgfQ580FsXA/3bKg1+OiKk1kImnDoM07Ajw=;
 b=pK+3myxxpfb52sbQ51UMqV1ijsShhs+N4KOFyDc+1Q4fXFFvSBkXSlqurecY9bC4nsPy9fqI4zUv3sxHoFgh+ZV+uoiUmg7BXZQVJMEyu/zUxo03YEb0D9bsnUtHeFyk7zaQoz4sSdVSuBc9dcTbF1StUf7OMfvRJBo7GrFXu6w=
Received: from BN9PR03CA0371.namprd03.prod.outlook.com (2603:10b6:408:f7::16)
 by SN7PR12MB6983.namprd12.prod.outlook.com (2603:10b6:806:261::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Wed, 31 Jan
 2024 17:15:16 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:f7:cafe::80) by BN9PR03CA0371.outlook.office365.com
 (2603:10b6:408:f7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Wed, 31 Jan 2024 17:15:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 17:15:15 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 11:15:11 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/3] drm/amdgpu: sync page table freeing with tlb flush
Date: Wed, 31 Jan 2024 18:14:34 +0100
Message-ID: <20240131171434.256-3-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240131171434.256-1-shashank.sharma@amd.com>
References: <20240131171434.256-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|SN7PR12MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: 22a2ce10-8f79-44ec-4571-08dc2280315d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ltuPkj9dRfFHqR6HQiCTPG9GqYJKen3OH/Lh/Pkdm8qYyPGmSyiss21e2N46EBx1j0djFIVeBUPaZNi2Pv6rrfPIdi9QV35x4/KRsFY5A64z2SDibJQVdr92+t3y785dFOaC+PZgklDQc6wZIHHnKK9TxCmf7b8VwMzKYVvv8VvDwIRejpR367u99j8IlQ2V2KT/8tuLEUXFF3DtD5dI92qahwzTSxF58atUqT1lC8gIzTSZ8wMkxhczrjjNasra8y4zWwkFbYuFQHprG8WEeJtlArodQAwGIOFRj987R8FqW0sAEHBTzaMUENXH9mcruYlfa7h6GmIRJpBNtg0cw6pTRXlAS6I1dJDBa8zliPAWhCFarYSgrJJ2MQXp7AViQQ1I3pecnZ7YeoWxZkEJeJdMRjrjd6TVwI5lX6yt8V/Avbqgg8w4Wz2laolrLIbeU1HJ7QsBMRk2Y57hz8WYeltQMFa79LSTt2hmsYwug1Iy9l+tudP66C7BJq2pxCYCQFpbrqC7U+7QfaLyVgCPFH5csaSIU4f31xepIhNhSJnS+/z/4bLv8xcmddC/L4t+M9Jc/J5BeXqdBCRt4kqwLD6K+Ij1iZKmpbzXoNY5RlehKmYt0rNSkehU4G6ktjptHcwe+rCVAfyvoJMzHHFyrPMuY75OlA/GdKVn+zAnIFhI745zc+JALVMrQ55Oj4MqAO56lF6NWkSvfjxHsGmZDR7pT2N3xc91HgF5n4BsRbDHPZA1PcmaKlSfWJ26Mb9uMVDfXn9DRxz3RgPtSz7blw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(2906002)(44832011)(5660300002)(8936002)(356005)(82740400003)(36756003)(86362001)(81166007)(478600001)(336012)(41300700001)(26005)(83380400001)(2616005)(7696005)(1076003)(16526019)(66574015)(426003)(36860700001)(6666004)(47076005)(316002)(8676002)(4326008)(6916009)(70586007)(70206006)(40460700003)(40480700001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 17:15:15.8653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a2ce10-8f79-44ec-4571-08dc2280315d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6983
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <Christian.Koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch:
- Attaches the TLB flush fence to the PT objects being freed
- Adds a new ptr in VM to save this last TLB flush fence
- Adds a new lock in VM to prevent out-of-context update of saved
  TLB flush fence
- Adds a new ptr in tlb_flush structure to save vm

The idea is to delay freeing of page table objects until we have the
respective TLB entries flushed.

V2: rebase

Cc: Christian König <Christian.Koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 27 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 13 +++++++--
 4 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 67c690044b97..b0e81c249e3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2245,6 +2245,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->generation = 0;
 
 	mutex_init(&vm->eviction_lock);
+	mutex_init(&vm->tlb_flush_lock);
 	vm->evicting = false;
 	vm->tlb_fence_context = dma_fence_context_alloc(1);
 
@@ -2360,7 +2361,9 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	}
 
 	dma_fence_put(vm->last_update);
+	dma_fence_put(vm->tlb_fence_last);
 	vm->last_update = dma_fence_get_stub();
+	vm->tlb_fence_last = dma_fence_get_stub();
 	vm->is_compute_context = true;
 
 	/* Free the shadow bo for compute VM */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 8e6fd25d07b7..b05bc586237f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -334,6 +334,10 @@ struct amdgpu_vm {
 	uint64_t		*tlb_seq_cpu_addr;
 	uint64_t		tlb_fence_context;
 
+	/* Ptr and lock to maintain tlb flush sync */
+	struct mutex		tlb_flush_lock;
+	struct dma_fence        *tlb_fence_last;
+
 	atomic64_t		kfd_last_flushed_seq;
 
 	/* How many times we had to re-generate the page tables */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 95dc0afdaffb..f1c4418c4d63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -631,6 +631,18 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
 	return r;
 }
 
+static inline
+void amdgpu_vm_attach_tlb_fence(struct amdgpu_bo *bo, struct dma_fence *fence)
+{
+	if (!bo || !fence)
+		return;
+
+	if (!dma_resv_reserve_fences(bo->tbo.base.resv, 1)) {
+		dma_resv_add_fence(bo->tbo.base.resv, fence,
+				   DMA_RESV_USAGE_BOOKKEEP);
+	}
+}
+
 /**
  * amdgpu_vm_pt_free - free one PD/PT
  *
@@ -638,6 +650,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
  */
 static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 {
+	struct amdgpu_vm *vm;
 	struct amdgpu_bo *shadow;
 
 	if (!entry->bo)
@@ -646,9 +659,23 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	entry->bo->vm_bo = NULL;
 	shadow = amdgpu_bo_shadowed(entry->bo);
 	if (shadow) {
+		vm = shadow->vm_bo->vm;
+
+		mutex_lock(&vm->tlb_flush_lock);
+		if (vm->tlb_fence_last)
+			amdgpu_vm_attach_tlb_fence(shadow, vm->tlb_fence_last);
+		mutex_unlock(&vm->tlb_flush_lock);
+
 		ttm_bo_set_bulk_move(&shadow->tbo, NULL);
 		amdgpu_bo_unref(&shadow);
 	}
+
+	vm = entry->vm;
+	mutex_lock(&vm->tlb_flush_lock);
+	if (vm->tlb_fence_last)
+		amdgpu_vm_attach_tlb_fence(entry->bo, vm->tlb_fence_last);
+	mutex_unlock(&vm->tlb_flush_lock);
+
 	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
 
 	spin_lock(&entry->vm->status_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
index 569681badd7c..54ec81d30034 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
@@ -31,6 +31,7 @@
 struct amdgpu_tlb_fence {
 	struct dma_fence	base;
 	struct amdgpu_device	*adev;
+	struct amdgpu_vm	*vm;
 	struct dma_fence	*dependency;
 	struct work_struct	work;
 	spinlock_t		lock;
@@ -51,6 +52,7 @@ static const char *amdgpu_tlb_fence_get_timeline_name(struct dma_fence *f)
 static void amdgpu_tlb_fence_work(struct work_struct *work)
 {
 	struct amdgpu_tlb_fence *f = container_of(work, typeof(*f), work);
+	struct amdgpu_vm *vm = f->vm;
 	int r;
 
 	r = amdgpu_gmc_flush_gpu_tlb_pasid(f->adev, f->pasid, 2, true, 0);
@@ -62,6 +64,10 @@ static void amdgpu_tlb_fence_work(struct work_struct *work)
 
 	dma_fence_signal(&f->base);
 	dma_fence_put(&f->base);
+
+	mutex_lock(&vm->tlb_flush_lock);
+	vm->tlb_fence_last = NULL;
+	mutex_unlock(&vm->tlb_flush_lock);
 }
 
 static const struct dma_fence_ops amdgpu_tlb_fence_ops = {
@@ -92,6 +98,7 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm
 	f->adev = adev;
 	f->dependency = *fence;
 	f->pasid = vm->pasid;
+	f->vm = vm;
 	INIT_WORK(&f->work, amdgpu_tlb_fence_work);
 	spin_lock_init(&f->lock);
 
@@ -99,8 +106,10 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm
 		       vm->tlb_fence_context, atomic64_read(&vm->tlb_seq));
 
 	/* TODO: We probably need a separate wq here */
-	dma_fence_get(&f->base);
-	schedule_work(&f->work);
+	mutex_lock(&vm->tlb_flush_lock);
+	vm->tlb_fence_last = dma_fence_get(&f->base);
+	mutex_unlock(&vm->tlb_flush_lock);
 
+	schedule_work(&f->work);
 	*fence = &f->base;
 }
-- 
2.43.0

