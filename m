Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B11C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 22:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7275460F3A
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 22:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7275460F3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1061489BF8;
	Wed, 13 Oct 2021 22:05:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DEFC89BF8
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 22:05:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDq4tV/UuQBRTPdaSPeTesIifVX67H0JX0eKe7+hhc35EyeULp7JL0187nISFBhhzreDHZS4gJ0cGA0BuCbidsaNJWGpA3stxWMcxQp9ldY2t0xGLm/3pHovv0WCs5IkjgeetpcGhdb/iQ7cwxyEIS+LS+Ubd7WUXIkahi4pWlwaAynPH9NwtO96k/VYw/yLP2np0NBEnsHpkkkmzKW3I1v+uRx+3We9Dm4yzSWRqShGwUIAmQ01AbpE8QGlv5YBAgs+b84/J6yIn6kksAggT8wZbdUlbRs8ICFAZpWP28Zvmn91Npsd2WJltJhc22yZeJ9ixXKHP9fzc7CW8kyBtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMIc8SLdG44KpeHLHn1ozmn7dF6uus8EB1A4V+E9Zsg=;
 b=K4LmBJXvLdbNs3JDtjSTfMO6RGg4dffAAvw7QEy+HRaGkQ8I5L7p54IqxYaJg6KtyAX+gFSHd68EeJniner4nULLCsLVYiATrPV7mTWEoaLNk8PZ7k27b7omybacGNxqCY2mTEjRdUUQRtHO8PFKhcj60HFvia/G6VKJTzkSRJ2Ja0vHp63jOT3zIrGMF1NLWvrTUUKmH1R1tNQb/lES0Zj0XY+W5cN+oMHszmm75Jf6Lwr/G7Bt2raPCf1G8ZD/9byPhgP1QPuRw+DnGEEDLIwI1PYEnWirnHgpQzeMGrZZt7HpSQVPFw6+69zt4/eaeiWfzKnpVKkATI7w0UGSfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMIc8SLdG44KpeHLHn1ozmn7dF6uus8EB1A4V+E9Zsg=;
 b=k3Ma9PBY6laQAZD4Fr13Hr2eX41IscrcXbPTxsrzEx3qz1rBfsmOZeAIdsjU9Oh1nBFxfSx64SFiCyPlRZqaBxhmhsbEFV1h+y1R2izmbzrDOiR73L81Z6r1L4TMGLlNnoOCdlSMmgYoorWu1oTK/xIjoTGfsYJAVhEAC60uACI=
Received: from DM5PR20CA0007.namprd20.prod.outlook.com (2603:10b6:3:93::17) by
 DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Wed, 13 Oct 2021 22:05:40 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::51) by DM5PR20CA0007.outlook.office365.com
 (2603:10b6:3:93::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Wed, 13 Oct 2021 22:05:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 22:05:40 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 13 Oct
 2021 17:05:39 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3] drm/amdkfd: unregistered svm range not overlap with TTM
 range
