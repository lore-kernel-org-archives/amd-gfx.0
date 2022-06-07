Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0934EC43334
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 17:17:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F7CF10EED3;
	Tue,  7 Jun 2022 17:17:28 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2016B10EED2
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 17:17:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUyLyljWv94l9bURMnqum/hIsljdDYfmrilSl2nXz+gDd12o6HSse54cZSL5o7sZYp7ntau173nQDN0+/S+yY3FfAiZbJnTxJcBpaRr+2IpKN/nUWMZ2PqqBqMyHmWyRUaDyWvzcFOUsAJUGYTq1yHNnW3zMGdivVaB+peWaff9By/VFfc1QAaf2sIM11A1QnrWwoQtdRqW1Bp/cFVUYeJq8k+nkx/WA0fITxPsmDaypoMap04BF6e5TfsZzDJYCl2xFk+nD1GEyACeNqY5xQZ7xBYxfknTlEseonWwSWuHqbT9uZBfn+7pRhl1oTyWa8009xSTITJKbMa9vSnhBYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4ZY85X5zGpVBjsSIky9fel/9ji29aN+uoPWxHEKuPk=;
 b=ZY/xrpVpFuv/sNIX3uGljqPrlu51zP/SncQ74pZ7WKPMW438ldwJ5xgYqAdRBPilP1KQesg9jzEUH6c8wnbZ/X/3zQpMOSoebvUrCm4otJjcQMUEFLgSflm4J4bA6Lz2Vbeyw71OFWcCSB2PNvqaI4kotCGmkOv6xKB3PmdNK5J2LxG7GrCbsvZtucR+BbMM8euWKROExbSS1TKvYpWXa1RRGMgFdwKyhtS2iwyWv5C9onKqggVcRKLoDXARCGSbEMyNZq9Bi6GcbFrZpZF75l6+s2Gew0BN047Dwqhhfu1eYh9rNpHJp3jVIqM7UyWwaYMbfzRs+3JStXPbaPLgZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4ZY85X5zGpVBjsSIky9fel/9ji29aN+uoPWxHEKuPk=;
 b=4BUJlDHW6ep9L1kTFUZNkACZK7bU+oBaJJx001ns99ClwUUObUQ64sy/FCki2COLgRgRU31xjtEETGyrD7wYmsikuzrOrp/UYkmm3YMGRvr2F3FBLK/2Bcu6lBiEDFnaQCpMF1C4JDKL5SzulLqdMsmh0C87N3AKQIoo68AODJ0=
Received: from MW4PR04CA0031.namprd04.prod.outlook.com (2603:10b6:303:6a::6)
 by BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 17:17:23 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::1d) by MW4PR04CA0031.outlook.office365.com
 (2603:10b6:303:6a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Tue, 7 Jun 2022 17:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 17:17:22 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 7 Jun
 2022 12:17:21 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdkfd: track unified memory reservation with xnack
 off
Date: Tue, 7 Jun 2022 12:17:06 -0500
Message-ID: <20220607171706.28432-2-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220607171706.28432-1-alex.sierra@amd.com>
References: <20220607171706.28432-1-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f39f4c4e-85c6-4dc8-3e58-08da48a995df
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2353D0E7AB0116EF78720E42FDA59@BL0PR12MB2353.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pVJlO02blhSr1HOh15Ldly5FfyH3jT3oPIRUcm72q6AR0nBIIZXx3hjg+Z5TqMdT8a2lKPW02NKFrAATlZi32e6o7/iTd8CjOtjcIeqEtX8appIl+7xQUN2yXoFtZvJt9XAQayiemUXQH4o4LGLEDhdKNdvpj8JBgxg+HQPXrQKD8UcofV8/5Hs0mG34yIeITC78hrBBDQfncHQBJuGmlu4+1W42IljujjhERTEjsxwYMBaOyh93lke++BJs5ui1G3W2a4kAvMxvAalOT+8js5b65ASKWFYxhMBTfWYRV/mVe/Y4/CPhREcK2s4habfJFDe6IXZvKR7OHd+UC+oETBgNZeykZ1/b3BD0zFoyeZdKmwf1l9j7jw+uMWIeDsWuyZlzqJILLWUHyyyf5Qmdg+e4u+Irthxqzon0xY540NJJVoQQ+3y/7uBBmfgYuCca5Kf5G7sMD3iMNgzmaticq17jIrpY7txtjN3DVG10W4nNeZYCJWLZYZ91bqyVjAX1W61Pvo4V1VTsg80dJCN/aiP8GpTEc3keR1ZpmnGfykgfsD1XYH3+EbOsSyBCc5/21JUANBJMHLH/auD6qsu9w9ahI56amUPBInfv9SiyNarNYzCTZQowXHZjcivIK8d7uVVPj6kySJljlM2Txh0cATjwn4FyY++rIYoxM/UHfdu2fQvKlRQp5RhMbcgl4RahURP3lg31YUV5nW/yBEoa1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(316002)(81166007)(36756003)(8676002)(47076005)(508600001)(36860700001)(82310400005)(6916009)(4326008)(70586007)(356005)(70206006)(336012)(7696005)(26005)(2906002)(1076003)(6666004)(8936002)(5660300002)(83380400001)(30864003)(16526019)(186003)(44832011)(40460700003)(86362001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 17:17:22.5580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f39f4c4e-85c6-4dc8-3e58-08da48a995df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2353
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
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 27 ++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 47 +++++++++++++------
 3 files changed, 51 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index f8b9f27adcf5..f55f34af6480 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -301,6 +301,10 @@ bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *
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
index 50730d2132a6..f13977ae4579 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -122,7 +122,7 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
  *
  * Return: returns -ENOMEM in case of error, ZERO otherwise
  */
-static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
+int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag)
 {
 	uint64_t reserved_for_pt =
@@ -157,8 +157,8 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	     kfd_mem_limit.max_system_mem_limit && !no_system_mem_limit) ||
 	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
 	     kfd_mem_limit.max_ttm_mem_limit) ||
