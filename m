Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8AFC624D3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 368A310EA9B;
	Mon, 31 Aug 2026 18:30:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wgocywRw";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012031.outbound.protection.outlook.com
 [40.107.200.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75AAA10EA67
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBfDXbj2mVkOj0cwf8eFiRUov3nR4g/d5SiYEg0eELAyLNLLqbOtyU5KOsAB6kdarAzVT+ARIh2GJcNGHHC+CTnJNW57yWmBVIVwaD6YDFfBQPhQhhsLHtPMys2/10CQzAYAKWjO98AuvbjWKmzv8hZ4RSB40xjbALifv226ZiUqH6m4tGzdCcSgeMS+hH5GllVlkpa/F/lA3euNxYI3KWEZewFBjxjpXiCFNf6F5FH3dxiiR1TdGxQo+tZNgTKHcpcen4qcBaLN4fcw97d5DwFKb1ErrxtsFgromApNrGwcpUHWFyRhc7OLk/IYst+ygPswcKZrSvdxSlhLMHbS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvTbtZTkyZtv9cmcf18XTDGwwx6Sr5Gv5S/vdqO1J9k=;
 b=l0duwQ5/NCWkNW/ySmQ1FXCBbb2STcEb+O8t25bTnFlp2CNKJhDgmEhnCwv6QGQHcWCyaBcXYhUHwlCZebmSnusCXXWg0cajB6Yy9lBj3fFQIOYPkduKqvoEZo4ytuJFxeORhH74pvzEZRsNDGEmXiYsZGpKCB3NLjTuMnczZ1Ax50Wq/8IFKA3qALcXIK1twyuKLJlknI+X5wo79PbjZTXNS1aVOlFWggwr5sieNv6yFaDCTw1ueIesJZdsff8KoEuqS/MAsc09xWHBsjQ2t7lTjHKxUjjCQ9pczS/MAmv8nrC/8nFIMtoYYdwNfVpyPuUgNVBONmf64S0rsgU7jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvTbtZTkyZtv9cmcf18XTDGwwx6Sr5Gv5S/vdqO1J9k=;
 b=wgocywRwzLRtBcxpiBI75SrGXsmqC+O53RV63hS7Ye+EZJJE6dLFKyxkoJqy5FXI+VOl+qBFtCUX1EoC1YQ1NEip3zQo7k/ik4DAiLAw/MFMV2Qpbs87gS5xh6xsC3BGWxa/xLgL35HgNjtQ59tTWmqL6GfdYwoe6APnGKdoMds=
Received: from BN9PR03CA0662.namprd03.prod.outlook.com (2603:10b6:408:10e::7)
 by SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:10 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::26) by BN9PR03CA0662.outlook.office365.com
 (2603:10b6:408:10e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:29:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:29:03 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:29:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 88/95] drm/amdgpu: Cleanup UALink XA entries on manager stop
