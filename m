Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1994AFF886C
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 21:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADF1210EBAA;
	Tue, 28 Apr 2026 21:56:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dob/ZTk8";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012021.outbound.protection.outlook.com [52.101.53.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4B0710EBAA
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 21:56:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfSZAh4f6an5ao9JpuV3+SLI8WeJ77j9no8CCHIoJs5rLB8M6h0YVGQCK0QvR9ackBAGQ4pX9FR9TVrcrFcacBHU/JtwF/fK51oNvkQ7DOgBYmaEY5l4YbqMs5AF/E1l1TOIS8vUsmJPD0hovYZSZwQjUYcXWjns6hp5sue2WxNdoy8/uk4EZpnqKqq33sjFB/uukQrLECjJ4NRt5sz84AB83qqogCfl+6on139XfVLO2jlR+uXwfRItyv7KdKvTcYzAsAbtDpG6FEY5VlCvze5yAUrva9XnqrtRDMx6ZMIc9P8UDX8IfnJv/Q3N1tr0hn8TtpbWRBMuHvzbf1bZPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGIAuhE0Wl1Cqc28e3NUZPBndRVUsx/YBiUl8ffo7Sg=;
 b=yMsmg32nMrRgrG9MHX80dDYDfTU4Z97q8WpcsBzgFuNZsjoHxNbbIVy5wmYxTXpyWuG68y8+3Ne0d/9VwdPiFTu35xi76+h41y6oRXzKcwK9bEXjYc/OLWr63U36N8JenSdcef4lxHF8dWzrjezNNrgRdXFRYxHwx0i9ZgcMZAJ5S5G3AJDuKx6iuz3QewulOJkhLwaoqtlzAcJNY5Tzz1yfsVE1+E0/1tZF+mslO00IwO4kuf1gprg1hmZyCpvwiQsRkdl6CAx+KmaR+aWDs5r9PMNrv+bnAvcuTdp8X/BHfGWjOaG+npDwXJmyPB7QPCaDUgpxDQH2tDVmwmc6+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGIAuhE0Wl1Cqc28e3NUZPBndRVUsx/YBiUl8ffo7Sg=;
 b=dob/ZTk8KnVcFxWGMHAqnRC1GRgJqR2450BUr6MCd+PVzC6Gz9IFzb8mpWjMkSg6A1FUbIyW6LJuLiHpIUKFyaj/214914tqKE7a8wia2+DPNdzSFxSS5IfONpgAgN+28o2dMpz6I1ieg3BaupEtUZEk90z4AO2x18bzt1nFe6o=
Received: from SA1P222CA0124.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::12)
 by PH7PR12MB9126.namprd12.prod.outlook.com (2603:10b6:510:2f0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 28 Apr
 2026 21:56:37 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::62) by SA1P222CA0124.outlook.office365.com
 (2603:10b6:806:3c5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Tue,
 28 Apr 2026 21:56:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 21:56:36 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 28 Apr 2026 16:56:36 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdgpu: amdgpu_device_is_peer_accessible to support all
 BARs
Date: Tue, 28 Apr 2026 17:56:18 -0400
Message-ID: <20260428215618.3596608-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|PH7PR12MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b8a723-8f6a-4736-d772-08dea571050c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: X/roaa0H1Q24LPJhcLrr9lvOvelEM7KX17iZLJG3agiJD2meJE5T7/j2rb7Bl/+ldkfRM08TQ+reSndAw+BAoB5hEm9qV7KT6Q19PGhv4r0Zsz2owYJwR37ieb95TR9tdUYY2xZhY/HwjTaTuvcuCRz9X//eWhwqpMnZfUOg2YxnP0JfaA7f4wk+RVqQI+ee4NVYni8hD4LDRzvcaxtuRHwnUHpeEWbl7X8ZtIHUbxMdFnU6YFp3kZf1VGODEGRMZ2+YzI2T4xc/KEPWcI3nmo1TRSYYtaPVNJgdlDUnBREFjMH5yoYPnsada9nanQJeQSIlxOLgbGMGNrmYi40UBYxheu0Y4dvZQ3KLXvSlniamKY1cBErJlJDJvI/0Za8L/hEUEmNgjoXj45FWnfLPXxFbT7XRfivdB3GLqcmevYWqf4mcBw05OlQp316OSGy1uKe2jHJmNCAggfJGqLMJiXhDeRKvA4HVQB7QbeCNIR977xBsXPCE7W80/r0xXx2unQWQl5ctHnMb8mxsqk684hzp2nC1HGas5H9prryr6iz5xdPAbL0TbrkIAeECkaNSWhLW5a51+0+BJO2s0WL8IaFWv0ESscAxBFvpDFL84+iHIyWAnbT3FViXfJCyZj+IlfjfhtoWsRzAaiEINvyRBziG6kT6rpZTesiGAZaHb/NoSGyEJmLokm493CUokTFLs6y0fNlaMC9TpTJTq+Wq9n345pIqGocDvUArB2OZD/zHibkCl1gpEX4zZsStkUkIG273xSOq7reed9lBO52wOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GX7m+zR8b6EeaKdSG4LkgrAM62WtzPvR1mAnNKNh+kCcCJuubKceE8izfBeVkhcYqjB2Do1qYRNCdlbs2I73/QLmn+ousGcbn480E82QZ+iu3MIxH7Z8vvbR6ZZddMW9p7yYFdZC05dgdigecLo4+KMUfGXqw1+10Vo8cQa2LNZ93r5yPLRhdTqDpBgEu878qH9OUh8cTLGuPVVy0k1mt7sgSPDbnBMCBvHSKOeZRTH3MVio7qef7ZnYM/KeojKEmwdMNZ8YOLKA/b5LupxWkO3SOqZTGPcqgf81um8bGG04f3vPHTMARO9eTNJlVbkOqaB3glk6sQb0+MiPj6XsM+2usbli4WhictzbGtqP/FczWsCbh4MMKpgfHjYx1bGaZY2gCfqeTcXhrQQjoYW5X+sUp+cUp8OGKi9x6BGOVxC9yvqKJxnDTK+5Wd+E6+gG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 21:56:36.7147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b8a723-8f6a-4736-d772-08dea571050c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126
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

Change-Id: I0ec4d85ad505e0a1369e2d4d9fb6421664df41a1
Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 15 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 71 +++++++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  2 +-
 4 files changed, 72 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 39894e38fee4..d41d608d03b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1442,7 +1442,8 @@ bool amdgpu_device_supports_smart_shift(struct amdgpu_device *adev);
 int amdgpu_device_supports_baco(struct amdgpu_device *adev);
 void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev);
 bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
