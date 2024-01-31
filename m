Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C44FC47DB3
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 17:15:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B0610FB81;
	Wed, 31 Jan 2024 17:15:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A650510FB81
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 17:15:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a30qv+YZTGmG39EjUvaNwThBu28+z19T+zJamJq37WmKpnve3ZyWzm7mb1zJtvORo6QXqA0AaThIKQBsunAztS2NRFsajMBaSATxGesPs66uwn6OznTGuV9ikkTeCaWSkaohU1fzfPQ+VZEFFB2dl1qf42QbbXXiIfYFhak61euBBkcCStQEgDfaLXl80/wIBLerUjUc/i7ZC7SF867QGrcOQc1tn8pVDfVdnM1p2ligfXwDCgq0YOJ19ouLtSEMQGxVzL22p803Uat2344fccxGBkyG8mxg2ouEEIq3OmaXgOPFB6cox4bitpILfgSrRUAN7DzM9NOIWM09VO2LBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OT6ep1d97BshJ2ziVWkjP5ls/6m40MXlC1N62GD9rUE=;
 b=b8qGUW9uDnATnBTmB7xcUh71Nm8y3Hbi2gRqt3Q71/9vQzkQqLPcn9bEdpx+8i8Lpu4s2fNvuSeUCuic45apokBmETBrgV67kO/H76rf2H1oYy0/xAXaMpco2ZLOCf40CJmsd60SKNqoAJvZhPr92RJcDYrlNl+1PpKviF3bALTYDz+ZGSt7wxT0v5B44W8faPsb8iRkKP2Bu1WlsC4X3oN4jftlKQfLzzrYTghYV0zAjg1rsbBSYaSN7OMJDAVQv1y+SF+J+rtgqc/6EmgF3OsxsDH8Zfgs2PYaBRMfYTzhTgkaOKrXYi/HYFfENiW2/i1s22f9PyD5Lvqr5xpMAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OT6ep1d97BshJ2ziVWkjP5ls/6m40MXlC1N62GD9rUE=;
 b=1R1n4bMOjZ5a1I7Vuu1GVaFlenYRvJr2rdMh+C0KsMNfGApqFAz+YqtIBOxTmQVkk9WmQAJkbF+UrwtUf07mvDVtqRETWAybmio7u8eWr5U6rBXA0FLT45xtWMdT/UZP8WHfuZnHEcIN0FFNlNlZOSg56Kp/OC0gITOQjqbME9Q=
Received: from BN9PR03CA0387.namprd03.prod.outlook.com (2603:10b6:408:f7::32)
 by SJ2PR12MB8652.namprd12.prod.outlook.com (2603:10b6:a03:53a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 17:15:10 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:f7:cafe::1a) by BN9PR03CA0387.outlook.office365.com
 (2603:10b6:408:f7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Wed, 31 Jan 2024 17:15:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 17:15:09 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 11:15:08 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/3] drm/amdgpu: replace TLB seq callback with HW seq
