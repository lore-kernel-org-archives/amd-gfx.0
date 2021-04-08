Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E472CC433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 05:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22D061130
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 05:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22D061130
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 678286EA04;
	Thu,  8 Apr 2021 05:33:23 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690082.outbound.protection.outlook.com [40.107.69.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65C7D6EA03
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 05:33:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gna1osesD1juYOEDXIasMBf4nUumwwN0gZ/85gojR3SSK9GBOJ3NQaejQ406QkHPozc4uvY4sQA3H7rQ9RuSlEawpF8texZAcL08sDAS8qf876FguxqHIBGm+zKwNAbyN6/o/km+EquggPxan9kfDBwPyhR2yc4KWD1NhlZqFBJK9pwZ9jTY7Nmit+zTIJqEA0HLx5koO3/FCwca10wLmaZPdBJb9zCMDMae0c+MKqF9+sUIbdpW10sXr+C1WwYp7ij7OM0oGm2e8AYja3eeg9dizT18VdFbONnzaRKncdD6G3fToZi69CLUnfQQsiz+Lzc9vWRZgmcsTbh39insrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QPJZZSjF2T3Q0i5JAhhdoBHnCk6eN7xmTXhD0l9FE4=;
 b=PGi3UIt6cF9AmLj3hMEN0tw04OOoU/aWFU/RCO8t9ggFasSyGjx0W+qSphy4njucePgn5ZLyF/YSbABag8ksHvG7hu776ZBUpKnGjw5lIulxEQHNO5bW8BB10IM410g2LB+DgQRWP5+sjzURUOjp4yzBl2e3Kjxy9ysh+YXEOAiqd6mSiA1TEri6U+Y8GNLs/pxTBHCjX4Bxaz5kQuDbCwu6j6T0c1+7dr/BkPW63IpD+5t/gVthBpaySXM8RTs62wbkLHRnKvkkbOipwokKCT/Zcp7qAeXzCIyLjVLZaukFjI6eRJiX7XEjnjWHm/JVpIN1rEbIgATBhvOrqBucgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QPJZZSjF2T3Q0i5JAhhdoBHnCk6eN7xmTXhD0l9FE4=;
 b=DRZ4agoOAnnqoC2PNb2LgLimXDN95Y7CjnmW1WE6naC+AmBBwlV1xwx0oboRhbxRfiv17QCUzFebxCi2jKDFw61zaikBc69RjQSnxU24RHFAdzQoxU0/ckNLekf6Co6+veVg2X4Wz+IOJGpir2UuSl44nrb2TJtuW+swAYSEq3I=
Received: from BN0PR04CA0184.namprd04.prod.outlook.com (2603:10b6:408:e9::9)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Thu, 8 Apr
 2021 05:33:20 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::17) by BN0PR04CA0184.outlook.office365.com
 (2603:10b6:408:e9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Thu, 8 Apr 2021 05:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 05:33:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 00:33:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 00:33:19 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2 via Frontend
 Transport; Thu, 8 Apr 2021 00:33:18 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/8] drm/amdgpu: Change GC register access from MMIO to RLCG
