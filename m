Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13378CD6E57
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 21:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97F60112398;
	Wed,  3 Jun 2026 21:15:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n82x9xpy";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D854112398
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 21:15:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjQ1wzGwVqalEgzrZ3o9Vo9+LdJSvk9utbnWBvziS4IcYtvVV4Fkaok5FwGwzYrdpWqZjJn/8854Wm6WDRWq9YLx/0HcARgmPNaEG6Q5HA0lQ5OnnkHdmt6HwiGumDrI8oGob564joQiCTQl1KIQNlqf1HeKnuvscpJarbVOi7eVVfasI3CCEPi79l5/cJvR6Mo1ptf5BqSpY/rIbg1bXk8vTUxtR4FFEs11qBepSuFD4eQ1dJPLo00/p9qUAkfxbvHCW9FP1iI8N55s0bAjlVFx+trQ6RugyHLBWFokcsLYhepPIvmFrTZZOGHduQ8effUeJT10HRCZNb46AhoGgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XKdmCOrk4P2e1StaUGRZf0371ReQIcHO3spmJVnXZ0=;
 b=kqJAHI5/Etd9XkoYgpZtqel2ooynLLkMa4QYnQWN7czdE4Rs2XOidxYFm45Wat95IWwb2NCvKFowQexTXKXeE+NDtqkquwQm4sfwVJJslxZM+QPcXrRGdeN3un8KyrRckdwOl6kCI9UZY8OqYV4sgnjIDYKzuN5cNZaSe1M6Pl9/un7fPD8tWDERIJ3TqP6vQCUrcziSPQizLONh3IEufEbjfLrwDP2/qQrBfvNSX2i3c9SNNu0XYmwTJdKYmLUQowBVnZqn6tc1n5KftW/NeYTIzSxOdEQDm2hh/NTremOhp7vYZdK3WTA4K4gqeMOsneG4v75Y8gi+ZY4mn0I3QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XKdmCOrk4P2e1StaUGRZf0371ReQIcHO3spmJVnXZ0=;
 b=n82x9xpybhO8clUzSzoJJOhzuCewP4+VBVlc8JH0uA5Bu823xcfNNgF+ZzEq7ze4YDzmEqwgsQQXkC/eNJwgSvBZFoZHUl6pC7uxlFQrm6Kqc7F/6fomhvZYfj57LN0z2KDnjilW1IseD3PTAUIT4qOhQ3F5xNJM/z9Dhuhebew=
