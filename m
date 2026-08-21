Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF9CC5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03F9E10F4A8;
	Fri, 21 Aug 2026 19:53:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4poSkght";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9BC010F4A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:53:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCjfLjlMnH0aPdsA7kw9Z4cvTn6Oxk94HlioaELxQgysm+kQN3p8yi1YE94YnM9n5pfBX38giGp2KIN3Q8gtiz9fH/zzsD8i4X66OKFw8jW3tR4HCbgkypYExo7+dC1WQXg1waGLKUEn2eyueIa5J+bxgJ5yzHJJXV0GZKudx9xsOPvd6ELZn90v4koq0ofnRyj1Rx2l+GHDBelF28k5Lgw0HYUS7Fv1hlSvgR+thgqvDM7nGTOnpnhGmJ0jQisvnIOtLzRSQM+gCQRZAYn0RqFR6y1jpcA5aS0WVF5ehlwSbAlpo3mEqCo5zuJKKXCj6LXeMa+4c59Zj5TDuNT70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlHtucRpKosrq96xiEyH4GHnpE2mZpUN3VG55HdDngA=;
 b=dMvzmtv+aMGcQbAnGxK+Ab+vqvFI/qUjrPZ21Q/h1z82Y/FkzNESU1IS74On+jh5yzhF6Kdvbo/wfrqx+xLIgToKRixWx1u35QBdfHmtmtTcZdoK7zW0OK9vEHHWtBeCax6ki5fxf4z+v35WWm0M+v5BemR28RIJ7G9E4UIO8VBUMQdU0rdPR/dB6Z4leuXGBHflVF2ofIEWexNLuD8YsvgNGWuPj6SJt5iJ2Fm6krewDzCUEbMZVQUfx+LCdJkPii2RD3LiresWfdqdX8uyLpVUSVEfEuHcLeU82Opytf/PIVnN6ILAVmOSdrvlC2zQu2ANJWZRPykJXHXDEe7WSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlHtucRpKosrq96xiEyH4GHnpE2mZpUN3VG55HdDngA=;
 b=4poSkghtoVGOvqRxy/bOhnmjrBSLucsj13kpa/VYN6XWOH4bEmvPtWQslXa1808iff7Av3skdfs4eUfwjJrfhg4UiXSdNAhspZocfpVKgJRYRb9wi+1qQiJpjakCrH4iPvs5OCK2nH7rnrEv4oA0P/wuZW3CkM9DsHcYKN0J6BI=
Received: from CH5PR02CA0013.namprd02.prod.outlook.com (2603:10b6:610:1ed::27)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:35:50 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::a7) by CH5PR02CA0013.outlook.office365.com
 (2603:10b6:610:1ed::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:43 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:43 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 52/95] drm/amdgpu: Cleanup exported UALink handles
