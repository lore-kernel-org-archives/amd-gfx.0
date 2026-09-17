Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B87C982D0
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 11:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8370110E6EB;
	Thu, 17 Sep 2026 11:03:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tuVaUDRk";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FC4310E6EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 11:02:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmpsOZjN9U7L38m4DSAK33C6SPLLMqUOa9gAmRAdIBPdGE63JRAn8D7/wCOWHWm/1zpG7Z0T1bHcbAS3rzsmjUlvf3C1LxA48+Mv2E8QytJa4z3nITavjnmS5eapyyUfNGx2aBEW2An+k32128N2G+1MMxGcpljzhyJkKGdeNmCzlK0auFHrqRn8pGHz4fIenkNVAZ8eUDWRo7Uo6VqyCZtmCS7aX4yZwPvOYK3Nl+wi3o2HnFfE3uTjhR2CAcOc/mlmUHJEyWx4u6AjMTeWJDUHjBszmRscLP81oDwVyRsR2LVPNUbgD8oJPMf60J6XTMuBciqcis/F4eOtrrwJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a38JTD3IHqlbUGZAn34dNrARuOrC/jHIHjNIui5fxME=;
 b=lq1ySzz+1CbTRMrzYyu8nDsJMwbI0z7OYjaBbRwOsAHZaoGHNb1yCp18bySXSnQMhnxv1RoGbUzfBsopcpnyQXFk9NvJ9sZr0xZj4e3Q4IgjaxQbIGb4HSKLNJR4F59nHi5djotjAcq9vYPjJTRk4w5tAc/4tRfcQXPJlIv91ZAbxE9LXkBX4CZY+AZHQ8g3FJ85XTYXfqd4vm0a4Sw7s1rdpymVshL+E99m0NqQdjJwXsMiL20opm5FdagBHMMyQt+068ANLskA0UIBv7Muxpm8/vYeVWl9JPRCx/2YqAdN0Kv5KEXsfpWdJXhFDTHaqFT8775UVykoxiMLvgTrvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a38JTD3IHqlbUGZAn34dNrARuOrC/jHIHjNIui5fxME=;
 b=tuVaUDRkZ77Qp4dkhiVNyX38QKFvS+o9JrO1cg+AjDIjtkXfxqrcgaBib8axZoyImYR906bJrjhRQ4w5XYqZLzsooGS0l1C+R4mr8JA7ShlkoznXkJJvEw4bIEJ6Bsli5V22GdEQ+3n4D3zIA2T7uw1DJiCBGjeVLgEGmtykeB8=
Received: from SJ0PR03CA0332.namprd03.prod.outlook.com (2603:10b6:a03:39c::7)
 by DS7PR12MB9475.namprd12.prod.outlook.com (2603:10b6:8:251::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 11:02:52 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::4d) by SJ0PR03CA0332.outlook.office365.com
 (2603:10b6:a03:39c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 11:02:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 11:02:51 +0000
Received: from yhuang-B850M-AORUS-PRO-WIFI7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 06:02:49 -0500
From: Huang Yu <yhuang13@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
CC: Yu Huang <Yu.Huang@amd.com>, Honglei Huang <honghuan@amd.com>, Ray Huang
 <ray.huang@amd.com>, Shen Junhua <junhshen@amd.com>, Lingshan Zhu
 <lingszhu@amd.com>, Timur Cristof <timur.kristof@gmail.com>, Natalie Vock
 <natalie.vock@gmx.de>, AMD-GFX <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/13] drm/amdgpu: add amdgpu_vm_pt_leaves()
