Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE804C5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 798D710F3F1;
	Fri, 21 Aug 2026 19:51:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P4gE9tFB";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9ED410F3F1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:51:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5ZiDWXKJWjnvmW6fC9Y0A1nx+4+dkuexPmEk4a09vvBKZI5kwjuIki3aALcRzYIjePd18iP+BwbtI6buK8FVryU4ULZkXTY7UUQzLBjXoWrU+McrtRxx3wFDWZmVIKCvJoTt3atJCEuX5TbvSP/EWd2iqk+Q8nB45Uvpgk+/KzeWREPuHWjZkj4g9JriC2R6htV3o9H9WxTllLt62MM53Vmg9a1mKS8tM7+q0GZp6uA5k3jXOk6G9Z4D06zCV7/i4/IRX3Lf4J+B1ZtJ2Vl4iR06kPSQXupstKyKMasBbvoLdnDAFnnS2y8qb3vc8fISvM3V625w62J2Wm+LshMaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HH7WRCi85HawlwK6NkeY/5TZLyn/5UwPL5dR6/mSG5g=;
 b=twxyKUwJWspweRXYPYymP4r2/Li8pR+AcFoTp75e3n3xIqeq5x37R8gTvs7s77G796B7iaZ9RUAK/0INyWi2BdMUuevDtQFi1IIKH1ZvNk9A/voeU0yUAErkfkYyaJo58DlHlCxODxdjeEk1S5hl67oUBt1rHVoZIqn8innd5hXVwNv416e5gY+053JsLdapCbih8qwXIuuKADzOGdXuzNjkYsSxZlTdWk6GbQzCka/nMlpY0L+uafzp+xmBP3jor1Qiz/n6AtuGgfkJuQa9zYhmK4qK/Rgn/gZGMte3SpJF5Qe71Cr43jPpPPKwREtb4qVaxZZrVHU4GcOkk+iRVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HH7WRCi85HawlwK6NkeY/5TZLyn/5UwPL5dR6/mSG5g=;
 b=P4gE9tFBgJ2nl80DdaA1mU04PxLLcU8lBtRZEht4rg7bZ0sqMTtwwJ4gmvxP7m/2IbBSPuHnqOu0d9iTnV3trEpwSLHK51j2PUdAOQyBSU47h+wtgQhZGii26xMCHkz69/5UiBG+c6V9VFD51NQgsYhgUOw5/21yJcmF67Akl9Y=
Received: from SJ0PR03CA0229.namprd03.prod.outlook.com (2603:10b6:a03:39f::24)
 by MW4PR12MB7358.namprd12.prod.outlook.com (2603:10b6:303:22b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Fri, 21 Aug
 2026 19:35:41 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::71) by SJ0PR03CA0229.outlook.office365.com
 (2603:10b6:a03:39f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:32 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:32 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 34/95] drm/amdgpu: Add UALink NPA VM mapping for ring buffers