Date: Fri, 21 Aug 2026 15:34:15 -0400
Message-ID: <20260821193458.808626-53-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3a50a2-ad88-457b-cbf7-08deffbb681a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|22082099003|18002099003|11063799006|6133799003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: fGm79Uvu4v4TUEOyN8Mw1JxKJR/TrOTLe0MrlGJHMfCKzKYE+QYhUiu2RKBvma+XTvaWDu6qQFK3+tiybms0nY8FqW6CQAOIFbHei74vjN5SAH6klf7ZqGV9QpG99L81qOBwH8I9igoM4Tfg0TTY8rBFUbNPs2AsCuuQ+aW0PXh7LGkwA8Ghu2922wmPHTcGW2I2GBUSA9aalt/U6JPdEka3/npQAQvHkvcKzCrYUoIRI1af6vAHkPhUuMyk/+NSs3Hcgu/2ZG4XqLy/3HfWWOaulH+bWUbm66YnzrQs+VkH8NNt3dfIRTTIG1ARSI1TBYVgmfkPqPsTE+e3bibI3QY9oG7RKXagWi19TvZSS8TujbZa2Nq2QG2xzv42H/TUQjv9WbDhjDW/i+2m6quFv1Cp3o0PSj9iu72nXlfJmfGPMyApR1p/d6/Y6esB1QP7HqfNRYxIi/9WLRp0/oKKCWwK4U5m8Hte/xojlkmAwXCKihmpF09kT/sPMIsta4jgu0oc6fUfjInbXjU63JhtoRl/cnVHgZqM/0+2MNB+/mrpXOpaY8EDFFe9crA9O8j3hav9OoYD2bbqqkP4ZUQlNUS6nys0GHDkWvzo9oDrkkcUtwQeTOtVtxGhyIeG5c6mX8LMMp/3hnM+Jv/qezzpYtmYpGT70e4WAVLjEKBPwTutDMuFpdVIQJWieBqM/zEdEWZDhZsrDlzadGg75tGOvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(22082099003)(18002099003)(11063799006)(6133799003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PQ5av8tt8z/m74a6xxe+/NJnQltgMb2WZOGNSv3cev56EtfjB7voGjtByy/9MlzKsnlbNoXnV9Gs7dqKMLK2oWFTCV2P8RUN2+3QVBnIq5pRryxJaq0OHnWfd0p/YoBnT/u+uUwyjSvl+cSuFe2ex8s+mwHFEUb33jSjqE5A2XQIH1bYZqaiSVIPVfPFPuaJAtLu+sKgiNmBaJpvjrmLWaktr4RyseqyJI18WbHk6/I9yyTtSyRTrU3OF2vbddqJ2o1WGEUpX+eBufXS0gvYStFBa8220pDnGxlGDUAIkh3sfriBoC6gd4Xm0Bxx9UIYVotlDOCQ+bT+lR74hKWkhh5CsDCZW55qzyzO/d4HtmHY2iYib5zlfvlSI5N7PID0dzMoTf5qgZl+IF0qFOle3vVHybZnTPvteEZk3H7V3C+jFfjY2eyGFnbrs5JASZIx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:50.3094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3a50a2-ad88-457b-cbf7-08deffbb681a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656
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

From: Mukul Joshi <mukul.joshi@amd.com>

Add implementation for freeing up exporter GPU's UALink
handles and the corresponding xarray entries. Before freeing,
the exporter GPU would send the NPA-REVOKE message to all the
importers and wait for the NPA-RELEASE messages to come back
before freeing the xarray entry.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 343 +++++++++++++++++++++
 1 file changed, 343 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 03c061b135afb..44233e6c390ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1225,6 +1225,13 @@ static void amdgpu_generate_ualink_handle(struct amdgpu_device *adev,
 
 static void amdgpu_ualink_cleanup_exp_xa_node(struct kref *ref)
 {
+	struct amdgpu_ualink_exp_xa_node *exp_xa_node;
+	struct amdgpu_device *adev;
+
+	exp_xa_node = container_of(ref, struct amdgpu_ualink_exp_xa_node,
+				   refcount);
+	adev = amdgpu_ttm_adev(exp_xa_node->bo->tbo.bdev);
+	queue_work(adev->ualink.npa_wq, &exp_xa_node->cleanup_work);
 }
 
 static void amdgpu_ualink_cleanup_imp_xa_node(struct kref *ref)
@@ -1704,8 +1711,344 @@ static int amdgpu_ualink_setup_connection(struct amdgpu_device *adev,
 	return r;
 }
 
+/* Set PTE.X = 1 for all importer entries to retry RPCs. */
+static void amdgpu_ualink_force_retry_rpcs(struct amdgpu_device *adev,
+				struct amdgpu_ualink_exp_xa_node *exp_xa_node)
+{
+	u32 addr_mode = adev->ualink.info->vpod.addr_mode;
+	struct amdgpu_ualink_importer_entry *imp_entry;
+	struct amdgpu_vm *vm = &adev->ualink.npa_vm;
+	u64 pte_flags, npa_addr, size;
+	struct dma_fence *fence = NULL;
+	struct amdgpu_bo *bo;
+	struct drm_exec exec;
+	u32 remote_acc_id;
+	int r;
+
+	bo = exp_xa_node->bo;
+	size = amdgpu_bo_ngpu_pages(bo);
+
+	amdgpu_ualink_reserve_npa_vm_and_bos(adev, &bo, 1, &exec, false);
+
+	for_each_set_bit(remote_acc_id, exp_xa_node->importers_bitmap,
+			 AMDGPU_UALINK_ACCEL_MAX) {
+		if (addr_mode == AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS)
+			imp_entry = &exp_xa_node->importer_entries[0];
+		else
+			imp_entry = &exp_xa_node->importer_entries[remote_acc_id];
+		npa_addr = imp_entry->npa_addr;
+
+		/* If the connection state changed while we are freeing
+		 * the BO, then ignore this importer. We will unmap this
+		 * address eventually in amdgpu_ualink_unmap_all_npa_addr()
+		 * function. Also, we will clear the corresponding bit in
+		 * the importer_bitmap in the same function.
+		 */
+		if (!amdgpu_ualink_check_conn_ready(adev, remote_acc_id,
+					imp_entry->generation_count))
+			continue;
+
+		/* Set PTE.X = 1 */
+		pte_flags = amdgpu_ualink_get_export_pte_flags(adev, bo,
+					AMDGPU_VM_PAGE_EXECUTABLE);
+		dev_dbg(adev->dev,
+			"RETRY-RPC: setting PTE.X=1 for NPA:%llx remote:%u pte:0x%llx\n",
+			npa_addr, remote_acc_id, pte_flags);
+
+		r = amdgpu_vm_update_range(adev, vm, false, false, true,
+					false, NULL, npa_addr, npa_addr + size - 1,
+					pte_flags, 0, adev->vm_manager.vram_base_offset,
+					bo->tbo.resource, NULL, &vm->last_update);
+
+		if (r)
+			dev_warn(adev->dev,
+				"RETRY-RPC: PTE.X update failed for NPA:%llx remote:%u, r: %d\n",
+				npa_addr, remote_acc_id, r);
+
+		if (addr_mode == AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS)
+			break;
+	}
+
+	r = amdgpu_vm_update_pdes(adev, vm, false);
+	if (r) {
+		dev_err(adev->dev,
+			"Failed %d to update page directories during force retry rpcs\n",
+			r);
+		amdgpu_ualink_unreserve_npa_vm_and_bos(adev, &exec);
+		return;
+	}
+
+	fence = dma_fence_get(vm->last_update);
+	if (fence) {
+		r = dma_fence_wait(fence, false);
+		dma_fence_put(fence);
+		fence = NULL;
+		if (r)
+			dev_dbg(adev->dev, "RETRY-RPC: dma fence wait failed err:%d\n", r);
+	}
+
+	amdgpu_ualink_unreserve_npa_vm_and_bos(adev, &exec);
+
+	amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
+}
+
+/* Unmap all NPA addresses associated with a BO (UALink handle). This function is used
+ * only in Source Identification mode.
+ */
+static void amdgpu_ualink_unmap_all_npa_addr(struct amdgpu_device *adev,
+				struct amdgpu_ualink_exp_xa_node *exp_xa_node)
+{
+	u32 addr_mode = adev->ualink.info->vpod.addr_mode;
+	struct amdgpu_ualink_importer_entry *imp_entry;
+	u64 pte_value = adev->gmc.noretry_flags;
+	struct dma_fence *fence = NULL;
+	struct drm_exec exec;
+	u64 npa_addr, size;
+	u32 remote_acc_id;
+	int r;
+
+	size = amdgpu_bo_ngpu_pages(exp_xa_node->bo);
+
+	amdgpu_ualink_reserve_npa_vm_and_bos(adev, &exp_xa_node->bo, 1,
+					     &exec, false);
+
+	for_each_set_bit(remote_acc_id, exp_xa_node->importers_bitmap,
+			 AMDGPU_UALINK_ACCEL_MAX) {
+		if (addr_mode == AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS)
+			imp_entry = &exp_xa_node->importer_entries[0];
+		else
+			imp_entry = &exp_xa_node->importer_entries[remote_acc_id];
+		npa_addr = imp_entry->npa_addr;
+
+		if (!amdgpu_ualink_check_conn_ready(adev, remote_acc_id,
+					imp_entry->generation_count)) {
+			clear_bit(remote_acc_id,
+				  exp_xa_node->importers_bitmap);
+			continue;
+		}
+
+		dev_dbg(adev->dev,
+			"UNMAP-NPA: Unmapping NPA:%llx, handle:%llx:%llx remote:%u pte:0x%llx\n",
+			npa_addr, exp_xa_node->handle.handle_hi, exp_xa_node->handle.handle_lo,
+			remote_acc_id, pte_value);
+
+		r = amdgpu_vm_update_range(adev, &adev->ualink.npa_vm, false,
+					   false, true, false, NULL, npa_addr,
+					   npa_addr + size - 1, pte_value, 0,
+					   0, NULL, NULL, &fence);
+
+		if (r)
+			dev_err(adev->dev,
+				"UNMAP-NPA: Unmap failed NPA:%llx, handle:%llx:%llx remote:%u\n",
+				npa_addr, exp_xa_node->handle.handle_hi,
+				exp_xa_node->handle.handle_lo, remote_acc_id);
+
+		if (addr_mode == AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS)
+			break;
+	}
+
+	r = amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm, false);
+	if (r) {
+		dev_err(adev->dev,
+			"Failed %d to update page directories during all NPA addresses unmapping\n",
+			r);
+		amdgpu_ualink_unreserve_npa_vm_and_bos(adev, &exec);
+		return;
+	}
+
+	if (fence) {
+		r = dma_fence_wait(fence, false);
+		dma_fence_put(fence);
+		fence = NULL;
+		if (r)
+			dev_err(adev->dev,
+				"UNMAP-NPA: dma fence wait failed\n");
+	}
+
+	amdgpu_ualink_unreserve_npa_vm_and_bos(adev, &exec);
+
+	amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
+}
+
+static void amdgpu_ualink_free_all_npa_va(struct amdgpu_device *adev,
+				struct amdgpu_ualink_exp_xa_node *exp_xa_node,
+				unsigned long *importers_bitmap)
+{
+	u32 addr_mode = adev->ualink.info->vpod.addr_mode;
+	struct drm_mm_node *mm_node;
+	u32 remote_acc_id;
+
+	for_each_set_bit(remote_acc_id, importers_bitmap, AMDGPU_UALINK_ACCEL_MAX) {
+		if (addr_mode == AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS)
+			mm_node = exp_xa_node->importer_entries[0].mm_node;
+		else
+			mm_node = exp_xa_node->importer_entries[remote_acc_id].mm_node;
+
+		if (!mm_node) {
+			if (addr_mode == AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS)
+				break;
+			continue;
+		}
+
+		dev_dbg(adev->dev,
+			"FREE-NPA: freeing NPA address:%llx, handle:%llx:%llx remote:%u\n",
+			mm_node->start, exp_xa_node->handle.handle_hi,
+			exp_xa_node->handle.handle_lo, remote_acc_id);
+
+		amdgpu_ualink_npa_free_va(adev, mm_node);
+		kfree(mm_node);
+
+		if (addr_mode == AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS)
+			break;
+	}
+}
+
 static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
 {
+	DECLARE_BITMAP(orig_importers_bitmap, AMDGPU_UALINK_ACCEL_MAX);
+	struct amdgpu_ualink_importer_entry *imp_entry;
+	struct amdgpu_ualink_exp_xa_node *exp_xa_node;
+	struct amdgpu_ualink_handle handle;
+	struct amdgpu_device *adev;
+	struct amdgpu_bo *bo;
+	u32 remote_acc_id;
+	int r;
+
+	exp_xa_node = container_of(work, struct amdgpu_ualink_exp_xa_node,
+				   cleanup_work);
+	bo = exp_xa_node->bo;
+	adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	handle = exp_xa_node->handle;
+
+	/* Revoking access to an exported memory follows the steps:
+	 * 1. Set PTE.X = 1 to retry for RPCs.
+	 * 2. Send Remote TLB Shootdowns to all importers.
+	 * 3. Unmap the NPA address from NPA VM.
+	 * 4. Drop the ref count for the BO.
+	 * 5. Send NPA_REVOKE to all importers.
+	 * 6. Wait for NPA_RELEASE from all importers.
+	 * 7. Free the NPA address once all responses are received.
+	 */
+	/* If there are no importers for this BO/handle */
+	if (bitmap_empty(exp_xa_node->importers_bitmap,
+			 AMDGPU_UALINK_ACCEL_MAX)) {
+		/* Drop the BO reference so it can be freed. */
+		amdgpu_bo_unref(&bo);
+		exp_xa_node->bo = NULL;
+		goto free_node;
+	}
+
+	dev_dbg(adev->dev,
+		"EXP-CLEANUP: handle:%llx:%llx importers bitmap: %*pbl\n",
+		handle.handle_hi, handle.handle_lo,
+		AMDGPU_UALINK_ACCEL_MAX, exp_xa_node->importers_bitmap);
+
+	bitmap_copy(orig_importers_bitmap, exp_xa_node->importers_bitmap,
+		    AMDGPU_UALINK_ACCEL_MAX);
+
+	/* Set PTE.X = 1 for NPA addresses from all importers*/
+	amdgpu_ualink_force_retry_rpcs(adev, exp_xa_node);
+
+	/* Send TLB-shootdown to all importer GPUs */
+	for_each_set_bit(remote_acc_id, exp_xa_node->importers_bitmap,
+			 AMDGPU_UALINK_ACCEL_MAX) {
+		dev_dbg(adev->dev,
+			"EXP-CLEANUP: Sending TLB-shootdown to remote:%u\n",
+			remote_acc_id);
+		r = amdgpu_ualink_send_tlb_shootdown(adev, remote_acc_id);
+		if (r)
+			dev_err(adev->dev,
+				"EXP-CLEANUP: TLB shootdown send failed to remote:%u\n",
+				remote_acc_id);
+	}
+
+	/* Unmap all NPA addresses for this BO from NPA VM */
+	amdgpu_ualink_unmap_all_npa_addr(adev, exp_xa_node);
+
+	dev_dbg(adev->dev, "EXP-CLEANUP: handle:%llx:%llx Unpin BO, pin_count:%u, importers:%u\n",
+		handle.handle_hi, handle.handle_lo, bo->tbo.pin_count,
+		bitmap_weight(orig_importers_bitmap, AMDGPU_UALINK_ACCEL_MAX));
+	WARN_ON(bo->tbo.pin_count < bitmap_weight(orig_importers_bitmap,
+						AMDGPU_UALINK_ACCEL_MAX));
+
+	/* Unpin the BO */
+	if (likely(!amdgpu_bo_reserve(bo, true))) {
+		bo->ualink_handle_lo = 0ULL;
+		for_each_set_bit(remote_acc_id, orig_importers_bitmap,
+				 AMDGPU_UALINK_ACCEL_MAX)
+			amdgpu_bo_unpin(bo);
+		amdgpu_bo_unreserve(bo);
+	} else {
+		dev_warn(adev->dev,
+			"EXP-CLEANUP: BO reserve to unpin failed for handle:%llx:%llx\n",
+			handle.handle_hi, handle.handle_lo);
+	}
+
+	/* Free the DMABuf */
+	dma_buf_put(exp_xa_node->dmabuf);
+	/* Drop the reference to the BO so it can be freed. */
+	amdgpu_bo_unref(&bo);
+	exp_xa_node->bo = NULL;
+
+	/* Send NPA-REVOKE to all importers which have imported this memory */
+	for_each_set_bit(remote_acc_id, exp_xa_node->importers_bitmap,
+				 AMDGPU_UALINK_ACCEL_MAX) {
+		imp_entry = &exp_xa_node->importer_entries[remote_acc_id];
+		if (!amdgpu_ualink_check_conn_ready(adev, remote_acc_id,
+					imp_entry->generation_count)) {
+			clear_bit(remote_acc_id,
+				  exp_xa_node->importers_bitmap);
+			continue;
+		}
+
+		dev_dbg(adev->dev,
+			"EXP-CLEANUP: Sending NPA-REVOKE to remote:%u\n",
+			remote_acc_id);
+		set_bit(remote_acc_id, exp_xa_node->npa_release_bitmap);
+		r = amdgpu_ualink_send_npa_revoke_msg(adev, remote_acc_id, handle);
+		if (r) {
+			dev_err(adev->dev,
+				"EXP-CLEANUP: NPA-REVOKE send failed to remote:%u\n",
+				remote_acc_id);
+			clear_bit(remote_acc_id, exp_xa_node->npa_release_bitmap);
+		}
+	}
+
+	if (!bitmap_empty(exp_xa_node->importers_bitmap,
+			AMDGPU_UALINK_ACCEL_MAX)) {
+		dev_dbg(adev->dev,
+			"EXP-CLEANUP: handle:%llx:%llx NPA-RELEASE bitmap: %*pbl\n",
+			handle.handle_hi, handle.handle_lo,
+			AMDGPU_UALINK_ACCEL_MAX, exp_xa_node->npa_release_bitmap);
+
+		/* Wait for the NPA_RELEASE to come back from all importers */
+		r = wait_for_completion_timeout(&exp_xa_node->npa_done,
+					msecs_to_jiffies(AMDGPU_UALINK_RESP_TIMEOUT));
+
+		if (r == 0)
+			dev_warn(adev->dev,
+				"EXP-CLEANUP: NPA-RELEASE timeout for handle:%llx:%llx\n",
+				handle.handle_hi, handle.handle_lo);
+	}
+
+	/* Free the NPA addresses given to all the importers */
+	amdgpu_ualink_free_all_npa_va(adev, exp_xa_node,
+				      orig_importers_bitmap);
+
+	/* Warn about all importers that didn't respond back with
+	 * NPA-RELEASE message. This will trigger connection timeout
+	 * handling which is added later.
+	 */
+	for_each_set_bit(remote_acc_id, exp_xa_node->npa_release_bitmap,
+			 AMDGPU_UALINK_ACCEL_MAX)
+		dev_warn(adev->dev,
+			"EXP-CLEANUP: handle:%llx:%llx NPA-RELEASE timeout from remote:%u\n",
+			handle.handle_hi, handle.handle_lo, remote_acc_id);
+
+free_node:
+	xa_erase(&adev->ualink.handle_invalid_xa, handle.handle_lo);
+	mutex_destroy(&exp_xa_node->node_lock);
+	kfree(exp_xa_node);
 }
 
 /* This function is a copy of amdgpu_dma_buf_move_notify() function.
-- 
2.55.0