-	    (adev->kfd.vram_used + vram_needed >
-	     adev->gmc.real_vram_size - reserved_for_pt)) {
+	    (adev && (adev->kfd.vram_used + vram_needed >
+	     adev->gmc.real_vram_size - reserved_for_pt))) {
 		ret = -ENOMEM;
 		goto release;
 	}
@@ -166,7 +166,10 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
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
 
@@ -175,7 +178,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	return ret;
 }
 
-static void unreserve_mem_limit(struct amdgpu_device *adev,
+void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag)
 {
 	spin_lock(&kfd_mem_limit.mem_limit_lock);
@@ -184,7 +187,10 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
 		kfd_mem_limit.system_mem_used -= size;
 		kfd_mem_limit.ttm_mem_used -= size;
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
-		adev->kfd.vram_used -= size;
+		WARN_ONCE(!adev,
+			  "adev reference can't be null when alloc mem flags vram is set");
+		if (adev)
+			adev->kfd.vram_used -= size;
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
 		kfd_mem_limit.system_mem_used -= size;
 	} else if (!(alloc_flag &
@@ -193,11 +199,8 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
 		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
 		goto release;
 	}
-
-	WARN_ONCE(adev->kfd.vram_used < 0,
+	WARN_ONCE(adev && adev->kfd.vram_used < 0,
 		  "KFD VRAM memory accounting unbalanced");
-	WARN_ONCE(kfd_mem_limit.ttm_mem_used < 0,
-		  "KFD TTM memory accounting unbalanced");
 	WARN_ONCE(kfd_mem_limit.system_mem_used < 0,
 		  "KFD system memory accounting unbalanced");
 
@@ -211,7 +214,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
 	u32 alloc_flags = bo->kfd_bo->alloc_flags;
 	u64 size = amdgpu_bo_size(bo);
 
-	unreserve_mem_limit(adev, size, alloc_flags);
+	amdgpu_amdkfd_unreserve_mem_limit(adev, size, alloc_flags);
 
 	kfree(bo->kfd_bo);
 }
@@ -1601,7 +1604,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	/* Don't unreserve system mem limit twice */
 	goto err_reserve_limit;
 err_bo_create:
-	unreserve_mem_limit(adev, size, flags);
+	amdgpu_amdkfd_unreserve_mem_limit(adev, size, flags);
 err_reserve_limit:
 	mutex_destroy(&(*mem)->lock);
 	if (gobj)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index d6fc00d51c8c..329b10d1709b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -259,13 +259,22 @@ void svm_range_free_dma_mappings(struct svm_range *prange)
 	}
 }
 
-static void svm_range_free(struct svm_range *prange)
+static void svm_range_free(struct svm_range *prange, bool skip_unreserve)
 {
+	uint64_t size = (prange->last - prange->start + 1) << PAGE_SHIFT;
+	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
+
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx]\n", prange->svms, prange,
 		 prange->start, prange->last);
 
 	svm_range_vram_node_free(prange);
 	svm_range_free_dma_mappings(prange);
