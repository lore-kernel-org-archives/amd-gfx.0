Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120DEC624D4
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAA2510EA5F;
	Mon, 31 Aug 2026 18:28:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S6c3jcVz";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012053.outbound.protection.outlook.com [52.101.53.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F46310E50F
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcvHs8VdzzbIrltyD+6SspNmOgCq9P5F30pH2lk97cX+z3P42W5XpaTpcP3dWLaRKbPva9I1/G/6REPMhjYbSXVHsB7OEteiobf9Ci8jzMpyR0w9atNQa05RlI48XJc1muDS0MKWpVO1Atb5tpEIHsXfe8q6oyCbMbv0jzcbx0QATq9Be1dUlS+qGu8JaBF17zsk3ZxUUXy9ro9Dr9rHzfJPuXawjCTD7Up82/DzU4CJjGsGWqX9Emb/a/XQo5+d3AbnxwBu4dfe0jWgydCoDsyVfhDyT/TDL1H7PjE7b7l4FhT0IofY5ZyjEs6XrFVGWgxiueYW8qDFEAFCEMBZtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tg5v9bqy1jo0fqeSZgiuDFxh+22DKcfVwAY9gJZ/iA8=;
 b=fwyDgzXY6CuUsPW9eiD9ro931G0Hz7vnTGhmN97Y+LCXrtc4ZLGO3u/5Pv56m0IaEtYI9KI986Y9JBMKQYWdC6BDEVgYjLMQILG1K1oP9Cxlm764wxUFnzuVE4hbXEGOZraAhduidoEsH/eqh+/C4anwV5TeaxZYjH/p9Vl7FldNZRZq3YGbQzmLFJ5FXNhfl5iX0R+2PNfLYC5XhNICUunURLdBPForYIav1X7I60+ycG7y0N3Wzj4CTQ+S8kPJ/pbnVremxytCJTskmNo3r0RpLHEFR1LpHxEaz/CPktOJpSK8r6CrLITiAW3c00GEQ7aMuEMcyUmEiBFnoqONgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tg5v9bqy1jo0fqeSZgiuDFxh+22DKcfVwAY9gJZ/iA8=;
 b=S6c3jcVz+xnz9Wc+ma3tIsfvGCthFaEJlZdMGvu3f7oZu4+a1niKySZ9kTRWD6VYBQnebDtDUuwUBy+guJg7nCfuVrBZ1OuYsn9VmtRtvMpjA4HoK7a+vyEkGr4poHlOOIbjPyr+ERmf0f/H5bnMXQnGGks7GWpM5k4E3lWMxAU=
Received: from CH5P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::23)
 by SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:34 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::25) by CH5P220CA0024.outlook.office365.com
 (2603:10b6:610:1ef::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:33 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:29 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 36/95] drm/amdgpu: Add UALink GART helpers for NPA address
 access
Date: Mon, 31 Aug 2026 14:26:55 -0400
Message-ID: <20260831182754.1089811-37-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|SN7PR12MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: ceb22900-bd0c-4e4f-7b10-08df078daa4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Es67Gn2HCeItUTRdglh56GX18vu4H4Cfs+zQIeSaF3OFNmJgpUHi4R+7HRvPkm35iOFo313dIAby/U6G2GSjOCFnTtiGfMbsNw0CH5qNBCyf3J/9DwE9yKdtN5pNDxg3Sr1T5zpwUXkZWY8jiTW4/5W06dsm602nczXJx7XHIFQmX3H/c2gjCaRpB4ilBFndwiUJGwxpU3CKOGm3n+evoG1GznXpSq60lVKqRl/3GNb0bQcsVi1YyMcHQyPUJCuVL6Q4rIxGx8/Q1jSgjlSljyRbSFIbPm7i8OZlcUVFN/+VncbCmUVak4xaOIYEJQFB9iS9a35l1wjNtzQV6OyMphBw7psCiX2t/4Nujh55IBdHs2BUSJfoMJVXjNVO9UJKVSMwrJ4JfLyha7OJu79VNH5yFI6Dm+0d2X+hyMHiASt7YK0MCREDhn1ZFMMLNzdLfhNjJH2Un86OGAeoMj5sh6DOMbtTiIQxIbqLtekeHuckrN2rIxgIMvVlYJ21s0s1+AjCM+2lvgtlvbc6jyWltL75WUbUbM8bgLULBR6wc9XxPDXaaZWZ6rOIryKMeuYu39sXzPTMwS1o6vG0bhbRxZ2sb9wkZp8JpoXMTyZCDjY9neMimR2uYrOwoY2qmogPzkN1I+jp9MfoQHgTi3weCOIvDyyJHafjwPQuj+iSilSoAuwJWhlZ8GU2ic4BuS2g8/gVwAP+60ctyQ6OUF5H+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0cX+h8ua4BL61HkmVm2y/7ZVKVmqZ+6wrR4yLFQVl2tQhOMRF2OhuB5sAEOMpyL5WRkmpVU/KOt5LfRyW83/1SCyo2mSNy07nK+CSnl93Uj/jTVGB9Zq/6Hd4KHQxUkPLTf76l8cb17uOFntPB85GOFXxi4qM7BzPaW2cFHGr5zXPA2HVgXjnWgWIzUVF8NQlIJAUwzLP4LPWw7zfRghy9HolOE2MtW9rh3iqh9BWMRGh0v7Quol4GpJn3q/hkvQubVl9IQnWAxaqWJamJCJbzxrcUithXcNBAce12Jxg3NbQAVk6ik7qNGwmwaPpUwjyA6dcbFWRkuKIGyG2xG8ZDnSmapJVh74xJph2RnZG6v3gwoOnwbLujUE+mWd5XcpARHmf1S94Z3GTeVpx63/N8mUIfHA+0AM4M3a083MW37U7bwzJd07PRanRCD+ck1n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:33.8249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb22900-bd0c-4e4f-7b10-08df078daa4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670
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

v2: fix 32 bit build (Alex)

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 75 ++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 2cb805dd6cbf5..d7010cde11bb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -2060,3 +2060,78 @@ static void amdgpu_ualink_sdma_entities_fini(struct amdgpu_device *adev)
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
+		dma_addr = (dma_addr_t *)&npa;
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

