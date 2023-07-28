Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58F7C001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 16:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4068710E725;
	Fri, 28 Jul 2023 16:41:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2E8610E211
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 16:41:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQU9kPwiVThlsX4+BPOdMRCS/f7bmUrM0D9FIdn7QC9yfkCY1GOOPOJwIdYhsQB3lIGtQj27loRFOwouRF/exAfW0drkkhCCl+IRL+Ouf8gAOKePpf2PHD8vb0BqcTvcXz9Xj/3JMoO0HESZ/lLndzVaCQUGX0cqBYE0wNLLAJd39U7ifuwULReEw16A5jzDChPDVnJolPmFspQpQ4wFOgSzii/xclSugcvUpmXhmJydQ+TmMzdA2cZRryHCL0n2qqnpxtfMqPxF7EKVrPJVMy9A8gC/RasRTuEuiZDIyb/EUHXE+pih1c70K2i9O6jZinfLk1CurMVEIl5FaeTUrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PU9MTHIN3Ilm7uMA0r8jjN4UY8mOfaYTSVfm2BVvLRs=;
 b=TDvc6wtKezdRSrCOb+0VIe9OVo0UHJIj2UPrjzEIE+vBoRDp4a/g/7ysxx67CC76O6dyVNXCqeGA7/R/TPm19mqhD4N+CL4Zy9tM5Vn2KzpASPIoGf9kOleLALZh7zv198/dWMSQTCrAZd1Ebqr3Aq7SddjiY8JtBZkQsn4vFSCxYq+egM7WGPSqdNVSzaDFzDEMRcyBWUOzZwsPZUt00V8yQPxOyFWiLBdQcjCQpeJaPeR25CgXhmzBEWE7gfVcFQGnwz67v4G36Sap+tUvW/9+y3/UR3hzy7BTWwXLAGnAQ0zpLaMXF4KW+QKK0RtOOHEzIbXb+IUtPj+6oHLKwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PU9MTHIN3Ilm7uMA0r8jjN4UY8mOfaYTSVfm2BVvLRs=;
 b=VgOQO3TkFkeu+r0Dlvomk2mEsJNwEVpFaPPjLyDiIOiaM46yHwRJYFVQfSuKKd5ceAGjOQ5DelvKhoR/XA+91VYgCzFNumwoFwLPf2hs1yOKECr7X/3XNY8YwjQgwVnul5s5Hw9o1M7CVNsTqwgTPxyonZxedoVW0KPa8ZAZ54A=
Received: from DM6PR08CA0045.namprd08.prod.outlook.com (2603:10b6:5:1e0::19)
 by BL1PR12MB5319.namprd12.prod.outlook.com (2603:10b6:208:317::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 16:41:18 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::b5) by DM6PR08CA0045.outlook.office365.com
 (2603:10b6:5:1e0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.34 via Frontend
 Transport; Fri, 28 Jul 2023 16:41:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 16:41:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 11:41:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdkfd: drop IOMMUv2 support
Date: Fri, 28 Jul 2023 12:41:02 -0400
Message-ID: <20230728164102.3327956-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728164102.3327956-1-alexander.deucher@amd.com>
References: <20230728164102.3327956-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT066:EE_|BL1PR12MB5319:EE_
X-MS-Office365-Filtering-Correlation-Id: 8caac70f-9038-4925-d9a0-08db8f8977f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bIzepeiRX5l3mnDFZ15KQcnKY3H2mMQIlrVoxe4Vpfpc9mtzIAZARGyrg49GX6xl90N+5uCOI4dJcVSVD3dBHOYxblM2vPoM1VJb1S12uC1xCfndrkj2FNkuwkK9igiXyNCzX4rcDF+20hyPPqg7PkSTVRPcnwnFW4iRQFs+yS3ZGMWrzR9zESmPRbnAzPh2ZjK/QX1swHAQxhVm+UJzyD0FBgghikCpaEielY6U0tgT/fpsO/0reclc4lZhrQ/vkLPFpbfJu/IIFzvLLqN/SXzfq4ECLXgN1S7mKX/mSdSwUXPD2kti2s3lCEv+JmoUdwDUoWtgy2PT5w4ZVTqXBIaws0IsZt1jZmsQCpIC6McI+p90as8wtkJ5DhOdIl/cRk/4FWyT11yICHf15LuKyV5ulOq1Wtx89Nb12wdICv/InCZdLvZVDYEI+kaNzIhNTkeReIvo97+SJEb7AHZtN2zauG/YZnIypNCElEg/qORos5MZlo2jqVgRNFx5xqLf6hHxIXUNcqWSYSnYdAD69+i+NGpHv1S9X6xOu8Odc/WH0PGZC50TSONLcBoeO6y37559ZPTIEOQV574ngFdkeeAAqobKJ3OXWhlbDgSlMNGVQBLNIzyJAju+rC/CidfK6TCog8YT7iuWSInvKId9ygSmxyZEgyIFsfWJi1E0AFbqhH63JSTogbu8bo6lzLJAG9otfibGRVZFgNlCNvhwKEomY+2BFDDUeWDVSo57jLt2RGPAYbo3tGJivgtO1aSmD3/FrZQca/Cg6ApZSB0z2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(83380400001)(7696005)(356005)(66899021)(2906002)(40460700003)(2616005)(47076005)(6666004)(30864003)(426003)(40480700001)(1076003)(36860700001)(26005)(86362001)(478600001)(5660300002)(41300700001)(336012)(70206006)(82740400003)(81166007)(186003)(316002)(70586007)(8676002)(36756003)(6916009)(8936002)(4326008)(16526019)(36900700001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 16:41:18.8299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8caac70f-9038-4925-d9a0-08db8f8977f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5319
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Now that we use the dGPU path for all APUs, drop the
IOMMUv2 support.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  10 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   7 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   9 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  14 -
 drivers/gpu/drm/amd/amdkfd/Kconfig            |   1 -
 drivers/gpu/drm/amd/amdkfd/Makefile           |   4 -
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |   3 -
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  73 ----
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h         |   1 -
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  37 --
 .../amd/amdkfd/kfd_device_queue_manager_v9.c  |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  82 ----
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  35 +-
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c        | 356 ------------------
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.h        |  84 -----
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  14 -
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  16 -
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 111 +-----
 18 files changed, 28 insertions(+), 831 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
 delete mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_iommu.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 629ca1ad75a86..df633e9ce9205 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -226,16 +226,6 @@ void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm)
 		kgd2kfd_suspend(adev->kfd.dev, run_pm);
 }
 