Received: from PH7P220CA0176.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::29)
 by SA3PR12MB7903.namprd12.prod.outlook.com (2603:10b6:806:307::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 21:15:14 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::4a) by PH7P220CA0176.outlook.office365.com
 (2603:10b6:510:33b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 21:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 21:15:12 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 16:15:10 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: amdgpu_device_is_peer_accessible to
 support all BARs
Date: Wed, 3 Jun 2026 17:14:55 -0400
Message-ID: <20260603211455.307285-2-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603211455.307285-1-Harish.Kasiviswanathan@amd.com>
References: <20260603211455.307285-1-Harish.Kasiviswanathan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SA3PR12MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b0e27d-0c1e-43bf-690a-08dec1b53371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: u6zr9T1YgLoc42rJ+4R/93fylqW36dfwvrL/fVp6jU15my/Le/cSpVufXYNLjjEZYW7oUz9BzYQ2bHpLhoMy0QFMoyvs3Ii3VxNXuHfCdr58Fkje/9hw6Ac9ge3kUngQcDpW/NcEzz1xR8sY5RSkkPmSHqN3xZK0shAF6fl5cKMp3KR/NjDJkr7MdDp+hCQPuMTvh8FLmoEeHzeEoVYGhNW7znPZS8eXcKsaEOYTmWs8Bh6JPSEAKJofXrGRvpxHovDF++LGiwcDoZDO7wAmBruXHtWpChNOe7lFbjCEzbqskrmxugMkpyCu0wp2sVtzhbZEEqOGOCBJ/03gmXUK/njY184rHa3LGcGpT3wy2CzrpesSkVU07Dp8dDCQlHfutyGebw5ExohHgr1B0uS/wHvgLmjIRQWgyAFncJ2j7uDQCK3dSYrdafHo5TExAk+hfenr8qysyoDfEsVivix5gAHLgdL+JVXdRVUcYmsqkDlmBBIq5MWIKJcZJlSXGkGHLSiTEqu2wVG1pr6V6mOq47JaFCkCMMvr2IY5cJCVTwiMah5DVQA2jr0kRG2kdk9vpssKjSAvw5i3Mm6+TgQc6NZOUJ7GO9rwJjF1v9GUTlLG4nMipGEEZklMusd/7jFOSicvurZ1ZDmYkXyKCsKP8+zL2il2mjQyXhjA3X009rUZ544lba+V38NYmCWHnYFuu8vH8Mrur46n16AWIS62RIjZITxtKnxmXigaHtP2Gww=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: np0/9l49q22abOAz2JdfoxRkAebNqn9OAgxlT+pGlFGb2TY4zAfshX1N3d1zFRcOSRDCHW8aiHa5DCI4qHnisUCjJTjxQ7CeLO62+9kvwJbHnI6tTJPtixVBwH0lNpxhy3cwwHXcQfVyHTneK1dDiOBjO66sgw1fYrNINxErfqoI8jdZka14U/tq6ravRsXCDNpE6ouN00dnZ3Rv16U/5MGFm3+fDA9hzqW24hKIGJ9LBibh64Vpptpdz2hVyFgI+gXBuuYvH9zdcJ3hIJufHdHZL5ZV1rJ3hwBMMQ7tFe10XH7b2c5khtDZA9irczrExpI34WwytMqCARmu5h0Bp4aRbADBXHypu//gc8KCZeCHH7Y9BiGBTAWE42z/vqUe8DJhxWO93agVwDHVmTcOxXUQ3xIZ8tE2g+U0K957VKJbWCry1N6hVUJl59bgSPh6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 21:15:12.8608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b0e27d-0c1e-43bf-690a-08dec1b53371
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7903
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

amdgpu_device_is_peer_accessible was initially written to check peer
VRAM access, however, it is getting called for DOORBELL & MMIO range.
Add support for these also

v2: Updated  comments in function amdgpu_device_is_peer_accessible()

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 15 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 77 +++++++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  2 +-
 4 files changed, 78 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8e7de8d436f5..42658574912b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1424,7 +1424,8 @@ enum amdgpu_pcie_bar {
 int amdgpu_get_bar_idx(struct amdgpu_device *adev, enum amdgpu_pcie_bar bar);
 
 bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
-				      struct amdgpu_device *peer_adev);
+				      struct amdgpu_device *peer_adev,
+				      enum amdgpu_pcie_bar pcie_bar);
 int amdgpu_device_baco_enter(struct amdgpu_device *adev);
 int amdgpu_device_baco_exit(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 7c01492e69dd..3df92b49d478 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -900,8 +900,19 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
 		if (mem->domain == AMDGPU_GEM_DOMAIN_VRAM)
 			same_hive = amdgpu_xgmi_same_hive(adev, bo_adev);
-		if (!same_hive && !amdgpu_device_is_peer_accessible(bo_adev, adev))
-			return -EINVAL;
+		if (!same_hive) {
+			enum amdgpu_pcie_bar bar;
+
+			if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL)
+				bar = AMDGPU_PCIE_BAR_DOORBELL;
+			else if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)
+				bar = AMDGPU_PCIE_BAR_MMIO;
+			else
+				bar = AMDGPU_PCIE_BAR_VRAM;
+
+			if (!amdgpu_device_is_peer_accessible(bo_adev, adev, bar))
+				return -EINVAL;
+		}
 	}
 
 	for (i = 0; i <= is_aql; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 48409b28ff55..6b04d8486217 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6218,36 +6218,83 @@ static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev)
  *
  * @adev: amdgpu_device pointer
  * @peer_adev: amdgpu_device pointer for peer device trying to access @adev
+ * @pcie_bar: PCIe BAR role to check (enum amdgpu_pcie_bar)
+ *
+ * Return true if @peer_adev can access (DMA) @adev through the specified
+ * PCIe BAR. For VRAM, @adev must be "large BAR" and the BAR must match
+ * the DMA mask of @peer_adev. For doorbell and MMIO BARs, only the DMA
+ * addressability and P2P chipset support are checked. Doorbell P2P is
+ * only supported on Bonaire and newer ASICs.
+ *
+ * @note: CONFIG_HSA_AMD_P2P indicates support for P2P DMA mappings. Query
+ * P2PDMA distance only if the kernel has all the prerequisites for P2P DMA
+ * support.
  *
