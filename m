Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FA6C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 23:19:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4DD061029
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 23:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D4DD061029
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CD416E883;
	Wed, 13 Oct 2021 23:19:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA48E6E883
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 23:19:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqlLwJhhmb2y5dyVVQQxdGbMvyxEZ2ZVz8D6dzugJ2h2yDz3rkPyT+/4dPzzxGnSiQ1QZ3XPg6Ao2QOVZXBJ6o9vDub/8AXspZcGa+g+MAPe1xDC71UFwENjtYzhoHjxm3fZ71djQisLKK76JJKpvSikzaAObt4agOj+ihk+dXXHHdj4FrxLV2CW65zkK4dzJqZg38F1P5BuztWlzRPjNaLqDgNgntXYqOiB4h0Xz6ER3dh98exGvER8vB76XaCO7aHQzGC1nqZkFnYrOjt+hENYIMXjw2GSSeE608x5wsP4fnJymdvKDbi8DxRqXarPs1lW0oDvxo2O89Q9/5+3fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mriP0yloWkqf/X4k9c2+Rag+TkT4E8U3Hjm4dEKFuf4=;
 b=nlqD1tz7MX4aiPPjYvofxpxSacGlbWSzgLuOB5xfCLxRsplbqO0hoONT0S6IjXnktwZk1kyVehxfMpg218erEDARCXfM4/GGSyQFIwTOiBWoxIKCoPnCrPjyV4Jm6n2xdpTdBrIQKqMpSYxMAiQMa+5cl98bC1JnvKBvW4MeaJ7Gz4uQTcItd5IiTvxQOKrsnu/dkc+Ga1dE3QG6M8jgyrQp/ha+VJ0tOInpw9EQ7pfHuKmNJfi9T8keBG90WrsSmMs5eyPN7ho2/y8Hitsncf48wwDtrW05L1UoA2AjOqkN+tPaJntAPNRyc3PvVAUXF9pY1dHAhTBtFFwvefZWVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mriP0yloWkqf/X4k9c2+Rag+TkT4E8U3Hjm4dEKFuf4=;
 b=BhwMsvebXfdDDEoyn1ltNaYPBVPwZO9xLm3sasqtzfPSMVXBKMrdcFV+0DGpLafFGhHjBo40rj+5mpL4Y0PnIafIjIHC1CIZI77Ob6K+o88COUYsqBrehkoraq3KqPMcKmVGyUjaEq5Ym8lMQ5uUYNzG69PtmC/MoE4Cigev/7k=
Received: from MWHPR1701CA0017.namprd17.prod.outlook.com
 (2603:10b6:301:14::27) by MW2PR12MB2586.namprd12.prod.outlook.com
 (2603:10b6:907:11::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 13 Oct
 2021 23:18:56 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::76) by MWHPR1701CA0017.outlook.office365.com
 (2603:10b6:301:14::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Wed, 13 Oct 2021 23:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 23:18:55 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 13 Oct
 2021 18:18:54 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v4] drm/amdkfd: unregistered svm range not overlap with TTM
 range
