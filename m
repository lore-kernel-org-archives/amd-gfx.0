Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EB8C6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 083ED10EB6D;
	Wed, 29 Mar 2023 15:48:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51F1310EB6F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:48:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D76jMFHIopEBgt2Dl5V0YhBzl41mpYgaKgdBHT9uqEEIjzCbYOqlOFDG+fJsPH+kWkxGJNVF2I3yGTC3YnrTiKPd3vzmo30NKBXtikR63C1geIKsTX5DSXHkZ5IjNsQAPnSJEFZixfh4i3U7vsLVb0T8Suk6dcvDhtHf073BcM9z2gtx7R4Xm33hZ4KMSXvveWnN4YJZICTz2uO6F1/fvwyWIixtL4MYSVJkoJ5P/+0AomATI7nrX0ACOcXS5IImiIwBGHI+Dk4F5Mu55BVistiO0Mp5UWDcey/jPGBqk4p1aYnsVP7eyZXCuLpZjRIXjS6ff6wuss7Qx96b+1F1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MuaI/+pk5HlGBbxhZdAkTn4ue35eDMdyZslOVdr/JE=;
 b=KLm2xlm6zKUpiQO/Qnj5KHXIEuw/XYL2SpW5e390agR6R2zaiVshskGx+iae6d5h6ZiLjHwh5sUnLDVD8eKKCaZP5hvwrtavr0V+Xys/9Tnk8Zo1rnoUAggNrjdTv3lTblZIWd4YW/ZQg2JV2C4MkExKWqHvKiN3kYdiA9esu6hTpcv0R3lkCyu8wIhkNybK64ZvFUCLSVvV8aGq9SA5Ynrwtf/EmaZ9nHfVLUdQm4MV8EmHKwxtUuCU7ZQeLEGL001C/CxeZtTF7EBSUObNhB0SPR4b2CRQu70gPLwkcxn8s5GaYOL9oimrmse102Br4sO+sXeUzoKVJMNIB7tx4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MuaI/+pk5HlGBbxhZdAkTn4ue35eDMdyZslOVdr/JE=;
 b=sNS49mMREJr/hVZJsav10Vaw2ELkNZBTKa5PBmseuFUvl/ovKb0QuV7gpe5eKieDu+c3FA+h22fkfYlKNVOeRlWmDHRFK+kIIv3wr/WCtwOWeVs8h0Qec/MNokYYB/Zw+wwCaW8WVNFnp8jafUutUoz4Dzddue4NDwQYasqnh4Y=
Received: from DM6PR11CA0071.namprd11.prod.outlook.com (2603:10b6:5:14c::48)
 by SJ2PR12MB7798.namprd12.prod.outlook.com (2603:10b6:a03:4c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 15:48:19 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::55) by DM6PR11CA0071.outlook.office365.com
 (2603:10b6:5:14c::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:48:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 15:48:19 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:48:17 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/16] drm/amdgpu: create a new file for doorbell manager
