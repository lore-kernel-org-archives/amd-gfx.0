Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2006CC5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:53:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB2F610F49B;
	Fri, 21 Aug 2026 19:53:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rY8WN+gJ";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013053.outbound.protection.outlook.com
 [40.93.196.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9B5810F49B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:53:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNHLk/L/DsWocwrWvkOhTr7qY8sDNTSp2cxQL0CMsGaPZhb3GwQJEdybjxhjJzgjq3Wyvuf9yF26bpLZgM6eTCUUrv7Ce14RXzvAp3g5JjIK4CrQDsOFKjPVyO5hwcOELIrOBQxXoIRA4HjhF8r3TScZ1j6ZG9zatBckCG+FityKuDz6XOYqzulVGbKEFXNSX3Y2ZSMxYGKJQFLJE7Rvrd86jqRvDod3Q0c+dtavD2c8GcYltZhrnvZHLrdVv6fXxlF9W/aQoIwQnkOaZQOacN4u3blnSEUSHxUAwjpKTpZ7+ezogaOkKLzvg9LlUsejKkqb6r21mB/V5QttGAwCTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zHouAYxV9RtzBFouXqlAr0hzg6EhtSCcR9qkDaWslI=;
 b=smEynAJd8NyL+5R21dZFOM/Fm4NNAFUZyhcgp2vFgDyKpsvlAJ4i0s8vux3Tw2Rkk4om8WrwVD67xYBnLSj+aErwRzZhR/B9Ut5IYGyY49w79Yn3lytRI196YV9lHLLOdETJZ6d8/TdU8k8eXfk3YmbFdRCuEZbwEIFw5OBcEaKY67C+W6RprdmSy2NkLM2QcBMFXukOBD/XiR6CxgHD0l7Q79SuRWazvPNrESErMEbt7ps03L2mycTso8k08rta8DCp4OwYsAIr5NMkVKUCAwLSx83ByXq59PCAa1OK97ET+c8V4XrWbSFyzkaBfs5U4tvhnvXmZBlR97SGnfH8NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zHouAYxV9RtzBFouXqlAr0hzg6EhtSCcR9qkDaWslI=;
 b=rY8WN+gJ6a4XSDWYifEwIE/q50RagymXmC0/el/lKzXkAC/5rmXoXTc56W3ZsjdARxVZudSRLPnOwQA3eL/Z0XOG2p4PhE5EoR67/38QFLM3ObsvzpMdNRjNJt6B2EzZzzqUVLjQotZlga0sdSUEvLL8V/3AITh88+Bx/yeT8l4=
Received: from CH5PR02CA0024.namprd02.prod.outlook.com (2603:10b6:610:1ed::6)
 by DS7PR12MB6006.namprd12.prod.outlook.com (2603:10b6:8:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:43 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::48) by CH5PR02CA0024.outlook.office365.com
 (2603:10b6:610:1ed::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:34 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:34 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 37/95] drm/amdgpu: Add UALink ring buffer allocation and
 firmware init
Date: Fri, 21 Aug 2026 15:34:00 -0400
Message-ID: <20260821193458.808626-38-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|DS7PR12MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f62a97-d056-4d18-b27a-08deffbb62f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: H1PurIjUw2NuUsrV0iwFugi8m2rW24g0k14pDgary2u6ssuUfxjU1gNoTYdFDdbOKkOEJUKLaYlV8zdGbPfNwlr8+/ddq23I92ORTDsQcoXhJ+POLxZmPU9zREDwJf/GmWyjH9c35ul8pZSv4Oxoh/82bvw7FERDRhZxZ+rqNSbPCJzzq3L2StVRxI6XrdODHDn5fwCstKvwKUYpgF7qa62V4aWETqcGCrvSAhkLSV98y/+APDxKLp+6s0AkgXrJ2L5ONfTKxuTtqBj6CcoRyVU9Xr7p0bO+7tHAudy/ZUIZ6sk6BEwo+vsVY0sUijmABysTJu2ToG8ktujz7hoMye3/ThuRL+O/XP56KcqAaSiUqhSAnQzLcHYpttZWE5t7S0td2lfA8cAdgduCVdTVeYpVw5UUraNJPaTyhdVrWze1chMF76eWS1oafhliYibuFpWGlYFrWnwLn+Hr51XYkN+591zFTdbEERGUAXX/J6+q862pRwTDQNyoDe4hMAmrt9x9JYQxv4405g+cBStUb/AbzQJRNbTYQH0vhJHuAjfH9DcghZzTR9znKT1aOeEkYwq9REdM/mMaJMW+2OteO2j45altv9VFoblTjFKf+uETaEQlCaNJhZcxAdsGN3ou5mxZ1Ep1/rCfjoVciPLIa3W5VPev7LTLIJqSJmHWvWumLxos+XQUy+fUW96LX+XFdBjr7N41HUPvqF+nNktmWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h/my2OB4SQkR3EoYrT3vNUiYYS80CbVPkuSHMTmEs6UGlva8O4H4pDDWBEH44pC17ZXLA9kXJBXngQNkucgvA7AlrpsnpGu/zKD/hbnrjFHElapJP1M1d3K5zgU0Nm2i6MhPpgl/8eXmkCchQjbXl48a9kiFRVNCwF1iasqMQr90ss7ebMt5ArSuhPq0VfOo33T3lxu5FOcnKM8pu4Ujnk7iq+VtRkDLlBpHmMTxaqrK6qKup0AIFZqkMFAvySvoJdI3V1KXF/FAkLJRGHP2iujJlKnNFiPSFvNeBSR4uO+ZRNiUBII7sf/z3XwS+ErpaXxu2t8brIUzYwIma59RvWfzjvkv0xh+3UIzs1eeB8gc0H2ZP81+d4lZjlP59QsVoYop+VY3Q4ss1yhfYOhwhXVjmlQquZSkTUqi6hyugp1LmhZBwq+nYL/eCrX4E8zA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:41.7007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f62a97-d056-4d18-b27a-08deffbb62f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6006
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

Allocate pinned memory for firmware metadata, ring buffers, and write
and read pointer pages. Populate per-GPU metadata entries and send them
to MPNHT firmware via SMN mailbox, then poll for a ready acknowledgement.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 214 +++++++++++++++++++++
 1 file changed, 214 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 69abb61e95238..d212416213960 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1454,6 +1454,25 @@ static void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32 flush_type)
 					bit, flush_type);
 }
 
