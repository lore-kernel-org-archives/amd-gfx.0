Return-Path: <SRS0=biE/=M3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94551C432BE
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 02:15:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5806760F58
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 02:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5806760F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 213546E209;
	Wed,  4 Aug 2021 02:15:47 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2083.outbound.protection.outlook.com [40.107.102.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84CBC6E209
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Aug 2021 02:15:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOM4Tg0Zvq5upTmxrxn+gtSqXAT+z8enI8o1aB73BmVc4/LJ4z+P5rInaeBUTZPTImYXEX9x+2yQcKdZAl88h8tk6yugdkQymUNJdN2OVfpj1IJHpbQv3D5fhi9UADGyWyipBCcUUQGjk2Ji+p40cGFlU+XOWxxg+P1+u54Xosg9noR1Wccoi2DCRi2WNbNbd0KEI/hjKV9a5RHOB9v63c8mab35B1KJlar58FQH+evz2zTzDWWKryey+VT3hlBtNRaVzxkrNKxqgZHjeVSRoVT7KmO6T+m+AhkBsvIAyIv6oPtRpBiubF8Hky4yeHWg6d0VF+PuZ6mNXvO8S8POcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7Bkf+vKLadKAbBCVoqUXW6Dy5RSFdXxTJ0ncAxHenM=;
 b=T6X6JR2ZRSFb/8kbMxf4mArzVCg15OPSCdZpvld5MJL9f1WDcD4WGJsvfD/CK4ZZXYE8hxCdttiSK1o2JsSTIvfeDq5JCn77xR12CXCHs8ENmiYmgfPu9C4eLI5pTV78x05Ms050srn1seN9JVNWwlD8wXx3ndGFjZgEHYgUZhLjG369re/cMr18sufi//Yl5BrZj5BKH0GBWBQ/CFMy6dUej9CEwzZnXdRmkPOdRTMRiwjPBpPNchmZv74EHTUyiAz2SsQTZLb+U8smPR19srNwPO3IfkoDFgXfakH+iQj7D9BPu3b3tVEJhRLieswOv26dXWTsdcnuo+6jeABLaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7Bkf+vKLadKAbBCVoqUXW6Dy5RSFdXxTJ0ncAxHenM=;
 b=xixK33pDx3cMU0GAqi497HpK6/BD5dQMnKBQ+1oE+jFS9rxMU/siOaI42+ehze+YARgvzkYqui2CorZUAm6iLwqzwtpKaEQrZOo3nUGUmFKWYHROMct1v0lupv+EmouzK17lD6CzorjOlQWXeutG7pIl7BsPYHpR8JdFvKbgB0k=
Received: from DM5PR22CA0012.namprd22.prod.outlook.com (2603:10b6:3:101::22)
 by MN2PR12MB3615.namprd12.prod.outlook.com (2603:10b6:208:c9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Wed, 4 Aug
 2021 02:15:40 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::df) by DM5PR22CA0012.outlook.office365.com
 (2603:10b6:3:101::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Wed, 4 Aug 2021 02:15:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Wed, 4 Aug 2021 02:15:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 3 Aug
 2021 21:15:38 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12 via Frontend
 Transport; Tue, 3 Aug 2021 21:15:37 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David M Nieto <david.nieto@amd.com>, Peng Ju Zhou <PengJu.Zhou@amd.com>
Subject: [PATCH] drm/amdgpu: add done BO list
Date: Wed, 4 Aug 2021 10:15:27 +0800
Message-ID: <20210804021528.25421-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56d94ad8-46e5-4b06-88ed-08d956edc125
X-MS-TrafficTypeDiagnostic: MN2PR12MB3615:
X-Microsoft-Antispam-PRVS: <MN2PR12MB36150F7591DCBD3312AB2CA6F8F19@MN2PR12MB3615.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zq+89ZCdXEDY8mFFbexaD2mGHfu4lM/BPlXZHiwgEsCNMPAfwdkk5M6254js+0/JBhmkMt1s7zO09EuVE0Lcz3zh2gZEc2Pnhr3bluvQo1A3HRWRuylMoHztw374hVjlIMvZbZsCbOeToQ2t7/52rV29dqwftN6BX88JUgF89lTSxoIJTXwDqJw+YQlouakGJROEVHdQmSf0ddLxr3IWB/K063EaBGIJl2RUvyQt+tLDs0eF3SY8r0LfASX0s7oqJLsONB9MBH3su9YBHDSN32yLb8TktXHWR3VaIeucfWNpT7nr4rXPOOiAWq2QykENw6xAba39Wn++hubLBVHeABLp0pgTZI0zjwDt5xqWK8dR/TFrl5bXPo5jbc8ZTPTa3ql+L0TqmJuXesyu/rodHVS9w7uvllCDF+R7MCsEBKeghOF3zn2nAnhF1K1kn+GnxJWgj3ARtt4AKzmFvDtjbweQfSxVFpXnFfoA0PxT6iCEVgWe2ypMP/sq5T1NWJypQJYYcXB+y7yaqgfvA3LJCL2Os15puGQW/emKFvcOyGFNYmx5Ik/czlJd/B3xVlKI7fZ06N4gm2J/iquA0C/iWGb1N3n1YE6kd/feTRDV4oAPDBcUv5DNSJvn0vpzyv309wt6zs7PO1LVuLxN8HdZJSMDWWwlOWTnfdtv142CuS03hQJrw5PY6D0N9q7pdFhuZkkOky8RLHKbkumnUrNmXoNi8SaOQYzY+bw7cJ5B3Zc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(46966006)(36840700001)(30864003)(6666004)(81166007)(2616005)(86362001)(7696005)(54906003)(82310400003)(36756003)(47076005)(82740400003)(83380400001)(6916009)(26005)(2906002)(426003)(356005)(186003)(316002)(336012)(478600001)(70586007)(1076003)(70206006)(5660300002)(4326008)(36860700001)(8936002)(8676002)(36900700001)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 02:15:39.6356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d94ad8-46e5-4b06-88ed-08d956edc125
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3615
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

From: David M Nieto <david.nieto@amd.com>

backport of "add a list in VM for BOs in the done state"

Signed-off-by: David M Nieto <david.nieto@amd.com>
Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1196 +++++++++++-------------
 1 file changed, 561 insertions(+), 635 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 2a88ed5d983b..ecf7f2039de0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -25,22 +25,16 @@
  *          Alex Deucher
  *          Jerome Glisse
  */
-
 #include <linux/dma-fence-array.h>
 #include <linux/interval_tree_generic.h>
 #include <linux/idr.h>
-#include <linux/dma-buf.h>
 
 #include <drm/amdgpu_drm.h>
-#include <drm/drm_drv.h>
 #include "amdgpu.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_gmc.h"
 #include "amdgpu_xgmi.h"
-#include "amdgpu_dma_buf.h"
-#include "amdgpu_res_cursor.h"
-#include "kfd_svm.h"
 
 /**
  * DOC: GPUVM
@@ -89,46 +83,6 @@ struct amdgpu_prt_cb {
 };
 
 /**
- * amdgpu_vm_set_pasid - manage pasid and vm ptr mapping
- *
- * @adev: amdgpu_device pointer
- * @vm: amdgpu_vm pointer
- * @pasid: the pasid the VM is using on this GPU
- *
- * Set the pasid this VM is using on this GPU, can also be used to remove the
- * pasid by passing in zero.
- *
- */
-int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			u32 pasid)
-{
-	int r;
-
-	if (vm->pasid == pasid)
-		return 0;
-
-	if (vm->pasid) {
-		r = xa_err(xa_erase_irq(&adev->vm_manager.pasids, vm->pasid));
-		if (r < 0)
-			return r;
-
-		vm->pasid = 0;
-	}
-
-	if (pasid) {
-		r = xa_err(xa_store_irq(&adev->vm_manager.pasids, pasid, vm,
-					GFP_KERNEL));
-		if (r < 0)
-			return r;
-
-		vm->pasid = pasid;
-	}
-
-
-	return 0;
-}
-
-/*
  * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
  * happens while holding this lock anywhere to prevent deadlocks when
  * an MMU notifier runs in reclaim-FS context.
@@ -136,13 +90,13 @@ int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
 {
 	mutex_lock(&vm->eviction_lock);
-	vm->saved_flags = memalloc_noreclaim_save();
+	vm->saved_flags = memalloc_nofs_save();
 }
 
 static inline int amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
 {
 	if (mutex_trylock(&vm->eviction_lock)) {
-		vm->saved_flags = memalloc_noreclaim_save();
+		vm->saved_flags = memalloc_nofs_save();
 		return 1;
 	}
 	return 0;
@@ -150,7 +104,7 @@ static inline int amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
 
 static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
 {
-	memalloc_noreclaim_restore(vm->saved_flags);
+	memalloc_nofs_restore(vm->saved_flags);
 	mutex_unlock(&vm->eviction_lock);
 }
 
@@ -372,7 +326,7 @@ static void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 	base->next = bo->vm_bo;
 	bo->vm_bo = base;
 
-	if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
+	if (amdkcl_ttm_resvp(&bo->tbo) != amdkcl_ttm_resvp(&vm->root.base.bo->tbo))
 		return;
 
 	vm->bulk_moveable = false;
@@ -382,7 +336,7 @@ static void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 		amdgpu_vm_bo_idle(base);
 
 	if (bo->preferred_domains &
-	    amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type))
+	    amdgpu_mem_type_to_domain(bo->tbo.mem.mem_type))
 		return;
 
 	/*
@@ -401,14 +355,14 @@ static void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
  * Helper to get the parent entry for the child page table. NULL if we are at
  * the root page directory.
  */
-static struct amdgpu_vm_bo_base *amdgpu_vm_pt_parent(struct amdgpu_vm_bo_base *pt)
+static struct amdgpu_vm_pt *amdgpu_vm_pt_parent(struct amdgpu_vm_pt *pt)
 {
-	struct amdgpu_bo *parent = pt->bo->parent;
+	struct amdgpu_bo *parent = pt->base.bo->parent;
 
 	if (!parent)
 		return NULL;
 
-	return parent->vm_bo;
+	return container_of(parent->vm_bo, struct amdgpu_vm_pt, base);
 }
 
 /*
@@ -416,8 +370,8 @@ static struct amdgpu_vm_bo_base *amdgpu_vm_pt_parent(struct amdgpu_vm_bo_base *p
  */
 struct amdgpu_vm_pt_cursor {
 	uint64_t pfn;
-	struct amdgpu_vm_bo_base *parent;
-	struct amdgpu_vm_bo_base *entry;
+	struct amdgpu_vm_pt *parent;
+	struct amdgpu_vm_pt *entry;
 	unsigned level;
 };
 
@@ -456,17 +410,17 @@ static bool amdgpu_vm_pt_descendant(struct amdgpu_device *adev,
 {
 	unsigned mask, shift, idx;
 
-	if ((cursor->level == AMDGPU_VM_PTB) || !cursor->entry ||
-	    !cursor->entry->bo)
+	if (!cursor->entry->entries)
 		return false;
 
+	BUG_ON(!cursor->entry->base.bo);
 	mask = amdgpu_vm_entries_mask(adev, cursor->level);
 	shift = amdgpu_vm_level_shift(adev, cursor->level);
 
 	++cursor->level;
 	idx = (cursor->pfn >> shift) & mask;
 	cursor->parent = cursor->entry;
-	cursor->entry = &to_amdgpu_bo_vm(cursor->entry->bo)->entries[idx];
+	cursor->entry = &cursor->entry->entries[idx];
 	return true;
 }
 
@@ -493,7 +447,7 @@ static bool amdgpu_vm_pt_sibling(struct amdgpu_device *adev,
 	shift = amdgpu_vm_level_shift(adev, cursor->level - 1);
 	num_entries = amdgpu_vm_num_entries(adev, cursor->level - 1);
 
-	if (cursor->entry == &to_amdgpu_bo_vm(cursor->parent->bo)->entries[num_entries - 1])
+	if (cursor->entry == &cursor->parent->entries[num_entries - 1])
 		return false;
 
 	cursor->pfn += 1ULL << shift;
@@ -579,7 +533,7 @@ static void amdgpu_vm_pt_first_dfs(struct amdgpu_device *adev,
  * True when the search should continue, false otherwise.
  */
 static bool amdgpu_vm_pt_continue_dfs(struct amdgpu_vm_pt_cursor *start,
-				      struct amdgpu_vm_bo_base *entry)
+				      struct amdgpu_vm_pt *entry)
 {
 	return entry && (!start || entry != start->entry);
 }
@@ -630,7 +584,7 @@ void amdgpu_vm_get_pd_bo(struct amdgpu_vm *vm,
 			 struct amdgpu_bo_list_entry *entry)
 {
 	entry->priority = 0;
-	entry->tv.bo = &vm->root.bo->tbo;
+	entry->tv.bo = &vm->root.base.bo->tbo;
 	/* Two for VM updates, one for TTM and one for the CS job */
 	entry->tv.num_shared = 4;
 	entry->user_pages = NULL;
@@ -653,7 +607,7 @@ void amdgpu_vm_del_from_lru_notify(struct ttm_buffer_object *bo)
 	if (!amdgpu_bo_is_amdgpu_bo(bo))
 		return;
 
-	if (bo->pin_count)
+	if (bo->mem.placement & TTM_PL_FLAG_NO_EVICT)
 		return;
 
 	abo = ttm_to_amdgpu_bo(bo);
@@ -662,7 +616,7 @@ void amdgpu_vm_del_from_lru_notify(struct ttm_buffer_object *bo)
 	for (bo_base = abo->vm_bo; bo_base; bo_base = bo_base->next) {
 		struct amdgpu_vm *vm = bo_base->vm;
 
-		if (abo->tbo.base.resv == vm->root.bo->tbo.base.resv)
+		if (amdkcl_ttm_resvp(&abo->tbo) == amdkcl_ttm_resvp(&vm->root.base.bo->tbo))
 			vm->bulk_moveable = false;
 	}
 
@@ -682,30 +636,27 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 	struct amdgpu_vm_bo_base *bo_base;
 
 	if (vm->bulk_moveable) {
-		spin_lock(&adev->mman.bdev.lru_lock);
+		spin_lock(&ttm_bo_glob.lru_lock);
 		ttm_bo_bulk_move_lru_tail(&vm->lru_bulk_move);
-		spin_unlock(&adev->mman.bdev.lru_lock);
+		spin_unlock(&ttm_bo_glob.lru_lock);
 		return;
 	}
 
 	memset(&vm->lru_bulk_move, 0, sizeof(vm->lru_bulk_move));
 
-	spin_lock(&adev->mman.bdev.lru_lock);
+	spin_lock(&ttm_bo_glob.lru_lock);
 	list_for_each_entry(bo_base, &vm->idle, vm_status) {
 		struct amdgpu_bo *bo = bo_base->bo;
-		struct amdgpu_bo *shadow = amdgpu_bo_shadowed(bo);
 
 		if (!bo->parent)
 			continue;
 
-		ttm_bo_move_to_lru_tail(&bo->tbo, bo->tbo.resource,
-					&vm->lru_bulk_move);
-		if (shadow)
-			ttm_bo_move_to_lru_tail(&shadow->tbo,
-						shadow->tbo.resource,
+		ttm_bo_move_to_lru_tail(&bo->tbo, &vm->lru_bulk_move);
+		if (bo->shadow)
+			ttm_bo_move_to_lru_tail(&bo->shadow->tbo,
 						&vm->lru_bulk_move);
 	}
-	spin_unlock(&adev->mman.bdev.lru_lock);
+	spin_unlock(&ttm_bo_glob.lru_lock);
 
 	vm->bulk_moveable = true;
 }
@@ -734,21 +685,15 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	list_for_each_entry_safe(bo_base, tmp, &vm->evicted, vm_status) {
 		struct amdgpu_bo *bo = bo_base->bo;
-		struct amdgpu_bo *shadow = amdgpu_bo_shadowed(bo);
 
 		r = validate(param, bo);
 		if (r)
 			return r;
-		if (shadow) {
-			r = validate(param, shadow);
-			if (r)
-				return r;
-		}
 
 		if (bo->tbo.type != ttm_bo_type_kernel) {
 			amdgpu_vm_bo_moved(bo_base);
 		} else {
-			vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
+			vm->update_funcs->map_table(bo);
 			amdgpu_vm_bo_relocated(bo_base);
 		}
 	}
@@ -780,8 +725,8 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
  *
  * @adev: amdgpu_device pointer
  * @vm: VM to clear BO from
- * @vmbo: BO to clear
- * @immediate: use an immediate update
+ * @bo: BO to clear
+ * @direct: use a direct update
  *
  * Root PD needs to be reserved when calling this.
  *
@@ -790,14 +735,13 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
  */
 static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 			      struct amdgpu_vm *vm,
-			      struct amdgpu_bo_vm *vmbo,
-			      bool immediate)
+			      struct amdgpu_bo *bo,
+			      bool direct)
 {
 	struct ttm_operation_ctx ctx = { true, false };
 	unsigned level = adev->vm_manager.root_level;
 	struct amdgpu_vm_update_params params;
-	struct amdgpu_bo *ancestor = &vmbo->bo;
-	struct amdgpu_bo *bo = &vmbo->bo;
+	struct amdgpu_bo *ancestor = bo;
 	unsigned entries, ats_entries;
 	uint64_t addr;
 	int r;
@@ -821,11 +765,11 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 		entries -= ats_entries;
 
 	} else {
-		struct amdgpu_vm_bo_base *pt;
+		struct amdgpu_vm_pt *pt;
 
-		pt = ancestor->vm_bo;
+		pt = container_of(ancestor->vm_bo, struct amdgpu_vm_pt, base);
 		ats_entries = amdgpu_vm_num_ats_entries(adev);
-		if ((pt - to_amdgpu_bo_vm(vm->root.bo)->entries) >= ats_entries) {
+		if ((pt - vm->root.entries) >= ats_entries) {
 			ats_entries = 0;
 		} else {
 			ats_entries = entries;
@@ -837,22 +781,21 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
-	if (vmbo->shadow) {
-		struct amdgpu_bo *shadow = vmbo->shadow;
-
-		r = ttm_bo_validate(&shadow->tbo, &shadow->placement, &ctx);
+	if (bo->shadow) {
+		r = ttm_bo_validate(&bo->shadow->tbo, &bo->shadow->placement,
+				    &ctx);
 		if (r)
 			return r;
 	}
 
-	r = vm->update_funcs->map_table(vmbo);
+	r = vm->update_funcs->map_table(bo);
 	if (r)
 		return r;
 
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
-	params.immediate = immediate;
+	params.direct = direct;
 
 	r = vm->update_funcs->prepare(&params, NULL, AMDGPU_SYNC_EXPLICIT);
 	if (r)
@@ -869,7 +812,7 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 			amdgpu_gmc_get_vm_pde(adev, level, &value, &flags);
 		}
 
-		r = vm->update_funcs->update(&params, vmbo, addr, 0, ats_entries,
+		r = vm->update_funcs->update(&params, bo, addr, 0, ats_entries,
 					     value, flags);
 		if (r)
 			return r;
@@ -892,7 +835,7 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 			}
 		}
 
-		r = vm->update_funcs->update(&params, vmbo, addr, 0, entries,
+		r = vm->update_funcs->update(&params, bo, addr, 0, entries,
 					     value, flags);
 		if (r)
 			return r;
@@ -902,85 +845,34 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 }
 
 /**
- * amdgpu_vm_pt_create - create bo for PD/PT
+ * amdgpu_vm_bo_param - fill in parameters for PD/PT allocation
  *
  * @adev: amdgpu_device pointer
  * @vm: requesting vm
  * @level: the page table level
- * @immediate: use a immediate update
- * @vmbo: pointer to the buffer object pointer
+ * @direct: use a direct update
+ * @bp: resulting BO allocation parameters
  */
-static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
-			       struct amdgpu_vm *vm,
-			       int level, bool immediate,
-			       struct amdgpu_bo_vm **vmbo)
+static void amdgpu_vm_bo_param(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			       int level, bool direct,
+			       struct amdgpu_bo_param *bp)
 {
-	struct amdgpu_bo_param bp;
-	struct amdgpu_bo *bo;
-	struct dma_resv *resv;
-	unsigned int num_entries;
-	int r;
-
-	memset(&bp, 0, sizeof(bp));
+	memset(bp, 0, sizeof(*bp));
 
-	bp.size = amdgpu_vm_bo_size(adev, level);
-	bp.byte_align = AMDGPU_GPU_PAGE_SIZE;
-	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
-	bp.domain = amdgpu_bo_get_preferred_pin_domain(adev, bp.domain);
-	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
+	bp->size = amdgpu_vm_bo_size(adev, level);
+	bp->byte_align = AMDGPU_GPU_PAGE_SIZE;
+	bp->domain = AMDGPU_GEM_DOMAIN_VRAM;
+	bp->domain = amdgpu_bo_get_preferred_pin_domain(adev, bp->domain);
+	bp->flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
 		AMDGPU_GEM_CREATE_CPU_GTT_USWC;
-
-	if (level < AMDGPU_VM_PTB)
-		num_entries = amdgpu_vm_num_entries(adev, level);
-	else
-		num_entries = 0;
-
-	bp.bo_ptr_size = struct_size((*vmbo), entries, num_entries);
-
 	if (vm->use_cpu_for_update)
-		bp.flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
-
-	bp.type = ttm_bo_type_kernel;
-	bp.no_wait_gpu = immediate;
-	if (vm->root.bo)
-		bp.resv = vm->root.bo->tbo.base.resv;
-
-	r = amdgpu_bo_create_vm(adev, &bp, vmbo);
-	if (r)
-		return r;
-
-	bo = &(*vmbo)->bo;
-	if (vm->is_compute_context || (adev->flags & AMD_IS_APU)) {
-		(*vmbo)->shadow = NULL;
-		return 0;
-	}
-
-	if (!bp.resv)
-		WARN_ON(dma_resv_lock(bo->tbo.base.resv,
-				      NULL));
-	resv = bp.resv;
-	memset(&bp, 0, sizeof(bp));
-	bp.size = amdgpu_vm_bo_size(adev, level);
-	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
-	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
-	bp.type = ttm_bo_type_kernel;
-	bp.resv = bo->tbo.base.resv;
-	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
-
-	r = amdgpu_bo_create(adev, &bp, &(*vmbo)->shadow);
-
-	if (!resv)
-		dma_resv_unlock(bo->tbo.base.resv);
-
-	if (r) {
-		amdgpu_bo_unref(&bo);
-		return r;
-	}
-
-	(*vmbo)->shadow->parent = amdgpu_bo_ref(bo);
-	amdgpu_bo_add_to_shadow_list(*vmbo);
-
-	return 0;
+		bp->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+	else if (!vm->root.base.bo || vm->root.base.bo->shadow)
+		bp->flags |= AMDGPU_GEM_CREATE_SHADOW;
+	bp->type = ttm_bo_type_kernel;
+	bp->no_wait_gpu = direct;
+	if (vm->root.base.bo)
+		bp->resv = amdkcl_ttm_resvp(&vm->root.base.bo->tbo);
 }
 
 /**
@@ -989,7 +881,7 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
  * @adev: amdgpu_device pointer
  * @vm: VM to allocate page tables for
  * @cursor: Which page table to allocate
- * @immediate: use an immediate update
+ * @direct: use a direct update
  *
  * Make sure a specific page table or directory is allocated.
  *
@@ -1000,27 +892,40 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 			       struct amdgpu_vm *vm,
 			       struct amdgpu_vm_pt_cursor *cursor,
-			       bool immediate)
+			       bool direct)
 {
-	struct amdgpu_vm_bo_base *entry = cursor->entry;
-	struct amdgpu_bo *pt_bo;
-	struct amdgpu_bo_vm *pt;
+	struct amdgpu_vm_pt *entry = cursor->entry;
+	struct amdgpu_bo_param bp;
+	struct amdgpu_bo *pt;
 	int r;
 
-	if (entry->bo)
+	if (cursor->level < AMDGPU_VM_PTB && !entry->entries) {
+		unsigned num_entries;
+
+		num_entries = amdgpu_vm_num_entries(adev, cursor->level);
+		entry->entries = kvmalloc_array(num_entries,
+						sizeof(*entry->entries),
+						GFP_KERNEL | __GFP_ZERO);
+		if (!entry->entries)
+			return -ENOMEM;
+	}
+
+	if (entry->base.bo)
 		return 0;
 
-	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt);
+	amdgpu_vm_bo_param(adev, vm, cursor->level, direct, &bp);
+
+	r = amdgpu_bo_create(adev, &bp, &pt);
 	if (r)
 		return r;
 
 	/* Keep a reference to the root directory to avoid
 	 * freeing them up in the wrong order.
 	 */
-	pt_bo = &pt->bo;
-	pt_bo->parent = amdgpu_bo_ref(cursor->parent->bo);
-	amdgpu_vm_bo_base_init(entry, vm, pt_bo);
-	r = amdgpu_vm_clear_bo(adev, vm, pt, immediate);
+	pt->parent = amdgpu_bo_ref(cursor->parent->base.bo);
+	amdgpu_vm_bo_base_init(&entry->base, vm, pt);
+
+	r = amdgpu_vm_clear_bo(adev, vm, pt, direct);
 	if (r)
 		goto error_free_pt;
 
@@ -1028,7 +933,7 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 
 error_free_pt:
 	amdgpu_bo_unref(&pt->shadow);
-	amdgpu_bo_unref(&pt_bo);
+	amdgpu_bo_unref(&pt);
 	return r;
 }
 
@@ -1037,17 +942,16 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
  *
  * @entry: PDE to free
  */
-static void amdgpu_vm_free_table(struct amdgpu_vm_bo_base *entry)
+static void amdgpu_vm_free_table(struct amdgpu_vm_pt *entry)
 {
-	struct amdgpu_bo *shadow;
-
-	if (!entry->bo)
-		return;
-	shadow = amdgpu_bo_shadowed(entry->bo);
-	entry->bo->vm_bo = NULL;
-	list_del(&entry->vm_status);
-	amdgpu_bo_unref(&shadow);
-	amdgpu_bo_unref(&entry->bo);
+	if (entry->base.bo) {
+		entry->base.bo->vm_bo = NULL;
+		list_del(&entry->base.vm_status);
+		amdgpu_bo_unref(&entry->base.bo->shadow);
+		amdgpu_bo_unref(&entry->base.bo);
+	}
+	kvfree(entry->entries);
+	entry->entries = NULL;
 }
 
 /**
@@ -1064,7 +968,7 @@ static void amdgpu_vm_free_pts(struct amdgpu_device *adev,
 			       struct amdgpu_vm_pt_cursor *start)
 {
 	struct amdgpu_vm_pt_cursor cursor;
-	struct amdgpu_vm_bo_base *entry;
+	struct amdgpu_vm_pt *entry;
 
 	vm->bulk_moveable = false;
 
@@ -1332,10 +1236,10 @@ uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr)
  */
 static int amdgpu_vm_update_pde(struct amdgpu_vm_update_params *params,
 				struct amdgpu_vm *vm,
-				struct amdgpu_vm_bo_base *entry)
+				struct amdgpu_vm_pt *entry)
 {
-	struct amdgpu_vm_bo_base *parent = amdgpu_vm_pt_parent(entry);
-	struct amdgpu_bo *bo = parent->bo, *pbo;
+	struct amdgpu_vm_pt *parent = amdgpu_vm_pt_parent(entry);
+	struct amdgpu_bo *bo = parent->base.bo, *pbo;
 	uint64_t pde, pt, flags;
 	unsigned level;
 
@@ -1343,10 +1247,9 @@ static int amdgpu_vm_update_pde(struct amdgpu_vm_update_params *params,
 		pbo = pbo->parent;
 
 	level += params->adev->vm_manager.root_level;
-	amdgpu_gmc_get_pde_for_bo(entry->bo, level, &pt, &flags);
-	pde = (entry - to_amdgpu_bo_vm(parent->bo)->entries) * 8;
-	return vm->update_funcs->update(params, to_amdgpu_bo_vm(bo), pde, pt,
-					1, 0, flags);
+	amdgpu_gmc_get_pde_for_bo(entry->base.bo, level, &pt, &flags);
+	pde = (entry - parent->entries) * 8;
+	return vm->update_funcs->update(params, bo, pde, pt, 1, 0, flags);
 }
 
 /**
@@ -1361,11 +1264,11 @@ static void amdgpu_vm_invalidate_pds(struct amdgpu_device *adev,
 				     struct amdgpu_vm *vm)
 {
 	struct amdgpu_vm_pt_cursor cursor;
-	struct amdgpu_vm_bo_base *entry;
+	struct amdgpu_vm_pt *entry;
 
 	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, NULL, cursor, entry)
-		if (entry->bo && !entry->moved)
-			amdgpu_vm_bo_relocated(entry);
+		if (entry->base.bo && !entry->base.moved)
+			amdgpu_vm_bo_relocated(&entry->base);
 }
 
 /**
@@ -1373,7 +1276,7 @@ static void amdgpu_vm_invalidate_pds(struct amdgpu_device *adev,
  *
  * @adev: amdgpu_device pointer
  * @vm: requested vm
- * @immediate: submit immediately to the paging queue
+ * @direct: submit directly to the paging queue
  *
  * Makes sure all directories are up to date.
  *
@@ -1381,7 +1284,7 @@ static void amdgpu_vm_invalidate_pds(struct amdgpu_device *adev,
  * 0 for success, error for failure.
  */
 int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
-			  struct amdgpu_vm *vm, bool immediate)
+			  struct amdgpu_vm *vm, bool direct)
 {
 	struct amdgpu_vm_update_params params;
 	int r;
@@ -1392,19 +1295,18 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
-	params.immediate = immediate;
+	params.direct = direct;
 
 	r = vm->update_funcs->prepare(&params, NULL, AMDGPU_SYNC_EXPLICIT);
 	if (r)
 		return r;
 
 	while (!list_empty(&vm->relocated)) {
-		struct amdgpu_vm_bo_base *entry;
+		struct amdgpu_vm_pt *entry;
 
-		entry = list_first_entry(&vm->relocated,
-					 struct amdgpu_vm_bo_base,
-					 vm_status);
-		amdgpu_vm_bo_idle(entry);
+		entry = list_first_entry(&vm->relocated, struct amdgpu_vm_pt,
+					 base.vm_status);
+		amdgpu_vm_bo_idle(&entry->base);
 
 		r = amdgpu_vm_update_pde(&params, vm, entry);
 		if (r)
@@ -1427,9 +1329,9 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
  * Make sure to set the right flags for the PTEs at the desired level.
  */
 static void amdgpu_vm_update_flags(struct amdgpu_vm_update_params *params,
-				   struct amdgpu_bo_vm *pt, unsigned int level,
+				   struct amdgpu_bo *bo, unsigned level,
 				   uint64_t pe, uint64_t addr,
-				   unsigned int count, uint32_t incr,
+				   unsigned count, uint32_t incr,
 				   uint64_t flags)
 
 {
@@ -1445,7 +1347,7 @@ static void amdgpu_vm_update_flags(struct amdgpu_vm_update_params *params,
 		flags |= AMDGPU_PTE_EXECUTABLE;
 	}
 
-	params->vm->update_funcs->update(params, pt, pe, addr, count, incr,
+	params->vm->update_funcs->update(params, bo, pe, addr, count, incr,
 					 flags);
 }
 
@@ -1544,24 +1446,20 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
 		uint64_t incr, entry_end, pe_start;
 		struct amdgpu_bo *pt;
 
-		if (!params->unlocked) {
+		if (flags & (AMDGPU_PTE_VALID | AMDGPU_PTE_PRT)) {
 			/* make sure that the page tables covering the
 			 * address range are actually allocated
 			 */
 			r = amdgpu_vm_alloc_pts(params->adev, params->vm,
-						&cursor, params->immediate);
+						&cursor, params->direct);
 			if (r)
 				return r;
 		}
 
 		shift = amdgpu_vm_level_shift(adev, cursor.level);
 		parent_shift = amdgpu_vm_level_shift(adev, cursor.level - 1);
-		if (params->unlocked) {
-			/* Unlocked updates are only allowed on the leaves */
-			if (amdgpu_vm_pt_descendant(adev, &cursor))
-				continue;
-		} else if (adev->asic_type < CHIP_VEGA10 &&
-			   (flags & AMDGPU_PTE_VALID)) {
+		if (adev->asic_type < CHIP_VEGA10 &&
+		    (flags & AMDGPU_PTE_VALID)) {
 			/* No huge page support before GMC v9 */
 			if (cursor.level != AMDGPU_VM_PTB) {
 				if (!amdgpu_vm_pt_descendant(adev, &cursor))
@@ -1584,7 +1482,7 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
 			continue;
 		}
 
-		pt = cursor.entry->bo;
+		pt = cursor.entry->base.bo;
 		if (!pt) {
 			/* We need all PDs and PTs for mapping something, */
 			if (flags & AMDGPU_PTE_VALID)
@@ -1596,10 +1494,8 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
 			if (!amdgpu_vm_pt_ancestor(&cursor))
 				return -EINVAL;
 
-			pt = cursor.entry->bo;
+			pt = cursor.entry->base.bo;
 			shift = parent_shift;
-			frag_end = max(frag_end, ALIGN(frag_start + 1,
-				   1ULL << shift));
 		}
 
 		/* Looks good so far, calculate parameters for the update */
@@ -1611,26 +1507,19 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
 		entry_end = min(entry_end, end);
 
 		do {
-			struct amdgpu_vm *vm = params->vm;
 			uint64_t upd_end = min(entry_end, frag_end);
 			unsigned nptes = (upd_end - frag_start) >> shift;
-			uint64_t upd_flags = flags | AMDGPU_PTE_FRAG(frag);
 
 			/* This can happen when we set higher level PDs to
 			 * silent to stop fault floods.
 			 */
 			nptes = max(nptes, 1u);
-
-			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
-						    nptes, dst, incr, upd_flags,
-						    vm->task_info.pid,
-						    vm->immediate.fence_context);
-			amdgpu_vm_update_flags(params, to_amdgpu_bo_vm(pt),
-					       cursor.level, pe_start, dst,
-					       nptes, incr, upd_flags);
+			amdgpu_vm_update_flags(params, pt, cursor.level,
+					       pe_start, dst, nptes, incr,
+					       flags | AMDGPU_PTE_FRAG(frag));
 
 			pe_start += nptes * 8;
-			dst += nptes * incr;
+			dst += (uint64_t)nptes * AMDGPU_GPU_PAGE_SIZE << shift;
 
 			frag_start = upd_end;
 			if (frag_start >= frag_end) {
@@ -1650,11 +1539,7 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
 			 * completely covered by the range and so potentially still in use.
 			 */
 			while (cursor.pfn < frag_start) {
-				/* Make sure previous mapping is freed */
-				if (cursor.entry->bo) {
-					params->table_freed = true;
-					amdgpu_vm_free_pts(adev, params->vm, &cursor);
-				}
+				amdgpu_vm_free_pts(adev, params->vm, &cursor);
 				amdgpu_vm_pt_next(adev, &cursor);
 			}
 
@@ -1670,51 +1555,39 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
 /**
  * amdgpu_vm_bo_update_mapping - update a mapping in the vm page table
  *
- * @adev: amdgpu_device pointer of the VM
- * @bo_adev: amdgpu_device pointer of the mapped BO
+ * @adev: amdgpu_device pointer
  * @vm: requested vm
- * @immediate: immediate submission in a page fault
- * @unlocked: unlocked invalidation during MM callback
+ * @direct: direct submission in a page fault
  * @resv: fences we need to sync to
  * @start: start of mapped range
  * @last: last mapped entry
  * @flags: flags for the entries
- * @offset: offset into nodes and pages_addr
- * @res: ttm_resource to map
+ * @addr: addr to set the area to
  * @pages_addr: DMA addresses to use for mapping
  * @fence: optional resulting fence
- * @table_freed: return true if page table is freed
  *
  * Fill in the page table entries between @start and @last.
  *
  * Returns:
  * 0 for success, -EINVAL for failure.
  */
-int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
-				struct amdgpu_device *bo_adev,
-				struct amdgpu_vm *vm, bool immediate,
-				bool unlocked, struct dma_resv *resv,
-				uint64_t start, uint64_t last,
-				uint64_t flags, uint64_t offset,
-				struct ttm_resource *res,
-				dma_addr_t *pages_addr,
-				struct dma_fence **fence,
-				bool *table_freed)
+static int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
+				       struct amdgpu_vm *vm, bool direct,
+				       struct dma_resv *resv,
+				       uint64_t start, uint64_t last,
+				       uint64_t flags, uint64_t addr,
+				       dma_addr_t *pages_addr,
+				       struct dma_fence **fence)
 {
 	struct amdgpu_vm_update_params params;
-	struct amdgpu_res_cursor cursor;
 	enum amdgpu_sync_mode sync_mode;
-	int r, idx;
-
-	if (!drm_dev_enter(&adev->ddev, &idx))
-		return -ENODEV;
+	int r;
 
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
-	params.immediate = immediate;
+	params.direct = direct;
 	params.pages_addr = pages_addr;
-	params.unlocked = unlocked;
 
 	/* Implicitly sync to command submissions in the same VM before
 	 * unmapping. Sync to moving fences before mapping.
@@ -1730,133 +1603,178 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 		goto error_unlock;
 	}
 
-	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
-		struct dma_fence *tmp = dma_fence_get_stub();
+	if (flags & (AMDGPU_PTE_VALID | AMDGPU_PTE_PRT)) {
+		struct amdgpu_bo *root = vm->root.base.bo;
 
-		amdgpu_bo_fence(vm->root.bo, vm->last_unlocked, true);
-		swap(vm->last_unlocked, tmp);
-		dma_fence_put(tmp);
+		if (!dma_fence_is_signaled(vm->last_direct))
+			amdgpu_bo_fence(root, vm->last_direct, true);
 	}
 
 	r = vm->update_funcs->prepare(&params, resv, sync_mode);
 	if (r)
 		goto error_unlock;
 
-	amdgpu_res_first(pages_addr ? NULL : res, offset,
-			 (last - start + 1) * AMDGPU_GPU_PAGE_SIZE, &cursor);
-	while (cursor.remaining) {
-		uint64_t tmp, num_entries, addr;
+	r = amdgpu_vm_update_ptes(&params, start, last + 1, addr, flags);
+	if (r)
+		goto error_unlock;
+
+	r = vm->update_funcs->commit(&params, fence);
+
+error_unlock:
+	amdgpu_vm_eviction_unlock(vm);
+	return r;
+}
 
-		num_entries = cursor.size >> AMDGPU_GPU_PAGE_SHIFT;
-		if (pages_addr) {
-			bool contiguous = true;
+/**
+ * amdgpu_vm_bo_split_mapping - split a mapping into smaller chunks
+ *
+ * @adev: amdgpu_device pointer
+ * @resv: fences we need to sync to
+ * @pages_addr: DMA addresses to use for mapping
+ * @vm: requested vm
+ * @mapping: mapped range and flags to use for the update
+ * @flags: HW flags for the mapping
+ * @bo_adev: amdgpu_device pointer that bo actually been allocated
+ * @nodes: array of drm_mm_nodes with the MC addresses
+ * @fence: optional resulting fence
+ *
+ * Split the mapping into smaller chunks so that each update fits
+ * into a SDMA IB.
+ *
+ * Returns:
+ * 0 for success, -EINVAL for failure.
+ */
+static int amdgpu_vm_bo_split_mapping(struct amdgpu_device *adev,
+				      struct dma_resv *resv,
+				      dma_addr_t *pages_addr,
+				      struct amdgpu_vm *vm,
+				      struct amdgpu_bo_va_mapping *mapping,
+				      uint64_t flags,
+				      struct amdgpu_device *bo_adev,
+				      struct ttm_mem_reg *mem,
+				      struct dma_fence **fence)
+{
+	struct drm_mm_node *nodes = mem ? mem->mm_node : NULL;
+	uint64_t vram_base_offset = bo_adev->vm_manager.vram_base_offset;
+	unsigned min_linear_pages = 1 << adev->vm_manager.fragment_size;
+	uint64_t pfn, start = mapping->start;
+	int r;
 
-			if (num_entries > AMDGPU_GPU_PAGES_IN_CPU_PAGE) {
-				uint64_t pfn = cursor.start >> PAGE_SHIFT;
-				uint64_t count;
+	/* normally,bo_va->flags only contians READABLE and WIRTEABLE bit go here
+	 * but in case of something, we filter the flags in first place
+	 */
+	if (!(mapping->flags & AMDGPU_PTE_READABLE))
+		flags &= ~AMDGPU_PTE_READABLE;
+	if (!(mapping->flags & AMDGPU_PTE_WRITEABLE))
+		flags &= ~AMDGPU_PTE_WRITEABLE;
+
+	/* Apply ASIC specific mapping flags */
+	amdgpu_gmc_get_vm_pte(adev, mapping, &flags);
+
+	if (adev != bo_adev &&
+	    !(flags & AMDGPU_PTE_SYSTEM) &&
+	    !mapping->bo_va->is_xgmi) {
+		if (amdgpu_device_is_peer_accessible(bo_adev, adev)) {
+			flags |= AMDGPU_PTE_SYSTEM;
+			vram_base_offset = bo_adev->gmc.aper_base;
+		} else {
+			DRM_DEBUG_DRIVER("Failed to map the VRAM for peer device access.\n");
+			return -EINVAL;
+		}
+	}
 
-				contiguous = pages_addr[pfn + 1] ==
-					pages_addr[pfn] + PAGE_SIZE;
+	trace_amdgpu_vm_bo_update(mapping);
 
-				tmp = num_entries /
-					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
-				for (count = 2; count < tmp; ++count) {
-					uint64_t idx = pfn + count;
+	pfn = mapping->offset >> PAGE_SHIFT;
+	if (nodes) {
+		while (pfn >= nodes->size) {
+			pfn -= nodes->size;
+			++nodes;
+		}
+	}
 
-					if (contiguous != (pages_addr[idx] ==
-					    pages_addr[idx - 1] + PAGE_SIZE))
+	do {
+		dma_addr_t *dma_addr = NULL;
+		uint64_t max_entries;
+		uint64_t addr, last;
+		uint64_t count;
+
+		if (nodes) {
+			addr = nodes->start << PAGE_SHIFT;
+			max_entries = (nodes->size - pfn) *
+				AMDGPU_GPU_PAGES_IN_CPU_PAGE;
+
+			switch (mem->mem_type) {
+			case TTM_PL_TT:
+				if (pages_addr) {
+					for (count = 1;
+						 count < max_entries / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
+						 ++count){
+						uint64_t idx = pfn + count;
+						if (pages_addr[idx] !=
+							(pages_addr[idx - 1] + PAGE_SIZE))
 						break;
+						}
+					if (count < min_linear_pages) {
+						addr = pfn << PAGE_SHIFT;
+						dma_addr = pages_addr;
+					} else {
+						addr = pages_addr[pfn];
+						max_entries = count;
+					}
+				} else if (flags & (AMDGPU_PTE_VALID | AMDGPU_PTE_PRT)) {
+					addr += vram_base_offset;
+					addr += pfn << PAGE_SHIFT;
 				}
-				num_entries = count *
-					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
-			}
-
-			if (!contiguous) {
-				addr = cursor.start;
-				params.pages_addr = pages_addr;
-			} else {
-				addr = pages_addr[cursor.start >> PAGE_SHIFT];
-				params.pages_addr = NULL;
+				break;
+			case AMDGPU_PL_DGMA_IMPORT:
+			case AMDGPU_PL_DGMA_PEER:
+				addr = 0;
+				dma_addr = pages_addr;
+				break;
+			case AMDGPU_PL_DGMA:
+				addr += vram_base_offset +
+					adev->mman.bdev.man[mem->mem_type].gpu_offset -
+					adev->mman.bdev.man[TTM_PL_VRAM].gpu_offset;
+				addr += pfn << PAGE_SHIFT;
+				break;
+			case TTM_PL_VRAM:
+				addr += vram_base_offset;
+				addr += pfn << PAGE_SHIFT;
+				break;
+			default:
+				break;
 			}
-
-		} else if (flags & (AMDGPU_PTE_VALID | AMDGPU_PTE_PRT)) {
-			addr = bo_adev->vm_manager.vram_base_offset +
-				cursor.start;
 		} else {
 			addr = 0;
+			max_entries = S64_MAX;
 		}
 
-		tmp = start + num_entries;
-		r = amdgpu_vm_update_ptes(&params, start, tmp, addr, flags);
+		last = min((uint64_t)mapping->last, start + max_entries - 1);
+		r = amdgpu_vm_bo_update_mapping(adev, vm, false, resv,
+						start, last, flags, addr,
+						dma_addr, fence);
 		if (r)
-			goto error_unlock;
-
-		amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
-		start = tmp;
-	}
+			return r;
 
-	r = vm->update_funcs->commit(&params, fence);
+		pfn += (last - start + 1) / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
+		if (nodes && nodes->size == pfn) {
+			pfn = 0;
+			++nodes;
+		}
+		start = last + 1;
 
-	if (table_freed)
-		*table_freed = *table_freed || params.table_freed;
+	} while (unlikely(start != mapping->last + 1));
 
-error_unlock:
-	amdgpu_vm_eviction_unlock(vm);
-	drm_dev_exit(idx);
-	return r;
+	return 0;
 }
 
-void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
-				uint64_t *gtt_mem, uint64_t *cpu_mem)
-{
-	struct amdgpu_bo_va *bo_va, *tmp;
-
-	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
-				gtt_mem, cpu_mem);
-	}
-	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
-				gtt_mem, cpu_mem);
-	}
-	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
-				gtt_mem, cpu_mem);
-	}
-	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
-				gtt_mem, cpu_mem);
-	}
-	spin_lock(&vm->invalidated_lock);
-	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
-				gtt_mem, cpu_mem);
-	}
-	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
-				gtt_mem, cpu_mem);
-	}
-	spin_unlock(&vm->invalidated_lock);
-}
 /**
  * amdgpu_vm_bo_update - update all BO mappings in the vm page table
  *
  * @adev: amdgpu_device pointer
  * @bo_va: requested BO and VM object
  * @clear: if true clear the entries
- * @table_freed: return true if page table is freed
  *
  * Fill in the page table entries for @bo_va.
  *
@@ -1864,13 +1782,14 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
  * 0 for success, -EINVAL for failure.
  */
 int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
