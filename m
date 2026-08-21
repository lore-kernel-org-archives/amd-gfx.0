Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A35C5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC4F610F36C;
	Fri, 21 Aug 2026 16:10:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3ORzkClZ";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010021.outbound.protection.outlook.com
 [52.101.193.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64B8B10F36D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:10:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ja09FotvmZts9ru51lb8g6dEsl6xomiGgIlmNuj20ojwW89H2muWLK+hqh5zhxcjRYWlLdWBqcvv4YrPe0pB+GFipMmgiU+0gWJgiLUL6vYnQK+XYlGbpI6XFxc2JDWh6G5is4DpkEBYc7Nu3i+yf6tmkppZ+KgeL3RiZ/6hbTaBhFBZFTqkHo59ZAM7tqZkqqbajPCSxOI3vNlCx/1iKoj4Tv2zw1HFvzl5gwsCdQvdEkagJqNNjDGNm61CgJ7JQKcTJyRkFx12A4tNHNuJDvUX9SHBQFDkMncSIx1hM1ffMVY1jqUbTmzOqMxJSCDVsdarg2QBaV65occfkL/viA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhEGSYUzk4EVx5yhbvn45J4gGDdZ7HAqsZ4aU/rn0oI=;
 b=p6mvve7xHEHs7h9RNkdAkx8fftej/U5S3jgOl+Xh33sfVHSh2kwWeLmRSKu8oDqaEG/A/KSyb6K2vanl6tpwYzcRhaFsJLO70ZT/LBO5IU3HZh3+fH6sHEUZV3m9PvqEeeGxv6XMYvxVkACrTDZA8ryX4XpQROSKtsFnyaruslkB8+36d0OC+V2AjV/L73fes6QaCxu4s7wt9wTOjcapKLAUqRPecln/KJgswPOMaVsrLK3paW0PhlCXdadylZUovCX1cLPQvXicX+bQqT/fmloUKep6IC4IqqEfhehmtOWme0KkJuzBi0JcJDv/cPeWuUNWBH4DB9bAlpkgU3IAKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhEGSYUzk4EVx5yhbvn45J4gGDdZ7HAqsZ4aU/rn0oI=;
 b=3ORzkClZvkXPsRRsHCB7uZaygztbUs0y+HBo76BFpVBuzjKKYMZ4hfUlTZTeimRvhZzFgAbwOv2ChQjdxmW4U89kfSVldquSdz7Fyfizm9WtL6CCwpIT4oUA9L41/soisAFeLv8lfG41iRv/Ct2DZ6Nn7Uv83oR5RgihUYA+b7A=
Received: from SA0PR11CA0057.namprd11.prod.outlook.com (2603:10b6:806:d0::32)
 by SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Fri, 21 Aug
 2026 16:10:37 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:d0:cafe::20) by SA0PR11CA0057.outlook.office365.com
 (2603:10b6:806:d0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 16:10:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:10:37 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:10:15 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:10:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <Le.Ma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 10/13] drm/amdgpu: Use global addr for mmhub v4_2 reg access
