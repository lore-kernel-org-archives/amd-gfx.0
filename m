Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343A3606A31D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 23:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wG2DlYjm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBC1410F1B3;
	Mon, 26 Oct 2026 23:03:19 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012005.outbound.protection.outlook.com
 [40.93.195.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F07410F1B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 23:03:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMKuLbX94RZJ8ex1FyqbdOeI9whr7+49nAAjwJgm/ejzQjDqDTJZ+MfQVuZJ8aY1kINvs5oeXLprh7lPNpSpckqcwlVOOIFTDaD3/WRoQIM0hUuu+jdvdcxgm4V1M58acyk1E5yzvc+5mfE+MSq2hRRQl0oMfefRyJ8mBSmha4Kzpr3q45WMLp5p9EN5341EXUStedkgtHMeR0aho27dAEOkBXA9KVXZcw9SRq/fYjfqOGn2UcFWAiB68rAPCna4kXmyhB3k+LOdmtM0VgIP4rHd0ysanCZaFHQ7qE6u+/oyqTVyd1RVEo6J6iY8Wuz7o6VU748V/A3H8IpKdOHJ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsY8GCUMQI+5D5gi47ISqUFQ5sqfIcJMHdjK9qcJHHg=;
 b=sFisN00bAb/5+ojps1wcDyoCEQwZeoXK/bsJvmDSYEnYlU7gZPIJwe60jEbbnRI5EWgZymLkKDBybl3SQnwqaq/f8QD9SyWhpcFZs1118u705Djfzd6v6K3wBLUr3lj4ov21z8ANhf0RuE99oVMDDrFN1SHfSyG61s4IEOR87swaG4X1CVGhy/Rz2FpQH02sFn1ng9YAvRo1OpWU+Kc0Y/RkDrgKhRTeT3KowGigsWo+8HuRQTO+Op8LII0EL+4Iy9zev+tXNNfqCHsw16vEK/rx7iFftd/jR+dgqGpuQFcXnodbZA8uSZTqYHfI8SgwyGClYw//uAp2TgyFBs0ESw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsY8GCUMQI+5D5gi47ISqUFQ5sqfIcJMHdjK9qcJHHg=;
 b=wG2DlYjm5T90AVFKJNpmL9TeBeI9R+1ldSR5MeguC+wGg8CXK+QXEQ4N1y14V12G8HNaHLV+k4LFRxe9aIe95bLjxMcwjhGTFSr8E+qdtsAlk8C4+kC8VVLo9oNUsvnap0Re9rgKD2dvTsYXkE27sNn6w6diN/PEii2iHUm/LhA=
Received: from BN0PR07CA0006.namprd07.prod.outlook.com (2603:10b6:408:141::23)
 by CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 23:03:05 +0000
Received: from BN3PEPF00022BBB.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::92) by BN0PR07CA0006.outlook.office365.com
 (2603:10b6:408:141::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 23:03:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBB.mail.protection.outlook.com (10.167.248.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 23:03:05 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 18:03:04 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH 5/8] drm/amdgpu: Set up UALink rings and metadata for loopback
Date: Mon, 26 Oct 2026 18:59:27 -0400
Message-ID: <20261026230248.1597606-6-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026230248.1597606-1-mukul.joshi@amd.com>
References: <20261026230248.1597606-1-mukul.joshi@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBB:EE_|CY5PR12MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: fafccef9-4a1a-4230-f2ef-08df33b54b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|10067099003|22082099003|18002099003|261026140227099003|56012099006|11063799006|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: ceOuFRdbZr1boK4NXS0RDWNGsS/SgtcNdFmJjeoPwHBRBm1i36F8b6yCr3hgnvZtUNVQfjzjQA+bur/4sdpQwOpJcF/2lIrYucrpTXKTEqhsH4c2ELM7Uarp7BfycJBcj1Raxd4LPLdqvnQQyd9WS9XTzoQQ1wqWpVLPrHuAj/sxwlL3E/yKh7F5ZEsjnk2MX7w09w4Ik/PQgLgLoLFdjAYXGYV+6I5EhNNx/yLM6r5fRAnpjs7OzrXrciUKfmr5ClWd2W7lieElvSZfKCcSj+VU/al0TM+xHNBHJEDkXS6avuafkULAn+gqZfLq4pcnbsT4qU7RAijXf4nyYAn910rioI4MHptjsbb/n5fpCFJcihyH486WfX6o6bGUY+Yi3kvwwRB1k02fJqUDgAAw5IOt4dzDRO1YydWsOx4G49bRfMNFhhKubUt7VcdcQU++BmU+0Em9rOXut3L0mEnP42wz1e1sa70fyOxP+o0PCdb1sG5/fPPZ47hhtdAo7UIfMBbzcdT6MWrC+dW9oH/vDRGI2AJKtgRZBayDB4Gy4KRhQzDlWm6tOHjUFTAwvSELnJ3Vx9dkVHgNNKhHng3G6qmL0aJyTOLcNBwOqtHyjVh1joKRhLPijolOvGyeRSfB8LH9NddvbS86OTFXo7DtZzWmICKeaQTsKNZ3LQNskpsx+QBq2tCQTXvu7Nw4zI1cmfDBccBAjhe3zI+xsWqYug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(10067099003)(22082099003)(18002099003)(261026140227099003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tSDOWss5aRgWY9uFdhjQ9mSlPgqED5XTTUgHICleHX87Ku2fzG8rST5hVC8qaNVK1PKfaMVMh+fUw02rXvtW9X3r+xOsTDC2X7mjPVOiWzTuuwGMXjOc9mWgJ5E4Oyj57/ApSl4nfSgWZw5FxXNKd4ZiRSel763v9w/5DMdzLmLoUGsJJux6lvFX3NJfqLSMcAlzsys5y5wNx4MniEfsfBPtCbxqAh5tKIQq9t7yoT9bS2lYZKBBnfQZEwSAchQ6Dq+ngPU36oqvaKHFMWtfREP6rUL3YZ5FyQEnkAkQFxt2m4fFF3FG0eXm3+5zxcBn7x3nhvCmykzN95TThf+/iyp8ILUgbf6RzI40TK6xR+qqa93iciYM2AT20CdKYIA1gAztDGUpN+86JfIDU/2ZUOTcMwnaw7FYzMbTRC2Oq0YUM7ww09kNgDWfmOUbATgY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 23:03:05.3831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fafccef9-4a1a-4230-f2ef-08df33b54b3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In UALink loopback mode a single GPU acts as both the exporter and the
importer, and the only path the HW serves is importer -> exporter.
Adjust the per-peer setup accordingly:

- The importer's doorbell reaches the MP nHT stamped with the GPU ID of
  the exporter, and the FW looks up the metadata entry by that ID. So
  publish the importer's rings and tail pointers in metadata[exporter].

- The local sender of the HW-served direction is the importer, so set
  up (and tear down) the send rings with the importer as the source.

- Skip the ring pointer resync. Both ends of every ring are on this
  GPU, so there is no remote peer that can reboot and leave the
  pointers stale.

- Do not take the local dma-buf shortcut on import. It would bypass
  the NPA path that loopback is meant to exercise.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 66 +++++++++++++++++-----
 1 file changed, 51 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 233ca804c4cf..9326836f4f4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3961,7 +3961,13 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
 		return -EINVAL;
 	}
 
-	if (amdgpu_ualink_is_local_accel(adev, remote_acc_id))
+	/* In loopback mode the exporter and importer are the same GPU, but the
+	 * import must still go through the full cross-domain NPA path (the
+	 * dma_buf shortcut in amdgpu_ualink_local_import() bypasses NPA). Only
+	 * take the local shortcut for genuine same-pod local accelerators.
+	 */
+	if (!adev->ualink.loopback.enabled &&
+	    amdgpu_ualink_is_local_accel(adev, remote_acc_id))
 		return amdgpu_ualink_local_import(adev, remote_acc_id,
 						  &handle, fd_out);
 
@@ -5454,11 +5460,28 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 		wptr_gpu_addr = remote->rb_gpu_addr + rb_size * ualink_exp_accel_id(adev);
 
 	for_each_set_bit(accel_id, remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
+		struct amdgpu_ualink_metadata *md;
+
 		dev_dbg(adev->dev, "init for accel_id %u\n", accel_id);
 
 		if (accel_id == ualink_exp_accel_id(adev))
 			continue;
 
+		/* In loopback the single MP nHT services the exporter half:
+		 * the only messages delivered over HW are importer -> exporter
+		 * (source = importer accel_id), while the exporter -> importer
+		 * direction is emulated in SW and never reaches the MP nHT.
+		 *
+		 * The importer's doorbell reaches the MP nHT stamped with the
+		 * GPU ID of the single physical station, the exporter, so the
+		 * FW looks up metadata[exporter]. Publish the importer's rings
+		 * and tail pointers in that entry.
+		 */
+		if (adev->ualink.loopback.enabled)
+			md = &metadata[ualink_exp_accel_id(adev)];
+		else
+			md = &metadata[accel_id];
+
 		rb_gpu_addr = remote->rb_gpu_addr + rb_size * accel_id;
 
 		if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT) {
@@ -5466,27 +5489,26 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 			wptr_gpu_addr += wptr_size * accel_id;
 		}
 
-		metadata[accel_id].header = AMDGPU_UALINK_METADATA_HEADER;
-		metadata[accel_id].rb_size = fls(AMDGPU_UALINK_RB_SIZE / 64) - 1;
+		md->header = AMDGPU_UALINK_METADATA_HEADER;
+		md->rb_size = fls(AMDGPU_UALINK_RB_SIZE / 64) - 1;
 
 		/*
 		 * remote shootdown type is 0, remote command type is 1
 		 * with 2MB ring buffer mapping, remote shootdown ring NPA is before interrupt
 		 */
-		metadata[accel_id].ri_rb = rb_gpu_addr + AMDGPU_UALINK_RB_SIZE;
-		metadata[accel_id].tlb_inv_rb = rb_gpu_addr;
+		md->ri_rb = rb_gpu_addr + AMDGPU_UALINK_RB_SIZE;
+		md->tlb_inv_rb = rb_gpu_addr;
 
-		metadata[accel_id].tailptr_ri = wptr_gpu_addr +
-						ualink_wptr_offset(adev, accel_id);
-		metadata[accel_id].tailptr_tlb_inv = wptr_gpu_addr +
-						     ualink_tlb_wptr_offset(adev, accel_id);
+		md->tailptr_ri = wptr_gpu_addr + ualink_wptr_offset(adev, accel_id);
+		md->tailptr_tlb_inv = wptr_gpu_addr +
+				      ualink_tlb_wptr_offset(adev, accel_id);
 
-		dev_dbg(adev->dev, "init from accel_id %u to accel_id %u, rb_size 0x%x\n",
-			accel_id, ualink_exp_accel_id(adev), metadata[accel_id].rb_size);
+		dev_dbg(adev->dev, "init from accel_id %u to accel_id %u, metadata entry %td, rb_size 0x%x\n",
+			accel_id, ualink_exp_accel_id(adev), md - metadata, md->rb_size);
 		dev_dbg(adev->dev, "rb 0x%llx tlb rb 0x%llx\n",
-			metadata[accel_id].ri_rb, metadata[accel_id].tlb_inv_rb);
+			md->ri_rb, md->tlb_inv_rb);
 		dev_dbg(adev->dev, "rb wptr at 0x%llx tlb wptr at 0x%llx\n",
-			metadata[accel_id].tailptr_ri, metadata[accel_id].tailptr_tlb_inv);
+			md->tailptr_ri, md->tailptr_tlb_inv);
 	}
 
 	r = adev->ualink.msg_ctl->send_metadata(adev,
@@ -6067,6 +6089,12 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
 	u64 int_wptr, tlb_wptr;
 	int r;
 
+	/* UALink loopback: both ends of every ring live on this GPU, so there
+	 * is no remote peer that can reboot and leave the pointers stale.
+	 */
+	if (adev->ualink.loopback.enabled)
+		return 0;
+
 	/* ring->wptr and ring->rptr are owned by the send path. */
 	guard(mutex)(&peer->lock);
 
@@ -6288,7 +6316,12 @@ static int amdgpu_ualink_peer_remote_init(struct amdgpu_device *adev)
 	struct amdgpu_ualink_peer *peer;
 	struct amdgpu_ualink_ring *interrupt;
 	struct amdgpu_ualink_ring *shootdown;
-	u32 src_accel_id = ualink_exp_accel_id(adev);
+	/* This sets up the send rings (local sender -> each remote dst). In
+	 * loopback the HW-served direction is importer -> exporter, so the
+	 * local sender is the importer; the skip below then skips the importer
+	 * and sets up the peer[exporter] ring that the HW path needs.
+	 */
+	u32 src_accel_id = ualink_imp_accel_id(adev);
 	u32 dst_accel_id;
 	u64 npa, flags;
 	int r = 0;
@@ -6411,7 +6444,10 @@ static void amdgpu_ualink_peer_remote_fini(struct amdgpu_device *adev)
 {
 	u32 rb_pages = AMDGPU_UALINK_RB_SIZE >> AMDGPU_GPU_PAGE_SHIFT;
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
-	u32 src_accel_id = ualink_exp_accel_id(adev);
+	/* Mirror peer_remote_init: in loopback the local sender is the
+	 * importer, so unmap the peer[exporter] send ring that was set up.
+	 */
+	u32 src_accel_id = ualink_imp_accel_id(adev);
 	u32 dst_accel_id;
 	struct amdgpu_ualink_peer *peer;
 	struct amdgpu_ualink_ring *ring;
-- 
2.55.0