Date: Fri, 21 Aug 2026 15:33:57 -0400
Message-ID: <20260821193458.808626-35-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|MW4PR12MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: 722d0b24-f8a8-4531-112a-08deffbb61da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: nN3dlzxdXiA78ttIfV46xVd6qOxVWsUVRHpporjyLkplTzLUytUnulxbCkL+R9Was4wfGPGHqDKpy6L9nLOdULBws/UOW0qJb2aiBZsv+QVGrIPAO0X7VRGmoPMLXCnspPLSzo+hQ9IGit5iuvC4PaUN4AKEXZMSfPlFzjFe/v205w2/kGuw7QfJJnZUj+68aeAOgM95VDJW73ORXcBD/qHzH1lXOGjVeiYulFg0uNzqPgo+2BDfxr512lM5oJf1fpZn1GOHfCSMVvfhgY7ehv+ZLA5T9SNPLC1Lr2bIfKCcJOFdl8X62GFXupnESgMkUcExI+erRFCYUZfW8H59CpUL1ANV8Es5PQUxG236TAqMZw4gyDrNY6PWMupH9lMZGAx629kxizO2sawBo6uL0I0OvOJJLF78iZjM7exEZncMTSjajLrro1iaVBe0di94mK3yns3qFgGoyBegqS28w7piniwQr8khUOU9tgHnWCXY8+KzH1BxtMleLbB4Mf5ZaKSh5DI1Xr0r6gX1uDksLTMxkOv3n1pbeVnpzWGAbBfiQ5mwxMrQgYzZbKpCHpWGqTJhMdm/0pwO8ijL+U77un/BO9wBatF/Q8wDrW+XhFT27XZjsS6RhK27FyCdkduI0pZ0VTolfR9HNC0p0xxrLYZmu0zDWrpBJVOyxlmnI2XO90kmtyUglp0b80LjeMtk2zWJTTnJm+Z1tgRh0Mfogw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IbSc5vtrhV/ywlzxaCHCs5a1NbwVZueTr00jLybA079/wHtVVGrR7e/tPnsgJ8RV+jRw5KfScb/5JWmTeW1mr2Vip1kgmT0D69lPb+FvjtcNtQpgzRe7mkGIRNDz6r/oEI491i4eLxrYVdeb3eHD+G0pYQRsajv8zqLX8UdaoF6Uds4WLV3PBrpEKF8rjl1uC76ty0yGhbXc+GKzIWt5NxjWaaRJzvLtQ6ATGz6gn9IfYSb1R8e/FcJXYuFR84sACC51xNmUVHjuQYi8Yju/doRWMUd62YpWK/MPeveuqFJx8Cxn8Ou5Cm69DZUf4xVrPxCBp8x8ovZPeTxpaJO5+4JOuxTM3EvBXmexbhbFSWiYQUVeL/6unSRwfK1WrHqnkKe7870kyHViyRY2hlMdMawyD6+Oa7DjpkgfNBmWhnHId1XBISv5GTpHdccEwqZC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:39.7742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 722d0b24-f8a8-4531-112a-08deffbb61da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7358
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

From: Philip Yang <Philip.Yang@amd.com>

Populate the NPA VM so remote GPUs can access local ring buffers and
write pointer pages at their reserved NPA addresses. Teardown waits for
DMA fences and issues a heavyweight TLB flush.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 429 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |   3 +
 2 files changed, 432 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 857af8a3727b3..191b45a51024a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1439,6 +1439,92 @@ static inline u32 ualink_tlb_wb_offset(struct amdgpu_device *adev, u32 accel_id)
 	return ualink_wb_offset(adev, accel_id) + sizeof(struct amdgpu_ualink_wb);
 }
 