-int amdgpu_amdkfd_resume_iommu(struct amdgpu_device *adev)
-{
-	int r = 0;
-
-	if (adev->kfd.dev)
-		r = kgd2kfd_resume_iommu(adev->kfd.dev);
-
-	return r;
-}
-
 int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
 {
 	int r = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index b34418e3e006e..559f14cc0a991 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -149,7 +149,6 @@ int amdgpu_amdkfd_init(void);
 void amdgpu_amdkfd_fini(void);
 
 void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
-int amdgpu_amdkfd_resume_iommu(struct amdgpu_device *adev);
 int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
 void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 			const void *ih_ring_entry);
@@ -400,7 +399,6 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 			 const struct kgd2kfd_shared_resources *gpu_resources);
 void kgd2kfd_device_exit(struct kfd_dev *kfd);
 void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
-int kgd2kfd_resume_iommu(struct kfd_dev *kfd);
 int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
 int kgd2kfd_pre_reset(struct kfd_dev *kfd);
 int kgd2kfd_post_reset(struct kfd_dev *kfd);
@@ -440,11 +438,6 @@ static inline void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 {
 }
 
-static int __maybe_unused kgd2kfd_resume_iommu(struct kfd_dev *kfd)
-{
-	return 0;
-}
-
 static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 215c4de2717fd..660fe09eb9e48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3274,12 +3274,6 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
 {
 	int r;
 
-	if (!adev->in_s0ix) {
-		r = amdgpu_amdkfd_resume_iommu(adev);
-		if (r)
-			return r;
-	}
-
 	r = amdgpu_device_ip_resume_phase1(adev);
 	if (r)
 		return r;
@@ -4979,9 +4973,6 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 				dev_warn(tmp_adev->dev, "asic atom init failed!");
 			} else {
 				dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
-				r = amdgpu_amdkfd_resume_iommu(tmp_adev);
-				if (r)
-					goto out;
 
 				r = amdgpu_device_ip_resume_phase1(tmp_adev);
 				if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 11d30092f0ad1..6d26b8a70519c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -756,20 +756,6 @@ module_param(debug_largebar, int, 0444);
 MODULE_PARM_DESC(debug_largebar,
 	"Debug large-bar flag used to simulate large-bar capability on non-large bar machine (0 = disable, 1 = enable)");
 
-/**
- * DOC: ignore_crat (int)
- * Ignore CRAT table during KFD initialization. By default, KFD uses the ACPI CRAT
- * table to get information about AMD APUs. This option can serve as a workaround on
- * systems with a broken CRAT table.
- *
- * Default is auto (according to asic type, iommu_v2, and crat table, to decide
- * whether use CRAT)
- */
-int ignore_crat;
-module_param(ignore_crat, int, 0444);
-MODULE_PARM_DESC(ignore_crat,
-	"Ignore CRAT table during KFD initialization (0 = auto (default), 1 = ignore CRAT)");
-
 /**
  * DOC: halt_if_hws_hang (int)
  * Halt if HWS hang is detected. Default value, 0, disables the halt on hang.
diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
index 93bd4eda0d94f..d3c3d3ab72255 100644
--- a/drivers/gpu/drm/amd/amdkfd/Kconfig
+++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
@@ -6,7 +6,6 @@
 config HSA_AMD
 	bool "HSA kernel driver for AMD GPU devices"
 	depends on DRM_AMDGPU && (X86_64 || ARM64 || PPC64)
-	imply AMD_IOMMU_V2 if X86_64
 	select HMM_MIRROR
 	select MMU_NOTIFIER
 	select DRM_AMDGPU_USERPTR
diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/amdkfd/Makefile
index 2ec8f27c5366c..a5ae7bcf44eb8 100644
--- a/drivers/gpu/drm/amd/amdkfd/Makefile
+++ b/drivers/gpu/drm/amd/amdkfd/Makefile
@@ -59,10 +59,6 @@ AMDKFD_FILES	:= $(AMDKFD_PATH)/kfd_module.o \
 		$(AMDKFD_PATH)/kfd_crat.o \
 		$(AMDKFD_PATH)/kfd_debug.o
 
-ifneq ($(CONFIG_AMD_IOMMU_V2),)
-AMDKFD_FILES += $(AMDKFD_PATH)/kfd_iommu.o
-endif
-
 ifneq ($(CONFIG_DEBUG_FS),)
 AMDKFD_FILES += $(AMDKFD_PATH)/kfd_debugfs.o
 endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index aef8e12df61f6..5f83ddc33cc41 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1025,9 +1025,6 @@ bool kfd_dev_is_large_bar(struct kfd_node *dev)
 		return true;
 	}
 
-	if (dev->kfd->use_iommu_v2)
-		return false;
-
 	if (dev->local_mem_info.local_mem_size_private == 0 &&
 	    dev->local_mem_info.local_mem_size_public > 0)
 		return true;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index f5a6f562e2a80..86fb7ac7982a1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -26,7 +26,6 @@
 #include "kfd_crat.h"
 #include "kfd_priv.h"
 #include "kfd_topology.h"
-#include "kfd_iommu.h"
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
 
@@ -1536,72 +1535,6 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
 	return num_of_cache_types;
 }
 
-static bool kfd_ignore_crat(void)
-{
-	bool ret;
-
-	if (ignore_crat)
-		return true;
-
-	ret = true;
-
-	return ret;
-}
-
-/*
- * kfd_create_crat_image_acpi - Allocates memory for CRAT image and
- * copies CRAT from ACPI (if available).
- * NOTE: Call kfd_destroy_crat_image to free CRAT image memory
- *
- *	@crat_image: CRAT read from ACPI. If no CRAT in ACPI then
- *		     crat_image will be NULL
- *	@size: [OUT] size of crat_image
- *
- *	Return 0 if successful else return error code
- */
-int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
-{
-	struct acpi_table_header *crat_table;
-	acpi_status status;
-	void *pcrat_image;
-	int rc = 0;
-
-	if (!crat_image)
-		return -EINVAL;
-
-	*crat_image = NULL;
-
-	if (kfd_ignore_crat()) {
-		pr_info("CRAT table disabled by module option\n");
-		return -ENODATA;
-	}
-
-	/* Fetch the CRAT table from ACPI */
-	status = acpi_get_table(CRAT_SIGNATURE, 0, &crat_table);
-	if (status == AE_NOT_FOUND) {
-		pr_info("CRAT table not found\n");
-		return -ENODATA;
-	} else if (ACPI_FAILURE(status)) {
-		const char *err = acpi_format_exception(status);
-
-		pr_err("CRAT table error: %s\n", err);
-		return -EINVAL;
-	}
-
-	pcrat_image = kvmalloc(crat_table->length, GFP_KERNEL);
-	if (!pcrat_image) {
-		rc = -ENOMEM;
-		goto out;
-	}
-
-	memcpy(pcrat_image, crat_table, crat_table->length);
-	*crat_image = pcrat_image;
-	*size = crat_table->length;
-out:
-	acpi_put_table(crat_table);
-	return rc;
-}
-
 /* Memory required to create Virtual CRAT.
  * Since there is no easy way to predict the amount of memory required, the
  * following amount is allocated for GPU Virtual CRAT. This is
@@ -2169,12 +2102,6 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 
 	cu->hsa_capability = 0;
 
-	/* Check if this node supports IOMMU. During parsing this flag will
-	 * translate to HSA_CAP_ATS_PRESENT
-	 */
-	if (!kfd_iommu_check_device(kdev->kfd))
-		cu->hsa_capability |= CRAT_CU_FLAGS_IOMMU_PRESENT;
-
 	crat_table->length += sub_type_hdr->length;
 	crat_table->total_entries++;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
index fc719389b5d65..387a8ef493855 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
@@ -307,7 +307,6 @@ struct kfd_gpu_cache_info {
 };
 int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pcache_info);
 