-			bool clear, bool *table_freed)
+			bool clear)
 {
 	struct amdgpu_bo *bo = bo_va->base.bo;
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	struct amdgpu_bo_va_mapping *mapping;
 	dma_addr_t *pages_addr = NULL;
-	struct ttm_resource *mem;
+	struct ttm_mem_reg *mem;
+	struct drm_mm_node *nodes;
 	struct dma_fence **last_update;
 	struct dma_resv *resv;
 	uint64_t flags;
@@ -1879,23 +1798,21 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 
 	if (clear || !bo) {
 		mem = NULL;
-		resv = vm->root.bo->tbo.base.resv;
+		nodes = NULL;
+		resv = amdkcl_ttm_resvp(&vm->root.base.bo->tbo);
 	} else {
-		struct drm_gem_object *obj = &bo->tbo.base;
-
-		resv = bo->tbo.base.resv;
-		if (obj->import_attach && bo_va->is_xgmi) {
-			struct dma_buf *dma_buf = obj->import_attach->dmabuf;
-			struct drm_gem_object *gobj = dma_buf->priv;
-			struct amdgpu_bo *abo = gem_to_amdgpu_bo(gobj);
-
-			if (abo->tbo.resource->mem_type == TTM_PL_VRAM)
-				bo = gem_to_amdgpu_bo(gobj);
+		struct ttm_dma_tt *ttm;
+
+		mem = &bo->tbo.mem;
+		nodes = mem->mm_node;
+		if (mem->mem_type == TTM_PL_TT) {
+			ttm = container_of(bo->tbo.ttm, struct ttm_dma_tt, ttm);
+			pages_addr = ttm->dma_address;
+		} else if (mem->mem_type == AMDGPU_PL_DGMA_IMPORT ||
+			   mem->mem_type == AMDGPU_PL_DGMA_PEER) {
+			pages_addr = (dma_addr_t *)bo_va->base.bo->tbo.mem.bus.addr;
 		}
-		mem = bo->tbo.resource;
-		if (mem->mem_type == TTM_PL_TT ||
-		    mem->mem_type == AMDGPU_PL_PREEMPT)
-			pages_addr = bo->tbo.ttm->dma_address;
+		resv = amdkcl_ttm_resvp(&bo->tbo);
 	}
 
 	if (bo) {
@@ -1909,8 +1826,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 		flags = 0x0;
 	}
 
-	if (clear || (bo && bo->tbo.base.resv ==
-		      vm->root.bo->tbo.base.resv))
+	if (clear || (bo && amdkcl_ttm_resvp(&bo->tbo) == amdkcl_ttm_resvp(&vm->root.base.bo->tbo)))
 		last_update = &vm->last_update;
 	else
 		last_update = &bo_va->last_pt_update;
@@ -1924,26 +1840,9 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 	}
 
 	list_for_each_entry(mapping, &bo_va->invalids, list) {
-		uint64_t update_flags = flags;
-
-		/* normally,bo_va->flags only contians READABLE and WIRTEABLE bit go here
-		 * but in case of something, we filter the flags in first place
-		 */
-		if (!(mapping->flags & AMDGPU_PTE_READABLE))
-			update_flags &= ~AMDGPU_PTE_READABLE;
-		if (!(mapping->flags & AMDGPU_PTE_WRITEABLE))
-			update_flags &= ~AMDGPU_PTE_WRITEABLE;
-
-		/* Apply ASIC specific mapping flags */
-		amdgpu_gmc_get_vm_pte(adev, mapping, &update_flags);
-
-		trace_amdgpu_vm_bo_update(mapping);
-
-		r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, false, false,
-						resv, mapping->start,
-						mapping->last, update_flags,
-						mapping->offset, mem,
-						pages_addr, last_update, table_freed);
+		r = amdgpu_vm_bo_split_mapping(adev, resv, pages_addr, vm,
+					       mapping, flags, bo_adev,
+					       mem, last_update);
 		if (r)
 			return r;
 	}
