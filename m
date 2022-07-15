Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EEDC433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDFE110EAC3;
	Sat, 16 Jul 2022 14:37:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91D4A10E00E
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 23:55:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAIs4iS79S7aADjBuieLc6m1hpAl4oj/8z0C4102FJEchocD/sJykeFUO7T9JiNPADWCp5/vzQWe8BZ2j9k3/7FByijfwUE0VYFUbOcclUIedwPEaU0WQTC1a3Fbd+yshMy4TR9pClraDjb4Owgbt+xg3Jdiue1FLEZpqdW4nOACZalNnyo2MZCxmN+HoUWMe9kI3UCn0fGguQ1iw2UymOZXeTOI4K0gb6uB3++0ETLX5i5zGjIuSyhLtDIqpO8kEhRc9ymLNK7wKD6b07BlxgHy9G7E7Kz7MVT384rugt1wULVbqwSP7Kb4IJS0eaCse1qpjAezarWzoWT21YCk6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XCrY9DZ0W6zUHWV/XyMC0Onocehyw7xEMbbrj3aR/U=;
 b=NUAjJDty6NM46/ubzN/nDCdhcG5OfP+wB3GGn0hG9xMJzdpeJTPmONoJyLSQW4M19SMpN6BE70XIeY5xqa2nt05aRHFvQeil6nl80OpPvbUu7YYwbJasl2hCH9t08zm415z58YZ4M+VSbk8BhTC+KPHnR00GExzmyJOeK6cpUdkgXoI59MLLp9cElG+xIXU4ws8gp2FR1mD64BkSwTs/b3c7glrrFwVejRk1iOqPZjjbzn9pK6MrvcpOAqGodTpTMzCWLcyEOlRs7sOIfCA65qwxBMBfogxv7UXBfjfnWfaEJUHkkD6wYxiuCzmSQaNJAoMOyTs4tWu4NUUaEK7zhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XCrY9DZ0W6zUHWV/XyMC0Onocehyw7xEMbbrj3aR/U=;
 b=JCu36UKwrdRWMAp3w6yNmKVO/xu1Gidh1LLCUdyuNNEJKD28PAu7qGJXGFXhwASStnaj4XaGGemB0YyKmXx2nCmnNRCVyKDZHIW4f3PNCNDo2FT9ywwhCdVlNsoSP/Qt3EtfG84C+gRqBFXOWKe7c8UFx1LNeLXFcJ3kCOqi+XA=
