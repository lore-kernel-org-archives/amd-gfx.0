Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A1BC5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1FCA10E330;
	Fri, 21 Aug 2026 19:51:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="psgN8B/2";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013057.outbound.protection.outlook.com
 [40.93.196.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DC5610E330
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:50:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOi6yD0cjiNY0lixAPaOTzdipMW7wd+XsNDli3jL2kG3NomiKlVuRRpU/jIxRJnb2t9jn0FBOejD5CEcB/rNUxfx+v0LnghOK8s5LQ1FxkPcHjH6kADi7eAP3MlXAZQKSsuqxSHXb/Fx8q7PR8qNh/FKqtplo+RLXS1d88jyikQ63Par2or02mML6P5K62BvlKK8VCnqozapMEcLIinYXoh4V7P0XmqHQC6wqNQEo6fYKC9qrbSmOf4OfpadEOgGMn5XEztQmkyUQPiDjIzGYn28dlMa9KMyBpDc/Lroxkwrth4JEMteX39fJ5xxwk+sEErKglQ9qsZCKJKzvGPIlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ljcXGXMVr8ImCIeKcB2v3B0ourDpF4BP8KMqw7TOqU=;
 b=kRfqf9jiJvMNhJTCJNzpMup3uXfYz4L81p01JRB/ZvYZDjLdIjZLlR/v7iFMZJA6NJr5InF3+K5Xcw2xA4DjHkKg61hasuqBzPzD6aRdy0FJWutWPSDcz9lWL+JKVdU/CLrd0ZAthLu5wbt87F6lyFm8H6uHsfBNK2MPZ/hM6c5lqZUGFn6eEwaUt3cgaYlVGSSdgWcGBqhN00BCv87RtAOEmraLPGoTrbNq3PuAEcwa7hh9IcO60jnIhycOPzgADeKl7vN7X5GXgpRbfoxZ+rjRd8/2C81DnYXLEY1ihiEKgjQcY8g0qFOF0qBWwSaDkZVvQ2bHuODib4uWRFmGaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ljcXGXMVr8ImCIeKcB2v3B0ourDpF4BP8KMqw7TOqU=;
 b=psgN8B/2Gxxc4roAUvjsAIPHSqb2ryLlZRZP1P2gdz50fVXhKQm1QRQEQcJko9aAz8feSkR6Hxw4GNu+mOi4DvewtEzXc54D2ELcdSK6YAERZOhpGGX0XGhvPNhJMXGAKhEAg+2wQMM7vqz8dh/xpajuFTDwBVxyEwfPuUfzZoc=
Received: from CH5PR02CA0010.namprd02.prod.outlook.com (2603:10b6:610:1ed::22)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:38 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::4d) by CH5PR02CA0010.outlook.office365.com
 (2603:10b6:610:1ed::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:33 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:33 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 36/95] drm/amdgpu: Add UALink GART helpers for NPA address
 access
Date: Fri, 21 Aug 2026 15:33:59 -0400
Message-ID: <20260821193458.808626-37-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|DM6PR12MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: 822c2d69-ef98-4ef9-8f32-08deffbb60dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: HM+cSuL7lsqR1FKkwzobLFat3hFbdaFH66NpNDbwY8Z2h+zAvT0mq6BoBB5x3XEuWODYh4d0Aun8awT1OkkXioSSPNnK2py+nD7zlVe/cFM5pVn503mQFbZQ8+LLmku6gqqO9TbBTxLnxkpU6rYWAtNzDnXqO6xG8za2cYZtUIVbQLdScNMMBdvStUVGSxBeY2iqM4fU6Y4/OP7YNdDLr/ipwh+621DfDcCOoHbGgiGGWhdEClqWQ2MaPSRHYELGVpijq1tkPtBapVV/xXfPXZVgHuMs8xbYsF8WNCA6rjXAYdF5dsaHqYQvLtfKQXiYIZadMnG6o2mNjIfO1UrBSUKWuSjJCubqCPoaTNYwrlS2uXwKat3SywWAeMosJrXq6obqUMSi3U4qkV5kNsLiK/FEcG7EviSgJUabPA+9VZmwwh78pr6DbKB21gZuoTaJ9KyEUxb+qFGglOwiS0lv0CDz7QBLI0Cchi5C/NeGl1k+OnZOuCavXx55sq7ZUjEjsGCrtoRGYVgXf9JYplhUnyKL1qxw/m0OEnFN3liCZrYu2qhct03d7721xolpvjCdyXqDHd00a3rtbDSxRwuBuy5kVg/aXZ3vK5pHbvUsBOBU/nS5nQ9UTZ+z5NkEb7ahnZbB9iTty/z7u9i0JG1DlQz7qeZJA490TS1hrOU757CJm2m5wQVttaL84pjt8sQONmTyhWt4mivkDvj20KLqxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oZ1Xb6A+iSEbkyDCdhX/zG2Z8WU0mrBgZJkn3GiWokXqRLreUthcEPE2Hi54ui3pDiKaqW/M1B3WkysuOQ310VG6TeQkviElsICnq+QNmHG6r+JqSx31w5ueWcfbRjiGPOWaMys1pQj+I2q9jHL/IPD0hsDE+fhjvkYzUVyzzKiG7ac1ZtJYxG9R4TRiWYJ0hZsHmQsoYyGnq3INYdheYYDdsQBz1djZeKDSU2QoRXvVaTbUWyQZ9HgQVwZ2yOmWYT9HC6wboQUqFswng2avzs3RWk+GyjoBbrpiIER9KqIMPauySHHPWaPA6GkAbPSPfHtLfFqeKfjf3LyB0AGpalK0bIhSNvAKcv1wtnS35Cu6/5eZPIw578fQnhltdETBCrkCamtlSNShgDvhmHpFWbHspCABtPy2Tjif0t/Vc6HdgZgk3YdlMVYk8oQRs7nA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:38.1729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 822c2d69-ef98-4ef9-8f32-08deffbb60dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091
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

