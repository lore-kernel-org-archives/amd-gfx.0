Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C962CD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 20:56:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B88310E986;
	Mon,  1 Jun 2026 20:56:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wdUwSRRT";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E494D10E986
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 20:56:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYYWy29R8GOVD6/K8lIHXbhHBfd8rWOSK8vi+Xizt89M//+o+ywQtXUOVTAdE0WKTkQTFJNIbl4VvifsTFoTC4qc2R2YfERVNTaijz14WlAxaBrU9kG46e2XhdhoqbbbOBBJPrBK6uArtsVNoNRrKavvUkiYBGJM+EismMKZwSq7rBRZ8xznwA49lmrDQmNWOMFy45L7EG3JQOaBTGDq0xt13dsm5wUI/Z3Uw4mkvXQ+vJOOyQZxwPmtqh66IzZBW33vbSL7E+9CLwZTVDYS/gYqgzVwSBP//jWoBCCzMXLEaBV1Z8y5SIFNindo2kwJi6gOxSLqDnAEI78jfeWIUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GimhxMIAUjirWG55QP88wn8r2Yw5JzPjE0TH++htIA=;
 b=NK6NqtM95pDwDP3jGkwRqlfy/10z/ez9m09KmYfqmvmJ7sRgrzPtaveddfH79JShllO1jpwZleZzwiiNIvPI5tgcju1xcVKB0igRgO4mmFyhnbUpq5pX7awcIRLjKQSHLZzWaZ8d4B52bwlF4fM1pacjJ4Bq0qpK0USYAI56uyHD67wDQtqhZZFpcyygQnLeDSxgqrkttRAmGop4WzTalw9Osu2nYmIEnfhMihRM8Arn9+6sSNCBt3en+M759escEMeDy0pXnXnO06VErJbw+48nby4iSskWMNFLNfiyVMXgmNDsh6+w3RzfDoylVSqwRpPhDVsuYOopj9HjLDbmrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GimhxMIAUjirWG55QP88wn8r2Yw5JzPjE0TH++htIA=;
 b=wdUwSRRTiRpwo1rNjqQycsUsHi+ajEit8uO0ENjUM/TN1oWKK20Y/FaJf2k6Y1mBhGupjk7buQc7bwEVD+r8lj3tQJE42zcfemDiMaVJB35ziWSLUc4v81WjTUykDyPMWj7FuZk0PpWfzHlIRdNg8jygoN2eT/jwfoQjIzXdaI0=