@@ -1952,8 +1851,8 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 	 * the evicted list so that it gets validated again on the
 	 * next command submission.
 	 */
-	if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv) {
-		uint32_t mem_type = bo->tbo.resource->mem_type;
+	if (bo && amdkcl_ttm_resvp(&bo->tbo) == amdkcl_ttm_resvp(&vm->root.base.bo->tbo)) {
+		uint32_t mem_type = bo->tbo.mem.mem_type;
 
 		if (!(bo->preferred_domains &
 		      amdgpu_mem_type_to_domain(mem_type)))
@@ -2089,17 +1988,18 @@ static void amdgpu_vm_free_mapping(struct amdgpu_device *adev,
  */
 static void amdgpu_vm_prt_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
-	struct dma_resv *resv = vm->root.bo->tbo.base.resv;
+	struct dma_resv *resv = amdkcl_ttm_resvp(&vm->root.base.bo->tbo);
 	struct dma_fence *excl, **shared;
 	unsigned i, shared_count;
 	int r;
 
-	r = dma_resv_get_fences(resv, &excl, &shared_count, &shared);
+	r = dma_resv_get_fences_rcu(resv, &excl,
+					      &shared_count, &shared);
 	if (r) {
 		/* Not enough memory to grab the fence list, as last resort
 		 * block for all the fences to complete.
 		 */
-		dma_resv_wait_timeout(resv, true, false,
+		dma_resv_wait_timeout_rcu(resv, true, false,
 						    MAX_SCHEDULE_TIMEOUT);
 		return;
 	}
@@ -2135,7 +2035,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm,
 			  struct dma_fence **fence)
 {
-	struct dma_resv *resv = vm->root.bo->tbo.base.resv;
+	struct dma_resv *resv = amdkcl_ttm_resvp(&vm->root.base.bo->tbo);
 	struct amdgpu_bo_va_mapping *mapping;
 	uint64_t init_pte_value = 0;
 	struct dma_fence *f = NULL;
@@ -2150,10 +2050,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 		    mapping->start < AMDGPU_GMC_HOLE_START)
 			init_pte_value = AMDGPU_PTE_DEFAULT_ATC;
 
-		r = amdgpu_vm_bo_update_mapping(adev, adev, vm, false, false,
-						resv, mapping->start,
-						mapping->last, init_pte_value,
-						0, NULL, NULL, &f, NULL);
+		r = amdgpu_vm_bo_update_mapping(adev, vm, false, resv,
+						mapping->start, mapping->last,
+						init_pte_value, 0, NULL, &f);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
 			dma_fence_put(f);
@@ -2172,6 +2071,58 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 
 }
 
+void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
+				uint64_t *gtt_mem, uint64_t *cpu_mem)
+{
+	struct amdgpu_bo_va *bo_va, *tmp;
+
+	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
+		if (!bo_va->base.bo)
+			continue;
+		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
+					gtt_mem, cpu_mem);
+	}
+	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status) {
+		if (!bo_va->base.bo)
+			continue;
+		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
+					gtt_mem, cpu_mem);
+	}
+	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status) {
+		if (!bo_va->base.bo)
+			continue;
+		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
+					gtt_mem, cpu_mem);
+	}
+	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
+		if (!bo_va->base.bo)
+			continue;
+		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
+					gtt_mem, cpu_mem);
+	}
+	spin_lock(&vm->invalidated_lock);
+	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
+		if (!bo_va->base.bo)
+			continue;
+		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
+					gtt_mem, cpu_mem);
+	}
+	list_for_each_entry_safe(bo_va, tmp, &vm->freed, base.vm_status) {
+		if (!bo_va->base.bo)
+			continue;
+		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
+					gtt_mem, cpu_mem);
+	}
+	spin_unlock(&vm->invalidated_lock);
+
+	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
+		if (!bo_va->base.bo)
+			continue;
+		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
+					gtt_mem, cpu_mem);
+	}
+}
+
 /**
  * amdgpu_vm_handle_moved - handle moved BOs in the PT
  *
@@ -2195,7 +2146,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 
 	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
 		/* Per VM BOs never need to bo cleared in the page tables */
