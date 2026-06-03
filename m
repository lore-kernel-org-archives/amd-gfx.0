Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130C0CD6E55
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 21:15:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A048A112371;
	Wed,  3 Jun 2026 21:15:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MMcEJODF";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011048.outbound.protection.outlook.com
 [40.93.194.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DC82112371
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 21:15:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Etdwvj4PIf5DBlcXmg1UC8TRrB6rjXZYR6d4NwFIW2D37xO8CgrK32yYXUbg7IBy9IPfXs8lWnUubOmfGGa7k5FOVQBqh3xjHthJpA2S5yBtRvSogO26IlBwBNTRvKjUcfOh/+PgR58zYBOrcilp4vM37mWnK8/CCQx0uu0frZjWRe1eY//535/i2MuJjV9xxQjJARPUNWDmKH1J87gZEDyzSsk7r82K+QKKaQBR1MN25xeHAd5mxBi6sfMRW5+ybT++bXbefWXTyVaH1Gr5GZW2qFnDP0WluhkEJay2sqQ42SOW6faMExX2Qi3VK67CB7AiX7jKmgU2oahj+5A20g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyAIZdTFpUa9I/6bgA5nADy7QpT6OaKxPG2Ir6PUD8o=;
 b=RsZCz+sNzzxR+4w6HILu3YNqVxQB1grw4vnVyOafWj2l45dN2+h+LhMDcmzcRsj65VmYiQ0xddF1jfQeSKv3+mT37En5CHZ86fUhGp+wJ0gGKaJj/We7HQRiIdDWLYmOyNNv4U6GgtXPqcN7HMbAjl97TnGAtztdvIEix/NPNoXVHwCJLnLizi1OBIOiRZzC8agiBEozrIljsUB7BE/MNHjgcAzx0PJ1w2rw8js5c0HCvhXzGyIUVUWJVFTXExkgQkkN+7PFvKSvKma8GZly8/+ItWW1mjKJaSBIo+KtC/vvAFv3/Ry9CZne78ahFqkaHbTrDlqslceMleHba8Cgxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyAIZdTFpUa9I/6bgA5nADy7QpT6OaKxPG2Ir6PUD8o=;
 b=MMcEJODFZ5aGHcMsydKnCMgsD7JDkqeqyyp2ahLQQ5lox0L51/bjubqjnBgUOdyStNJb3TxW13sAwPLpiOAJrrFJ4NXu1T0l2D4hx8+GJMULXe9Xmxqfdd2dkAH/2SpAGNmh1qK9lisrOBCEICyIhkaI7R2chPOhlZ+2HHNNsBA=
Received: from CYZPR17CA0005.namprd17.prod.outlook.com (2603:10b6:930:8c::21)
 by PH7PR12MB7456.namprd12.prod.outlook.com (2603:10b6:510:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 21:15:10 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:930:8c:cafe::79) by CYZPR17CA0005.outlook.office365.com
 (2603:10b6:930:8c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 21:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 21:15:08 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 16:15:07 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH v3 1/2] drm/amdgpu: Add enum for PCIe BAR regions
Date: Wed, 3 Jun 2026 17:14:54 -0400
Message-ID: <20260603211455.307285-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|PH7PR12MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d4dfbcb-f3d7-49d9-4733-08dec1b530c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099006|18002099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 9hdhG1pzQJP49ACdujPBKLYnPEe/iZErA3t4Uz0YSR6MIWRWswiAj4xGMwCkS8RgNhGNaDeGHyYave8EfRRJl+GVwvD7sdZXp2ci/QbLiaNOFDYKEaydEjZ60sTvfNFziWtkK9VVXgwzbr0VvLd45tgtjafUb0lVmbTgRmFYje5+qc2pfV2Tw/VwRh1A3E4Lt2EvUSJz//QB4wPZnDbzwfUlgVOaak4skXfQJN+4eO+VuLCPR4YlC7ayfxWLsQgEQgawaHDsCPfWAaTbgDaBXiA8a1s/jyMq7YNAZ6kJYrCQ3dAFOPnqCYq10kPHFAJhSGcZWm8S0Ob7vtd91HJ8FsU7yr1lnfrgrgPXogfgdfEodjWNw5XgwB1JX7wnEAPcHWVZ9vMHq60tZxQYnfwRwOCfhB8J7kei57oCnnTrjVGkjvlM+1elG2vDHuIFVCdm+r223ZV17M5B59QQ+jJjasEVGdup18yE9j1ssnftgiOf7tTcCAIfTOhh9DPAo4ZvWonIWGVYf7ssvTUB65tKLnx438KI5s1vyBeg1OnTqcAuZMnwJEIvSGqZZhih7d9/psSnPfo0lE7EVNKrodW+DW69TGVf1xQ1xwNkT928DPoouDqADu2pWOBu4la2OAr7cN/JNHBBVwGY1g8TZGaLcE9Oceoz6VdhWEeqAo/GkYhEqew394ba2ORaUefJatvycE7K5Q9BmNnL2FU4yGnPxw2gGsLI502gncpybWHxRy4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099006)(18002099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VZ0UvQXMGSekomhSQ/txFlxvCtJh/pKzN3g13bErxRIzQhxv5Sk9l37RJ4GVDy8Sucs98Nq/Zf15Au06U7iV7pD37sVO3b01I13+7PxlJjwNqRwWd2GQc3F/PCiQHWyvEG2uivhOhnc1toT3eNhdJ/kr9/8e8i021497ZDyqESdzwMzpFK0/YD1Fxy23S4ScRHBOkYePbz1QrG4OdCNRqWLQZi4Kv4gXSiG6+dbhEUzRo6TGJB0OiatCep2kXvWG0j+4FrpAEv3PXSGwGrtWYMVg5Yq0KGqqpc0YkPAHW1tYEWat5CbPoB8hd9xsGsBbsmy1mouQtOmk7dwmzBrW88DvxrrrLPRuoofY6clWojEJisQbV1fAuQL70vGu+awG2ZlLXJyw0di1Mo4A6fNBMC91Mdz3GQkWAoGuXXV3FNO/lVzPnnDP3rT/u4BhgA7k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 21:15:08.3945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4dfbcb-f3d7-49d9-4733-08dec1b530c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7456
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

Use enum instead of hard coded values. There is no functional change.

v2:
- Add amdgpu_get_bar_idx() to map BAR roles to PCI BAR indices

v3:
- Use opaque enum values for BAR roles instead of PCI BAR numbers
- Return PCI BAR index literals from amdgpu_get_bar_idx()

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 18 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 57 ++++++++++++++-----
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  |  9 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |  6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |  6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  9 ++-
 11 files changed, 101 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5d7bfa59424a..8e7de8d436f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1405,6 +1405,24 @@ bool amdgpu_device_supports_boco(struct amdgpu_device *adev);
 bool amdgpu_device_supports_smart_shift(struct amdgpu_device *adev);
 int amdgpu_device_supports_baco(struct amdgpu_device *adev);
 void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev);
