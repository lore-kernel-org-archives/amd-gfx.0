Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C088EC5DF97
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 311A110F485;
	Fri, 21 Aug 2026 19:53:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="muHL0JNN";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD1310F47B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:53:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3sZaBFSPPuUfamUYa0/hVKdgjBzmEQEQ8lwK7HtMaBT25wrphUgCyE+0RnbsjjA1xn7YpDeYT0fX/Z8noxqQ67EfVY8o6ySK8fGL6vrXCRqHrlnU8jA0pW5qlLwm1VR5Zu9OfnHF+TKO4lHemy3x+WR2jlN8kJTrLjKt9HVEBp8i8/LuUNGBAnbOisMn1ofZ9mTIhn+mlxVeuMgSEofzGPQOFixXg1tkU+qSvoToIU7HGAaOHnezs/N3Yto1I8JNWRrZvDr9lXXtrjry/Vhw0aljjdGK5pZthXq29Easp/JPZw1nM3lUCXWI3HfQLyOmS5K7fyPh0qu/ogzVkat7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZgaFR8hRgHKFYDRqiIkd2UAVQoTa3Hf96pWyBIcCrU=;
 b=jPyhZTqK1OiYthDmFDaOV2G1jsPdP+CnTTU1Xc0lOiynYfVDl9A1s0eJafNfg3B+9e9XNjc/98D1dnKyTc8jewaKDfWWz5u5KpCmZf45IMg8QAOb29Jabq4MSKcsJK3YF/VOIuJzOSEiMIvAODin0sbxEKABEpQ6Ce4urPObb7dW0BZfHhW1juOaTWiGQjMyUF6VcjXPZY0/3yhaEhEq1uCv+P3WobObCnEc3ecMmjoKf8IkrR4xbWmQbLG46Dtj1RDh9kUkijAoIvnkGoVbq2RxqdO2ivEgd9j1M0EYryaLzgmZg3Mn7CWBaVqSncAS0z8/kHuPyN+ysEFXYIE38Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZgaFR8hRgHKFYDRqiIkd2UAVQoTa3Hf96pWyBIcCrU=;
 b=muHL0JNNlplu+gxjFppakkQmUa82xBssycMLXlSPhIXJ/NXcN1J8ffVs569fttm/tL1wSkn9UcDKx/r/Heco3KQUC5tzua2rYVn93AbjcHPQkjNFQ3KpmgZDEf4UVtCt2BhXfM8mYioGfcQ4Dq6bTJiSrL8jzxCBp3io2NmND7M=
Received: from CY5PR19CA0070.namprd19.prod.outlook.com (2603:10b6:930:69::16)
 by IA1PR12MB6457.namprd12.prod.outlook.com (2603:10b6:208:3ab::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:52 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::6f) by CY5PR19CA0070.outlook.office365.com
 (2603:10b6:930:69::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:42 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:42 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 50/95] drm/amdgpu: Implement mechanism to revoke exported
 memory
