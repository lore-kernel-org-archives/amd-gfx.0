Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DE4C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 26 May 2022 17:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 698F810E21A;
	Thu, 26 May 2022 17:58:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA60910E1DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 May 2022 17:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEOtUwHbrjBdsgVe6d9IGpwO9UYmnlb6YL/mF/gcqxterTapLMi5jR8wsaRFaijbrQ9cuOFyPlAFRArdAYYC7NK40gLVz5ZuqPxF1aXznCkSm/7YXSO3+63Nv95A13oJV9HzUTRrqKn+I9xBPG62lFCzZ5r6WGM0ZWt3jG2K31G5/+54GNg7i1iMosgaZrc3MYXVOwtGp2hhZgtyY85n31sSzdDOJP4R13BD9xBw3tbvc0lrtjTn9wCXfD6zNzo6iPa6fmUSC6MrJzjoEsEPDem7TJUuysvohhVbtf+ukZJH3eW18eq1uXaSdU8+C2LjxbLwdLCpHxiDrjhutPXv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbrdDgBnkqyI5hbbZrAHJgauEIhJBdLp7PrJf3IT53k=;
 b=Otce1CKJXGeo2tnTm2oyMIpS06Q0M8iSq0r3802xwYnxufTUBqyYmbi5aQ+W47rrUBuoW+D2DLH39zBYIP2f8Su7zMUPTRtsCfoFckM/3D5+/Mno0UNGBiWJ1rYk6oizs2h8+BJ6RD7JOvdU4OXdu4g0VQkkS682jLR5UDZlhyojYj1tIOHnj/TDazuLPxXQiOgBNYSnB27zg/Oki3DTKsFx6lQG/MDDy+oEb1DFCFlbe2weu3tIrnXnoT6IPgyT5lfdjhtKn3TpNQoP5q56lLRZ1F9CfZr6UjNhwKEXfwmKOVaQBK0+Nn3JjYjdOwBLnOb+jq0UAC70OnCf5vuZDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbrdDgBnkqyI5hbbZrAHJgauEIhJBdLp7PrJf3IT53k=;
 b=xfQ8xfpvbQqqoGG2mTXzqHqUCKo3KiJ/0kMMJ0kry5HIkHBs2omWADz354r7hRF1AW5VPsGDOufphrcDhIrPhqJHRNfrFI5x1uz6zWtJsXoXFOrcaT1QrNEjM3qDXLWzUXSMGsGY4LiHkER/0EaGXIft79JBRN9GPgqGGRwHEp4=
Received: from BN9PR03CA0628.namprd03.prod.outlook.com (2603:10b6:408:106::33)
 by CY4PR12MB1720.namprd12.prod.outlook.com (2603:10b6:903:121::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Thu, 26 May
 2022 17:58:51 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::35) by BN9PR03CA0628.outlook.office365.com
 (2603:10b6:408:106::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 26 May 2022 17:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 17:58:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 26 May
 2022 12:58:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/gmc11: enable AGP aperture
Date: Thu, 26 May 2022 13:58:35 -0400
Message-ID: <20220526175835.3044451-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220526175835.3044451-1-alexander.deucher@amd.com>
References: <20220526175835.3044451-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72e84a6d-2e0d-4022-c90e-08da3f416406
X-MS-TrafficTypeDiagnostic: CY4PR12MB1720:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1720483B52A424AF17AB9C1FF7D99@CY4PR12MB1720.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t754yP5+pxFDqHGZiMkr9XzxnWMHCE0B0fpWiTbY3vzFS5CJiPFDP0+Z/G8cPOZ3RL1SCb9fdIZBH52iZlrrk86X6ironLjJMVg2Kfj7ysyi/TIQHnsTLfZ9igWLRWP+oJvvoMqaNVD6HqwfWQ84hqnRwwjjnmzXKh3n6PshFGxYbVy4GwMnx3bGWZmkJuCfMS7p6EfZ78HatLzwRNV4uS5qyp3UFfPYcUsdIGO6jQ7dS3OPFfOQ3SVIHLkLRaBhNm0uQhyTqBL5W/POnmIuAbk5fi7E/WpEIR4jYJszgXZG8orsYzrF0GfbYKzJ8EorVgMvptNyo3+M9nA4YwwS7qsb64s1OcLXUWnHqRGI1vA061qP9Ocqi2RTjRQC8tnkFiEUNugWlzcavPCCcjOARxyTtxO90tuzL48gZsapIHgfywQv0FMuKKOdUDrCFyfNOaErECY7VPQWWipuFia12CGtaqfNhvP44vCRFs1z/vld3+0kg6D210ZuotFba/PSztV7S1pLg4NGg2CVj9fuQOdSulrpdA6HbQfGlenrv9+h0FpeAuaC9jlYcYxirpOkcnQID1qHgGnpbNbLIRcDGHUHsP9AUFv/Qd5I13pjdMazJlJVdENNEFxInu1YXMcPyfAULSqrmvuLc9cN/XnQXh9JQkv5QCswdbcapFcDdEeeysmvfbsuvFoA7285Pd6NpkOp4dhid01l9jy2O1+WMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(336012)(426003)(47076005)(8936002)(4326008)(70586007)(86362001)(8676002)(70206006)(316002)(83380400001)(7696005)(186003)(6666004)(40460700003)(508600001)(26005)(82310400005)(81166007)(356005)(6916009)(16526019)(1076003)(2616005)(36756003)(2906002)(5660300002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 17:58:50.9311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e84a6d-2e0d-4022-c90e-08da3f416406
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1720
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

Enable the AGP aperture on chips with GMC v11.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c  | 7 ++++---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c   | 6 +++---
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c | 6 +++---
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index 5eccaa2c7ca0..f99d7641bb21 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -154,10 +154,11 @@ static void gfxhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t value;
 
-	/* Disable AGP. */
+	/* Program the AGP BAR */
 	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
-	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_TOP, 0);
-	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BOT, 0x00FFFFFF);
+	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+
 
 	/* Program the system aperture low logical page number. */
 	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index b6daa4146dd3..635103c7e2a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -654,6 +654,7 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
 	amdgpu_gmc_gart_location(adev, mc);
+	amdgpu_gmc_agp_location(adev, mc);
 
 	/* base offset of vram pages */
 	adev->vm_manager.vram_base_offset = adev->mmhub.funcs->get_mc_fb_offset(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
index bc11b2de37ae..4926fa82c1c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -169,10 +169,10 @@ static void mmhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	uint64_t value;
 	uint32_t tmp;
 
-	/* Disable AGP. */
+	/* Program the AGP BAR */
 	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
-	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, 0);
-	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, 0x00FFFFFF);
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
 
 	if (!amdgpu_sriov_vf(adev)) {
 		/*
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
index 770be0a8f7ce..5e5b884d8357 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
@@ -162,10 +162,10 @@ static void mmhub_v3_0_2_init_system_aperture_regs(struct amdgpu_device *adev)
 	uint64_t value;
 	uint32_t tmp;
 
-	/* Disable AGP. */
+	/* Program the AGP BAR */
 	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
-	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, 0);
-	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, 0x00FFFFFF);
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
 
 	if (!amdgpu_sriov_vf(adev)) {
 		/*
-- 
2.35.3