+
+/**
+ * enum amdgpu_pcie_bar - PCIe BAR role identifiers
+ * @AMDGPU_PCIE_BAR_VRAM: VRAM aperture
+ * @AMDGPU_PCIE_BAR_DOORBELL: Doorbell aperture (Bonaire+)
+ * @AMDGPU_PCIE_BAR_MMIO: MMIO register aperture
+ *
+ * Enum values identify BAR roles only, not PCI BAR indices. Use
+ * amdgpu_get_bar_idx() to map a role to the PCI BAR index on a given ASIC.
+ */
+enum amdgpu_pcie_bar {
+	AMDGPU_PCIE_BAR_VRAM,
+	AMDGPU_PCIE_BAR_DOORBELL,
+	AMDGPU_PCIE_BAR_MMIO,
+};
+
+int amdgpu_get_bar_idx(struct amdgpu_device *adev, enum amdgpu_pcie_bar bar);
+
 bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 				      struct amdgpu_device *peer_adev);
 int amdgpu_device_baco_enter(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index aa039e148a5e..7e253bb35434 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -111,11 +111,13 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
 			return false;
 
 	/* FB BAR not enabled */
-	if (pci_resource_len(adev->pdev, 0) == 0)
+	if (pci_resource_len(adev->pdev,
+			       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM)) == 0)
 		return false;
 
 	adev->bios = NULL;
