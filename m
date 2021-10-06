Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A86FC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 14:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9115610EA
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 14:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E9115610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83FF16ECE4;
	Wed,  6 Oct 2021 14:32:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D9076E525
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 14:32:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csWO3J75IE3xg+c+28EtsfZenizD3lpsFhaajjGet+g12cFRhQjhF7n2MurB45HsUZXtkkQH78/2C1++flKfHDpKeloAA9JLkaPiSwQJXm5FnBUlEQEy1YOhJppITFomuQcIlDqs9UiDeq9D1SdK4VZwoLT4afwR0o5B4Xe+m+eSkz5bZLXu4M6/FBxFY0xLBKMdtNY6Ym4Prv0Lzr1A/CETIGlgVlJ1wJJF5/9ICDQSSxXznJ1TePFidvQrFIQmnEl2jz3cnw31Di3BH+zL1u2qIQuKdYDP2CvoBvhxa9gwvjP1L6ModWz32nVfv5bo5biT/NuylYwv+YB2rOqn4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+uW8dTAW6WeiHjuDaMK3zbMZp0wXtLz8xTiUpbP8+M=;
 b=TDiUO1R2lQcD+ibzMZZ6UkPJ+zxNKFlbPUHhegS9kPwuZ89Y+O2Aj6hV/9+M8JlqDjQwJLoNcSL0vwCyaNRwJ+2fN8dDxmrJqvACa6UMzb4HXsyr+AQoFbAJnEte6+vNZ/bv/xxEGC62HZL5Xsg2K9/6Umig+yxDC1TyI1ScBfOvveoLprnl6/tFIc8ITkF/hepcXwSPDZMwZsLmBm1gtAij47m901AoZGyNuWPA3h3NaxRT1T1Yx8Os9/LcEdHDBhI87XAwFyEXdctsvhQ3xq5SoTuJola9LIDhIO1WTL9+6OxNcQyEoYgQOH/k+WHM50UhnVxVHnr7oHh4Zuwx6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+uW8dTAW6WeiHjuDaMK3zbMZp0wXtLz8xTiUpbP8+M=;
 b=hEI8WMixSZL3UZckxGbeONWwIXoTvrFTXVoW74h9eW8nXQblLwqi23xSfLs+CJrMXHii12bxdvpVY7fLUcfltDZVc3RfbUN/oJRa+7VfRNl80VibYFsQfFsnL5JrD9UjjqcHU8bFnLfM3Ez3jh/8DGyKl2E1ak5VCdeW6Eootdw=
Received: from MWHPR22CA0005.namprd22.prod.outlook.com (2603:10b6:300:ef::15)
 by MN2PR12MB3565.namprd12.prod.outlook.com (2603:10b6:208:c2::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Wed, 6 Oct
 2021 14:32:29 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::c8) by MWHPR22CA0005.outlook.office365.com
 (2603:10b6:300:ef::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Wed, 6 Oct 2021 14:32:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Wed, 6 Oct 2021 14:32:29 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 6 Oct 2021
 09:32:28 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 3/4] drm/amdkfd: avoid svm conflicting with userptr address
