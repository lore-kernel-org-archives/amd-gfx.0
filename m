Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05952CD13DA
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2026 21:29:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B7CD10E2CF;
	Sat,  2 May 2026 21:29:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yO3eYCPI";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012048.outbound.protection.outlook.com [52.101.48.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 807D910E2CF
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 May 2026 21:29:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9n5vnoNRoOVaj10Wkd3s9btPgwN/muAY23pkeYTw1rdQ5tLz2fcq/94QBpK+TlC8mLitukZOMX5Lkb1VYiTTBhm0JlWyolUubCljrBa+s5wDIeXEFVHJ5LhZfVnromDY9V7jDuBJ/n89KJkVI3HyAAMIjbDnH6bwcjmUpAlMK2k7Qw8XOJs7pgaIn0+tM/mj9oXRmmpA/QXGLje5yPv0PcryX57DiWaC6xXfss6/0msoTOrc/giBOt9PguaZkVCr6dElWy57cjC6bBBjXpxscrld0DpvATZt/9xc/SDIRVhecKFror+yUefJl1dSkntHyJ4grgsI51ZGu9l9vVJuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VmuVqmB8JMknzlAll+lep/UCUsajJHQHUhB/uACUxg=;
 b=KNYeKWTEe4pV9La1whitXYDwd4duCv9CkAPSUpNrZkIJ4MoPgulKwGlIiIalNH412DG4hhUq8TfDNGr0QLW2ygEB3HV4zvG+l3KhihzVUpn2hnXwXQy8u56BHtqSyJJl2ZTbeuNXWH0B9aFrObOX49AufOASbptxzfv1XDEI8wb+BT2dotAxcA5hE5/VRDOVXPORgGUN3WMeM3NMwu7P7RtARQGPMto16/U74clrieycyU1KzL91Yi76LntC1K74VegQIOIQQB1iy0iYSLWB7W/2adiRXWxV1XDsnCCLnXwNwbKr97vHRvHzrHN5LUXgRAIQgBZTaq3fhn0VatEANw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VmuVqmB8JMknzlAll+lep/UCUsajJHQHUhB/uACUxg=;
 b=yO3eYCPIkKuoMeZ6kEXK95gU4HCE62tjC3n6fLHC+hOMWy3HHogkEkkBPlm3dYezROrExbhUmt5ZluRXQk33TvhPqkNaUfaqMWr7TR8uY3nX+IHq2Fc1K5ZYZ4ATLeTpkk6HyzDnBexKte/eXtlASDFyQB3M3w4sjnkQoDeLgXU=
Received: from CH2PR18CA0011.namprd18.prod.outlook.com (2603:10b6:610:4f::21)
 by DS0PR12MB6581.namprd12.prod.outlook.com (2603:10b6:8:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Sat, 2 May
 2026 21:29:11 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::99) by CH2PR18CA0011.outlook.office365.com
 (2603:10b6:610:4f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.23 via Frontend Transport; Sat,
 2 May 2026 21:29:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Sat, 2 May 2026 21:29:11 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sat, 2 May 2026 16:29:10 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add enum for PCIe BAR regions
Date: Sat, 2 May 2026 17:28:56 -0400
Message-ID: <20260502212857.85677-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|DS0PR12MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ded1bd-8c46-4b7b-1f4f-08dea891d9fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: agdLof8g+iQ9CN18v5flny/mJE2GtpFl3PL8+UoM36GjABgffniKkRL627m2n4z5x1nrPJGhU3XYOCGICXUGXJCZLvtPTCvBa8J4k9E2QTgfV78ohmq03kMzD6GdPoFJa+VQRrYiqcs0iZ79xqWo0UWUkHGbVRpLe5WOP7obDNXGWQ/bIiCSPt3vKUe6rVHdyXEUZDRKlg+fLjwgTYspxcGB1hlhkiNx8b82uopfJLt7+/Ia3mRE4qJQDtDA6f5I2hQaVOGdZIz61EB05la9OoYGSNqh9/5a1opFLHXnfWS8jXXEFAIkrMvhvVU+1kFJXESNMr8El+aE2Ok8nSUDKXGzB7+1vazg8uN4TQlnbAbB4xKYESvfgBUAxTCwitCPEi8pLpqKJUTZhV6jB7kexiRZOqaT+2bJWB3pGYgl7AoxwnfSOMjHpSCvv+xj+nptAawm3wfXvx7teTOmIjKxlfWhMkMnxc6DdWWGn5rlmud4UkoCb6N7rwyassNoSrvvuc1kCODsUF56W9YPq/wpaAD+ndRhMq7RX1oIuPTSKgV8hLEWLO7kXsr5n/HnuF7djsKi3qOh0xoMNOUm3ju5icRg6bq7gHZMfzsViygBpZMg3JPM4nAtNxaQhV6kRbc9sL49DqJm5inHH12rJ1ccxdwKAhWnFKqMiX8So8XPRvWaGBBzk6+5RV3T8/6SAHbcdVVdZN8t0VM9rHm4b6EX2HjiZkwz62nYZVBMzdTsEcU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a825Q/+Y0I4bphGZGolArlmJYjCc9+Clja8hw7KkODNzG6SjqdRA4pAS9zS2LT74o1luCWq3QypiHxepnE5XhN4N4ujLx+SHtLOAaZESTJm1Fm1Gb4QOJA+ziIEP0Sz0LAR9XasCVVreC41zmySDmGd0BhAhrS/WdiKwiOmSTBUrUIgMYaAVsicD/ehtG+x4ufpRvSCI/FYvh3dxZImlmNw7oSW5zdC1bTDqUTFRyRem03EIqaPkDIXIoalOlqeVmNVUnk1OQA73Hp2GxFdT+1UofdlR/yf2MdUk87na9GO+F+bZU9yLgqq+brWSp9ShW+ZK/YTc+s/OjDDs9jXBNJwPcFfsjMUo6RxSIk2mtTHfgy30ua5A5Js2mC1+O8TAPL2nOZblrNphTxMwCFK/5DaC9Gt+fgKvl/sDKqrmbheoDgvPwIHrI9PgzREx6yki
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 21:29:11.3629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ded1bd-8c46-4b7b-1f4f-08dea891d9fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6581
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

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 13 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 28 ++++++++++++-------
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  |  6 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  4 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  4 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |  4 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |  4 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  4 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  4 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  6 ++--
 11 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 39894e38fee4..6b9d103fbff1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1441,6 +1441,19 @@ bool amdgpu_device_supports_boco(struct amdgpu_device *adev);
 bool amdgpu_device_supports_smart_shift(struct amdgpu_device *adev);
 int amdgpu_device_supports_baco(struct amdgpu_device *adev);
 void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev);