-		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
+		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			return r;
 	}
@@ -2204,7 +2155,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 	while (!list_empty(&vm->invalidated)) {
 		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
 					 base.vm_status);
-		resv = bo_va->base.bo->tbo.base.resv;
+		resv = amdkcl_ttm_resvp(&bo_va->base.bo->tbo);
 		spin_unlock(&vm->invalidated_lock);
 
 		/* Try to reserve the BO to avoid clearing its ptes */
@@ -2214,7 +2165,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 		else
 			clear = true;
 
-		r = amdgpu_vm_bo_update(adev, bo_va, clear, NULL);
+		r = amdgpu_vm_bo_update(adev, bo_va, clear);
 		if (r)
 			return r;
 
@@ -2258,13 +2209,14 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
 	INIT_LIST_HEAD(&bo_va->valids);
 	INIT_LIST_HEAD(&bo_va->invalids);
 
-	if (!bo)
-		return bo_va;
-
-	if (amdgpu_dmabuf_is_xgmi_accessible(adev, bo)) {
+	if (bo && amdgpu_xgmi_same_hive(adev, amdgpu_ttm_adev(bo->tbo.bdev)) &&
+	    (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM)) {
 		bo_va->is_xgmi = true;
+		mutex_lock(&adev->vm_manager.lock_pstate);
 		/* Power up XGMI if it can be potentially used */
-		amdgpu_xgmi_set_pstate(adev, AMDGPU_XGMI_PSTATE_MAX_VEGA20);
+		if (++adev->vm_manager.xgmi_map_counter == 1)
+			amdgpu_xgmi_set_pstate(adev, 1);
+		mutex_unlock(&adev->vm_manager.lock_pstate);
 	}
 
 	return bo_va;
@@ -2272,7 +2224,7 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
 
 
 /**
- * amdgpu_vm_bo_insert_map - insert a new mapping
+ * amdgpu_vm_bo_insert_mapping - insert a new mapping
  *
  * @adev: amdgpu_device pointer
  * @bo_va: bo_va to store the address
@@ -2294,7 +2246,7 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
 	if (mapping->flags & AMDGPU_PTE_PRT)
 		amdgpu_vm_prt_get(adev);
 
-	if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
+	if (bo && amdkcl_ttm_resvp(&bo->tbo) == amdkcl_ttm_resvp(&vm->root.base.bo->tbo) &&
 	    !bo_va->base.moved) {
 		list_move(&bo_va->base.vm_status, &vm->moved);
 	}
@@ -2329,15 +2281,14 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
 	uint64_t eaddr;
 
 	/* validate the parameters */
-	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK ||
-	    size == 0 || size & ~PAGE_MASK)
+	if (saddr & AMDGPU_GPU_PAGE_MASK || offset & AMDGPU_GPU_PAGE_MASK ||
+	    size == 0 || size & AMDGPU_GPU_PAGE_MASK)
 		return -EINVAL;
 
 	/* make sure object fit at this offset */
 	eaddr = saddr + size - 1;
 	if (saddr >= eaddr ||
-	    (bo && offset + size > amdgpu_bo_size(bo)) ||
-	    (eaddr >= adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT))
+	    (bo && offset + size > amdgpu_bo_size(bo)))
 		return -EINVAL;
 
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
@@ -2395,15 +2346,14 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
 	int r;
 
 	/* validate the parameters */
