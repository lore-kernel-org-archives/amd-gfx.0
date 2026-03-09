Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38865F417EE
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 14:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C934210E51E;
	Mon,  9 Mar 2026 14:57:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eYEv/t3/";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010021.outbound.protection.outlook.com
 [52.101.193.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D019310E51F
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 14:57:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDTQwvUcmNJQISCpSnYxbf7HJHDx2vhNv6g+fEsgsrpk5xRyr6ERwb2RNG3ZzsCNVol2uvuvfbVc26KJq24IWgLCasHR/N+Y9ZvUma3NNE4AyAQrmkZ96IE++wgKKgweb+Il/AiIDASCS6htNSTOg2ZnvVEUeJT5z3h49mJsdwvLjNCB662Q8Hj7XQVBTcvhHk84tT3AhkufKOjyvh9zkTKj4vwKxWd1nRZUfi0zKfvQ8La4YpcPbk8mfYWOWFMcWGkVBtZP9FR+JJO/3TBtiQs7wZtXdmXJ3AC6Leg/YrD9ckYaDzCRqaWJF33CFsaaO/5Zi//M6v+xPwI963qozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxkqV1dzUBM+p9q9b81i8iVyNiJIv8mingJf31krlt4=;
 b=Lr3B1qdTUUEbgZG8mQifUZKJo6O5RWBb5EBY80EKhYc1uEwsZRbASy8doxpQ75BLtCEFPqrpVMzRSE+553H745poNgfQYvXl+vB0ZIp06UG7nG4z2KZa4S7rhdmFDcvTIiLzUPQ80WhX5m/p7rfHMkQDrMsczIJ/4+ZEY4WrR8LD2WveHX+lwnnsW+zaXvS/e/8faP4qjBvahYktAIDcG8CHwc2n/7rx3NKU9y9WAHRjLiH1YyCMe91m2+oYtyWPYrReGHgFmUmjr6PPcNIzLJHus6WEssHpHmhI/5dphQ1AUSVvA2rLHRnOybQPK3MQo2aYuXLVcWipnNFuAxDzFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxkqV1dzUBM+p9q9b81i8iVyNiJIv8mingJf31krlt4=;
 b=eYEv/t3/wWPsOkgygftpJij2GnHgUGDn35S2nembR26upixjSJ6XKvGaNOGycfjxoNoUSVdCW3CkQSqT63tEbtZmQbvvaO+aKlWzlKAImNkorvRjgMbNFbGmXpTXjXSf13bukj4LmyRKWqc/n/7xa6t1MgtSbZulYJue4Fouh3o=
Received: from SJ0PR03CA0384.namprd03.prod.outlook.com (2603:10b6:a03:3a1::29)
 by DS7PR12MB6167.namprd12.prod.outlook.com (2603:10b6:8:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 14:56:56 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::ec) by SJ0PR03CA0384.outlook.office365.com
 (2603:10b6:a03:3a1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 14:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:56:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 09:56:44 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 09:56:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Update gfxhub system aperture settings for A + A
Date: Mon, 9 Mar 2026 10:56:18 -0400
Message-ID: <20260309145629.2844495-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309145629.2844495-1-alexander.deucher@amd.com>
References: <20260309145629.2844495-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|DS7PR12MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a33cfa4-b7ba-443e-d6ed-08de7dec1b85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016; 
X-Microsoft-Antispam-Message-Info: kmuP5tej3q7rLW/gFptt0O/tR64C6BWF/8Gy9OfxXrQHa5MLcwAq9lxDP5W+VbKF1P+06CdVdnJJvaMDv0esQWRpn8moXMvl5FDbnbBaVQ6T5Y8Iuf08IiEpDWvB8qzR0ABWtBXkEyZaHqBawVwovSFSma5bVzmhfXZYzfdqqmq9D7aTdVIHVSTtwAs/ifDPpuGDUJh2T0SSkhhV3K+HKAUvOn8sDuoMBFM/oXEGhCGtIrGMMbhIkF3v4AgJX3Aoml1TEV7wklwFc7HTZ/c3Dko7BmbLrBdPlWEP438pY23lYnzubOmtzNMiZCcx/uXSqHbl4kr7tZ8e9msBXj7ZoAK6T/NgKi6mM1pa+fNYsuEHyCJJxVxeyA5XWTd7M3GmW6WWDYf6/NV4Fwzn5xxNYqQ/F6OrYKz5BfI9S0zTmRU+LmZeXsQnBDRBxd0y712M356TfJSd1JyctzeZx6AZObTe2UaI4teRDMiN+7xeix12sXXjp8bVlPMaW50WKBar4fCDvlEft/sTawcXub7RGWJTlrThOLaL3ReKw5mZ3h/moOqRNO/TaMw8hh8tGZPRLJnfJ46X6d2VcoWhwmtyq2C6ImM9R3GGoJgG3TEKz0YpyhzIYNRDV5lax7W5qmX3Q12DTghkmowUOovsuRbiYVpLssWUdr6Qs2M8/54YJxMrSY7Wfty/3AkU9SyJ4XNdYDCEYFxVl/RVpsdeuxZbNgtBVZufPweNJyjm+ZuKh0h0oe73iHEAffQuISoTSt0bOSqpm9KIrTwCwRzJuL2v4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: syoXVXeYP/udbL0fzLUHGT4dbcmVmBXrPf62aJ1b+bmg0fCOELZe7/VP+X29DOD8wiDEEgq+LmM0jLKEtp6ZyvrwV9/E2Mpz8Fc5GUgs6f0nfiqlksHGiwkXcZBj7i88MGVsOZ6A5HdIUs3RcSaESu2iT5qrDqIvhLc3Sh4nHGq7HZ0kZSL16TWjYz4xzargQP9w4cb2zPjjtOCYfuUdNHfkhdKPQYF8HhKnA3lggmuvGlRJKWDyRx5x3yhovTPD3cta6vf1QDVMxNE4rs3fFdfkzHWHONFXATTn6fGUv/5D+KtmaA5hJCsYDRR+Q8bytVyNMYHJODxr5sd6qw1G72sQiPoH3MRzJOqSGfoazzO7DYCKwfn6ygqujkdcdvbPSWrLf9baGixDnXeCThkC4UC9ErENkbCWM56/VJZ3Pr2Nstaw6ObD+F9TLlVj8EvD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:56:55.9361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a33cfa4-b7ba-443e-d6ed-08de7dec1b85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6167
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

Bypass the programming from SRIOV guest

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 135 ++++++++++++----------
 1 file changed, 71 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index 6a6f1707cb53e..d086c23e4c2da 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -146,71 +146,15 @@ static void gfxhub_v12_1_xcc_init_system_aperture_regs(struct amdgpu_device *ade
 	uint32_t tmp;
 	int i;
 
-	for_each_inst(i, xcc_mask) {
-		/* Program the AGP BAR */
-		WREG32_SOC15_RLC(GC, GET_INST(GC, i),
-				 regGCMC_VM_AGP_BASE_LO32, 0);
-		WREG32_SOC15_RLC(GC, GET_INST(GC, i),
-				 regGCMC_VM_AGP_BASE_HI32, 0);
-		WREG32_SOC15_RLC(GC, GET_INST(GC, i),
-				 regGCMC_VM_AGP_BOT_LO32,
-				 lower_32_bits(adev->gmc.agp_start >> 24));
-		WREG32_SOC15_RLC(GC, GET_INST(GC, i),
-				 regGCMC_VM_AGP_BOT_HI32,
-				 upper_32_bits(adev->gmc.agp_start >> 24));
-		WREG32_SOC15_RLC(GC, GET_INST(GC, i),
-				 regGCMC_VM_AGP_TOP_LO32,
-				 lower_32_bits(adev->gmc.agp_end >> 24));
-		WREG32_SOC15_RLC(GC, GET_INST(GC, i),
-				 regGCMC_VM_AGP_TOP_HI32,
-				 upper_32_bits(adev->gmc.agp_end >> 24));
-
-		if (!amdgpu_sriov_vf(adev)) {
-			/* Program the system aperture low logical page number. */
-			WREG32_SOC15(GC, GET_INST(GC, i),
-				     regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR_LO32,
-				     lower_32_bits(min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18));
-			WREG32_SOC15(GC, GET_INST(GC, i),
-				     regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR_HI32,
-				     upper_32_bits(min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18));
-			WREG32_SOC15(GC, GET_INST(GC, i),
-				     regGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR_LO32,
-				     lower_32_bits(max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18));
-			WREG32_SOC15(GC, GET_INST(GC, i),
-				     regGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR_HI32,
-				     upper_32_bits(max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18));
-
-			/* Set default page address. */
-			value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
-			WREG32_SOC15(GC, GET_INST(GC, i),
-				     regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
-				     (u32)(value >> 12));
-			WREG32_SOC15(GC, GET_INST(GC, i),
-				     regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
-				     (u32)(value >> 44));
-
-			/* Program "protection fault". */
-			WREG32_SOC15(GC, GET_INST(GC, i),
-				     regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
-				     (u32)(adev->dummy_page_addr >> 12));
-			WREG32_SOC15(GC, GET_INST(GC, i),
-				     regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
-				     (u32)((u64)adev->dummy_page_addr >> 44));
-
-			tmp = RREG32_SOC15(GC, GET_INST(GC, i),
-					   regGCVM_L2_PROTECTION_FAULT_CNTL2);
-			tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
-					    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
-			tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
-					    ENABLE_RETRY_FAULT_INTERRUPT, 0x1);
-			WREG32_SOC15(GC, GET_INST(GC, i),
-				     regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
-		}
+	/*TODO: revisit whether the SRIOV guest access to theseregisters
+	 * is blocked by security policy or not */
+	if (amdgpu_sriov_vf(adev))
+		return;
 
-		/* In the case squeezing vram into GART aperture, we don't use
-		 * FB aperture and AGP aperture. Disable them.
-		 */
+	for_each_inst(i, xcc_mask) {
 		if (adev->gmc.pdb0_bo) {
+			/* Disable agp and system aperture
+			 * when vmid0 page table is enabled */
 			WREG32_SOC15(GC, GET_INST(GC, i),
 				     regGCMC_VM_FB_LOCATION_TOP_LO32, 0);
 			WREG32_SOC15(GC, GET_INST(GC, i),
@@ -225,7 +169,8 @@ static void gfxhub_v12_1_xcc_init_system_aperture_regs(struct amdgpu_device *ade
 			WREG32_SOC15(GC, GET_INST(GC, i),
 				     regGCMC_VM_AGP_TOP_HI32, 0);
 			WREG32_SOC15(GC, GET_INST(GC, i),
-				     regGCMC_VM_AGP_BOT_LO32, 0xFFFFFFFF);
+				     regGCMC_VM_AGP_BOT_LO32,
+				     0xFFFFFFFF);
 			WREG32_SOC15(GC, GET_INST(GC, i),
 				     regGCMC_VM_AGP_BOT_HI32, 1);
 			WREG32_SOC15(GC, GET_INST(GC, i),
@@ -238,7 +183,69 @@ static void gfxhub_v12_1_xcc_init_system_aperture_regs(struct amdgpu_device *ade
 				     regGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR_LO32, 0);
 			WREG32_SOC15(GC, GET_INST(GC, i),
 				     regGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR_HI32, 0);
+		} else {
+			/* Program the AGP BAR */
+			WREG32_SOC15_RLC(GC, GET_INST(GC, i),
+					 regGCMC_VM_AGP_BASE_LO32, 0);
+			WREG32_SOC15_RLC(GC, GET_INST(GC, i),
+					 regGCMC_VM_AGP_BASE_HI32, 0);
+			WREG32_SOC15_RLC(GC, GET_INST(GC, i),
+					 regGCMC_VM_AGP_BOT_LO32,
+					 lower_32_bits(adev->gmc.agp_start >> 24));
+			WREG32_SOC15_RLC(GC, GET_INST(GC, i),
+					 regGCMC_VM_AGP_BOT_HI32,
+					 upper_32_bits(adev->gmc.agp_start >> 24));
+			WREG32_SOC15_RLC(GC, GET_INST(GC, i),
+					 regGCMC_VM_AGP_TOP_LO32,
+					 lower_32_bits(adev->gmc.agp_end >> 24));
+			WREG32_SOC15_RLC(GC, GET_INST(GC, i),
+					 regGCMC_VM_AGP_TOP_HI32,
+					 upper_32_bits(adev->gmc.agp_end >> 24));
+
+			/* Program the system aperture low logical page number. */
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR_LO32,
+				     lower_32_bits(min(adev->gmc.fb_start,
+						   adev->gmc.agp_start) >> 18));
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR_HI32,
+				     upper_32_bits(min(adev->gmc.fb_start,
+						   adev->gmc.agp_start) >> 18));
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR_LO32,
+				     lower_32_bits(max(adev->gmc.fb_end,
+						   adev->gmc.agp_end) >> 18));
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR_HI32,
+				     upper_32_bits(max(adev->gmc.fb_end,
+						   adev->gmc.agp_end) >> 18));
 		}
+
+		/* Set default page address. */
+		value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
+		WREG32_SOC15(GC, GET_INST(GC, i),
+			     regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
+			     (u32)(value >> 12));
+		WREG32_SOC15(GC, GET_INST(GC, i),
+			     regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
+			     (u32)(value >> 44));
+
+		/* Program "protection fault". */
+		WREG32_SOC15(GC, GET_INST(GC, i),
+			     regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
+			     (u32)(adev->dummy_page_addr >> 12));
+		WREG32_SOC15(GC, GET_INST(GC, i),
+			     regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
+			     (u32)((u64)adev->dummy_page_addr >> 44));
+
+		tmp = RREG32_SOC15(GC, GET_INST(GC, i),
+				   regGCVM_L2_PROTECTION_FAULT_CNTL2);
+		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
+				    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
+				    ENABLE_RETRY_FAULT_INTERRUPT, 0x1);
+		WREG32_SOC15(GC, GET_INST(GC, i),
+			     regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 	}
 }
 
-- 
2.53.0