Date: Fri, 21 Aug 2026 12:09:55 -0400
Message-ID: <20260821160958.753063-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160958.753063-1-alexander.deucher@amd.com>
References: <20260821160958.753063-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|SA1PR12MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: c9854f95-db35-440b-e36f-08deff9ebd41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: H+eNlTIhrowuxGBm394n2FsOhhokD+9qZLgd066FVOTJo3lB8wijXeUWpwbdBLGTOUJ1enwct7htP/QcWy4t6d7n3/8SfxC1KP1lPUAnuF+eTT4RtZtqTqd9mbtqbTxd7U6iMMO9cJlm78qkASTGdpYJR+cdwk/WrDlGPvLr31kwk0jTcWsMtU99uYmF6hKKbm5riTcdwTkE+cYVo+t/XItiptRKj4CESniqSgETVN/wh++Xe45L+AiVt48mhkJsnGblj++wZOnPc1pIT3b7TiJ/06XAqdP3jdtgvdQyjncPvzzvDBhisoB9CkBwbyV4KP63qoCt8OQqTMmrx1QxcBJPA2/uu/z5k4L+ZfXxqDucNihdtC4zv7zc2YP73DwDBI+d7jQnuEaoSKIm75SQU1iyLaU5/e5Two+Vz1z1OQKZjyW3QsysE2PqlTVmvG9qF7ESJieliTYWEqM0x2zG3HermujGOZOicDxGaWkHj+Nz780aQ6VuZ6XzGnnvwFP6Sz5j1H8CzwAgxkWDXLZBzPHwl1AIbEbwrjrmKLbkpGvEK5mB6La/9RB++GX/mZZoZHjXu3aXZTLuAsjdaj0Fs7QHwDVaOVLpCC/1KSxyBnZn+lP+q0KCFKqux1NUs1Xsc7AQtvlMHWg4T7QEYGpEI0BeJvGKdY8M/5QnMZkScL8IpXwbvAbPyOArCa/0ceb9zuf3HoPddt/OVfLq6gNUrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rc7H7ChhtTeaE5vzylnuDEmXwpriYesgwRgb+EpmKNKALX5LfHUHu2ciWxA6f+dNEqYf4YUG1tVzNX4h21qia6GAQUQLpif7QR7sGiZdhIvCgJxxFZYA1YwKbAhxYr0gROdkEp8ZFMI4TNtnTwl5hPJKUnTz8BrIj7YrTWRDi3k1E0XoTvKdP/1XJr4No502ATxIm0+Ad9tvRAh7ho1S0LxURpedA9VKafoSvEPsylrELH2RCQMo/FSDEJ1hCUlASmOBCsb/QnYHkJKEo/MpV8T394O+8joKwtn1WZRGoD/DrI43VjFpViiYRU4HzrSr9Dt+XqKboH7URcKuGlkwLGwiSm7uFYEGkC8qDw+qIQ+kXCyTr74GT37AN3AApafFbpc37UK+kswthN03ghggHcnY6sepiwSfFnd0KWN9+1R+iE/APVZFRoFQZwzE5PYb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:10:37.2887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9854f95-db35-440b-e36f-08deff9ebd41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Use global SMN addresses for MMHUB v4_2_0 register access
across all instances.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 238 +++++++++++++---------
 1 file changed, 140 insertions(+), 98 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
index 8e010296b3c29..8bed4addba426 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@ -29,10 +29,57 @@
 
 #include "soc15_common.h"
 #include "soc24_enum.h"
+#include "soc_v1_0.h"
 
 #define regMMVM_L2_CNTL3_DEFAULT				0x80100007
 #define regMMVM_L2_CNTL4_DEFAULT				0x000000c1
 #define regMMVM_L2_CNTL5_DEFAULT				0x00003fe0
