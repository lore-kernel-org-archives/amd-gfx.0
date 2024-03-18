Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F878C54E5D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 16:12:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E30EE10FB96;
	Mon, 18 Mar 2024 16:12:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2KSQ/OMA";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8995710FB96
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 16:12:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlOZMigNkcMvggSw7kVJLjsMWBleUj1bfHyr7l9uwsSgITYxdUkpvIcHl/gNJH5eY/Lhq6aKrQ+2EFoOZNKvA5Gxrj4j9uJ/mG+7OBr2FIDt+DCQtSriJ7IxxOIAwvPcdOHBkMelKezgKu7bP2c43XyezQb6yz3ESGSQGcISFLZF3AiUMeI5LycYNjMFOUQL76J2yTraF7sPsbz89vFuLsmOzpoXJDNWOSx7JVpCL22DBEC/Q68aK/b34kNRYI35DH4nCdGDXUQKPuG82IeKAF21KdpDL++0UJDDKb1b7+8s3WHtQZkRw2iJYhspScrRrhK1S7ITKk5uMAh+N8DMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+aFDbrm00bF/PQ0EOfakY4r6+UQyx2JSPadF7eOPd0=;
 b=NdkkejosHhpQiqZtBtAb95fT7LhGpWZ+w3rxLSEjv8pAlRsqOG46GTHX17QlKo+rZWrPa9g37KT/PUDUVirNzAkChLOgfql3Uu1zzh7vXALppHu/XvpAohAH9NIVG3SYq0t/SEfjA+btTNgO/FXnwrALI59B9yxoEdFZieC6W95zH94oOTbEcUjpjs+xfPKG1I4/RWaQOGYVHnLxAfguJOhDYOjn6pmeCvZR5VqgeKBaPcBqbCTtY+/+LIgHA26Z0EdJr6CCrbzqv8fTGnI/4ifaSr+MClk/nBxv4EgjuuDYQ+b968X4N7TWjBtX5KDZl6SmL2JvW8fJoVWRFn4iqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+aFDbrm00bF/PQ0EOfakY4r6+UQyx2JSPadF7eOPd0=;
 b=2KSQ/OMAT6ICWUR4pQ4tVZ6xyA1ZK9NP6lgrwGMlivhyAm1S4seICzzsiT79lZukGG9VUiqyZL7kO43daUIlaY9jyjMP5HxRfhTKk5m60Vb+bGIo6hmH2WYhArSTA7kOUA2izSAapgkEMJvxTRUJAFyAAYfvdU8MIORvJhrpek0=
Received: from CH5P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::22)
 by LV8PR12MB9229.namprd12.prod.outlook.com (2603:10b6:408:191::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 16:12:06 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::f5) by CH5P223CA0021.outlook.office365.com
 (2603:10b6:610:1f3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 16:12:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 16:12:06 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 11:12:02 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Christian Koenig <christian.koenig@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>
Subject: [PATCH v9 1/2] drm/amdgpu: implement TLB flush fence
Date: Mon, 18 Mar 2024 17:11:39 +0100
Message-ID: <20240318161140.2101-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|LV8PR12MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b1a4ab8-a073-4ee2-29c5-08dc476627fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wFNu24fw//3pDMk75gZdcRfeMzYtAGQFpkffY82aSROiVL41R5vsgu1kNUBZ33zjPwylq78KkKhV+h1H3WhLwm/X7w5rdU3QJw4a6AGx3Qzrts4bFhoxTVUuCBBJ71bI1lLvAxmSCIcf5HMiEns0ztMKiou+ropJ20YYO4Po/3CHpOL0KIvqoHFhaiQLXMFDVV1hsWtj2TNAbefBzwjALXIS+8XD82n4qXRrY8D6opigViKGOmu/dLlJrS4NuNB1g2HfIUkfGdGJjbQMJD19ZgdFFYALcjXCPTg8zp6xsF3Pq+NX/T90w8BEjnHHlyvlnlvCrrJfRal37VIKyz0DrlMLmwUPwF4Vluzfz+nPHL8WCu91LgYHDxn4N1c914v3+fH3RB05A/LU5sNB4VmSa05BpTpi1AubWRnqIxaMFFVgETsTkiIFf1tCmesb/VWIvprY+xp+7uLKehYCOoWgO+A4otR2zguZHrmZ8iP+cXFMhquk9Yrkknm+asDVzo7TG5FJWyooshADWZrlI6KSuX71+Sj1EWoKSnX1Zg+zOMTrQte66Bju+RHV6Ezh9IiLRVRfY/zFMK52kLkZaXJyPyCXSdO9b5J9c7BLjvbJ3xtrmmP8T4eTOb/urEJ95NYtVRjZfbgi3GUG3uQp49r/g2rUu5XZFBhHIPZnhhq/JTlHHnrP6SK9jcXuNwUXLqrI+6Y2NXLGcX01bFzdygfKrPARVMJUV9vDJN/IstRJVBVFm6nKFWZFDqvi3jplYJ0S
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 16:12:06.2216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1a4ab8-a073-4ee2-29c5-08dc476627fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9229
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Christian Koenig <christian.koenig@amd.com>

The problem is that when (for example) 4k pages are replaced
with a single 2M page we need to wait for change to be flushed
out by invalidating the TLB before the PT can be freed.

Solve this by moving the TLB flush into a DMA-fence object which
can be used to delay the freeing of the PT BOs until it is signaled.

V2: (Shashank)
    - rebase
    - set dma_fence_error only in case of error
    - add tlb_flush fence only when PT/PD BO is locked (Felix)
    - use vm->pasid when f is NULL (Mukul)

V4: - add a wait for (f->dependency) in tlb_fence_work (Christian)
    - move the misplaced fence_create call to the end (Philip)

V5: - free the f->dependency properly

V6: (Shashank)
    - light code movement, moved all the clean-up in previous patch
    - introduce params.needs_flush and its usage in this patch
    - rebase without TLB HW sequence patch

V7:
   - Keep the vm->last_update_fence and tlb_cb code until
     we can fix the HW sequencing (Christian)
   - Move all the tlb_fence related code in a separate function so that
     its easier to read and review

V9: Addressed review comments from Christian
    - start PT update only when we have callback memory allocated

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  64 +++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |   4 +
 .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 112 ++++++++++++++++++
 7 files changed, 175 insertions(+), 22 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 4536c8ad0e11..f24f11ac3e92 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -70,7 +70,8 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o \
 	atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
 	atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
-	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o amdgpu_pll.o \
+	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_vm_tlb_fence.o \
+	amdgpu_ib.o amdgpu_pll.o \
 	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
 	amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o \
 	amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 81fb3465e197..104bf600c85f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -885,6 +885,44 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
 	kfree(tlb_cb);
 }
 