Date: Mon, 31 Aug 2026 14:27:47 -0400
Message-ID: <20260831182754.1089811-89-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 38b5267b-57d3-48fa-9dac-08df078dc059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|3023799007|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: dIsQkb0lHTH/UYkj1zlQGeiIF7BOdmP+xgGAOKNwemhGAM2ansxaZlUNh44iuTzl7Ad2kkKVuKG8sh1zD9N2yWoevvVrc4R+nmMTEiVEc7y46Fmjrr/tZnDIbQamHyCy6c2zBIQTvWJVLrRiNT9ZCO18jc/ysUskCH/ovRijBZShn7g2GtUzu3I3M/W7yGSkcer5daKQ3UfF7qNaSjQQSSDkesGmRfU7XBi9+EmK5o4R92LXyQPWvYlLMhG7wJj2Y4d/0IP1EgU09CGvLb4sqcu2zEXHv1DXKVq6RcBQNvxbVa7IaKy2695kAuxs5f8coq1dM+dTWsn+tuzSYQTFhonEToFcgmA2os/dIQ/FzPLZ7wva6Kngq089X8l0qM56VPmnLUk2RQ/4uDC2NYIvJIgezI1BJaMh44yCJCN5VArkIha/DdJFNNj8VS6uw1WjNF4nCw8KvAm9NCt1S9TfptWCUqSBXNNPNEjnjOy7ln2Jjx1jH7IVBHrWY9LqLq0gmgRt1Br7TgC1UloYBh/6vu2ZTfaxq0QFEuG1Qr54rKQ0czU8q+txO/MCaif//Q48AG2wsUTJcnVigCNkm6wiZTN/nfyLpziltY3VJ9fCefr9dBCMhrT5+H0UOthQTSNZ+HlIscTG3MDMB4aQOv6FoECnLjXndeESlyZSN4cMrtbaioD/0PCiXVlUz2yPxB0mXi+h1hZV+88Eyr3FTlpWLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(3023799007)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x/g3n4RureV8ph5N0GhUla5mtRFvnKTfocEAtwEed+MhGM7IhI5toBveyCLYf44AWl1DwIviEE/G7aCoTcWubIDW9YM++AqiqjCKZ9ZlCOxXw9VDk9B6nv2l+OZhsVvBfUwdGEuQgfv/ek2q91mHwjqRqWPzapjfTBlXGFyFDen5su5Q1eimcMfZwBlQ+ypRqYp9gvFD8ajQDEOeuZkUvxceT0zJxAenuHVdF+i0y//TkF1kM/pxpmeb+CWzxEZc4MRqP+PAbSYyLu/SyuD/1bRjJfWlhuIkFIrxYui1Ih5UeAjsk+IpGRN3Pjx/RWNas1GUx+TlPVqqBcQ/JkivFpfQt1w9mVWgNuL64rdg9nGuvbit9nFAVD0Q8oWaKfmf8KQL22ZV+2bk2N+IvkNvfF63eJojBnJR4BXoHQdLG2wZ+ftArh5uEiufmWYS2oeC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:10.8350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b5267b-57d3-48fa-9dac-08df078dc059
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830
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

amdgpu_ualink_manager_stop() only called xa_destroy() on the exporter,
importer and handle-invalid xarrays, which frees the internal tree but
not the node objects. Entries still present at teardown thus leaked the
nodes, left NPA addresses mapped and kept exported BOs pinned.

Free the entries in all three xarrays explicitly, without exchanging any
NPA protocol messages (the F/W is already halted by
amdgpu_ualink_sw_fini()): mark connections down so the drained workers
and teardown take the message-free path, drain in-flight exporter
cleanup work to empty handle_invalid_xa, then free the remaining
importer and exporter entries before the NPA allocator is torn down.

Also factor the shared importer-node release into
amdgpu_ualink_release_imp_xa_node(), drop/drain stale remote interrupts
in the IRQ handler when the accelerator is not ACTIVE, and refuse outbound
messages in amdgpu_ualink_send_command() when not ACTIVE so an in-flight
cleanup worker cannot emit onto torn-down peer/SDMA state or block
waiting for a response that will never arrive.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 153 +++++++++++++++++++--
 1 file changed, 141 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 7d2acf10123bc..d7d74b1ae7fc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -2205,12 +2205,33 @@ static int amdgpu_ualink_setup_connection(struct amdgpu_device *adev,
 	return r;
 }
 
