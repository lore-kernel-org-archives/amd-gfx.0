Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB69C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 13:55:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7EA860E94
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 13:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D7EA860E94
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72C0F6E998;
	Tue, 12 Oct 2021 13:55:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD0766E995
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 13:55:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Us2VAz9tR+TkxtBCNP9NK/sxhpxChgo53xEQQeidWtRijTZSug0xZYP9tgMNXqrXbzoZZYShWxiHQ0pgTaLsa/JG5FzxzG0s9v7Pr6+dldp8iaBLASP7XXoFoEkIveeXRSCdo0ZA1BV7oWlwWA5oFeELDD9PkuIzw8ruJGJEXCAHy+6D6GHqE8bwI0HH2hZsW5mmdp9okXLGa5t7HNGu362np3cyuH1RlW9hIecgE7uhlWjmD5yw3DFdaY8t4r/GgVUBCzf01mz9QAjwvEeEj7Y7l4ZPDwqcSoedPsFN0L5+D75wlKDsQQZhZ0i7wofoMkQfRtSYZHiF6sZxq7I5yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phYIpWGJj+GFX2d8zI9+vbUjy8L6/cIUIBU5PikbaL8=;
 b=KPOjDJo/eW9ffWIhW7DVF87FGefWgr0x4p4zpHqBcqIDorbKGRnarEy7YZU33X8rHYziYiQQLSM9BBU7VABaeWV+9R1FyRHcbJhG841Q+fsnxkabY416Vfxx3TygPRo2QSmRNOKz3FdjJfzHl49ulOvfPKHPdqWqGIESSBxBw7Eqp3Lij98JVUB9yfiGfyrHaOi8kvuvWPhwOTY0yv4QD30cFTgDsppP5FM34O9oRxjaNUUOzFLlRxvsrs6bJJeqiLrgUDU1ZejLVOE2aWZbSOSjhKB1W07WQBh+bA+uiee+9h9UQfXu5ydbC0pOpQRW4SoiUoZ9paecmWvQ88NLZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phYIpWGJj+GFX2d8zI9+vbUjy8L6/cIUIBU5PikbaL8=;
 b=xz9+wMAdsBTYGLtUwBgLbYNXQWpQ0UkhkSuAS8QnAVe5ZiFehEAlaHN2xrOk2AKsut7kGrNHHmHa+BVLyMBRZtV2PHmeqXc2wclncZLyVAJc1ByM3qR8Yx6eGXmLM+BI7U7ZaafR9AmJCOS+7C8SEQN5pCBmU2axSeh/khE2zpE=
Received: from BN9PR03CA0343.namprd03.prod.outlook.com (2603:10b6:408:f6::18)
 by MN2PR12MB3790.namprd12.prod.outlook.com (2603:10b6:208:164::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Tue, 12 Oct
 2021 13:55:46 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::8c) by BN9PR03CA0343.outlook.office365.com
 (2603:10b6:408:f6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend
 Transport; Tue, 12 Oct 2021 13:55:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 13:55:45 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 08:55:44 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 3/3] drm/amdkfd: create unregister svm range not overlap
 with TTM range
Date: Tue, 12 Oct 2021 09:55:27 -0400
Message-ID: <20211012135527.28083-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211012135527.28083-1-Philip.Yang@amd.com>
References: <20211012135527.28083-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e5a8fc4-0d46-4f4c-a93b-08d98d87fd2f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3790:
X-Microsoft-Antispam-PRVS: <MN2PR12MB379075BE564D175C4E364962E6B69@MN2PR12MB3790.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FAOMWfEL9hVKMpdJHhp2vviLcNKfZy1P/yMfmo/UInJvmQ65eW+VEt6EKW6YJUaRSvZbuXzIuyXASuU9RaJoAFgPqN3nIrqVsp5+xSFQs4JyocrmqmXrBabVn4v1jCeozoYO9VA/IcbhdLTmqFuK28sczFjZohfZHEObGLmrP59da3gCLTHkyikzO63TC+wxUTyFkdvWbkDTyW4nPyWDaOy/NUMyVdo9a+/b0sy6jEr/sFfQAnlIBnWOGMNV9h59w4Lray6IW+vG4KEtdPhPdc+FDkc5+ZJeJfd56STyaeZRi4N1JrzYTwcdjS9dua6f2u8nYbfI5un9EFr8WaFCMAHt/Pg0Izr5gIISXHVU2pwNe8L+natltNtRPEwZSKN+s4nCb3nBWhGLrf7ha/tATThKTknCgkqNxluIKYH6kJcP89XvvTD0aXRmKMizzEaSummJUOA39tvB47FvAHbo76XL9S6x042WDSLupb2BvwwD3RF/rR2CFxhaYCRCIabcgIo6qeaI7du8wx6uhQxblEmhysOWDAYrdbOcmIYLeaUHEV6W0qPVN/cJtBNgmTMRYOqA+sPverCMZ2lLLNnesWjIIHG+XpmWN3jwpNken2wNi1B4hG37sXx8dGj37R5W4gY6EUkOCvjXlrLzWs06kxFufG1sMgS0/jx7ljYPzgwfLW0jtdzWop/5jssQi8Mtjj8hU9EZ7EDWuPTEwo0El6aGueHflsdkz6GenSPyYqk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(186003)(2616005)(70206006)(70586007)(82310400003)(26005)(316002)(8936002)(8676002)(36756003)(336012)(5660300002)(426003)(356005)(81166007)(16526019)(1076003)(83380400001)(6916009)(2906002)(7696005)(6666004)(47076005)(86362001)(36860700001)(4326008)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 13:55:45.7072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5a8fc4-0d46-4f4c-a93b-08d98d87fd2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3790
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

When creating new svm range to recover retry fault, avoid svm range
to overlap with ranges or userptr ranges managed by TTM, otherwise
svm migration will trigger TTM or userptr eviction, to evict user queues
unexpectedly.

Change helper amdgpu_ttm_tt_affect_userptr to return userptr which is
inside the range. Add helper svm_range_check_vm_userptr to scan all
userptr of the vm, and return overlap userptr bo start, last.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 92 +++++++++++++++++++++++--
 3 files changed, 91 insertions(+), 7 deletions(-)

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
index 49c92713c2ad..f987c73b535e 100644
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
+
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
@@ -2366,10 +2420,23 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
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
+	if (addr < bo_s)
+		last = bo_s - 1;
+	if (addr > bo_l)
+		start = bo_l + 1;
+
 	prange = svm_range_new(&p->svms, start, last);
 	if (!prange) {
 		pr_debug("Failed to create prange in address [0x%llx]\n", addr);
@@ -2672,6 +2739,8 @@ int svm_range_list_init(struct kfd_process *p)
  * @p: current kfd_process
  * @start: range start address, in pages
  * @last: range last address, in pages
+ * @bo_s: mapping start address in pages if address range already mapped
+ * @bo_l: mapping last address in pages if address range already mapped
  *
  * The purpose is to avoid virtual address ranges already allocated by
  * kfd_ioctl_alloc_memory_of_gpu ioctl.
@@ -2686,8 +2755,11 @@ int svm_range_list_init(struct kfd_process *p)
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
 
@@ -2701,8 +2773,17 @@ svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last)
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
@@ -2743,7 +2824,8 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
 		start = min(end, vma->vm_end);
 	} while (start < end);
 
-	return svm_range_check_vm(p, start_unchg, (end - 1) >> PAGE_SHIFT);
+	return svm_range_check_vm(p, start_unchg, (end - 1) >> PAGE_SHIFT, NULL,
+				  NULL);
 }
 
 /**
-- 
2.17.1

