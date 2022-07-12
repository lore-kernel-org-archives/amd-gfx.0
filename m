Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1C5C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 01:56:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE4798E519;
	Tue, 12 Jul 2022 01:56:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3984B8E519
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 01:56:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXMDboPObXBFLywpvirNokUcgKB/i7Ew/Pj7TsHzZR+1ctiqld3tPKuCPga7W/XA2nKt5ftPd5Jc9hPBaWsedKr8nkYcQDTXm16vp7VdTo/sWpVKYGEYaZJRN3dR9hhK2d7H30MQLku+wAHViP1vi2Z9+hj4Bd/2WTXUlh6LNd23yiKM2eyfBg9pxkVuieaX2AlEq2W5rb2QsXRo+XQJaGXWbTgOI9FZ0B6KnYVCOU/72m+WjNAZT2Gr+irbdGe01Cuh9e9ub2UyYjkKtq31+yYC6u2eSh53HdD+zjALR7kHeTZ0t2S9478ZLxrNrN05XfHYPBQjbvljo8Hb2LF1iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZafFXW5y9y8AldPZzV7blCw2rO6xo1b6c8kuUhyVZE=;
 b=byflXduK4gM+twrhMm3w0e4ZRcKNFOeiVRcjQwjmJ3vVM2/UF/NTkRI+8gVcJ3PQMoTHM74b5zvmqPDFQ4D8etKY6kqSN4q1sNtJGvtPxef6rwo9+dgSS8ek4iEOli4GQdels/PGJLg7FxEuSXk+5KbYAwsuro33kWnVVfXQlei8LsJ25wSSefrRBfX5jYr8hVquyfL567GMijSRTxuU1SJyqO4NpSi483hxBh3g95CY6X3z+IH0TXoBJ8Hq+RUtzH9zGm7sytdHovsmpBF4JXj9Lw00NylMv+b91nP9JNqgrQwYkAIdzOz3RJ/3M+VxgE7lyJBVruOi0WiYZn2Wyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZafFXW5y9y8AldPZzV7blCw2rO6xo1b6c8kuUhyVZE=;
 b=Qi6tfbewjUCd/9mmK2f3MXyafbv++zolOlUuH++STuTyzJbzZRh6ysQmwJEjnJsDn/LrPu6P2Q78Cpw5CwS7JJava/hy0yOErHXLweW4ERwJKdIj+Q435AkJAeTcMP6lHbnK+Mq0+XI/Omj5mNSqtWuqRXFTB/wYb0Pq7TX9v1U=
