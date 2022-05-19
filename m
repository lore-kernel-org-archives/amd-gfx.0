Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CC1C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 16:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 072B710E209;
	Thu, 19 May 2022 16:22:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ABE110E11D
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 16:22:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foKPAMDQkBNpZkelDsdaO58t0G1zz70pcuQ7mgWJDf6Wgh9DjagnBBjXoTh5pH8ZIAvsONfQ5SNxq3i7mrUpa++5PlaVDJHOtqO1RXJKJBTaoLUMICBWvPz4/61gqur/9aZZaJTmiqWsldHaZLHXTGd3tsluikyxSxpzgpciPcgVLTIEQHG8+ZQQ9+ufD/24Zsbfv/w0GvWARaNlLPQK1QMGgRiujQ2m+aVj6aFSD9h36TgzHoo0fIBGZ2ppDYgHDqMUl02EaXffBNzAqTR1Ng1gD4nwtFGovf/zxkPH0zK/klGLLnUESLJRxunavfyv3WBvq0cpKAS+leR4A8OiMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pl8QaQUJsHz/FrVOBwUa8SLn/jvH8yPIu8Xwx+OPw0=;
 b=dNDTwdXGvRH+NdlMNLUhyLdW1v9PeJ1vdNr0ngD+wMBkMnPuUZwrNyJB39sBEnhKXRxOZLzb4KSLvLTbTrw4pgu1H+UcYoT06+cykxoOoHS89uW1IybwJCOHScpId43zh/yX34d0MGK5jJ5ArRMbGRLPoCzyn3+PCtL/llRttFn+aBx+XTdJwOb10MClUMGH4uvnPybughLY9tl9QzEOyRbWkJjzZJ1oGawr5F7U07LGcGehWwmjMlZ4E/OwJBhKjbl43fmd1QjNgp9Gr3Oe5g95U9PaGlfqWxa/sWrgqFKEhZ9TFokdX1rznFSXCFInFVrnAtngA4Dn3u957ZN3uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pl8QaQUJsHz/FrVOBwUa8SLn/jvH8yPIu8Xwx+OPw0=;
 b=ZrOFJyocZCmTTj3DYcHUAONcskv8sgaTKezIin5wZHR+DbB700lVU9/sHkW41yIpRMPgixJkySzjlOjzpiFFYfp+LJwDm7kOpDvbC+MGkpBjGIdpVeJyBxV+xF1BJJkbrLsbutiT0s/bZapQjnPowy4F8jatohD+AjltlsT+FE8=
Received: from BN9PR03CA0529.namprd03.prod.outlook.com (2603:10b6:408:131::24)
 by BN8PR12MB3506.namprd12.prod.outlook.com (2603:10b6:408:9e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Thu, 19 May
 2022 16:22:29 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::dd) by BN9PR03CA0529.outlook.office365.com
 (2603:10b6:408:131::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13 via Frontend
 Transport; Thu, 19 May 2022 16:22:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 16:22:28 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 11:22:27 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdkfd: track unified memory reservation with xnack
 off
Date: Thu, 19 May 2022 11:21:53 -0500
Message-ID: <20220519162153.6268-2-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220519162153.6268-1-alex.sierra@amd.com>
References: <20220519162153.6268-1-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a743f793-3664-4e33-2124-08da39b3c4c7
X-MS-TrafficTypeDiagnostic: BN8PR12MB3506:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB350672DBE70F8BFC4C251793FDD09@BN8PR12MB3506.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wxExj2no6VaBRxPBqAMitPDzFotdi3aDOPaHSFm9OenJmkTDl6jap/imxNIORWYrYEPtyPT84wUzhlxNBvZpLta7OUdkqsB4AnApwVsWH4VMkKpO2hg647xCsfjyjgxcJGcEyP8ZCUWf2gOZpCQ8CL8hPYzWmvjNs0c3JFCLjmn0hydB7fw2EwzUIJUrtwTNaUjorEvmYdEEo93YEqysr+HiQSbiHWj19WZYtTEbeP8kBreTU5Yak6Sz/LzF9Arv4R+ueH9hzvxu28OkgKhUlSn3u8QUtWg1Ru4Vh0BCud/6DurYEJbl+7iqDqb0rEWJ24cWhoPYPiiL0NJeZtornQ9eQNDnPgKJFHPKGDigSZgJCurkHX5HA7HvWOcLuzCBhdBb6QlrAJzmLomx8xy5ns8RooRi2xTgISLSgIfuk3FQhG0/sWSMd6jFdRSz2g2wrKydRZuwVnQNYIlPsSg//SUtQs5wapU/5cwZUiskVb+RSdGSFi4ihnuDHv6GK3pS1mIp5yR9B6aY+tiOaPWYyBw43rVezVyBkXrA1GCS6kBoH4oGb/HTpbz/tnN4Lq32aM/vGFXVV0Z+QTA1KzGGRqrHgk6b6EqQ8OUotHBcLONvMdrls33uMUla2OjZW2NOgvfj6m3QynfsJTVBZuj+NhE/z28gvgDeYTT8nxrkejnIu2myw/0WoRGnRsJofJmBABy1fRk24uGCUdByQfxeHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36756003)(40460700003)(7696005)(426003)(2616005)(508600001)(47076005)(26005)(6666004)(316002)(70586007)(83380400001)(70206006)(6916009)(4326008)(336012)(186003)(8676002)(16526019)(44832011)(81166007)(8936002)(356005)(36860700001)(1076003)(82310400005)(5660300002)(86362001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 16:22:28.9035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a743f793-3664-4e33-2124-08da39b3c4c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3506
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  4 +++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 24 +++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 34 ++++++++++++++-----
 3 files changed, 43 insertions(+), 19 deletions(-)

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
index 966714dd764b..615e2b34fe12 100644
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
@@ -166,7 +166,8 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	/* Update memory accounting by decreasing available system
 	 * memory, TTM memory and GPU memory as computed above
 	 */
-	adev->kfd.vram_used += vram_needed;
+	if (adev)
+		adev->kfd.vram_used += vram_needed;
 	kfd_mem_limit.system_mem_used += system_mem_needed;
 	kfd_mem_limit.ttm_mem_used += ttm_mem_needed;
 
@@ -175,7 +176,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	return ret;
 }
 