+#define MMHUB_V4_2_0_MID1_EXT_ID				0x3
+
+static u64 mmhub_v4_2_0_get_reg_addr(int inst, u32 reg_offset)
+{
+	int ext_id = inst ? MMHUB_V4_2_0_MID1_EXT_ID : 0;
+
+	return (u64)reg_offset * 4 +
+	       soc_v1_0_encode_ext_smn_addressing(ext_id);
+}
+
+static u32 mmhub_v4_2_0_rreg(struct amdgpu_device *adev, int inst,
+			     u32 reg_offset)
+{
+	u64 reg_addr;
+
+	reg_addr = mmhub_v4_2_0_get_reg_addr(inst, reg_offset);
+
+	return RREG32_PCIE_EXT(reg_addr);
+}
+
+static void mmhub_v4_2_0_wreg(struct amdgpu_device *adev, int inst,
+			      u32 reg_offset, u32 value)
+{
+	u64 reg_addr;
+
+	reg_addr = mmhub_v4_2_0_get_reg_addr(inst, reg_offset);
+
+	WREG32_PCIE_EXT(reg_addr, value);
+}
+
+#define RREG32_MMHUB(inst, reg) \
+	mmhub_v4_2_0_rreg(adev, inst, \
+		(adev->reg_offset[MMHUB_HWIP][GET_INST(MMHUB, 0)] \
+				 [reg##_BASE_IDX] + (reg)))
+#define RREG32_MMHUB_OFFSET(inst, reg, offset) \
+	mmhub_v4_2_0_rreg(adev, inst, \
+		(adev->reg_offset[MMHUB_HWIP][GET_INST(MMHUB, 0)] \
+				 [reg##_BASE_IDX] + (reg) + (offset)))
+#define WREG32_MMHUB(inst, reg, value) \
+	mmhub_v4_2_0_wreg(adev, inst, \
+		(adev->reg_offset[MMHUB_HWIP][GET_INST(MMHUB, 0)] \
+				 [reg##_BASE_IDX] + (reg)), value)
+#define WREG32_MMHUB_OFFSET(inst, reg, offset, value) \
+	mmhub_v4_2_0_wreg(adev, inst, \
+		(adev->reg_offset[MMHUB_HWIP][GET_INST(MMHUB, 0)] \
+				 [reg##_BASE_IDX] + (reg) + (offset)), value)
 
 static const char *mmhub_client_ids_v4_2_0[][2] = {
 	[0][0] = "VMC",
@@ -144,15 +191,15 @@ static void mmhub_v4_2_0_mid_setup_vm_pt_regs(struct amdgpu_device *adev,
 
 	for_each_inst(i, inst_mask) {
 		hub = &adev->vmhub[AMDGPU_MMHUB0(i)];
-		WREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, i),
-				    regMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
-				    hub->ctx_addr_distance * vmid,
-				    lower_32_bits(page_table_base));
-
-		WREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, i),
-				    regMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
-				    hub->ctx_addr_distance * vmid,
-				    upper_32_bits(page_table_base));
+		WREG32_MMHUB_OFFSET(i,
+				   regMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
+				   hub->ctx_addr_distance * vmid,
+				   lower_32_bits(page_table_base));
+
+		WREG32_MMHUB_OFFSET(i,
+				   regMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
+				   hub->ctx_addr_distance * vmid,
+				   upper_32_bits(page_table_base));
 	}
 }
 
@@ -180,31 +227,31 @@ static void mmhub_v4_2_0_mid_init_gart_aperture_regs(struct amdgpu_device *adev,
 
 	for_each_inst(i, inst_mask) {
 		if (adev->gmc.pdb0_bo) {
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
 				     (u32)(adev->gmc.fb_start >> 12));
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
 				     (u32)(adev->gmc.fb_start >> 44));
 
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
 				     (u32)(adev->gmc.gart_end >> 12));
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
 				     (u32)(adev->gmc.gart_end >> 44));
 		} else {
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
 				     (u32)(adev->gmc.gart_start >> 12));
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
 				     (u32)(adev->gmc.gart_start >> 44));
 
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
 				     (u32)(adev->gmc.gart_end >> 12));
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
 				     (u32)(adev->gmc.gart_end >> 44));
 		}
@@ -230,67 +277,67 @@ static void mmhub_v4_2_0_mid_init_system_aperture_regs(struct amdgpu_device *ade
 		if (adev->gmc.pdb0_bo) {
 			/* Disable agp and system aperture
 			 * when vmid0 page table is enabled */
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMMC_VM_FB_LOCATION_TOP_LO32, 0);
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMMC_VM_FB_LOCATION_TOP_HI32, 0);
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMMC_VM_FB_LOCATION_BASE_LO32,
 				     0xFFFFFFFF);
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMMC_VM_FB_LOCATION_BASE_HI32, 1);
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMMC_VM_AGP_TOP_LO32, 0);
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMMC_VM_AGP_TOP_HI32, 0);
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMMC_VM_AGP_BOT_LO32,
 				     0xFFFFFFFF);
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMMC_VM_AGP_BOT_HI32, 1);
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR_LO32,
 				     0xFFFFFFFF);
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR_HI32,
 				     0x7F);
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR_LO32, 0);
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR_HI32, 0);
 		} else {
 			/* Program the AGP BAR */
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMMC_VM_AGP_BASE_LO32, 0);
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMMC_VM_AGP_BASE_HI32, 0);
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMMC_VM_AGP_BOT_LO32,
 				     lower_32_bits(adev->gmc.agp_start >> 24));
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMMC_VM_AGP_BOT_HI32,
 				     upper_32_bits(adev->gmc.agp_start >> 24));
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMMC_VM_AGP_TOP_LO32,
 				     lower_32_bits(adev->gmc.agp_end >> 24));
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMMC_VM_AGP_TOP_HI32,
 				     upper_32_bits(adev->gmc.agp_end >> 24));
 
 			/* Program the system aperture low logical page number. */
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR_LO32,
 				     lower_32_bits(min(adev->gmc.fb_start,
 						   adev->gmc.agp_start) >> 18));
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR_HI32,
 				     upper_32_bits(min(adev->gmc.fb_start,
 						   adev->gmc.agp_start) >> 18));
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR_LO32,
 				     lower_32_bits(max(adev->gmc.fb_end,
 						   adev->gmc.agp_end) >> 18));