-	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK ||
-	    size == 0 || size & ~PAGE_MASK)
+	if (saddr & AMDGPU_GPU_PAGE_MASK || offset & AMDGPU_GPU_PAGE_MASK ||
+	    size == 0 || size & AMDGPU_GPU_PAGE_MASK)
 		return -EINVAL;
 
 	/* make sure object fit at this offset */
 	eaddr = saddr + size - 1;
 	if (saddr >= eaddr ||
-	    (bo && offset + size > amdgpu_bo_size(bo)) ||
-	    (eaddr >= adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT))
+	    (bo && offset + size > amdgpu_bo_size(bo)))
 		return -EINVAL;
 
 	/* Allocate all the needed memory */
@@ -2541,7 +2491,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 			after->start = eaddr + 1;
 			after->last = tmp->last;
 			after->offset = tmp->offset;
-			after->offset += (after->start - tmp->start) << PAGE_SHIFT;
+			after->offset += after->start - tmp->start;
 			after->flags = tmp->flags;
 			after->bo_va = tmp->bo_va;
 			list_add(&after->list, &tmp->bo_va->invalids);
@@ -2628,7 +2578,7 @@ void amdgpu_vm_bo_trace_cs(struct amdgpu_vm *vm, struct ww_acquire_ctx *ticket)
 			struct amdgpu_bo *bo;
 
 			bo = mapping->bo_va->base.bo;
