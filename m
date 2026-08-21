Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B416FC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25A9A10F3EC;
	Fri, 21 Aug 2026 19:51:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YDZLUjIj";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010038.outbound.protection.outlook.com
 [52.101.193.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF24B10F3EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:51:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9xEfHcXCvdWTa7UhgArO19f9XEBktYds7nXvAaHt6xtkLPnxLOi5rF+WZ61TESZvq80a21gRlwcFXjnNQORAqL7ndR4QpUIHXgpDjT0gA1iCTFl7f55CLy+wdd37Jefl5HPh7tlosTOS5WgdW4tyI7shm181cP/Jh//P23OvvoCE9B8WcFG+l3qyqVSFkanmvaupgTonGyMW8j8AUQS4/5I1bvN6hkZxlhcko8Tex2McpfHNhnNMGLvq8pRmKaYrDmXqRO8KEomKS/2LUSKoD8PLjE64gLrCG42SWM/YXc2T34oQwHqto944JmiGs/gfQKe1nTRdMDzFRnMvOebNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ily4fre0eXWhoRchy9lLKEbdpkvlUuNvtKQrE828g+U=;
 b=IKYE2vclRkZj75ozXBmUWN4wdkqasHBV+IZe4RaXM+EzSwlIZxAG53F8XmiPMQYwnjZXsl5JHnCFfdTOKFHnHy3IQO33zqoHP7ua1gSdCUij2qhqAbVY9po+sWvmjhX+Yl35yvUnreN7VYxHtkxF5DqNsyFYi7qdY/cUE+1aN4UB9hzqCgCOld/xD3uDYv8eF3BRLctOFCz4edEeoEVe3eokIodrpDfPtPl4hxJOFEaJc6T1p6Yk96/pkGPTAafkG3g3FhL9zCzCZVECBaudl6e/f0m5ChDFCPMVJVsiIE3H3iIELArWdTZIRklNrPYWnZe05xjKK16oIT6z9079Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ily4fre0eXWhoRchy9lLKEbdpkvlUuNvtKQrE828g+U=;
 b=YDZLUjIjq2X1OZt4d2evgXu8nXOqQOP1Vvx5Qb4BaI/wU+8k0MU5RMTUzYbWMVZxEh2ZEA8ZF8sDSnk/xGbmjfM53gFaOWAu8flSd5+RYScAbKwY21xCEFE4Hq+A679jBiulM/lXcAOHrZj46UD4XXPzfXZ6oJ9Cyq6qTa5IgHc=
Received: from CY5PR19CA0078.namprd19.prod.outlook.com (2603:10b6:930:69::25)
 by IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:47 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::3) by CY5PR19CA0078.outlook.office365.com
 (2603:10b6:930:69::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:36 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:36 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 40/95] drm/amdgpu: Add UALink cross-GPU TLB shootdown and
 remote interrupt
