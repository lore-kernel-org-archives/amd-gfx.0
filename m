Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC20CDB466
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A35710E588;
	Mon, 22 Jun 2026 08:46:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gzO+irQP";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82EF610E57F
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:46:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoZ/z1vQNGpW35D8DdDt23ZIWxbjUEVW+OPwk0BfGM+6YVNUPsShxgFoS7IiTcNYP9rutDrjLlSOXgU0ymkovQpKJn9iQ7rn8GOOVaTK2U9eoD5xkoizXjJC550xr5IVbrh4ygwD2VHlmeNuKbOQmjtzUDLblaVShJOCuqCVpuVIvwYHIwD7qR/k+Tp7HRMYfnu9w+GRzc19vJyIemyZpKMRQ9s9PSLENTVEatcPnnZZlNJKAEkZJq1era+0sAEYFIfzBnWUesr8/UN4M0jbb1Dhmsor0/N/nXfpIq6RqtYW3vtQO4+E4vChc1l63fPPxWtstiIER2XR3qcSn5pd7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UiANWRrC/EceTDO5JeQ0423d7W0xcUBc8IHdqTic1s=;
 b=UFIISNMlaZbKwr4lHecNfsXDtgl6cPHk602nyQ0Ww9CSNBcpjkDLAbjB0chGd3viKRp54b1NZ6P13ibUBZgSCLxyR8n5YCN2pczyhHIr3WlyrQopsuAIS0KMx1wgis6JSVmeLq58oOx5HFbhZPwXBmaDqUx85biSmXD4/g53M0f7bE7SqSOo0Xz4A9eTjQWdax8IcEvPwahiPmqrvD9+1H3f7Fijh7XKqMQBKfKIMkCbf3aeGggLQeMkhAkDzXtY1ZkY/BeVbFN+8hS4Y37TuUO0lDHcZAcsIgSLxFORlGVmptM8V75C5tgIcCzG/8SLRb6EFHZQEfm+rUaF/TBohg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UiANWRrC/EceTDO5JeQ0423d7W0xcUBc8IHdqTic1s=;
 b=gzO+irQPTW75Ell7egJg0wV72HPkoPezWPVvPId2TXgK6daV7vFATgDap/CXJSshFQaA7KACCCFvKdZz7jY4IOjgi6UG85vynmGlv6/0leMytl4s0PTGO6sWXWJ29K6FjUspej5zZEbI4qSrhV2XwOtneBhdVvJeMswkCT3AwHQ=
Received: from DS1PR05CA0023.namprd05.prod.outlook.com (2603:10b6:8:23f::9) by
 MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 08:46:42 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:8:23f:cafe::29) by DS1PR05CA0023.outlook.office365.com
 (2603:10b6:8:23f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Mon,
 22 Jun 2026 08:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:46:41 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:46:39 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 47/48] drm/amdgpu: retire legacy umc v12_0 ras functions