-			if (dma_resv_locking_ctx(bo->tbo.base.resv) !=
+			if (dma_resv_locking_ctx(amdkcl_ttm_resvp(&bo->tbo)) !=
 			    ticket)
 				continue;
 		}
@@ -2656,7 +2606,7 @@ void amdgpu_vm_bo_rmv(struct amdgpu_device *adev,
 	struct amdgpu_vm_bo_base **base;
 
 	if (bo) {
-		if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
+		if (amdkcl_ttm_resvp(&bo->tbo) == amdkcl_ttm_resvp(&vm->root.base.bo->tbo))
 			vm->bulk_moveable = false;
 
 		for (base = &bo_va->base.bo->vm_bo; *base;
@@ -2689,8 +2639,12 @@ void amdgpu_vm_bo_rmv(struct amdgpu_device *adev,
 
 	dma_fence_put(bo_va->last_pt_update);
 
-	if (bo && bo_va->is_xgmi)
-		amdgpu_xgmi_set_pstate(adev, AMDGPU_XGMI_PSTATE_MIN);
+	if (bo && bo_va->is_xgmi) {
+		mutex_lock(&adev->vm_manager.lock_pstate);
+		if (--adev->vm_manager.xgmi_map_counter == 0)
+			amdgpu_xgmi_set_pstate(adev, 0);
+		mutex_unlock(&adev->vm_manager.lock_pstate);
+	}
 
 	kfree(bo_va);
 }
@@ -2711,7 +2665,7 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
 		return true;
 
 	/* Don't evict VM page tables while they are busy */
-	if (!dma_resv_test_signaled(bo->tbo.base.resv, true))
+	if (!dma_resv_test_signaled_rcu(amdkcl_ttm_resvp(&bo->tbo), true))
 		return false;
 
 	/* Try to block ongoing updates */
@@ -2719,7 +2673,7 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
 		return false;
 
 	/* Don't evict VM page tables while they are updated */
-	if (!dma_fence_is_signaled(bo_base->vm->last_unlocked)) {
+	if (!dma_fence_is_signaled(bo_base->vm->last_direct)) {
 		amdgpu_vm_eviction_unlock(bo_base->vm);
 		return false;
 	}
@@ -2744,13 +2698,13 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
 	struct amdgpu_vm_bo_base *bo_base;
 
 	/* shadow bo doesn't have bo base, its validation needs its parent */
-	if (bo->parent && (amdgpu_bo_shadowed(bo->parent) == bo))
+	if (bo->parent && bo->parent->shadow == bo)
 		bo = bo->parent;
 
 	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
 		struct amdgpu_vm *vm = bo_base->vm;
 
-		if (evicted && bo->tbo.base.resv == vm->root.bo->tbo.base.resv) {
+		if (evicted && amdkcl_ttm_resvp(&bo->tbo) == amdkcl_ttm_resvp(&vm->root.base.bo->tbo)) {
 			amdgpu_vm_bo_evicted(bo_base);
 			continue;
 		}
@@ -2761,7 +2715,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
 
 		if (bo->tbo.type == ttm_bo_type_kernel)
 			amdgpu_vm_bo_relocated(bo_base);
-		else if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
+		else if (amdkcl_ttm_resvp(&bo->tbo) == amdkcl_ttm_resvp(&vm->root.base.bo->tbo))
 			amdgpu_vm_bo_moved(bo_base);
 		else
 			amdgpu_vm_bo_invalidated(bo_base);
@@ -2891,12 +2845,12 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
  */
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
 {
-	timeout = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv, true,
-					true, timeout);
+	timeout = dma_resv_wait_timeout_rcu(amdkcl_ttm_resvp(&vm->root.base.bo->tbo),
+						   true, true, timeout);
 	if (timeout <= 0)
 		return timeout;
 
-	return dma_fence_wait_timeout(vm->last_unlocked, true, timeout);
+	return dma_fence_wait_timeout(vm->last_direct, true, timeout);
 }
 
 /**
@@ -2904,19 +2858,26 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
  *
  * @adev: amdgpu_device pointer
  * @vm: requested vm
+ * @vm_context: Indicates if it GFX or Compute context
+ * @pasid: Process address space identifier
  *
  * Init @vm fields.
  *
  * Returns:
  * 0 for success, error for failure.
  */
-int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
+int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		   int vm_context, unsigned int pasid)
 {
-	struct amdgpu_bo *root_bo;
-	struct amdgpu_bo_vm *root;
+	struct amdgpu_bo_param bp;
+	struct amdgpu_bo *root;
 	int r, i;
 
+#ifndef HAVE_TREE_INSERT_HAVE_RB_ROOT_CACHED
+	vm->va = RB_ROOT;
+#else
 	vm->va = RB_ROOT_CACHED;
+#endif
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
 		vm->reserved_vmid[i] = NULL;
 	INIT_LIST_HEAD(&vm->evicted);
@@ -2929,7 +2890,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	INIT_LIST_HEAD(&vm->done);
 
 	/* create scheduler entities for page table updates */
-	r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NORMAL,
+	r = drm_sched_entity_init(&vm->direct, DRM_SCHED_PRIORITY_NORMAL,
 				  adev->vm_manager.vm_pte_scheds,
 				  adev->vm_manager.vm_pte_num_scheds, NULL);
 	if (r)
@@ -2939,14 +2900,21 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 				  adev->vm_manager.vm_pte_scheds,
 				  adev->vm_manager.vm_pte_num_scheds, NULL);
 	if (r)
-		goto error_free_immediate;
+		goto error_free_direct;
 
 	vm->pte_support_ats = false;
 	vm->is_compute_context = false;
 
-	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
-				    AMDGPU_VM_USE_CPU_FOR_GFX);
+	if (vm_context == AMDGPU_VM_CONTEXT_COMPUTE) {
+		vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
+						AMDGPU_VM_USE_CPU_FOR_COMPUTE);
 
+		if (adev->asic_type == CHIP_RAVEN)
+			vm->pte_support_ats = true;
+	} else {
+		vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
+						AMDGPU_VM_USE_CPU_FOR_GFX);
+	}
 	DRM_DEBUG_DRIVER("VM update mode is %s\n",
 			 vm->use_cpu_for_update ? "CPU" : "SDMA");
 	WARN_ONCE((vm->use_cpu_for_update &&
@@ -2958,50 +2926,65 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	else
 		vm->update_funcs = &amdgpu_vm_sdma_funcs;
 	vm->last_update = NULL;
-	vm->last_unlocked = dma_fence_get_stub();
+	vm->last_direct = dma_fence_get_stub();
 
 	mutex_init(&vm->eviction_lock);
 	vm->evicting = false;
 
-	r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
-				false, &root);
+	amdgpu_vm_bo_param(adev, vm, adev->vm_manager.root_level, false, &bp);
+	if (vm_context == AMDGPU_VM_CONTEXT_COMPUTE)
+		bp.flags &= ~AMDGPU_GEM_CREATE_SHADOW;
+	r = amdgpu_bo_create(adev, &bp, &root);
 	if (r)
 		goto error_free_delayed;
-	root_bo = &root->bo;
-	r = amdgpu_bo_reserve(root_bo, true);
+
+	r = amdgpu_bo_reserve(root, true);
 	if (r)
 		goto error_free_root;
 
-	r = dma_resv_reserve_shared(root_bo->tbo.base.resv, 1);
+	r = dma_resv_reserve_shared(amdkcl_ttm_resvp(&root->tbo), 1);
 	if (r)
 		goto error_unreserve;
 
-	amdgpu_vm_bo_base_init(&vm->root, vm, root_bo);
+	amdgpu_vm_bo_base_init(&vm->root.base, vm, root);
 
 	r = amdgpu_vm_clear_bo(adev, vm, root, false);
 	if (r)
 		goto error_unreserve;
 
-	amdgpu_bo_unreserve(vm->root.bo);
+	amdgpu_bo_unreserve(vm->root.base.bo);
+
+	if (pasid) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
+		r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
+			      GFP_ATOMIC);
+		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
+		if (r < 0)
+			goto error_free_root;
+
+		vm->pasid = pasid;
+	}
 
 	INIT_KFIFO(vm->faults);
 
 	return 0;
 
 error_unreserve:
-	amdgpu_bo_unreserve(vm->root.bo);
+	amdgpu_bo_unreserve(vm->root.base.bo);
 
 error_free_root:
-	amdgpu_bo_unref(&root->shadow);
-	amdgpu_bo_unref(&root_bo);
-	vm->root.bo = NULL;
+	amdgpu_bo_unref(&vm->root.base.bo->shadow);
+	amdgpu_bo_unref(&vm->root.base.bo);
+	vm->root.base.bo = NULL;
 
 error_free_delayed:
-	dma_fence_put(vm->last_unlocked);
+	dma_fence_put(vm->last_direct);
 	drm_sched_entity_destroy(&vm->delayed);
 
-error_free_immediate:
-	drm_sched_entity_destroy(&vm->immediate);
+error_free_direct:
+	drm_sched_entity_destroy(&vm->direct);
 
 	return r;
 }
@@ -3020,14 +3003,17 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
  *	0 if this VM is clean
  */
 static int amdgpu_vm_check_clean_reserved(struct amdgpu_device *adev,
-					  struct amdgpu_vm *vm)
+	struct amdgpu_vm *vm)
 {
 	enum amdgpu_vm_level root = adev->vm_manager.root_level;
 	unsigned int entries = amdgpu_vm_num_entries(adev, root);
 	unsigned int i = 0;
 
+	if (!(vm->root.entries))
+		return 0;
+
 	for (i = 0; i < entries; i++) {
-		if (to_amdgpu_bo_vm(vm->root.bo)->entries[i].bo)
+		if (vm->root.entries[i].base.bo)
 			return -EINVAL;
 	}
 
@@ -3039,6 +3025,7 @@ static int amdgpu_vm_check_clean_reserved(struct amdgpu_device *adev,
  *
  * @adev: amdgpu_device pointer
  * @vm: requested vm
+ * @pasid: pasid to use
  *
  * This only works on GFX VMs that don't have any BOs added and no
  * page tables allocated yet.
@@ -3046,6 +3033,7 @@ static int amdgpu_vm_check_clean_reserved(struct amdgpu_device *adev,
  * Changes the following VM parameters:
  * - use_cpu_for_update
  * - pte_supports_ats
+ * - pasid (old PASID is released, because compute manages its own PASIDs)
  *
  * Reinitializes the page directory to reflect the changed ATS
  * setting.
@@ -3053,12 +3041,13 @@ static int amdgpu_vm_check_clean_reserved(struct amdgpu_device *adev,
  * Returns:
  * 0 for success, -errno for errors.
  */
-int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
+int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			   unsigned int pasid)
 {
 	bool pte_support_ats = (adev->asic_type == CHIP_RAVEN);
 	int r;
 
-	r = amdgpu_bo_reserve(vm->root.bo, true);
+	r = amdgpu_bo_reserve(vm->root.base.bo, true);
 	if (r)
 		return r;
 
@@ -3067,16 +3056,27 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	if (r)
 		goto unreserve_bo;
 
+	if (pasid) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
+		r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
+			      GFP_ATOMIC);
+		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
+
+		if (r == -ENOSPC)
+			goto unreserve_bo;
+		r = 0;
+	}
+
 	/* Check if PD needs to be reinitialized and do it before
 	 * changing any other state, in case it fails.
 	 */
 	if (pte_support_ats != vm->pte_support_ats) {
 		vm->pte_support_ats = pte_support_ats;
-		r = amdgpu_vm_clear_bo(adev, vm,
-				       to_amdgpu_bo_vm(vm->root.bo),
-				       false);
+		r = amdgpu_vm_clear_bo(adev, vm, vm->root.base.bo, false);
 		if (r)
-			goto unreserve_bo;
+			goto free_idr;
 	}
 
 	/* Update VM state */
@@ -3088,28 +3088,46 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		   !amdgpu_gmc_vram_full_visible(&adev->gmc)),
 		  "CPU update of VM recommended only for large BAR system\n");
 
-	if (vm->use_cpu_for_update) {
-		/* Sync with last SDMA update/clear before switching to CPU */
-		r = amdgpu_bo_sync_wait(vm->root.bo,
-					AMDGPU_FENCE_OWNER_UNDEFINED, true);
-		if (r)
-			goto unreserve_bo;
-
+	if (vm->use_cpu_for_update)
 		vm->update_funcs = &amdgpu_vm_cpu_funcs;
-	} else {
+	else
 		vm->update_funcs = &amdgpu_vm_sdma_funcs;
-	}
 	dma_fence_put(vm->last_update);
 	vm->last_update = NULL;
 	vm->is_compute_context = true;
 
+	if (vm->pasid) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
+		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
+		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
+
+		/* Free the original amdgpu allocated pasid
+		 * Will be replaced with kfd allocated pasid
+		 */
+		amdgpu_pasid_free(vm->pasid);
+		vm->pasid = 0;
+	}
+
 	/* Free the shadow bo for compute VM */
-	amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.bo)->shadow);
+	amdgpu_bo_unref(&vm->root.base.bo->shadow);
+
+	if (pasid)
+		vm->pasid = pasid;
 
 	goto unreserve_bo;
 
+free_idr:
+	if (pasid) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
+		idr_remove(&adev->vm_manager.pasid_idr, pasid);
+		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
+	}
 unreserve_bo:
-	amdgpu_bo_unreserve(vm->root.bo);
+	amdgpu_bo_unreserve(vm->root.base.bo);
 	return r;
 }
 
@@ -3123,7 +3141,14 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
  */
 void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
-	amdgpu_vm_set_pasid(adev, vm, 0);
+	if (vm->pasid) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
+		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
+		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
+	}
+	vm->pasid = 0;
 	vm->is_compute_context = false;
 }
 
@@ -3145,11 +3170,19 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
-	root = amdgpu_bo_ref(vm->root.bo);
+	root = amdgpu_bo_ref(vm->root.base.bo);
 	amdgpu_bo_reserve(root, true);