-int kfd_create_crat_image_acpi(void **crat_image, size_t *size);
 void kfd_destroy_crat_image(void *crat_image);
 int kfd_parse_crat_table(void *crat_image, struct list_head *device_list,
 			 uint32_t proximity_domain);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 80362074f9796..3403eb1ba848c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -30,7 +30,6 @@
 #include "kfd_pm4_headers_vi.h"
 #include "kfd_pm4_headers_aldebaran.h"
 #include "cwsr_trap_handler.h"
-#include "kfd_iommu.h"
 #include "amdgpu_amdkfd.h"
 #include "kfd_smi_events.h"
 #include "kfd_svm.h"
@@ -63,7 +62,6 @@ static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
 				unsigned int chunk_size);
 static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
 
-static int kfd_resume_iommu(struct kfd_dev *kfd);
 static int kfd_resume(struct kfd_node *kfd);
 
 static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
@@ -758,15 +756,6 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	kfd->noretry = kfd->adev->gmc.noretry;
 
-	/* If CRAT is broken, won't set iommu enabled */
-	kfd_double_confirm_iommu_support(kfd);
-
-	if (kfd_iommu_device_init(kfd)) {
-		kfd->use_iommu_v2 = false;
-		dev_err(kfd_device, "Error initializing iommuv2\n");
-		goto device_iommu_error;
-	}
-
 	kfd_cwsr_init(kfd);
 
 	dev_info(kfd_device, "Total number of KFD nodes to be created: %d\n",
@@ -841,9 +830,6 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	svm_range_set_max_pages(kfd->adev);
 
-	if (kfd_resume_iommu(kfd))
-		goto kfd_resume_iommu_error;
-
 	spin_lock_init(&kfd->watch_points_lock);
 
 	kfd->init_complete = true;
@@ -855,11 +841,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	goto out;
 
-kfd_resume_iommu_error:
 node_init_error:
 node_alloc_error:
 	kfd_cleanup_nodes(kfd, i);
-device_iommu_error:
 	kfd_doorbell_fini(kfd);
 kfd_doorbell_error:
 	kfd_gtt_sa_fini(kfd);
@@ -974,7 +958,6 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 		node = kfd->nodes[i];
 		node->dqm->ops.stop(node->dqm);
 	}
-	kfd_iommu_suspend(kfd);
 }
 
 int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
@@ -1004,26 +987,6 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 	return ret;
 }
 