+/**
+ * amdgpu_vm_tlb_flush - prepare TLB flush
+ *
+ * @params: parameters for update
+ * @fence: input fence to sync TLB flush with
+ * @tlb_cb: the callback structure
+ *
+ * Increments the tlb sequence to make sure that future CS execute a VM flush.
+ */
+static void
+amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
+		    struct dma_fence **fence,
+		    struct amdgpu_vm_tlb_seq_struct *tlb_cb)
+{
+	struct amdgpu_vm *vm = params->vm;
+
+	if (!fence || !*fence)
+		return;
+
+	tlb_cb->vm = vm;
+	if (!dma_fence_add_callback(*fence, &tlb_cb->cb,
+				    amdgpu_vm_tlb_seq_cb)) {
+		dma_fence_put(vm->last_tlb_flush);
+		vm->last_tlb_flush = dma_fence_get(*fence);
+	} else {
+		amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
+	}
+
+	/* Prepare a TLB flush fence to be attached to PTs */
+	if (!params->unlocked && vm->is_compute_context) {
+		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
+
+		/* Makes sure no PD/PT is freed before the flush */
+		dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
+				   DMA_RESV_USAGE_BOOKKEEP);
+	}
+}
+
 /**
  * amdgpu_vm_update_range - update a range in the vm page table
  *
@@ -916,8 +954,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			   struct ttm_resource *res, dma_addr_t *pages_addr,
 			   struct dma_fence **fence)
 {
-	struct amdgpu_vm_update_params params;
 	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
+	struct amdgpu_vm_update_params params;
 	struct amdgpu_res_cursor cursor;
 	enum amdgpu_sync_mode sync_mode;
 	int r, idx;
@@ -926,10 +964,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		return -ENODEV;
 
 	tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
-	if (!tlb_cb) {
-		r = -ENOMEM;
-		goto error_unlock;
-	}
+	if (!tlb_cb)
+		return -ENOMEM;
 
 	/* Vega20+XGMI where PTEs get inadvertently cached in L2 texture cache,
 	 * heavy-weight flush TLB unconditionally.
@@ -948,6 +984,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.immediate = immediate;
 	params.pages_addr = pages_addr;
 	params.unlocked = unlocked;
+	params.needs_flush = flush_tlb;
 	params.allow_override = allow_override;
 
 	/* Implicitly sync to command submissions in the same VM before
@@ -1031,24 +1068,16 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}
 
 	r = vm->update_funcs->commit(&params, fence);
+	if (r)
+		goto error_free;
 
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
+	if (params.needs_flush) {
+		amdgpu_vm_tlb_flush(&params, fence, tlb_cb);
 		tlb_cb = NULL;
 	}
 
 error_free:
 	kfree(tlb_cb);
-
-error_unlock:
 	amdgpu_vm_eviction_unlock(vm);
 	drm_dev_exit(idx);
 	return r;
@@ -2391,6 +2420,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	mutex_init(&vm->eviction_lock);
 	vm->evicting = false;
+	vm->tlb_fence_context = dma_fence_context_alloc(1);
 
 	r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
 				false, &root, xcp_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 8efa8422f4f7..b0a4fe683352 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -257,9 +257,9 @@ struct amdgpu_vm_update_params {
 	unsigned int num_dw_left;
 
 	/**
-	 * @table_freed: return true if page table is freed when updating
+	 * @needs_flush: true whenever we need to invalidate the TLB
 	 */