-	amdgpu_vm_set_pasid(adev, vm, 0);
-	dma_fence_wait(vm->last_unlocked, false);
-	dma_fence_put(vm->last_unlocked);
+	if (vm->pasid) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
+		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
+		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
+		vm->pasid = 0;
+	}
+
+	dma_fence_wait(vm->last_direct, false);
+	dma_fence_put(vm->last_direct);
 
 	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
 		if (mapping->flags & AMDGPU_PTE_PRT && prt_fini_needed) {
@@ -3164,16 +3197,24 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	amdgpu_vm_free_pts(adev, vm, NULL);
 	amdgpu_bo_unreserve(root);
 	amdgpu_bo_unref(&root);
-	WARN_ON(vm->root.bo);
+	WARN_ON(vm->root.base.bo);
 
-	drm_sched_entity_destroy(&vm->immediate);
+	drm_sched_entity_destroy(&vm->direct);
 	drm_sched_entity_destroy(&vm->delayed);
 
+#ifndef HAVE_TREE_INSERT_HAVE_RB_ROOT_CACHED
+	if (!RB_EMPTY_ROOT(&vm->va)) {
+#else
 	if (!RB_EMPTY_ROOT(&vm->va.rb_root)) {
+#endif
 		dev_err(adev->dev, "still active bo inside vm\n");
 	}
 	rbtree_postorder_for_each_entry_safe(mapping, tmp,
+#ifndef HAVE_TREE_INSERT_HAVE_RB_ROOT_CACHED
+					     &vm->va, rb) {
+#else
 					     &vm->va.rb_root, rb) {
+#endif
 		/* Don't remove the mapping here, we don't want to trigger a
 		 * rebalance and the tree is about to be destroyed anyway.
 		 */
@@ -3197,12 +3238,6 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 {
 	unsigned i;
 
-	/* Concurrent flushes are only possible starting with Vega10 and
-	 * are broken on Navi10 and Navi14.
-	 */
-	adev->vm_manager.concurrent_flush = !(adev->asic_type < CHIP_VEGA10 ||
-					      adev->asic_type == CHIP_NAVI10 ||
-					      adev->asic_type == CHIP_NAVI14);
 	amdgpu_vmid_mgr_init(adev);
 
 	adev->vm_manager.fence_context =
@@ -3229,7 +3264,11 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 	adev->vm_manager.vm_update_mode = 0;
 #endif
 
-	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
+	idr_init(&adev->vm_manager.pasid_idr);
+	spin_lock_init(&adev->vm_manager.pasid_lock);
+
+	adev->vm_manager.xgmi_map_counter = 0;
+	mutex_init(&adev->vm_manager.lock_pstate);
 }
 
 /**
@@ -3241,8 +3280,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
  */
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
 {
-	WARN_ON(!xa_empty(&adev->vm_manager.pasids));
-	xa_destroy(&adev->vm_manager.pasids);
+	WARN_ON(!idr_is_empty(&adev->vm_manager.pasid_idr));
+	idr_destroy(&adev->vm_manager.pasid_idr);
 
 	amdgpu_vmid_mgr_fini(adev);
 }
@@ -3260,7 +3299,7 @@ void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
 int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 {
 	union drm_amdgpu_vm *args = data;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_device *adev = dev->dev_private;
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	long timeout = msecs_to_jiffies(2000);
 	int r;
@@ -3280,7 +3319,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		/* Wait vm idle to make sure the vmid set in SPM_VMID is
 		 * not referenced anymore.
 		 */
-		r = amdgpu_bo_reserve(fpriv->vm.root.bo, true);
+		r = amdgpu_bo_reserve(fpriv->vm.root.base.bo, true);
 		if (r)
 			return r;
 
@@ -3288,7 +3327,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		if (r < 0)
 			return r;
 
-		amdgpu_bo_unreserve(fpriv->vm.root.bo);
+		amdgpu_bo_unreserve(fpriv->vm.root.base.bo);
 		amdgpu_vmid_free_reserved(adev, &fpriv->vm, AMDGPU_GFXHUB_0);
 		break;
 	default:
@@ -3305,19 +3344,19 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
  * @pasid: PASID identifier for VM
  * @task_info: task_info to fill.
  */
-void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
+void amdgpu_vm_get_task_info(struct amdgpu_device *adev, unsigned int pasid,
 			 struct amdgpu_task_info *task_info)
 {
 	struct amdgpu_vm *vm;
 	unsigned long flags;
 
-	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
+	spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
 
-	vm = xa_load(&adev->vm_manager.pasids, pasid);
+	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
 	if (vm)
 		*task_info = vm->task_info;
 
-	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
 }
 
 /**
@@ -3349,60 +3388,50 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
  * Try to gracefully handle a VM fault. Return true if the fault was handled and
  * shouldn't be reported any more.
  */
-bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
+bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, unsigned int pasid,
 			    uint64_t addr)
 {
-	bool is_compute_context = false;
 	struct amdgpu_bo *root;
-	unsigned long irqflags;
 	uint64_t value, flags;
 	struct amdgpu_vm *vm;
-	int r;
+	long r;
 
-	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
-	vm = xa_load(&adev->vm_manager.pasids, pasid);
-	if (vm) {
-		root = amdgpu_bo_ref(vm->root.bo);
-		is_compute_context = vm->is_compute_context;
-	} else {
+	spin_lock(&adev->vm_manager.pasid_lock);
+	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
+	if (vm)
+		root = amdgpu_bo_ref(vm->root.base.bo);
+	else
 		root = NULL;
-	}
-	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
+	spin_unlock(&adev->vm_manager.pasid_lock);
 
 	if (!root)
 		return false;
 
-	addr /= AMDGPU_GPU_PAGE_SIZE;
-
-	if (is_compute_context &&
-	    !svm_range_restore_pages(adev, pasid, addr)) {
-		amdgpu_bo_unref(&root);
-		return true;
-	}
-
 	r = amdgpu_bo_reserve(root, true);
 	if (r)
 		goto error_unref;
 
 	/* Double check that the VM still exists */
-	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
-	vm = xa_load(&adev->vm_manager.pasids, pasid);
-	if (vm && vm->root.bo != root)
+	spin_lock(&adev->vm_manager.pasid_lock);
+	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
+	if (vm && vm->root.base.bo != root)
 		vm = NULL;
-	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
+	spin_unlock(&adev->vm_manager.pasid_lock);
 	if (!vm)
 		goto error_unlock;
 
+	addr /= AMDGPU_GPU_PAGE_SIZE;
 	flags = AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
 		AMDGPU_PTE_SYSTEM;
 
-	if (is_compute_context) {
+	if (vm->is_compute_context) {
 		/* Intentionally setting invalid PTE flag
 		 * combination to force a no-retry-fault
 		 */
 		flags = AMDGPU_PTE_EXECUTABLE | AMDGPU_PDE_PTE |
 			AMDGPU_PTE_TF;
 		value = 0;
+
 	} else if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_NEVER) {
 		/* Redirect the access to the dummy page */
 		value = adev->dummy_page_addr;
@@ -3414,15 +3443,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		value = 0;
 	}
 
-	r = dma_resv_reserve_shared(root->tbo.base.resv, 1);
-	if (r) {
-		pr_debug("failed %d to reserve fence slot\n", r);
-		goto error_unlock;
-	}
-
-	r = amdgpu_vm_bo_update_mapping(adev, adev, vm, true, false, NULL, addr,
-					addr, flags, value, NULL, NULL, NULL,
-					NULL);
+	r = amdgpu_vm_bo_update_mapping(adev, vm, true, NULL, addr, addr + 1,
+					flags, value, NULL, NULL);
 	if (r)
 		goto error_unlock;
 
@@ -3431,106 +3453,10 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 error_unlock:
 	amdgpu_bo_unreserve(root);
 	if (r < 0)
-		DRM_ERROR("Can't handle page fault (%d)\n", r);
+		DRM_ERROR("Can't handle page fault (%ld)\n", r);
 
 error_unref:
 	amdgpu_bo_unref(&root);
 
 	return false;
 }
-
-#if defined(CONFIG_DEBUG_FS)
-/**
- * amdgpu_debugfs_vm_bo_info  - print BO info for the VM
- *
- * @vm: Requested VM for printing BO info
- * @m: debugfs file
- *
- * Print BO information in debugfs file for the VM
- */
-void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
-{
-	struct amdgpu_bo_va *bo_va, *tmp;
-	u64 total_idle = 0;
-	u64 total_evicted = 0;
-	u64 total_relocated = 0;
-	u64 total_moved = 0;
-	u64 total_invalidated = 0;
-	u64 total_done = 0;
-	unsigned int total_idle_objs = 0;
-	unsigned int total_evicted_objs = 0;
-	unsigned int total_relocated_objs = 0;
-	unsigned int total_moved_objs = 0;
-	unsigned int total_invalidated_objs = 0;
-	unsigned int total_done_objs = 0;
-	unsigned int id = 0;
-
-	seq_puts(m, "\tIdle BOs:\n");
-	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		total_idle += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
-	}
-	total_idle_objs = id;
-	id = 0;
-
-	seq_puts(m, "\tEvicted BOs:\n");
-	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		total_evicted += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
-	}
-	total_evicted_objs = id;
-	id = 0;
-
-	seq_puts(m, "\tRelocated BOs:\n");
-	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		total_relocated += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
-	}
-	total_relocated_objs = id;
-	id = 0;
-
-	seq_puts(m, "\tMoved BOs:\n");
-	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		total_moved += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
-	}
-	total_moved_objs = id;
-	id = 0;
-
-	seq_puts(m, "\tInvalidated BOs:\n");
-	spin_lock(&vm->invalidated_lock);
-	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		total_invalidated += amdgpu_bo_print_info(id++,	bo_va->base.bo, m);
-	}
-	total_invalidated_objs = id;
-	id = 0;
-
-	seq_puts(m, "\tDone BOs:\n");
-	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
-	}
-	spin_unlock(&vm->invalidated_lock);
-	total_done_objs = id;
-
-	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
-		   total_idle_objs);
-	seq_printf(m, "\tTotal evicted size:     %12lld\tobjs:\t%d\n", total_evicted,
-		   total_evicted_objs);
-	seq_printf(m, "\tTotal relocated size:   %12lld\tobjs:\t%d\n", total_relocated,
-		   total_relocated_objs);
-	seq_printf(m, "\tTotal moved size:       %12lld\tobjs:\t%d\n", total_moved,
-		   total_moved_objs);
-	seq_printf(m, "\tTotal invalidated size: %12lld\tobjs:\t%d\n", total_invalidated,
-		   total_invalidated_objs);
-	seq_printf(m, "\tTotal done size:        %12lld\tobjs:\t%d\n", total_done,
-		   total_done_objs);
-}
-#endif
-- 
2.17.1