-int kgd2kfd_resume_iommu(struct kfd_dev *kfd)
-{
-	if (!kfd->init_complete)
-		return 0;
-
-	return kfd_resume_iommu(kfd);
-}
-
-static int kfd_resume_iommu(struct kfd_dev *kfd)
-{
-	int err = 0;
-
-	err = kfd_iommu_resume(kfd);
-	if (err)
-		dev_err(kfd_device,
-			"Failed to resume IOMMU for device %x:%x\n",
-			kfd->adev->pdev->vendor, kfd->adev->pdev->device);
-	return err;
-}
-
 static int kfd_resume(struct kfd_node *node)
 {
 	int err = 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
index 8af6433887687..54eb1bff903c7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
@@ -60,7 +60,7 @@ static int update_qpd_v9(struct device_queue_manager *dqm,
 		qpd->sh_mem_config = SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
 					SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 
-		if (dqm->dev->kfd->noretry && !dqm->dev->kfd->use_iommu_v2)
+		if (dqm->dev->kfd->noretry)
 			qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
 
 		if (KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 4, 3))
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 8081a9408006e..0f58be65132fc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -31,7 +31,6 @@
 #include <linux/memory.h>
 #include "kfd_priv.h"
 #include "kfd_events.h"
-#include "kfd_iommu.h"
 #include <linux/device.h>
 
 /*
@@ -1146,87 +1145,6 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
 	rcu_read_unlock();
 }
 
-#ifdef KFD_SUPPORT_IOMMU_V2
-void kfd_signal_iommu_event(struct kfd_node *dev, u32 pasid,
-		unsigned long address, bool is_write_requested,
-		bool is_execute_requested)
-{
-	struct kfd_hsa_memory_exception_data memory_exception_data;
-	struct vm_area_struct *vma;
-	int user_gpu_id;
-
-	/*
-	 * Because we are called from arbitrary context (workqueue) as opposed
-	 * to process context, kfd_process could attempt to exit while we are
-	 * running so the lookup function increments the process ref count.
-	 */
-	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
-	struct mm_struct *mm;
-
-	if (!p)
-		return; /* Presumably process exited. */
-
-	/* Take a safe reference to the mm_struct, which may otherwise
-	 * disappear even while the kfd_process is still referenced.
-	 */
-	mm = get_task_mm(p->lead_thread);
-	if (!mm) {
-		kfd_unref_process(p);
-		return; /* Process is exiting */
-	}
-
-	user_gpu_id = kfd_process_get_user_gpu_id(p, dev->id);
-	if (unlikely(user_gpu_id == -EINVAL)) {
-		WARN_ONCE(1, "Could not get user_gpu_id from dev->id:%x\n", dev->id);
-		return;
-	}
-	memset(&memory_exception_data, 0, sizeof(memory_exception_data));
-
-	mmap_read_lock(mm);
-	vma = find_vma(mm, address);
-
-	memory_exception_data.gpu_id = user_gpu_id;
-	memory_exception_data.va = address;
-	/* Set failure reason */
-	memory_exception_data.failure.NotPresent = 1;
-	memory_exception_data.failure.NoExecute = 0;
-	memory_exception_data.failure.ReadOnly = 0;
-	if (vma && address >= vma->vm_start) {
-		memory_exception_data.failure.NotPresent = 0;
-
-		if (is_write_requested && !(vma->vm_flags & VM_WRITE))
-			memory_exception_data.failure.ReadOnly = 1;
-		else
-			memory_exception_data.failure.ReadOnly = 0;
-
-		if (is_execute_requested && !(vma->vm_flags & VM_EXEC))
-			memory_exception_data.failure.NoExecute = 1;
-		else
-			memory_exception_data.failure.NoExecute = 0;
-	}
-
-	mmap_read_unlock(mm);
-	mmput(mm);
-
-	pr_debug("notpresent %d, noexecute %d, readonly %d\n",
-			memory_exception_data.failure.NotPresent,
-			memory_exception_data.failure.NoExecute,
-			memory_exception_data.failure.ReadOnly);
-
-	/* Workaround on Raven to not kill the process when memory is freed
-	 * before IOMMU is able to finish processing all the excessive PPRs
-	 */
-
-	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 1, 0) &&
-	    KFD_GC_VERSION(dev) != IP_VERSION(9, 2, 2) &&
-	    KFD_GC_VERSION(dev) != IP_VERSION(9, 3, 0))
-		lookup_events_by_type_and_signal(p, KFD_EVENT_TYPE_MEMORY,
-				&memory_exception_data);
-
-	kfd_unref_process(p);
-}
-#endif /* KFD_SUPPORT_IOMMU_V2 */
-
 void kfd_signal_hw_exception_event(u32 pasid)
 {
 	/*
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index da2ca00d79e5e..efb05acea2f8b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -322,22 +322,13 @@ static void kfd_init_apertures_vi(struct kfd_process_device *pdd, uint8_t id)
 	pdd->lds_base = MAKE_LDS_APP_BASE_VI();
 	pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
 
-	if (!pdd->dev->kfd->use_iommu_v2) {
-		/* dGPUs: SVM aperture starting at 0
-		 * with small reserved space for kernel.
-		 * Set them to CANONICAL addresses.
-		 */
-		pdd->gpuvm_base = SVM_USER_BASE;
-		pdd->gpuvm_limit =
-			pdd->dev->kfd->shared_resources.gpuvm_size - 1;
-	} else {
-		/* set them to non CANONICAL addresses, and no SVM is
-		 * allocated.
-		 */
-		pdd->gpuvm_base = MAKE_GPUVM_APP_BASE_VI(id + 1);
-		pdd->gpuvm_limit = MAKE_GPUVM_APP_LIMIT(pdd->gpuvm_base,
-				pdd->dev->kfd->shared_resources.gpuvm_size);
-	}
+	/* dGPUs: SVM aperture starting at 0
+	 * with small reserved space for kernel.
+	 * Set them to CANONICAL addresses.
+	 */
+	pdd->gpuvm_base = SVM_USER_BASE;
+	pdd->gpuvm_limit =
+		pdd->dev->kfd->shared_resources.gpuvm_size - 1;
 
 	pdd->scratch_base = MAKE_SCRATCH_APP_BASE_VI();
 	pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
@@ -417,13 +408,11 @@ int kfd_init_apertures(struct kfd_process *process)
 				}
 			}
 
-			if (!dev->kfd->use_iommu_v2) {
-				/* dGPUs: the reserved space for kernel
-				 * before SVM
-				 */
-				pdd->qpd.cwsr_base = SVM_CWSR_BASE;
-				pdd->qpd.ib_base = SVM_IB_BASE;
-			}
+			/* dGPUs: the reserved space for kernel
+			 * before SVM
+			 */
+			pdd->qpd.cwsr_base = SVM_CWSR_BASE;
+			pdd->qpd.ib_base = SVM_IB_BASE;
 		}
 
 		dev_dbg(kfd_device, "node id %u\n", id);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