Received: from BN8PR04CA0059.namprd04.prod.outlook.com (2603:10b6:408:d4::33)
 by BL1PR12MB5947.namprd12.prod.outlook.com (2603:10b6:208:39a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Tue, 12 Jul
 2022 01:56:19 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::f8) by BN8PR04CA0059.outlook.office365.com
 (2603:10b6:408:d4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Tue, 12 Jul 2022 01:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 01:56:18 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 11 Jul
 2022 20:56:17 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdkfd: track unified memory reservation with xnack
 off
Date: Mon, 11 Jul 2022 20:56:03 -0500
Message-ID: <20220712015604.7697-2-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220712015604.7697-1-alex.sierra@amd.com>
References: <20220712015604.7697-1-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97f0ee68-4d6a-42e2-55f9-08da63a9b695
X-MS-TrafficTypeDiagnostic: BL1PR12MB5947:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I8EuEkP14kxM/xVtwt+3PfAPw1gDpMg0TIRzl3FD711jNRFg4B62nP43MylQy028cW+C5q99acVoKCeapM632Ovm8PwG0A7mf3k3CR/eN//E88iuGRCII7vYileeuWnNQ3oB6y7pszKQ3ZC8ILnMfJHqwMH0+J21jCVnHhzB9QehHZopWUcHDUpLpRUU/sS+ry5yfDqtZ4GfqCMfmd3S3XGNf1Pma9AAW+XoBdAuBLJNECJ7Gao0kqNHTBzmy+1lsuzyidigD7ROiKGOWBmMQF41UsQ9l16WTyz/iEbCTz6WCNYmRl3WMdOQsrHdpYzeIm18yJ/92pp0LltGSobouUr9RwwxAa7c5BHzUjauspNFrAhFMXJir0n9CnVKFzzPdlC2Rl+Tjx+pNXWgNgZ5BqzyYuA4pcaIW3wL75zFDlUIDaaq9IUKUEUskJgmvEdOo/dy28YRko3DHmXPaa88qqYVSx5OW0eQjeHs8UV4B/ZxKuz7slvN5jLe7RNK5J2Z9V/Y8yR2O1ZJz2vUn1Th3bKjdyfzCgVJ3qR2FF1Oam4BsVonzMHT3pOUepdNFNdxCwyGDdVN8ITzUyarRodUu7R6sz/zRWI21Xd+B/LxgWhA+m/olYtE0h9rhRKCNP0D8f2YzCNaoxiEtM8KSopca6yWrvrPdb51hgsGpe1y/uz+gQLfl155vgQlq6D0Q750eDHfg4y5MKN8JT3XazkuZBbwTP2cd1rRa/xAJWwkxnKlIb8FTckTipqIt8hEUAXAa/T+y9+jbBS/Qi1o5/suq0ghlUlkM8fu8x2iuavQTrejVEBfuD7VTR80ZkhreVe65zVsbDyBp+lTz5AAjDb5uTR32c8KmaWzrKrBb9qnIaw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(136003)(396003)(346002)(36840700001)(46966006)(40470700004)(36860700001)(2906002)(36756003)(70206006)(2616005)(8936002)(47076005)(82740400003)(478600001)(356005)(40480700001)(81166007)(30864003)(426003)(6916009)(336012)(82310400005)(86362001)(70586007)(316002)(16526019)(4326008)(41300700001)(6666004)(44832011)(7696005)(8676002)(5660300002)(186003)(1076003)(40460700003)(83380400001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 01:56:18.9584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f0ee68-4d6a-42e2-55f9-08da63a9b695
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5947
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
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 25 ++++----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 60 +++++++++++++------
 3 files changed, 60 insertions(+), 29 deletions(-)

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
index 2bc36ff0aa0f..7480e7333e5d 100644
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
@@ -207,11 +213,8 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
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
 
@@ -225,7 +228,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
 	u32 alloc_flags = bo->kfd_bo->alloc_flags;
 	u64 size = amdgpu_bo_size(bo);
 
-	unreserve_mem_limit(adev, size, alloc_flags);
+	amdgpu_amdkfd_unreserve_mem_limit(adev, size, alloc_flags);
 
 	kfree(bo->kfd_bo);
 }
@@ -1788,7 +1791,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	/* Don't unreserve system mem limit twice */
 	goto err_reserve_limit;
 err_bo_create:
-	unreserve_mem_limit(adev, size, flags);
+	amdgpu_amdkfd_unreserve_mem_limit(adev, size, flags);
 err_reserve_limit:
 	mutex_destroy(&(*mem)->lock);
 	if (gobj)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b592aee6d9d6..b62ead8d70bf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -260,13 +260,22 @@ void svm_range_free_dma_mappings(struct svm_range *prange)
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
@@ -285,7 +294,7 @@ svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
 
 static struct
 svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
-			 uint64_t last)
+			 uint64_t last, bool is_new_alloc)
 {
 	uint64_t size = last - start + 1;
 	struct svm_range *prange;
@@ -294,6 +303,15 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
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
+		svm_range_free(*new, true);
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
+			svm_range_free(prange, true);
+		list_for_each_entry_safe(prange, tmp, &new_list, list)
+			svm_range_free(prange, false);
+	} else if (!list_empty(&new_list)) {
+		list_splice(&new_list, insert_list);
+	}
 
 	return r;
 }
@@ -2047,7 +2071,7 @@ svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange,
 			 svms, prange, prange->start, prange->last);
 		svm_range_unlink(prange);
 		svm_range_remove_notifier(prange);
-		svm_range_free(prange);
+		svm_range_free(prange, false);
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
+		svm_range_free(prange, false);
 		return NULL;
 	}
 
@@ -2917,7 +2941,7 @@ void svm_range_list_fini(struct kfd_process *p)
 	list_for_each_entry_safe(prange, next, &p->svms.list, list) {
 		svm_range_unlink(prange);
 		svm_range_remove_notifier(prange);
-		svm_range_free(prange);
+		svm_range_free(prange, false);
 	}
 
 	mutex_destroy(&p->svms.lock);
@@ -3333,7 +3357,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 			 prange->last);
 		svm_range_unlink(prange);
 		svm_range_remove_notifier(prange);
-		svm_range_free(prange);
+		svm_range_free(prange, true);
 	}
 
 	mmap_write_downgrade(mm);
-- 
2.32.0

