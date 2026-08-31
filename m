Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109FDC624C6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:30:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1AB610EA99;
	Mon, 31 Aug 2026 18:30:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5hAi8Ag+";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74FA310EA67
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UaEOiVz4MV6Y4rdCLS03g8CeI2BhGARP6jUJT5ohvKfkGAj/4DSoMEOHNq3JXBzSVE0OJHLiprOrzX8boxo04judz1DOhdc+NqfGvbYjAxpBSTzx29B00outiL4oyfAny3epO0lmkUBu6HWQc4mZ0eERV2swbnsp2DL2xN6A018E3m49qitw99Qm0U80OheIP59AGFyHeswBo2Hjz8R+oEXXRd9Q4onyOwThjJ+IOXElQNkLdEi9vKZcXHbJ8qz7bgmlkmUTBEOonVI/hmWhOXOLBkjrrLAD8WK1AYnAnl96s0tNCYb9woqFHqw+v6GDVlF00sFBEwmNMm2psJYDpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDWdv9xoNEZJfCYYRcvseQ552GXflzVAUarW2KZK9dk=;
 b=KalUcn5KHhZcik+ml9PZjXjvx1kmxIwP6Gbpz6q8xj5HUhLfUD+zSqZjyrXhLB42rkOcREqBZYbmqOXj9NPFXtpQCVSC1LeEaFvYINEKmfidswa71GAbNON2d3QS0QsuGnEYDoWi/nxCM06eekmQTjj60XLdJMB6dl9wKcm4maQkyWDa3NYeMMjP5FkgZVASv1mr44/d3rfPrE+M9YuC+Qep6D1Rj+wsbpWddKQyYyzCBSF162ALXurlNip/SNWLb3kllsjdI1zE5qa3NjTqtQD2Eqx4DbzUE/bbqI2PHyy/dWZoduT7xCjgrY4S7vebrWhfzFsn4GdW+9pirdH9Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDWdv9xoNEZJfCYYRcvseQ552GXflzVAUarW2KZK9dk=;
 b=5hAi8Ag+aEKTL8SbJLZat7sKH2AnTw60NtIWMX8i0/5yHuqDBm6IuEiVUMr/wfBuLZpSmuWqFQne6PtN2mRoIp/prIfRNF0pOgvixEZbQj3+Wo/0HGr9UdwYbkghbQRDHKr7ocXxIb1/ijdM9LUGkLyETOjo/ya6nBgCz4U1RSo=
Received: from BN9PR03CA0139.namprd03.prod.outlook.com (2603:10b6:408:fe::24)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:50 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::67) by BN9PR03CA0139.outlook.office365.com
 (2603:10b6:408:fe::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:28 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:28 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 34/95] drm/amdgpu: Add UALink NPA VM mapping for ring buffers
Date: Mon, 31 Aug 2026 14:26:53 -0400
Message-ID: <20260831182754.1089811-35-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea757d5-3bf2-47ea-bcc1-08df078db2f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: v3BAl9NqbRhQuUrRG277Emk/IjkXsqBJuxEGmFyOjUaZUuL7pQArbcASidaSjOjJ3kYA99H2w5hmIwBfbu7t5HnjQWTdfYtWEysO9mRsAXNCfqYeclJwW0O4GP0oZtmYZouRUJtRC3qSu8rNYm2KJG9O1pLUq/YzWoXkW4TnVkuj4QDkUudr1ySOWDe/JrjTpRo0+tkDuYB2ArXaDyQcfflhWTH5+raODwIaTwP3QlfvQ9NKDhI4vfZlPG5dWwF2drv5UaiGxA880KjcBDTG2A1XnGapVEDR5RwxhSup7emHEpUjkoC7pG8DzS2BrYRMuNr8w5QSVceZGNTz8SiYTIfHVhTYAwEJUlnXOXfi53h5m93y6VFfT+iHtt7YPlInI4grRHsHTdsoUBqTtCCiYy9nLTuFLq8/dZzmA1pa2w/FU9wILP99QZLFlbza0VievbujTlXOC92xxD6OgSb4vsJgl5WIZusF5g/5/8J5uMyAEguk5sMThaoO8oWoquV+TYADkZdYvLUUW+wKDKWArkIdQpAQhdxZKw7eQqsPt9dyQeRJeJIA2/0U7t793X7+aiIdrh1iF+PsaeBW4YQpscib4RQk10hYBbEgDAD7/qDZ7CQejY6DT+9EhyqNMFhWVsswcDbN1zHf3atIdwurYIHWNbdpR1lY6ghkX/xGUK3ygK50DTzM8ehfGpfiL8leMMF57FmgJzvNtcPxGOgBeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ywojBNT6zUKPKc8gxL4LfcYyAgetgP5qWIdXTZ9nLF1AhP/HdsSZiMOtFWABpNRRIWKqBh3C6wKdU0loUEV6y1a2LxvsEni6dsR1iUPpwAj4N5b4cqxZTBWvAiVAign7igDx30PWmlT3quo+FaOJYBjZSObAJEfVWkpwHtENeNPkijx7WQDp1ehw0TJKicQgiCOnvQWEyfNaWmUq5gG5e382lWQ3FGKjaZPV1ZYn9UD60K6E4SXx8uAfZTAAOspvP6ooGComtLZzrIrtDauEmPsDzRH3U7PvItW7H8hPLyXbm4RSM/mz4SozCF0YTjsZtH9p+Td3Xqe2PwpxjnCsao9ORYGAXLciBJVYkSdwveSX1B172kZloPf48PT0M85YIvfUnZEEuF0wdGVIbnVPSpNxTtTiHIL0Qqf8LJvurin0iTSFGHccywE1XIDpM2Bi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:48.3846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea757d5-3bf2-47ea-bcc1-08df078db2f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467
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
index c4edefcef2141..51e0e2336d052 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1484,6 +1484,92 @@ static inline u32 ualink_tlb_wb_offset(struct amdgpu_device *adev, u32 accel_id)
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
@@ -1578,3 +1664,346 @@ static u64 amdgpu_ualink_gart_npa_addr(struct amdgpu_device *adev, u32 type,
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
index a75aac48604cb..3fde1b80c3e92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -185,6 +185,9 @@ struct amdgpu_ualink_mgr {
 
 	/* NPA-VM used on the exporter.*/
 	struct amdgpu_vm npa_vm;
+
+	/* Sequence number to track the need for TLB flushes */
+	atomic64_t last_flushed_tlb_seq;
 };
 
 int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev);
-- 
2.55.0