-	vram_base = pci_resource_start(adev->pdev, 0);
+	vram_base = pci_resource_start(adev->pdev,
+				       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
 
 	adev->bios = kmalloc(size, GFP_KERNEL);
 	if (!adev->bios)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e46cdd6ecd42..48409b28ff55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1103,6 +1103,34 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
 	spin_unlock_irqrestore(&adev->wb.lock, flags);
 }
 
+/**
+ * amdgpu_get_bar_idx - map a BAR role to the PCI BAR index
+ * @adev: amdgpu_device pointer
+ * @bar: BAR role to look up
+ *
+ * Return the PCI BAR index for @bar on @adev.
+ *
+ * VRAM is always BAR 0. Doorbells were introduced at Bonaire (CIK): pre-Bonaire
+ * ASICs have no dedicated doorbell BAR, and BAR 2 is used for MMIO registers.
+ * Bonaire and newer expose a doorbell aperture at BAR 2 and MMIO at BAR 5.
+ */
+int amdgpu_get_bar_idx(struct amdgpu_device *adev, enum amdgpu_pcie_bar bar)
+{
+	switch (bar) {
+	case AMDGPU_PCIE_BAR_VRAM:
+		return 0;
+	case AMDGPU_PCIE_BAR_DOORBELL:
+		return 2;
+	case AMDGPU_PCIE_BAR_MMIO:
+		if (adev->asic_type >= CHIP_BONAIRE)
+			return 5;
+		return 2;
+	default:
+		WARN_ON(1);
+		return -EINVAL;
+	}
+}
+
 /**
  * amdgpu_device_resize_fb_bar - try to resize FB BAR
  *
@@ -1146,7 +1174,8 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 
 	/* skip if the bios has already enabled large BAR */
 	if (adev->gmc.real_vram_size &&
-	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size))
+	    (pci_resource_len(adev->pdev,
+			      amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM)) >= adev->gmc.real_vram_size))
 		return 0;
 
 	/* Check if the root BUS has 64bit memory resources */
@@ -1165,7 +1194,8 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 		return 0;
 
 	/* Limit the BAR size to what is available */
-	max_size = pci_rebar_get_max_size(adev->pdev, 0);
+	max_size = pci_rebar_get_max_size(adev->pdev,
+					  amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
 	if (max_size < 0)
 		return 0;
 	rbar_size = min(max_size, rbar_size);
@@ -1178,9 +1208,11 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	/* Tear down doorbell as resizing will release BARs */
 	amdgpu_doorbell_fini(adev);
 
-	r = pci_resize_resource(adev->pdev, 0, rbar_size,
-				(adev->asic_type >= CHIP_BONAIRE) ? 1 << 5
-								  : 1 << 2);
+	/* Resize the VRAM BAR. Exclude the MMIO BAR from being released. */
+	r = pci_resize_resource(adev->pdev,
+				amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM),
+				rbar_size,
+				BIT(amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_MMIO)));
 	if (r == -ENOSPC)
 		dev_info(adev->dev,
 			 "Not enough PCI address space for a large BAR.");
@@ -1191,7 +1223,8 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	 * using the device.
 	 */
 	r = amdgpu_doorbell_init(adev);
-	if (r || (pci_resource_flags(adev->pdev, 0) & IORESOURCE_UNSET))
+	if (r || (pci_resource_flags(adev->pdev,
+				       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM)) & IORESOURCE_UNSET))
 		return -ENODEV;
 
 	pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
@@ -3696,7 +3729,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		       uint32_t flags)
 {
 	struct pci_dev *pdev = adev->pdev;
-	int r, i;
+	int r, i, mmio_bar;
 	bool px = false;
 	u32 max_MBps;
 	int tmp;
@@ -3826,13 +3859,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	/* Registers mapping */
 	/* TODO: block userspace mapping of io register */
-	if (adev->asic_type >= CHIP_BONAIRE) {
-		adev->rmmio_base = pci_resource_start(adev->pdev, 5);
-		adev->rmmio_size = pci_resource_len(adev->pdev, 5);
-	} else {
-		adev->rmmio_base = pci_resource_start(adev->pdev, 2);
-		adev->rmmio_size = pci_resource_len(adev->pdev, 2);
-	}
+	mmio_bar = amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_MMIO);
+	adev->rmmio_base = pci_resource_start(adev->pdev, mmio_bar);
+	adev->rmmio_size = pci_resource_len(adev->pdev, mmio_bar);
 
 	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
 		atomic_set(&adev->pm.pwr_state[i], POWER_STATE_UNKNOWN);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