Date: Fri, 21 Aug 2026 15:34:03 -0400
Message-ID: <20260821193458.808626-41-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|IA0PR12MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b4515a-b962-4df4-56d3-08deffbb649f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|22082099003|18002099003|56012099006|10067099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: yVGqkq2TZG99dgguaV3msaAGPRC33iTwqyFi+4HTe/94WURwhtC2Sq4sYZkBc/bQQND6kVcuA8rlXIg/S3Lc+prXE8gCGtLZA5ZAaUkjPUxeQb+bSFXgOjQV50Tz7erzEpH0pDNtj5oBFqI2oqaAbS6OXejrCn3mbVNWSgOzo2eDjbDJR0UeLXUV2SILoDlqRgmp6VJIDifkMQ6ZFJOFmTNAEYQT4BCf9Mpm5W5c0vyxznHZPZ5zpyn65ZPWjP4DPYaHTydkpP1EJ8cHc3yYmram22suNveTF6zBuVujVZ4reD6V3860qhJCrDHpHqtthRXPRfNdlNsBSlfqc/aXcFpZy/rpGUbIslr0/POewqPt98wb3wO8IXYQ3d9fnL+qyX5ZIs8nJm7q53T3hUwFhLN2K1i13XjgBXcJjo46zv6gDOCvDBjQVLxSH3xbTreUqaCP2c+e2aEQkYpsHS7V2uWele6G+76sxLaK1Y57mWm2w2JpgsfvsnyoCtruwB3CKfmqvFHTr5JSyqDT87R21DkMLpyNssU7FO4fHbCJIqKzA3y/umfFlynuIFSgtYpUeVUlXQV3AncHuBZCQkwKvrt87oxejgmW8HUZwxVq9xXOnFPuRMbYNesKviZ3GPHhNDM1/gWkdWM0m556JLbfUFgmKKQdjueRMDVcletXkOpTsYuaoh4ezm/Bxqi4XPXn+/zDG+/1N23qzBy7uT9E6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: csvuwNAwoBR/OABRA5HFJ+i6RL53xLajb58YfLqefcTFaS4MYAQj+xEKeW4WxmtI6n4ihJkEroRZNUYxqtOVAJ6mcbnAG3NWByZ1fIR2lelidChJQ6kUXFgBywhKK2kW8fUWAMwRSxAuXGmZpxUGbxahXgJOHHJdmvaOlMCglPeHku1liX6WwU5Cp5p1ssQDd2bfUKIN+diCsNODK6PTmIzjgEik34pdTEeUOwaN7ynCCtkLRky7iIXTnmLm37d/fzXqFxGgqe4ly1jiQUedUlpROWCk31w6uBB4csvgE12r3rcQVEmqYg/lwvfp2WYVHm7Vhd5Tm7z/wKbllJIGZOQ2F+JBhevDipt21y9N0Ad1obg+xPJrQcBCQo6d/BjTirIW/eDN0xKONsuRs1lh4oLD3lSi6FF53VkaOV36hG6lpNld8HKbDLHZ8j3HPAPE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:44.4473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b4515a-b962-4df4-56d3-08deffbb649f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773
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

Expose the two public send operations for remote TLB invalidation and
remote interrupt delivery. Set up per-peer GART entries covering ring
buffers, write pointer pages, and doorbells for every active remote GPU.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 244 +++++++++++++++++++++
 1 file changed, 244 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index dd95e13570d1b..35c9f8de60961 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -2721,3 +2721,247 @@ static int amdgpu_ualink_update_wb_address(struct amdgpu_device *adev,
 	return r;
 }
 
