Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864B7C7619A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 16:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 376DC10E898;
	Wed, 12 Apr 2023 16:26:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5BB910E89A
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 16:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiKRa6VfbDB18udBlKMXaUw0c7KvtXibHGGB9c4zgoCGlka3kyfJSiZAOki9RasFOAIOP2oP7hEvqDQZcxQc4MGkdCzvs01Nj8kACRa+od057DvtI6NswLT77FNs1Dy3TshjifBnqOz8DVvU/UtukSmnIKLH1iizH5pDotOCxoWw/D+wrT8KiPQbjPrvJln3XgacPhRsEKnlDesQ0sWYSWSnqF2YtHoeaoKfGJbtgBHfUCTfP5gdwMYi3/7HwrsRO5L+Y0LfpLxmOrSlaZW1zkfG5x1qpWWrsiIYF3f8BgxGofFZ24DVXoe9BrI/29t9CDG5gVcG3BYNUT8Rdx1fIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/oh7I9F5SMHyt+JiVbeN1PwDgpoMsD6qUSy+oVFymA=;
 b=NaribPjxTXmNOOU29NVx2im9kc/9ZjtbsMFte8QX2xWDYm+1QdM9NFfCLaauskyrGCGnuLzWZmN3STblzlV5Y3qshO91Ggkng7XxDgCHwdS10xOW66thNt8lo8mbKTj172LhCW8yUzNa2YkaJOVY6lp2BIIjCJLj25oDrEWYIY7tZQns1SkOSVQtE0+kT7atLoZ/isRSyy9TBoSDsW8+qZwRLWN9sybbJBMSKnbaCEDnQ9j117cZFaz6QmZvzTITYoFS5eke5ui+Wz82rS7xeFPyUaSLQihvkgQu9hLVUzJ9+XZkJdEug80ssgAojRql8Ufj+T2bNG4NzrrAX/lm5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/oh7I9F5SMHyt+JiVbeN1PwDgpoMsD6qUSy+oVFymA=;
 b=oveElf3oglCEOjcfHHF4R2eAkhg3y69C06kT/kE/WQp3uO+QznvUyhlC0PFEnpK+QWbMyZdhIQDPXaqgHF6K2McnAGeq+RTqYVGbjewDLNlX5oNtBj5VwGnAyC7euG8kBjmLeVJng60geyIKw/XbBmA6HGo7n1JABtRyXeYdEDQ=
Received: from BLAPR03CA0013.namprd03.prod.outlook.com (2603:10b6:208:32b::18)
 by PH7PR12MB8154.namprd12.prod.outlook.com (2603:10b6:510:2b9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 12 Apr
 2023 16:26:01 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:32b:cafe::c3) by BLAPR03CA0013.outlook.office365.com
 (2603:10b6:208:32b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28 via Frontend
 Transport; Wed, 12 Apr 2023 16:26:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.27 via Frontend Transport; Wed, 12 Apr 2023 16:26:00 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 12 Apr
 2023 11:25:58 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 01/12] drm/amdgpu: create a new file for doorbell manager
