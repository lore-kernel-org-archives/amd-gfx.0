Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83CBC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 00:24:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46CEF10E510;
	Tue, 28 Jun 2022 00:24:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D407A10E899
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 00:24:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ettvjk3M8wznJLMOeeoSyCg+yH8cohGkh/gC16uaJo1ecwbRROqBsY/7jX+ArBOznA+pnaKuGvf5oAuvo3VNhFtb5Y5dJpZbtKyEYch1UJSqqVAbM9pYvhYMWH/M23u08OiEsXQVbJtRRgr+BCb0XhCHdSFUR4t7k/XUxAEadLWj84I+LAvDUEXMAIPqeJGkxG5/LK8Owg56Nz8IR1+j40Tte7rbog5n/zwWfk9Nn6SNKp+nyPvOqVdGsmPjSDMjN+OOA4Oyh8d6NdPgIR2sf/WKqcy63jE3r4G6TqDtRM4XkrSbhGdyv963TQSp68LP0xxgHXKoQCCsXTwoclf/JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKB9Agmzrq3v2khzT8RzJnApU1cJ0G5fjgFp+TThe8Q=;
 b=UCaSf4kETlIjK5CZethLgFaEAUSMj67CA8ufAMEDxHQ1+yVPv3Q7y8g8VZ7LdGeBErLdVmrsU2PKP+2Qt146mf8VRZ4wVG9iu2NPSk0hmiW77ZcPhmuFH1oMiWhEggWEIM7A4ipIjbgQQ3slqvmcgyW5V48I1mKAmmPX+YKzHPiXar25O3/nHAIuHpHDrWHnLaUAN+hW6n14aSTcVP/qizHSVZwt1TvAo1iCpIW8eaTQzaS2DHqFlRriCzJ8qsZ2MEQA1hoQ32C0r/Gln8RJD7qHX4Tlu/ZqHTlBkA2hmeeMLvHWLjWEWbjsN9zAL1m8m53EZMrU9Dgp9xdVHGMlVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKB9Agmzrq3v2khzT8RzJnApU1cJ0G5fjgFp+TThe8Q=;
 b=Lc5HpVPVTAYz/KBEMQ19FQGVqTSz3gp147XrH+IlXjt4RGPOrICmuu7i7Kcu/Oz1WGUL5uDfl3OU+Ji1JE3MdmhtbfqlbhZ9rO6ieE4j3XOEhkAaX/+Ll4KD0zuxY22FPYP0aRM/Rdm7m+RiT6iInAIY1MJXZyfFuvXAyfRF9c8=
Received: from DS7PR03CA0028.namprd03.prod.outlook.com (2603:10b6:5:3b8::33)
 by BYAPR12MB3480.namprd12.prod.outlook.com (2603:10b6:a03:aa::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 00:24:00 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::4b) by DS7PR03CA0028.outlook.office365.com
 (2603:10b6:5:3b8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16 via Frontend
 Transport; Tue, 28 Jun 2022 00:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 00:24:00 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 27 Jun
 2022 19:23:59 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdkfd: track unified memory reservation with xnack
 off
Date: Mon, 27 Jun 2022 19:23:46 -0500
Message-ID: <20220628002347.3982-2-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220628002347.3982-1-alex.sierra@amd.com>
References: <20220628002347.3982-1-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b20e94b9-58ea-4f44-cfb1-08da589c7f74
X-MS-TrafficTypeDiagnostic: BYAPR12MB3480:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LdMKk9S90mOS0U8JpbXNWHHc3iu8yyFOIlVCnclLBUYO4JVyztvGxyHF3NFo79S3DYUcbIKdbbmZUobWX7LhzTEVlDrXhJV3CwblwvKF5F5fg9y2UFrp3ldsJAdYqDfc6iUkUeRP+jOkJV/YgykfbSG7oLTAaBHnd2zkwvnRAIGU2YMIQXdvnapsOfbUHn+jiNL/Z+bKte6jK4ygPf+VF0dGhs6ZdxrJ/RkjgHtzfrbbjohLz5T+34+Zng2uQuD89XPoYcs1HpEoG4QWG/fWa1mBdBmBGPM4GBAqk3ZySRlyXGirU5rALvHKeDWi99WbvRY7B4I4kz8LJmB4I8pSeC/F6bhTPur/+Zz7jjSj0Dv3pkmWr3BRMupi5/6HkYPwHCAZCqq4LZ6YYivP8D2cYGdb7ydqFHSH3+2QKJPpa27nRTwHuxD1ixZyctCa8OXLs7IyTB32KSJml0D6Nd7A17Y8ErWdrcPzY+BZMimf9xo/a8awT78yeus0lU7zDGhNxK0BwPpSZEUz3OdgWt8fzX7YJZ54t51bNnWhMn20+BAP0NAw4JKdmszXeaM+oPzq7Ef1kNIyn0UurAPPImBsqw8lS7rcyjMdXRhQHZKMpAffERK3c3yYnbqUU5KOQUvTO3UGG4cuPJoNQBCj8iGh17+AWtlFZCHhneqriHh8cLLOXzNZqRHw1qEwj8lsrYy97JKYtKkPWKYeVgN1QHV/w2X335q5METRZOTdf63vh4BaLV7ervmqhHYcYgAGttNuEijM3hBWTIIZZnJ99Cq0yjAcRlch31s3MA/S73Cf1fd4AnZMDpj59jYeV+b3wu8g9N9YWeQVh8pMVU6gdRlFfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(39860400002)(346002)(396003)(36840700001)(46966006)(40470700004)(6666004)(186003)(5660300002)(40480700001)(16526019)(70586007)(82740400003)(4326008)(356005)(70206006)(81166007)(30864003)(7696005)(2906002)(478600001)(44832011)(336012)(36756003)(8936002)(8676002)(40460700003)(82310400005)(86362001)(2616005)(426003)(47076005)(83380400001)(36860700001)(1076003)(316002)(6916009)(41300700001)(26005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 00:24:00.1757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b20e94b9-58ea-4f44-cfb1-08da589c7f74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3480
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
Cc: Alex Sierra <alex.sierra@amd.com>, Felix.Kuehling@amd.com
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
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 58 +++++++++++++------
 3 files changed, 58 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index b25b41f50213..e6244182a3a4 100644
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
index 9142f6cc3f4d..9719577ecc6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -128,7 +128,7 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
  *
  * Return: returns -ENOMEM in case of error, ZERO otherwise
  */
-static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
+int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag)
 {
 	uint64_t reserved_for_pt =
@@ -168,7 +168,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	     kfd_mem_limit.max_system_mem_limit && !no_system_mem_limit) ||
 	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
 	     kfd_mem_limit.max_ttm_mem_limit) ||
