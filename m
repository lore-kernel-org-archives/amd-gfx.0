Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87E2F417F3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 14:57:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 717B310E519;
	Mon,  9 Mar 2026 14:57:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GxxLqofC";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1678710E519
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 14:57:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meseDbGmvQfGdFn9ZY1dIH07ReLmuqS0yHfCnnxpqQFnuMLhvuSG7tnRSwpMFYLnzGMiEyZwvWwRiUZ8RZWl6ynaVs2KRBTUoD71QNC2oSrEf25YOn8Xx1WPx/NOXFvonZnhCTS03/WWBqrKjiD6bC+FB9hxJHvastZ/xvsgzBlsrF1zV+Fo29X1q/3O4L1JOT1ryAog7tPMNRY0Oj9MMdiDhBh8UDCEOsoarfRoMnq5VpIitbqK+6Wy9JwI6wy59EgEbAcj+P0Rz1Wcu4MRqXcyD2vKB1TfoZB3zXWZFQxdZmf/K/GvavCmBN+VEHZeniLmWLwW0EbkRRX2Jz+zbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uT2nxw8a3aPEQm2w0HAPc6NkA1fc9xBqV2Ewe+32PwE=;
 b=eBo+x5Y8FftaHbqztCKlPvwiywwRaSvA2/5cp9Snb1i6/Udlm0CGdT4bWKhOGlRV9ukd8jug6OwuKCGkCjDS3WXNBTOjJkuHN/r9beRncnKNVBOebuH6y9mSVvB8oxcXfhsJBk8N6xLKY+X1dWacTknmoc2BMlH10uKhV3gXigRw6k1IKrN7FU2YG+vjFdPD722BQCe1Mi0dZJw95LPGyb0HzGEEYsIGSstIU9vw4W5HYYRQCfX/pkSUSIGDZy9biJC8p0ZdMby14gAWaYx0SPd2arY1gKMAZoLqLLACTIwVa7p1z6oT9pC7tolBecEElpX24Pkp6GcMO7xypbz4lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uT2nxw8a3aPEQm2w0HAPc6NkA1fc9xBqV2Ewe+32PwE=;
 b=GxxLqofC/6VlNBcBVx3IISZf1RAiRbgSHLG1a3FtdIJPL3xutKmDgLKXLm1JdogmgYBIKFKl9BWpdpmkp/TKV9f5EKlVdQLd+3Wv2xlJG7nJJfCmBEZPSeOPRl1nkOs0CrX1DM5Q9BOZ9GwMPWlj++ChCAgHmH7Voh5db9BtV9k=