deleted file mode 100644
index 808ee010520a2..0000000000000
--- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
+++ /dev/null
@@ -1,356 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR MIT
-/*
- * Copyright 2018-2022 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- */
-
-#include <linux/kconfig.h>
-
-#if IS_REACHABLE(CONFIG_AMD_IOMMU_V2)
-
-#include <linux/printk.h>
-#include <linux/device.h>
-#include <linux/slab.h>
-#include <linux/pci.h>
-#include <linux/amd-iommu.h>
-#include "kfd_priv.h"
-#include "kfd_topology.h"
-#include "kfd_iommu.h"
-
-static const u32 required_iommu_flags = AMD_IOMMU_DEVICE_FLAG_ATS_SUP |
-					AMD_IOMMU_DEVICE_FLAG_PRI_SUP |
-					AMD_IOMMU_DEVICE_FLAG_PASID_SUP;
-
-/** kfd_iommu_check_device - Check whether IOMMU is available for device
- */
-int kfd_iommu_check_device(struct kfd_dev *kfd)
-{
-	struct amd_iommu_device_info iommu_info;
-	int err;
-
-	if (!kfd->use_iommu_v2)
-		return -ENODEV;
-
-	iommu_info.flags = 0;
-	err = amd_iommu_device_info(kfd->adev->pdev, &iommu_info);
-	if (err)
-		return err;
-
-	if ((iommu_info.flags & required_iommu_flags) != required_iommu_flags)
-		return -ENODEV;
-
-	return 0;
-}
-
-/** kfd_iommu_device_init - Initialize IOMMU for device
- */
-int kfd_iommu_device_init(struct kfd_dev *kfd)
-{
-	struct amd_iommu_device_info iommu_info;
-	unsigned int pasid_limit;
-	int err;
-
-	if (!kfd->use_iommu_v2)
-		return 0;
-
-	iommu_info.flags = 0;
-	err = amd_iommu_device_info(kfd->adev->pdev, &iommu_info);
-	if (err < 0) {
-		dev_err(kfd_device,
-			"error getting iommu info. is the iommu enabled?\n");
-		return -ENODEV;
-	}
-
-	if ((iommu_info.flags & required_iommu_flags) != required_iommu_flags) {
-		dev_err(kfd_device,
-			"error required iommu flags ats %i, pri %i, pasid %i\n",
-		       (iommu_info.flags & AMD_IOMMU_DEVICE_FLAG_ATS_SUP) != 0,
-		       (iommu_info.flags & AMD_IOMMU_DEVICE_FLAG_PRI_SUP) != 0,
-		       (iommu_info.flags & AMD_IOMMU_DEVICE_FLAG_PASID_SUP)
-									!= 0);
-		return -ENODEV;
-	}
-
-	pasid_limit = min_t(unsigned int,
-			(unsigned int)(1 << kfd->device_info.max_pasid_bits),
-			iommu_info.max_pasids);
-
-	if (!kfd_set_pasid_limit(pasid_limit)) {
-		dev_err(kfd_device, "error setting pasid limit\n");
-		return -EBUSY;
-	}
-
-	return 0;
-}
-
-/** kfd_iommu_bind_process_to_device - Have the IOMMU bind a process
- *
- * Binds the given process to the given device using its PASID. This
- * enables IOMMUv2 address translation for the process on the device.
- *
- * This function assumes that the process mutex is held.
- */
-int kfd_iommu_bind_process_to_device(struct kfd_process_device *pdd)
-{
-	struct kfd_node *dev = pdd->dev;
-	struct kfd_process *p = pdd->process;
-	int err;
-
-	if (!dev->kfd->use_iommu_v2 || pdd->bound == PDD_BOUND)
-		return 0;
-
-	if (unlikely(pdd->bound == PDD_BOUND_SUSPENDED)) {
-		pr_err("Binding PDD_BOUND_SUSPENDED pdd is unexpected!\n");
-		return -EINVAL;
-	}
-
-	if (!kfd_is_first_node(dev)) {
-		dev_warn_once(kfd_device,
-				"IOMMU supported only on first node\n");
-		return 0;
-	}
-
-	err = amd_iommu_bind_pasid(dev->adev->pdev, p->pasid, p->lead_thread);
-	if (!err)
-		pdd->bound = PDD_BOUND;
-
-	return err;
-}
-
-/** kfd_iommu_unbind_process - Unbind process from all devices
- *
- * This removes all IOMMU device bindings of the process. To be used
- * before process termination.
- */
-void kfd_iommu_unbind_process(struct kfd_process *p)
-{
-	int i;
-
-	for (i = 0; i < p->n_pdds; i++)
-		if ((p->pdds[i]->bound == PDD_BOUND) &&
-		    (kfd_is_first_node((p->pdds[i]->dev))))
-			amd_iommu_unbind_pasid(p->pdds[i]->dev->adev->pdev,
-					       p->pasid);
-}
-
-/* Callback for process shutdown invoked by the IOMMU driver */
-static void iommu_pasid_shutdown_callback(struct pci_dev *pdev, u32 pasid)
-{
-	struct kfd_node *dev = kfd_device_by_pci_dev(pdev);
-	struct kfd_process *p;
-	struct kfd_process_device *pdd;
-
-	if (!dev)
-		return;
-
-	/*
-	 * Look for the process that matches the pasid. If there is no such
-	 * process, we either released it in amdkfd's own notifier, or there
-	 * is a bug. Unfortunately, there is no way to tell...
-	 */
-	p = kfd_lookup_process_by_pasid(pasid);
-	if (!p)
-		return;
-
-	pr_debug("Unbinding process 0x%x from IOMMU\n", pasid);
-
-	mutex_lock(&p->mutex);
-
-	pdd = kfd_get_process_device_data(dev, p);
-	if (pdd)
-		/* For GPU relying on IOMMU, we need to dequeue here
-		 * when PASID is still bound.
-		 */
-		kfd_process_dequeue_from_device(pdd);
-
-	mutex_unlock(&p->mutex);
-
-	kfd_unref_process(p);
-}
-
-/* This function called by IOMMU driver on PPR failure */
-static int iommu_invalid_ppr_cb(struct pci_dev *pdev, u32 pasid,
-				unsigned long address, u16 flags)
-{
-	struct kfd_node *dev;
-
-	dev_warn_ratelimited(kfd_device,
-			"Invalid PPR device %x:%x.%x pasid 0x%x address 0x%lX flags 0x%X",
-			pdev->bus->number,
-			PCI_SLOT(pdev->devfn),
-			PCI_FUNC(pdev->devfn),
-			pasid,
-			address,
-			flags);
-
-	dev = kfd_device_by_pci_dev(pdev);
-	if (!WARN_ON(!dev))
-		kfd_signal_iommu_event(dev, pasid, address,
-			flags & PPR_FAULT_WRITE, flags & PPR_FAULT_EXEC);
-
-	return AMD_IOMMU_INV_PRI_RSP_INVALID;
-}
-
-/*
- * Bind processes do the device that have been temporarily unbound
- * (PDD_BOUND_SUSPENDED) in kfd_unbind_processes_from_device.
- */
-static int kfd_bind_processes_to_device(struct kfd_node *knode)
-{
-	struct kfd_process_device *pdd;
-	struct kfd_process *p;
-	unsigned int temp;
-	int err = 0;
-
-	int idx = srcu_read_lock(&kfd_processes_srcu);
-
-	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
-		mutex_lock(&p->mutex);
-		pdd = kfd_get_process_device_data(knode, p);
-
-		if (WARN_ON(!pdd) || pdd->bound != PDD_BOUND_SUSPENDED) {
-			mutex_unlock(&p->mutex);
-			continue;
-		}
-
-		err = amd_iommu_bind_pasid(knode->adev->pdev, p->pasid,
-				p->lead_thread);
-		if (err < 0) {
-			pr_err("Unexpected pasid 0x%x binding failure\n",
-					p->pasid);
-			mutex_unlock(&p->mutex);
-			break;
-		}
-
-		pdd->bound = PDD_BOUND;
-		mutex_unlock(&p->mutex);
-	}
-
-	srcu_read_unlock(&kfd_processes_srcu, idx);
-
-	return err;
-}
-
-/*
- * Mark currently bound processes as PDD_BOUND_SUSPENDED. These
- * processes will be restored to PDD_BOUND state in
- * kfd_bind_processes_to_device.
- */
-static void kfd_unbind_processes_from_device(struct kfd_node *knode)
-{
-	struct kfd_process_device *pdd;
-	struct kfd_process *p;
-	unsigned int temp;
-
-	int idx = srcu_read_lock(&kfd_processes_srcu);
-
-	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
-		mutex_lock(&p->mutex);
-		pdd = kfd_get_process_device_data(knode, p);
-
-		if (WARN_ON(!pdd)) {
-			mutex_unlock(&p->mutex);
-			continue;
-		}
-
-		if (pdd->bound == PDD_BOUND)
-			pdd->bound = PDD_BOUND_SUSPENDED;
-		mutex_unlock(&p->mutex);
-	}
-
-	srcu_read_unlock(&kfd_processes_srcu, idx);
-}
-
-/** kfd_iommu_suspend - Prepare IOMMU for suspend
- *
- * This unbinds processes from the device and disables the IOMMU for
- * the device.
- */
-void kfd_iommu_suspend(struct kfd_dev *kfd)
-{
-	if (!kfd->use_iommu_v2)
-		return;
-
-	kfd_unbind_processes_from_device(kfd->nodes[0]);
-
-	amd_iommu_set_invalidate_ctx_cb(kfd->adev->pdev, NULL);
-	amd_iommu_set_invalid_ppr_cb(kfd->adev->pdev, NULL);
-	amd_iommu_free_device(kfd->adev->pdev);
-}
-
-/** kfd_iommu_resume - Restore IOMMU after resume
- *
- * This reinitializes the IOMMU for the device and re-binds previously
- * suspended processes to the device.
- */
-int kfd_iommu_resume(struct kfd_dev *kfd)
-{
-	unsigned int pasid_limit;
-	int err;
-
-	if (!kfd->use_iommu_v2)
-		return 0;
-
-	pasid_limit = kfd_get_pasid_limit();
-
-	err = amd_iommu_init_device(kfd->adev->pdev, pasid_limit);
-	if (err)
-		return -ENXIO;
-
-	amd_iommu_set_invalidate_ctx_cb(kfd->adev->pdev,
-					iommu_pasid_shutdown_callback);
-	amd_iommu_set_invalid_ppr_cb(kfd->adev->pdev,
-				     iommu_invalid_ppr_cb);
-
-	err = kfd_bind_processes_to_device(kfd->nodes[0]);
-	if (err) {
-		amd_iommu_set_invalidate_ctx_cb(kfd->adev->pdev, NULL);
-		amd_iommu_set_invalid_ppr_cb(kfd->adev->pdev, NULL);
-		amd_iommu_free_device(kfd->adev->pdev);
-		return err;
-	}
-
-	return 0;
-}
-
-/** kfd_iommu_add_perf_counters - Add IOMMU performance counters to topology
- */
-int kfd_iommu_add_perf_counters(struct kfd_topology_device *kdev)
-{
-	struct kfd_perf_properties *props;
-
-	if (!(kdev->node_props.capability & HSA_CAP_ATS_PRESENT))
-		return 0;
-
-	if (!amd_iommu_pc_supported())
-		return 0;
-
-	props = kfd_alloc_struct(props);
-	if (!props)
-		return -ENOMEM;
-	strcpy(props->block_name, "iommu");
-	props->max_concurrent = amd_iommu_pc_get_max_banks(0) *
-		amd_iommu_pc_get_max_counters(0); /* assume one iommu */
-	list_add_tail(&props->list, &kdev->perf_props);
-
-	return 0;
-}
-
-#endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.h b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.h
deleted file mode 100644
index 8cf0fcbe87c2e..0000000000000
--- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.h
+++ /dev/null
@@ -1,84 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR MIT */
-/*
- * Copyright 2018-2022 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- */
-
-#ifndef __KFD_IOMMU_H__
-#define __KFD_IOMMU_H__
-
-#include <linux/kconfig.h>
-
-#if IS_REACHABLE(CONFIG_AMD_IOMMU_V2)
-
-#define KFD_SUPPORT_IOMMU_V2
-
-int kfd_iommu_check_device(struct kfd_dev *kfd);
-int kfd_iommu_device_init(struct kfd_dev *kfd);
-
-int kfd_iommu_bind_process_to_device(struct kfd_process_device *pdd);
-void kfd_iommu_unbind_process(struct kfd_process *p);
-
-void kfd_iommu_suspend(struct kfd_dev *kfd);
-int kfd_iommu_resume(struct kfd_dev *kfd);
-
-int kfd_iommu_add_perf_counters(struct kfd_topology_device *kdev);
-
-#else
-
-static inline int kfd_iommu_check_device(struct kfd_dev *kfd)
-{
-	return -ENODEV;
-}
-static inline int kfd_iommu_device_init(struct kfd_dev *kfd)
-{
-#if IS_MODULE(CONFIG_AMD_IOMMU_V2)
-	WARN_ONCE(1, "iommu_v2 module is not usable by built-in KFD");
-#endif
-	return 0;
-}
-
-static inline int kfd_iommu_bind_process_to_device(
-	struct kfd_process_device *pdd)
-{
-	return 0;
-}
-static inline void kfd_iommu_unbind_process(struct kfd_process *p)
-{
-	/* empty */
-}
-
-static inline void kfd_iommu_suspend(struct kfd_dev *kfd)
-{
-	/* empty */
-}
-static inline int kfd_iommu_resume(struct kfd_dev *kfd)
-{
-	return 0;
-}
-
-static inline int kfd_iommu_add_perf_counters(struct kfd_topology_device *kdev)
-{
-	return 0;
-}
-
-#endif /* IS_REACHABLE(CONFIG_AMD_IOMMU_V2) */
-
-#endif /* __KFD_IOMMU_H__ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d4c9ee3f99533..924a19f7db5fa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -175,12 +175,6 @@ extern int send_sigterm;
  */
 extern int debug_largebar;
 