Date: Mon, 22 Jun 2026 16:44:49 +0800
Message-ID: <ea319027c76364c2a73a663e059b3da6058b4442.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|MW6PR12MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eafa0e9-ca32-49b5-b00e-08ded03ac82e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|18002099003|22082099003|3023799007|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: aZJwOSsO2fNknHJcKV+9CU+PHFTKXTDZrnjzY+ZN0kX4XEzjBmyxPqx9NGYDz6bA3yVpj2O03GHTOo6r51JobjXgbX3y6W90Uzf6EE9N/0meAZJmdXFbdakNHnjSqOaUntxbThG0kH4/7wvSnJqcTG73I76CbCDa/XE1Hza6wJVeoGR3U4qHt/PgGMCCnovZZTALXmDEteke3ysCi7KmXpMUcy5q94twbKapQzhFafFDN22RbCJdRaSdCHPxzUNNqRl9Z10+n8l+AkQNaXFfHSnI4rQyK1jjLTeaydbMTRzGwMW0E3wUUMbMAUEthTxQ4ESXS1BtuV2ts4HEFA6ZtGfYW57WkC8pPaTfAIHE4vnX0vEoaZGHprhioLekEyDIkIkUOt4pB9fRVwwvhvJefO+58Rs489HzHH59FaAePsj68CcX4NRiiz26ks5DBxye0O/bWCzBz8Op27GLb9zCOz61YLj0O9eBsqsGSo5/Rx9KM0Iq1O/686Fk1oRoqUXFY7eDwsnOmwPdN0qRnLS6CkXUJCaxB/OibO7jNw29O39Dv9oi55NmTh20f292FiSHYx2j6cIP7PBS9B4DoCLcNcH4C6r0uE+x8oU+x5Mlx7b8N64uQeZSCh+nTXcXCpkXY4b7FxKBe6ZStunJG4562iniFe0/Xtafg78m+4QJIuFM+Upz7fe6O6WmSsRM/o30/cbxZ/pgBPXha6VC1UqIVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FEd+2eZO8R9ru3S1E0ACFv4lWqA+0oHg8QQok48xxwBFlQ0/DUrIy83c9w0pzfhH2GFBmwQSnUORvWzMLDWRocDRr5ItZmY+wFwYMYHa2pVgxfzmdcEG8mxIiPHLP8Qbv7Y+tEo1JdYMV1BxXKCHl5ZuYwHmpUicZc/FKDRzxDalPnPHwbhUKPYg12vlDDt2Xugwg6z4siHzpsR8UwvDiggbKWPYtBUuuxsbLVwDU0BTIFFqGWvKuzzSIcUaVrLN54BqT3CQZYRQ8HtO8J325TjH1jQcXgJ+bqNkyDQYWjo6sLf8jaOQEWJOpNJK8fIROHWu+HieDR82kV0lmbuveAe9esC7tEyUyGp1FwJ1y4hMnkUCz0O/bMpX+B+7BJ8hbIddQQtZ9UE2nsxXAPQQ+biJGEUYWW+90+7B13Jz5GtJSp6g4r2I4PrbJpAcdtch
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:46:41.7745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eafa0e9-ca32-49b5-b00e-08ded03ac82e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000
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

retire legacy umc v12_0 ras functions

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  8 +-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c        | 56 --------------
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h        | 74 -------------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  1 -
 5 files changed, 6 insertions(+), 135 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 5100e35027ec..3b9c3b7be482 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -113,7 +113,7 @@ amdgpu-y += \
 
 # add UMC block
 amdgpu-y += \
-	umc_v6_0.o umc_v6_1.o umc_v6_7.o umc_v8_7.o umc_v8_10.o umc_v12_0.o umc_v8_14.o
+	umc_v6_0.o umc_v6_1.o umc_v6_7.o umc_v8_7.o umc_v8_10.o umc_v8_14.o
 
 # add IH block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 1fcc0594fd0a..f6eed1470647 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -56,7 +56,6 @@
 #include "umc_v6_1.h"
 #include "umc_v6_0.h"
 #include "umc_v6_7.h"
-#include "umc_v12_0.h"
 #include "ras_umc_v12_0.h"
 #include "hdp_v4_0.h"
 #include "mca_v3_0.h"
@@ -79,6 +78,8 @@
 #define mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION_DCN2                                                          0x05ea
 #define mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION_DCN2_BASE_IDX                                                 2
 
+struct amdgpu_umc_ras umc_dummy_ras;
+
 static const char * const gfxhub_client_ids[] = {
 	"CB",
 	"DB",
@@ -1389,7 +1390,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.node_inst_num /= UMC_V12_0_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V12_0_PER_CHANNEL_OFFSET;
 		if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu)
-			adev->umc.ras = &umc_v12_0_ras;
+			adev->umc.ras = &umc_dummy_ras;
 		break;
 	default:
 		break;
@@ -2271,7 +2272,8 @@ static int gmc_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
 		amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 
 		if (adev->gmc.ecc_irq.funcs &&
-		    amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
+		    amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC) &&
+		    adev->umc.ras)
 			amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
