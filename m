Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3542B606A328
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 01:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2FBE10E1FE;
	Wed, 21 Oct 2026 01:59:32 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012021.outbound.protection.outlook.com [52.101.53.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 637B110E1FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 01:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dE0sZgEBzAowb2JzSKL5p8xN2+RCBInLF4wxWaZU+F+RUFbK0dbZiS1IsUhAy1tdxVapgasBdcOJ7o+e2vHJLopzYdcupNqRoyLb/YTioPD2nLaYRr3+yo7sfsPNXOgYAsrr9OgHjwf/rw5E+b4I+J4P2nNNdxJGM1i7sQbELk+9Ge5Sg+SG2J/ypwj4JDiJL2+px2EvKwn8ZQGQ9+vhpDEkh1xIcuSUNhMco3b1jKF8eeYWII3H3Exr6r826JBXeaEiVZ7AvFR+zlARMGePf85a8ydlvBtRaPBrhCL35mt6Y3FyTkP39CIurE7TzRJyDFsUMBUpg5HP+SALjMcWfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzC1exK48mVPF09gJHHtwobrxD52BFvC0W6aorOId2c=;
 b=TffYQpNVb8hXiI4wTGrwgfbS7o69k9LYYELz8GFEjxg1AEQ70RTOsZQBXFEP6ak8kD1riW+rVc8pe1gLXahWi4jmsMFkMj66m7VYi7VMMhaxZ/ve1TU/8wzTAvC99ECUlJ2X7qGnd3zMVxOSLZwV8aQlkU51MMJkv/XZLhoWlGLztw+gtjol3+//czuJLJOlYxQ7pmiApQgbHuZT7tnc6At5Q7/5QczpE8TTB9iruOWwM8xapSOLw/Dsg8mnol58Zdu3NCZ143uXScA4oE4jCg7qerkOQceLq6VCj/6h6/9n1uU/oUoH6+5bSV7ovnsYt+G2rmW+7ZHKissgnmAArQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzC1exK48mVPF09gJHHtwobrxD52BFvC0W6aorOId2c=;
 b=XnoVsSMYSslchsIdweUY90IWFvNml++ysbu3s5FzhbcpAvmPKW/qiWiDwqgtGEKLw8PeB/5gX8CVx9MU3agi+s58u7qpCo7Vd1OIox9HwDdXxzdecGflfpK1Sddv5NIkS9kmWB1wYMR8AsDJUT7ohxOSi6WXkXNFWYgS3WXAbnc=
Received: from SJ0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::9)
 by SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 01:59:21 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::18) by SJ0P220CA0004.outlook.office365.com
 (2603:10b6:a03:41b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 01:59:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 01:59:20 +0000
Received: from danielhuang-HP-EliteBook-845-14-inch-G10-Notebook-PC.amd.com
 (10.180.168.240) by satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Tue, 20 Oct 2026 20:59:19 -0500
From: Daniel Huang <danielhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Daniel Huang <danielhu@amd.com>
Subject: [PATCH v4 2/2] drm/amdkfd: bound SVM ranges by the smallest GPU
 address limit
Date: Wed, 21 Oct 2026 17:59:06 +0800
Message-ID: <20261021095906.48630-3-danielhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021095906.48630-1-danielhu@amd.com>
References: <20261021095906.48630-1-danielhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SN7PR12MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d4a5fab-91c0-4b31-18b6-08df2f16ec48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|56012099006|5023799004|11063799006|261009223027099003|10067099003|22082099003|18002099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: oDeias3GFv7W3WrrY+BlhcHwwCBmnbZQOCwywobKzzq0KC+rudIXxeq+XoSaWShdMw9OOYVYB/PRICmB8Fks4q09mXNpIQxVpEcd0aJD7jCvApedfYnQbvakaYOEwlOihJSjR6PmwibPZuPbFvnvpiJd2bxK8MxmXymquuIjGqryDnP+WYyQxxuA3quH3Dj8OeCHaGe8GYBFphe0iUS777FUDCtdm/A6EF5CWkNTith+tKA7LWt9G1MpZiKfVwR2AWfi0b1Sh+x2VFm5x2E2xMg5ClrnT4blHgYyo9cDcChmhBP7D2qt9CqKJFj6XTkO+mLFw3t8SomD55knw+HBBBVAbWVf772OFZrIuY0qEQi0R3CzR6p35lY5PSiJkJIuH3dhBOufS57/3qquFrtEqB99JrpD6jNCYbJf+0VbRhY79PpOqDfOqlHkCp+Zfq+OrjyoBU/H2+dofbEtfA98pK0yGUCYvOyjfu2LLoLEFy1zn+X5Cocpmeubd4przjUivMpQVWBpMjnmtFlGxj++6QFhv4N+Hkn7CqFJATIf7XrLLzQBrSqbf3Z/X2m5s9GnskRdJPBg8nwFwNSBzAHLBCbbSSQijUz0RKLDgDZRg2mhgLG2z9/QvMSGeBC+5KoCd+RlnKYxv12waxYUpofbZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(5023799004)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rWh+VWOd1LivDCRz0kurtiGqon1iZfY0H9MQ/Vcu5omr1b2Ay0QNujM8878w6C+pd950zs3drKitlA4taor+2YdBfY9zbgz2zLpq9a9w74KD7l4EbeDZ3kvC+NaDZyXGbNbiZ+ZLbAC5XKPxMpyrIARV+mCNOrzDsFg2dCbaXmf60ppQuyPpkCZ2OVf21KdRDqIgNAmDo4gaR6RTj4OaHdBEf0fuIjq/uBlebhfoH4C/FRnBLa1lpmbbj9w/q3Ry+jaMyB/G6G7Hj9KGlv0D6gk8qamgS35Lq6M5ddjM9wFyEnJaAzE3lsmMv8lWqlPlfvt9jw4OoJy3QjvUsvxbFbduXR+Ufrcd6ARFxe7SYsPeHr2bfC9TgdocC/mdAZiXV654gR3Ywgp9OH36+X47WDq+8015v6gD7Crtn9JbXuQzps+WrLVhQ0HzM2tMPynv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 01:59:20.9081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4a5fab-91c0-4b31-18b6-08df2f16ec48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834
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

svm_range_map_to_gpu() keeps the same condition as a WARN_ON_ONCE()
immediately before amdgpu_vm_update_range() walks the page tables. The
creation-time bounds above make it unreachable, so it asserts that
invariant rather than checking the caller, and catches a future range
creation path that forgets to apply the bound.

A process wide minimum makes a GPU with a larger GPUVM unusable above
the smallest limit in the process, even for ranges only that GPU would
map. Every SVM capable GMC generation uses a 4-level, 48-bit GPUVM
except one gfx12 variant, so the minimum is uniform in practice.

Link: https://sashiko.dev/#/patchset/20261016145129.69645-1-danielhu%40amd.com
Assisted-by: Claude:claude-opus-5
Signed-off-by: Daniel Huang <danielhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  4 +++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 43 +++++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h  |  8 +++++
 3 files changed, 52 insertions(+), 3 deletions(-)

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
index cfb428c72686..fa68fc512331 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1504,6 +1504,14 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 		return -EINVAL;
 	}
 
+	/* Ranges are bounded when they are created, so this asserts that
+	 * invariant before amdgpu_vm_update_range() walks the page tables
+	 * rather than checking the caller.
+	 */
+	if (WARN_ON_ONCE(npages && last_start + npages - 1 >=
+			 kfd_svm_gpu_va_limit_pfn(pdd)))
+		return -EINVAL;
+
 	for (i = offset; i < offset + npages; i++) {
 		uint64_t gpu_start;
 		uint64_t gpu_end;
@@ -2960,6 +2968,15 @@ svm_range *svm_range_create_unregistered_range(struct kfd_node *node,
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
@@ -3410,9 +3427,18 @@ int svm_range_list_init(struct kfd_process *p)
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
@@ -3511,6 +3537,17 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
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