Date: Wed, 13 Oct 2021 18:05:26 -0400
Message-ID: <20211013220526.7505-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fb1695e-559a-4011-2b72-08d98e959812
X-MS-TrafficTypeDiagnostic: DM6PR12MB4332:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4332EF268786570B7BAD760DE6B79@DM6PR12MB4332.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CeRt5k0aBuKemTO7/vHY8ja6u5IwRVHU/o/2LPKWY1uJsgsY7VgsBbJOUvRUNU7rhCSAEU5Vv7kkep3K3NE0E7xdNBFYV5foMTcMSfTh6geZ3zHDGzjsiHRst2Ce6i6yDaNU9hc+K1TQPOGzFxG0oa5xZp7359W+yU+dsTXxK2htpvQsaeKt7p76tpzrqTjg95NTXO6RG4J8EF2ea0WB7uNl/H0SyqdnK0iMbEGnt/QsZ3bWn7hH7XJPZaPtVPWX5xlfvdSxQsgJMepgce06K2rQv6DLVqLQ1yrAXeuguMNUh9vhkdw820gLHcdCS9ru3XH3vE5/V06+GfCF+d24g+TeDjT9G3TlV4bDBv+tt60uglB5JUC9frcx9uubszq0OcFfc6JGe3KDbxfJMDtOaVZcDLu9vgFqQKOr9SKLYVPRbShCbwpgDxd84g0MZJJowZsl8C1PjkTUTCN/l7HIPzq36Y+DkLaXz6E9731iX+tOPNeguppMc966sHkBszFtOaoPMgWPa1gd0HVKM3GzvjB5uhMlY/jDN6y2NZx1Ra/aNJC41h8ZMW352PK/h5um7NhgXoA7lLKCtz6cxUd5xL2Fr6sB6+1OAkpy6HT+WSi5PDnbEE+lkOydlJwPrR2coU3xzle6ifsw66JIE+cRU7cAa4tkgE+VZLy/TYHoekmwpN7G4xZ8cKHrLMlhPZ1bMuAHYncf3VkzDSBs8dm4WhQrYNKWmFcpUcixcLIIXzM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(4326008)(426003)(26005)(82310400003)(6666004)(36756003)(2616005)(5660300002)(81166007)(356005)(336012)(1076003)(508600001)(83380400001)(7696005)(186003)(316002)(86362001)(8936002)(16526019)(36860700001)(6916009)(8676002)(70586007)(47076005)(2906002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 22:05:40.1325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb1695e-559a-4011-2b72-08d98e959812
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332
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

When creating unregistered new svm range to recover retry fault, avoid
new svm range to overlap with ranges or userptr ranges managed by TTM,
otherwise svm migration will trigger TTM or userptr eviction, to evict
user queues unexpectedly.

Change helper amdgpu_ttm_tt_affect_userptr to return userptr which is
inside the range. Add helper svm_range_check_vm_userptr to scan all
userptr of the vm, and return overlap userptr bo start, last.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 93 +++++++++++++++++++++++--
 3 files changed, 92 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index bd5dda8066fa..d784f8d3a834 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1220,7 +1220,7 @@ struct mm_struct *amdgpu_ttm_tt_get_usermm(struct ttm_tt *ttm)
  *
  */
 bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
-				  unsigned long end)
+				  unsigned long end, unsigned long *userptr)
 {
 	struct amdgpu_ttm_tt *gtt = (void *)ttm;
 	unsigned long size;
@@ -1235,6 +1235,8 @@ bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
 	if (gtt->userptr > end || gtt->userptr + size <= start)
 		return false;
 
+	if (userptr)
+		*userptr = gtt->userptr;
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index ba5c864b8de1..91a087f9dc7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -182,7 +182,7 @@ int amdgpu_ttm_tt_set_userptr(struct ttm_buffer_object *bo,
 bool amdgpu_ttm_tt_has_userptr(struct ttm_tt *ttm);
 struct mm_struct *amdgpu_ttm_tt_get_usermm(struct ttm_tt *ttm);
 bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
-				  unsigned long end);
+				  unsigned long end, unsigned long *userptr);
 bool amdgpu_ttm_tt_userptr_invalidated(struct ttm_tt *ttm,
 				       int *last_invalidated);
 bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 49c92713c2ad..95d018fe2287 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -50,7 +50,9 @@ static bool
 svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
 				    const struct mmu_notifier_range *range,
 				    unsigned long cur_seq);
-
+static int
+svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last,
+		   uint64_t *bo_s, uint64_t *bo_l);
 static const struct mmu_interval_notifier_ops svm_range_mn_ops = {
 	.invalidate = svm_range_cpu_invalidate_pagetables,
 };
@@ -2308,6 +2310,7 @@ svm_range_best_restore_location(struct svm_range *prange,
 
 	return -1;
 }
+
 static int
 svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 				unsigned long *start, unsigned long *last)
@@ -2355,8 +2358,59 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 		  vma->vm_end >> PAGE_SHIFT, *last);
 
 	return 0;
