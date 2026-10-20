Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B6F606A326
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 05:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nTbBNxz3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB5C510EB8C;
	Tue, 20 Oct 2026 05:29:33 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013055.outbound.protection.outlook.com
 [40.93.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67B1E10E7C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 05:29:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSN6skn1V70ITn8ymlhbMno4RMtKx8LkprtPR3JByBp7iPSuLyfnnWsAvUi0y/v+fvvCqTJNfg+dq9YHr3GCTa3Y7CMIRcwnzG9vgYr4OCAf7pPfsgqXqJSvwR27CbX3GvdBP+1By6uEy1ScIE9aVDVwQxX1ocLxROD3s9JuDrxjDM8KRTROWdGAo4jWGSqbJ9f0jwY13PwNlOyp9FB1X1t33JqTl7Ae+ypK+fSTI5nPTcY+SkL53H9RADdYlFo3ZapL3AZiySw0i7qnMeh9xrbRere/C2Tze8vdSvouZ1rF2yKijHchAYvSMzpqNeqBrP8at8u/ZNhyMYlRq+Lqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoOZenu/7ilCXlTIsAsxT8KHpg8XjqkoSNl/ImpYPfc=;
 b=jCg4mR8lBw570H/6HBARv/Jr+UU4U3lmrVLTLEZ4+3Qnydqze6IT2efQFRZwHzgnLwfWDisiCA14fgedBp5tRZ5DKAmrX2rsIu5wm7NhyJc8Sw7ILcb5NTkgRHYBdq0fpUUD10jZ4WWAKBNmkAUCqB9omCv8ucBqidqpLlT5wWBbJTZfnFVuS1dWqL6cynL32SvdYDjoKIaKAgx8yKrUfL6VvIJ7/c6lnGAdg/B+aNyPMh/OSGOM9FVn8BlgLsjGgKe4ocMhw9HJcKcHWTRLp7npSm+zy18yqf/pifB9NemWJl326FcBFMxMVjG+nifBuuQHpW7WgXMCDnlbxvKHgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoOZenu/7ilCXlTIsAsxT8KHpg8XjqkoSNl/ImpYPfc=;
 b=nTbBNxz3S8/E1oawVTAn7RUdUaM/t6uWRNaWZObmY2S2CGkrZHZSsOn5yPnWewcIVJkGZ2+MtNpOQH/3wZXHuZdpUHBt8VsfAlCqAsXCVAqitwkZNX2EXq9dWFMW/Jd36JsyttU2wIyZb1HzvgEimNvV6xrVTvHh1INgxfL9tRg=
Received: from BL1P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::10)
 by PH8PR12MB7160.namprd12.prod.outlook.com (2603:10b6:510:228::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Tue, 20 Oct
 2026 05:29:20 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:208:2c7:cafe::8f) by BL1P222CA0005.outlook.office365.com
 (2603:10b6:208:2c7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 20
 Oct 2026 05:29:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Tue, 20 Oct 2026 05:29:19 +0000
Received: from danielhuang-HP-EliteBook-845-14-inch-G10-Notebook-PC.amd.com
 (10.180.168.240) by satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Tue, 20 Oct 2026 00:29:18 -0500
From: Daniel Huang <danielhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Daniel Huang <danielhu@amd.com>
Subject: [PATCH v3 2/2] drm/amdkfd: bound SVM ranges by the smallest GPU
 address limit
Date: Tue, 20 Oct 2026 21:29:01 +0800
Message-ID: <20261020132901.23157-3-danielhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020132901.23157-1-danielhu@amd.com>
References: <20261020132901.23157-1-danielhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|PH8PR12MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd636db-d267-4173-cf74-08df2e6b174d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|56012099006|5023799004|11063799006|10067099003|22082099003|18002099003|261009223027099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: OZakZJn9M28LQZL4n5Zc62k3gxNgakDTX+8ViidVNr/u9/Nw/3WBlSR7TWw7uWqONiiqCFNPsVSFydafcQD3QzEwm7FUmVirBt+Z+TX2+3R/Ptu0tHdSd9ZXIXmrKwidAN8v1IBrAvKpqYAJMdtES4DsVZt9wEsEGkxwfs/K/fO2po0XspDPohq0F0LuvEKrmQV0u20qsEFDynpyKFj5X8in3sgOxWbb1l8rWL/PpoWmJPP22nI7xZqigYfhzTxBjPWhBVkalTwnbhw1cAx1legB2ROX3qIKaQPkTLnIplDyvPC0YGV80y09bzhixRjk/SgFV/haS3IVJZUcDTrBEOjeOp+2uWXvDeWk8AN1xP6WqZOJFIekUfP+iAvqOEaXRBI2rkSDSEwq7jCfCgRiPzUkGtvDg26ThJapU5vfLRgBF1S+25+e2ooLQlTT0jclm6xcnuWCiB9+T54V1MxLDvOHuRf+GaCETkIpDZag+pqVwgQ2SWhWu7/fMn5w5tfQXp99idqjJFfG9/knDxcOK7DmWA/UPHfZQ694pU6hrVUAETonqPaLL3pwl9jO/lqxa7xTp/NxY/mYUwnh9R8F3KKFI/oI7nRvzIyFSKW1vjqfFBYUKPJRfDEz0525XAT3ux7WYnH2EuVvkTTjFdAjpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(56012099006)(5023799004)(11063799006)(10067099003)(22082099003)(18002099003)(261009223027099003)(6133799003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: on1HUPVXMUzqVumuvUorRIW10V4afPMlzS9ZTIqbJoJzUy0SPVj4x/Fg/Kkhx0VcnDfA5MZ5I2ca4owPb4ocCCxGdwr/sWjfISO1xSVL5X0PI0NbWaipZdMoREziXGJjs7J4GsYpEfYjnkl7Ix0wkyabTTIjigd/mcb6ygy8sJqGuu7+H2zkgkpQUydfHLDRy84QYBh+ueiCL/kkzfyupYGpYoG+2cWPWVrh/9xdnExZuh78MVyrBCOPFU7qEL9lWJkbyNIcaKdZgmCucztExTzP9r3bngAF3a35K9SYUn8na9kN9PYG59+w9F3jjafnHNnff4FZTrja5gIdQ1HimMVl+b6elXIFF4M8MOaaERUvxKAx5JQij5nd+oJUCUEOfvlxO3T26jRzTYjvdNdhAgowgRygdx2yJWeg8dhfj/qNALNiqE/iIr+bujV+LzBp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 05:29:19.6830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd636db-d267-4173-cf74-08df2e6b174d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7160
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

KFD SVM maps memory in GPUVM at the same virtual address used by the
CPU, but nothing bounds that address against what the GPU can
represent. kfd_ioctl_svm() checks only page alignment and a non-zero
size, so the PFNs reach amdgpu_vm_update_range() unvalidated. Unlike
the SVM path, the BO mapping path validates the address range through
amdgpu_vm_verify_parameters().

Disabling SVM when the GPUVM cannot cover AMDGPU_GMC_HOLE_START closes
the case where the GPUVM is globally too small, but it compares the
GPUVM against the GPU's own address hole. When the CPU address space is
larger than the GPU's, the comparison succeeds and SVM stays enabled
while individual addresses can still fall outside the GPUVM.

On a 5-level paging CPU with a 4-level GPU, mmap() returns addresses
above the GPU limit when user space passes a hint above
DEFAULT_MAP_WINDOW. Passing such an address to KFD SVM indexes beyond
the allocated root page-table entries in amdgpu_vm_pt_descendant().

This gap was found by the Sashiko AI review bot, during review of the
first patch in this series.

Determine the smallest GPUVM among the SVM capable GPUs of the process
in svm_range_list_init(), where the pdds are already final, and store
it in svm_range_list as the first CPU page index that cannot be mapped.
Reuse shared_resources.gpuvm_size, which the KFD already derives from
vm_manager.max_pfn and the GPUVM address hole, and reports to user
space as pdd->gpuvm_limit.

Validate against that limit where ranges are created, so that an
address the GPUs cannot map is rejected as early as possible and never
results in a range that is silently left unmapped:

 - svm_range_is_valid() rejects out of range set_attr and get_attr
   ioctls with -EINVAL, before any range is allocated.
 - svm_range_create_unregistered_range() rejects an out of range fault
   address, which svm_range_restore_pages() reports as -EFAULT. The
   range boundaries widen the fault address to the granularity, so the
   widened range is clamped rather than the fault refused.

svm_range_map_to_gpu() keeps a hard check so that no out of range PFN
can reach amdgpu_vm_update_range() through any caller.

A process wide minimum makes a GPU with a larger GPUVM unusable above
the smallest limit in the process, even for ranges only that GPU would
map. Every SVM capable GMC generation uses a 4-level, 48-bit GPUVM
except one gfx12 variant, so the minimum is uniform in practice.

Link: https://sashiko.dev/#/patchset/20261016145129.69645-1-danielhu%40amd.com
Assisted-by: Claude:claude-opus-5
Signed-off-by: Daniel Huang <danielhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  4 +++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 44 +++++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h  |  8 +++++
 3 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index b9a31489b1c8..a800515baf4a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -907,6 +907,10 @@ struct svm_range_list {
 	atomic_t			drain_pagefaults;
 	struct delayed_work		restore_work;
 	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
+	/* First CPU page index beyond the smallest GPUVM supported by the
+	 * SVM capable GPUs of this process. Zero if none support SVM.
+	 */
+	uint64_t			max_va_pfn;
 	struct task_struct		*faulting_task;
 	/* check point ts decides if page fault recovery need be dropped */
 	atomic64_t			checkpoint_ts[MAX_GPU_INSTANCE];
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index cfb428c72686..3fa0d6ff7236 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1504,6 +1504,15 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 		return -EINVAL;
 	}
 
+	/* Backstop before amdgpu_vm_update_range() walks the page tables.
+	 * Ranges are bounded when created, so this is not expected to trigger.
+	 */
+	if (npages && last_start + npages - 1 >= kfd_svm_gpu_va_limit_pfn(pdd)) {
+		pr_debug("CPU[0x%lx 0x%lx] exceeds GPUVM, canceling map\n",
+			 last_start, last_start + npages - 1);
+		return -EINVAL;
+	}
+
 	for (i = offset; i < offset + npages; i++) {
 		uint64_t gpu_start;
 		uint64_t gpu_end;
@@ -2960,6 +2969,15 @@ svm_range *svm_range_create_unregistered_range(struct kfd_node *node,
 					   &is_heap_stack))
 		return NULL;
 
+	if (p->svms.max_va_pfn) {
+		if (addr >= p->svms.max_va_pfn) {
+			pr_debug("fault address 0x%llx exceeds GPUVM limit 0x%llx\n",
+				 addr, p->svms.max_va_pfn);
+			return NULL;
+		}
+		last = min_t(unsigned long, last, p->svms.max_va_pfn - 1);
+	}
+
 	r = svm_range_check_vm(p, start, last, &bo_s, &bo_l);
 	if (r != -EADDRINUSE)
 		r = svm_range_check_vm_userptr(p, start, last, &bo_s, &bo_l);
@@ -3410,9 +3428,18 @@ int svm_range_list_init(struct kfd_process *p)
 	INIT_LIST_HEAD(&svms->criu_svm_metadata_list);
 	spin_lock_init(&svms->deferred_list_lock);
 
-	for (i = 0; i < p->n_pdds; i++)
-		if (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev->adev))
-			bitmap_set(svms->bitmap_supported, i, 1);
+	/* The ranges of this process must fit in every GPU that can map them,
+	 * so bound them by the smallest GPUVM among the SVM capable GPUs.
+	 */
+	for (i = 0; i < p->n_pdds; i++) {
+		struct kfd_process_device *pdd = p->pdds[i];
+
+		if (!KFD_IS_SVM_API_SUPPORTED(pdd->dev->adev))
+			continue;
+		bitmap_set(svms->bitmap_supported, i, 1);
+		svms->max_va_pfn = min_not_zero(svms->max_va_pfn,
+						kfd_svm_gpu_va_limit_pfn(pdd));
+	}
 
 	 /* Value of default granularity cannot exceed 0x1B, the
 	  * number of pages supported by a 4-level paging table
@@ -3511,6 +3538,17 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
 	if (check_add_overflow(start, size << PAGE_SHIFT, &end))
 		return -EOVERFLOW;
 
+	/* Reject up front what the GPUs of this process cannot map, rather
+	 * than letting the mapping fail later on.
+	 */
+	if (p->svms.max_va_pfn &&
+	    (end - 1) >> PAGE_SHIFT >= p->svms.max_va_pfn) {
+		pr_debug("CPU[0x%lx 0x%lx] exceeds GPUVM limit 0x%llx\n",
+			 start_unchg, (end - 1) >> PAGE_SHIFT,
+			 p->svms.max_va_pfn);
+		return -EINVAL;
+	}
+
 	do {
 		vma = vma_lookup(p->mm, start);
 		if (!vma || (vma->vm_flags & device_vma))
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index f61030408f45..268a545302bd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -213,6 +213,14 @@ static inline bool kfd_svm_vm_covers_user_va(struct amdgpu_device *adev)
 		AMDGPU_GMC_HOLE_START;
 }
 
+/* First CPU page index that this GPU's GPUVM cannot represent. An SVM range
+ * is mappable on pdd only if its last page lies below this.
+ */
+static inline uint64_t kfd_svm_gpu_va_limit_pfn(struct kfd_process_device *pdd)
+{
+	return pdd->dev->kfd->shared_resources.gpuvm_size >> PAGE_SHIFT;
+}
+
 /* SVM API and HMM page migration work together, device memory type
  * is initialized to not 0 when page migration register device memory.
  */
-- 
2.53.0