Received: from BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::11)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 20:56:07 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::83) by BY1P220CA0011.outlook.office365.com
 (2603:10b6:a03:59d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 20:56:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 20:56:06 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 1 Jun 2026 15:56:06 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu: Add enum for PCIe BAR regions
Date: Mon, 1 Jun 2026 16:55:52 -0400
Message-ID: <20260601205553.239933-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: d456a886-ea82-4456-3f78-08dec020339d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: k5c5FH2bnCK/BCLlecXV5Ksw793Ni7TWspU7LX69/DHwpX0nJKnf/yhNVgulmnvYTnf/R2wBoyrXdHb92voUolN+o8O4EEdFOSA4SOY3hpz7UOCXMlwRa+bQkOeDmBX8M+hwiyYx7lUJdz08Kopa6Ut4ztPqKTU3YkAlHtC426VFabCEXGtFWqrAyPJoBuLCFu5386jcbHqAwP+Eo2Ho22lvfwqnpqLT0gjhXEPOfeg+qa7q9DhHzBP/i/+2WNN7GX9eF7o9VhYZQ5Bh1aBAqdjNHzkYbzbz6LxyjaBdjKm9Mgpg58mZq6zNMgFsdGA+AaSPKBIcriRaz+KhfEqsDE0p4Dqax5UDbk/9oaHa3K/Y8c42KvbBDqBMngkS+R6eAGHZpLLTZdPj+EIDshHVNrPcvuJ0ldGz5zIcjwR1mELDMR1RPJFWoIPPk34D3xtwmgB6eb+TzgFF+ARHqDXoL0wlrWsgklTqvpPAHxZxq5lnzJaZ/U0CVNyX+hQuUm+qvU64Tu6VhzHCF2JlEGtBKV9ixki6ajHlnjImQhaXdCOq7Ntw0YzqbxZZlcnYIkkIOD/k8SYQ07JIUuczPTN9a02VCA0qhRJ17VXIBwvBvkE8pT+r/tqgR0mglf6kluZG69cuHfVyz5ndDjpKWmlwO+LSF9DfLDvRvBpCf900qRQQk963SwgxvwSXzo/uo49SkU49aSszYtv9BB90dCpm4COQGuvS0QHgo1eGrHqHtqg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZONqjCHqziGl1Btl/YSn7rJTw5mS1qJOMEO/28OIzKeqG+VbYcLBnAwhkklpvE/3V4tTBfCoU9TqV6JQ9qBNoS9/TxGz4H5ottFo5M2LOX1MmhUyoG9DfYbEBrKAEa17dWJHm219u4hR23HW7ApWSOPNUNttYRuYzabfNoBBaOnoNr8T7fLtZmfXyJUh8GGb7KqcDl28hIJfSLn/n+GdSqscuFSXR+Ak7YyJDtapGHS4iy+kOuOtJHB4E8S1i5wFotxdaIhCcBq92rxZPHvkbZa0X+V9smv3oiA3GatXBE33M6J+05rj+eK9HYj99AIr2F9t7HtutunDZ+3OF1usgYqskmRVH50ARVYD3bsuzpFsTup7mU7UNvqk2XuTXNnh9YH+QVLAciPAubF0SQJaqHRjCE1g6KYh19OtCfY9zxhGqduw9IQpxGSDKcVhNXLK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 20:56:06.9343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d456a886-ea82-4456-3f78-08dec020339d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098
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

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 17 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 56 ++++++++++++++-----
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  |  9 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |  6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |  6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  9 ++-
 11 files changed, 100 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5d7bfa59424a..1944d1bece86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1405,6 +1405,23 @@ bool amdgpu_device_supports_boco(struct amdgpu_device *adev);
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
+ * Use amdgpu_get_bar_idx() to map a role to the PCI BAR index on a given ASIC.
+ */
+enum amdgpu_pcie_bar {
+	AMDGPU_PCIE_BAR_VRAM = 0,
+	AMDGPU_PCIE_BAR_DOORBELL = 2,
+	AMDGPU_PCIE_BAR_MMIO = 5,
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
index 5ff224163bab..2e1e5791f123 100644
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
+		return AMDGPU_PCIE_BAR_VRAM;
+	case AMDGPU_PCIE_BAR_DOORBELL:
+		return AMDGPU_PCIE_BAR_DOORBELL;
+	case AMDGPU_PCIE_BAR_MMIO:
+		if (adev->asic_type >= CHIP_BONAIRE)
+			return AMDGPU_PCIE_BAR_MMIO;
+		return AMDGPU_PCIE_BAR_DOORBELL;
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
@@ -3825,13 +3858,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	/* Registers mapping */
 	/* TODO: block userspace mapping of io register */
-	if (adev->asic_type >= CHIP_BONAIRE) {
-		adev->rmmio_base = pci_resource_start(adev->pdev, 5);
-		adev->rmmio_size = pci_resource_len(adev->pdev, 5);
-	} else {
-		adev->rmmio_base = pci_resource_start(adev->pdev, 2);
-		adev->rmmio_size = pci_resource_len(adev->pdev, 2);
-	}
+	adev->rmmio_base = pci_resource_start(adev->pdev,
+					      amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_MMIO));
+	adev->rmmio_size = pci_resource_len(adev->pdev,
+					    amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_MMIO));
 
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
index 8523833a74fb..728d93e96ea1 100644
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
index 16388e3caea3..a16e681b4de0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -694,8 +694,10 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
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
index 586703ec0dfa..5c2b4d2f3f16 100644
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
index af6944d2d330..5bdcc276244c 100644
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
index 93cf283191fa..d8b81d8ec954 100644
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
index 1d3ddffd5a11..99bfd4e42977 100644
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
index ced0f3941863..774e93590389 100644
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

