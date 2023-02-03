Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E270C636CC
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 19:09:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83C8410E8A1;
	Fri,  3 Feb 2023 19:09:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A718010E8A5
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 19:09:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvYl5T8BHfUv3f7joRDxdSbz3jXpDMLXkyr7qNF821D0sq9GaHKq4Y38ySOHlksyJo/tKGsDvDL4JgcL118IKGdzFFWo/2lDHExDeZsxznBiDlU8wh0hCkzknIU43xxSCCSWN24hpW0tfI6poBrPucRJz0YEsPiCq6WvHAbQxjQMp8Np7OhpdyUwi/Z7w9SzWfZ6Zww8IMVZOGRs1H+zVW95PW5pnRM+Fi7En0XBn3zPf34/E9Si7h0RvA32SvM7AkbuifXKIGbPCiWsMR0x2I+kURGFZsT2D3DUgztplKYecbTF0ZBJ/l5SErsrf3KQPaFXQdp2WFYCQs5U9zBLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onR4T87Bx5R169+cdb9pjzxV6eX5j6Qy+oIQDQrGVX4=;
 b=KdIQ5Z/g8MJ2XKq3aJuiZEUkw1GSoe8dOibIqHq35HcjrdNEoPxYHpo9pg5b4DkDuleRIr+UYJrJ28NLoYv1LzgHHD+yX0GjqJOOtP4R2YJJpFGrEa+a7fg0ZC/5F+UiwKaYmR1w07QXJTQsmAtUgBwtS08SqCwmiUwS2NsiUEzg8ecWky60KgtoE0dtc8b2CtoksEjadv/ecRHFhJYxcbE8Pk+zEiD81qPdY3OPp3Y/ca52wieZuYiLemFEL9HEOxKMtY/BkWVnuzPVwzxtD8Y5Ds/h/dF8F47BoEdbQJVGRF/yC6JqtJ0PGf1HPT0eA715CTEBbbrlNtsqPIdxVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onR4T87Bx5R169+cdb9pjzxV6eX5j6Qy+oIQDQrGVX4=;
 b=yYOqN8KSWjhnyL2bFB+7N2mERFlB1jorzUsk/vQwsaeMeShtss2EoYWspSd2IR6KF1Jah0GjAdMgWozpJL55j7IPwboWa7MKAngYecbe2zZ6iPOrK1RY0sOrwaNPx2bTYr/GbUS8kR2s6Bz9FPqD0UmHFVlfjjwBYW0Swgwf7mw=
Received: from CY5PR15CA0253.namprd15.prod.outlook.com (2603:10b6:930:66::20)
 by DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 19:09:26 +0000
Received: from CY4PEPF0000B8EC.namprd05.prod.outlook.com
 (2603:10b6:930:66:cafe::bd) by CY5PR15CA0253.outlook.office365.com
 (2603:10b6:930:66::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 19:09:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EC.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.4 via Frontend Transport; Fri, 3 Feb 2023 19:09:26 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 13:09:24 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/14] drm/amdgpu: move doorbell aperture handling into
 ttm_init
Date: Fri, 3 Feb 2023 20:08:27 +0100
Message-ID: <20230203190836.1987-11-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230203190836.1987-1-shashank.sharma@amd.com>
References: <20230203190836.1987-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EC:EE_|DM6PR12MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: 687536ef-eb8f-49e0-1e76-08db061a2af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 51uFRcFRda1K9Mqf0WLd5F/2lvc8/FlkU9hUidX+aSbHY6JzZ+AlGvORHXOxTNQStjMUNSbdu7R2Fv5r+1fYPWYdB3XYz6ElZtrkg/3W3UslMAb66GUJuYbQXDnb8bd9TmGEPtZb1NQMzyUxgbSEEVYLYl+LzgG6bBWvaOOrsZaqZLn5FQ0+45PUT4vI9V4c55RxOFArzTg5TCFiTox9rFJfuvi0SU+l2gc3tvfskVfnir+WK9hHrIHMOtiYpgryUK+z+B+0JmaiIsmxuIc3oDV1TfBmaWWtR55IkOC8rgDP3DvAMD2HWm8e1JkaH3X1ZqOTbyonP8SX6RjceSN87rAmOI9DLduymxudwKsL8YiXi5Flj5xYfbaB6/f4vHxwgXGwmFpK5J0X/tUVGx/gQe3EFBGBOSYrCjohEidC6yOWEiW2tIvNqyjE4O6h32VmpQITNJ9/RG6TJhFnOSysrmKp58WK9dBBqcY9iD5bH3z/Js6pZuFjMA6I/7oJNaajKBHoofPZsEoSKMFdj0Q3cf2Chz1pCwlDkdb0LihymYDKTbj7QtQGKeOBx3wSw4SkPYvZ5HdsAvKwTzzDZc1p80iUB6qgnf9kg6I5DBViA+LPzoSzhw/0gO8AVo2LjLQfKHS9d+r80uFkZfg68dPHw3G978FWRDbPiyZYZaCiQhRp6ZdpUlq5T9XDd3KTirb6+SFVnJvjgMFrTroBTbU2sDfy0OFbh0Y9Bdu7XUBkK5c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199018)(46966006)(40470700004)(36840700001)(336012)(2906002)(44832011)(41300700001)(478600001)(36756003)(70586007)(40460700003)(186003)(5660300002)(1076003)(16526019)(26005)(2616005)(8936002)(7696005)(47076005)(86362001)(40480700001)(426003)(356005)(82310400005)(8676002)(70206006)(83380400001)(6916009)(4326008)(82740400003)(316002)(54906003)(36860700001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 19:09:26.1324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 687536ef-eb8f-49e0-1e76-08db061a2af1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

To consolidate it with vram handling.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 96 ++--------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 64 +++++++++++++++
 2 files changed, 71 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b07b7679bf9f..7c21ffe63ebc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1016,82 +1016,6 @@ int amdgpu_device_pci_reset(struct amdgpu_device *adev)
 	return pci_reset_function(adev->pdev);
 }
 