Date: Wed, 29 Mar 2023 17:47:40 +0200
Message-ID: <20230329154753.1261-4-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230329154753.1261-1-shashank.sharma@amd.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT028:EE_|SJ2PR12MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 53cd93b8-7cfa-4c2a-1868-08db306d0519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TY78VXFJJq3/x0Y1W4xdmFEgpI+g8e8s9ZOV/OF8pYFX6VMn5kU4vcoK3Sa60z4Kz+pMfnfhjxbBlttA9flNWSSwj7lNJA4zo9yXZh6GkvMMTMTfP+MXUhNlQRIVoYxC/NGVX2AeiKUix1e1E9JH8ZGIFx6OznzUcj7JcS3V8B6Y4BJssGYeS6sm5b3mBM+fuMRGvkaR6L5K2sku1Hd9TBrf2hvTko6QtWVep2AFJ8sHKyFHhl4mOi/GPMXgMqrcyQrk9Sl1DKi6b67xyUi9DlygQP8NkHVD5fyZAxwlqIshSQqxc+zQPVls5vr6PoD4MMJLT8ONtbHoAnsnZh3Brpc/ReCHJHc9yvu5bnHN+0Q2rHlbpGRlkbEdsC/nDfQRPlBv9lpJG2PdsPBdQLN5sC84ZuGVABAY+VVX1p/A1VmNa/B6zvmvaKUIo6eCdRWcKanKfA/GA7rZHUaCpLT7Wu06c6+HaKqargyCITDHO3DDKOvPNMBtjXKS3pW1PSPKc175pQPC+IMMDZQzaVNqLG/u1Ww6HIyIUsBq8TX24v82n1OT2WQQisAkwJm7Um8EkZqLZEdz5cqbTYXfvmMEr7dAoZvJasLvak+8wK0sBihL5GION5G59z0hghsLu/oSFf0b+yQT3gljOytnY44kSuT+gHiRLewFdCexA/qRm4t98byyaaLx5RZfLfd3GZIKf5zeij8wZqdAFj2Fl5GZIJ+Sro8K3zxi2S6PFXSHnec=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(36840700001)(40470700004)(46966006)(186003)(16526019)(54906003)(6666004)(316002)(26005)(1076003)(336012)(66899021)(426003)(83380400001)(2616005)(47076005)(7696005)(40460700003)(81166007)(478600001)(40480700001)(82310400005)(8936002)(44832011)(5660300002)(30864003)(86362001)(82740400003)(41300700001)(70206006)(356005)(4326008)(6916009)(8676002)(70586007)(2906002)(36860700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:48:19.7531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cd93b8-7cfa-4c2a-1868-08db306d0519
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7798
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
Cc: Mukul
 Joshi <mukul.joshi@amd.com>, Shashank Sharma <shashank.sharma@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <contactshashanksharma@gmail.com>

This patch:
- creates a new file for doorbell management.
- moves doorbell code from amdgpu_device.c to this file.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 164 ---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |  22 +++
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 186 ++++++++++++++++++
 4 files changed, 209 insertions(+), 165 deletions(-)
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
index 57ee1c4a81e9..7f8fcac4f18b 100644
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index 6064943a1b53..f9c3b77bf65d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -306,6 +306,28 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v);
 u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index);
 void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v);
 
+/*
+ * GPU doorbell aperture helpers function.
+ */
+/**
+ * amdgpu_device_doorbell_init - Init doorbell driver information.
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Init doorbell driver information (CIK)
+ * Returns 0 on success, error on failure.
+ */
+int amdgpu_device_doorbell_init(struct amdgpu_device *adev);
+
+/**
+ * amdgpu_device_doorbell_fini - Tear down doorbell driver information.
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Tear down doorbell driver information (CIK)
+ */
+void amdgpu_device_doorbell_fini(struct amdgpu_device *adev);
+
 #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
 #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
 #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
new file mode 100644
index 000000000000..2206926ba289
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -0,0 +1,186 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+	if (index < adev->doorbell.num_kernel_doorbells) {
+		return readl(adev->doorbell.ptr + index);
+	} else {
+		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
+		return 0;
+	}
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
+	if (index < adev->doorbell.num_kernel_doorbells) {
+		writel(v, adev->doorbell.ptr + index);
+	} else {
+		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
+	}
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
+	if (index < adev->doorbell.num_kernel_doorbells) {
+		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
+	} else {
+		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
+		return 0;
+	}
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
+	if (index < adev->doorbell.num_kernel_doorbells) {
+		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
+	} else {
+		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
+	}
+}
+
+/*
+ * GPU doorbell aperture helpers function.
+ */
+/**
+ * amdgpu_device_doorbell_init - Init doorbell driver information.
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Init doorbell driver information (CIK)
+ * Returns 0 on success, error on failure.
+ */
+int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
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
+ * amdgpu_device_doorbell_fini - Tear down doorbell driver information.
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Tear down doorbell driver information (CIK)
+ */
+void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
+{
+	iounmap(adev->doorbell.ptr);
+	adev->doorbell.ptr = NULL;
+}
-- 
2.40.0