+
+/**
+ * enum amdgpu_pcie_bar - PCIe BAR index identifiers for P2P access
+ * @AMDGPU_PCIE_BAR_VRAM: VRAM aperture (BAR 0)
+ * @AMDGPU_PCIE_BAR_DOORBELL: Doorbell aperture (BAR 2)
+ * @AMDGPU_PCIE_BAR_MMIO: MMIO remap aperture (BAR 5)
+ */
+enum amdgpu_pcie_bar {
+	AMDGPU_PCIE_BAR_VRAM = 0,
+	AMDGPU_PCIE_BAR_DOORBELL = 2,
+	AMDGPU_PCIE_BAR_MMIO = 5,
+};
+
 bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 				      struct amdgpu_device *peer_adev);
 int amdgpu_device_baco_enter(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 35d04e69aec0..3e8216913e5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -110,11 +110,11 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
 			return false;
 
 	/* FB BAR not enabled */
-	if (pci_resource_len(adev->pdev, 0) == 0)
+	if (pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_VRAM) == 0)
 		return false;
 
 	adev->bios = NULL;
-	vram_base = pci_resource_start(adev->pdev, 0);
+	vram_base = pci_resource_start(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
 
 	adev->bios = kmalloc(size, GFP_KERNEL);
 	if (!adev->bios)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 073f632f295a..5c14fdbc1847 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1146,7 +1146,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 
 	/* skip if the bios has already enabled large BAR */
 	if (adev->gmc.real_vram_size &&
-	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size))
+	    (pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_VRAM) >= adev->gmc.real_vram_size))
 		return 0;
 
 	/* Check if the root BUS has 64bit memory resources */
@@ -1165,7 +1165,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 		return 0;
 
 	/* Limit the BAR size to what is available */