Date: Thu, 8 Apr 2021 13:32:34 +0800
Message-ID: <20210408053236.30762-6-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210408053236.30762-1-PengJu.Zhou@amd.com>
References: <20210408053236.30762-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 959c8ce3-105a-467a-87c4-08d8fa4fd1bd
X-MS-TrafficTypeDiagnostic: BY5PR12MB4211:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4211EC5CC6EBD9B1CA4F3813F8749@BY5PR12MB4211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: er/Gxbkvl0iAdhLzub5fHhhhgdh9KIfFMP+1hP2WJd71KLuJ3LeM1BIWw1ZrT+ZtNJQVtqoEqgLIS4fyrRz8RuF8oMAixk6Owm5u1UghXiVRJuHKffAjiKmWudLXcKa+qD3PboNh4an/VDqk275/QNBuf64/Ze6Mj5wLX0+i3ZZqDp5WPRFWhzTAn9J45uFAdYj7xGkmsEOXHFhuEERvZiCAU2roKSv5dY/E0fAe1BrUulJf0xi3nxtedYVWw+j5/v6bcN13hcZYgAa479Io+umif2Y9KddlOwBQ069iFPSdPeeVuBJM2sawTc2zA9S+hvlljLkJtJyC8QXskwb+l3GWnwi6s+UTKKoKVEM05wMcNY8SfG0FR5Jqjq9MurxRqFp7UjRuyugx5ZG3kn6NzdBMMP8BHbOcWTBrDY2GywBDnsVQSTZdkWnnukAwc33OTAWwNPU24UbOAqV+wq7lWUxGOQ+zM+u5Invc45SDHnrloFYsfWqNt+AKQF3eThaP3XiNYl7V1VUs1NOLUmJcZ+WyjZjuoe+6TQY8XTwVApax1dmT+ASZWPEGw1JLzdBCecj/lnkkKGqwLVPou5bWlLzs0/Qj45MA9lNmQX7NaCFYtJbm4sqsCXkA9r0+Tp85ArTvk5zNHXC93OG6L6xtfEvKZUkdUzVZBxsCPeIJ1Ffx1aTGGbQ5E1kloB939qgw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(46966006)(36840700001)(70586007)(82310400003)(70206006)(82740400003)(81166007)(336012)(47076005)(86362001)(8936002)(54906003)(6916009)(4326008)(36756003)(8676002)(478600001)(2906002)(6666004)(7696005)(26005)(5660300002)(83380400001)(1076003)(36860700001)(2616005)(356005)(316002)(426003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 05:33:20.0595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 959c8ce3-105a-467a-87c4-08d8fa4fd1bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211
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
Cc: jane.jian@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SRIOV environment, KMD should access GC registers
with RLCG if GC indirect access flag enabled.

Change GC register access from MMIO to RLCG.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 36 ++++++++++++------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index a96be9acb9b4..f71644f25df6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -174,12 +174,12 @@ static void gfxhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	}
 
 	/* Program "protection fault". */
-	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
 		     (u32)(adev->dummy_page_addr >> 12));
-	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
 		     (u32)((u64)adev->dummy_page_addr >> 44));
 
-	WREG32_FIELD15(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
+	WREG32_FIELD15_RLC(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
 		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
 }
 
@@ -213,7 +213,7 @@ static void gfxhub_v2_0_init_cache_regs(struct amdgpu_device *adev)
 		return;
 
 	/* Setup L2 cache */
-	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_CNTL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CNTL);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL, ENABLE_L2_CACHE, 1);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL, ENABLE_L2_FRAGMENT_PROCESSING, 0);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL,
@@ -224,12 +224,12 @@ static void gfxhub_v2_0_init_cache_regs(struct amdgpu_device *adev)
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL, PDE_FAULT_CLASSIFICATION, 0);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL, CONTEXT1_IDENTITY_ACCESS_MODE, 1);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL, IDENTITY_MODE_FRAGMENT_SIZE, 0);
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL, tmp);
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CNTL, tmp);
 
-	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_CNTL2);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CNTL2);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL2, INVALIDATE_ALL_L1_TLBS, 1);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL2, INVALIDATE_L2_CACHE, 1);
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL2, tmp);
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CNTL2, tmp);
 
 	tmp = mmGCVM_L2_CNTL3_DEFAULT;
 	if (adev->gmc.translate_further) {
@@ -241,16 +241,16 @@ static void gfxhub_v2_0_init_cache_regs(struct amdgpu_device *adev)
 		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL3,
 				    L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
 	}
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL3, tmp);
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CNTL3, tmp);
 
 	tmp = mmGCVM_L2_CNTL4_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL4, VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL4, tmp);
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CNTL4, tmp);
 
 	tmp = mmGCVM_L2_CNTL5_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL5, L2_CACHE_SMALLK_FRAGMENT_SIZE, 0);
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL5, tmp);
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CNTL5, tmp);
 }
 
 static void gfxhub_v2_0_enable_system_domain(struct amdgpu_device *adev)
@@ -267,18 +267,18 @@ static void gfxhub_v2_0_enable_system_domain(struct amdgpu_device *adev)
 
 static void gfxhub_v2_0_disable_identity_aperture(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32,
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32,
 		     0xFFFFFFFF);
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_HI32,
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_HI32,
 		     0x0000000F);
 
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_LO32,
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_LO32,
 		     0);
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_HI32,
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_HI32,
 		     0);
 
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_LO32, 0);
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_HI32, 0);
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_LO32, 0);
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_HI32, 0);
 
 }
 
@@ -393,7 +393,7 @@ static void gfxhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev,
 					  bool value)
 {
 	u32 tmp;
-	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
 			    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
@@ -423,7 +423,7 @@ static void gfxhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev,
 		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
 				CRASH_ON_RETRY_FAULT, 1);
 	}
-	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
 }
 
 static const struct amdgpu_vmhub_funcs gfxhub_v2_0_vmhub_funcs = {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