- * Return true if @peer_adev can access (DMA) @adev through the PCIe
- * BAR, i.e. @adev is "large BAR" and the BAR matches the DMA mask of
- * @peer_adev.
  */
 bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
-				      struct amdgpu_device *peer_adev)
+				      struct amdgpu_device *peer_adev,
+				      enum amdgpu_pcie_bar pcie_bar)
 {
 #ifdef CONFIG_HSA_AMD_P2P
-	bool p2p_access =
-		!adev->gmc.xgmi.connected_to_cpu &&
+	bool p2p_access = true;
+	bool p2p_addressable = false;
+	resource_size_t bar_base = 0, bar_size = 0;
+
+	/* VRAM requires large BAR (full VRAM visible) for P2P access */
+	if (pcie_bar == AMDGPU_PCIE_BAR_VRAM) {
+		if (!adev->gmc.visible_vram_size ||
+		    adev->gmc.real_vram_size != adev->gmc.visible_vram_size)
+			return false;
+
+		/* VRAM on CPU-connected xGMI devices is accessed via
+		 * coherent fabric, not PCIe BAR P2P
+		 */
+		if (adev->gmc.xgmi.connected_to_cpu)
+			return false;
+	}
+
+	switch (pcie_bar) {
+	case AMDGPU_PCIE_BAR_DOORBELL:
+		if (adev->asic_type < CHIP_BONAIRE)
+			return false;
+		bar_base = adev->doorbell.base;
+		bar_size = adev->doorbell.size;
+		break;
+	case AMDGPU_PCIE_BAR_MMIO:
+		bar_base = adev->rmmio_base;
+		bar_size = adev->rmmio_size;
+		break;
+	case AMDGPU_PCIE_BAR_VRAM:
+	default:
+		bar_base = adev->gmc.aper_base;
+		bar_size = adev->gmc.aper_size;
+		break;
+	}
+
+	if (!bar_base || !bar_size) {
+		dev_dbg(adev->dev,
+			"Invalid BAR%d configuration for P2P access (role %d)\n",
+			amdgpu_get_bar_idx(adev, pcie_bar), pcie_bar);
+		return false;
+	}
+
+	p2p_access =
 		!(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) < 0);
 	if (!p2p_access)
 		dev_info(adev->dev, "PCIe P2P access from peer device %s is not supported by the chipset\n",
 			pci_name(peer_adev->pdev));
-
-	bool is_large_bar = adev->gmc.visible_vram_size &&
-		adev->gmc.real_vram_size == adev->gmc.visible_vram_size;
-	bool p2p_addressable = amdgpu_device_check_iommu_remap(peer_adev);
+	p2p_addressable = amdgpu_device_check_iommu_remap(peer_adev);
 
 	if (!p2p_addressable) {
 		uint64_t address_mask = peer_adev->dev->dma_mask ?
 			~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
-		resource_size_t aper_limit =
-			adev->gmc.aper_base + adev->gmc.aper_size - 1;
+		resource_size_t bar_limit = bar_base + bar_size - 1;
 
-		p2p_addressable = !(adev->gmc.aper_base & address_mask ||
-				     aper_limit & address_mask);
+		p2p_addressable = !(bar_base & address_mask ||
+				     bar_limit & address_mask);
 	}
-	return pcie_p2p && is_large_bar && p2p_access && p2p_addressable;
+
+	return p2p_access && p2p_addressable;
 #else
 	return false;
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index f57da088f1f8..b77acf97fbc8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1497,7 +1497,7 @@ static int kfd_add_peer_prop(struct kfd_topology_device *kdev,
 
 	if (!amdgpu_device_is_peer_accessible(
 				kdev->gpu->adev,
-				peer->gpu->adev))
+				peer->gpu->adev, AMDGPU_PCIE_BAR_VRAM))
 		return ret;
 
 	if (list_empty(&kdev->io_link_props))
-- 
2.43.0