-static void unreserve_mem_limit(struct amdgpu_device *adev,
+void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag)
 {
 	spin_lock(&kfd_mem_limit.mem_limit_lock);
@@ -184,7 +185,8 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
 		kfd_mem_limit.system_mem_used -= size;
 		kfd_mem_limit.ttm_mem_used -= size;
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
-		adev->kfd.vram_used -= size;
+		if (adev)
+			adev->kfd.vram_used -= size;
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
 		kfd_mem_limit.system_mem_used -= size;
 	} else if (!(alloc_flag &
@@ -193,9 +195,9 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
 		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
 		goto release;
 	}
-
-	WARN_ONCE(adev->kfd.vram_used < 0,
-		  "KFD VRAM memory accounting unbalanced");
+	if (adev)
+		WARN_ONCE(adev->kfd.vram_used < 0,
+			"KFD VRAM memory accounting unbalanced");
 	WARN_ONCE(kfd_mem_limit.ttm_mem_used < 0,
 		  "KFD TTM memory accounting unbalanced");
 	WARN_ONCE(kfd_mem_limit.system_mem_used < 0,
@@ -211,7 +213,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
 	u32 alloc_flags = bo->kfd_bo->alloc_flags;
 	u64 size = amdgpu_bo_size(bo);
 
-	unreserve_mem_limit(adev, size, alloc_flags);
+	amdgpu_amdkfd_unreserve_mem_limit(adev, size, alloc_flags);
 
 	kfree(bo->kfd_bo);
 }
@@ -1601,7 +1603,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	/* Don't unreserve system mem limit twice */
 	goto err_reserve_limit;
 err_bo_create:
-	unreserve_mem_limit(adev, size, flags);
+	amdgpu_amdkfd_unreserve_mem_limit(adev, size, flags);
 err_reserve_limit:
 	mutex_destroy(&(*mem)->lock);
 	if (gobj)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 835b5187f0b8..1380c2fee0dc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -261,11 +261,21 @@ void svm_range_free_dma_mappings(struct svm_range *prange)
 
 static void svm_range_free(struct svm_range *prange)
 {
+	uint64_t size = (prange->last - prange->start + 1) << PAGE_SHIFT;
+	struct kfd_process *p;
+
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx]\n", prange->svms, prange,
 		 prange->start, prange->last);
 
 	svm_range_vram_node_free(prange);
 	svm_range_free_dma_mappings(prange);
+
+	p = container_of(prange->svms, struct kfd_process, svms);
+	if (!p->xnack_enabled) {
+		pr_debug("unreserve mem limit: %lld\n", size);
+		amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
+					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+	}
 	mutex_destroy(&prange->lock);
 	mutex_destroy(&prange->migrate_mutex);
 	kfree(prange);
@@ -284,7 +294,7 @@ svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
 
 static struct
 svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
-			 uint64_t last)
+			 uint64_t last, bool is_new_alloc)
 {
 	uint64_t size = last - start + 1;
 	struct svm_range *prange;
@@ -293,6 +303,15 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
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
@@ -307,7 +326,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	mutex_init(&prange->migrate_mutex);
 	mutex_init(&prange->lock);
 
-	p = container_of(svms, struct kfd_process, svms);
 	if (p->xnack_enabled)
 		bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
 			    MAX_GPU_INSTANCE);
@@ -1000,9 +1018,9 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
 
 	svms = prange->svms;
 	if (old_start == start)
-		*new = svm_range_new(svms, last + 1, old_last);
+		*new = svm_range_new(svms, last + 1, old_last, false);
 	else
-		*new = svm_range_new(svms, old_start, start - 1);
+		*new = svm_range_new(svms, old_start, start - 1, false);
 	if (!*new)
 		return -ENOMEM;
 
@@ -1825,7 +1843,7 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 {
 	struct svm_range *new;
 
-	new = svm_range_new(old->svms, old->start, old->last);
+	new = svm_range_new(old->svms, old->start, old->last, false);
 	if (!new)
 		return NULL;
 
@@ -1951,7 +1969,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
 		/* insert a new node if needed */
 		if (node->start > start) {
-			prange = svm_range_new(svms, start, node->start - 1);
+			prange = svm_range_new(svms, start, node->start - 1, true);
 			if (!prange) {
 				r = -ENOMEM;
 				goto out;
@@ -1967,7 +1985,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
 	/* add a final range at the end if needed */
 	if (start <= last) {
-		prange = svm_range_new(svms, start, last);
+		prange = svm_range_new(svms, start, last, true);
 		if (!prange) {
 			r = -ENOMEM;
 			goto out;
@@ -2585,7 +2603,7 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 		last = addr;
 	}
 
-	prange = svm_range_new(&p->svms, start, last);
+	prange = svm_range_new(&p->svms, start, last, true);
 	if (!prange) {
 		pr_debug("Failed to create prange in address [0x%llx]\n", addr);
 		return NULL;
-- 
2.32.0