+
+	if (!skip_unreserve && !p->xnack_enabled) {
+		pr_debug("unreserve mem limit: %lld\n", size);
+		amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
+					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+	}
 	mutex_destroy(&prange->lock);
 	mutex_destroy(&prange->migrate_mutex);
 	kfree(prange);
@@ -284,7 +293,7 @@ svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
 
 static struct
 svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
-			 uint64_t last)
+			 uint64_t last, bool is_new_alloc)
 {
 	uint64_t size = last - start + 1;
 	struct svm_range *prange;
@@ -293,6 +302,15 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	prange = kzalloc(sizeof(*prange), GFP_KERNEL);
 	if (!prange)
 		return NULL;
+
+	p = container_of(svms, struct kfd_process, svms);
+	if (!p->xnack_enabled && is_new_alloc &&
+	    amdgpu_amdkfd_reserve_mem_limit(NULL, size << PAGE_SHIFT,
+					    KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)) {
+		pr_info("SVM mapping failed, exceeds resident system memory limit\n");
+		kfree(prange);
+		return NULL;
+	}
 	prange->npages = size;
 	prange->svms = svms;
 	prange->start = start;
@@ -307,7 +325,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	mutex_init(&prange->migrate_mutex);
 	mutex_init(&prange->lock);
 
-	p = container_of(svms, struct kfd_process, svms);
 	if (p->xnack_enabled)
 		bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
 			    MAX_GPU_INSTANCE);
@@ -1000,9 +1017,9 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
 
 	svms = prange->svms;
 	if (old_start == start)
-		*new = svm_range_new(svms, last + 1, old_last);
+		*new = svm_range_new(svms, last + 1, old_last, false);
 	else
-		*new = svm_range_new(svms, old_start, start - 1);
+		*new = svm_range_new(svms, old_start, start - 1, false);
 	if (!*new)
 		return -ENOMEM;
 
@@ -1010,7 +1027,7 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
 	if (r) {
 		pr_debug("failed %d split [0x%llx 0x%llx] to [0x%llx 0x%llx]\n",
 			 r, old_start, old_last, start, last);
-		svm_range_free(*new);
+		svm_range_free(*new, false);
 		*new = NULL;
 	}
 
@@ -1825,7 +1842,7 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 {
 	struct svm_range *new;
 
-	new = svm_range_new(old->svms, old->start, old->last);
+	new = svm_range_new(old->svms, old->start, old->last, false);
 	if (!new)
 		return NULL;
 
@@ -1951,7 +1968,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
 		/* insert a new node if needed */
 		if (node->start > start) {
-			prange = svm_range_new(svms, start, node->start - 1);
+			prange = svm_range_new(svms, start, node->start - 1, true);
 			if (!prange) {
 				r = -ENOMEM;
 				goto out;
@@ -1967,7 +1984,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
 	/* add a final range at the end if needed */
 	if (start <= last) {
-		prange = svm_range_new(svms, start, last);
+		prange = svm_range_new(svms, start, last, true);
 		if (!prange) {
 			r = -ENOMEM;
 			goto out;
@@ -1979,7 +1996,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 out:
 	if (r)
 		list_for_each_entry_safe(prange, tmp, insert_list, list)
-			svm_range_free(prange);
+			svm_range_free(prange, false);
 
 	return r;
 }
@@ -2026,7 +2043,7 @@ svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange,
 			 svms, prange, prange->start, prange->last);
 		svm_range_unlink(prange);
 		svm_range_remove_notifier(prange);
-		svm_range_free(prange);
+		svm_range_free(prange, false);
 		break;
 	case SVM_OP_UPDATE_RANGE_NOTIFIER:
 		pr_debug("update notifier 0x%p prange 0x%p [0x%lx 0x%lx]\n",
@@ -2588,14 +2605,14 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
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
+		svm_range_free(prange, false);
 		return NULL;
 	}
 
@@ -2884,7 +2901,7 @@ void svm_range_list_fini(struct kfd_process *p)
 	list_for_each_entry_safe(prange, next, &p->svms.list, list) {
 		svm_range_unlink(prange);
 		svm_range_remove_notifier(prange);
-		svm_range_free(prange);
+		svm_range_free(prange, false);
 	}
 
 	mutex_destroy(&p->svms.lock);
@@ -3299,7 +3316,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 			 prange->last);
 		svm_range_unlink(prange);
 		svm_range_remove_notifier(prange);
-		svm_range_free(prange);
+		svm_range_free(prange, true);
 	}
 
 	mmap_write_downgrade(mm);
-- 
2.32.0

