Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD821EB64DB
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jun 2023 17:16:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 816F610E2F5;
	Tue, 20 Jun 2023 17:16:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA9010E0A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 17:16:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeFEgxC8phei8J8xTmXSrKBJKvllBT7NSJMozBuyExXmtKkj5ksBL38Ya9eMjMjaTEcrEL4qQwt/6JPXFWX5KdIFtGqovixUzVOVIslyDAKUKsZ0WomURY6OBiZ/rD+qoDAjoOjD9xiOQdyQAKfZeSnY0qdc3hngap58OJESwVzNA+2sjhqIiouC/gCf1dGRcH78IV6XZ9HBUOCDRPf1PFteZVnMprTBoTv6Q+03ZdWCbhEgsZWG0CH7WXIEx0gTidIbJr3Fl166PacqjDB5TDj00PyBFKTvx2INfPB9Y+Jv6NMEDhw/AJMu8LcD61L8y9RW9+LZ9bSrWdgXsrwGXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bP5jFbT76VzCJpO1JslIC+NH4CHigeeTE1Sd8tJu8hw=;
 b=a9rHGDwgzh+7N29fYFVVvWqHBBnR32Srs4pf02uHDFRvqmSGcUYf0OgIm2FmjzcIePo6sfSvBXtaFj0UJsUuFkaFxIG/GIKxGASNKH8E8G4uD9qg1FgFAT0CGgN86LLV8GwM3iMnyTcgVHGp0LJFCPtFbobg2ODLZz78MNULflQB0y4hPC80KFTUx5HMM8mDFGhci+4s/seFklgL/8ZL+0M+D+Clk5mLpVFADSEsW0KdwBjSb7aBDd6Nnk19iSxgwU7s4CQNy2AQb9uLXdrZJXaWQzjY31bDInVlnV8rWGq24wNUWYlqlkv6r1o1Ev++eksinjVe3nUFl+s/wDTfUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bP5jFbT76VzCJpO1JslIC+NH4CHigeeTE1Sd8tJu8hw=;
 b=FAuaWn/e8hHgdmmwwnU2pozV7O2/I27Z4Z9SLF1gTD/QQ0Y5JtYiM+k44JwtusdTX1kEkfoXdUR5/Wy+6iVYbvO9azmwxbCSLFcIb2iaT5/tFCnspEnGch1TmPCavA6UDJ5cd9f216A+3BEzFcNvbaUEIOXLmZ9INDZoZ7jGrCY=
Received: from BYAPR07CA0051.namprd07.prod.outlook.com (2603:10b6:a03:60::28)
 by SJ1PR12MB6291.namprd12.prod.outlook.com (2603:10b6:a03:456::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 17:16:26 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:60:cafe::d) by BYAPR07CA0051.outlook.office365.com
 (2603:10b6:a03:60::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Tue, 20 Jun 2023 17:16:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.37 via Frontend Transport; Tue, 20 Jun 2023 17:16:26 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 12:16:23 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 01/12] drm/amdgpu: create a new file for doorbell manager