Date: Thu, 17 Sep 2026 19:01:49 +0800
Message-ID: <20260917110158.296198-5-yhuang13@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917110158.296198-1-yhuang13@amd.com>
References: <20260917110158.296198-1-yhuang13@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|DS7PR12MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f84d8f4-a47e-4ae5-80aa-08df14ab37e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|18002099003|22082099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: lYZeJMR8ajlLvJPrS6zdRdaEwFXekvOsSDu+zk2s3wo8j5k9a7P4Xgrg9s9fp9fcBk+cYddyf0i7xBVyk/sNUvtEiEPGRPOkg37RRU2xV9Mj0TYzm9TwTE/5zamTQM/ipZSkM5kbln8x/Rha73NUm45nDW3KnuIBqtTceoIBVslNMAdGBSsBcRVZiyXupZJGchjKjcnUBeJfhyT0hc2Q9QHgK8BXSKR6tsyOXC1YDRPI8dlweL5LHxwGt4NLDPBWGy735pM6cSVmPkIaHbGowK5Lq8uPdg2PVEZkGlqPEXNj8mc2dFsUAu/Cz7RumcL/X5DeFcUptvk8ceBs1N5eTa72jkaKoO3+ITVvQ53xVqnGOVT2BWFQI3C4I6RGapvENND4z6EszQr+wlnesXOc0i9tjqF57S4A338LlfA9KYgb3N4KqvKV4K4K3yFQAsIEnbSOMCcbBBQDW8dKL2xGc9WzXRNf3qHt7sVfHbZlM6MjwqfRgbV68jX3ezGE4T/4JzOUyFvfz2yvkgv4T9LLJKr4pR5uhpBSfL0s5bgSdTmVJ/0dc1+rvpY5jV7XJb/ICMlDwZQhR03AwgwR0rs11YJYu5BfheCEk8gUwoXtkeeWo4Ko7b5iQd9C88Yj6MZxlbJ/X007Orxs58jyfSnCPTPFKkyUJ5CGNYtQ9syvfyHjy/kJiiatoucrQ8Iehl8c
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MerwJtYZlQ5DFkbemzPCN8OOReXeOBcxWgcTF7b1OC9SalrFjpNsT9NXjVlMrGEbYkLep8UKwc0wdy9ObPiIM5qxvcjLeQcg7KhkbfphiHDB2yEsh4Hp6LaH3p/AOCrR/w+VA5bPpYp5+vlIsjzBHUBiCX8Ea+ABHxIl7z0S3f18UQljvlLdcuOD65NAUusUM+gD+bk6dsk6z+cyySCbHDzMW881dOXtBo1RcV1E4zgIK2n6gFVtd7DmIc3Fv2VPU8WNi9w66rryY9UjKAMUgXe6L70G6BoJgmt50uhbD8Ja10VpOQ8wokVzggdq9pLW8u92Cw3noOd/eNigHtsVXiFCUrkoQ5HjVOzJw9gng9TfymgH7PXys+bLtByOjH1YuJrW4mQRjL/vGO5ph0LupBT5Weke2DPuv++BgHGMqHiwmQeg/mA085sgDiVC1tpY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 11:02:51.8971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f84d8f4-a47e-4ae5-80aa-08df14ab37e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9475
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

From: Christian König <ckoenig.leichtzumerken@gmail.com>

Add a new function amdgpu_vm_update_leaves() to avoid memory allocation
on page faults.

The idea is to only update the leave PDEs/PTEs to let them point to the
dummy page.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 55 +++++++++++-----
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 62 +++++++++++++++++++
 3 files changed, 105 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 5675925ca656..e60143d4990c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3013,10 +3013,12 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    u32 vmid, u32 node_id, uint64_t addr,
 			    uint64_t ts, bool write_fault)
 {
+	struct amdgpu_vm_update_params params;
 	bool is_compute_context = false;
-	struct drm_exec exec;
-	uint64_t value, flags;
+	uint64_t *values, flags;
 	struct amdgpu_vm *vm;
+	struct drm_exec exec;
+	unsigned int idx;
 	int r;
 
 	drm_exec_init(&exec, 0, 1);
@@ -3060,24 +3062,21 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	}
 
 	addr /= AMDGPU_GPU_PAGE_SIZE;
-	flags = AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
-		AMDGPU_PTE_SYSTEM;
-
 	if (is_compute_context) {
 		/* Intentionally setting invalid PTE flag
 		 * combination to force a no-retry-fault
 		 */
 		flags = AMDGPU_VM_NORETRY_FLAGS;
-		value = 0;
+		values = NULL;
 	} else if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_NEVER) {
 		/* Redirect the access to the dummy page */
-		value = adev->dummy_page_addr;
-		flags |= AMDGPU_PTE_EXECUTABLE | AMDGPU_PTE_READABLE |
-			AMDGPU_PTE_WRITEABLE;
-
+		flags = 0;
+		values = adev->vm_manager.dummy_dst;
 	} else {
 		/* Let the hw retry silently on the PTE */
-		value = 0;
+		flags = AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
+			AMDGPU_PTE_SYSTEM;
+		values = NULL;
 	}
 
 	r = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 1);
@@ -3086,12 +3085,38 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		goto error_unlock;
 	}
 