-/*
- * GPU doorbell aperture helpers function.
- */
-/**
- * amdgpu_device_doorbell_init - Init doorbell driver information.
- *
- * @adev: amdgpu_device pointer
- *
- * Init doorbell driver information (CIK)
- * Returns 0 on success, error on failure.
- */
-static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
-{
-
-	/* No doorbell on SI hardware generation */
-	if (adev->asic_type < CHIP_BONAIRE) {
-		adev->gmc.doorbell_aper_base = 0;
-		adev->gmc.doorbell_aper_size = 0;
-		adev->doorbell.num_doorbells = 0;
-		adev->mman.doorbell_aper_base_kaddr = NULL;
-		return 0;
-	}
-
-	if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
-		return -EINVAL;
-
-	amdgpu_asic_init_doorbell_index(adev);
-
-	/* doorbell bar mapping */
-	adev->gmc.doorbell_aper_base = pci_resource_start(adev->pdev, 2);
-	adev->gmc.doorbell_aper_size = pci_resource_len(adev->pdev, 2);
-
-	if (adev->enable_mes) {
-		adev->doorbell.num_doorbells =
-			adev->gmc.doorbell_aper_size / sizeof(u32);
-	} else {
-		adev->doorbell.num_doorbells =
-			min_t(u32, adev->gmc.doorbell_aper_size / sizeof(u32),
-			      adev->doorbell_index.max_assignment+1);
-		if (adev->doorbell.num_doorbells == 0)
-			return -EINVAL;
-
-		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
-		 * paging queue doorbell use the second page. The
-		 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
-		 * doorbells are in the first page. So with paging queue enabled,
-		 * the max num_doorbells should + 1 page (0x400 in dword)
-		 */
-		if (adev->asic_type >= CHIP_VEGA10)
-			adev->doorbell.num_doorbells += 0x400;
-	}
-
-	adev->mman.doorbell_aper_base_kaddr = ioremap(adev->gmc.doorbell_aper_base,
-						      adev->doorbell.num_doorbells *
-						      sizeof(u32));
-	if (adev->mman.doorbell_aper_base_kaddr == NULL)
-		return -ENOMEM;
-
-	return 0;
-}
-
-/**
- * amdgpu_device_doorbell_fini - Tear down doorbell driver information.
- *
- * @adev: amdgpu_device pointer
- *
- * Tear down doorbell driver information (CIK)
- */
-static void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
-{
-	iounmap(adev->mman.doorbell_aper_base_kaddr);
-	adev->mman.doorbell_aper_base_kaddr = NULL;
-}
-
-
-
 /*
  * amdgpu_device_wb_*()
  * Writeback is the method by which the GPU updates special pages in memory
@@ -1239,7 +1163,6 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 			      cmd & ~PCI_COMMAND_MEMORY);
 
 	/* Free the VRAM and doorbell BAR, we most likely need to move both. */
-	amdgpu_device_doorbell_fini(adev);
 	if (adev->asic_type >= CHIP_BONAIRE)
 		pci_release_resource(adev->pdev, 2);
 
@@ -1253,11 +1176,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 
 	pci_assign_unassigned_bus_resources(adev->pdev->bus);
 
-	/* When the doorbell or fb BAR isn't available we have no chance of
-	 * using the device.
-	 */
-	r = amdgpu_device_doorbell_init(adev);
-	if (r || (pci_resource_flags(adev->pdev, 0) & IORESOURCE_UNSET))
+	if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
+		return -ENODEV;
+
+	if (pci_resource_flags(adev->pdev, 0) & IORESOURCE_UNSET)
 		return -ENODEV;
 
 	pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