Date: Tue, 20 Jun 2023 19:15:57 +0200
Message-ID: <20230620171608.2131-2-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230620171608.2131-1-shashank.sharma@amd.com>
References: <20230620171608.2131-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|SJ1PR12MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b44c188-b49f-4606-0329-08db71b21450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBze2B/U6mDVoVt1kgvEdtdl/EX7FWAIkAZWbn2Xop56ZkMT+nmYqG2B7ZRXuiOSytCa+TSD4lxeYvkYaKcmT+YRonQ5XXP1IMXtbKzHOOYzd/VqqVeZ+PYwF3pkSxIZBgLE12rPJBLRqrWWGgAUG+FmQb7hnLTNjg2NDHSS7YaDi0b6o3cjMSNDD5KU+n5ymKN8kw1JQqIiS6EuxPu42fV+F0/ANKdPYSa/cJNvnBdRQqyhmCJgfkn/ODJhCVC5Fy6uwTmxo04oaiwfPG7JFAerH1ql5lCJ98NfmKLwMS0c4wJkD0ERKeD9mv4cmusOzzgVpL1i18m/wQTScsa17O6vGUI21wbGfeiF4+d8n6vTmZQmJcSTr1AYJJhkzsfVihcpEephCW3yLJCdQoXEOmpRnzDXDa9n+kGFNM5GtkwN8H5VXHEeFGJEMR01AwU/WNISTSvc0HHmMboPlMXqDWQ242UvBHJjzKGlzE8il5AzmodY79PQny2llnXGw/Jm/JuGbRZY237MQTronmMbaBaemMDZ3o1IbSoz6f05stCBRNt86f7o+uQ6DR/ONQRyeJ2Q7g2iiqa/SlE5dWSEwPYU3v8+8nTprv33L7HX0GLnVYOsr+/UL6h0LK0oLtz++q4zD/ZE5mkaC4C0/b8t6pbssjZlr/9eXfL5/t/tY9SMN1N41w4ZAkUeUmtL/OJQNryEFW8R1cTNtGOggypaDGiQEsRtYVuz8z9xPzm7jnnsajsR84j8u8ouEODMa7tFR+lPmYzyv1LDulT2cx88rQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(81166007)(356005)(336012)(426003)(66574015)(2616005)(86362001)(83380400001)(2906002)(47076005)(30864003)(36860700001)(44832011)(5660300002)(66899021)(82740400003)(4326008)(40460700003)(54906003)(82310400005)(70586007)(186003)(70206006)(8676002)(16526019)(8936002)(478600001)(36756003)(41300700001)(6916009)(40480700001)(1076003)(26005)(316002)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 17:16:26.1337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b44c188-b49f-4606-0329-08db71b21450
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6291
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch:
- creates a new file for doorbell management.
- moves doorbell code from amdgpu_device.c to this file.

V2:
 - remove doc from function declaration (Christian)
 - remove 'device' from function names to make it consistent (Alex)
 - add SPDX license identifier (Luben)

V3:
 - change license to MIT license(Christian)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 174 +----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |   6 +
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 183 ++++++++++++++++++
 4 files changed, 195 insertions(+), 170 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 415a7fa395c4..b0b2cd21160a 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -42,7 +42,7 @@ ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
 amdgpu-y := amdgpu_drv.o
 
 # add KMS driver
-amdgpu-y += amdgpu_device.o amdgpu_kms.o \
+amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_atombios.o atombios_crtc.o amdgpu_connectors.o \
 	atom.o amdgpu_fence.o amdgpu_ttm.o amdgpu_object.o amdgpu_gart.o \
 	amdgpu_encoders.o amdgpu_display.o amdgpu_i2c.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5c7d40873ee2..253f9533de1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -588,94 +588,6 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 	}
 }
 