-				      struct amdgpu_device *peer_adev);
+				      struct amdgpu_device *peer_adev,
+				      int pcie_bar);
 int amdgpu_device_baco_enter(struct amdgpu_device *adev);
 int amdgpu_device_baco_exit(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 7c01492e69dd..e5e3f437ad3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -900,8 +900,19 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
 		if (mem->domain == AMDGPU_GEM_DOMAIN_VRAM)
 			same_hive = amdgpu_xgmi_same_hive(adev, bo_adev);
-		if (!same_hive && !amdgpu_device_is_peer_accessible(bo_adev, adev))
-			return -EINVAL;
+		if (!same_hive) {
+			int bar;
+
+			if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL)
+				bar = 2;
+			else if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)
+				bar = 5;
+			else
+				bar = 0;
+
+			if (!amdgpu_device_is_peer_accessible(bo_adev, adev, bar))
+				return -EINVAL;
+		}
 	}
 
 	for (i = 0; i <= is_aql; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 073f632f295a..65709a2c53be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6177,36 +6177,77 @@ static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev)
  *
  * @adev: amdgpu_device pointer
  * @peer_adev: amdgpu_device pointer for peer device trying to access @adev
+ * @pcie_bar: PCIe BAR index to check accessibility for:
+ *            0 = VRAM aperture (BAR 0)
+ *            2 = Doorbell aperture (BAR 2)
+ *            5 = MMIO remap aperture (BAR 5)
+ *
+ * Return true if @peer_adev can access (DMA) @adev through the specified
+ * PCIe BAR. For VRAM (BAR 0), @adev must be "large BAR" and the BAR must
+ * match the DMA mask of @peer_adev. For doorbell and MMIO BARs, only the
+ * DMA addressability and P2P chipset support are checked.
+ *
+ * @note: CONFIG_HSA_AMD_P2P indicates support for P2P DMA mappings. Query
+ * P2PDMA distance only if the kernel has all the prerequisites for P2P DMA
+ * support. Otherwise fall back to the less reliable legacy P2P support to
+ * avoid regressions.
  *
- * Return true if @peer_adev can access (DMA) @adev through the PCIe
- * BAR, i.e. @adev is "large BAR" and the BAR matches the DMA mask of
- * @peer_adev.
  */
 bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
-				      struct amdgpu_device *peer_adev)
+				      struct amdgpu_device *peer_adev,
+				      int pcie_bar)
 {
 #ifdef CONFIG_HSA_AMD_P2P
-	bool p2p_access =
-		!adev->gmc.xgmi.connected_to_cpu &&
+	bool p2p_access = true;
+	bool p2p_addressable = false;
+	resource_size_t bar_base, bar_size;
+
+	/* VRAM requires large BAR (full VRAM visible) for P2P access */
+	if (pcie_bar == 0) {
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
+	case 2:
+		bar_base = adev->doorbell.base;
+		bar_size = adev->doorbell.size;
+		break;
+	case 5:
+		bar_base = adev->rmmio_base;
+		bar_size = adev->rmmio_size;
+		break;
+	case 0:
+	default:
+		bar_base = adev->gmc.aper_base;
+		bar_size = adev->gmc.aper_size;
+		break;
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
index 4dc9f9aa3a2e..24fb565fa53c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1496,7 +1496,7 @@ static int kfd_add_peer_prop(struct kfd_topology_device *kdev,
 
 	if (!amdgpu_device_is_peer_accessible(
 				kdev->gpu->adev,
-				peer->gpu->adev))
+				peer->gpu->adev, 0))
 		return ret;
 
 	if (list_empty(&kdev->io_link_props))
-- 
2.43.0