-	bool table_freed;
+	bool needs_flush;
 
 	/**
 	 * @allow_override: true for memory that is not uncached: allows MTYPE
@@ -342,6 +342,7 @@ struct amdgpu_vm {
 	atomic64_t		tlb_seq;
 	struct dma_fence	*last_tlb_flush;
 	atomic64_t		kfd_last_flushed_seq;
+	uint64_t		tlb_fence_context;
 
 	/* How many times we had to re-generate the page tables */
 	uint64_t		generation;
@@ -611,5 +612,8 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 				  uint64_t addr,
 				  uint32_t status,
 				  unsigned int vmhub);
+void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
+				 struct amdgpu_vm *vm,
+				 struct dma_fence **fence);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index 6e31621452de..3895bd7d176a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -108,7 +108,9 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
 static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
 				struct dma_fence **fence)
 {
-	/* Flush HDP */
+	if (p->needs_flush)
+		atomic64_inc(&p->vm->tlb_seq);
+
 	mb();
 	amdgpu_device_flush_hdp(p->adev, NULL);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 124389a6bf48..601df0ce8290 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -972,7 +972,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			while (cursor.pfn < frag_start) {
 				/* Make sure previous mapping is freed */
 				if (cursor.entry->bo) {
-					params->table_freed = true;
+					params->needs_flush = true;
 					amdgpu_vm_pt_free_dfs(adev, params->vm,
 							      &cursor,
 							      params->unlocked);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 349416e176a1..66e8a016126b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -126,6 +126,10 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
 
 	WARN_ON(ib->length_dw == 0);
 	amdgpu_ring_pad_ib(ring, ib);
+
+	if (p->needs_flush)
+		atomic64_inc(&p->vm->tlb_seq);
+
 	WARN_ON(ib->length_dw > p->num_dw_left);
 	f = amdgpu_job_submit(p->job);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
new file mode 100644
index 000000000000..51cddfa3f1e8
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <linux/dma-fence.h>
+#include <linux/workqueue.h>
+
+#include "amdgpu.h"
+#include "amdgpu_vm.h"
+#include "amdgpu_gmc.h"
+
+struct amdgpu_tlb_fence {
+	struct dma_fence	base;
+	struct amdgpu_device	*adev;
+	struct dma_fence	*dependency;
+	struct work_struct	work;
+	spinlock_t		lock;
+	uint16_t		pasid;
+
+};
+
+static const char *amdgpu_tlb_fence_get_driver_name(struct dma_fence *fence)
+{
+	return "amdgpu tlb fence";
+}
+
+static const char *amdgpu_tlb_fence_get_timeline_name(struct dma_fence *f)
+{
+	return "amdgpu tlb timeline";
+}
+
+static void amdgpu_tlb_fence_work(struct work_struct *work)
+{
+	struct amdgpu_tlb_fence *f = container_of(work, typeof(*f), work);
+	int r;
+
+	if (f->dependency) {
+		dma_fence_wait(f->dependency, false);
+		dma_fence_put(f->dependency);
+		f->dependency = NULL;
+	}
+
+	r = amdgpu_gmc_flush_gpu_tlb_pasid(f->adev, f->pasid, 2, true, 0);
+	if (r) {
+		dev_err(f->adev->dev, "TLB flush failed for PASID %d.\n",
+			f->pasid);
+		dma_fence_set_error(&f->base, r);
+	}
+
+	dma_fence_signal(&f->base);
+	dma_fence_put(&f->base);
+}
+
+static const struct dma_fence_ops amdgpu_tlb_fence_ops = {
+	.use_64bit_seqno = true,
+	.get_driver_name = amdgpu_tlb_fence_get_driver_name,
+	.get_timeline_name = amdgpu_tlb_fence_get_timeline_name
+};
+
+void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+				struct dma_fence **fence)
+{
+	struct amdgpu_tlb_fence *f;
+
+	f = kmalloc(sizeof(*f), GFP_KERNEL);
+	if (!f) {
+		/*
+		 * We can't fail since the PDEs and PTEs are already updated, so
+		 * just block for the dependency and execute the TLB flush
+		 */
+		if (*fence)
+			dma_fence_wait(*fence, false);
+
+		amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
+		*fence = dma_fence_get_stub();
+		return;
+	}
+
+	f->adev = adev;
+	f->dependency = *fence;
+	f->pasid = vm->pasid;
+	INIT_WORK(&f->work, amdgpu_tlb_fence_work);
+	spin_lock_init(&f->lock);
+
+	dma_fence_init(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
+		       vm->tlb_fence_context, atomic64_read(&vm->tlb_seq));
+
+	/* TODO: We probably need a separate wq here */
+	dma_fence_get(&f->base);
+	schedule_work(&f->work);
+
+	*fence = &f->base;
+}
-- 
2.43.2