@@ -3711,9 +3633,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (!adev->have_atomics_support)
 		dev_info(adev->dev, "PCIE atomic ops is not supported\n");
 
-	/* doorbell bar mapping and doorbell index init*/
-	amdgpu_device_doorbell_init(adev);
-
 	if (amdgpu_emu_mode == 1) {
 		/* post the asic on emulation mode */
 		emu_soc_asic_init(adev);
@@ -3941,14 +3860,14 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
 	/* Clear all CPU mappings pointing to this device */
 	unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
 
-	/* Unmap all mapped bars - Doorbell, registers and VRAM */
-	amdgpu_device_doorbell_fini(adev);
-
 	iounmap(adev->rmmio);
 	adev->rmmio = NULL;
 	if (adev->mman.vram_aper_base_kaddr)
 		iounmap(adev->mman.vram_aper_base_kaddr);
 	adev->mman.vram_aper_base_kaddr = NULL;
+	if (adev->mman.doorbell_aper_base_kaddr)
+		iounmap(adev->mman.doorbell_aper_base_kaddr);
+	adev->mman.doorbell_aper_base_kaddr = NULL;
 
 	/* Memory manager related */
 	if (!adev->gmc.xgmi.connected_to_cpu) {
@@ -4051,7 +3970,6 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 
 		iounmap(adev->rmmio);
 		adev->rmmio = NULL;
-		amdgpu_device_doorbell_fini(adev);
 		drm_dev_exit(idx);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index bb2230d14ea6..983826ae7509 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1705,6 +1705,63 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 	return 0;
 }
 
+/*
+ * GPU doorbell aperture helpers function.
+ */
+/**
+ * amdgpu_ttm_doorbell_init - Init doorbell driver information.
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Init doorbell driver information (CIK)
+ * Returns 0 on success, error on failure.
+ */
+static int amdgpu_ttm_doorbell_init(struct amdgpu_device *adev)
+{
+
+	/* No doorbell on SI hardware generation */
+	if (adev->asic_type < CHIP_BONAIRE) {
+		adev->gmc.doorbell_aper_base = 0;
+		adev->gmc.doorbell_aper_size = 0;
+		adev->doorbell.num_doorbells = 0;
+		adev->mman.doorbell_aper_base_kaddr = NULL;
+		return 0;
+	}
+
+	if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
+		return -EINVAL;
+
+	amdgpu_asic_init_doorbell_index(adev);
+
+	/* doorbell bar mapping */
+	adev->gmc.doorbell_aper_base = pci_resource_start(adev->pdev, 2);
+	adev->gmc.doorbell_aper_size = pci_resource_len(adev->pdev, 2);
+	adev->mman.doorbell_aper_base_kaddr = ioremap(adev->gmc.doorbell_aper_base,
+                                                    adev->gmc.doorbell_aper_size);
+
+	if (adev->enable_mes) {
+		adev->doorbell.num_doorbells =
+			adev->gmc.doorbell_aper_size / sizeof(u32);
+	} else {
+		adev->doorbell.num_doorbells =
+			min_t(u32, adev->gmc.doorbell_aper_size / sizeof(u32),
+			      adev->doorbell_index.max_assignment+1);
+		if (adev->doorbell.num_doorbells == 0)
+			return -EINVAL;
+
+		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
+		 * paging queue doorbell use the second page. The
+		 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
+		 * doorbells are in the first page. So with paging queue enabled,
+		 * the max num_doorbells should + 1 page (0x400 in dword)
+		 */
+		if (adev->asic_type >= CHIP_VEGA10)
+			adev->doorbell.num_doorbells += 0x400;
+	}
+
+	return 0;
+}
+
 /*
  * amdgpu_ttm_init - Init the memory management (ttm) as well as various
  * gtt/vram related fields.
@@ -1761,6 +1818,10 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 				adev->gmc.visible_vram_size);
 #endif
 
+	r = amdgpu_ttm_doorbell_init(adev);
+	if (r)
+		return r;
+
 	/*
 	 *The reserved vram for firmware must be pinned to the specified
 	 *place on the VRAM, so reserve it early.
@@ -1907,6 +1968,9 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 		if (adev->mman.vram_aper_base_kaddr)
 			iounmap(adev->mman.vram_aper_base_kaddr);
 		adev->mman.vram_aper_base_kaddr = NULL;
+		if (adev->mman.doorbell_aper_base_kaddr)
+			iounmap(adev->mman.doorbell_aper_base_kaddr);
+		adev->mman.doorbell_aper_base_kaddr = NULL;
 
 		drm_dev_exit(idx);
 	}
-- 
2.34.1