-	    (adev->kfd.vram_used + vram_needed >
+	    (adev && adev->kfd.vram_used + vram_needed >
 	     adev->gmc.real_vram_size -
 	     atomic64_read(&adev->vram_pin_size) -
 	     reserved_for_pt)) {
@@ -179,7 +179,10 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
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
 
@@ -188,7 +191,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	return ret;
 }
 
-static void unreserve_mem_limit(struct amdgpu_device *adev,
+void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag)
 {
 	spin_lock(&kfd_mem_limit.mem_limit_lock);
@@ -197,7 +200,10 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
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
@@ -206,11 +212,8 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
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
 
@@ -224,7 +227,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
 	u32 alloc_flags = bo->kfd_bo->alloc_flags;
 	u64 size = amdgpu_bo_size(bo);
 
-	unreserve_mem_limit(adev, size, alloc_flags);
+	amdgpu_amdkfd_unreserve_mem_limit(adev, size, alloc_flags);
 
 	kfree(bo->kfd_bo);
 }
@@ -1806,7 +1809,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	/* Don't unreserve system mem limit twice */
 	goto err_reserve_limit;
 err_bo_create:
-	unreserve_mem_limit(adev, size, flags);
+	amdgpu_amdkfd_unreserve_mem_limit(adev, size, flags);
 err_reserve_limit:
 	mutex_destroy(&(*mem)->lock);
 	if (gobj)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index d6fc00d51c8c..e706cbfa924f 100644
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
+		svm_range_free(*new, true);
 		*new = NULL;
 	}
 
@@ -1825,7 +1842,7 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 {
 	struct svm_range *new;
 
-	new = svm_range_new(old->svms, old->start, old->last);
+	new = svm_range_new(old->svms, old->start, old->last, false);
 	if (!new)
 		return NULL;
 
@@ -1889,6 +1906,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	struct interval_tree_node *node;
 	struct svm_range *prange;
 	struct svm_range *tmp;
+	struct list_head new_list;
 	int r = 0;
 
 	pr_debug("svms 0x%p [0x%llx 0x%lx]\n", &p->svms, start, last);
@@ -1896,6 +1914,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	INIT_LIST_HEAD(update_list);
 	INIT_LIST_HEAD(insert_list);
 	INIT_LIST_HEAD(remove_list);
+	INIT_LIST_HEAD(&new_list);
 
 	node = interval_tree_iter_first(&svms->objects, start, last);
 	while (node) {
@@ -1951,13 +1970,13 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
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
 
@@ -1967,19 +1986,22 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
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
 	if (r)
-		list_for_each_entry_safe(prange, tmp, insert_list, list)
-			svm_range_free(prange);
+		list_for_each_entry_safe(prange, tmp, &new_list, list)
+			svm_range_free(prange, false);
+	else
+		list_for_each_entry_safe(prange, tmp, &new_list, list)
+			list_add(&prange->list, insert_list);
 
 	return r;
 }
@@ -2026,7 +2048,7 @@ svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange,
 			 svms, prange, prange->start, prange->last);
 		svm_range_unlink(prange);
 		svm_range_remove_notifier(prange);
-		svm_range_free(prange);
+		svm_range_free(prange, false);
 		break;
 	case SVM_OP_UPDATE_RANGE_NOTIFIER:
 		pr_debug("update notifier 0x%p prange 0x%p [0x%lx 0x%lx]\n",
@@ -2588,14 +2610,14 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
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
 
@@ -2884,7 +2906,7 @@ void svm_range_list_fini(struct kfd_process *p)
 	list_for_each_entry_safe(prange, next, &p->svms.list, list) {
 		svm_range_unlink(prange);
 		svm_range_remove_notifier(prange);
-		svm_range_free(prange);
+		svm_range_free(prange, false);
 	}
 
 	mutex_destroy(&p->svms.lock);
@@ -3299,7 +3321,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 			 prange->last);
 		svm_range_unlink(prange);
 		svm_range_remove_notifier(prange);
-		svm_range_free(prange);
+		svm_range_free(prange, true);
 	}
 
 	mmap_write_downgrade(mm);
-- 
2.32.0