Received: from MW4PR03CA0047.namprd03.prod.outlook.com (2603:10b6:303:8e::22)
 by BN9PR12MB5307.namprd12.prod.outlook.com (2603:10b6:408:104::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Fri, 15 Jul
 2022 23:54:57 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::1d) by MW4PR03CA0047.outlook.office365.com
 (2603:10b6:303:8e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19 via Frontend
 Transport; Fri, 15 Jul 2022 23:54:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 23:54:56 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 18:54:55 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: track unified memory reservation with xnack off
Date: Fri, 15 Jul 2022 18:54:43 -0500
Message-ID: <20220715235443.32471-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220712015604.7697-2-alex.sierra@amd.com>
References: <20220712015604.7697-2-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e70bb81c-0cb2-4edd-f1a0-08da66bd6b96
X-MS-TrafficTypeDiagnostic: BN9PR12MB5307:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tn4KkH+5CoADhPEu65gx791ZLBFxk3PhGfOPBiA7zz9AvmltO8Zv0rm+cy9MO8d8Mvt9aX7O2AYm0E9b2/cOlLkr+nmtePjDl/tm/hN//KDHS+ouDUSta5k4tzcopYugZ7RQ9WeHjXUJUcNPHsHLNSmQw3Ac238jbhVtFnzXGpu/c0Hz4xL9b37JEg20yIgEwXOzXuRIBI3b7KOMuicSRjf0jmJ4EoIuJM7+4estiUmGY7lGBmUFkT1ZZGtSyLC24bMw13GB4+TbQdfgtHCyTwpNrZ3zTGs3C9lj124PCEtdE0Vv6qRm10dxPFB8aTEbGFm7E8uRIhFKCAeZMueYj7dOdFlAptYo6QceiGlJ93HpVhouTGEUV7DZbSjAklRqzGjI5pghQSX1WKjVPUKjUfcuYk+/Nb8TAVETKTRU9k+d6NPiMKz+JQa2C0Qnq3baKOpwLIHick+TwUBfysJgrtcbAIsfZUGAhCnRUZ53SrCHhIdlx14ASylwB3AIqXGgUCuG/1XKDo09lW7NlY5E7oxQvheGNwQPDnOb+pRRZBsnT39ahD7GBxOcJ2ieV53V5RgIlnXVh8YkaQM/4M7DWWnaa7/hDNId5RWQCywLqnJhSPsAI9dAbuKsCGrpZIUPc3HeLOAadsoB/nd/ud8AsSUUkbagYluhrsMU+C+CTSY3PQmGfbnHNr6kUUPjuZ7V4Q/7M4Gflq9PfxOj3CXVdW47z8Gwv9IHtHPr0iHlZPav0NnHSOyc65cH9o0Yc0bgKZnniBBNTT/dO98EQxAgb+hWpgM9X9M8cZ3RNkXl66cX8yWrER+pyj1YwKSPiHKf80PY+kX8+hEmyKoeTerT87j/bQ4HSupLgeaC6upJVn8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(136003)(396003)(376002)(40470700004)(36840700001)(46966006)(82740400003)(81166007)(478600001)(356005)(41300700001)(316002)(6666004)(2616005)(83380400001)(26005)(16526019)(70586007)(6916009)(1076003)(186003)(7696005)(47076005)(336012)(426003)(40460700003)(8936002)(5660300002)(44832011)(30864003)(8676002)(4326008)(36860700001)(86362001)(36756003)(2906002)(70206006)(82310400005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 23:54:56.4378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e70bb81c-0cb2-4edd-f1a0-08da66bd6b96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5307
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
Cc: Alex Sierra <alex.sierra@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[WHY]
Unified memory with xnack off should be tracked, as userptr mappings
and legacy allocations do. To avoid oversuscribe system memory when
xnack off.
[How]
Exposing functions reserve_mem_limit and unreserve_mem_limit to SVM
API and call them on every prange creation and free.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  4 ++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 23 ++++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 60 +++++++++++++------
 3 files changed, 60 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 73bf8b5f2aa9..83d955f0c52f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -305,6 +305,10 @@ bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *
 void amdgpu_amdkfd_block_mmu_notifications(void *p);
 int amdgpu_amdkfd_criu_resume(void *p);
 bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev);
+int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
+		uint64_t size, u32 alloc_flag);
+void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
+		uint64_t size, u32 alloc_flag);
 
 #if IS_ENABLED(CONFIG_HSA_AMD)
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 2bc36ff0aa0f..39d589394160 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -129,7 +129,7 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
  *
  * Return: returns -ENOMEM in case of error, ZERO otherwise
  */
-static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
+int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag)
 {
 	uint64_t reserved_for_pt =
@@ -169,7 +169,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	     kfd_mem_limit.max_system_mem_limit && !no_system_mem_limit) ||
 	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
 	     kfd_mem_limit.max_ttm_mem_limit) ||
-	    (adev->kfd.vram_used + vram_needed >
+	    (adev && adev->kfd.vram_used + vram_needed >
 	     adev->gmc.real_vram_size -
 	     atomic64_read(&adev->vram_pin_size) -
 	     reserved_for_pt)) {
@@ -180,7 +180,10 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	/* Update memory accounting by decreasing available system
 	 * memory, TTM memory and GPU memory as computed above
 	 */
-	adev->kfd.vram_used += vram_needed;
+	WARN_ONCE(vram_needed && !adev,
+		  "adev reference can't be null when vram is used");
+	if (adev)
+		adev->kfd.vram_used += vram_needed;
 	kfd_mem_limit.system_mem_used += system_mem_needed;
 	kfd_mem_limit.ttm_mem_used += ttm_mem_needed;
 
@@ -189,7 +192,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	return ret;
 }
 