Add helpers to insert and remove NPA addresses in the GART page table
without a TTM buffer object, allowing the local SDMA engine to reach
remote GPU ring buffers, write pointer pages, and doorbell addresses.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 75 ++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index abbb24330c0af..69abb61e95238 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -2015,3 +2015,78 @@ static void amdgpu_ualink_sdma_entities_fini(struct amdgpu_device *adev)
 	dev_dbg(adev->dev, "exit\n");
 }
 
+/**
+ * amdgpu_ualink_gart_map - Allocate GART entry and map NPA address
+ * @adev: amdgpu device pointer
+ * @npages: Number of pages to map
+ * @npa: NPA address to map
+ * @mm_node: DRM memory manager node for GART allocation
+ * @pte_flags: the GART mapping flags
+ *
+ * Allocates GART entries and sets up NPA address mapping without TTM BO.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int amdgpu_ualink_gart_map(struct amdgpu_device *adev, u64 npages,
+				   u64 npa, struct drm_mm_node *mm_node,
+				   u64 pte_flags)
+{
+	struct ttm_resource_manager *man =
+				ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
+	struct amdgpu_gtt_mgr *mgr =
+				container_of(man, struct amdgpu_gtt_mgr, manager);
+	dma_addr_t *dma_addr;
+	int i, r;
+
+	dev_dbg(adev->dev, "npa 0x%llx npages 0x%llx\n", npa, npages);
+
+	if (npages > 1) {
+		dma_addr = kmalloc_array(npages, sizeof(*dma_addr), GFP_KERNEL);
+		if (!dma_addr)
+			return -ENOMEM;
+
+		for (i = 0; i < npages; i++)
+			dma_addr[i] = npa + i * AMDGPU_GPU_PAGE_SIZE;
+	} else {
+		dma_addr = &npa;
+	}
+
+	r = amdgpu_gtt_mgr_alloc_entries(mgr, mm_node, npages, DRM_MM_INSERT_BEST);
+	if (r)
+		goto out;
+	amdgpu_gart_bind(adev, mm_node->start << AMDGPU_GPU_PAGE_SHIFT, npages, dma_addr,
+			 pte_flags);
+
+out:
+	dev_dbg(adev->dev, "npa 0x%llx mapped to 0x%llx npages 0x%llx r=%d\n",
+		npa, mm_node->start << AMDGPU_GPU_PAGE_SHIFT, npages, r);
+
+	if (npages > 1)
+		kfree(dma_addr);
+	return r;
+}
+
+/**
+ * amdgpu_ualink_gart_unmap - Unmap and free GART entry
+ * @adev: amdgpu device pointer
+ * @npages: Number of pages to unmap
+ * @mm_node: DRM memory manager node for GART allocation
+ *
+ * Unbinds GART mapping and frees allocated entries.
+ */
+static void amdgpu_ualink_gart_unmap(struct amdgpu_device *adev, u64 npages,
+				      struct drm_mm_node *mm_node)
+{
+	struct ttm_resource_manager *man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
+	struct amdgpu_gtt_mgr *mgr =
+				container_of(man, struct amdgpu_gtt_mgr, manager);
+
+	dev_dbg(adev->dev, "0x%llx npages 0x%llx\n", mm_node->start << AMDGPU_GPU_PAGE_SHIFT,
+		npages);
+
+	if (!drm_mm_node_allocated(mm_node))
+		return;
+	amdgpu_gart_unbind(adev, mm_node->start << AMDGPU_GPU_PAGE_SHIFT, npages);
+	amdgpu_gtt_mgr_free_entries(mgr, mm_node);
+}
+
-- 
2.55.0