-/*
- * Ignore CRAT table during KFD initialization, can be used to work around
- * broken CRAT tables on some AMD systems
- */
-extern int ignore_crat;
-
 /* Set sh_mem_config.retry_disable on GFX v9 */
 extern int amdgpu_noretry;
 
@@ -234,7 +228,6 @@ struct kfd_device_info {
 	uint8_t num_of_watch_points;
 	uint16_t mqd_size_aligned;
 	bool supports_cwsr;
-	bool needs_iommu_device;
 	bool needs_pci_atomics;
 	uint32_t no_atomic_fw_version;
 	unsigned int num_sdma_queues_per_engine;
@@ -368,9 +361,6 @@ struct kfd_dev {
 
 	bool pci_atomic_requested;
 
-	/* Use IOMMU v2 flag */
-	bool use_iommu_v2;
-
 	/* Compute Profile ref. count */
 	atomic_t compute_profile;
 
@@ -1152,7 +1142,6 @@ static inline struct kfd_node *kfd_node_by_irq_ids(struct amdgpu_device *adev,
 }
 int kfd_topology_enum_kfd_devices(uint8_t idx, struct kfd_node **kdev);
 int kfd_numa_node_to_apic_id(int numa_node_id);
-void kfd_double_confirm_iommu_support(struct kfd_dev *gpu);
 
 /* Interrupts */
 #define	KFD_IRQ_FENCE_CLIENTID	0xff
@@ -1459,9 +1448,6 @@ int kfd_wait_on_events(struct kfd_process *p,
 		       uint32_t *wait_result);
 void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
 				uint32_t valid_id_bits);
-void kfd_signal_iommu_event(struct kfd_node *dev,
-			    u32 pasid, unsigned long address,
-			    bool is_write_requested, bool is_execute_requested);
 void kfd_signal_hw_exception_event(u32 pasid);
 int kfd_set_event(struct kfd_process *p, uint32_t event_id);
 int kfd_reset_event(struct kfd_process *p, uint32_t event_id);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index a844e68211acc..b360538354aa2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -28,7 +28,6 @@
 #include <linux/sched/task.h>
 #include <linux/mmu_context.h>
 #include <linux/slab.h>
-#include <linux/amd-iommu.h>
 #include <linux/notifier.h>
 #include <linux/compat.h>
 #include <linux/mman.h>
@@ -41,7 +40,6 @@ struct mm_struct;
 
 #include "kfd_priv.h"
 #include "kfd_device_queue_manager.h"
-#include "kfd_iommu.h"
 #include "kfd_svm.h"
 #include "kfd_smi_events.h"
 #include "kfd_debug.h"
@@ -1123,7 +1121,6 @@ static void kfd_process_wq_release(struct work_struct *work)
 	dma_fence_signal(p->ef);
 
 	kfd_process_remove_sysfs(p);
-	kfd_iommu_unbind_process(p);
 
 	kfd_process_kunmap_signal_bo(p);
 	kfd_process_free_outstanding_kfd_bos(p);
@@ -1766,10 +1763,6 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_node *dev,
 		}
 	}
 