-static void unreserve_mem_limit(struct amdgpu_device *adev,
+void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag)
 {
 	spin_lock(&kfd_mem_limit.mem_limit_lock);
@@ -198,7 +201,10 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
 		kfd_mem_limit.system_mem_used -= size;
 		kfd_mem_limit.ttm_mem_used -= size;
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
-		adev->kfd.vram_used -= ALIGN(size, VRAM_ALLOCATION_ALIGN);
+		WARN_ONCE(!adev,
+			  "adev reference can't be null when alloc mem flags vram is set");
+		if (adev)
+			adev->kfd.vram_used -= ALIGN(size, VRAM_ALLOCATION_ALIGN);
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
 		kfd_mem_limit.system_mem_used -= size;
 	} else if (!(alloc_flag &
@@ -207,8 +213,7 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
 		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
 		goto release;
 	}
-
-	WARN_ONCE(adev->kfd.vram_used < 0,
+	WARN_ONCE(adev && adev->kfd.vram_used < 0,
 		  "KFD VRAM memory accounting unbalanced");
 	WARN_ONCE(kfd_mem_limit.ttm_mem_used < 0,
 		  "KFD TTM memory accounting unbalanced");
@@ -225,7 +230,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
 	u32 alloc_flags = bo->kfd_bo->alloc_flags;
 	u64 size = amdgpu_bo_size(bo);
 
-	unreserve_mem_limit(adev, size, alloc_flags);
+	amdgpu_amdkfd_unreserve_mem_limit(adev, size, alloc_flags);
 
 	kfree(bo->kfd_bo);
 }
@@ -1788,7 +1793,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	/* Don't unreserve system mem limit twice */
 	goto err_reserve_limit;
 err_bo_create:
-	unreserve_mem_limit(adev, size, flags);
+	amdgpu_amdkfd_unreserve_mem_limit(adev, size, flags);
 err_reserve_limit:
 	mutex_destroy(&(*mem)->lock);
 	if (gobj)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b592aee6d9d6..af5b0629b84a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -260,13 +260,22 @@ void svm_range_free_dma_mappings(struct svm_range *prange)
 	}
 }
 
-static void svm_range_free(struct svm_range *prange)
+static void svm_range_free(struct svm_range *prange, bool update_mem_usage)
 {
+	uint64_t size = (prange->last - prange->start + 1) << PAGE_SHIFT;
+	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
+
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx]\n", prange->svms, prange,
 		 prange->start, prange->last);
 
 	svm_range_vram_node_free(prange);
 	svm_range_free_dma_mappings(prange);
+
+	if (update_mem_usage && !p->xnack_enabled) {
+		pr_debug("unreserve mem limit: %lld\n", size);
+		amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
+					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+	}
 	mutex_destroy(&prange->lock);
 	mutex_destroy(&prange->migrate_mutex);
 	kfree(prange);
@@ -285,7 +294,7 @@ svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
 
 static struct
 svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
-			 uint64_t last)
+			 uint64_t last, bool update_mem_usage)
 {
 	uint64_t size = last - start + 1;
 	struct svm_range *prange;
@@ -294,6 +303,15 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	prange = kzalloc(sizeof(*prange), GFP_KERNEL);
 	if (!prange)
 		return NULL;
+
+	p = container_of(svms, struct kfd_process, svms);
+	if (!p->xnack_enabled && update_mem_usage &&
+	    amdgpu_amdkfd_reserve_mem_limit(NULL, size << PAGE_SHIFT,
+					    KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)) {
+		pr_info("SVM mapping failed, exceeds resident system memory limit\n");
+		kfree(prange);
+		return NULL;
+	}
 	prange->npages = size;
 	prange->svms = svms;
 	prange->start = start;
@@ -308,7 +326,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	mutex_init(&prange->migrate_mutex);
 	mutex_init(&prange->lock);
 
-	p = container_of(svms, struct kfd_process, svms);
 	if (p->xnack_enabled)
 		bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
 			    MAX_GPU_INSTANCE);
@@ -1001,9 +1018,9 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
 
 	svms = prange->svms;
 	if (old_start == start)
-		*new = svm_range_new(svms, last + 1, old_last);
+		*new = svm_range_new(svms, last + 1, old_last, false);
 	else
-		*new = svm_range_new(svms, old_start, start - 1);
+		*new = svm_range_new(svms, old_start, start - 1, false);
 	if (!*new)
 		return -ENOMEM;
 