+static void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32 flush_type)
+{
+	uint64_t tlb_seq = amdgpu_vm_tlb_seq(&adev->ualink.npa_vm);
+	u32 bit;
+
+	if (atomic64_xchg(&adev->ualink.last_flushed_tlb_seq, tlb_seq) == tlb_seq)
+		return;
+
+	bit = AMDGPU_MMHUB0_START;
+
+	for_each_set_bit_from(bit, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
+		amdgpu_gmc_flush_gpu_tlb(adev, adev->vm_manager.npa_vmid,
+					bit, flush_type);
+}
+
+/**
+ * amdgpu_ualink_npa_vm_map_range - Map a range in the NPA VM
+ * @adev: amdgpu device pointer
+ * @bo: buffer object backing the mapping
+ * @pte_flags: page table entry flags
+ * @offset: offset into the buffer object in bytes
+ * @size_in_pages: size of the range to map in pages
+ * @npa_in_pages: NPA target address in pages
+ *
+ * Maps a buffer object range into the NPA VM page table at the specified
+ * NPA address.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int amdgpu_ualink_npa_vm_map_range(struct amdgpu_device *adev, struct amdgpu_bo *bo,
+				   u64 pte_flags, u64 offset, u64 size_in_pages,
+				   u64 npa_in_pages)
+{
+	struct amdgpu_vm *npa_vm = &adev->ualink.npa_vm;
+	int r;
+
+	dev_dbg(adev->dev, "offset 0x%llx size 0x%llx flags 0x%llx npa 0x%llx\n",
+		offset, size_in_pages << AMDGPU_GPU_PAGE_SHIFT, pte_flags,
+		npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
+
+	r = amdgpu_vm_update_range(adev, npa_vm, false, false, true,
+				   false, NULL, npa_in_pages,
+				   npa_in_pages + size_in_pages - 1,
+				   pte_flags, offset, adev->vm_manager.vram_base_offset,
+				   bo->tbo.resource, NULL, &npa_vm->last_update);
+	if (r)
+		dev_dbg(adev->dev, "failed %d to map npa 0x%llx to NPA VM\n", r,
+			npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
+	return r;
+}
+
+/**
+ * amdgpu_npa_vm_unmap_range - Unmap a range from the NPA VM
+ * @adev: amdgpu device pointer
+ * @bo: buffer object backing the mapping
+ * @pte_flags: page table entry flags
+ * @offset: offset into the buffer object in bytes
+ * @size_in_pages: size of the range to unmap in pages
+ * @npa_in_pages: NPA target address in pages
+ *
+ * Removes a previously established mapping from the NPA VM page table.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int amdgpu_ualink_npa_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_bo *bo,
+				     u64 pte_flags, u64 offset, u64 size_in_pages,
+				     u64 npa_in_pages)
+{
+	struct amdgpu_vm *npa_vm = &adev->ualink.npa_vm;
+	int r;
+
+	dev_dbg(adev->dev, "offset 0x%llx size 0x%llx flags 0x%llx npa 0x%llx\n",
+		offset, size_in_pages << AMDGPU_GPU_PAGE_SHIFT, pte_flags,
+		npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
+
+	r = amdgpu_vm_update_range(adev, npa_vm, false, false, true,
+				   false, NULL, npa_in_pages,
+				   npa_in_pages + size_in_pages - 1,
+				   pte_flags, offset, 0, bo->tbo.resource, NULL,
+				   &npa_vm->last_update);
+	if (r)
+		dev_dbg(adev->dev, "failed %d to unmap npa 0x%llx from NPA VM\n", r,
+			npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
+	return r;
+}
+
 /*
  * Reserved NPA space for remote shootdown and interrupt ring buffer,
  * write pointers, read pointers and writeback buffers
@@ -1533,3 +1619,346 @@ static u64 amdgpu_ualink_gart_npa_addr(struct amdgpu_device *adev, u32 type,
 	return npa | ((u64)dst_accel_id << AMDGPU_UALINK_GART_NPA_ADDR_GPUID_SHIFT);
 }
 
+/**
+ * amdgpu_ualink_reserve_npa_vm_and_bos - Reserve the NPA VM page directory and BOs
+ * @adev: amdgpu device pointer
+ * @bos: array of buffer objects to reserve
+ * @n_bos: number of entries in @bos
+ * @exec: drm_exec context to initialize and use for locking
+ * @interruptible: true to use the interruptible dma_resv_lock
+ *
+ * Initializes @exec and uses it to lock all BOs in @bos together with the
+ * NPA VM page directory, retrying on contention. On failure, @exec is
+ * finalized and the error code is returned.
+ *
+ * Returns: 0 on success, negative error code on failure.
+ */
+static int amdgpu_ualink_reserve_npa_vm_and_bos(struct amdgpu_device *adev,
+						struct amdgpu_bo *bos[], u32 n_bos,
+						struct drm_exec *exec,
+						bool interruptible)
+{
+	u32 flags = DRM_EXEC_IGNORE_DUPLICATES;
+	int i, r = 0;
+
+	if (interruptible)
+		flags |= DRM_EXEC_INTERRUPTIBLE_WAIT;
+
+	dev_dbg(adev->dev, "reserve NPA vm and %d bos\n", n_bos);
+
+	drm_exec_init(exec, flags, 0);
+
+	drm_exec_until_all_locked(exec) {
+		for (i = 0; i < n_bos; i++) {
+			r = drm_exec_lock_obj(exec, &bos[i]->tbo.base);
+			drm_exec_retry_on_contention(exec);
+			if (unlikely(r))
+				goto out;
+		}
+
+		r = amdgpu_vm_lock_pd(&adev->ualink.npa_vm, exec, 0);
+		drm_exec_retry_on_contention(exec);
+		if (unlikely(r))
+			goto out;
+	}
+
+out:
+	if (r)
+		drm_exec_fini(exec);
+	return r;
+
+}
+
+/**
+ * amdgpu_ualink_unreserve_npa_vm_and_bos - Release the NPA VM page directory and BOs
+ * @adev: amdgpu device pointer
+ * @exec: drm_exec context previously initialized by
+ *        amdgpu_ualink_reserve_npa_vm_and_bos()
+ *
+ * Finalizes @exec, releasing all locks on the NPA VM page directory and
+ * the associated BOs acquired during reservation.
+ */
+static void amdgpu_ualink_unreserve_npa_vm_and_bos(struct amdgpu_device *adev,
+						   struct drm_exec *exec)
+{
+	dev_dbg(adev->dev, "unreserve NPA vm and bos\n");
+	drm_exec_fini(exec);
+}
+
+/**
+ * amdgpu_ualink_metadata_npa_unmapping - Tear down NPA address mappings
+ * @adev: amdgpu device pointer
+ *
+ * Unmaps all NPA address mappings from the NPA VM for ring buffers,
+ * write pointers, and read pointers. Waits for outstanding DMA fences
+ * and flushes the TLB.
+ */
+static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
+{
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+	u64 timeout = msecs_to_jiffies(2000);
+	u32 dst_accel_id = ualink_accel_id(adev);
+	struct amdgpu_bo *bos[2];
+	u32 n_bos;
+	struct dma_fence *fence;
+	struct drm_exec exec;
+	u32 rptr_size, rptr_size_in_pages;
+	u32 rb_size, rb_size_in_pages;
+	u64 pte_flags = adev->gmc.noretry_flags;
+	u64 npa;
+	int r;
+
+	if (!remote->ring_bo)
+		return;
+	if (!remote->active_accel_bits)
+		return;
+
+	rb_size = AMDGPU_UALINK_RB_SIZE;
+	rb_size_in_pages = rb_size >> AMDGPU_GPU_PAGE_SHIFT;
+
+	bos[0] = remote->ring_bo;
+	n_bos = 1;
+	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS) {
+		bos[1] = remote->rptr_bo;
+		n_bos = 2;
+	}
+
+	r = amdgpu_ualink_reserve_npa_vm_and_bos(adev, bos, n_bos, &exec, false);
+	if (unlikely(r))
+		return;
+
+	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS) {
+		/* rptr npa mapping, up to allocated 2 pages npa address */
+		rptr_size = ualink_wb_size(adev);
+		rptr_size = AMDGPU_GPU_PAGE_ALIGN(rptr_size * remote->num_accel);
+		rptr_size_in_pages = rptr_size >> AMDGPU_GPU_PAGE_SHIFT;
+
+		npa = remote->rptr_npa;
+
+		amdgpu_ualink_npa_vm_unmap_range(adev, remote->rptr_bo,
+						 pte_flags, 0, rptr_size_in_pages,
+						 npa >> AMDGPU_GPU_PAGE_SHIFT);
+		amdgpu_ualink_npa_free_va(adev, &remote->rptr_mm_node);
+
+		/*
+		 * unmap wptr, remote interrupt, shootdown ring.
+		 * wptr page is part of the single 2MB mapping for remote GPUs
+		 * interrupt and shootdown ring buffer
+		 */
+		npa = amdgpu_ualink_npa_addr(adev, RB_TYPE_TLB_INV,
+					     0, dst_accel_id);
+		amdgpu_ualink_npa_vm_unmap_range(adev, remote->ring_bo, pte_flags,
+						 0,
+						 2 * rb_size_in_pages * AMDGPU_UALINK_ACCEL_MAX,
+						 npa >> AMDGPU_GPU_PAGE_SHIFT);
+	} else {
+		u32 wptr_offset = 2 * rb_size * remote->num_accel;
+		u32 idx = 0;
+		u32 accel_id;
+
+		/* source identification mode */
+		for_each_set_bit(accel_id, remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
+			if (accel_id == dst_accel_id)
+				continue;
+
+			/* remote interrupt ring npa mapping */
+			npa = amdgpu_ualink_npa_addr(adev, RB_TYPE_REMOTE_INTERRUPT,
+						     accel_id, dst_accel_id);
+			amdgpu_ualink_npa_vm_unmap_range(adev, remote->ring_bo,
+							 pte_flags, idx * 2 * rb_size,
+							 rb_size_in_pages,
+							 npa >> AMDGPU_GPU_PAGE_SHIFT);
+
+			/* remote shootdown ring npa mapping */
+			npa = amdgpu_ualink_npa_addr(adev, RB_TYPE_TLB_INV, accel_id,
+						     dst_accel_id);
+			amdgpu_ualink_npa_vm_unmap_range(adev, remote->ring_bo,
+							 pte_flags, (idx * 2 + 1) * rb_size,
+							 rb_size_in_pages,
+							 npa >> AMDGPU_GPU_PAGE_SHIFT);
+
+			/* wptr, rptr npa mapping */
+			npa = amdgpu_ualink_npa_addr(adev, RB_TYPE_TAILPTR, accel_id,
+						      dst_accel_id);
+			amdgpu_ualink_npa_vm_unmap_range(adev, remote->ring_bo,
+						  pte_flags, wptr_offset + idx * PAGE_SIZE,
+						  1, npa >> AMDGPU_GPU_PAGE_SHIFT);
+			idx++;
+		}
+	}
+
+	r = amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm, false);
+	if (r) {
+		dev_dbg(adev->dev, "failed %d to update directories\n", r);
+		goto out_unreserve;
+	}
+
+	fence = dma_fence_get(adev->ualink.npa_vm.last_update);
+	if (fence) {
+		r = dma_fence_wait_timeout(fence, true, timeout);
+		dma_fence_put(fence);
+		if (r <= 0)
+			dev_dbg(adev->dev, "failed %d to dma fence wait\n", r);
+	}
+
+	amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
+out_unreserve:
+	amdgpu_ualink_unreserve_npa_vm_and_bos(adev, &exec);
+}
+
+/**
+ * amdgpu_ualink_metadata_npa_mapping - Setup NPA address mapping in VM
+ * @adev: amdgpu device pointer
+ *
+ * Maps NPA addresses to GPA for metadata ring buffers, write pointers,
+ * on NPA VMID 15.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int amdgpu_ualink_metadata_npa_mapping(struct amdgpu_device *adev)
+{
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+	u32 dst_accel_id = ualink_accel_id(adev);
+	u64 timeout = msecs_to_jiffies(2000);
+	struct amdgpu_bo *bos[2];
+	u32 n_bos;
+	struct dma_fence *fence;
+	struct drm_exec exec;
+	u32 rb_size, rb_size_in_pages;
+	u64 npa, npa_in_pages, pte_flags;
+	int r;
+
+	rb_size = AMDGPU_UALINK_RB_SIZE;
+	rb_size_in_pages = rb_size >> AMDGPU_GPU_PAGE_SHIFT;
+
+	bos[0] = remote->ring_bo;
+	n_bos = 1;
+	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS) {
+		bos[1] = remote->rptr_bo;
+		n_bos = 2;
+	}
+
+	r = amdgpu_ualink_reserve_npa_vm_and_bos(adev, bos, n_bos, &exec, false);
+	if (unlikely(r))
+		return r;
+
+	pte_flags = amdgpu_ttm_tt_pte_flags(adev, remote->ring_bo->tbo.ttm,
+					    remote->ring_bo->tbo.resource);
+	dev_dbg(adev->dev, "init pte_flags 0x%llx\n", pte_flags);
+
+	amdgpu_gmc_get_vm_pte(adev, &adev->ualink.npa_vm, remote->ring_bo,
+			      AMDGPU_VM_MTYPE_DEFAULT, &pte_flags);
+	dev_dbg(adev->dev, "after get coherent pte_flags 0x%llx\n", pte_flags);
+
+	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS) {
+		u32 rptr_size, rptr_size_in_pages;
+
+		/* rptr npa mapping, up to allocated 2 pages npa address */
+		rptr_size = ualink_wb_size(adev);
+		rptr_size = AMDGPU_GPU_PAGE_ALIGN(rptr_size * remote->num_accel);
+		rptr_size_in_pages = rptr_size >> AMDGPU_GPU_PAGE_SHIFT;
+
+		r = amdgpu_ualink_npa_alloc_va(adev, &remote->rptr_mm_node,
+					       0, 0, 0,
+					       rptr_size_in_pages);
+		if (r)
+			goto out;
+
+		npa_in_pages = remote->rptr_mm_node.start;
+
+		dev_dbg(adev->dev, "source aliasing rptr alloc 0x%llx and map to npa vm\n",
+			npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
+
+		r = amdgpu_ualink_npa_vm_map_range(adev, remote->rptr_bo, pte_flags, 0,
+						   rptr_size_in_pages,
+						   npa_in_pages);
+		if (r)
+			goto error_npa_mapping;
+
+		remote->rptr_npa = npa_in_pages << AMDGPU_GPU_PAGE_SHIFT;
+
+		/* wptr, remote interrupt, shootdown ring, single big 2MB mapping */
+		npa = amdgpu_ualink_npa_addr(adev, RB_TYPE_TLB_INV,
+					     0, dst_accel_id);
+		r = amdgpu_ualink_npa_vm_map_range(adev, remote->ring_bo, pte_flags,
+						   0,
+						   2 * rb_size_in_pages * AMDGPU_UALINK_ACCEL_MAX,
+						   npa >> AMDGPU_GPU_PAGE_SHIFT);
+		if (r)
+			goto error_npa_mapping;
+
+	} else {
+		u32 wptr_offset = 2 * rb_size * remote->num_accel;
+		u32 accel_id, idx = 0;
+
+		/* Source identification mode */
+		for_each_set_bit(accel_id, remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
+			if (accel_id == dst_accel_id)
+				continue;
+
+			/* remote interrupt ring npa mapping */
+			npa = amdgpu_ualink_npa_addr(adev, RB_TYPE_REMOTE_INTERRUPT,
+						      accel_id, dst_accel_id);
+			r = amdgpu_ualink_npa_vm_map_range(adev, remote->ring_bo, pte_flags,
+							   idx * 2 * rb_size,
+							   rb_size_in_pages,
+							   npa >> AMDGPU_GPU_PAGE_SHIFT);
+			if (r)
+				goto error_npa_mapping;
+
+			/* remote shootdown ring npa mapping */
+			npa = amdgpu_ualink_npa_addr(adev, RB_TYPE_TLB_INV, accel_id,
+						     dst_accel_id);
+			r = amdgpu_ualink_npa_vm_map_range(adev, remote->ring_bo, pte_flags,
+							   (idx * 2 + 1) * rb_size,
+							   rb_size_in_pages,
+							   npa >> AMDGPU_GPU_PAGE_SHIFT);
+			if (r)
+				goto error_npa_mapping;
+
+			/* wptr, rptr npa mapping */
+			npa = amdgpu_ualink_npa_addr(adev, RB_TYPE_TAILPTR, accel_id,
+						     dst_accel_id);
+			r = amdgpu_ualink_npa_vm_map_range(adev, remote->ring_bo,
+							   pte_flags,
+							   wptr_offset + idx * PAGE_SIZE,
+							   1, npa >> AMDGPU_GPU_PAGE_SHIFT);
+			if (r)
+				goto error_npa_mapping;
+
+			idx++;
+		}
+	}
+
+	r = amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm, false);
+	if (r) {
+		dev_dbg(adev->dev, "failed %d to update directories\n", r);
+		goto error_npa_mapping;
+	}
+
+	/* TODO: only wait the last fence, then flush TLB */
+	fence = dma_fence_get(adev->ualink.npa_vm.last_update);
+	if (fence) {
+		r = dma_fence_wait_timeout(fence, true, timeout);
+		dma_fence_put(fence);
+		if (r <= 0)
+			dev_dbg(adev->dev, "failed %d to dma fence wait\n", r);
+	}
+
+	amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
+
+	amdgpu_ualink_unreserve_npa_vm_and_bos(adev, &exec);
+	return 0;
+
+error_npa_mapping:
+	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS)
+		amdgpu_ualink_npa_free_va(adev, &remote->rptr_mm_node);
+	if (r)
+		dev_dbg(adev->dev, "failed %d to map NPA vm\n", r);
+
+out:
+	amdgpu_ualink_unreserve_npa_vm_and_bos(adev, &exec);
+
+	return r;
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 0d1b46a53e97a..187d42af27dcb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -181,6 +181,9 @@ struct amdgpu_ualink_mgr {
 
 	/* NPA-VM used on the exporter.*/
 	struct amdgpu_vm npa_vm;
+
+	/* Sequence number to track the need for TLB flushes */
+	atomic64_t last_flushed_tlb_seq;
 };
 
 int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev);
-- 
2.55.0