+/* Invalidate an importer node's mappings and drop its last ref (frees the
+ * node, dma-buf and GEM handle). Caller must have unlinked it from the
+ * per-remote list and must not hold the imp_xa lock.
+ */
+static void amdgpu_ualink_release_imp_xa_node(struct amdgpu_device *adev,
+				struct amdgpu_ualink_imp_xa_node *imp_xa_node)
+{
+	struct amdgpu_bo *bo;
+
+	dev_dbg(adev->dev,
+		"IMP-CLEANUP: handle:%llx:%llx npa:%llx size:%llx\n",
+		imp_xa_node->handle.handle_hi, imp_xa_node->handle.handle_lo,
+		imp_xa_node->npa_addr, imp_xa_node->size);
+
+	if (imp_xa_node->dmabuf) {
+		bo = gem_to_amdgpu_bo(imp_xa_node->dmabuf->priv);
+		amdgpu_ualink_invalidate_import_mappings(bo);
+	}
+
+	amdgpu_ualink_imp_xa_entry_put(imp_xa_node);
+}
+
 static void amdgpu_ualink_cleanup_imp_xa_entries(struct amdgpu_device *adev,
 						 u32 remote_acc_id)
 {
 	struct amdgpu_ualink_imp_xa_node *imp_xa_node;
 	struct list_head *imp_handles_list;
-	struct amdgpu_bo *bo;
 
 	dev_dbg(adev->dev,
 		"IMP-RESET: Cleaning up all XA entries for remote:%u\n",
@@ -2226,18 +2247,8 @@ static void amdgpu_ualink_cleanup_imp_xa_entries(struct amdgpu_device *adev,
 		WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_TEARDOWN);
 		xa_unlock(&adev->ualink.imp_xa);
 
-		dev_dbg(adev->dev,
-			"IMP-RESET: remote:%u handle:%llx:%llx npa:%llx size:%llx\n",
-			remote_acc_id, imp_xa_node->handle.handle_hi,
-			imp_xa_node->handle.handle_lo,
-			imp_xa_node->npa_addr, imp_xa_node->size);
-
-		bo = gem_to_amdgpu_bo(imp_xa_node->dmabuf->priv);
-		/* Invalidate the imported mappings */
-		amdgpu_ualink_invalidate_import_mappings(bo);
+		amdgpu_ualink_release_imp_xa_node(adev, imp_xa_node);
 
-		/* Drop the refcount for the node */
-		amdgpu_ualink_imp_xa_entry_put(imp_xa_node);
 		xa_lock(&adev->ualink.imp_xa);
 	}
 	xa_unlock(&adev->ualink.imp_xa);
@@ -3860,13 +3871,114 @@ int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
 	return r;
 }
 