@@ -1011,7 +1028,7 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
 	if (r) {
 		pr_debug("failed %d split [0x%llx 0x%llx] to [0x%llx 0x%llx]\n",
 			 r, old_start, old_last, start, last);
-		svm_range_free(*new);
+		svm_range_free(*new, false);
 		*new = NULL;
 	}
 
@@ -1846,7 +1863,7 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 {
 	struct svm_range *new;
 
-	new = svm_range_new(old->svms, old->start, old->last);
+	new = svm_range_new(old->svms, old->start, old->last, false);
 	if (!new)
 		return NULL;
 
@@ -1910,6 +1927,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	struct interval_tree_node *node;
 	struct svm_range *prange;
 	struct svm_range *tmp;
+	struct list_head new_list;
 	int r = 0;
 
 	pr_debug("svms 0x%p [0x%llx 0x%lx]\n", &p->svms, start, last);
@@ -1917,6 +1935,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	INIT_LIST_HEAD(update_list);
 	INIT_LIST_HEAD(insert_list);
 	INIT_LIST_HEAD(remove_list);
+	INIT_LIST_HEAD(&new_list);
 
 	node = interval_tree_iter_first(&svms->objects, start, last);
 	while (node) {
@@ -1972,13 +1991,13 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
 		/* insert a new node if needed */
 		if (node->start > start) {
-			prange = svm_range_new(svms, start, node->start - 1);
+			prange = svm_range_new(svms, start, node->start - 1, true);
 			if (!prange) {
 				r = -ENOMEM;
 				goto out;
 			}
 
-			list_add(&prange->list, insert_list);
+			list_add(&prange->list, &new_list);
 			list_add(&prange->update_list, update_list);
 		}
 
@@ -1988,19 +2007,24 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
 	/* add a final range at the end if needed */
 	if (start <= last) {
-		prange = svm_range_new(svms, start, last);
+		prange = svm_range_new(svms, start, last, true);
 		if (!prange) {
 			r = -ENOMEM;
 			goto out;
 		}
-		list_add(&prange->list, insert_list);
+		list_add(&prange->list, &new_list);
 		list_add(&prange->update_list, update_list);
 	}
 
 out:
-	if (r)
+	if (r) {
 		list_for_each_entry_safe(prange, tmp, insert_list, list)
-			svm_range_free(prange);
+			svm_range_free(prange, false);
+		list_for_each_entry_safe(prange, tmp, &new_list, list)
+			svm_range_free(prange, true);
+	} else {
+		list_splice(&new_list, insert_list);
+	}
 
 	return r;
 }
@@ -2047,7 +2071,7 @@ svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange,
 			 svms, prange, prange->start, prange->last);
 		svm_range_unlink(prange);
 		svm_range_remove_notifier(prange);
-		svm_range_free(prange);
+		svm_range_free(prange, true);
 		break;
 	case SVM_OP_UPDATE_RANGE_NOTIFIER:
 		pr_debug("update notifier 0x%p prange 0x%p [0x%lx 0x%lx]\n",
@@ -2610,14 +2634,14 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 		last = addr;
 	}
 
-	prange = svm_range_new(&p->svms, start, last);
+	prange = svm_range_new(&p->svms, start, last, true);
 	if (!prange) {
 		pr_debug("Failed to create prange in address [0x%llx]\n", addr);
 		return NULL;
 	}
 	if (kfd_process_gpuid_from_adev(p, adev, &gpuid, &gpuidx)) {
 		pr_debug("failed to get gpuid from kgd\n");
-		svm_range_free(prange);
+		svm_range_free(prange, true);
 		return NULL;
 	}
 
@@ -2917,7 +2941,7 @@ void svm_range_list_fini(struct kfd_process *p)
 	list_for_each_entry_safe(prange, next, &p->svms.list, list) {
 		svm_range_unlink(prange);
 		svm_range_remove_notifier(prange);
-		svm_range_free(prange);
+		svm_range_free(prange, true);
 	}
 
 	mutex_destroy(&p->svms.lock);
@@ -3333,7 +3357,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 			 prange->last);
 		svm_range_unlink(prange);
 		svm_range_remove_notifier(prange);
-		svm_range_free(prange);
+		svm_range_free(prange, false);
 	}
 
 	mmap_write_downgrade(mm);
-- 
2.32.0