+static inline u32 amdgpu_ualink_mailbox_read(struct amdgpu_device *adev,
+					     u32 mailbox_reg)
+{
+	u32 value;
+
+	value = RREG32_PCIE(mailbox_reg);
+	dev_dbg_ratelimited(adev->dev, "ualink read mailbox 0x%x return value 0x%x\n",
+			    mailbox_reg, value);
+	return value;
+}
+
+static inline void amdgpu_ualink_mailbox_write(struct amdgpu_device *adev,
+					       u32 mailbox_reg, u32 value)
+{
+	dev_dbg(adev->dev, "ualink write mailbox 0x%x value 0x%x\n",
+		mailbox_reg, value);
+	WREG32_PCIE(mailbox_reg, value);
+}
+
 /**
  * amdgpu_ualink_npa_vm_map_range - Map a range in the NPA VM
  * @adev: amdgpu device pointer
@@ -2090,3 +2109,198 @@ static void amdgpu_ualink_gart_unmap(struct amdgpu_device *adev, u64 npages,
 	amdgpu_gtt_mgr_free_entries(mgr, mm_node);
 }
 
+/**
+ * amdgpu_ualink_metadata_fini - Clean up ualink metadata structures
+ * @adev: amdgpu device pointer
+ *
+ * Unmaps NPA addresses and frees all allocated buffers for metadata,
+ * ring buffers, and pointers.
+ */
+static void amdgpu_ualink_metadata_fini(struct amdgpu_device *adev)
+{
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+
+	dev_dbg(adev->dev, "accel_id %u\n", ualink_accel_id(adev));
+	amdgpu_bo_free_kernel(&remote->rptr_bo, &remote->rptr_gpu_addr,
+				      &remote->rptr_cpu_addr);
+	amdgpu_bo_free_kernel(&remote->ring_bo, &remote->rb_gpu_addr,
+			      &remote->rb_cpu_addr);
+	amdgpu_bo_free_kernel(&remote->metadata_bo, &remote->metadata_gpu_addr,
+			      &remote->metadata_cpu_addr);
+}
+
+/**
+ * amdgpu_ualink_metadata_init - Initialize ualink metadata structures
+ * @adev: amdgpu device pointer
+ *
+ * Allocates and initializes metadata structures, ring buffers, and write/read
+ * pointers for multi-GPU ualink. Communicates with firmware to load metadata.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+	struct amdgpu_ualink_metadata *metadata;
+	u32 size, rb_size, wptr_size, rptr_size, metadata_size;
+	u64 rb_gpu_addr, wptr_gpu_addr;
+	u32 status, accel_id;
+	int i, r;
+
+	remote->active_accel_bits = adev->ualink.info->vpod.active_accel_bits;
+	dev_dbg(adev->dev, "%d active accelerators config in vpod\n",
+		bitmap_weight(remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX));
+
+	/*
+	 * allocate metadata entries and ring buffer for all remote GPUs,
+	 * to get 2MB page ring buffer NPA mapping for remote access.
+	 */
+	remote->num_accel = AMDGPU_UALINK_ACCEL_MAX;
+
+	status = amdgpu_ualink_mailbox_read(adev, mmMPNHT_SMN_C2PMSG_26_ALT_2);
+	if (status != AMDGPU_UALINK_FW_STATUS_PREINIT &&
+	    status != AMDGPU_UALINK_FW_STATUS_HALT) {
+		dev_dbg(adev->dev, "fw status 0x%x not preinit or halt\n", status);
+		return -ENODEV;
+	}
+
+	dev_dbg(adev->dev, "accel_id %u addr_mode %d fw status 0x%x\n",
+		ualink_accel_id(adev), ualink_addr_mode(adev), status);
+
+	/* Alloc metadata structure for all GPUs */
+	metadata_size = sizeof(struct amdgpu_ualink_metadata) * AMDGPU_UALINK_ACCEL_MAX;
+	metadata_size = AMDGPU_GPU_PAGE_ALIGN(metadata_size);
+
+	dev_dbg(adev->dev, "metadata size 0x%x\n", metadata_size);
+
+	/* pinned system memory */
+	r = amdgpu_bo_create_kernel(adev, metadata_size, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_GTT,
+				    &remote->metadata_bo, &remote->metadata_gpu_addr,
+				    &remote->metadata_cpu_addr);
+	if (r)
+		goto out;
+
+	memset(remote->metadata_cpu_addr, 0, metadata_size);
+	metadata = remote->metadata_cpu_addr;
+
+	dev_dbg(adev->dev, "metadata gpu address 0x%llx\n", remote->metadata_gpu_addr);
+
+	/* Allocate ring buffers, wptr for remote interrupt and shootdown */
+	rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
+	wptr_size = ualink_wptr_size(adev);
+	size = (rb_size + wptr_size) * remote->num_accel;
+	size = AMDGPU_GPU_PAGE_ALIGN(size);
+
+	dev_dbg(adev->dev, "rb_size 0x%x wptr_size 0x%x total alloc size 0x%x\n",
+		rb_size, wptr_size, size);
+
+	/* pinned VRAM */
+	r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_VRAM,
+				    &remote->ring_bo,
+				    &remote->rb_gpu_addr,
+				    &remote->rb_cpu_addr);
+	if (r)
+		goto out;
+
+	memset(remote->rb_cpu_addr, 0, size);
+
+	dev_dbg(adev->dev, "rb gpu addr 0x%llx cpu addr 0x%p vram_start 0x%llx vram_base 0x%llx\n",
+		remote->rb_gpu_addr, remote->rb_cpu_addr, adev->gmc.vram_start,
+		adev->vm_manager.vram_base_offset);
+
+	/*
+	 * address aliasing mode, shared wptr pagee left is not enough for wb data,
+	 * wb status and rptr, alloc another BO, and then alloc npa address and map
+	 * to npa vm, for remote to access.
+	 *
+	 * No gart mapping required for wb data, status and rptr because this is
+	 * updated by firmware.
+	 */
+	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS) {
+		rptr_size = AMDGPU_GPU_PAGE_ALIGN(ualink_wb_size(adev) * remote->num_accel);
+		dev_dbg(adev->dev, "source aliasing mode rptr_size 0x%x\n", rptr_size);
+
+		/* pinned VRAM */
+		r = amdgpu_bo_create_kernel(adev, rptr_size, PAGE_SIZE,
+					    AMDGPU_GEM_DOMAIN_VRAM,
+					    &remote->rptr_bo,
+					    &remote->rptr_gpu_addr,
+					    &remote->rptr_cpu_addr);
+		if (r)
+			goto out;
+
+		memset(remote->rptr_cpu_addr, 0, rptr_size);
+
+		dev_dbg(adev->dev, "source aliasing rptr gpu addr 0x%llx cpu addr 0x%p\n",
+			remote->rptr_gpu_addr, remote->rptr_cpu_addr);
+	}
+
+	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS)
+		wptr_gpu_addr = remote->rb_gpu_addr + rb_size * ualink_accel_id(adev);
+
+	for_each_set_bit(accel_id, remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
+		dev_dbg(adev->dev, "init for accel_id %u\n", accel_id);
+
+		if (accel_id == ualink_accel_id(adev))
+			continue;
+
+		rb_gpu_addr = remote->rb_gpu_addr + rb_size * accel_id;
+
+		if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT) {
+			wptr_gpu_addr = remote->rb_gpu_addr + rb_size * remote->num_accel;
+			wptr_gpu_addr += wptr_size * accel_id;
+		}
+
+		metadata[accel_id].header = AMDGPU_UALINK_METADATA_HEADER;
+		metadata[accel_id].rb_size = fls(AMDGPU_UALINK_RB_SIZE / 64) - 1;
+
+		/*
+		 * remote shootdown type is 0, remote command type is 1
+		 * with 2MB ring buffer mapping, remote shootdown ring NPA is before interrupt
+		 */
+		metadata[accel_id].ri_rb = rb_gpu_addr + AMDGPU_UALINK_RB_SIZE;
+		metadata[accel_id].tlb_inv_rb = rb_gpu_addr;
+
+		metadata[accel_id].tailptr_ri = wptr_gpu_addr +
+						ualink_wptr_offset(adev, accel_id);
+		metadata[accel_id].tailptr_tlb_inv = wptr_gpu_addr +
+						     ualink_tlb_wptr_offset(adev, accel_id);
+
+		dev_dbg(adev->dev, "init from accel_id %u to accel_id %u, rb_size 0x%x\n",
+			accel_id, ualink_accel_id(adev), metadata[accel_id].rb_size);
+		dev_dbg(adev->dev, "rb 0x%llx tlb rb 0x%llx\n",
+			metadata[accel_id].ri_rb, metadata[accel_id].tlb_inv_rb);
+		dev_dbg(adev->dev, "rb wptr at 0x%llx tlb wptr at 0x%llx\n",
+			metadata[accel_id].tailptr_ri, metadata[accel_id].tailptr_tlb_inv);
+	}
+
+	amdgpu_ualink_mailbox_write(adev, mmMPNHT_SMN_C2PMSG_25_ALT_2,
+				    upper_32_bits(remote->metadata_gpu_addr));
+	amdgpu_ualink_mailbox_write(adev, mmMPNHT_SMN_C2PMSG_24_ALT_2,
+				    lower_32_bits(remote->metadata_gpu_addr));
+	amdgpu_ualink_mailbox_write(adev, mmMPNHT_SMN_C2PMSG_23_ALT_2,
+				    AMDGPU_UALINK_ACCEL_MAX << 8);
+	amdgpu_ualink_mailbox_write(adev, mmMPNHT_SMN_C2PMSG_22_ALT_2,
+				    AMDGPU_UALINK_FW_CMD_LOAD_METADATA);
+
+	for (i = 0; i < 2000; i++) {
+		status = amdgpu_ualink_mailbox_read(adev, mmMPNHT_SMN_C2PMSG_26_ALT_2);
+		if (status == AMDGPU_UALINK_FW_STATUS_READY)
+			break;
+		mdelay(1);
+	}
+	if (status != AMDGPU_UALINK_FW_STATUS_READY) {
+		dev_dbg(adev->dev, "f/w load metadata failed 0x%x\n", status);
+		r = -ETIME;
+	}
+
+out:
+	if (r)
+		amdgpu_ualink_metadata_fini(adev);
+
+	dev_dbg(adev->dev, "ret 0x%x\n", r);
+	return r;
+}
+
-- 
2.55.0

