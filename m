Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751C4606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zF8XisCX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CB8C10E498;
	Tue, 27 Oct 2026 20:01:47 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010062.outbound.protection.outlook.com
 [52.101.193.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B587A10F7E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 20:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeWbheDtyv6mpHsu7VtgTA+j1Xe+YmyiHWxfFwoTIqyIFL+0cviIeofTlxZUUwBXTLfWtmAe6x1TwafEEn21ypzZTkz1lAxSLm0LcD0M5xMUYp/b4dOWh8ZMWEd6/Xa5aRxjTxAkIOput471E2L/LTDZR++uDdbyt5rD67ViApvXkBoic/SUlH3O76QZvRZej00uXwgVAqTXFFTbu+LNBJSTGRIPhm8RznBMxEzXOS2aWplwi2In362azqoXJMEcfv01Pyj1DkPzN5aeDbCbcYzdPjCgjr5sL5z/1ZoEDCPnQyQFlRIybPEHfu8n3L79DuGy8hRTIBSKz+JRAGjX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suCljZIruTJ53ILmx0i5QpHGYi7DuvulcyJqNvnHCFs=;
 b=qA6UxR/iTVclFqRWuSXhQqiPZcm/UzL7OC12VX3gqeFVjHDIGiskxRSn+KmrMKO9phjwifonmuF3ASngU0pK1WM22To1x1BE8nj9x03GDqokOYPEGuA/vXiQqODtGasBDFeP1NKL3mEGSLw3bIckStjvY2P6U1CWkYul3yICOMLZgc+7pq6y4NEv1kXyt8gxTDaszsP26eTbZY8P2d3SLfLEjyOu5kjZY2ixghPXKdXvJq9nWXQSoLSgkYTW9yS/IRRw2F1swoKOH2X2aD9zcCAdnC6FHZQvjswhQrxtcSw19iuVN83PCdcJrRSTrBWWXT/UZQgoAJRIxOhZdEGaTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suCljZIruTJ53ILmx0i5QpHGYi7DuvulcyJqNvnHCFs=;
 b=zF8XisCXSc0nbkrYkts3cucIUNhv77kY8J8DEftEq/Nj8blUSZovaxnj/sfxQ2LduxSiI+z+EqdaF7QE2ago97LJacuEAgqbFAWz9EFRP7pFB3MMMYqHq2la2sSiZhAlDp7TPxWn7pr6xh3kq3tIFVo0qKbnntFhADi5v1jV+VQ=
Received: from SJ0PR05CA0070.namprd05.prod.outlook.com (2603:10b6:a03:332::15)
 by CH3PR12MB504971.namprd12.prod.outlook.com (2603:10b6:610:34a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 19:59:34 +0000
Received: from PH5PEPF0000002E.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::88) by SJ0PR05CA0070.outlook.office365.com
 (2603:10b6:a03:332::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Tue, 27
 Oct 2026 19:59:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH5PEPF0000002E.mail.protection.outlook.com (10.167.243.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 19:59:34 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 14:59:30 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCHv2 5/8] drm/amdgpu: Set up UALink rings and metadata for
 loopback
Date: Tue, 27 Oct 2026 15:54:18 -0400
Message-ID: <20261027195913.1794477-6-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027195913.1794477-1-mukul.joshi@amd.com>
References: <20261027195913.1794477-1-mukul.joshi@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PEPF0000002E:EE_|CH3PR12MB504971:EE_
X-MS-Office365-Filtering-Correlation-Id: df674c26-e9f0-411b-7914-08df3464d279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|261021123027099003|261022105027099003|261009223027099003|261021121427099003|10067099003|56012099006|261026121527099003|22082099003|18002099003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info: SpNSC2ZWrERNK9Fgd06Gwxs9vatsiCz1sV7PoBNa6jXi8ivuaoIM+fdyURTUHMeMUoxdv1aR9XzJaEIzChwC0Z1aJypXpNJvrb5j+OSFH/79xeRMn1ctCVCDZckvpqq7g3BzI536PjzuCkQ64tKRkVqxlyMFduvkFDJ4G30DuOphBI4/lNAp8lc91lzLR8I8kFdT+c5INooHSmqtlmw1p+7qlEJuLgj2+Da6BnSCQdaXlJOzJppE69nAWc7nzHyVoArE+YrtEstE1KtzSfM++tgrAVS85pLW8dGs2UVJYaoL8edJyu5eTQteLIgsRXNSpf/XzxnVSN8jJVHZCZtIcuIKETri6M4oMvz/GDFA8e5+7Q74WYaoZU1JESheY8Zj4zHExKpykbPkEKnADIkm1CSTphh/cr/j6JyttScL2lhzqTKyNMPcoDCJSefvXxh7ltyMHSz0sQ0nCrnmhk3f32CtHuFR7D1KR8ir9/vb1kaNgefCmuTnmR9jR8fHuZJQRWva+kz+LLkSW9zvBh9eaHG9vISsSltN7jQqV55g31GpzJysmSweKYGnWDDCKjMynUrEIAmwSH/+Dn2ewiySnTAQ1BRKazRkHGfplwIOUBvu24ta4cU3oMolOe+sATXVAmvg/3fp4y05qMMo3gnDvZX0eD3xZhd7ZhyxXZyS9B4I29tSlDJtVx1904L5OfbbkIs4p7awo5Erm4mWUObv9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(261021123027099003)(261022105027099003)(261009223027099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(11063799006)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jPd73qXfBpRGjOK3yeb3McKVWVtD+ej1PECmMpNvqwrcgxYwt1US6VaVfdu7opKOCN6Rv2hUipC8TQDtQ9eANTl5V/I2Q5+OtWUg2gHYwBIU4hSX3U3QxJBGtnZGWi8cvcS5epto8zbGIiIWaiUoxJlFGkMdUSeu7UZXHuNpOwhOuEkpSnf4+poAnNH3a9MxIHL4+uWSZ14hwtw0T/At7diq2TFNTRBwUk3qE6gmuRroDzAIHrZ7rvX3xXrCEkrqgvA+NTHq92X7zXVbfLc9IjOTqE2CPIFyKgBlXSlRq03gjFCvxN4/9zGJza5uDTXGTqqk3fd4YhiPTkvowVgyNJtaZ6pHvEvOY7MafBA4zO9Ma7JGYjXrO4SzwdkXacyHFvjwk0dvQq/6UsK/h7x3pYL3zFnFe4b6/dUkNbXxiqAgAWZKc6AafBD2hXZM6ba6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 19:59:34.1331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df674c26-e9f0-411b-7914-08df3464d279
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH5PEPF0000002E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB504971
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
index 96a6023f51c5..e6272446ff4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3965,7 +3965,13 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
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
 
@@ -5441,11 +5447,28 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
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
@@ -5453,27 +5476,26 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
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
@@ -6058,6 +6080,12 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
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
 
@@ -6279,7 +6307,12 @@ static int amdgpu_ualink_peer_remote_init(struct amdgpu_device *adev)
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
@@ -6402,7 +6435,10 @@ static void amdgpu_ualink_peer_remote_fini(struct amdgpu_device *adev)
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