-	max_size = pci_rebar_get_max_size(adev->pdev, 0);
+	max_size = pci_rebar_get_max_size(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
 	if (max_size < 0)
 		return 0;
 	rbar_size = min(max_size, rbar_size);
@@ -1178,9 +1178,15 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	/* Tear down doorbell as resizing will release BARs */
 	amdgpu_doorbell_fini(adev);
 
-	r = pci_resize_resource(adev->pdev, 0, rbar_size,
-				(adev->asic_type >= CHIP_BONAIRE) ? 1 << 5
-								  : 1 << 2);
+	/*
+	 * Resize the VRAM BAR. Exclude the MMIO BAR from being released
+	 * during the resize. On Bonaire+ the MMIO BAR is at BAR 5, while
+	 * on pre-Bonaire ASICs it is at BAR 2.
+	 */
+	r = pci_resize_resource(adev->pdev, AMDGPU_PCIE_BAR_VRAM, rbar_size,
+				(adev->asic_type >= CHIP_BONAIRE)
+					? BIT(AMDGPU_PCIE_BAR_MMIO)
+					: BIT(AMDGPU_PCIE_BAR_DOORBELL));
 	if (r == -ENOSPC)
 		dev_info(adev->dev,
 			 "Not enough PCI address space for a large BAR.");
@@ -1191,7 +1197,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	 * using the device.
 	 */
 	r = amdgpu_doorbell_init(adev);
-	if (r || (pci_resource_flags(adev->pdev, 0) & IORESOURCE_UNSET))
+	if (r || (pci_resource_flags(adev->pdev, AMDGPU_PCIE_BAR_VRAM) & IORESOURCE_UNSET))
 		return -ENODEV;
 
 	pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
@@ -3814,11 +3820,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* Registers mapping */
 	/* TODO: block userspace mapping of io register */
 	if (adev->asic_type >= CHIP_BONAIRE) {
-		adev->rmmio_base = pci_resource_start(adev->pdev, 5);
-		adev->rmmio_size = pci_resource_len(adev->pdev, 5);
+		/* Bonaire and newer use BAR 5 for MMIO registers */
+		adev->rmmio_base = pci_resource_start(adev->pdev, AMDGPU_PCIE_BAR_MMIO);
+		adev->rmmio_size = pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_MMIO);
 	} else {
-		adev->rmmio_base = pci_resource_start(adev->pdev, 2);
-		adev->rmmio_size = pci_resource_len(adev->pdev, 2);
+		/* Pre-Bonaire chips use BAR 2 for MMIO registers */
+		adev->rmmio_base = pci_resource_start(adev->pdev, AMDGPU_PCIE_BAR_DOORBELL);
+		adev->rmmio_size = pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_DOORBELL);
 	}
 
 	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
index bc7858567321..0251625887d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -201,14 +201,14 @@ int amdgpu_doorbell_init(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
+	if (pci_resource_flags(adev->pdev, AMDGPU_PCIE_BAR_DOORBELL) & IORESOURCE_UNSET)
 		return -EINVAL;
 
 	amdgpu_asic_init_doorbell_index(adev);
 
 	/* doorbell bar mapping */
-	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
-	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
+	adev->doorbell.base = pci_resource_start(adev->pdev, AMDGPU_PCIE_BAR_DOORBELL);
+	adev->doorbell.size = pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_DOORBELL);
 
 	adev->doorbell.num_kernel_doorbells =
 		min_t(u32, adev->doorbell.size / sizeof(u32),
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index e1ace7d44ffd..83611edbd7b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -694,8 +694,8 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 	}
-	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
+	adev->gmc.aper_base = pci_resource_start(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
+	adev->gmc.aper_size = pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
 
 #ifdef CONFIG_X86_64
 	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 94d6631ce0bc..887edd7ea7c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -694,8 +694,8 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 	}
-	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
+	adev->gmc.aper_base = pci_resource_start(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
+	adev->gmc.aper_size = pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
 
 #ifdef CONFIG_X86_64
 	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 5bdd4b9b7893..a2a81e601e99 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -746,8 +746,8 @@ static int gmc_v12_0_mc_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
+	adev->gmc.aper_base = pci_resource_start(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
+	adev->gmc.aper_size = pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
 
 #ifdef CONFIG_X86_64
 	if (((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) ||
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index cc272a96fcef..14963e9edac0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -323,8 +323,8 @@ static int gmc_v6_0_mc_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 	}
-	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
+	adev->gmc.aper_base = pci_resource_start(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
+	adev->gmc.aper_size = pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
 	adev->gmc.visible_vram_size = adev->gmc.aper_size;
 
 	/* set the gart size */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index fb5e33c8a5ee..a0ab5ab7df94 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -379,8 +379,8 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 	}
-	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
+	adev->gmc.aper_base = pci_resource_start(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
+	adev->gmc.aper_size = pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
 
 #ifdef CONFIG_X86_64
 	if ((adev->flags & AMD_IS_APU) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 963d5b0fa87b..5f83311d7c26 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -572,8 +572,8 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 	}
-	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
+	adev->gmc.aper_base = pci_resource_start(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
+	adev->gmc.aper_size = pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
 
 #ifdef CONFIG_X86_64
 	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index e7b78027002b..0cc4ac7e8ad9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1593,7 +1593,7 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_block *ip_block)
 		 * mode.
 		 */
 		adev->gmc.is_app_apu = (pkg_type == AMDGPU_PKG_TYPE_APU &&
-					!pci_resource_len(adev->pdev, 0));
+					!pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_VRAM));
 	}
 
 	gmc_v9_0_set_gmc_funcs(adev);
@@ -1705,8 +1705,8 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 	}
-	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
+	adev->gmc.aper_base = pci_resource_start(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
+	adev->gmc.aper_size = pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
 
 #ifdef CONFIG_X86_64
 	/*
-- 
2.43.0

