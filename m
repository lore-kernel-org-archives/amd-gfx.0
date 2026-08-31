Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D1FC79F81
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5308D10EA90;
	Mon, 31 Aug 2026 18:29:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RuymU+Bo";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3D0C10E50F
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pp56vGAG1Tcc+GhoQqcyivbN3uSsJgRDgtrH5PlGovQukmSh/AidBCW8dfK9LrT+C6VP0XL8fFeYwXnTPTqUtFLW5/F+nj7uud8/UxNdNutisqGBWTgs9D1exB6cctnLt63sFytQ7dMnOyIEQ/CDKF8a8YSqsA/fhTVA/kmUtCb4XRTMTSyqRpffvj5AJ4xUnoiJ/mP9FcUZlepjL3AecV04Jgczb/6VvzsfmUwsOtjHZJJkWjx5GEqFx96iZNO7N8kKODkloldRLT3Al7nygpnW/C+mMbXu5ucHy98byW3hEZqTX/NIMWo+RQbsIKJoR1VdDJe5w/vzo4wFX6kvGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KH6kzedeKc3tMMabX4DN3eG2ntVOU4nhXsvRo0jUvc0=;
 b=WWXXPtmScPQt4MXADR9/CAAtZVptRhvOGWYAUQPSse08jmFmvBrRGcdywljdVsGKeQlVGHOTMDfhm3B8Kg+fZnCi9VKH6Vj3aWwOD2TXz4pXzE94r/jhaU8KFubxDYT31GDZCpMoPxNpl6WQApvGg7c/zk/trU+THC9Vj0mjCNxBswUUua+WE6//p30YxVY8EvgHYG0exe7bchBWqfI0xQBasTi9494P8kyVWVafOKmERRjpujw+MQEnTMprXLxXF25G9Woswq9QEGKlYb04uRIpWIZgtwyKyj/DUidbWMqQr+51YzI89n9eqmNfEUbVopajDXMH6DEz/Z3/k4Jfpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KH6kzedeKc3tMMabX4DN3eG2ntVOU4nhXsvRo0jUvc0=;
 b=RuymU+Bof0LXbpna71L3nZJ9bTZdVko4Q4i7XSTZrg/zfzSrbCNa3PVF7DTUA2D6YwJD3aSlkTUh38n4lU/d6l+7Gu9zCdwDM/CMxtJTR5G7j38Nlorfe7BCXQ01jKqI1u7R+CbgqHIrvVGpOM5+JWIPQyzAR7U2bHIBgE6M7Qo=
Received: from CH0PR04CA0106.namprd04.prod.outlook.com (2603:10b6:610:75::21)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:50 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::2e) by CH0PR04CA0106.outlook.office365.com
 (2603:10b6:610:75::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:39 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 52/95] drm/amdgpu: Cleanup exported UALink handles
Date: Mon, 31 Aug 2026 14:27:11 -0400
Message-ID: <20260831182754.1089811-53-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: d5548f87-a3ff-4baa-6d4e-08df078db44a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|56012099006|10067099003|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BnxjmGBIJ0MFGAD+RdKK/fzwEEu1KBlnMb8cFno3pxaRdroIb9JZDxpNP1tayGFsY4X/HEzK4ER4Y5+huY9enrZlROMwklQo6+JfyhBFuB393epVSf58q2hVJfL4EV7GhLoDZO8pCF0CABKiT9va9tpWdfEpPjFw0aQNl5Sk7m3EeOW4E5N0+9bYAR1LXebnRYvwKsBH3KSI3wkCxPrO+eAqjSotB7LZmhs/qLW67SaYfKghwO2UxDYesRcRrT08Jk0VMEHxC79Qos1uPIc9xLaJNnsyPgnloX2gmAE5D+893GZ8reVYupBTCB3hgbJ3MXWdq+Lv10swhPABdnPwXhh1UJ60kxRi6CeK/3XN++pTvK+0LSGKf6aEa8vtCEykXhAPiRMAPjIDSKHPNvxtdPQNDQayU2ISeA05v8ZIZT6277Z+vTMt5GX3Yk00ghBoU9J4t9yNzSHJfSraJWUdoKWcZ49WEqWz/I/4REq+OB80YREFWRTAmvSM9k9xhFAx6HRCFnFRwBlTYPgLKv27r7KsrAbcJfdCxhMrYnz+PY9UHtrAj0m4GpUjTs+9HL0tufY2E2RtNOXPV0gSH2kYZ5YPX/S11qgoKQapj2lbuqVbMc/+bPzQus8NPhHjjBGfpBfs9EERIechwTQy744Qvpc/Nxux48yP6FFhZWJ89/oOYSOmsxqRgil+tgFgWts4HzMSKbHexLZvPDlzHGgoGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: foXWLbQoAeqqWCvqFb2y+hj1S+nL5VW+pqxPL880nZJNrwuEBIAN/9hi8inpOtATcCl9d5fmvRrz95KXkVT5EgBnHEn8B95BrjCk1QS3CcMPyaWHOKJeGIW9UJSIjtc3XpWrMfAr85F59EZkX+kPjUqpb1w+H95zq9Z99EdYm96aHu45bwMN6hsXJoeNsMbXBLdqR2F/hXbXQ6zSoLXICFsbsE+NKI4KY9rDKq1BL22a4d9KoS0Wooa4kWAkcLmC0xW6xbTjhBCSG/w1Bwqz5Kou22Z1jMCtk958/6oDVh1L30owHnj14HzTQm02841mVJgXZjRfwR9RVZ9VBKtY3Lef5GTkAGjbJ8IETWAvdn0pSxKd36jenfJJYCnVHsB35ghfORBtZZ98GuY2A9QE0rMf+zXtBO/xkZKcKoE7/eKtQwVSugTs0WkqoXY1mAhZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:50.5934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5548f87-a3ff-4baa-6d4e-08df078db44a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
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
index 82a362e44a3fe..d87b66d1d51d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1272,6 +1272,13 @@ static void amdgpu_generate_ualink_handle(struct amdgpu_device *adev,
 
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
@@ -1751,8 +1758,344 @@ static int amdgpu_ualink_setup_connection(struct amdgpu_device *adev,
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