+/* Free every importer entry left in imp_xa at manager stop. */
+static void amdgpu_ualink_teardown_imp_xa_entries(struct amdgpu_device *adev)
+{
+	struct amdgpu_ualink_imp_xa_node *imp_xa_node;
+	unsigned long index;
+
+	xa_for_each(&adev->ualink.imp_xa, index, imp_xa_node) {
+		list_del_init(&imp_xa_node->list);
+		WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_TEARDOWN);
+		amdgpu_ualink_release_imp_xa_node(adev, imp_xa_node);
+	}
+}
+
+/* Free a single exporter node at manager stop. This is the message-free
+ * portion of amdgpu_ualink_exp_cleanup_worker().
+ */
+static void amdgpu_ualink_teardown_exp_xa_node(struct amdgpu_device *adev,
+				struct amdgpu_ualink_exp_xa_node *exp_xa_node)
+{
+	DECLARE_BITMAP(importers_bitmap, AMDGPU_UALINK_ACCEL_MAX);
+	struct amdgpu_bo *bo = exp_xa_node->bo;
+	u32 remote_acc_id;
+
+	bitmap_copy(importers_bitmap, exp_xa_node->importers_bitmap,
+		    AMDGPU_UALINK_ACCEL_MAX);
+
+	dev_dbg(adev->dev,
+		"EXP-STOP: handle:%llx:%llx importers bitmap: %*pbl\n",
+		exp_xa_node->handle.handle_hi, exp_xa_node->handle.handle_lo,
+		AMDGPU_UALINK_ACCEL_MAX, importers_bitmap);
+
+	if (!bitmap_empty(importers_bitmap, AMDGPU_UALINK_ACCEL_MAX)) {
+		amdgpu_ualink_unmap_all_npa_addr(adev, exp_xa_node);
+
+		/* Unlink importers and unpin the BO once per importer. */
+		if (likely(!amdgpu_bo_reserve(bo, true))) {
+			bo->ualink_handle_lo = 0ULL;
+			for_each_set_bit(remote_acc_id, importers_bitmap,
+					 AMDGPU_UALINK_ACCEL_MAX) {
+				list_del_init(&exp_xa_node->importer_entries[remote_acc_id].list);
+				amdgpu_bo_unpin(bo);
+			}
+			amdgpu_bo_unreserve(bo);
+		} else {
+			dev_warn(adev->dev,
+				"EXP-STOP: BO reserve to unpin failed handle:%llx:%llx\n",
+				exp_xa_node->handle.handle_hi,
+				exp_xa_node->handle.handle_lo);
+			for_each_set_bit(remote_acc_id, importers_bitmap,
+					 AMDGPU_UALINK_ACCEL_MAX)
+				list_del_init(&exp_xa_node->importer_entries[remote_acc_id].list);
+		}
+
+		amdgpu_ualink_free_all_npa_va(adev, exp_xa_node, importers_bitmap);
+	}
+
+	/* Release the export dma-buf and drop the BO ref. */
+	dma_buf_put(exp_xa_node->dmabuf);
+	amdgpu_bo_unref(&bo);
+	exp_xa_node->bo = NULL;
+
+	mutex_destroy(&exp_xa_node->node_lock);
+	kfree(exp_xa_node);
+}
+
+/* Free every exporter entry left in exp_xa at manager stop. These were
+ * exported but never revoked, so no cleanup worker was queued for them.
+ */
+static void amdgpu_ualink_teardown_exp_xa_entries(struct amdgpu_device *adev)
+{
+	struct amdgpu_ualink_exp_xa_node *exp_xa_node;
+	unsigned long index;
+
+	xa_for_each(&adev->ualink.exp_xa, index, exp_xa_node) {
+		xa_erase(&adev->ualink.exp_xa, index);
+		amdgpu_ualink_teardown_exp_xa_node(adev, exp_xa_node);
+	}
+}
+
 void amdgpu_ualink_manager_stop(struct amdgpu_device *adev)
 {
 	int i;
 
 	adev->mmhub.funcs->setup_vm_pt_regs(adev, adev->vm_manager.npa_vmid, 0);
+
+	/* Mark connections down so the drained workers and the teardown below
+	 * take the message-free path in amdgpu_ualink_check_conn_ready().
+	 */
+	for (i = 0; i < AMDGPU_UALINK_ACCEL_MAX; i++) {
+		mutex_lock(&adev->ualink.conn_state[i].lock);
+		adev->ualink.conn_state[i].state = AMDGPU_UALINK_CONN_NOT_READY;
+		mutex_unlock(&adev->ualink.conn_state[i].lock);
+	}
+
+	/* Drain in-flight exporter cleanup work so revoked nodes in
+	 * handle_invalid_xa free themselves and empty that xarray.
+	 */
+	drain_workqueue(adev->ualink.npa_wq);
+
+	/* Free live entries before the NPA allocator is torn down, so NPA
+	 * addresses can still be unmapped and freed.
+	 */
+	amdgpu_ualink_teardown_imp_xa_entries(adev);
+	amdgpu_ualink_teardown_exp_xa_entries(adev);
+
 	amdgpu_ualink_npa_mm_fini(adev);
 
+	/* All three xarrays are empty by now. */
 	xa_destroy(&adev->ualink.exp_xa);
 	xa_destroy(&adev->ualink.imp_xa);
 	xa_destroy(&adev->ualink.handle_invalid_xa);
@@ -5177,6 +5289,10 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
 	u64 src;
 	int r;
 
+	/* Refuse sends unless active */
+	if (adev->ualink.info->accel_state != AMDGPU_UALINK_ACCEL_STATE_ACTIVE)
+		return -ESHUTDOWN;
+
 	peer = &remote->peer[remote_accel_id];
 
 	/*
@@ -5734,6 +5850,7 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
 				     struct amdgpu_iv_entry *entry)
 {
 	u32 sender_acc_id, receiver_acc_id, msg_type, src_acc_id;
+	enum amdgpu_ualink_accel_state accel_state;
 	struct amdgpu_ualink_handle handle;
 	u32 size, npa_addr, fail_reason;
 	u32 dw0, dw1, dw2, dw3;
@@ -5746,6 +5863,18 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
 		return handled;
 	}
 
+	/* Only handle interrupts while ACTIVE. Otherwise (e.g. during teardown)
+	 * consume stale ring entries but drop them, so they don't touch state
+	 * being freed.
+	 */
+	accel_state = adev->ualink.info->accel_state;
+	if (accel_state != AMDGPU_UALINK_ACCEL_STATE_ACTIVE) {
+		dev_dbg(adev->dev,
+			"Dropping stale UALink interrupt, accel_state %d\n",
+			accel_state);
+		return handled;
+	}
+
 	dev_dbg(adev->dev, "%s client_id 0x%x src_id 0x%x ih\n",
 		entry->ih == &adev->irq.ih ? "ring" : "ualink soft ring",
 		entry->client_id, entry->src_id);
-- 
2.55.0