-			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			WREG32_MMHUB(i,
 				     regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR_HI32,
 				     upper_32_bits(max(adev->gmc.fb_end,
 						   adev->gmc.agp_end) >> 18));
@@ -298,28 +345,27 @@ static void mmhub_v4_2_0_mid_init_system_aperture_regs(struct amdgpu_device *ade
 
 		/* Set default page address. */
 		value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+		WREG32_MMHUB(i,
 			     regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 			     (u32)(value >> 12));
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+		WREG32_MMHUB(i,
 			     regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
 			     (u32)(value >> 44));
 
 		/* Program "protection fault". */
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+		WREG32_MMHUB(i,
 			     regMMVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
 			     (u32)(adev->dummy_page_addr >> 12));
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+		WREG32_MMHUB(i,
 			     regMMVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
 			     (u32)((u64)adev->dummy_page_addr >> 44));
 
-		tmp = RREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-				   regMMVM_L2_PROTECTION_FAULT_CNTL2);
+		tmp = RREG32_MMHUB(i, regMMVM_L2_PROTECTION_FAULT_CNTL2);
 		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL2,
 				    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
 		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL2,
 				    ENABLE_RETRY_FAULT_INTERRUPT, 0x1);
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+		WREG32_MMHUB(i,
 			     regMMVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 	}
 }
@@ -332,8 +378,7 @@ static void mmhub_v4_2_0_mid_init_tlb_regs(struct amdgpu_device *adev,
 
 	for_each_inst(i, inst_mask) {
 		/* Setup TLB control */
-		tmp = RREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-				   regMMMC_VM_MX_L1_TLB_CNTL);
+		tmp = RREG32_MMHUB(i, regMMMC_VM_MX_L1_TLB_CNTL);
 
 		tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 1);
 		tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL, SYSTEM_ACCESS_MODE, 3);
@@ -344,7 +389,7 @@ static void mmhub_v4_2_0_mid_init_tlb_regs(struct amdgpu_device *adev,
 		tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL,
 				    MTYPE, MTYPE_UC); /* UC, uncached */
 
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+		WREG32_MMHUB(i,
 			     regMMMC_VM_MX_L1_TLB_CNTL, tmp);
 	}
 }
@@ -363,7 +408,7 @@ static void mmhub_v4_2_0_mid_init_cache_regs(struct amdgpu_device *adev,
 
 	for_each_inst(i, inst_mask) {
 		/* Setup L2 cache */
-		tmp = RREG32_SOC15(MMHUB, GET_INST(MMHUB, i), regMMVM_L2_CNTL);
+		tmp = RREG32_MMHUB(i, regMMVM_L2_CNTL);
 		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL, ENABLE_L2_CACHE, 1);
 		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL,
 				    ENABLE_DEFAULT_PAGE_OUT_TO_SYSTEM_MEMORY, 1);
@@ -376,7 +421,7 @@ static void mmhub_v4_2_0_mid_init_cache_regs(struct amdgpu_device *adev,
 				    CONTEXT1_IDENTITY_ACCESS_MODE, 1);
 		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL,
 				    IDENTITY_MODE_FRAGMENT_SIZE, 0);
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i), regMMVM_L2_CNTL, tmp);
+		WREG32_MMHUB(i, regMMVM_L2_CNTL, tmp);
 
 		tmp = regMMVM_L2_CNTL3_DEFAULT;
 		if (adev->gmc.translate_further) {
@@ -388,7 +433,7 @@ static void mmhub_v4_2_0_mid_init_cache_regs(struct amdgpu_device *adev,
 			tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL3,
 					    L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
 		}
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i), regMMVM_L2_CNTL3, tmp);
+		WREG32_MMHUB(i, regMMVM_L2_CNTL3, tmp);
 
 		tmp = regMMVM_L2_CNTL4_DEFAULT;
 		/* For AMD APP APUs setup WC memory */