deleted file mode 100644
index 99d19de42525..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- * Copyright 2023 Advanced Micro Devices, Inc.
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
- *
- */
-#include "umc_v12_0.h"
-#include "amdgpu_ras.h"
-#include "amdgpu_umc.h"
-#include "amdgpu.h"
-#include "umc/umc_12_0_0_offset.h"
-#include "umc/umc_12_0_0_sh_mask.h"
-#include "mp/mp_13_0_6_sh_mask.h"
-
-bool umc_v12_0_is_uncorrectable_error(struct amdgpu_device *adev, uint64_t mc_umc_status)
-{
-	return ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
-		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC) == 1 ||
-		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) == 1 ||
-		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) == 1));
-}
-
-bool umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t mc_umc_status)
-{
-	return (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
-		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1 ||
-		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 &&
-		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) == 0) ||
-		/* Identify data parity error in replay mode */
-		((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, ErrorCodeExt) == 0x5 ||
-		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, ErrorCodeExt) == 0xb) &&
-		!(umc_v12_0_is_uncorrectable_error(adev, mc_umc_status)))));
-}
-
-struct amdgpu_umc_ras umc_v12_0_ras = {
-	.ras_block = {
-		.hw_ops = NULL,
-	},
-};
-
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
deleted file mode 100644
index 906dc7fa1008..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- * Copyright 2023 Advanced Micro Devices, Inc.
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
- *
- */
-#ifndef __UMC_V12_0_H__
-#define __UMC_V12_0_H__
-
-#include "soc15_common.h"
-#include "amdgpu.h"
-
-/* one piece of normalized address is mapped to 8 pieces of physical address */
-#define UMC_V12_0_NA_MAP_PA_NUM        8
-/* R13 bit shift should be considered, double the number */
-#define UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL (UMC_V12_0_NA_MAP_PA_NUM * 2)
-
-/* column bits in SOC physical address */
-#define UMC_V12_0_PA_C2_BIT 15
-#define UMC_V12_0_PA_C3_BIT 16
-#define UMC_V12_0_PA_C4_BIT 21
-/* row bits in SOC physical address */
-#define UMC_V12_0_PA_R0_BIT 22
-#define UMC_V12_0_PA_R10_BIT 32
-#define UMC_V12_0_PA_R11_BIT 33
-#define UMC_V12_0_PA_R12_BIT 34
-#define UMC_V12_0_PA_R13_BIT 35
-/* channel bit in SOC physical address */
-#define UMC_V12_0_PA_CH4_BIT 12
-#define UMC_V12_0_PA_CH5_BIT 13
-/* bank bit in SOC physical address */
-#define UMC_V12_0_PA_B0_BIT 19
-#define UMC_V12_0_PA_B1_BIT 20
-/* row bits in MCA address */
-#define UMC_V12_0_MA_R0_BIT 10
-
-#define MCA_IPID_LO_2_UMC_CH(_ipid_lo) (((((_ipid_lo) >> 20) & 0x1) * 4) + \
-			(((_ipid_lo) >> 12) & 0xF))
-#define MCA_IPID_LO_2_UMC_INST(_ipid_lo) (((_ipid_lo) >> 21) & 0x7)
-
-#define MCA_IPID_2_DIE_ID(ipid)  ((REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi) >> 2) & 0x03)
-
-#define MCA_IPID_2_UMC_CH(ipid) \
-	(MCA_IPID_LO_2_UMC_CH(REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo)))
-
-#define MCA_IPID_2_UMC_INST(ipid) \
-	(MCA_IPID_LO_2_UMC_INST(REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo)))
-
-#define MCA_IPID_2_SOCKET_ID(ipid) \
-	(((REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo) & 0x1) << 2) | \
-	 (REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi) & 0x03))
-
-bool umc_v12_0_is_uncorrectable_error(struct amdgpu_device *adev, uint64_t mc_umc_status);
-bool umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t mc_umc_status);
-
-extern struct amdgpu_umc_ras umc_v12_0_ras;
-
-#endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 7c5e04a1cc94..8a1e28e45a2e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -47,7 +47,6 @@
 #include "smu_cmn.h"
 #include "mp/mp_13_0_6_offset.h"
 #include "mp/mp_13_0_6_sh_mask.h"
-#include "umc_v12_0.h"
 
 #undef MP1_Public
 #undef smnMP1_FIRMWARE_FLAGS
-- 
2.34.1