Received: from SJ0PR03CA0387.namprd03.prod.outlook.com (2603:10b6:a03:3a1::32)
 by CY3PR12MB9680.namprd12.prod.outlook.com (2603:10b6:930:100::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 14:56:54 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::ba) by SJ0PR03CA0387.outlook.office365.com
 (2603:10b6:a03:3a1::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 14:56:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:56:53 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 09:56:44 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 09:56:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Correct mmhub system aperture settings for A + A
Date: Mon, 9 Mar 2026 10:56:17 -0400
Message-ID: <20260309145629.2844495-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309145629.2844495-1-alexander.deucher@amd.com>
References: <20260309145629.2844495-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|CY3PR12MB9680:EE_
X-MS-Office365-Filtering-Correlation-Id: 764136c7-54f4-410a-36dc-08de7dec1a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: 9swynvoceWSN+RQrALhFlkcEHkHmJ3OKD/Wmyg565rfrYIG9YhyJiLzOVe6VnCL5X3W6vYw54vQfIZBomfoRiX5nB0PXA4L6CHnuCcoCq6U28pLZSLk//O1Le+QlOedHAFzY5U9mYSEcvdl/A27RLqrTqcE+bfzpVxydJWr712ynkXC/jl2cqi4C577uBT2U7Nscpg5EepuqOX6xYeD4ncAYqOhoLQFN5l8buQksImLjqdcHDBhg3l0FVnaTX4r6m3iohFQjE6b9xqv3J2Xs7uZM/LsBjgarEDufqaGmB8xuj7oZcrbjpgCyqBKQBHikhm7AQw/UjtFlkLDeYXd+MfoDCWMkC/T/xl8rKIPlOk2IpuKMWaD+DG0VgmDHiw2PcrRO90o27vKAJTvxKKhLbuyhpb/QtX/OlkctEzmwq7L0fe00AYLQ2kMPLlLFe5ty3bql7JS+7XpKlNECndoGEyfVC1rrXEKSBT2A2NBVpNX58NDlSD19ACOxSJD0e47ij8gVll1qS1x9W3rCmIFU8pgebTTQ8psqIA9LqOGg8iOywNPwHfVjmgdXc9xPv3m5KBgqsg8HdTfqps8reKCXzEdiX64RXo0KMLPJUMe4B0aZh2JVesFpg3KWnvFoqrmxakXhlrlr7PA1w7LwJ5EfKXiQ1SLqYYERFgnzRzwsk3Ts//J9YcrxD+rUrWpExM+DOzSV4HZi+pgIXSfHfiU5biJBR4ENdhLIZ9TbrC6PY0khtRkGNQSgzjo4vV2h5jmwFBH4MYyE+Q2d071WNxi7eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JkCyXCNX24xMc7AFcATrMa6Q/FggQUwBySJRUG6ovGv0QnNiUk/Cwwcoz/NrRPRYtMGQGbfIjHMn2Qj28wse8UUY+R2UWBm69IDIfqKCM84/qII9DMfBdpcitqbqzHDZy461NLZr4bJ4Bx3+Bf/8bDPKaRxvidjcwMvy0o5Nm4uOh6swOdpYQK5ILBi5IVzPTuM2Xp2HTumRqZMi2c/TKnoQb0cVAnqVQiWw+Rtf6XzLGA1NOtAjxZmr+Z1Qi5roZCt7e4fImcakW5KkvmRk8x/UgCDlxUImUX1/2sR8uFAeLWfBPWtPJwxc7VXax88hQ3vGOLCqj+jGycaZPkGHB2LoKQBQdlz7otkP56+scagLT7K7onNk73+sHUPuAaMglWmv0VJ4iWra/kwENj7yrK/WfGX5hmVnNzl1j6qpK0YLG4nBiN7o5of9eiNQCIW1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:56:53.5489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 764136c7-54f4-410a-36dc-08de7dec1a11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9680
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

Disable AGP and FB apeture on all available MMHUB
instances when vmid0 page table is enabled

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 135 +++++++++++-----------
 1 file changed, 68 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
index a72770e3d0e99..60bba87e42a01 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@ -131,7 +131,7 @@ static void mmhub_v4_2_0_setup_vm_pt_regs(struct amdgpu_device *adev,
 static void mmhub_v4_2_0_mid_init_gart_aperture_regs(struct amdgpu_device *adev,
 						     uint32_t mid_mask)
 {
-	uint64_t pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
+	uint64_t pt_base;
 	int i;
 
 	if (adev->gmc.pdb0_bo)
@@ -190,41 +190,74 @@ static void mmhub_v4_2_0_mid_init_system_aperture_regs(struct amdgpu_device *ade
 		return;
 
 	for_each_inst(i, mid_mask) {
-		/* Program the AGP BAR */
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-			     regMMMC_VM_AGP_BASE_LO32, 0);
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-			     regMMMC_VM_AGP_BASE_HI32, 0);
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-			     regMMMC_VM_AGP_BOT_LO32,
-			     lower_32_bits(adev->gmc.agp_start >> 24));
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-			     regMMMC_VM_AGP_BOT_HI32,
-			     upper_32_bits(adev->gmc.agp_start >> 24));
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-			     regMMMC_VM_AGP_TOP_LO32,
-			     lower_32_bits(adev->gmc.agp_end >> 24));
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-			     regMMMC_VM_AGP_TOP_HI32,
-			     upper_32_bits(adev->gmc.agp_end >> 24));
+		if (adev->gmc.pdb0_bo) {
+			/* Disable agp and system aperture
+			 * when vmid0 page table is enabled */
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMMC_VM_FB_LOCATION_TOP_LO32, 0);
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMMC_VM_FB_LOCATION_TOP_HI32, 0);
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMMC_VM_FB_LOCATION_BASE_LO32,
+				     0xFFFFFFFF);
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMMC_VM_FB_LOCATION_BASE_HI32, 1);
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMMC_VM_AGP_TOP_LO32, 0);
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMMC_VM_AGP_TOP_HI32, 0);
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMMC_VM_AGP_BOT_LO32,
+				     0xFFFFFFFF);
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMMC_VM_AGP_BOT_HI32, 1);
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR_LO32,
+				     0xFFFFFFFF);
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR_HI32,
+				     0x7F);
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR_LO32, 0);
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR_HI32, 0);
+		} else {
+			/* Program the AGP BAR */
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMMC_VM_AGP_BASE_LO32, 0);
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMMC_VM_AGP_BASE_HI32, 0);
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMMC_VM_AGP_BOT_LO32,
+				     lower_32_bits(adev->gmc.agp_start >> 24));
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMMC_VM_AGP_BOT_HI32,
+				     upper_32_bits(adev->gmc.agp_start >> 24));
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMMC_VM_AGP_TOP_LO32,
+				     lower_32_bits(adev->gmc.agp_end >> 24));
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMMC_VM_AGP_TOP_HI32,
+				     upper_32_bits(adev->gmc.agp_end >> 24));
 