-/**
- * amdgpu_mm_rdoorbell - read a doorbell dword
- *
- * @adev: amdgpu_device pointer
- * @index: doorbell index
- *
- * Returns the value in the doorbell aperture at the
- * requested doorbell index (CIK).
- */
-u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
-{
-	if (amdgpu_device_skip_hw_access(adev))
-		return 0;
-
-	if (index < adev->doorbell.num_kernel_doorbells) {
-		return readl(adev->doorbell.ptr + index);
-	} else {
-		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
-		return 0;
-	}
-}
-
-/**
- * amdgpu_mm_wdoorbell - write a doorbell dword
- *
- * @adev: amdgpu_device pointer
- * @index: doorbell index
- * @v: value to write
- *
- * Writes @v to the doorbell aperture at the
- * requested doorbell index (CIK).
- */
-void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
-{
-	if (amdgpu_device_skip_hw_access(adev))
-		return;
-
-	if (index < adev->doorbell.num_kernel_doorbells) {
-		writel(v, adev->doorbell.ptr + index);
-	} else {
-		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
-	}
-}
-
-/**
- * amdgpu_mm_rdoorbell64 - read a doorbell Qword
- *
- * @adev: amdgpu_device pointer
- * @index: doorbell index
- *
- * Returns the value in the doorbell aperture at the
- * requested doorbell index (VEGA10+).
- */
-u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
-{
-	if (amdgpu_device_skip_hw_access(adev))
-		return 0;
-
-	if (index < adev->doorbell.num_kernel_doorbells) {
-		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
-	} else {
-		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
-		return 0;
-	}
-}
-
-/**
- * amdgpu_mm_wdoorbell64 - write a doorbell Qword
- *
- * @adev: amdgpu_device pointer
- * @index: doorbell index
- * @v: value to write
- *
- * Writes @v to the doorbell aperture at the
- * requested doorbell index (VEGA10+).
- */
-void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
-{
-	if (amdgpu_device_skip_hw_access(adev))
-		return;
-
-	if (index < adev->doorbell.num_kernel_doorbells) {
-		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
-	} else {
-		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
-	}
-}
-
 /**
  * amdgpu_device_indirect_rreg - read an indirect register
  *
@@ -1042,82 +954,6 @@ int amdgpu_device_pci_reset(struct amdgpu_device *adev)
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
-		adev->doorbell.base = 0;
-		adev->doorbell.size = 0;
-		adev->doorbell.num_kernel_doorbells = 0;
-		adev->doorbell.ptr = NULL;
-		return 0;
-	}
-
-	if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
-		return -EINVAL;
-
-	amdgpu_asic_init_doorbell_index(adev);
-
-	/* doorbell bar mapping */
-	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
-	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
-
-	if (adev->enable_mes) {
-		adev->doorbell.num_kernel_doorbells =
-			adev->doorbell.size / sizeof(u32);
-	} else {
-		adev->doorbell.num_kernel_doorbells =
-			min_t(u32, adev->doorbell.size / sizeof(u32),
-			      adev->doorbell_index.max_assignment+1);
-		if (adev->doorbell.num_kernel_doorbells == 0)
-			return -EINVAL;
-
-		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
-		 * paging queue doorbell use the second page. The
-		 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
-		 * doorbells are in the first page. So with paging queue enabled,
-		 * the max num_kernel_doorbells should + 1 page (0x400 in dword)
-		 */
-		if (adev->asic_type >= CHIP_VEGA10)
-			adev->doorbell.num_kernel_doorbells += 0x400;
-	}
-
-	adev->doorbell.ptr = ioremap(adev->doorbell.base,
-				     adev->doorbell.num_kernel_doorbells *
-				     sizeof(u32));
-	if (adev->doorbell.ptr == NULL)
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
-	iounmap(adev->doorbell.ptr);
-	adev->doorbell.ptr = NULL;
-}
-
-
-
 /*
  * amdgpu_device_wb_*()
  * Writeback is the method by which the GPU updates special pages in memory
@@ -1265,7 +1101,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 			      cmd & ~PCI_COMMAND_MEMORY);
 
 	/* Free the VRAM and doorbell BAR, we most likely need to move both. */
-	amdgpu_device_doorbell_fini(adev);
+	amdgpu_doorbell_fini(adev);
 	if (adev->asic_type >= CHIP_BONAIRE)
 		pci_release_resource(adev->pdev, 2);
 
@@ -1282,7 +1118,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	/* When the doorbell or fb BAR isn't available we have no chance of
 	 * using the device.
 	 */
-	r = amdgpu_device_doorbell_init(adev);
+	r = amdgpu_doorbell_init(adev);
 	if (r || (pci_resource_flags(adev->pdev, 0) & IORESOURCE_UNSET))
 		return -ENODEV;
 
@@ -3772,7 +3608,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		dev_info(adev->dev, "PCIE atomic ops is not supported\n");
 
 	/* doorbell bar mapping and doorbell index init*/
-	amdgpu_device_doorbell_init(adev);
+	amdgpu_doorbell_init(adev);
 
 	if (amdgpu_emu_mode == 1) {
 		/* post the asic on emulation mode */
@@ -4010,7 +3846,7 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
 	unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
 
 	/* Unmap all mapped bars - Doorbell, registers and VRAM */
-	amdgpu_device_doorbell_fini(adev);
+	amdgpu_doorbell_fini(adev);
 
 	iounmap(adev->rmmio);
 	adev->rmmio = NULL;
@@ -4124,7 +3960,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 
 		iounmap(adev->rmmio);
 		adev->rmmio = NULL;
-		amdgpu_device_doorbell_fini(adev);
+		amdgpu_doorbell_fini(adev);
 		drm_dev_exit(idx);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index 8fd11497faba..783e2b8b086c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -306,6 +306,12 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v);
 u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index);
 void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v);
 
+/*
+ * GPU doorbell aperture helpers function.
+ */
+int amdgpu_doorbell_init(struct amdgpu_device *adev);
+void amdgpu_doorbell_fini(struct amdgpu_device *adev);
+
 #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
 #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
 #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
