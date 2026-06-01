Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866A8CD6E55
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 20:56:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A63310E99C;
	Mon,  1 Jun 2026 20:56:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dWdZGktU";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010059.outbound.protection.outlook.com [52.101.46.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C487010E99C
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 20:56:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwUisxU/eiNXkYARxkeqoMhnm9t1nvFoMUbH9PTKPxWSlLLsl1Qre8rys+OcsKqd/NDwN0UPNHyqPRTc9+kjaX6VRXe5UjAB3dMz6wllE0MKabpjIlpMtUAK2LLAeODEVvSaNTjwQFyiFtYEDm1zt3h6H982GOVD/XQ5LFewvERNkh4xG0vaqiAu4thyQzPyjQEEZ7MgWaYxW36SdmoyWolCoCda+PUwwP4CJM4nxK3bRnAfyQJHv5YpJ6JobuUYj8mexNqwPW7Ap3Ua5AMjm/ES2wzih1PfhJO30ndOdMecAfFo3hZSJOY0wrEWG8bRY0z8smLtNdufqBkuieJuiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEp4tVTkbLu5bDWGrJp3fiYp8kuoVEPF70bqTZhMoMI=;
 b=y7cPHXIoM6pmwJRCIxfFhO45JDXKGEl4+u/ARAjOrH+t41pbD9gQtWssQKIgsdhD2tMyrdw4kf3AICi9mCFKXmxX4wtlIzTrQZt8SAjwBqREUff+nqFM4y8YcAvwVRV7fT6vYuK3/qIZCQaAh1VvmqT5GEIskW+9U1m59ZB+rYsoMXJwx06iHm36Qj4QVPI7vGyy3Zv+6PNuPK04ULAb5ZQPmwdJuzmuh4CVHGgYleT7evREZ6jxnWqD/UCSoeV2Oq3BKT+s3oJtJO8R3NeJFri6DZI01xqSe5yP9NsoCSV/UBFOm2bIOQ0qC8wxpDKF2PHVDVKONgz22xREjsecFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEp4tVTkbLu5bDWGrJp3fiYp8kuoVEPF70bqTZhMoMI=;
 b=dWdZGktUhrf4Vti/TNIaKLug4+9N2vzDyj33DVfEyCSbqDZJj8gSSEEGDr2dmRePwMsle7Qw47Q+pIpecn5AY99p3exdBZbRWN+/GQW630n/ZPpvl9ZsuYvY1ZNiRsXbD3mt29sUHR2UzsvhKdglBSirgU0gzLQLcnMHtiMUs0k=
Received: from BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::12)
 by SA1PR12MB7176.namprd12.prod.outlook.com (2603:10b6:806:2bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 20:56:12 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::24) by BY1P220CA0010.outlook.office365.com
 (2603:10b6:a03:59d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 20:56:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 20:56:11 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 1 Jun 2026 15:56:08 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: amdgpu_device_is_peer_accessible to
 support all BARs
Date: Mon, 1 Jun 2026 16:55:53 -0400
Message-ID: <20260601205553.239933-2-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601205553.239933-1-Harish.Kasiviswanathan@amd.com>
References: <20260601205553.239933-1-Harish.Kasiviswanathan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|SA1PR12MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 88406a94-d04b-4a9e-c713-08dec020367d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PAI7qWPZbXYgZN9i7mVbKUzp5U+EG4nxXa++5P+GXaeEib26QM9InkHSeTtthsT2oZksa4uIuoVs8H5QG4mlegvctneDFR9rcmETFTlEGkWvkQzDahegspKWCuVlzZbO0gsHRcoUEnpxLIMT7TpVaNgkmokoHatzuikuSLOP9XY17hPIFLSqyxd1HbWj8rc8NYgRBxuBVPdbsXWP9VhioppGvTRLbOJISUufsziJ7G6yNbTZdatYg5sxFk3yNvCcUFaCWKktLXyB6IcuDZnaSKpQ+VJGynRLhNf6irQkSW8fjNthOUEgwjIG0wivNmUGE/OWIH1tB9C4SoFTSpX9N+u9HAlCSad/frtlYxGPxVB7WLkgBuzr7yDLivMru11Q86FwKsJTp6FBLf2ARhzBj1hVMnEXNVqcY7w83B7nzvHZ4catcTkVkmKFwm5rn+cGWhvG8E0ptC/wKeVsKp9L+oGRWGRFwkpOhqLyjvK44hZmHz+/g1V8YXs0ejAYzSblBzvI8SoZYC6t5S+cv4aTdx3NJUPIMVXvU9qCLMi0AuLOgNdlROxBlK/vAbjQ7Zyg4rWXT4myjpeaM+cWmYDwwdhDgSKmAQXSqQgbOdIT+crs6HnMV/sykWbuan4srTCTS3j7EJYXJ8QaVIABuvzMnm8K50hJSf/BRIgQ9+P3YxxpqCPWNrlrqqZvVSHA6Uq/s0wYrHwbCwXWUGWaHuoWCpddsSQeMju5h7MYLnBFXKc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UrYN2zpXxzGWqdf4tXzzVvdduUSYKIz6vG8n1Mpnt3QBS78NwghD0yMwSsmGmDTQZ5OmBeHu+y1AQAVpz2AaTATRs9UC7WfJp4mxs/TD/yNo3sMSW3d6Y38/TZJxINDtP2bu4ExEOijmOXVYAf3Ur4BplxrIa9BwnHbHlow5S17ONZpJCvzyOBvDsrrfCwUGwoESSFp1aOIsheyxxcjDhcaQFqnfz4+BYASjO6C/yNUimo38PMN5TGosj5EWklcxFIgW778vc/NG2sWKHiENY2OXT5m31HeA3CAlYe8dCGijOm9jotvB/DBYAsOElcJgLlvT+7r17fJIeIdVgVxkjaVBuNaHhMuUUP8XPMW8Tf+hLBhMSxzVN0+GCMHxaYbhTUN4ietCrFrIPc1jFm0zcXMEXfFghPznNHKEuOQJEiH7G6IQC/symiefZkPsJj3d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 20:56:11.7868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88406a94-d04b-4a9e-c713-08dec020367d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7176
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
index 1944d1bece86..6004736a08a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1423,7 +1423,8 @@ enum amdgpu_pcie_bar {
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
index 2e1e5791f123..bd1f5cfd88c8 100644
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