-		/* Program the system aperture low logical page number. */
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-			     regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR_LO32,
-			     lower_32_bits(min(adev->gmc.fb_start,
-					       adev->gmc.agp_start) >> 18));
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-			     regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR_HI32,
-			     upper_32_bits(min(adev->gmc.fb_start,
-					       adev->gmc.agp_start) >> 18));
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-			     regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR_LO32,
-			     lower_32_bits(max(adev->gmc.fb_end,
-					       adev->gmc.agp_end) >> 18));
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-			     regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR_HI32,
-			     upper_32_bits(max(adev->gmc.fb_end,
-					       adev->gmc.agp_end) >> 18));
+			/* Program the system aperture low logical page number. */
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR_LO32,
+				     lower_32_bits(min(adev->gmc.fb_start,
+						   adev->gmc.agp_start) >> 18));
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR_HI32,
+				     upper_32_bits(min(adev->gmc.fb_start,
+						   adev->gmc.agp_start) >> 18));
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR_LO32,
+				     lower_32_bits(max(adev->gmc.fb_end,
+						   adev->gmc.agp_end) >> 18));
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR_HI32,
+				     upper_32_bits(max(adev->gmc.fb_end,
+						   adev->gmc.agp_end) >> 18));
+		}
 
 		/* Set default page address. */
 		value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
@@ -252,38 +285,6 @@ static void mmhub_v4_2_0_mid_init_system_aperture_regs(struct amdgpu_device *ade
 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
 			     regMMVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 	}
-
-	/* In the case squeezing vram into GART aperture, we don't use
-	 * FB aperture and AGP aperture. Disable them.
-	 */
-	if (adev->gmc.pdb0_bo) {
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-			     regMMMC_VM_FB_LOCATION_TOP_LO32, 0);
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-			     regMMMC_VM_FB_LOCATION_TOP_HI32, 0);
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-			     regMMMC_VM_FB_LOCATION_BASE_LO32, 0xFFFFFFFF);
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-			     regMMMC_VM_FB_LOCATION_BASE_HI32, 1);
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-			     regMMMC_VM_AGP_TOP_LO32, 0);
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-			     regMMMC_VM_AGP_TOP_HI32, 0);
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-			     regMMMC_VM_AGP_BOT_LO32, 0xFFFFFFFF);
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-			     regMMMC_VM_AGP_BOT_HI32, 1);
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-			     regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR_LO32,
-			     0xFFFFFFFF);
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-			     regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR_HI32,
-			     0x7F);
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-			     regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR_LO32, 0);
-		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-			     regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR_HI32, 0);
-	}
 }
 
 static void mmhub_v4_2_0_mid_init_tlb_regs(struct amdgpu_device *adev,
-- 
2.53.0