new file mode 100644
index 000000000000..31db526d4921
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include "amdgpu.h"
+
+/**
+ * amdgpu_mm_rdoorbell - read a doorbell dword
+ *
+ * @adev: amdgpu_device pointer
+ * @index: doorbell index
+ *
+ * Returns the value in the doorbell aperture at the
+ * requested doorbell index (CIK).
+ */
+u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
+{
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
+	if (index < adev->doorbell.num_kernel_doorbells)
+		return readl(adev->doorbell.ptr + index);
+
+	DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
+	return 0;
+}
+
+/**
+ * amdgpu_mm_wdoorbell - write a doorbell dword
+ *
+ * @adev: amdgpu_device pointer
+ * @index: doorbell index
+ * @v: value to write
+ *
+ * Writes @v to the doorbell aperture at the
+ * requested doorbell index (CIK).
+ */
+void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
+{
+	if (amdgpu_device_skip_hw_access(adev))
+		return;
+
+	if (index < adev->doorbell.num_kernel_doorbells)
+		writel(v, adev->doorbell.ptr + index);
+	else
+		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
+}
+
+/**
+ * amdgpu_mm_rdoorbell64 - read a doorbell Qword
+ *
+ * @adev: amdgpu_device pointer
+ * @index: doorbell index
+ *
+ * Returns the value in the doorbell aperture at the
+ * requested doorbell index (VEGA10+).
+ */
+u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
+{
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
+	if (index < adev->doorbell.num_kernel_doorbells)
+		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
+
+	DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
+	return 0;
+}
+
+/**
+ * amdgpu_mm_wdoorbell64 - write a doorbell Qword
+ *
+ * @adev: amdgpu_device pointer
+ * @index: doorbell index
+ * @v: value to write
+ *
+ * Writes @v to the doorbell aperture at the
+ * requested doorbell index (VEGA10+).
+ */
+void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
+{
+	if (amdgpu_device_skip_hw_access(adev))
+		return;
+
+	if (index < adev->doorbell.num_kernel_doorbells)
+		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
+	else
+		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
+}
+
+/*
+ * GPU doorbell aperture helpers function.
+ */
+/**
+ * amdgpu_doorbell_init - Init doorbell driver information.
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Init doorbell driver information (CIK)
+ * Returns 0 on success, error on failure.
+ */
+int amdgpu_doorbell_init(struct amdgpu_device *adev)
+{
+
+	/* No doorbell on SI hardware generation */
+	if (adev->asic_type < CHIP_BONAIRE) {
+		adev->doorbell.base = 0;
+		adev->doorbell.size = 0;
+		adev->doorbell.num_kernel_doorbells = 0;
+		adev->doorbell.ptr = NULL;
+		return 0;
+	}
+
+	if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
+		return -EINVAL;
+
+	amdgpu_asic_init_doorbell_index(adev);
+
+	/* doorbell bar mapping */
+	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
+	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
+
+	if (adev->enable_mes) {
+		adev->doorbell.num_kernel_doorbells =
+			adev->doorbell.size / sizeof(u32);
+	} else {
+		adev->doorbell.num_kernel_doorbells =
+			min_t(u32, adev->doorbell.size / sizeof(u32),
+			      adev->doorbell_index.max_assignment+1);
+		if (adev->doorbell.num_kernel_doorbells == 0)
+			return -EINVAL;
+
+		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
+		 * paging queue doorbell use the second page. The
+		 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
+		 * doorbells are in the first page. So with paging queue enabled,
+		 * the max num_kernel_doorbells should + 1 page (0x400 in dword)
+		 */
+		if (adev->asic_type >= CHIP_VEGA10)
+			adev->doorbell.num_kernel_doorbells += 0x400;
+	}
+
+	adev->doorbell.ptr = ioremap(adev->doorbell.base,
+				     adev->doorbell.num_kernel_doorbells *
+				     sizeof(u32));
+	if (adev->doorbell.ptr == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * amdgpu_doorbell_fini - Tear down doorbell driver information.
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Tear down doorbell driver information (CIK)
+ */
+void amdgpu_doorbell_fini(struct amdgpu_device *adev)
+{
+	iounmap(adev->doorbell.ptr);
+	adev->doorbell.ptr = NULL;
+}
-- 
2.40.1