index bc7858567321..826b80481908 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -201,14 +201,17 @@ int amdgpu_doorbell_init(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
+	if (pci_resource_flags(adev->pdev,
+			       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_DOORBELL)) & IORESOURCE_UNSET)
 		return -EINVAL;
 
 	amdgpu_asic_init_doorbell_index(adev);
 
 	/* doorbell bar mapping */
-	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
-	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
+	adev->doorbell.base = pci_resource_start(adev->pdev,
+						 amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_DOORBELL));
+	adev->doorbell.size = pci_resource_len(adev->pdev,
+					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_DOORBELL));
 
 	adev->doorbell.num_kernel_doorbells =
 		min_t(u32, adev->doorbell.size / sizeof(u32),
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 6be2000c8261..711c76c8ca59 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -694,8 +694,10 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 	}
-	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
+	adev->gmc.aper_base = pci_resource_start(adev->pdev,
+					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
+	adev->gmc.aper_size = pci_resource_len(adev->pdev,
+					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
 
 #ifdef CONFIG_X86_64
 	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 8eb9847d9e1e..12dff2ffe835 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -696,8 +696,10 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 	}
-	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
+	adev->gmc.aper_base = pci_resource_start(adev->pdev,
+					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
+	adev->gmc.aper_size = pci_resource_len(adev->pdev,
+					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
 
 #ifdef CONFIG_X86_64
 	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 84c93364d220..dec3a2c3ad33 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -746,8 +746,10 @@ static int gmc_v12_0_mc_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
+	adev->gmc.aper_base = pci_resource_start(adev->pdev,
+					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
+	adev->gmc.aper_size = pci_resource_len(adev->pdev,
+					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
 
 #ifdef CONFIG_X86_64
 	if (((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) ||
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index a914dd8183b5..136dcc901a6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -323,8 +323,10 @@ static int gmc_v6_0_mc_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 	}
-	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
+	adev->gmc.aper_base = pci_resource_start(adev->pdev,
+					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
+	adev->gmc.aper_size = pci_resource_len(adev->pdev,
+					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
 	adev->gmc.visible_vram_size = adev->gmc.aper_size;
 
 	/* set the gart size */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 0cc6ebb53a09..6b9e2f0147a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -379,8 +379,10 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 	}
-	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
+	adev->gmc.aper_base = pci_resource_start(adev->pdev,
+					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
+	adev->gmc.aper_size = pci_resource_len(adev->pdev,
+					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
 
 #ifdef CONFIG_X86_64
 	if ((adev->flags & AMD_IS_APU) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index c8741ce71229..dddf05d53318 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -572,8 +572,10 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 	}
-	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
+	adev->gmc.aper_base = pci_resource_start(adev->pdev,
+					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
+	adev->gmc.aper_size = pci_resource_len(adev->pdev,
+					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
 
 #ifdef CONFIG_X86_64
 	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 8a5c44810ba1..bc62a59f79d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1588,7 +1588,8 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_block *ip_block)
 		 * mode.
 		 */
 		adev->gmc.is_app_apu = (pkg_type == AMDGPU_PKG_TYPE_APU &&
-					!pci_resource_len(adev->pdev, 0));
+					!pci_resource_len(adev->pdev,
+							  amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM)));
 	}
 
 	gmc_v9_0_set_gmc_funcs(adev);
@@ -1700,8 +1701,10 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 	}
-	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
+	adev->gmc.aper_base = pci_resource_start(adev->pdev,
+					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
+	adev->gmc.aper_size = pci_resource_len(adev->pdev,
+					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
 
 #ifdef CONFIG_X86_64
 	/*
-- 
2.43.0