Date: Wed, 13 Oct 2021 19:18:41 -0400
Message-ID: <20211013231841.4419-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45b25834-2910-407c-ae38-08d98e9fd417
X-MS-TrafficTypeDiagnostic: MW2PR12MB2586:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2586909C640AA949F8BB7A3EE6B79@MW2PR12MB2586.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MRK1SyzJ8y4mOTDboCgZzv2S+O7MCWILHqJ4dsK6GIMNcXg8CumYHhH4MiOimvBX66QgGMVBN3w1AsVZdmMy4Pn7qpKMPibkzZIe73zMTIOaJVKexUgi03dXdJcermvJ6MJxZkokQ49y2mJh/JJf0ODKkhqKftle5zA6tXzn8qJVn4dKfvgRRVV4mJ2AGv1VN2bfpi9s+WAfP/1e9NzfkHq6w+xGoEqY1GwFz8o+tOH4TAHjpMz5Ng4R+vtA5UC4NcWl1FzuDOrnlcqpnEKeQFRgvwLiaP8cCjnDn5fIWJ84GxXTTqM8cbqLRdOVpkbhkCfSJtaFTY3Bv43QUpjZ1ljBDeFSCVm2kTGyDe1k/z6/81PZULEk2xmhD44g0Fafa+ZTHhNlKmRjGsIJMfDP+CnimN6VBHeGXfmYUNLguURqyMS4KdEmwXFgRduJDUnd4Gjbb56LXxSjfozzU2h/4O4VEQP7IXrXqcFIs+p8DE0LQf9tPD53PuEv+VlDZvOu3qwJMP+MCWAq3HMzC1H0B/X6LLoIHKYYSTUyOq0TXhIAjrclinwy2dJ/uC7PalVO1lWHQBJrgWTEq46e/UpSHn1l1wmOwDSZdqGeFAE+d7p4BD0LHuXhN55+q3QRZHCnhVrSn2/Bx0Q+GeBcTuXGyY6jiuiN4yMphtFqZVOcrk1mhSK7f/LsRArsLFtpEqnXKo4HgueUowV4sVedO6BHcWPJI3egv0pW7TjlfZv/kZY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(82310400003)(2906002)(36860700001)(47076005)(26005)(356005)(186003)(16526019)(316002)(81166007)(1076003)(5660300002)(336012)(508600001)(426003)(70586007)(7696005)(70206006)(36756003)(6916009)(2616005)(86362001)(4326008)(6666004)(83380400001)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 23:18:55.6303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b25834-2910-407c-ae38-08d98e9fd417
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2586
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
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 95 +++++++++++++++++++++++--
 3 files changed, 94 insertions(+), 7 deletions(-)

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
index 49c92713c2ad..b691c8495d66 100644
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
@@ -2366,10 +2420,26 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 	struct svm_range *prange = NULL;
 	unsigned long start, last;
 	uint32_t gpuid, gpuidx;
+	uint64_t bo_s = 0;
+	uint64_t bo_l = 0;
+	int r;
 
 	if (svm_range_get_range_boundaries(p, addr, &start, &last))
 		return NULL;
 
+	r = svm_range_check_vm(p, start, last, &bo_s, &bo_l);
+	if (r != -EADDRINUSE)
+		r = svm_range_check_vm_userptr(p, start, last, &bo_s, &bo_l);
+
+	if (r == -EADDRINUSE) {
+		if (addr >= bo_s && addr <= bo_l)
+			return NULL;
+
+		/* Create one page svm range if 2MB range overlapping */
+		start = addr;
+		last = addr;
+	}
+
 	prange = svm_range_new(&p->svms, start, last);
 	if (!prange) {
 		pr_debug("Failed to create prange in address [0x%llx]\n", addr);
@@ -2672,6 +2742,8 @@ int svm_range_list_init(struct kfd_process *p)
  * @p: current kfd_process
  * @start: range start address, in pages
  * @last: range last address, in pages
+ * @bo_s: mapping start address in pages if address range already mapped
+ * @bo_l: mapping last address in pages if address range already mapped
  *
  * The purpose is to avoid virtual address ranges already allocated by
  * kfd_ioctl_alloc_memory_of_gpu ioctl.
@@ -2686,8 +2758,11 @@ int svm_range_list_init(struct kfd_process *p)
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
 
@@ -2701,8 +2776,17 @@ svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last)
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
@@ -2743,7 +2827,8 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
 		start = min(end, vma->vm_end);
 	} while (start < end);
 
-	return svm_range_check_vm(p, start_unchg, (end - 1) >> PAGE_SHIFT);
+	return svm_range_check_vm(p, start_unchg, (end - 1) >> PAGE_SHIFT, NULL,
+				  NULL);
 }
 
 /**
-- 
2.17.1