Date: Wed, 31 Jan 2024 18:14:32 +0100
Message-ID: <20240131171434.256-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|SJ2PR12MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa5f3e2-24a1-4f77-3715-08dc22802dc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LMhlD1x6R3/99i1QRvCuAn6h/9YBGhrkaDpKJkb7YjM4owaNZcdkaDLVIUqS0BPqih9uuTmO0fjSnXSmClUddt8xrH2TMRxQQBAP1LcBiN4WACRlmec1DIJ2+z6G/aqexLN54x1CO1SvTR2AA28PGW1Uo2H3GRyukKTLINfJKsCx5AFDq0l8zosguwZUWXoTvByAk3f52gx3vWxx4YyQ4LKZ7a1Wr/ZTDOsMiXII3KsV6W1T5LMClj1cK9p+yxhOpvGpJ4wpq95JY3sRnISxL9dRvmco5wmlYQ1nsStp3nFJeFLda1NL3V5ihEBHx3XJEmKCtXgzh+cQ9bRsV965rdfuVWEmtYwj5s5hf6dtA6jbAcVi9F/zEvrq/5rhJbnaKnCdJvfOjXTJlyefvR7M0q9UoZ93DN7N+ObJwu1Mo10WXNixZPyVxYEj6AhvdZoAmwsBG9LxMGOI0J6HjQ/UsvhwMgyiDKP8p6poJPHXBwza8Om0t+g4gslKa1ZR73GYrd05qDr3OPIFqSFi3oS/Y+QUpQRIoWl8A9+USN4eaWBI6QqtaBTVSsfMpPSwTY2dRLIQD15WooZRG0Zt6rbsBk1MoTd5eeVrtO5BhF0r1AUpdsjK/ETJzAdNFOC1ykOvTJbAqSq3ZUuqWM276NmD7xBgzcZILRkKDCShy10r57vceRr/yjgtXJ6tb6GO5LUt42z0Znf65L06s7hM4FaTKmyg3no4r/clAnNjL2BC6i+aSgVbe5GNMxgHfSsvVwncRKllRolOGyzggW9NWZCKbUFF4PyWi5kIj51KB5JuT/I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(54906003)(70586007)(70206006)(47076005)(44832011)(316002)(478600001)(6916009)(8676002)(6666004)(8936002)(7696005)(4326008)(1076003)(336012)(2616005)(426003)(2906002)(30864003)(83380400001)(5660300002)(82740400003)(26005)(16526019)(36860700001)(86362001)(81166007)(40460700003)(356005)(36756003)(40480700001)(41300700001)(66574015)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 17:15:09.8029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa5f3e2-24a1-4f77-3715-08dc22802dc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8652
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
Cc: Alex
 Deucher <alexander.deucher@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Christian König <christian.koenig@amd.com>

The callback we installed for the SDMA update were actually pretty
horrible. since we now have seq64 use that one and HW seq writes
instead.

V2:(Shashank)
 - rebased on amd-drm-staging-next
 - changed amdgpu_seq64_gpu_addr

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c   | 14 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 79 ++++-----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      | 27 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  5 ++
 7 files changed, 42 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index 3d0d56087d41..300dc79fa2b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -199,6 +199,20 @@ void amdgpu_seq64_free(struct amdgpu_device *adev, u64 va)
 		__clear_bit(bit_pos, adev->seq64.used);
 }
 
+/**
+ * amdgpu_seq64_gpu_addr - Calculate GPU addr from va
+ *
+ * @adev: amdgpu_device pointer
+ * @va: virtual address in client address space
+ *
+ * Calculate the GART address for a VA.
+ */
+u64 amdgpu_seq64_gpu_addr(struct amdgpu_device *adev, u64 va)
+{
+	return va - amdgpu_seq64_get_va_base(adev) +
+		amdgpu_bo_gpu_offset(adev->seq64.sbo);
+}
+
 /**
  * amdgpu_seq64_fini - Cleanup seq64 driver
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
index 4203b2ab318d..63e8ac0a2057 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
@@ -43,6 +43,7 @@ void amdgpu_seq64_free(struct amdgpu_device *adev, u64 gpu_addr);
 int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct amdgpu_bo_va **bo_va);
 void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv);
+u64 amdgpu_seq64_gpu_addr(struct amdgpu_device *adev, u64 va);
 
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ed4a8c5d26d7..0960e0a665d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -111,21 +111,6 @@ struct amdgpu_prt_cb {
 	struct dma_fence_cb cb;
 };
 
-/**
- * struct amdgpu_vm_tlb_seq_struct - Helper to increment the TLB flush sequence
- */
-struct amdgpu_vm_tlb_seq_struct {
-	/**
-	 * @vm: pointer to the amdgpu_vm structure to set the fence sequence on
-	 */
-	struct amdgpu_vm *vm;
-
-	/**
-	 * @cb: callback
-	 */
-	struct dma_fence_cb cb;
-};
-
 /**
  * amdgpu_vm_set_pasid - manage pasid and vm ptr mapping
  *
@@ -862,23 +847,6 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	return r;
 }
 
-/**
- * amdgpu_vm_tlb_seq_cb - make sure to increment tlb sequence
- * @fence: unused
- * @cb: the callback structure
- *
- * Increments the tlb sequence to make sure that future CS execute a VM flush.
- */
-static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
-				 struct dma_fence_cb *cb)
-{
-	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
-
-	tlb_cb = container_of(cb, typeof(*tlb_cb), cb);
-	atomic64_inc(&tlb_cb->vm->tlb_seq);
-	kfree(tlb_cb);
-}
-
 /**
  * amdgpu_vm_update_range - update a range in the vm page table
  *
@@ -911,7 +879,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			   struct dma_fence **fence)
 {
 	struct amdgpu_vm_update_params params;
-	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
 	struct amdgpu_res_cursor cursor;
 	enum amdgpu_sync_mode sync_mode;
 	int r, idx;
@@ -919,12 +886,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return -ENODEV;
 
-	tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
-	if (!tlb_cb) {
-		r = -ENOMEM;
-		goto error_unlock;
-	}
-
 	/* Vega20+XGMI where PTEs get inadvertently cached in L2 texture cache,
 	 * heavy-weight flush TLB unconditionally.
 	 */
