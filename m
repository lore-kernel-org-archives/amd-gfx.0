Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B02C624D0
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D08F10EA7B;
	Mon, 31 Aug 2026 18:29:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mq6omEoP";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011050.outbound.protection.outlook.com [52.101.57.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FD2E10EA21
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnLxtDgjvFnx7H8Aj3/iMWRCdI4NbUUpda1vvdXQhDfO+I5p6Dc07h7JSugs1YdbpkCtyr5UYrH9+tvNRar2QUVrlnHYoLWy2ygPrWm2Y3/F2KV8liXIfSlDoU8YEpUG0UXoGetnC1Xsrxq38J4GjHIIjZbCMf7MTHFl61Riww6mUDVYdZkACGhBxK5N58tBzRVCtYhGzxW60RZvNK3iBSVpLf8HXmORmoR0r+xb2fCy8FEOe8CgFQWbXDmpfufskr6fBi+PRZGspn3Re6HR1/wprvZMx7s4T8HKIhLsPi3wKR0XoMIegD0NFFbEMotnXnbW5sdg2E7krNQLl++SIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEuU1FTmIF4hUHkIlm7cO1eGIIV/bPx+g2oI6SuiW9c=;
 b=JSwuu7aoerz2XaiQHfT5JISZLwG3PJfhjGoPogVTNDMYJ/r0Gdv7jMzFeAQMCaW0dmn0olvnu7NvId2hdcnvxs95RiNrli0iWvPgcqGIsMX0HRhWnGnV7yLZPHr0leE+i4XV9PFeG5XsEBIYwuwCTD0Nr2KNRxuh/JaBLNBCkFCIs4EEB3GcRwm1BePma5s2idqsTnyQetjPu6p9xZvx3ubWrW9aR72+sV7UvQjzN/6rTJ160tPZKYUhkfi5cJgHFBJMlFF93daaENt0G9uoo52H29AlsP1rz4VkIZP+o1cmlcz23XpS7+yo3L7IJILZLTS+omqfEFlM/dXAPEI/4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEuU1FTmIF4hUHkIlm7cO1eGIIV/bPx+g2oI6SuiW9c=;
 b=Mq6omEoPSeg+6BlFWNyQ8iu3l1fiad6hfuQXNLLsfYxX9T8GktsnC4QXuQYOjDqtgpW8gIn2HGVgGeDYncOr+dWh2E66jXjrkGgw/rxDmBv7Cn7MxNoQs71+xVaioTNukj9xcvQc50djLIUqyi9w9TnRcjFZOV2wGKSH5eyk11g=
Received: from BN9PR03CA0676.namprd03.prod.outlook.com (2603:10b6:408:10e::21)
 by SJ2PR12MB8112.namprd12.prod.outlook.com (2603:10b6:a03:4f8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:56 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::38) by BN9PR03CA0676.outlook.office365.com
 (2603:10b6:408:10e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:38 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:38 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 50/95] drm/amdgpu: Implement mechanism to revoke exported
 memory
Date: Mon, 31 Aug 2026 14:27:09 -0400
Message-ID: <20260831182754.1089811-51-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SJ2PR12MB8112:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a011297-fe58-43b5-5464-08df078db789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|56012099006|10067099003|11063799006|5023799004|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: R209aDvh9fqY30dJBxlYQlLOM60ABEO7CoBI8Fc6ZCD2SLmgs/1GGyCmf8h8s5+2V/cy1jKzpofe+hDqkJBTHY0tnJSHDQGg+FbiIMOaNvTbteyxrm3vREC03SxESU8dBYOSK8siE/03px82HKyRQpCdVhHeKAFODOzELqT/fmzsnnqc1hH8IpYSHmSVnwG7Mx0gPD5rRS+J/IDmniO6f1gmZaSd9KjdRt4wmVHpPwP9K0gTcdCsH7L+ZEfADY1iECC/epSsgDwleyWhT3eNjNjs9XYE3YI5hsKChXh3rvM8GJUHwaXPq17aDTScoDk3PdYMXsgNA6DpvEwNHcJLwXX8Q+pOq3q9cJASRhgCDkIOZS8DW9NErgmqyuHCN0UHYCYLRcdmxIr/Uv+nBpQdnNjQq6t36cY79dAHGgBuinmnQ0ZIaBFkh9GjQBTcs3gk0ozL6DKU8Vp59AwyuiGgBUKUeWsQv3vZN01rV86uECxh0eZrV3cl6A2ZzqrB+A9vu+KasPehTT+fRFwZl7u4OjzCOUyIj3KJv2FDk/FWfg0Qyy856FC/GXzjQLpWMqf0GQLWuDb/gdKliWBd6RceIWWIK57yhzo7E+e4Cn08unTg/SfW8fEfS/5IsbjRy3ywcbXzI6ZKvBowx1UlkgUIntMK2TwahX6rLl/Xo25JackqH+4yAxSHHW//39MUvvWtxY3C7Tz8eU648cxx9zdlEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(5023799004)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q6vw0GR9bdUguBQQ/iO0qKVcMDy2leSkvagFzvw9O2//uOSauelG8e5d0YcHZHBfP657+3KOqwvqrRxx4SuQAN4b88d5fKVcID2yXwz0mvxlwANl2HTIQBjCxnWiqOsuv6C2fQMy+iahLQ8u553m+L9qxZrNJpNPmXqlx6Q9vQpMT3IytEM7pH9W3tz+NOCoo00f887j7fhaI+dZLK7tsGlYcwoKZ5HEVPUPrVteQyJaAwHVJ9aiPYq0XgHgjWOKEtEahWVyzZSai6t7HRwl9JhFrZQE2E6uPhOk7UFMUXaYgkKtFkJemzVBvd7yd5nBHXHeX1peQYm4V7FlU5mSzuaQzSF40XYNfZu4gX7jmXHqfgYk/u1djjQcd9l8BOjBUA3aaAbxAvO+tTM6q5zAhBuwkR4sFcTVbhNGVYxTz2ETYj1dVzjjINrN1tdmRcuc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:56.0461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a011297-fe58-43b5-5464-08df078db789
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8112
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
index ad993ab50b5c3..9d21f08123eed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1298,6 +1298,48 @@ static void amdgpu_ualink_imp_xa_entry_put(struct amdgpu_ualink_imp_xa_node *imp
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
@@ -1713,6 +1755,78 @@ static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
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
+		struct dma_resv *resv = vm->root.bo->tbo.base.resv;
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
@@ -1793,6 +1907,141 @@ static int amdgpu_ualink_map_npa_to_dmabuf(struct amdgpu_device *adev,
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
index 4a977af9565b9..8aee16ad39e9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -76,6 +76,8 @@ enum AMDGPU_UALINK_PROTOCOL_MESSAGES {
 	AMDGPU_UALINK_NPA_REQ_MSG			= 3,
 	AMDGPU_UALINK_NPA_RSP_MSG			= 4,
 	AMDGPU_UALINK_NPA_FAIL_MSG			= 5,
+	AMDGPU_UALINK_NPA_REVOKE_MSG			= 6,
+	AMDGPU_UALINK_NPA_RELEASE_MSG			= 7,
 	AMDGPU_UALINK_MAX_PROTOCOL_MSG
 };
 
@@ -354,4 +356,5 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
 int amdgpu_ualink_import_handle(struct drm_device *dev,
 				const struct amdgpu_ualink_handle *ualink_handle,
 				int *fd_out);
+void amdgpu_ualink_revoke_exported_memory(struct amdgpu_bo *bo);
 #endif
-- 
2.55.0