Date: Fri, 21 Aug 2026 15:34:13 -0400
Message-ID: <20260821193458.808626-51-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|IA1PR12MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d64ab4-f68c-407f-9aef-08deffbb6884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|11063799006|10067099003|22082099003|18002099003|3023799007|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: eSJj/mhnKplCr6jinDyIeTC9qqf6rjy1GD8eZzRomZ1I1RE8ZFXUdgLyexvX80aU4X4eQeKFQOy9rFEinkD9SSOm9uze1vE8hsLHfSdFtaPRb/J/20tee6iLDMkpRO3HDLymc6GuY7C7fpnxKT9oYVtYxT5+dcIYcsY9diSohr+T4zlrSyYjuOzA7zlsYwXX1Mc5TNz+Fut87wBCPiuKcxYVKCyb2e1nc8pg2G9nqZP1gLvn9yOafWQZHslTFZ74XCDUcCzDObq9CgecxLV6+jIXM4AgtvCPJf42DvDAGGRedIfI849M98PY78Mv8rB7t3hCtJfTMqFY0cKztwJJCMI7SihtpRQgSK1DWeiYmdzbkOmqe8Z2r2hEwQILlIYsIum+wC07NYd5c/cMutua11q3ixpOpX+Ul+tUoZ/7WpR/nh9As0NEXtbQ1rnoq25PJIF5EBE35ZKRVRMdEbfX8YsrKdM4ZRh2Vk+E4/r95yQXnyP02Xm37DNtNkgJVE+5WAPSc0VzSKJnkw3nB5Uccx9c79oPiZmGQ2RiR/aT3a65qDM5vhkoGxOXdCdv5RdZhaB2qxk5evzbI/2ucO3wtEjImCTz3IWq24TfH0PC2EVbr+vQpxc8bU0dl9vwS4o7Y5Me37V3LH7I8e1nLkZEbf/oEiE8LbK+rk3PPmxh4MikUn5RDkjTfBE5iMpnk8m9l5oMCkx5/bW9RIa9QkYIQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007)(56012099006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YTEKh/cyPtlrBzz+QkEHVuQSV0CcNdDIa94ss6wWZFZG7QrpiWMap0GvfNNw3l23oJuA23ISGxwSV49u+VzyuHNs67uY/paW/+XHc2M3uPeaFg3vqtQ8ylE7dB9AAQVLnpICotwLSNOFItMdG4PQKPZYm0n68pAWmlOiKIoGimy0MZHmonn9hWOOoRuMz2xltfjzCqzmtQsjtX418/JUsw7iZnWOHfQkjz28fMh1rrGHvnKa65WvB60EouT3acvIzgy5Ietxsecd5gZaLI7syS8U+wN2p4EcE0qjXVllNEFSNJCY42p8941F8k9X+x95yQVHrUwHHXBLRPEd4mi/qC7znWTWTFaC6757jg5QV9K5t5LDCdO7dfu6NDvqA3KwIpXu68ky5s8AHyqw7Yq16i4Gi2u+JH7/QUaJwfVLeluOqmSrJ4tDDbbAWaTprxK7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:50.9832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d64ab4-f68c-407f-9aef-08deffbb6884
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6457
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

This patch adds implementation to revoke exported memory.
The exporter GPU will send a NPA-REVOKE message to inform the
importer GPUs to stop using the exported memory. Once the importers
stop using the exporter memory, they would send back a NPA-RELEASE
message to inform the exporters to free the exporter memory.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 249 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |   3 +
 2 files changed, 252 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 60080271b3bd0..d4e3a44252e36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1251,6 +1251,48 @@ static void amdgpu_ualink_imp_xa_entry_put(struct amdgpu_ualink_imp_xa_node *imp
 	kref_put(&imp_xa_node->refcount, amdgpu_ualink_cleanup_imp_xa_node);
 }
 
+static int amdgpu_ualink_send_npa_release_msg(struct amdgpu_device *adev,
+				    u32 remote_acc_id,
+				    struct amdgpu_ualink_handle handle)
+{
+	u32 dw0, dw1, dw2, dw3;
+
+	dw0 = lower_32_bits(handle.handle_lo);
+	dw0 &= ~AMDGPU_UALINK_MESSAGE_HEADER_MASK;
+	dw0 |= AMDGPU_UALINK_NPA_RELEASE_MSG;
+
+	dw1 = upper_32_bits(handle.handle_lo);
+	dw2 = lower_32_bits(handle.handle_hi);
+	dw3 = upper_32_bits(handle.handle_hi);
+
+	dev_dbg(adev->dev, "SEND NPA-RELEASE: remote_acc_id %u handle %llx:%llx dw[0-3] 0x%x 0x%x 0x%x 0x%x\n",
+		remote_acc_id, handle.handle_hi, handle.handle_lo, dw0, dw1, dw2, dw3);
+
+	return amdgpu_ualink_remote_interrupt(adev, remote_acc_id, dw0, dw1,
+					      dw2, dw3);
+}
+
+static int amdgpu_ualink_send_npa_revoke_msg(struct amdgpu_device *adev,
+					u32 remote_acc_id,
+					struct amdgpu_ualink_handle handle)
+{
+	u32 dw0, dw1, dw2, dw3;
+
+	dw0 = lower_32_bits(handle.handle_lo);
+	dw0 &= ~AMDGPU_UALINK_MESSAGE_HEADER_MASK;
+	dw0 |= AMDGPU_UALINK_NPA_REVOKE_MSG;
+
+	dw1 = upper_32_bits(handle.handle_lo);
+	dw2 = lower_32_bits(handle.handle_hi);
+	dw3 = upper_32_bits(handle.handle_hi);
+
+	dev_dbg(adev->dev, "SEND NPA-REVOKE: remote_acc_id %u handle %llx:%llx dw[0-3] 0x%x 0x%x 0x%x 0x%x\n",
+		remote_acc_id, handle.handle_hi, handle.handle_lo, dw0, dw1, dw2, dw3);
+
+	return amdgpu_ualink_remote_interrupt(adev, remote_acc_id, dw0, dw1,
+					      dw2, dw3);
+}
+
 static int amdgpu_ualink_send_npa_fail_msg(struct amdgpu_device *adev,
 				    u32 remote_acc_id,
 				    struct amdgpu_ualink_handle handle,
@@ -1666,6 +1708,78 @@ static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
 {
 }
 
+/* This function is a copy of amdgpu_dma_buf_move_notify() function.
+ * amdgpu_dma_buf_move_notify is only called for import attachments.
+ * But NPA DMABufs don't use attachments because they are imported
+ * on the same device. So we need to invalidate the GPUVM mappings
+ * manually.
+ */
+static void amdgpu_ualink_invalidate_import_mappings(struct amdgpu_bo *bo)
+{
+	struct drm_gem_object *obj = &bo->tbo.base;
+	struct ww_acquire_ctx *ticket = dma_resv_locking_ctx(obj->resv);
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	struct ttm_operation_ctx ctx = { false, false };
+	struct ttm_placement placement = {};
+	struct amdgpu_vm_bo_base *bo_base;
+	int r;
+
+	amdgpu_bo_reserve(bo, false);
+
+	/* FIXME: This should be after the "if", but needs a fix to make sure
+	 * DMABuf imports are initialized in the right VM list.
+	 */
+	amdgpu_vm_bo_invalidate(bo, false);
+	if (!bo->tbo.resource || bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
+		goto out;
+
+	r = ttm_bo_validate(&bo->tbo, &placement, &ctx);
+	if (r) {
+		dev_err(adev->dev, "Failed to invalidate NPA DMA-buf import (%d)\n",
+			r);
+		goto out;
+	}
+
+	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
+		struct amdgpu_vm *vm = bo_base->vm;
+		struct dma_resv *resv = amdkcl_ttm_resvp(&vm->root.bo->tbo);
+
+		if (ticket) {
+			/* When we get an error here it means that somebody
+			 * else is holding the VM lock and updating page tables
+			 * So we can just continue here.
+			 */
+			r = dma_resv_lock(resv, ticket);
+			if (r)
+				continue;
+
+		} else {
+			/* TODO: This is more problematic and we actually need
+			 * to allow page tables updates without holding the
+			 * lock.
+			 */
+			if (!dma_resv_trylock(resv))
+				continue;
+		}
+
+		/* Reserve fences for two SDMA page table updates */
+		r = dma_resv_reserve_fences(resv, 2);
+		if (!r)
+			r = amdgpu_vm_clear_freed(adev, vm, NULL);
+		if (!r)
+			r = amdgpu_vm_handle_moved(adev, vm, ticket);
+
+		if (r && r != -EBUSY)
+			dev_err(adev->dev, "Failed to invalidate VM page tables (%d))\n",
+				r);
+
+		dma_resv_unlock(resv);
+	}
+
+out:
+	amdgpu_bo_unreserve(bo);
+}
+
 static int amdgpu_ualink_map_npa_to_dmabuf(struct amdgpu_device *adev,
 				struct amdgpu_ualink_imp_xa_node *imp_xa_node)
 {
@@ -1746,6 +1860,141 @@ static int amdgpu_ualink_map_npa_to_dmabuf(struct amdgpu_device *adev,
 	return r;
 }
 
+void amdgpu_ualink_revoke_exported_memory(struct amdgpu_bo *bo)
+{
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	struct amdgpu_ualink_importer_entry *imp_entry;
+	struct amdgpu_ualink_exp_xa_node *exp_xa_node;
+	u32 remote_acc_id;
+	int r;
+
+	if (!bo->ualink_handle_lo)
+		return;
+
+	/* Remove the entry from the Xarray. */
+	xa_lock(&adev->ualink.exp_xa);
+	exp_xa_node = __xa_erase(&adev->ualink.exp_xa,
+				 bo->ualink_handle_lo);
+	if (!exp_xa_node) {
+		xa_unlock(&adev->ualink.exp_xa);
+		dev_warn(adev->dev,
+			 "Exp XA: handle_lo:%llx not found\n",
+			 bo->ualink_handle_lo);
+		return;
+	}
+
+	for_each_set_bit(remote_acc_id, exp_xa_node->importers_bitmap,
+			 AMDGPU_UALINK_ACCEL_MAX) {
+		imp_entry = &exp_xa_node->importer_entries[remote_acc_id];
+		list_del_init(&imp_entry->list);
+	}
+	xa_unlock(&adev->ualink.exp_xa);
+
+	/* Add it to the Handle_Invalid xarray */
+	r = xa_err(xa_store(&adev->ualink.handle_invalid_xa,
+			    bo->ualink_handle_lo,
+			    exp_xa_node, GFP_KERNEL));
+	if (r)
+		dev_err(adev->dev,
+			"Handle_Invalid XA store failed handle:%llx:%llx error:%d\n",
+			exp_xa_node->handle.handle_hi,
+			exp_xa_node->handle.handle_lo, r);
+
+	amdgpu_ualink_exp_xa_entry_put(exp_xa_node);
+}
+
+static void amdgpu_ualink_process_npa_release_msg(struct amdgpu_device *adev,
+						 u32 remote_acc_id,
+						 struct amdgpu_ualink_handle handle)
+{
+	struct amdgpu_ualink_exp_xa_node *exp_xa_node;
+
+	xa_lock(&adev->ualink.handle_invalid_xa);
+	exp_xa_node = xa_load(&adev->ualink.handle_invalid_xa, handle.handle_lo);
+	if (!exp_xa_node) {
+		dev_warn(adev->dev,
+			 "NPA-RELEASE: Handle (%llx:%llx) not found\n",
+			 handle.handle_hi, handle.handle_lo);
+		goto out;
+	}
+
+	/* Confirm that the complete handle matches. */
+	if (handle.handle_hi != exp_xa_node->handle.handle_hi) {
+		dev_warn(adev->dev,
+			 "NPA-RELEASE: handle_hi mismatch exp:%llx got:%llx:%llx remote:%u\n",
+			 exp_xa_node->handle.handle_hi,
+			 handle.handle_hi, handle.handle_lo, remote_acc_id);
+		goto out;
+	}
+
+	/* Test and clear the bit corresponding to the remote GPU id to signal
+	 * the arrival of NPA_RELEASE message from it.
+	 * If the corresponding bit wasn't set, then raise a warning and ignore
+	 * the NPA-Release message from the remote GPU.
+	 */
+	if (!test_and_clear_bit(remote_acc_id, exp_xa_node->npa_release_bitmap)) {
+		dev_warn(adev->dev,
+			 "NPA-RELEASE: unexpected from remote:%u handle:%llx:%llx\n",
+			 remote_acc_id, handle.handle_hi, handle.handle_lo);
+		goto out;
+	}
+
+	/* Signal completion if NPA_Release received from all importers */
+	if (bitmap_empty(exp_xa_node->npa_release_bitmap,
+			 AMDGPU_UALINK_ACCEL_MAX))
+		complete(&exp_xa_node->npa_done);
+
+out:
+	xa_unlock(&adev->ualink.handle_invalid_xa);
+}
+
+static void amdgpu_ualink_process_npa_revoke_msg(struct amdgpu_device *adev,
+						u32 remote_acc_id,
+						struct amdgpu_ualink_handle handle)
+{
+	struct amdgpu_ualink_imp_xa_node *imp_xa_node;
+	struct amdgpu_bo *bo;
+	int r = 0;
+
+	/* Remove the entry from the Xarray. */
+	xa_lock(&adev->ualink.imp_xa);
+	imp_xa_node = xa_load(&adev->ualink.imp_xa, handle.handle_lo);
+	if (!imp_xa_node) {
+		xa_unlock(&adev->ualink.imp_xa);
+		dev_warn(adev->dev,
+			 "NPA-REVOKE: Handle (%llx:%llx) not found\n",
+			 handle.handle_hi, handle.handle_lo);
+		return;
+	}
+
+	/* Confirm that the complete handle matches. */
+	if (handle.handle_hi != imp_xa_node->handle.handle_hi) {
+		xa_unlock(&adev->ualink.imp_xa);
+		dev_warn(adev->dev,
+			 "NPA-REVOKE: handle_hi mismatch exp:%llx got:%llx:%llx remote:%u\n",
+			 imp_xa_node->handle.handle_hi,
+			 handle.handle_hi, handle.handle_lo, remote_acc_id);
+		return;
+	}
+
+	WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_TEARDOWN);
+	list_del_init(&imp_xa_node->list);
+	xa_unlock(&adev->ualink.imp_xa);
+
+	/* Invalidate the GPUVM mappings */
+	bo = gem_to_amdgpu_bo(imp_xa_node->dmabuf->priv);
+	amdgpu_ualink_invalidate_import_mappings(bo);
+
+	/* Drop the refcount for the node */
+	amdgpu_ualink_imp_xa_entry_put(imp_xa_node);
+
+	r = amdgpu_ualink_send_npa_release_msg(adev, remote_acc_id, handle);
+	if (r)
+		dev_err(adev->dev,
+			"NPA-Release send failed remote:%u handle:%llx:%llx error:%d\n",
+			remote_acc_id, handle.handle_hi, handle.handle_lo, r);
+}
+
 static void amdgpu_ualink_process_npa_fail_msg(struct amdgpu_device *adev,
 				       u32 remote_acc_id, u64 partial_handle,
 				       u32 fail_reason)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 9d5d24a2a1106..0c2c5fad867af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -72,6 +72,8 @@ enum AMDGPU_UALINK_PROTOCOL_MESSAGES {
 	AMDGPU_UALINK_NPA_REQ_MSG			= 3,
 	AMDGPU_UALINK_NPA_RSP_MSG			= 4,
 	AMDGPU_UALINK_NPA_FAIL_MSG			= 5,
+	AMDGPU_UALINK_NPA_REVOKE_MSG			= 6,
+	AMDGPU_UALINK_NPA_RELEASE_MSG			= 7,
 	AMDGPU_UALINK_MAX_PROTOCOL_MSG
 };
 
@@ -350,4 +352,5 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
 int amdgpu_ualink_import_handle(struct drm_device *dev,
 				const struct amdgpu_ualink_handle *ualink_handle,
 				int *fd_out);
+void amdgpu_ualink_revoke_exported_memory(struct amdgpu_bo *bo);
 #endif
-- 
2.55.0