-	err = kfd_iommu_bind_process_to_device(pdd);
-	if (err)
-		goto out;
-
 	/*
 	 * make sure that runtime_usage counter is incremented just once
 	 * per pdd
@@ -1777,15 +1770,6 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_node *dev,
 	pdd->runtime_inuse = true;
 
 	return pdd;
-
-out:
-	/* balance runpm reference count and exit with error */
-	if (!pdd->runtime_inuse) {
-		pm_runtime_mark_last_busy(adev_to_drm(dev->adev)->dev);
-		pm_runtime_put_autosuspend(adev_to_drm(dev->adev)->dev);
-	}
-
-	return ERR_PTR(err);
 }
 
 /* Create specific handle mapped to mem from process local memory idr
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 3b07493903885..63f7a21223c13 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -36,7 +36,6 @@
 #include "kfd_crat.h"
 #include "kfd_topology.h"
 #include "kfd_device_queue_manager.h"
-#include "kfd_iommu.h"
 #include "kfd_svm.h"
 #include "kfd_debug.h"
 #include "amdgpu_amdkfd.h"
@@ -989,17 +988,6 @@ static void find_system_memory(const struct dmi_header *dm,
 	}
 }
 
-/*
- * Performance counters information is not part of CRAT but we would like to
- * put them in the sysfs under topology directory for Thunk to get the data.
- * This function is called before updating the sysfs.
- */
-static int kfd_add_perf_to_topology(struct kfd_topology_device *kdev)
-{
-	/* These are the only counters supported so far */
-	return kfd_iommu_add_perf_counters(kdev);
-}
-
 /* kfd_add_non_crat_information - Add information that is not currently
  *	defined in CRAT but is necessary for KFD topology
  * @dev - topology device to which addition info is added
@@ -1014,25 +1002,6 @@ static void kfd_add_non_crat_information(struct kfd_topology_device *kdev)
 	/* TODO: For GPU node, rearrange code from kfd_topology_add_device */
 }
 