Date: Wed, 6 Oct 2021 10:32:09 -0400
Message-ID: <20211006143210.4954-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211006143210.4954-1-Philip.Yang@amd.com>
References: <20211006143210.4954-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d757281-3b79-4bbd-0bcf-08d988d62018
X-MS-TrafficTypeDiagnostic: MN2PR12MB3565:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3565ED6CB40F424033114BF9E6B09@MN2PR12MB3565.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oETMFgCp7wC1TvRVxXIzUPh/k+zq02m1faw8p9nuw88lC2OAY6LhpvhFIUpi6NNyBBhI3vWxOZUCzmULJwRiH8EWJLV9fLPIRK/y4OhQZqa20YyL7iJ3blo+Yp4rG+yf8EWZdFkJDKxleyHxNjeX5FSK6tcqvLik1mtJriSDLs3DlryF+AVUutP1fh3T7e33gIr9yVXgoSNw47le2hQddrkyXpBTS6CnSnICKiraKO2sHM8hUyAKJOZE31N9wRtJImt0thM/THBfCfT2o7ikoePXs+IT2+mCXfG2kGpfHATjFtbvN/X1ypThol9gJmWM2eA1g9CIV2mcoWo0N5hKz4LoyXDMqhvw+Cl+fjwgY+H+4I37is7IY1qqiSQGkutaymguFL6G7/59geqHDGTSB3pYkGWCU6cuzz3UxVXuQldKxrQgTamb11o7j8DfkE3e9bflABgIyIUnIIO0khBalUa6/U0Ybb7InurfFgZ3jygWwLwm5ihu/P+fTXCEzk+WdbPWTbbBST4Paf8X3AeEOF5VTs3rRafpF8zYg34f7nu/WCa9fXCSjpfg6/n7Pam/z3VNpuRFUYTe7ZSJr8jVarZx/o5eD6oSCoCDixmZ02BPgNCi09otfuvbkZncKHdkPtIMDC8ZH8yHqnazK5MHUfCpT8dP9UpjTzAPDZCsp9IeE8i3vyK4u1Jpj3LqbTwZ495xzRuosoiJRd0OTL33WRSrljaSZFDcIOiNBetgNmQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2616005)(81166007)(6916009)(336012)(426003)(70206006)(70586007)(1076003)(36860700001)(82310400003)(186003)(508600001)(6666004)(86362001)(16526019)(8676002)(47076005)(2906002)(5660300002)(36756003)(26005)(7696005)(356005)(4326008)(83380400001)(8936002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 14:32:29.1012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d757281-3b79-4bbd-0bcf-08d988d62018
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3565
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

For ioctl_alloc_memory_of_gpu to alloc userptr bo, check userptr address
does not exist in svm->objects.

For svm range allocation, look for address in the userptr range of
interval tree VA nodes.

Change helper svm_range_check_vm to return amdgpu_bo, which will be used
to avoid creating new svm range overlap with bo later.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 17 +++++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 55 +++++++++++++++++++-----
 2 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f1e7edeb4e6b..34dfa6a938bf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1255,6 +1255,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	long err;
 	uint64_t offset = args->mmap_offset;
 	uint32_t flags = args->flags;
+	unsigned long start, last;
 
 	if (args->size == 0)
 		return -EINVAL;
@@ -1266,11 +1267,17 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	svm_range_list_lock_and_flush_work(&p->svms, current->mm);
 	mutex_lock(&p->svms.lock);
 	mmap_write_unlock(current->mm);
-	if (interval_tree_iter_first(&p->svms.objects,
-				     args->va_addr >> PAGE_SHIFT,
-				     (args->va_addr + args->size - 1) >> PAGE_SHIFT)) {
-		pr_err("Address: 0x%llx already allocated by SVM\n",
-			args->va_addr);
+
+	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
+		start = args->mmap_offset >> PAGE_SHIFT;
+		last = (args->mmap_offset + args->size - 1) >> PAGE_SHIFT;
+	} else {
+		start = args->va_addr >> PAGE_SHIFT;
+		last = (args->va_addr + args->size - 1) >> PAGE_SHIFT;
+	}
+
+	if (interval_tree_iter_first(&p->svms.objects, start, last)) {
+		pr_err("[0x%lx 0x%lx] already allocated by SVM\n", start, last);
 		mutex_unlock(&p->svms.lock);
 		return -EADDRINUSE;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 7f0743fcfcc3..d49c08618714 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2679,15 +2679,18 @@ int svm_range_list_init(struct kfd_process *p)
  *
  * Context: Process context
  *
- * Return 0 - OK, if the range is not mapped.
+ * Return NULL - if the range is not mapped.
+ * amdgpu_bo - if the range is mapped by old API
  * Otherwise error code:
- * -EADDRINUSE - if address is mapped already by kfd_ioctl_alloc_memory_of_gpu
  * -ERESTARTSYS - A wait for the buffer to become unreserved was interrupted by
  * a signal. Release all buffer reservations and return to user-space.
  */
-static int
+static struct amdgpu_bo *
 svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last)
 {
+	struct amdgpu_bo_va_mapping *mapping;
+	struct interval_tree_node *node;
+	struct amdgpu_bo *bo = NULL;
 	uint32_t i;
 	int r;
 
@@ -2700,16 +2703,42 @@ svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last)
 		vm = drm_priv_to_vm(p->pdds[i]->drm_priv);
 		r = amdgpu_bo_reserve(vm->root.bo, false);
 		if (r)
-			return r;
-		if (interval_tree_iter_first(&vm->va, start, last)) {
-			pr_debug("Range [0x%llx 0x%llx] already mapped\n", start, last);
-			amdgpu_bo_unreserve(vm->root.bo);
-			return -EADDRINUSE;
+			return ERR_PTR(r);
+		node = interval_tree_iter_first(&vm->va, start, last);
+		if (node) {
+			pr_debug("range [0x%llx 0x%llx] already TTM mapped\n",
+				 start, last);
+			mapping = container_of((struct rb_node *)node,
+					       struct amdgpu_bo_va_mapping, rb);
+			bo = mapping->bo_va->base.bo;
+			goto out_unreserve;
+		}
+
+		/* Check userptr by searching entire vm->va interval tree */
+		node = interval_tree_iter_first(&vm->va, 0, ~0ULL);
+		while (node) {
+			mapping = container_of((struct rb_node *)node,
+					       struct amdgpu_bo_va_mapping, rb);
+			bo = mapping->bo_va->base.bo;
+
+			if (amdgpu_ttm_tt_affect_userptr(bo->tbo.ttm,
+							 start << PAGE_SHIFT,
+							 last << PAGE_SHIFT)) {
+				pr_debug("[0x%llx 0x%llx] userptr mapped\n",
+					 start, last);
+				goto out_unreserve;
+			}
+			bo = NULL;
+			node = interval_tree_iter_next(node, 0, ~0ULL);
 		}
+
+out_unreserve:
 		amdgpu_bo_unreserve(vm->root.bo);
+		if (bo)
+			break;
 	}
 
-	return 0;
+	return bo;
 }
 
 /**
@@ -2732,6 +2761,7 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
 	struct vm_area_struct *vma;
 	unsigned long end;
 	unsigned long start_unchg = start;
+	struct amdgpu_bo *bo;
 
 	start <<= PAGE_SHIFT;
 	end = start + (size << PAGE_SHIFT);
@@ -2743,7 +2773,12 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
 		start = min(end, vma->vm_end);
 	} while (start < end);
 
-	return svm_range_check_vm(p, start_unchg, (end - 1) >> PAGE_SHIFT);
+	bo = svm_range_check_vm(p, start_unchg, (end - 1) >> PAGE_SHIFT);
+	if (IS_ERR(bo))
+		return PTR_ERR(bo);
+	if (bo)
+		return -EADDRINUSE;
+	return 0;
 }
 
 /**
-- 
2.17.1