@@ -942,6 +903,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.immediate = immediate;
 	params.pages_addr = pages_addr;
 	params.unlocked = unlocked;
+	params.needs_flush = flush_tlb;
 	params.allow_override = allow_override;
 
 	/* Implicitly sync to command submissions in the same VM before
@@ -955,7 +917,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	amdgpu_vm_eviction_lock(vm);
 	if (vm->evicting) {
 		r = -EBUSY;
-		goto error_free;
+		goto error_unlock;
 	}
 
 	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
@@ -968,7 +930,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	r = vm->update_funcs->prepare(&params, resv, sync_mode);
 	if (r)
-		goto error_free;
+		goto error_unlock;
 
 	amdgpu_res_first(pages_addr ? NULL : res, offset,
 			 (last - start + 1) * AMDGPU_GPU_PAGE_SIZE, &cursor);
@@ -1018,7 +980,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		tmp = start + num_entries;
 		r = amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
 		if (r)
-			goto error_free;
+			goto error_unlock;
 
 		amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
 		start = tmp;
@@ -1026,22 +988,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	r = vm->update_funcs->commit(&params, fence);
 
-	if (flush_tlb || params.table_freed) {
-		tlb_cb->vm = vm;
-		if (fence && *fence &&
-		    !dma_fence_add_callback(*fence, &tlb_cb->cb,
-					   amdgpu_vm_tlb_seq_cb)) {
-			dma_fence_put(vm->last_tlb_flush);
-			vm->last_tlb_flush = dma_fence_get(*fence);
-		} else {
-			amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
-		}
-		tlb_cb = NULL;
-	}
-
-error_free:
-	kfree(tlb_cb);
-
 error_unlock:
 	amdgpu_vm_eviction_unlock(vm);
 	drm_dev_exit(idx);
@@ -2260,10 +2206,14 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
 	INIT_KFIFO(vm->faults);
 
-	r = amdgpu_vm_init_entities(adev, vm);
+	r = amdgpu_seq64_alloc(adev, &vm->tlb_seq_va, &vm->tlb_seq_cpu_addr);
 	if (r)
 		return r;
 
+	r = amdgpu_vm_init_entities(adev, vm);
+	if (r)
+		goto error_free_seq;
+
 	vm->pte_support_ats = false;
 	vm->is_compute_context = false;
 
@@ -2283,7 +2233,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	vm->last_update = dma_fence_get_stub();
 	vm->last_unlocked = dma_fence_get_stub();
-	vm->last_tlb_flush = dma_fence_get_stub();
 	vm->generation = 0;
 
 	mutex_init(&vm->eviction_lock);
@@ -2322,10 +2271,11 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	amdgpu_bo_unref(&root_bo);
 
 error_free_delayed:
-	dma_fence_put(vm->last_tlb_flush);
 	dma_fence_put(vm->last_unlocked);
 	amdgpu_vm_fini_entities(vm);
 
+error_free_seq:
+	amdgpu_seq64_free(adev, vm->tlb_seq_va);
 	return r;
 }
 
@@ -2441,7 +2391,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	struct amdgpu_bo_va_mapping *mapping, *tmp;
 	bool prt_fini_needed = !!adev->gmc.gmc_funcs->set_prt;
 	struct amdgpu_bo *root;
-	unsigned long flags;
 	int i;
 
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
@@ -2453,11 +2402,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	amdgpu_vm_set_pasid(adev, vm, 0);
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
-	dma_fence_wait(vm->last_tlb_flush, false);
-	/* Make sure that all fence callbacks have completed */
-	spin_lock_irqsave(vm->last_tlb_flush->lock, flags);
-	spin_unlock_irqrestore(vm->last_tlb_flush->lock, flags);
-	dma_fence_put(vm->last_tlb_flush);
+	amdgpu_seq64_free(adev, vm->tlb_seq_va);
 
 	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
 		if (mapping->flags & AMDGPU_PTE_PRT && prt_fini_needed) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 666698a57192..ac9380afcb69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -247,9 +247,9 @@ struct amdgpu_vm_update_params {
 	unsigned int num_dw_left;
 
 	/**
-	 * @table_freed: return true if page table is freed when updating
+	 * @needs_flush: true whenever we need to invalidate the TLB
 	 */
-	bool table_freed;
+	bool needs_flush;
 
 	/**
 	 * @allow_override: true for memory that is not uncached: allows MTYPE
@@ -328,9 +328,11 @@ struct amdgpu_vm {
 	struct drm_sched_entity	immediate;
 	struct drm_sched_entity	delayed;
 
-	/* Last finished delayed update */
+	/* Sequence number indicating necessary TLB flush */
 	atomic64_t		tlb_seq;
-	struct dma_fence	*last_tlb_flush;
+	uint64_t		tlb_seq_va;
+	uint64_t		*tlb_seq_cpu_addr;
+
 	atomic64_t		kfd_last_flushed_seq;
 
 	/* How many times we had to re-generate the page tables */
@@ -549,22 +551,7 @@ int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm *vm);
  */
 static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
 {
-	unsigned long flags;
-	spinlock_t *lock;
-
-	/*
-	 * Workaround to stop racing between the fence signaling and handling
-	 * the cb. The lock is static after initially setting it up, just make
-	 * sure that the dma_fence structure isn't freed up.
-	 */
-	rcu_read_lock();
-	lock = vm->last_tlb_flush->lock;
-	rcu_read_unlock();
-
-	spin_lock_irqsave(lock, flags);
-	spin_unlock_irqrestore(lock, flags);
-
-	return atomic64_read(&vm->tlb_seq);
+	return READ_ONCE(*vm->tlb_seq_cpu_addr);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index 6e31621452de..0f8fd0acef7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -108,7 +108,8 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
 static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
 				struct dma_fence **fence)
 {
-	/* Flush HDP */
+	if (p->needs_flush)
+		*p->vm->tlb_seq_cpu_addr = atomic64_inc_return(&p->vm->tlb_seq);
 	mb();
 	amdgpu_device_flush_hdp(p->adev, NULL);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index a160265ddc07..95dc0afdaffb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -1056,7 +1056,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			while (cursor.pfn < frag_start) {
 				/* Make sure previous mapping is freed */
 				if (cursor.entry->bo) {
-					params->table_freed = true;
+					params->needs_flush = true;
 					amdgpu_vm_pt_free_dfs(adev, params->vm,
 							      &cursor,
 							      params->unlocked);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 349416e176a1..91cc3121fd4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -126,6 +126,11 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
 
 	WARN_ON(ib->length_dw == 0);
 	amdgpu_ring_pad_ib(ring, ib);
+	if (p->needs_flush) {
+		p->job->uf_addr = amdgpu_seq64_gpu_addr(p->adev,
+							p->vm->tlb_seq_va);
+		p->job->uf_sequence = atomic64_inc_return(&p->vm->tlb_seq);
+	}
 	WARN_ON(ib->length_dw > p->num_dw_left);
 	f = amdgpu_job_submit(p->job);
 
-- 
2.43.0