@@ -403,12 +448,12 @@ static void mmhub_v4_2_0_mid_init_cache_regs(struct amdgpu_device *adev,
 			tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL4,
 					    VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
 		}
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i), regMMVM_L2_CNTL4, tmp);
+		WREG32_MMHUB(i, regMMVM_L2_CNTL4, tmp);
 
 		tmp = regMMVM_L2_CNTL5_DEFAULT;
 		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL5,
 				    L2_CACHE_SMALLK_FRAGMENT_SIZE, 0);
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i), regMMVM_L2_CNTL5, tmp);
+		WREG32_MMHUB(i, regMMVM_L2_CNTL5, tmp);
 	}
 }
 
@@ -419,8 +464,7 @@ static void mmhub_v4_2_0_mid_enable_system_domain(struct amdgpu_device *adev,
 	int i;
 
 	for_each_inst(i, inst_mask) {
-		tmp = RREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-				   regMMVM_CONTEXT0_CNTL);
+		tmp = RREG32_MMHUB(i, regMMVM_CONTEXT0_CNTL);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT0_CNTL,
 				    ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT0_CNTL,
@@ -430,7 +474,7 @@ static void mmhub_v4_2_0_mid_enable_system_domain(struct amdgpu_device *adev,
 				    adev->gmc.vmid0_page_table_block_size);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT0_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+		WREG32_MMHUB(i,
 			     regMMVM_CONTEXT0_CNTL, tmp);
 	}
 }
@@ -447,24 +491,24 @@ static void mmhub_v4_2_0_mid_disable_identity_aperture(struct amdgpu_device *ade
 		return;
 
 	for_each_inst(i, inst_mask) {
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+		WREG32_MMHUB(i,
 			     regMMVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32,
 			     0xFFFFFFFF);
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+		WREG32_MMHUB(i,
 			     regMMVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_HI32,
 			     0x00001FFF);
 
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+		WREG32_MMHUB(i,
 			     regMMVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_LO32,
 			     0);
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+		WREG32_MMHUB(i,
 			     regMMVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_HI32,
 			     0);
 
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+		WREG32_MMHUB(i,
 			     regMMVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_LO32,
 			     0);
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+		WREG32_MMHUB(i,
 			     regMMVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_HI32,
 			     0);
 	}
@@ -480,9 +524,8 @@ static void mmhub_v4_2_0_mid_setup_vmid_config(struct amdgpu_device *adev,
 	for_each_inst(j, inst_mask) {
 		hub = &adev->vmhub[AMDGPU_MMHUB0(j)];
 		for (i = 0; i <= 14; i++) {
-			tmp = RREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, j),
-					          regMMVM_CONTEXT1_CNTL,
-						  i * hub->ctx_distance);
+			tmp = RREG32_MMHUB_OFFSET(j, regMMVM_CONTEXT1_CNTL,
+						 i * hub->ctx_distance);
 			tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 			tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 					    adev->vm_manager.num_level);
@@ -508,18 +551,22 @@ static void mmhub_v4_2_0_mid_setup_vmid_config(struct amdgpu_device *adev,
 			tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
 					    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
 					    !adev->gmc.noretry);
-			WREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, j), regMMVM_CONTEXT1_CNTL,
-					    i * hub->ctx_distance, tmp);
-			WREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, j), regMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
-					    i * hub->ctx_addr_distance, 0);
-			WREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, j), regMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
-					    i * hub->ctx_addr_distance, 0);
-			WREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, j), regMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
-					    i * hub->ctx_addr_distance,
-					    lower_32_bits(adev->vm_manager.max_pfn - 1));
-			WREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, j), regMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
-					    i * hub->ctx_addr_distance,
-					    upper_32_bits(adev->vm_manager.max_pfn - 1));
+			WREG32_MMHUB_OFFSET(j, regMMVM_CONTEXT1_CNTL,
+					   i * hub->ctx_distance, tmp);
+			WREG32_MMHUB_OFFSET(j,
+					   regMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
+					   i * hub->ctx_addr_distance, 0);
+			WREG32_MMHUB_OFFSET(j,
+					   regMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
+					   i * hub->ctx_addr_distance, 0);
+			WREG32_MMHUB_OFFSET(j,
+					   regMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
+					   i * hub->ctx_addr_distance,
+					   lower_32_bits(adev->vm_manager.max_pfn - 1));
+			WREG32_MMHUB_OFFSET(j,
+					   regMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
+					   i * hub->ctx_addr_distance,
+					   upper_32_bits(adev->vm_manager.max_pfn - 1));
 		}
 	}
 