+}
+
+static int
+svm_range_check_vm_userptr(struct kfd_process *p, uint64_t start, uint64_t last,
+			   uint64_t *bo_s, uint64_t *bo_l)
+{
+	struct amdgpu_bo_va_mapping *mapping;
+	struct interval_tree_node *node;
+	struct amdgpu_bo *bo = NULL;
+	unsigned long userptr;
+	uint32_t i;
+	int r;
 
+	for (i = 0; i < p->n_pdds; i++) {
+		struct amdgpu_vm *vm;
+
+		if (!p->pdds[i]->drm_priv)
+			continue;
+
+		vm = drm_priv_to_vm(p->pdds[i]->drm_priv);
+		r = amdgpu_bo_reserve(vm->root.bo, false);
+		if (r)
+			return r;
+
+		/* Check userptr by searching entire vm->va interval tree */
+		node = interval_tree_iter_first(&vm->va, 0, ~0ULL);
+		while (node) {
+			mapping = container_of((struct rb_node *)node,
+					       struct amdgpu_bo_va_mapping, rb);
+			bo = mapping->bo_va->base.bo;
+
+			if (!amdgpu_ttm_tt_affect_userptr(bo->tbo.ttm,
+							 start << PAGE_SHIFT,
+							 last << PAGE_SHIFT,
+							 &userptr)) {
+				node = interval_tree_iter_next(node, 0, ~0ULL);
+				continue;
+			}
+
+			pr_debug("[0x%llx 0x%llx] already userptr mapped\n",
+				 start, last);
+			if (bo_s && bo_l) {
+				*bo_s = userptr >> PAGE_SHIFT;
+				*bo_l = *bo_s + bo->tbo.ttm->num_pages - 1;
+			}
+			amdgpu_bo_unreserve(vm->root.bo);
+			return -EADDRINUSE;
+		}
+		amdgpu_bo_unreserve(vm->root.bo);
+	}
+	return 0;
 }
+
 static struct
 svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 						struct kfd_process *p,
@@ -2366,10 +2420,24 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 	struct svm_range *prange = NULL;
 	unsigned long start, last;
 	uint32_t gpuid, gpuidx;
+	uint64_t bo_s = 0;
+	uint64_t bo_l = 0;
 
 	if (svm_range_get_range_boundaries(p, addr, &start, &last))
 		return NULL;
 
+	if (svm_range_check_vm(p, start, last, &bo_s, &bo_l) != -EADDRINUSE)
+		svm_range_check_vm_userptr(p, start, last, &bo_s, &bo_l);
+
+	if (addr >= bo_s && addr <= bo_l)
+		return NULL;
+
+	/* Create one page svm range if 2MB range overlaps with TTM range */
+	if (addr < bo_s || addr > bo_l) {
+		start = addr;
+		last = addr;
+	}
+
 	prange = svm_range_new(&p->svms, start, last);
 	if (!prange) {
 		pr_debug("Failed to create prange in address [0x%llx]\n", addr);
@@ -2672,6 +2740,8 @@ int svm_range_list_init(struct kfd_process *p)
  * @p: current kfd_process
  * @start: range start address, in pages
  * @last: range last address, in pages
+ * @bo_s: mapping start address in pages if address range already mapped
+ * @bo_l: mapping last address in pages if address range already mapped
  *
  * The purpose is to avoid virtual address ranges already allocated by
  * kfd_ioctl_alloc_memory_of_gpu ioctl.
@@ -2686,8 +2756,11 @@ int svm_range_list_init(struct kfd_process *p)
  * a signal. Release all buffer reservations and return to user-space.
  */
 static int
-svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last)
+svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last,
+		   uint64_t *bo_s, uint64_t *bo_l)
 {
+	struct amdgpu_bo_va_mapping *mapping;
+	struct interval_tree_node *node;
 	uint32_t i;
 	int r;
 
@@ -2701,8 +2774,17 @@ svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last)
 		r = amdgpu_bo_reserve(vm->root.bo, false);
 		if (r)
 			return r;
-		if (interval_tree_iter_first(&vm->va, start, last)) {
-			pr_debug("Range [0x%llx 0x%llx] already mapped\n", start, last);
+
+		node = interval_tree_iter_first(&vm->va, start, last);
+		if (node) {
+			pr_debug("range [0x%llx 0x%llx] already TTM mapped\n",
+				 start, last);
+			mapping = container_of((struct rb_node *)node,
+					       struct amdgpu_bo_va_mapping, rb);
+			if (bo_s && bo_l) {
+				*bo_s = mapping->start;
+				*bo_l = mapping->last;
+			}
 			amdgpu_bo_unreserve(vm->root.bo);
 			return -EADDRINUSE;
 		}
@@ -2743,7 +2825,8 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
 		start = min(end, vma->vm_end);
 	} while (start < end);
 
-	return svm_range_check_vm(p, start_unchg, (end - 1) >> PAGE_SHIFT);
+	return svm_range_check_vm(p, start_unchg, (end - 1) >> PAGE_SHIFT, NULL,
+				  NULL);
 }
 
 /**
-- 
2.17.1