-	r = amdgpu_vm_update_range(adev, vm, true, false, false, false,
-				   NULL, addr, addr, flags, value, 0, NULL, NULL, NULL);
-	if (r)
+	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
+		r = -ENODEV;
 		goto error_unlock;
+	}
 
-	r = amdgpu_vm_update_pdes(adev, vm, true);
+	amdgpu_vm_eviction_lock(vm);
+	if (vm->evicting) {
+		r = -EBUSY;
+		goto error_dev_exit;
+	}
+
+	memset(&params, 0, sizeof(params));
+	params.adev = adev;
+	params.vm = vm;
+	params.immediate = true;
+	params.pages_addr = NULL;
+
+	r = vm->update_funcs->prepare(&params, NULL,
+				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES);
+	if (r)
+		goto error_dev_exit;
+
+	amdgpu_vm_pt_leaves(&params, addr, addr, values, flags);
+
+	r = vm->update_funcs->commit(&params, &vm->last_update);
+	if (r)
+		goto error_dev_exit;
+
+	amdgpu_vm_eviction_unlock(vm);
+
+error_dev_exit:
+	drm_dev_exit(idx);
 
 error_unlock:
 	drm_exec_fini(&exec);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
index 16cc0d5f5894..7d3c0904e1a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -121,6 +121,9 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
 int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			  uint64_t start, uint64_t end,
 			  uint64_t dst, uint64_t flags);
+void amdgpu_vm_pt_leaves(struct amdgpu_vm_update_params *params,
+			 uint64_t start, uint64_t end,
+			 int64_t *dst, uint64_t flags);
 void amdgpu_vm_pt_free_work(struct work_struct *work);
 void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
 			    struct amdgpu_vm_update_params *params);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 3a6449d60988..2f542c731447 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -936,6 +936,68 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 	return 0;
 }
 
+/**
+ * amdgpu_vm_pt_leaves - update leave PDEs/PTEs
+ *
+ * @params: see amdgpu_vm_update_params definition
+ * @start: start of GPU address range
+ * @end: end of GPU address range
+ * @dst: optional array with one dst addr per layer
+ * @flags: mapping flags
+ *
+ * Update the leave PDEs/PTEs in the range @start - @end without allocating or
+ * freeing page tables.
+ *
+ * Returns:
+ * 0 for success, negative error code for failure.
+ */
+void amdgpu_vm_pt_leaves(struct amdgpu_vm_update_params *params,
+			 uint64_t start, uint64_t end,
+			 int64_t *dst, uint64_t flags)
+{
+	struct amdgpu_device *adev = params->adev;
+	struct amdgpu_vm_pt_cursor cursor;
+
+	amdgpu_vm_pt_start(adev, params->vm, start, &cursor);
+	while (cursor.pfn < end) {
+		uint64_t entry_end, pe_start, val;
+		unsigned int shift, mask;
+		struct amdgpu_bo *pt;
+		unsigned int nptes;
+
+		/* Walk to the leave entries */
+		if (amdgpu_vm_pt_descendant(adev, &cursor))
+			continue;
+
+		pt = cursor.parent->bo;
+		shift = amdgpu_vm_pt_level_shift(adev, cursor.level - 1);
+		mask = amdgpu_vm_pt_entries_mask(adev, cursor.level - 1);
+
+		/* Looks good so far, calculate parameters for the update */
+		pe_start = ((cursor.pfn >> shift) & mask) * 8;
+
+		entry_end = ((uint64_t)mask + 1) << shift;
+		entry_end += cursor.pfn & ~(entry_end - 1);
+		entry_end = min(entry_end, end);
+
+		nptes = (entry_end - cursor.pfn) >> shift;
+		/*
+		 * This can happen when we set higher level PDEs to unmap and/or
+		 * silent to stop fault floods.
+		 */
+		nptes = max(nptes, 1u);
+
+		val = dst ? dst[cursor.level] : 0;
+		trace_amdgpu_vm_update_ptes(params, cursor.pfn, entry_end,
+					    min(nptes, 32u), val, 0, flags);
+
+		params->vm->update_funcs->update(params, to_amdgpu_bo_vm(pt),
+						 pe_start, val, nptes, 0,
+						 flags);
+		amdgpu_vm_pt_next(adev, &cursor);
+	}
+}
+
 /**
  * amdgpu_vm_pt_map_tables - have bo of root PD cpu accessible
  * @adev: amdgpu device structure
-- 
2.53.0