@@ -536,12 +583,12 @@ static void mmhub_v4_2_0_mid_program_invalidation(struct amdgpu_device *adev,
 		hub = &adev->vmhub[AMDGPU_MMHUB0(j)];
 
 		for (i = 0; i < 18; ++i) {
-			WREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, j),
-					    regMMVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
-					    i * hub->eng_addr_distance, 0xffffffff);
-			WREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, j),
-					    regMMVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
-					    i * hub->eng_addr_distance, 0x3fff);
+			WREG32_MMHUB_OFFSET(j,
+					   regMMVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
+					   i * hub->eng_addr_distance, 0xffffffff);
+			WREG32_MMHUB_OFFSET(j,
+					   regMMVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
+					   i * hub->eng_addr_distance, 0x3fff);
 		}
 	}
 }
@@ -578,25 +625,22 @@ static void mmhub_v4_2_0_mid_gart_disable(struct amdgpu_device *adev,
 		hub = &adev->vmhub[AMDGPU_MMHUB0(j)];
 		/* Disable all tables */
 		for (i = 0; i < 16; i++)
-			WREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, j),
-					    regMMVM_CONTEXT0_CNTL,
-					    i * hub->ctx_distance, 0);
+			WREG32_MMHUB_OFFSET(j, regMMVM_CONTEXT0_CNTL,
+					   i * hub->ctx_distance, 0);
 
 		/* Setup TLB control */
-		tmp = RREG32_SOC15(MMHUB, GET_INST(MMHUB, j),
-				   regMMMC_VM_MX_L1_TLB_CNTL);
+		tmp = RREG32_MMHUB(j, regMMMC_VM_MX_L1_TLB_CNTL);
 		tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL,
 				    ENABLE_L1_TLB, 0);
 		tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL,
 				    ENABLE_ADVANCED_DRIVER_MODEL, 0);
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, j),
-			     regMMMC_VM_MX_L1_TLB_CNTL, tmp);
+		WREG32_MMHUB(j, regMMMC_VM_MX_L1_TLB_CNTL, tmp);
 
 		/* Setup L2 cache */
-		tmp = RREG32_SOC15(MMHUB, GET_INST(MMHUB, j), regMMVM_L2_CNTL);
+		tmp = RREG32_MMHUB(j, regMMVM_L2_CNTL);
 		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL, ENABLE_L2_CACHE, 0);
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, j), regMMVM_L2_CNTL, tmp);
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, j), regMMVM_L2_CNTL3, 0);
+		WREG32_MMHUB(j, regMMVM_L2_CNTL, tmp);
+		WREG32_MMHUB(j, regMMVM_L2_CNTL3, 0);
 	}
 }
 
@@ -619,8 +663,7 @@ mmhub_v4_2_0_mid_set_fault_enable_default(struct amdgpu_device *adev,
 		return;
 
 	for_each_inst(i, inst_mask) {
-		tmp = RREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-				   regMMVM_L2_PROTECTION_FAULT_CNTL_LO32);
+		tmp = RREG32_MMHUB(i, regMMVM_L2_PROTECTION_FAULT_CNTL_LO32);
 		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
 				    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
 		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
@@ -648,8 +691,7 @@ mmhub_v4_2_0_mid_set_fault_enable_default(struct amdgpu_device *adev,
 			tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
 					    CRASH_ON_NO_RETRY_FAULT, 1);
 		}
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-			     regMMVM_L2_PROTECTION_FAULT_CNTL_LO32, tmp);
+		WREG32_MMHUB(i, regMMVM_L2_PROTECTION_FAULT_CNTL_LO32, tmp);
 	}
 }
 
-- 
2.55.0