+/**
+ * amdgpu_ualink_remote_shootdown - Send a remote TLB invalidation request
+ * @adev: amdgpu device pointer
+ * @remote_accel_id: accelerator ID of the remote GPU to shootdown
+ * @addr: page-aligned address to invalidate
+ * @size_in_pages: number of pages to invalidate, 0 to invalidate entire TLB
+ * @flush_type: type of TLB flush to perform
+ *
+ * Sends a remote TLB shootdown command to the specified peer GPU via the
+ * UALink ring buffer. The address and size are translated using the S-field
+ * encoding before being written to the ring.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
+				   u32 remote_accel_id, u64 addr,
+				   u32 size_in_pages, u32 flush_type)
+{
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+	struct amdgpu_ualink_peer *peer;
+	struct amdgpu_ualink_ring *ring;
+	int r;
+
+	peer = &remote->peer[remote_accel_id];
+	ring = &peer->shootdown;
+	if (!ring->ready) {
+		dev_dbg(adev->dev, "accel_id %u ring not ready\n", remote_accel_id);
+		r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
+						    RB_TYPE_TLB_INV);
+		if (r)
+			return r;
+	}
+
+	r = amdgpu_ualink_send_command(adev, remote_accel_id, ring, ring->wb_cpu,
+				       amdgpu_ualink_emit_shootdown,
+				       flush_type, upper_32_bits(addr),
+				       lower_32_bits(addr), size_in_pages);
+	return r;
+}
+
+/**
+ * amdgpu_ualink_remote_interrupt - Send a remote interrupt to a peer GPU
+ * @adev: amdgpu device pointer
+ * @remote_accel_id: accelerator ID of the remote GPU to interrupt
+ * @dw0: IH context ID dword 0
+ * @dw1: IH context ID dword 1
+ * @dw2: IH context ID dword 2
+ * @dw3: IH context ID dword 3
+ *
+ * Sends a remote interrupt command to the specified peer GPU via the
+ * UALink ring buffer. The four context ID dwords are delivered to the
+ * remote GPU's interrupt handler.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
+				   u32 remote_accel_id, u32 dw0, u32 dw1,
+				   u32 dw2, u32 dw3)
+{
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+	struct amdgpu_ualink_peer *peer;
+	struct amdgpu_ualink_ring *ring;
+	int r;
+
+	peer = &remote->peer[remote_accel_id];
+	ring = &peer->interrupt;
+	if (!ring->ready) {
+		dev_dbg(adev->dev, "accel_id %u ring not ready\n", remote_accel_id);
+		r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
+						    RB_TYPE_REMOTE_INTERRUPT);
+		if (r)
+			return r;
+	}
+
+	r = amdgpu_ualink_send_command(adev, remote_accel_id, ring, ring->wb_cpu,
+				       amdgpu_ualink_emit_interrupt,
+				       dw0, dw1, dw2, dw3);
+	return r;
+}
+
+/**
+ * amdgpu_ualink_peer_remote_init - Initialize remote peer GPU connections
+ * @adev: amdgpu device pointer
+ *
+ * Sets up ring buffers, GART mappings, and control structures for
+ * communicating with remote GPUs in the fabric.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int amdgpu_ualink_peer_remote_init(struct amdgpu_device *adev)
+{
+	u32 rb_pages = AMDGPU_UALINK_RB_SIZE >> AMDGPU_GPU_PAGE_SHIFT;
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+	struct amdgpu_bo *bo = remote->ring_bo;
+	struct amdgpu_ualink_peer *peer;
+	struct amdgpu_ualink_ring *interrupt;
+	struct amdgpu_ualink_ring *shootdown;
+	u32 src_accel_id = ualink_accel_id(adev);
+	u32 dst_accel_id;
+	u64 npa, flags;
+	int r = 0;
+
+	/* NPA mapping PTE flags VSCT = 0011 */
+	flags = amdgpu_ttm_tt_pte_flags(adev, bo->tbo.ttm, bo->tbo.resource);
+	flags |= AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT_GFX12 | AMDGPU_PTE_BUS_ATOMICS;
+	flags &= ~AMDGPU_PTE_VALID;
+	/* PTE.X=0 turn off RPC checks for RBs, wptr and doorbell NPA address */
+	flags &= ~AMDGPU_PTE_EXECUTABLE;
+
+	dev_dbg(adev->dev, "src_accel_id %u gart mapping flags 0x%llx\n",
+		src_accel_id, flags);
+
+	for_each_set_bit(dst_accel_id, remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
+		if (dst_accel_id == src_accel_id)
+			continue;
+
+		dev_dbg(adev->dev, "peer_remote to dst_accel_id %u\n", dst_accel_id);
+
+		peer = &remote->peer[dst_accel_id];
+		mutex_init(&peer->lock);
+
+		interrupt = &peer->interrupt;
+		shootdown = &peer->shootdown;
+
+		/* ring buffer npa gart mapping */
+		npa = amdgpu_ualink_gart_npa_addr(adev, RB_TYPE_REMOTE_INTERRUPT,
+						   src_accel_id, dst_accel_id);
+		r = amdgpu_ualink_gart_map(adev, rb_pages, npa, &interrupt->mm_node_rb, flags);
+		if (r)
+			break;
+		interrupt->rb_npa_gart = adev->gmc.gart_start +
+					 (interrupt->mm_node_rb.start << AMDGPU_GPU_PAGE_SHIFT);
+
+		dev_dbg(adev->dev, "rb npa 0x%llx mapped on gart 0x%llx\n",
+			npa, interrupt->rb_npa_gart);
+
+		/* tlb invalidate ring buffer npa gart mapping */
+		npa = amdgpu_ualink_gart_npa_addr(adev, RB_TYPE_TLB_INV, src_accel_id,
+						  dst_accel_id);
+		r = amdgpu_ualink_gart_map(adev, rb_pages, npa, &shootdown->mm_node_rb, flags);
+		if (r)
+			break;
+		shootdown->rb_npa_gart = adev->gmc.gart_start +
+					 (shootdown->mm_node_rb.start << AMDGPU_GPU_PAGE_SHIFT);
+
+		dev_dbg(adev->dev, "tlb rb npa 0x%llx mapped on gart 0x%llx\n",
+			npa, shootdown->rb_npa_gart);
+
+		/* wptr npa gart mapping */
+		npa = amdgpu_ualink_gart_npa_addr(adev, RB_TYPE_TAILPTR, src_accel_id,
+						  dst_accel_id);
+		r = amdgpu_ualink_gart_map(adev, 1, npa, &interrupt->mm_node_wptr, flags);
+		if (r)
+			break;
+
+		interrupt->wptr_npa_gart = adev->gmc.gart_start +
+					   (interrupt->mm_node_wptr.start << AMDGPU_GPU_PAGE_SHIFT)
+					    + ualink_wptr_offset(adev, src_accel_id);
+		shootdown->wptr_npa_gart = adev->gmc.gart_start +
+					   (interrupt->mm_node_wptr.start << AMDGPU_GPU_PAGE_SHIFT)
+					    + ualink_tlb_wptr_offset(adev, src_accel_id);
+
+		dev_dbg(adev->dev, "rb wptr npa 0x%llx on gart 0x%llx, tlb wptr on gart 0x%llx\n",
+			npa, interrupt->wptr_npa_gart, shootdown->wptr_npa_gart);
+
+		/*
+		 * doorbell npa gart mapping, doorbell NPA address coding
+		 *
+		 * ReqAddr[51:40] = 0xFFF
+		 * ReqAddr[39:30] = GPU accel_id
+		 * ReqAddr[29:12] = 18'h00000
+		 * ReqAddr[11:8]  = Random value
+		 * ReqAddr[7:6]   = PMI Index
+		 *     0 - PMI0 Remote Interrupt
+		 *     1 - PMI1 Remote TLB Shootdown
+		 * ReqAddr[5:0]   = 6'h0
+		 */
+		npa = 0xFFFUL << 40 | (u64)dst_accel_id << 30;
+		r = amdgpu_ualink_gart_map(adev, 1, npa, &interrupt->mm_node_doorbell, flags);
+		if (r)
+			break;
+
+		interrupt->doorbell_npa_gart = adev->gmc.gart_start +
+			(interrupt->mm_node_doorbell.start << AMDGPU_GPU_PAGE_SHIFT);
+
+		dev_dbg(adev->dev, "rb doorbell npa 0x%llx mapped on gart 0x%llx\n",
+			npa, interrupt->doorbell_npa_gart);
+
+		shootdown->doorbell_npa_gart = adev->gmc.gart_start+
+			(interrupt->mm_node_doorbell.start << AMDGPU_GPU_PAGE_SHIFT) + (1 << 6);
+
+		dev_dbg(adev->dev, "tlb doorbell npa 0x%llx mapped on gart 0x%llx\n",
+			npa, shootdown->doorbell_npa_gart);
+
+		interrupt->rb_size = AMDGPU_UALINK_RB_SIZE / 64;
+		interrupt->wptr = 0;
+		interrupt->rptr = 0;
+		interrupt->seq = 0;
+
+		shootdown->rb_size = AMDGPU_UALINK_RB_SIZE / 64;
+		shootdown->wptr = 0;
+		shootdown->rptr = 0;
+		shootdown->seq = 0;
+	}
+
+	dev_dbg(adev->dev, "peer remote init done r=%d\n", r);
+	return r;
+}
+
+/**
+ * amdgpu_ualink_peer_remote_fini - Clean up remote peer GPU connections
+ * @adev: amdgpu device pointer
+ *
+ * Unmaps GART entries and frees resources for remote GPU communication.
+ */
+static void amdgpu_ualink_peer_remote_fini(struct amdgpu_device *adev)
+{
+	u32 rb_pages = AMDGPU_UALINK_RB_SIZE >> AMDGPU_GPU_PAGE_SHIFT;
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+	u32 src_accel_id = ualink_accel_id(adev);
+	u32 dst_accel_id;
+	struct amdgpu_ualink_peer *peer;
+	struct amdgpu_ualink_ring *ring;
+
+	dev_dbg(adev->dev, "src_accel_id %u\n", src_accel_id);
+
+	for_each_set_bit(dst_accel_id, remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
+		dev_dbg(adev->dev, "dst_accel_id %u\n", dst_accel_id);
+		if (dst_accel_id == src_accel_id)
+			continue;
+
+		peer = &remote->peer[dst_accel_id];
+		mutex_destroy(&peer->lock);
+
+		ring = &peer->interrupt;
+		amdgpu_ualink_gart_unmap(adev, rb_pages, &ring->mm_node_rb);
+		amdgpu_ualink_gart_unmap(adev, 1, &ring->mm_node_wptr);
+		amdgpu_ualink_gart_unmap(adev, 1, &ring->mm_node_doorbell);
+
+		ring = &peer->shootdown;
+		amdgpu_ualink_gart_unmap(adev, rb_pages, &ring->mm_node_rb);
+	}
+}
+
-- 
2.55.0