Date: Wed, 12 Apr 2023 18:25:25 +0200
Message-ID: <20230412162537.1357-2-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230412162537.1357-1-shashank.sharma@amd.com>
References: <20230412162537.1357-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|PH7PR12MB8154:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b320c5d-5d50-4768-0197-08db3b729a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KTuomUAs7ePWlSB7724HdZiZDXGafTexmL11T/wTVMnoI4FZLB+kMzNRWnqaWG8YR3+wsByKjnqkfudd906ksj4LsLMW3ZPCWEU6DFFA5Um4EfAquYWQz57bB5Bhi2wfhXZrFFJnwd9JyURfq+Q9Qi6WwuUsIsmaOQJosPIOCGkXlX+B2/16lPnSGJvfYog4KUhH8y2gOcVD4BtV0VEuTDxPS3r9fQLyeTOH0P2lHnnqIqQQQ0iVZm26zFP9jV7BBv3oCHvlJC8oyPAxeqCIl2T4Tm3M6kMM+lM1hIp92udpEL1/PgUmXjap1yR7NRLR9y/8kyhFr9OVgpW+GI2EZLgES8AkaXOkcFzjZn7V+rPY+eez2dqMHIFhZBt+navSI9ZgcKx6cXWXlntiU2bVMLE5/5gjHzqOOTGDovRiNHnWrdOA7ElRh9hCIE6mUuhuBn0fn6AJ9zWlhqbhP4HH76bl4QQC4YXjIFdeB/i5G4OEEOZgTFspYB2b3T+P7LKCfA3Fub1woXXQ0CQdtL5is7Y5rDlRKVo7Pg73fWywfu5D0bJApFyVefsov6i88/0N9mAjfcPk57y9lTRdP/mQKkX0jm45mJffqnQB7KGlQG+CIAE8Mln4zymydPCab6f+a0G1iCjHx5ub3VkC4AnSoNz7coEaHYTgKeIpiuOvfR9v28Y2znM3gkFbhGRZ9wLJmEc9cHTM7QKu9CHaavVI4cczcX1LXhdI83Q1R74MZNg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(66899021)(36860700001)(36756003)(40460700003)(5660300002)(44832011)(2906002)(30864003)(8676002)(8936002)(40480700001)(86362001)(82310400005)(70206006)(6916009)(82740400003)(81166007)(41300700001)(4326008)(70586007)(356005)(2616005)(83380400001)(336012)(47076005)(54906003)(186003)(316002)(7696005)(26005)(478600001)(1076003)(426003)(16526019)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 16:26:00.0057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b320c5d-5d50-4768-0197-08db3b729a14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8154
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
Cc: mukul.joshi@amd.com, Shashank Sharma <shashank.sharma@amd.com>,
 arvind.yadav@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch:
- creates a new file for doorbell management.
- moves doorbell code from amdgpu_device.c to this file.

V2:
 - remove doc from function declaration (Christian)
 - remove 'device' from function names to make it consistent (Alex)
 - add SPDX license identifier (Luben)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 174 +----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |   6 +
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 183 ++++++++++++++++++
 4 files changed, 195 insertions(+), 170 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 798d0e9a60b7..204665f20319 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -41,7 +41,7 @@ ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
 amdgpu-y := amdgpu_drv.o
 
 # add KMS driver
-amdgpu-y += amdgpu_device.o amdgpu_kms.o \
+amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_atombios.o atombios_crtc.o amdgpu_connectors.o \
 	atom.o amdgpu_fence.o amdgpu_ttm.o amdgpu_object.o amdgpu_gart.o \
 	amdgpu_encoders.o amdgpu_display.o amdgpu_i2c.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 57ee1c4a81e9..88c75f7a8d66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -579,94 +579,6 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
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
@@ -1016,82 +928,6 @@ int amdgpu_device_pci_reset(struct amdgpu_device *adev)
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
@@ -1239,7 +1075,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 			      cmd & ~PCI_COMMAND_MEMORY);
 
 	/* Free the VRAM and doorbell BAR, we most likely need to move both. */
-	amdgpu_device_doorbell_fini(adev);
+	amdgpu_doorbell_fini(adev);
 	if (adev->asic_type >= CHIP_BONAIRE)
 		pci_release_resource(adev->pdev, 2);
 
@@ -1256,7 +1092,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	/* When the doorbell or fb BAR isn't available we have no chance of
 	 * using the device.
 	 */
-	r = amdgpu_device_doorbell_init(adev);
+	r = amdgpu_doorbell_init(adev);
 	if (r || (pci_resource_flags(adev->pdev, 0) & IORESOURCE_UNSET))
 		return -ENODEV;
 
@@ -3712,7 +3548,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		dev_info(adev->dev, "PCIE atomic ops is not supported\n");
 
 	/* doorbell bar mapping and doorbell index init*/
-	amdgpu_device_doorbell_init(adev);
+	amdgpu_doorbell_init(adev);
 
 	if (amdgpu_emu_mode == 1) {
 		/* post the asic on emulation mode */
@@ -3942,7 +3778,7 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
 	unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
 
 	/* Unmap all mapped bars - Doorbell, registers and VRAM */
-	amdgpu_device_doorbell_fini(adev);
+	amdgpu_doorbell_fini(adev);
 
 	iounmap(adev->rmmio);
 	adev->rmmio = NULL;
@@ -4051,7 +3887,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 
 		iounmap(adev->rmmio);
 		adev->rmmio = NULL;
-		amdgpu_device_doorbell_fini(adev);
+		amdgpu_doorbell_fini(adev);
 		drm_dev_exit(idx);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index 908433ac6cb3..3e77a6b4bd69 100644
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
index 000000000000..64fec954815d
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0+
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
2.40.0