-/* kfd_is_acpi_crat_invalid - CRAT from ACPI is valid only for AMD APU devices.
- *	Ignore CRAT for all other devices. AMD APU is identified if both CPU
- *	and GPU cores are present.
- * @device_list - topology device list created by parsing ACPI CRAT table.
- * @return - TRUE if invalid, FALSE is valid.
- */
-static bool kfd_is_acpi_crat_invalid(struct list_head *device_list)
-{
-	struct kfd_topology_device *dev;
-
-	list_for_each_entry(dev, device_list, list) {
-		if (dev->node_props.cpu_cores_count &&
-			dev->node_props.simd_count)
-			return false;
-	}
-	pr_info("Ignoring ACPI CRAT on non-APU system\n");
-	return true;
-}
-
 int kfd_topology_init(void)
 {
 	void *crat_image = NULL;
@@ -1063,48 +1032,25 @@ int kfd_topology_init(void)
 	 */
 	proximity_domain = 0;
 
-	/*
-	 * Get the CRAT image from the ACPI. If ACPI doesn't have one
-	 * or if ACPI CRAT is invalid create a virtual CRAT.
-	 * NOTE: The current implementation expects all AMD APUs to have
-	 *	CRAT. If no CRAT is available, it is assumed to be a CPU
-	 */
-	ret = kfd_create_crat_image_acpi(&crat_image, &image_size);
-	if (!ret) {
-		ret = kfd_parse_crat_table(crat_image,
-					   &temp_topology_device_list,
-					   proximity_domain);
-		if (ret ||
-		    kfd_is_acpi_crat_invalid(&temp_topology_device_list)) {
-			kfd_release_topology_device_list(
-				&temp_topology_device_list);
-			kfd_destroy_crat_image(crat_image);
-			crat_image = NULL;
-		}
+	ret = kfd_create_crat_image_virtual(&crat_image, &image_size,
+					    COMPUTE_UNIT_CPU, NULL,
+					    proximity_domain);
+	cpu_only_node = 1;
+	if (ret) {
+		pr_err("Error creating VCRAT table for CPU\n");
+		return ret;
 	}
 
-	if (!crat_image) {
-		ret = kfd_create_crat_image_virtual(&crat_image, &image_size,
-						    COMPUTE_UNIT_CPU, NULL,
-						    proximity_domain);
-		cpu_only_node = 1;
-		if (ret) {
-			pr_err("Error creating VCRAT table for CPU\n");
-			return ret;
-		}
-
-		ret = kfd_parse_crat_table(crat_image,
-					   &temp_topology_device_list,
-					   proximity_domain);
-		if (ret) {
-			pr_err("Error parsing VCRAT table for CPU\n");
-			goto err;
-		}
+	ret = kfd_parse_crat_table(crat_image,
+				   &temp_topology_device_list,
+				   proximity_domain);
+	if (ret) {
+		pr_err("Error parsing VCRAT table for CPU\n");
+		goto err;
 	}
 
 	kdev = list_first_entry(&temp_topology_device_list,
 				struct kfd_topology_device, list);
-	kfd_add_perf_to_topology(kdev);
 
 	down_write(&topology_lock);
 	kfd_topology_update_device_list(&temp_topology_device_list,
@@ -1190,8 +1136,7 @@ static struct kfd_topology_device *kfd_assign_gpu(struct kfd_node *gpu)
 		/* Discrete GPUs need their own topology device list
 		 * entries. Don't assign them to CPU/APU nodes.
 		 */
-		if (!gpu->kfd->use_iommu_v2 &&
-		    dev->node_props.cpu_cores_count)
+		if (dev->node_props.cpu_cores_count)
 			continue;
 
 		if (!dev->gpu && (dev->node_props.simd_count > 0)) {
@@ -2081,10 +2026,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	 * Overwrite ATS capability according to needs_iommu_device to fix
 	 * potential missing corresponding bit in CRAT of BIOS.
 	 */
-	if (dev->gpu->kfd->use_iommu_v2)
-		dev->node_props.capability |= HSA_CAP_ATS_PRESENT;
-	else
-		dev->node_props.capability &= ~HSA_CAP_ATS_PRESENT;
+	dev->node_props.capability &= ~HSA_CAP_ATS_PRESENT;
 
 	/* Fix errors in CZ CRAT.
 	 * simd_count: Carrizo CRAT reports wrong simd_count, probably
@@ -2279,29 +2221,6 @@ int kfd_numa_node_to_apic_id(int numa_node_id)
 	return kfd_cpumask_to_apic_id(cpumask_of_node(numa_node_id));
 }
 
-void kfd_double_confirm_iommu_support(struct kfd_dev *gpu)
-{
-	struct kfd_topology_device *dev;
-
-	gpu->use_iommu_v2 = false;
-
-	if (!gpu->device_info.needs_iommu_device)
-		return;
-
-	down_read(&topology_lock);
-
-	/* Only use IOMMUv2 if there is an APU topology node with no GPU
-	 * assigned yet. This GPU will be assigned to it.
-	 */
-	list_for_each_entry(dev, &topology_device_list, list)
-		if (dev->node_props.cpu_cores_count &&
-		    dev->node_props.simd_count &&
-		    !dev->gpu)
-			gpu->use_iommu_v2 = true;
-
-	up_read(&topology_lock);
-}
-
 #if defined(CONFIG_DEBUG_FS)
 
 int kfd_debugfs_hqds_by_device(struct seq_file *m, void *data)
-- 
2.41.0

