Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A42CC624D8
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47B2310EA81;
	Mon, 31 Aug 2026 18:29:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AH8ue6Li";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011041.outbound.protection.outlook.com [52.101.52.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECBBC10EA45
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMrx8MPXCkGkx5QggpoI9ZAVVra749rtrfvj8M+L2NmgT+byPBUoG5UGamtropZgCfkjAity7FSuIgath2HoNfvMs2L+hrxA+McuOnF+iTNipTXna6kstLOwUYd89CxjXqHD1fkGiG71aO1LNgofJ9GzWJO9C+e402cQexi8xubI7uqQFrMjmsnEOOVb67pWGmuCT7HnvpiayrJZyadfrgSIfYnej5gadvXwYbh+9lRQqcNrAE/IB/WJOH8HNUS8HcuEl/hA9279O8H23kp8bJLoUy3XVLRerXBaQOfnaBlGZxzfmsp/ou+rZyefQiQPh/dK9Vw8KgtJ0kiep0S8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScHNfFVK5BH3uycIudsxsraJj8gH6QcaeOKdZpvfnjw=;
 b=EzW6gJuL8wpJru8S3JFTv0avA9KrHgoJ2NNyaJqi+twiDzoEzbr1QIrUFPyE0I7I2qrDLWXxgpd7sT4kGsCh73GQFVafetuS0TQOnamyi2+9eEIIQBjFfYEHLLrua3NSohNPclBgXdp54eUsFsbH54jTjJwZjQFyuxTOkpSQMC/088iZxTWgnh02DmsmicaixTtcEOZTkPkT+eKH/4PM4LFE9g9UJQbs4ZYCRIg6QUIS2xrDOqHjw+HI4b6JcDmHFx4kBc+kL2Nzp2scZM6LkzVWBgecxAohltYjqi6ZRiAeoZW1Fx1WDqj65oRAYNqm+MJOefCKQM+Qy63t/ZdGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScHNfFVK5BH3uycIudsxsraJj8gH6QcaeOKdZpvfnjw=;
 b=AH8ue6LisCbKqZeuMyzoTAGUvOH54MWwt+4ZQPzMPYQvowgAMv3LG01drWkJBlqn2/Kgz1+rqJFDRsGi/8GwQt5IzWZn3PALtWSImPDvLXyNaaNevJDelTsoLJ3tkTa1w+NtZ51YYMXkElVmHo0weuv4sHEogCRsRZQN4rdb6jc=
Received: from CH5P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::10)
 by CH1PR12MB9694.namprd12.prod.outlook.com (2603:10b6:610:2af::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:41 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::8d) by CH5P220CA0002.outlook.office365.com
 (2603:10b6:610:1ef::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:40 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:29 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 37/95] drm/amdgpu: Add UALink ring buffer allocation and
 firmware init
Date: Mon, 31 Aug 2026 14:26:56 -0400
Message-ID: <20260831182754.1089811-38-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|CH1PR12MB9694:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ac08fb-3977-492a-a09a-08df078dae83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bv8JwxsCBU6uV/6tFMgF9l5687A5e/K2Gc4vacSg/a/fKfSMgBEAZRZS3Ne4jlZ8UFovxSFUKzyqO833uH514G1y9xarkeqJEYhVayQTmoh+kFpC3HT2+sJoPDJaUUdFzOB3wfASZ6Dz+YDI+iMn5U+rcBB2Gk65geA9qNunBFY7YmFBYoa7VUAvG4AjMpkwTgt5pK8p2k36K2oJVR3cgKwCC3BlbjU55G+foCWuSc8qA9iO3KvJZiSWMKX9oCuy4J/XHFA2gbeIjRI/PDfdMd0NLPNm/MgbKepUuD6PYEQCSYRXe8GAcklrEelXdRDfqzngU2YAIhH4RfA8phKb106ymb+Y9TZMzo5P5jqPu30seCIPfGMpeBMfQ4u+9zk6O9CgLKoajrq9tysE8n596w23ROppD9i+gC7X52vJ0xl9TfRWEaAWIJ0i/BFF4XgNKyFKP+SHHIxGxVPq6D5qky51OQPK0706akWjMJtYHZZFW4Gb/BblsGcgbfWIYZqvmrVkkT5PwG++J3CTatbbqlQTISoIIudtj/+lM8ktvcOgAQQhcNpJ9vZ1RIWrFZY7mCT6goLKyU4nG6ZvRkw2x7WlJhME5qG5rgu1GoEqRB7OP0Elr1S/DAajPuCdI8QdaCW4kMU0rugsb4NIF6KE/WcK7OJzd8PwwhQCY1h0ebl9lewAzG8jy+xirK4h7NpGCF04t6Uwrai3bYjnH+v5oA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E5v0MOmYShzAX5GVApfzV0YEcHFrNSm8uBcRoJ/DCJMktDe6Bs/tQGj79AoWm32S85p0IEpiFReNhZLJXZSqgfi1JDbLDUbQFm2j6NMI8MptOEqwIhyWFwU01MwKf2pNSEAqntkokTDWrcvG9qTm8NkSjRoc+5+vLZEsMdHkbDN1Kg8W6E2cIfgZTL9rfKt60FNzeq/9r+otR90KOyPvWUJho5l3SDVWGuTlFf4ClEaMeW9M/3Mp+sI1zW7OdgxUJWo1oS9QEVy7Mg2KLIxoUkuDfquvBOCbCFiSQOnU0e4qUaR3XEwmN/iNAl+iomjhHSasSPj0/WDB8gP2gCOEesokkM8S9ZqtV6+LNVYAKKAiXsuhfEawI9sRDWDpNS3xtSDw/8xU2RvFx74nN76Fs8cj97KKw3UsPD7kROEPef/Knjljgl4MYpD0mhO3I0Gt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:40.9068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ac08fb-3977-492a-a09a-08df078dae83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9694
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
index d7010cde11bb4..c8b01e9a2eabe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1499,6 +1499,25 @@ static void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32 flush_type)
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
@@ -2135,3 +2154,198 @@ static void amdgpu_ualink_gart_unmap(struct amdgpu_device *adev, u64 npages,
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

